import fs from "node:fs";
import path from "node:path";
import url from "node:url";

import prom from "@isaacs/express-prometheus-middleware";
import { createRequestHandler } from "@remix-run/express";
import { broadcastDevReady, installGlobals } from "@remix-run/node";
import type { ServerBuild } from "@remix-run/node";
import compression from "compression";
import express from "express";
import type { RequestHandler } from "express";
import { expressCspHeader, NONE, SELF, NONCE } from "express-csp-header";
import helmet from "helmet";
import morgan from "morgan";
import sourceMapSupport from "source-map-support";

sourceMapSupport.install();
installGlobals();
run();

async function run() {
  const BUILD_PATH = path.resolve("build/index.js");
  const VERSION_PATH = path.resolve("build/version.txt");
  const initialBuild = await reimportServer();

  const app = express();
  const metricsApp = express();
  app.use(
    prom({
      metricsPath: "/metrics",
      collectDefaultMetrics: true,
      metricsApp,
    }),
  );

  app.use((req, res, next) => {
    // /clean-urls/ -> /clean-urls
    if (req.path.endsWith("/") && req.path.length > 1) {
      const query = req.url.slice(req.path.length);
      const safepath = req.path.slice(0, -1).replace(/\/+/g, "/");
      res.redirect(301, safepath + query);
      return;
    }
    next();
  });

  app.use(compression());
  app.use(helmet());
  app.disable("x-powered-by");

  app.use(
    expressCspHeader({
      directives: {
        "default-src": [SELF],
        "script-src": [SELF, NONCE],
        "style-src": [SELF],
        "connect-src": [SELF, "ws:"],
        "img-src": ["data:", "user-images.githubusercontent.com"],
        "worker-src": [NONE],
        "block-all-mixed-content": true,
      },
    }),
  );

  // Remix fingerprints its assets so we can cache forever.
  app.use(
    "/build",
    express.static("public/build", { immutable: true, maxAge: "1y" }),
  );

  // Everything else (like favicon.ico) is cached for an hour. You may want to be
  // more aggressive with this caching.
  app.use(express.static("public", { maxAge: "1h" }));

  app.use(morgan("tiny"));

  app.all("*", async (...args) => {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    function getLoadContext(req: any) {
      return { nonce: req.nonce };
    }

    const handler =
      process.env.NODE_ENV === "development"
        ? await createDevRequestHandler(initialBuild, getLoadContext)
        : createRequestHandler({
          build: initialBuild,
          mode: initialBuild.mode,
          getLoadContext,
        });

    return handler(...args);
  });

  const port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log(`✅ app ready: http://localhost:${port}`);

    if (process.env.NODE_ENV === "development") {
      broadcastDevReady(initialBuild);
    }
  });

  const metricsPort = process.env.METRICS_PORT || 3010;

  metricsApp.listen(metricsPort, () => {
    console.log(`✅ metrics ready: http://localhost:${metricsPort}/metrics`);
  });

  async function reimportServer(): Promise<ServerBuild> {
    // cjs: manually remove the server build from the require cache
    Object.keys(require.cache).forEach((key) => {
      if (key.startsWith(BUILD_PATH)) {
        delete require.cache[key];
      }
    });

    const stat = fs.statSync(BUILD_PATH);

    // convert build path to URL for Windows compatibility with dynamic `import`
    const BUILD_URL = url.pathToFileURL(BUILD_PATH).href;

    // use a timestamp query parameter to bust the import cache
    return import(BUILD_URL + "?t=" + stat.mtimeMs);
  }

  async function createDevRequestHandler(
    initialBuild: ServerBuild,
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    getLoadContext: any,
  ): Promise<RequestHandler> {
    let build = initialBuild;
    async function handleServerUpdate() {
      // 1. re-import the server build
      build = await reimportServer();
      // 2. tell Remix that this app server is now up-to-date and ready
      broadcastDevReady(build);
    }
    const chokidar = await import("chokidar");
    chokidar
      .watch(VERSION_PATH, { ignoreInitial: true })
      .on("add", handleServerUpdate)
      .on("change", handleServerUpdate);

    // wrap request handler to make sure its recreated with the latest build for every request
    return async (req, res, next) => {
      try {
        return createRequestHandler({
          build,
          mode: "development",
          getLoadContext,
        })(req, res, next);
      } catch (error) {
        next(error);
      }
    };
  }
}

import { describe, it, expect } from "vitest";

import { validateEmail, safeRedirect, useMatchesData } from "./utils";

const DEFAULT_REDIRECT = "/";

test("validateEmail returns false for non-emails", () => {
  expect(validateEmail(undefined)).toBe(false);
  expect(validateEmail(null)).toBe(false);
  expect(validateEmail("")).toBe(false);
  expect(validateEmail("not-an-email")).toBe(false);
  expect(validateEmail("n@")).toBe(false);
});

test("validateEmail returns true for emails", () => {
  expect(validateEmail("kody@example.com")).toBe(true);
});

describe("safeRedirect", () => {
  it("returns default redirect if to is null", () => {
    expect(safeRedirect(null)).toBe(DEFAULT_REDIRECT);
  });

  it("returns default redirect if to is undefined", () => {
    expect(safeRedirect(undefined)).toBe(DEFAULT_REDIRECT);
  });

  it('returns default redirect if to does not start with "/"', () => {
    expect(safeRedirect("http://example.com")).toBe(DEFAULT_REDIRECT);
  });

  it('returns default redirect if to starts with "//"', () => {
    expect(safeRedirect("//example.com")).toBe(DEFAULT_REDIRECT);
  });

  it('returns to if it is a valid string starting with "/"', () => {
    expect(safeRedirect("/home")).toBe("/home");
  });
});

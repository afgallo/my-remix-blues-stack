import { describe, it, expect, vi, beforeEach } from "vitest";

import { prisma } from "~/db.server";

import * as model from "./note.server";

vi.mock("~/db.server", () => ({
  prisma: {
    note: {
      findFirst: vi.fn(),
      findMany: vi.fn(),
      create: vi.fn(),
      deleteMany: vi.fn(),
    },
  },
}));

describe("note model", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should retrieve a note for a given id and userId", async () => {
    const mockNote = {
      id: "1",
      title: "Test Note",
      body: "Test Body",
      userId: "user1",
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(prisma.note.findFirst).mockResolvedValue(mockNote);

    const result = await model.getNote({ id: "1", userId: "user1" });

    expect(prisma.note.findFirst).toHaveBeenCalledWith({
      select: { id: true, body: true, title: true },
      where: { id: "1", userId: "user1" },
    });
    expect(result).toEqual(mockNote);
  });

  it("should retrieve a list of note items for a given userId", async () => {
    const mockNotes = [
      { id: "1", title: "Note 1", body: "Test Body", userId: "user1", createdAt: new Date(), updatedAt: new Date() },
      { id: "2", title: "Note 2", body: "Test Body", userId: "user1", createdAt: new Date(), updatedAt: new Date() },
    ];

    vi.mocked(prisma.note.findMany).mockResolvedValue(mockNotes);

    const result = await model.getNoteListItems({ userId: "user1" });

    expect(prisma.note.findMany).toHaveBeenCalledWith({
      where: { userId: "user1" },
      select: { id: true, title: true },
      orderBy: { updatedAt: "desc" },
    });
    expect(result).toEqual(mockNotes);
  });

  it("should create a new note with provided body, title, and userId", async () => {
    const newNote = {
      id: "1",
      title: "New Note",
      body: "This is a new note.",
      userId: "user1",
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(prisma.note.create).mockResolvedValue(newNote);

    const result = await model.createNote({
      title: newNote.title,
      body: newNote.body,
      userId: newNote.userId,
    });

    expect(prisma.note.create).toHaveBeenCalledWith({
      data: {
        title: newNote.title,
        body: newNote.body,
        user: {
          connect: {
            id: newNote.userId,
          },
        },
      },
    });
    expect(result).toEqual(newNote);
  });
});

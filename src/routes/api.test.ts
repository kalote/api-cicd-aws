import request from "supertest";
import mongoose from "mongoose";

import app from "../app";
import { initDB } from "../db/init";
import { closeInstance } from "../redis/utils";

const DB_URL = process.env.DB_URL ?? "mongodb://127.0.0.1:27017/appdb";

describe("API routes", () => {
  beforeAll(async () => await initDB(DB_URL));
  test("'/api/user/create' success", async () => {
    const res = await request(app).post("/api/user/create").send({
      name: "john",
      position: "ceo",
    });
    expect(res.body).toEqual({
      name: "john",
      position: "ceo",
    });
  });

  test("'/api/user/create' missing name", async () => {
    const res = await request(app).post("/api/user/create").send({
      position: "ceo",
    });
    expect(res.statusCode).toEqual(400);
    expect(res.body).toEqual({
      message: "missing 'name' property",
    });
  });

  test("'/api/user/create' missing position", async () => {
    const res = await request(app).post("/api/user/create").send({
      name: "john",
    });
    expect(res.statusCode).toEqual(400);
    expect(res.body).toEqual({
      message: "missing 'position' property",
    });
  });

  afterEach(async () => {
    await mongoose.disconnect();
    await closeInstance();
  });
});

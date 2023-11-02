import request from "supertest";
import mongoose from "mongoose";

import app from "./app";

describe("Helper routes", () => {
  test("'/'", async () => {
    const res = await request(app).get("/");
    expect(res.text).toEqual(
      "<h1>Welcome 🫡.</h1><h4>Here is a list of endpoints:</h4><br />- '/status' to get application status 🩺<br />- '/data' to send data 👨‍💻."
    );
  });
  test("'/status'", async () => {
    const res = await request(app).get("/status");
    expect(res.body).toEqual({ message: "ok" });
  });
});

describe("Main routes", () => {
  test("'/data' success", async () => {
    const res = await request(app).post("/data").send({
      name: "john",
      position: "ceo",
    });
    expect(res.body).toEqual({
      name: "john",
      position: "ceo",
    });
  });

  test("'/data' missing name", async () => {
    const res = await request(app).post("/data").send({
      position: "ceo",
    });
    expect(res.statusCode).toEqual(400);
    expect(res.body).toEqual({
      message: "missing 'name' property",
    });
  });

  test("'/data' missing position", async () => {
    const res = await request(app).post("/data").send({
      name: "john",
    });
    expect(res.statusCode).toEqual(400);
    expect(res.body).toEqual({
      message: "missing 'position' property",
    });
  });

  afterAll(async () => {
    await mongoose.disconnect();
  });
});

import request from "supertest";

import app from "./app";

describe("Main application", () => {
  test("'/status' route", async () => {
    const res = await request(app).get("/status");
    expect(res.body).toEqual({ message: "ok" });
  });

  test("'/data' route", async () => {
    const res = await request(app).post("/data").send({
      name: "john",
      position: "ceo",
    });
    expect(res.body).toEqual({
      name: "john",
      position: "ceo",
    });
  });
});

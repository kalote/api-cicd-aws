import request from "supertest";

import app from "../app";

describe("Base routes", () => {
  test("'/'", async () => {
    const res = await request(app).get("/");
    expect(res.text).toEqual(`
    <h1>Welcome 🫡.</h1>
    <h4>Here is a list of endpoints:</h4><br />
    - '/status' to get application status 🩺<br />
    - '/api/user/create' to create a user 👨‍💻.<br />
    - '/api/users' to get all users 👨‍👨‍👦‍👦.<br />
    - '/api/user/:id' to get a user 👨‍💻.`);
  });
  test("'/status'", async () => {
    const res = await request(app).get("/status");
    expect(res.body).toEqual({ message: "ok" });
  });
});

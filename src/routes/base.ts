import { Router, Request, Response } from "express";

export const baseRoutes = Router();

// home
baseRoutes.get("/", (req: Request, res: Response) => {
  res.send(`
    <h1>Welcome 🫡.</h1>
    <h4>Here is a list of endpoints:</h4><br />
    - '/status' to get application status 🩺<br />
    - '/api/user/create' to create a user 👨‍💻.<br />
    - '/api/users' to get all users 👨‍👨‍👦‍👦.<br />
    - '/api/user/:id' to get a user 👨‍💻.`);
});

// health check
baseRoutes.get("/status", (req: Request, res: Response) => {
  res.json({ message: "ok" });
});

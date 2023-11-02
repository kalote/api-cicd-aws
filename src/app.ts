import express, { Request, Response, Application } from "express";
import bodyParser from "body-parser";
import dotenv from "dotenv";
import mongoose from "mongoose";
import model from "./model";

dotenv.config();

mongoose.connect(process.env.DB_URL as string);

const database = mongoose.connection;

database.on("error", (error) => {
  console.log(error);
});

database.once("connected", () => {
  console.log("Database Connected");
});

const app: Application = express();
const parser = bodyParser.json();

// home
app.get("/", (req: Request, res: Response) => {
  res.send(
    "<h1>Welcome 🫡.</h1><h4>Here is a list of endpoints:</h4><br />- '/status' to get application status 🩺<br />- '/data' to send data 👨‍💻."
  );
});

// health check
app.get("/status", (req: Request, res: Response) => {
  res.json({ message: "ok" });
});

// main app
app.post("/data", parser, async (req: Request, res: Response) => {
  if (!req.body.name)
    return res.status(400).json({ message: "missing 'name' property" });

  if (!req.body.position)
    return res.status(400).json({ message: "missing 'position' property" });

  const { name, position } = req.body;
  const data = new model({
    name,
    position,
  });

  try {
    await data.save();
    return res.status(201).json({ name, position });
  } catch (e: any) {
    res.status(400).json({ message: e?.message });
  }
});

export default app;

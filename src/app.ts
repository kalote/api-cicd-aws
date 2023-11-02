import express, { Request, Response, Application } from "express";
import bodyParser from "body-parser";

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

app.post("/data", parser, (req: Request, res: Response) => {
  if (!req.body.name)
    return res.status(400).json({ message: "missing 'name' property" });

  if (!req.body.position)
    return res.status(400).json({ message: "missing 'position' property" });

  const { name, position } = req.body;
  return res.json({ name, position });
});

export default app;

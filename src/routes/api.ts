import { Router, Request, Response } from "express";
import model from "../db/model";
import bodyParser from "body-parser";
import { cached, getClient } from "../redis/utils";

const parser = bodyParser.json();
const REDIS_URL = process.env.REDIS_URL ?? "redis://localhost:6379/0";
export const ApiRoute = Router();

// Create entry
ApiRoute.post("/user/create", parser, async (req: Request, res: Response) => {
  const client = await getClient(REDIS_URL);

  if (!req.body.name) {
    res.status(400).send({ message: "missing 'name' property" });
    return;
  }

  if (!req.body.position) {
    res.status(400).send({ message: "missing 'position' property" });
    return;
  }

  const { name, position } = req.body;
  const data = new model({
    name,
    position,
  });

  try {
    await client.del("all-users");
    await data.save();

    console.log("new item inserted in DB!", data);
    res.status(201).send({ name, position });
    return;
  } catch (e: any) {
    res.status(500).send({ message: e?.message });
    return;
  }
});

ApiRoute.get("/users", cached, async (req: Request, res: Response) => {
  const client = await getClient(REDIS_URL);

  try {
    const data = await model.find();
    await client.set("all-users", JSON.stringify(data), {
      EX: 180,
      NX: true,
    });

    res.send({
      fromCache: false,
      data,
    });
  } catch (e: any) {
    res.status(500).json({ message: e?.message });
  }
});

ApiRoute.get("/user/:id", cached, async (req: Request, res: Response) => {
  const client = await getClient(REDIS_URL);

  try {
    const data = await model.findById(req.params.id);
    await client.set(req.params.id, JSON.stringify(data), {
      EX: 180,
      NX: true,
    });
    res.send({
      fromCache: false,
      data,
    });
  } catch (e: any) {
    res.status(500).json({ message: e?.message });
  }
});

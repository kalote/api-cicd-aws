import { NextFunction, Request, Response } from "express";
import { get } from "mongoose";
import { createClient } from "redis";

const REDIS_URL = process.env.REDIS_URL ?? "redis://localhost:6379/0";

export const getClient = async (url: string) => {
  const client = await createClient({ url: url })
    .on("error", (err) => console.log("Redis Client Error", err))
    .connect();
  return client;
};

export const cached = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const client = await getClient(REDIS_URL);
  const userId = req.params?.id ? req.params?.id : "";

  let results;
  try {
    const cacheResults = await client.get(userId ? userId : "all-users");
    if (cacheResults) {
      results = JSON.parse(cacheResults);
      res.send({
        fromCache: true,
        data: results,
      });
    } else {
      next();
    }
  } catch (error) {
    console.error(error);
    res.status(500);
  }
};

export const closeInstance = async () => {
  const client = await getClient(REDIS_URL);
  await client.quit();
};

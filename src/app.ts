import express, { Application } from "express";
import dotenv from "dotenv";
import { baseRoutes } from "./routes/base";
import { ApiRoute } from "./routes/api";

dotenv.config();

const app: Application = express();

app.use("/", baseRoutes);
app.use("/api", ApiRoute);

export default app;

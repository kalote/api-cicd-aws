import app from "./app";
import { initDB } from "./db/init";

const PORT = process.env.PORT || 8000;

const DB_URL = process.env.DB_URL ?? "mongodb://127.0.0.1:27017/appdb";

app.listen(PORT, async (): Promise<void> => {
  await initDB(DB_URL);
  console.log(`running on port ${PORT}`);
});

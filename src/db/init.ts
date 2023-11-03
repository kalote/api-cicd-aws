import mongoose from "mongoose";

export const initDB = async (url: string) => {
  try {
    await mongoose.connect(url);
    console.log("Database connected!");
  } catch (error) {
    console.log("An error occured while connecting to the database");
    console.log(error);
  }
};

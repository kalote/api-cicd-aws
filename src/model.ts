import mongoose from "mongoose";

const dataSchema = new mongoose.Schema({
  name: {
    required: true,
    type: String,
  },
  position: {
    required: true,
    type: String,
  },
});

export default mongoose.model("Data", dataSchema);

const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

//resume data
const sampleResumes = [
  {
    name: "John Smith",
    skills: [
      "Kotlin, Java, Android Development",
      "REST APIs, Firebase, MVVM Architecture",
      "Git, GitHub, Agile Development",
    ],
    projects: [
      "VirusCheck - Scan File and URL for potential threat",
      "E-commerce Android App - Complete shopping solution",
      "Weather Forecast - Real-time weather data app",
    ],
    email: "john.smith@email.com",
    phone: "+1 (555) 123-4567",
    experience: "3+ years in Android Development",
  },
  {
    name: "Sarah Johnson",
    skills: [
      "Flutter, Dart, Cross-platform Development",
      "Firebase, SQLite, State Management",
      "UI/UX Design, Material Design",
    ],
    projects: [
      "TaskManager - Productivity app with offline sync",
      "FitnessTracker - Health monitoring application",
      "ChatApp - Real-time messaging platform",
    ],
    email: "sarah.johnson@email.com",
    phone: "+1 (555) 987-6543",
    experience: "2+ years in Mobile Development",
  },
  {
    name: "Mike Davis",
    skills: [
      "React Native, JavaScript, TypeScript",
      "Node.js, Express.js, MongoDB",
      "AWS, Docker, CI/CD",
    ],
    projects: [
      "FoodDelivery - Restaurant ordering platform",
      "SocialMedia - Content sharing application",
      "BookingSystem - Appointment scheduling app",
    ],
    email: "mike.davis@email.com",
    phone: "+1 (555) 456-7890",
    experience: "4+ years in Full-stack Development",
  },
];

// Routes
app.get("/", (req, res) => {
  res.json({
    message: "Resume API Server is running!",
    endpoints: {
      "/resume": "GET - Fetch resume data",
      "/resume?name=yourname": "GET - Fetch resume with custom name",
    },
  });
});

app.get("/resume", (req, res) => {
  try {
    const { name } = req.query;

    // Get random resume from sample data
    const randomIndex = Math.floor(Math.random() * sampleResumes.length);
    let resume = { ...sampleResumes[randomIndex] };

    // If custom name provided, use it
    if (name && name !== "Mike Davis") {
      resume.name = name;
      resume.email = `${name.toLowerCase().replace(/\s+/g, ".")}@email.com`;
    }

    // Add timestamp for debugging
    resume.timestamp = new Date().toISOString();

    console.log(`Resume request for: ${name || "random"}`);
    res.json(resume);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      error: "Internal server error",
      message: error.message,
    });
  }
});


// Start server
app.listen(PORT, () => {
  console.log(`🚀 Resume API Server running on port ${PORT}`);
  console.log(`📍 Local: http://localhost:${PORT}`);
  console.log(`📍 Resume endpoint: http://localhost:${PORT}/resume`);
});

// shutdown
process.on("SIGTERM", () => {
  console.log("shutting");
  process.exit(0);
});

process.on("SIGINT", () => {
  console.log(" shutting down ");
  process.exit(0);
});

const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());

// Test route
app.get('/', (req, res) => {
  res.json({ message: '🚀 Enviora API is running!' });
});

// Test database
app.get('/api/test', async (req, res) => {
  try {
    const db = require('./config/database');
    const [users] = await db.query('SELECT id, name, email FROM users LIMIT 1');
    res.json({ success: true, user: users[0] });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
});
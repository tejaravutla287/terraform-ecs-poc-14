const express = require('express');
const { Client } = require('pg');

const app = express();
const PORT = process.env.PORT || 80;

// Database configurations securely passed from ECS Environment variables
const dbConfig = {
  host: process.env.DB_HOST,
  database: process.env.DB_NAME || 'pocdb',
  user: process.env.DB_USER || 'pocadmin',
  password: process.env.DB_PASSWORD,
  port: 5432,
  connectionTimeoutMillis: 5000
};

app.get('/', async (req, res) => {
  let dbStatus = "❌ Disconnected";
  let dbErrorDetails = null;

  // Attempt a live query to the Aurora Cluster
  if (dbConfig.host && dbConfig.password) {
    const client = new Client(dbConfig);
    try {
      await client.connect();
      const dbRes = await client.query('SELECT NOW();');
      dbStatus = `✅ Connected Successfully (Server Time: ${dbRes.rows[0].now})`;
    } catch (err) {
      dbErrorDetails = err.message;
    } finally {
      await client.end();
    }
  } else {
    dbErrorDetails = "Database environment variables missing.";
  }

  // Cost-effective lightweight visual verification dashboard
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>POC-18 Deployment Verification</title>
      <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #f4f7f6; margin: 0; padding: 40px; color: #333; }
        .card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); max-width: 600px; margin: 0 auto; }
        h1 { color: #1a365d; margin-top: 0; border-bottom: 2px solid #e2e8f0; padding-bottom: 15px; }
        .status { font-size: 1.1em; font-weight: bold; padding: 12px; border-radius: 6px; background: #edf2f7; margin: 20px 0; }
        .error { color: #c53030; background: #fff5f5; border-left: 4px solid #c53030; font-family: monospace; }
        .badge { background: #3182ce; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.8em; }
      </style>
    </head>
    <body>
      <div class="card">
        <h1>POC-18 Architecture Verification</h1>
        <p><strong>Environment Tier:</strong> <span class="badge">${process.env.NODE_ENV || 'Production'}</span></p>
        <p><strong>Engine Type:</strong> AWS ECS Fargate</p>
        <div class="status">Aurora DB Status: ${dbStatus}</div>
        ${dbErrorDetails ? `<div class="status error"><strong>Error log:</strong> ${dbErrorDetails}</div>` : ''}
      </div>
    </body>
    </html>
  `);
});

app.listen(PORT, () => {
  console.log(`Application actively listening on port ${PORT}`);
});

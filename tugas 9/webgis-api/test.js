const pool = require('./db');

async function testDB() {
  try {
    const res = await pool.query('SELECT NOW()');
    console.log('Database connected:', res.rows);
  } catch (err) {
    console.error('Error:', err.message);
  }
}

testDB();

const express = require('express');
const cors = require('cors'); 
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Conexión a PostgreSQL
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT
});

// Ruta de prueba
app.get('/api/test', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json(result.rows);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error en la conexión a la base de datos');
  }
});

// Ruta para obtener usuarios
app.get('/api/usuarios', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM usuarios');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error al obtener usuarios');
  }
});

// Otras rutas
app.use('/api/usuarios', require('./routes/usuarios'));
app.use('/api/productos', require('./routes/productos'));
app.use('/api/rutas', require('./routes/rutas'));
app.use('/api/tareas', require('./routes/tareas'));
app.use('/api/mensajes', require('./routes/mensajes'));

app.listen(port, () => {
  console.log(`Servidor backend corriendo en http://localhost:${port}`);
});

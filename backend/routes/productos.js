const express = require('express');
const router = express.Router();
const pool = require('../db');

// Obtener todos los usuarios
router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM usuarios');
    res.json(result.rows);
  } catch (err) {
    res.status(500).send('Error al obtener usuarios');
  }
});

// Agregar nuevo usuario
router.post('/', async (req, res) => {
  const { nombre, correo } = req.body;
  try {
    const result = await pool.query(
      'INSERT INTO usuarios (nombre, correo) VALUES ($1, $2) RETURNING *',
      [nombre, correo]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).send('Error al agregar usuario');
  }
});

module.exports = router;
//cambiar en base a la bd
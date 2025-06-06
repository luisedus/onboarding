const express = require('express');
const router = express.Router();
const pool = require('../db');

// Registrar nuevo usuario
router.post('/', async (req, res) => {
  const { nombre, correo, contrasena } = req.body;

  // Validación básica
  if (!nombre || !correo || !contrasena) {
    return res.status(400).json({ error: 'Faltan campos requeridos' });
  }

  try {
    const result = await pool.query(
      'INSERT INTO usuarios(nombre, correo, contrasena) VALUES ($1, $2, $3) RETURNING *',
      [nombre, correo, contrasena]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Error al registrar usuario:', err.message);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// Login de usuario
router.post('/login', async (req, res) => {
  const { correo, contrasena } = req.body;

  if (!correo || !contrasena) {
    return res.status(400).json({ message: 'Faltan datos' });
  }

  try {
    const result = await pool.query(
      'SELECT * FROM usuarios WHERE correo = $1 AND contrasena = $2',
      [correo, contrasena]
    );

    if (result.rows.length > 0) {
      res.status(200).json({ message: 'Login exitoso' });
    } else {
      res.status(401).json({ message: 'Credenciales inválidas' });
    }
  } catch (err) {
    console.error('Error en login:', err.message);
    res.status(500).json({ message: 'Error en login' });
  }
});

module.exports = router;

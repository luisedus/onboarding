const express = require('express');
const router = express.Router();
const pool = require('../db');

// registrar nuevo usuario
router.post('/register', async (req, res) => {
  const { username, email, pasword } = req.body;

  // validación básica
  if (!username || !email || !pasword) {
    return res.status(400).json({ error: 'Faltan campos requeridos' });
  }

  try {
    const result = await pool.query(
      'INSERT INTO lgk_user(username, email, pasword) VALUES ($1, $2, $3) RETURNING *',
      [username, email, pasword]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Error al registrar usuario:', err.message);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// login de usuario
router.post('/login', async (req, res) => {
  const { email, pasword } = req.body;

  if (!email || !pasword) {
    return res.status(400).json({ message: 'Faltan datos' });
  }

  try {
    const result = await pool.query(
'SELECT * FROM lgk_user WHERE email = $1 AND pasword = $2'
      [email, pasword]
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

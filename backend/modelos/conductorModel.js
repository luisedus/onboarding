const db = require('../db/coneccion');

const getConductores = async () => {
  const result = await db.query('SELECT * FROM conductores');
  return result.rows;
};

const getConductorById = async (id) => {
  const result = await db.query('SELECT * FROM conductores WHERE id = $1', [id]);
  return result.rows[0];
};

module.exports = {
  getConductores,
  getConductorById,
};

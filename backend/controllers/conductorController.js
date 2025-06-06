const model = require('../models/conductorModel');

const getConductores = async (req, res) => {
  try {
    const conductores = await model.getConductores();
    res.json(conductores);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getConductorById = async (req, res) => {
  try {
    const id = req.params.id;
    const conductor = await model.getConductorById(id);
    res.json(conductor);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  getConductores,
  getConductorById,
};

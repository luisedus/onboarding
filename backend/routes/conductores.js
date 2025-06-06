const express = require('express');
const router = express.Router();
const controller = require('../controllers/conductoresController');

router.get('/', controller.getConductores);
router.get('/:id', controller.getConductorById);

module.exports = router;

var express = require('express');
var router = express.Router();
let jwt = require('jsonwebtoken');
const cors = require('cors');

const corsOptions = {
  origin: '*',
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  optionsSuccessStatus: 204,
};

router.use(cors(corsOptions));

const lugarC = require('../app/controllers/LugarControl');
let lugarControl = new lugarC();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send({"data":"hola"});
});

//api de lugar
router.get('/lugares', lugarControl.listar);
router.get('/lugares/:tipo', lugarControl.obtener);
router.post('/lugares/guardar', lugarControl.guardar);

module.exports = router;

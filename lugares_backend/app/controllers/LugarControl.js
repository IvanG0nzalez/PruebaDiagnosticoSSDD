"use strict";

var models = require('../models');
var lugar = models.lugar;

class LugarControl {
    async listar(req, res) {
        var lista = await lugar.findAll({
            attributes: ['nombre', 'external_id']
        });
        return res.status(200).json({ msg: "OK", code: 200, datos: lista });
    }

    async guardar(req, res) {
        if (req.body.hasOwnProperty('tipo') &&
            req.body.hasOwnProperty('nombre') &&
            req.body.hasOwnProperty('longitud') &&
            req.body.hasOwnProperty('latitud')) {
            var uuid = require('uuid');
            var data = {
                tipo: req.body.tipo,
                nombre: req.body.nombre,
                longitud: req.body.longitud,
                latitud: req.body.latitud,
                external_id: uuid.v4()
            }
            var result = await lugar.create(data);
            if (result === null) {
                return res.status(401).json({ msg: "Error", tag: "No se creó", code: 401 });
            } else {
                return res.status(200).json({ msg: "OK", code: 200 });
            }
        } else {
            return res.status(400).json({ msg: "Error", tag: "Faltan datos", code: 400 });
        }
    }

    async obtener(req, res) {
        const tipo = req.params.tipo;
        var lista = await lugar.findAll({
            attributes: ['nombre', 'latitud', 'longitud', 'external_id'],
            where: {
                tipo: tipo
            }
        });
        if (lista.length === 0) {
            return res.status(404).json({ msg: "Error", tag: "No se encontró", code: 404 });
        } else {
            return res.status(200).json({ msg: "OK", code: 200, datos: lista });
        }
    }
}
module.exports = LugarControl;
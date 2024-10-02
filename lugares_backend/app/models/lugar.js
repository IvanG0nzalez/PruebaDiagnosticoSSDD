"use strict";

module.exports = (sequelize, DataTypes) => {
    const lugar = sequelize.define('lugar',{
        tipo: {type: DataTypes.STRING, allowNull:false},
        nombre: {type: DataTypes.STRING, allowNull:false},
        longitud: {type: DataTypes.DECIMAL(16, 14), allowNull:false, defaultValue: 0},
        latitud: {type: DataTypes.DECIMAL(16, 14), allowNull:false, defaultValue: 0},
        external_id:{type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4}
    }, {freezeTableName: true});
    return lugar;
};
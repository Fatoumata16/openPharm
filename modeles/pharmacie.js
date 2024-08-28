


const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');

const pharmacie = sequelize.define('pharmacie', {
    id_pharmacie: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    nom: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    numero: {
      type: DataTypes.INTEGER,
      allowNull: false,
      unique: true,

    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
     
    },
    path: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    latitude: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
    longitude: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
    etat: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique:true,
      validate: {
        isEmail: {
          msg: 'Invalid email format',
        },
      },
    },
  }, {
    tableName: 'pharmacie' ,
    timestamps: false
  });

module.exports = pharmacie;


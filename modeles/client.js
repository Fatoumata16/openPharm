
const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');

const client = sequelize.define('client', {
    id_client: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    nom: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    prenom: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    tel: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
     
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    sexe: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  }, {
    tableName: 'client' ,
    timestamps: false
  });

module.exports = client;
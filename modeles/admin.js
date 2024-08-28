
const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');

const admin = sequelize.define('admin', {
    id_admin: {
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
    }
  }, {
    tableName: 'admin' ,
    timestamps: false
  });

module.exports = admin;

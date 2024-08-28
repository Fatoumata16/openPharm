const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');

const categorie = sequelize.define('categorie', {
    id_Categorie: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    nom: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  }, {
    tableName: 'categorie' ,
    timestamps: false
  });

module.exports = categorie;


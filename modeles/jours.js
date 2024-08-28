
const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');

const jours = sequelize.define('jours', {
    id_jour: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    nom: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  }, {
    tableName: 'jours' ,
    timestamps: false
  });

module.exports = jours;
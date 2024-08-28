
const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');
const pharmacie=require('../modeles/pharmacie');
const assurance=require('../modeles/assurance')
const pharmacie_assurances = sequelize.define('pharmacie_assurances', {
  }, {
    timestamps: false
  });
  pharmacie.belongsToMany(assurance, { through: pharmacie_assurances, foreignKey: 'id_pharmacie'  });
assurance.belongsToMany(pharmacie, { through: pharmacie_assurances , foreignKey: 'id_assurance' });
pharmacie_assurances.sync()

module.exports = pharmacie_assurances;


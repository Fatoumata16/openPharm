
const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');
const pharmacie=require('../modeles/pharmacie');
const jours=require('../modeles/jours')
const gardes = sequelize.define('gardes', {
  }, {
    timestamps: false
  });
  pharmacie.belongsToMany(jours, { through: gardes ,foreignKey: 'id_pharmacie'});
jours.belongsToMany(pharmacie, { through: gardes,foreignKey: 'id_jour' });
gardes.sync()
  .then(() => {
    console.log('Le modèle garde a été synchronisé avec la base de données.');
  })
  .catch((error) => {
    console.error('Erreur lors de la synchronisation du modèle ligne_appro :', error);
  });
module.exports = gardes;


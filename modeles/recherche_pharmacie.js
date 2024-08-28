const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');
const pharmacie=require('../modeles/pharmacie');
const recherche=require('../modeles/recherche_user')
const recherchepharmacies = sequelize.define('recherchepharmacie', {
  id_recherchePharmacie: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  }, {
    tableName: 'recherchepharmacie' ,// Spécifiez le nom de la table ici
    timestamps: false,
    
  });
  recherche.belongsToMany(pharmacie, { through: recherchepharmacies,foreignKey: 'id_rech_user', });
  pharmacie.belongsToMany(recherche, { through: recherchepharmacies ,foreignKey: 'id_pharm',});

module.exports = recherchepharmacies;

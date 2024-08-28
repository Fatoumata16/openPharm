
const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');

const assurance = sequelize.define('assurances', {
    id_assurance: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    libelle: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    adresse: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    tel: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
     
    }
  }, {
    tableName: 'assurances' ,
    timestamps: false
  });
  assurance.sync()
  .then(() => {
    console.log('Le modèle assurance a été synchronisé avec la base de données.');
  })
  .catch((error) => {
    console.error('Erreur lors de la synchronisation du modèle ligne_appro :', error);
  });
module.exports = assurance;
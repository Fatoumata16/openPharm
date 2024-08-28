const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');
const conseil=require('../modeles/conseil');
const categorie=require('../modeles/categorie')
const categorie_conseils = sequelize.define('categorie_conseils', {
  id_categorie_Conseils: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  }, {
    tableName: 'categorie_conseils' ,
    timestamps: false,
    
  });
  conseil.belongsToMany(categorie, { through: categorie_conseils,foreignKey: 'id_conseils', });
  categorie.belongsToMany(conseil, { through: categorie_conseils ,foreignKey: 'id_categori',});

module.exports = categorie_conseils;

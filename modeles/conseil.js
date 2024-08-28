const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');
const admin=require('../modeles/admin')

const conseils = sequelize.define('conseils', {
  id_conseil: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    description: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false,
      unique: true,
    },
    path: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  }, {
    tableName: 'conseils' ,
    timestamps: false
  });
  conseils.belongsTo(admin, {
    foreignKey: {
      name: 'id_administrateur', 
      allowNull: false 
    },
    onDelete: 'CASCADE' 
  });module.exports = conseils;






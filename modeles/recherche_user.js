

const { DataTypes } = require("sequelize");
const sequelize = require('../configuration/sequelizeconfig');
const client=require('../modeles/client')

const rechercheuser = sequelize.define('rechercheuser', {
    id_recherche_user: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    latitude: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
    longitude: {
      type: DataTypes.DOUBLE,
      allowNull: false,
      unique: true,
     
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  }, {
    tableName: 'rechercheuser' ,
    timestamps: false
  });
  rechercheuser.belongsTo(client, {
    foreignKey: {
      name: 'id_user',
      allowNull: false 
    },
    onDelete: 'CASCADE' 
  });module.exports = rechercheuser;









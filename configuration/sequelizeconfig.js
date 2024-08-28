// sequelize.js
const { Sequelize } = require('sequelize');
const dbConfig = require('../configuration/config')

const sequelize = new Sequelize(dbConfig.database, dbConfig.user, dbConfig.password, {
  host: dbConfig.host,
  dialect: 'mysql',
});

module.exports = sequelize;

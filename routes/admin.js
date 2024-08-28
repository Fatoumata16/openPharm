const express = require('express')
const route =express.Router();
const controlleur=require('../controlleur/admin')
route.post("/ajouter",controlleur.ajouterAdmin)
route.post("/connection",controlleur.connection)
module.exports=route;
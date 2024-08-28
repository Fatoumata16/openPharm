const express = require('express')
const route =express.Router();
const auth=require('../authentification/auth')
const controlleur=require('../controlleur/recherche_user')

route.post("/routerechercheUser",auth,controlleur.ajouter)


  
  module.exports=route;
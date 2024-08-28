const express = require('express')
const route =express.Router();
const controlleur=require('../controlleur/disponibilite_pharmacie')
const auth=require('../authentification/auth')

route.post("/ajouter",auth,controlleur.ajout)
route.delete("/supprimer/:nom",auth,controlleur.supprimerParId)
  module.exports=route;
const express = require('express')
const route =express.Router();
const controlleur=require('../controlleur/categorie_conseil')

route.post('/ajouter/:id/:ide',controlleur.ajout)
route.delete("/supprimer/:id",controlleur.supprimerParId)
route.put("/modifier/:id",controlleur.modifier)

  module.exports=route;
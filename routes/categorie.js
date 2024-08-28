const express = require('express')
const controlleur=require('../controlleur/categorie')
const auth=require('../authentification/auth')
const route =express.Router();
route.post("/creer",controlleur.ajout)
route.delete("/supprimer/:id",controlleur.supprimerParId)
route.get("/conseilparcategorie",auth,controlleur.conseilParCategorie)
route.get("/lister",controlleur.lister)
  module.exports=route;
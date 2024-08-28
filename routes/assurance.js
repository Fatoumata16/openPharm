const express = require('express')
const route =express.Router();
const controlleur=require('../controlleur/assurance')
const auth=require('../authentification/auth')
route.post("/ajouter",auth,controlleur.ajout)
route.put("/modifier/:id",auth,controlleur.modifierParId)
route.get("/lister",controlleur.lister)
route.delete("/supprimer/:id",auth,controlleur.supprimerParId)
module.exports=route;
const express = require('express')
const controlleur=require('../controlleur/pharmacie_assurance')
const auth=require('../authentification/auth')
const route =express.Router();
route.post("/ajouter/:id",auth,controlleur.ajout)
route.delete("/supprimer/:id/:ide",auth,controlleur.supprimerParId)
route.get("/listerParPharm",auth,controlleur.listerParPharm)
route.get("/listerPharmAssurance",auth,controlleur.lister)
module.exports=route;
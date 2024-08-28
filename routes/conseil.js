const express = require('express')
const controlleur=require('../controlleur/conseil')
const auth=require('../authentification/auth')
const multerr=require('../multer/multer_config')
const route =express.Router();
route.post("/ajouter",auth,multerr,controlleur.ajouter)
route.post("/modifier/:id",auth,multerr,controlleur.modifierConseil)
route.delete("/supprimer/:id",controlleur.supprimerParId)

  module.exports=route;
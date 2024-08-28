const express=require('express')
const route=express.Router();
const controlleur=require('../controlleur/pharmacie')
const multerr=require('../multer/multer_config');
const auth = require('../authentification/auth');
route.get("/infoPharm",auth,controlleur.trouverPharmParId)
route.post("/ajouterPharm",multerr,controlleur.ajouterPharm)
route.post("/connectionPharm",controlleur.connection)
route.get("/listerdisponibilite",auth,controlleur.listerDisponibilite)
route.get("/listerPharm",auth,controlleur.lister)
route.get("/listerPharmvalider",auth,controlleur.listerValider)
route.get("/listerPharmrejeter",auth,controlleur.listerRejeter)
route.get("/modifieretat/:id",auth,controlleur.modifierEtat)
route.get("/rechercherPharmacie/:rechercher",controlleur.rechercher)
route.get("/toutInfoPharmacie/:id",controlleur.toutInfoPharmacie)
route.get("/rejeterpharmacie/:id",auth,controlleur.modifierEtatRejeter)
route.put("/modifierPharm",auth,multerr,controlleur.modifierParId)
module.exports=route;
//   $2b$10$/WItOASon0lyXoSpZHw1tOn70tXNxFkG1ONIaRs49VtObf7S/1GGC
//  $2b$10$/WItOASon0lyXoSpZHw1tOn70tXNxFkG1ONIaRs49VtObf7S/1GGC
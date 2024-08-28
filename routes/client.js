const express = require('express')
const route =express.Router();
const controlleur=require('../controlleur/client')
const auth=require('../authentification/auth')
route.post("/ajouter",controlleur.ajout)
route.get("/infoClient",auth,controlleur.trouverclientparid)
route.post("/connecter",controlleur.connection)
route.get("/afficherHistoriqueRecherche/:id",controlleur.afficherHistoriqueRecherche)
route.put("/modifier",auth,controlleur.modifierParId)
route.get("/listerClient",controlleur.lister)
module.exports=route;
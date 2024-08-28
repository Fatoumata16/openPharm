const servicePharmAssurance=require('../services/pharmacie_assurance')
exports.ajout= async(req,res,next) =>{
    try {
         await servicePharmAssurance.creer(req.params.id,req.auth.userId)
         res.status(200).json("assurance ajoute a la pharmacie avec succes")
    } catch (error) {
      res.status(500).json(error.message
        )
    }
}
    exports.supprimerParId=async(req,res,next) =>{
        try {
         await servicePharmAssurance.supprimer(req.params.id,req.params.ide)
                 res.status(200).json({ message: 'pharmacie assurance supprimee avec succès' });
        } catch (error) {
         res.json(error.message)
        }
   }
   exports.listerParPharm=async(req,res,next) =>{
    try {
   const resultat=  await servicePharmAssurance.listerParPharm(req.auth.userId)
     res.status(200).json(resultat);
    } catch (error) {
     res.status(500).json({ error: error.message });
    }
 }
 exports.lister=async(req,res,next) =>{
    try {
   const resultat=  await servicePharmAssurance.lister()
     res.status(200).json(resultat);
    } catch (error) {
     res.status(500).json({ error: error.message });
    }
 }
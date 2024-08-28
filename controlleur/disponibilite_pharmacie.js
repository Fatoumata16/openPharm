const disponibiliteService=require('../services/disponibilite_pharmacie')

exports.ajout= async(req,res,next) =>{
     try {
      const resultat=await disponibiliteService.trouverJour(req.body.jour)
        if (resultat=== null) {
            res.status(400).json({ message: 'jour non trouvé' });
          } else {
        const result= await   disponibiliteService.ajouter(req.auth.userId,resultat.id_jour)
                res.json(result);
            
          }
     } catch (error) {
      
        res.status(500).json(error);
          }
}

exports.supprimerParId=async(req,res,next) =>{
     try {
        await  disponibiliteService.supprimerGarde(req.params.nom,req.auth.userId)
              res.status(200).json({ message: 'jour de garde supprimee avec succès' }) 
        
     } catch (error) {
      res.json(error)
     }
}






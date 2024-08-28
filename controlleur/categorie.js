const serviceCategorie=require('../services/categorie')
const client=require('../services/client')
exports.ajout= async(req,res,next) =>{
     try {
      const resultat=await  serviceCategorie.trouver(req.body.nom)
        if (resultat !== null) {
            res.status(400).json({ message: 'La catégorie existe déjà' });
          } else {
        await  serviceCategorie.creer(req.body.nom)
                res.status(200).json({ message: 'Catégorie créée avec succès' });
               
          }
     } catch (error) {
      res.json(error)
     }
}
exports.supprimerParId=async(req,res,next) =>{
     try {
      const resultat=await serviceCategorie.trouverparId(req.params.id)
      if (resultat===null) {
          res.status(400).json({ message: 'Catégorie non trouvée' });
        } else {
        await  serviceCategorie.supprimerparId(req.params.id)
              res.status(200).json({ message: 'Catégorie supprimee avec succès' });
              
        }
     } catch (error) {
      res.json(error.message)
     }
   

}
exports.lister=async(req,res,next) =>{
     try {
    const resultat=  await serviceCategorie.toutCategorie()
    
      res.status(200).json(resultat);
     } catch (error) {
      res.status(500).json({ error: error.message });
     }
  }

exports.conseilParCategorie=async(req,res,next) =>{
       try {
          console.log(req.body.nom)
          const nom = req.body.nom.trim();
                  if(nom==="sante reproductive"){
          const resultat= await  client.trouverClientparId(req.auth.userId)
               if(resultat.sexe==='feminin'){
              const resultats=await  serviceCategorie.trouverConseilparCategorie(req.body.nom)
                  res.status(200).json(resultats)
               
               }
               else{
                res.status(400).json("vous etes pas autorise a voir ce contenu")
               }
            
          }
          else{

              res.json(await  serviceCategorie.trouverConseilparCategorie(req.body.nom))
             
          }
       } catch (error) {
        res.json(error.message)
       }
}




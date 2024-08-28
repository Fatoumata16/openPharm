const categorie = require('../modeles/categorie');
const serviceCategorieConseil=require('../services/categorie_conseil')

exports.ajout= async (req,res,next) =>{
   try {
   await serviceCategorieConseil
      .creer(req.params.id, req.params.ide)
      
        res.status(200).json({ message: 'Catégorie créée avec succès' });
   } catch (error) {
    res.json(error.message)
   }
   
}
 
exports.modifier= async(req,res,next) =>{
      try {
        const id_categorie_Conseils = req.params.id;
        const  id_conseils = req.body.conseil;
        const  id_categori  = req.body.categori;
            
           await serviceCategorieConseil.modifier(id_conseils,id_categori,id_categorie_Conseils)
                res.status(200).send('Données modifiées avec succès');
      } catch (error) {
        res.json(error.message)
      }

   
}
exports.supprimerParId=async(req,res,next) =>{
      try {
        const id_categorie_Conseils = req.params.id;

  await  serviceCategorieConseil.supprimerparid(id_categorie_Conseils)
        res.status(200).send('Données supprimées avec succès');
      } catch (error) {
        res.json(error)
      }
}







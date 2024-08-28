const conseilService = require('../services/conseil');
const fs = require('fs');


exports.ajouter = async(req, res, next) => {
  let imageUrl="";
   try {
    const conseilData= JSON.parse(req.body.conseil);
    if(req.file){     imageUrl=`${req.protocol}://${req.get('host')}/images/${req.file.filename}`
  }
     const id_administrateur=req.auth.userId
  await conseilService.creerConseil(conseilData.description,imageUrl,id_administrateur)
      res.json({ message: 'Conseil ajouté avec succès' });
   } catch (error) {
    const filename = imageUrl.split('/images/')[1];
    fs.unlink(`images/${filename}`, (err) => {
        if (err) {
            console.error('Erreur lors de la suppression de l\'ancienne image :', err);
          }
    })
    res.status(500).json(error)
   }
   
};
exports.modifierConseil = async(req, res, next) => {
  const idConseil = req.params.id; 
  let description = req.body.description; 
  let imageUrl = ""; 

  if (req.file) {
    imageUrl = `${req.protocol}://${req.get('host')}/images/${req.file.filename}`;
    const cons=JSON.parse(req.body.conseil)
    description=cons.desc
  }
    try {
      await conseilService.modifierConseil(idConseil,description,imageUrl)
    res.json("conseil modifier avec succes")
    } catch (error) {
      res.json(error)
    }
  
  
  };
  exports.supprimerParId=async(req,res,next) =>{
    try {
      const id_Conseils = req.params.id;

await  conseilService.supprimerParId(id_Conseils)
      res.status(200).send('Données supprimées avec succès');
    } catch (error) {
      res.json(error)
    }
}
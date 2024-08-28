const assurance=require('../services/assurance')

exports.ajout= async(req,res,next) =>{
    const data=req.body
    try {
         await assurance.creer(data)
         res.status(200).json("assurance creer avec succes")
    } catch (error) {
      res.status(500).json(error)
    }
   
    
}
exports.modifierParId = async(req, res, next) => {
    const id = req.params.id;
    let data = req.body; 
    try {
      await assurance.modifierAssurance(id,data) 
      res.json("assurance modifier avec succes")
      } catch (error) {
        res.json(error)
      }
    };
    exports.supprimerParId=async(req,res,next) =>{
        try {
       await assurance.supprimerParId(req.params.id)
                 res.status(200).json({ message: 'assurance supprimee avec succès' });
        } catch (error) {
         res.json(error.message)
        }
   }
   exports.lister=async(req,res,next) =>{
    try {
   const resultat=  await assurance.lister()
   
     res.status(200).json(resultat);
    } catch (error) {
     res.status(500).json({ error: error.message });
    }
 }
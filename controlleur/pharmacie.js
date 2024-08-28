const jwt=require('jsonwebtoken')
const servicePharmacie=require('../services/pharmacie')
const bcript=require('bcrypt')

exports.ajouterPharm = async(req, res, next) => {
  try {
    let imageUrl="http://localhost:3000/images/openfarm3.jpg1689081448327.jpg"
    const data= JSON.parse(req.body.pharmaci);
    if(req.file){  
         imageUrl=`${req.protocol}://${req.get('host')}/images/${req.file.filename}`
  }
   const hash=await  bcript.hash(data.password,10)
   await servicePharmacie.creer(data,hash,imageUrl)
      res.status(200).json({ message: 'pharmacie créé avec succès' });
  } catch (error) {
    console.log(error)
    res.status(500).json({ error: error.message });
  }
};
exports.connection= async(req,res,next) =>{
  try {
    const data=req.body
 const resultat=await servicePharmacie.connecter(data.tel,data.password)
 res.status(200).json({
  userId: resultat.id_pharmacie,
  token: jwt.sign(
    {
      userId: resultat.id_pharmacie,
    },
    'RAMDOM_TOKEN_SECRET',
    { expiresIn: '24h' }
  ),
});
  }  catch (error) {
      console.log(error)
      res.status(500).json(error.message);
  }
  
}
exports.trouverPharmParId=async(req,res,next) =>{
  try {
   const resultat= await  servicePharmacie.trouverPharmParId(req.auth.userId)
    
    res.status(200).json(resultat);
  } catch (error) {
    res.json(error)
  }

   
  }
exports.modifierEtat=async (req,res,next) =>{
  
    try {
      await  servicePharmacie.validerInscription(req.params.id)
  
      res.status(200).json({ message: 'compte pharmacie validee avec succès' });
    } catch (error) {
      res.status(500).json({ error: error.message });

    }
 
}
exports.modifierEtatRejeter=async (req,res,next) =>{
  
  try {
    await  servicePharmacie.rejeterInscription(req.params.id)

    res.status(200).json({ message: 'compte pharmacie rejeter avec succès' });
  } catch (error) {
    res.status(500).json({ error: error.message });

  }

}
exports.lister=async(req,res,next) =>{
     try {
    const resultat=  await servicePharmacie.lister()
    
      res.status(200).json(resultat);
     } catch (error) {
      res.status(500).json({ error: error.message });
     }
  }
  exports.rechercher=async(req,res,next) =>{
    try {
   const resultat=  await servicePharmacie.rechercher(req.params.rechercher)
   
     res.status(200).json(resultat);
    } catch (error) {
     res.status(500).json({ error: error.message });
    }
 }
 exports.toutInfoPharmacie=async(req,res,next) =>{
  try {
 const resultat=  await servicePharmacie.toutInfoPharmacie(req.params.id)
 
   res.status(200).json(resultat);
  } catch (error) {
   res.status(500).json({ error: error.message });
  }
}
  exports.listerValider=async(req,res,next) =>{
    try {
   const resultat=  await servicePharmacie.listerValider()
   
     res.status(200).json(resultat);
    } catch (error) {
     res.status(500).json({ error: error.message });
    }
 }
 exports.listerRejeter=async(req,res,next) =>{
  try {
 const resultat=  await servicePharmacie.listerRejeter()
 
   res.status(200).json(resultat);
  } catch (error) {
   res.status(500).json({ error: error.message });
  }
}
  exports.listerDisponibilite=async(req,res,next) =>{
      try {
        const resultat=await servicePharmacie.listerDisponibilite(req.auth.userId)
        res.status(200).json(resultat);
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
    }
      exports.modifierParId = async(req, res, next) => {
        const idPharm = req.auth.userId;
        let data = req.body; 
        let imageUrl = ""; 
        try {
        if (req.file) {
          
          imageUrl = `${req.protocol}://${req.get('host')}/images/${req.file.filename}`;
          data=JSON.parse(req.body.pharmacie)
        }
          
          const resultat=  await servicePharmacie. modifierPharmacie(idPharm,data,imageUrl)
          res.json("pharmacie modifier avec succes")
          } catch (error) {
            res.json(error)
          }
        };







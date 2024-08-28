const jwt=require('jsonwebtoken')
const serviceClient=require('../services/client')

exports.ajout= async(req,res,next) =>{
    const data=req.body
    try {
         await serviceClient.creer(data)
         res.status(200).json("compte creer avec succes")
    } catch (error) {
      res.status(500).json(error)
    }
   
    
}
exports.connection = async (req, res, next) => {
  const data = req.body;
  try {
    const resultat = await serviceClient.connecter(data.tel,data.password);
    res.status(200).json({
      userId: resultat.id_client,
      token: jwt.sign(
        {
          userId: resultat.id_client,
        },
        'RAMDOM_TOKEN_SECRET',
        { expiresIn: '24h' }
      ),
    });
  } catch (error) {
    if (error.message === 'utilisateur non trouve') {
      res.status(500).json(error.message);
    } else if (error.message === 'mot de passe incorrect') {
      res.status(401).json(error.message);
    } else {
      res.status(500).json('Erreur serveur');
    }
  }
};
exports.afficherHistoriqueRecherche=async(req,res,next) =>{
  try {
    
    
    res.status(200).json( await  serviceClient.afficherHistoriqueRecherche(req.params.id));
  } catch (error) {
    res.json(error)
  }

   
  },
  exports.trouverclientparid=async(req,res,next) =>{
    try {
   const resultat=   await  serviceClient.trouverClientparId(req.auth.userId)
      
      res.status(200).json(resultat);
    } catch (error) {
      res.json(error)
    }
  
     
    }
    exports.modifierParId = async(req, res, next) => {
      const id = req.auth.userId;
      let data = req.body; 
      try {
          await serviceClient.modifierUser(id,data)
        res.json("user modifier avec succes")
        } catch (error) {
          res.json(error)
        }
      };

      exports.lister=async(req,res,next) =>{
        try {
       const resultat=  await serviceClient.lister()
       
         res.status(200).json(resultat);
        } catch (error) {
         res.status(500).json({ error: error.message });
        }
     }

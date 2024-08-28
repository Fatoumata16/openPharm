const jwt=require('jsonwebtoken')
const serviceAdmin=require('../services/admin')
const bcript=require('bcrypt')
exports.ajouterAdmin = async(req, res, next) => {
 const data=req.body
 try {
  const hash=await bcript.hash(data.password,10)
 await serviceAdmin.creer(data,hash)
    res.status(200).json({ message: 'Administrateur créé avec succès' });
 } catch (error) {
  res.status(500).json({ error: error.message });
 }
};
exports.connection = async (req, res, next) => {
  try {
    const data = req.body;
   

    const resultat = await serviceAdmin.connecter(data.tel, req.body.password);

    res.status(200).json({
      userId: resultat.id_admin,
      token: jwt.sign(
        {
          userId: resultat.id_admin,
        },
        'RAMDOM_TOKEN_SECRET',
        { expiresIn: '24h' }
      ),
    });
  } catch (error) {
      res.status(500).json(error.message);
  }
};

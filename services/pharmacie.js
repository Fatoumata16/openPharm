const pharmacie=require('../modeles/pharmacie')
const bcrypt = require('bcrypt');
const fs = require('fs');
const assurance=require('../modeles/assurance')
const jours = require('../modeles/jours');
const Sequelize = require('sequelize');
const nodemail=require('nodemailer')
pharmacie.sync();
module.exports = {
  async creer(pharmacieee, password, path){
    try {
      await pharmacie.create({nom:pharmacieee.nom,numero:pharmacieee.numero,password,path,latitude:pharmacieee.latitude,longitude:pharmacieee.longitude,etat:"en attente",email:pharmacieee.email})
    } catch (error) {
      throw new Error(error)
    }
  },
  async  connecter(numero,password){
    try {
      const resultat=await pharmacie.findOne({where:{numero:numero}})
      if (resultat === null) {
        throw new Error('utilisateur non trouve');
      } else {
            if(resultat.etat==="valider"){
              const result=      await   bcrypt.compare(password, resultat.password)
              if (!result) {
                throw new Error('mot de passe incorrect');
              } else {
                return resultat;
              }
            }
            throw new Error('vous avez pas accces a ce interface');
      }
    } catch (error) {
      throw error
    }
  }
,
  async trouverPharmParId(id_pharmacie){
    try {
    return  await pharmacie.findByPk(id_pharmacie)
   } catch (error) {
     throw new Error(error);
   }
},
  async lister() {
    try {
    return   await pharmacie.findAll()
    } catch (error) {
      throw new Error(error);

    }
  },
  async listerValider() {
    try {
    return   await pharmacie.findAll({where:{etat:"valider"}})
    } catch (error) {
      throw new Error(error);
    }
  },
  async listerRejeter() {
    try {
    return   await pharmacie.findAll({where:{etat:"rejeter"}})
    } catch (error) {
      throw new Error(error);
    }
  },
  async validerInscription(id_pharmacie){
    try {
      const pharm=await pharmacie.findByPk(id_pharmacie)
      var transporteur=nodemail.createTransport({
        service:'gmail',
        auth:{
          user:'',
          pass:''
        }
      })
      var mailObtion={
        from:'fantisca747@gmail.com',
        to:pharm.email,
        subject:'validation du compte pharmacie',
        text:'Bonjour votre compte pour openPharm a ete accepté vous pouvez vous connecter des a present '
      }
    

   
  await  transporteur.sendMail(mailObtion,function(erreur,info){
      if(erreur){
        throw new Error(erreur);
      }
      else{
      }
    })
    await  pharm.update({etat:"valider"})
    } catch (error) {
      throw new Error(error);

    }
  },
  async rejeterInscription(id_pharmacie){
    try {
   const pharm=await pharmacie.findByPk(id_pharmacie)
    await  pharm.update({etat:"rejeter"})
    } catch (error) {
      throw new Error(error);

    }
  },
  async listerDisponibilite(id){
    try {
      const pharmacies = await pharmacie.findAll({
        attributes: [ "latitude", "longitude", "path", "numero", "nom"],
        where: {
          id_pharmacie: id,
        },
        include: [
          {
            model: jours,
            through: {
              attributes: [], 
            },
            attributes: ["nom"], 
          },
        ],
        raw: true,
      });
      return pharmacies
    } catch (error) {
       throw new Error(error)
    }
  },
async  modifierPharmacie(id_pharmacie, pharmaciee, imageUrl) {
  try {
    const res = await pharmacie.findByPk(id_pharmacie);
    if (res === null) {
      throw new Error('pharmacie non trouvé');
    } else {
      const updatedPharmacie = { nom: pharmaciee.nom }; // Initialiser avec les attributs à mettre à jour

      if (pharmaciee.numero !== undefined) {
        updatedPharmacie.numero = pharmaciee.numero;
      }
      if (pharmaciee.password !== undefined) {
        const pass = await bcrypt.hash(pharmaciee.password, 10);
        updatedPharmacie.password = pass;
      }
      if (pharmaciee.email !== undefined) {
        updatedPharmacie.email = pharmaciee.email;
      }
      if (imageUrl !== "") {
        const filename = res.path.split('/images/')[1];
        fs.unlink(`images/${filename}`, (err) => {
          if (err) {
            console.error('Erreur lors de la suppression de l\'ancienne image :', err);
          }
        });
        updatedPharmacie.path = imageUrl;
      }

      if (pharmaciee.longitude !== undefined) {
        updatedPharmacie.longitude = pharmaciee.longitude;
      }

      if (pharmaciee.latitude !== undefined) {
        updatedPharmacie.latitude = pharmaciee.latitude;
      }

      return await pharmacie.update(updatedPharmacie, { where: { id_pharmacie: id_pharmacie } });
    }
  } catch (error) {
    throw new Error(error);
  }
}
,
async rechercher(rechercherPharmacie) {
  try {
  return   await pharmacie.findAll({
    where: {
      // Utilisez l'opérateur LIKE pour rechercher des noms contenant la chaîne
      nom: {
        [Sequelize.Op.like]: `%${rechercherPharmacie}%`
      }
    }
})
  } catch (error) {
    throw new Error(error);
  }
},
async toutInfoPharmacie(id){
  try {
    const pharmacies = await pharmacie.findOne({
      attributes: [ "latitude", "longitude", "path", "numero", "nom"],
      where: {
        id_pharmacie: id,
      },
      include: [
        {
          model: jours,
          through: {
            attributes: [], 
          },
          attributes: ["nom"], 
        },
        {
          model: assurance,
          through: {
            attributes: [], 
          },
          attributes: ["libelle","adresse","tel"], 
        },
      ],
    });
    return pharmacies
  } catch (error) {
     throw new Error(error)
  }
},
}

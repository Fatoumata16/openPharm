// client.service.js
// const Client = require('../modeles/client'); // Adjust the path as needed
const client=require('../modeles/client')
const bcrypt = require('bcrypt');
const mysql = require('mysql');
const dbConfig = require('../configuration/config');
const connection = mysql.createConnection(dbConfig);
const rechercheuser=require('../modeles/recherche_user')

client.sync();

class ClientService {
    async creer(clien){
    const  {nom,prenom,tel,password,sexe}=clien;
    try {
      let hashe = await bcrypt.hash(password, 10);
      
      await client.create({nom,prenom,tel,password: hashe,sexe})
    } catch (error) {
       throw error
    }
    }
    async  connecter(tel,password){
      try {
        const resultat=await client.findOne({where:{tel:tel}})
        if (resultat === null) {
          throw new Error('utilisateur non trouve');
        } else {
       const result=      await   bcrypt.compare(password, resultat.password)
            if (!result) {
              throw new Error('mot de passe incorrect');
            } else {
              return resultat;
            }
         
        }
      } catch (error) {
        console.log(error)
        throw error
      }
    }

  async trouverClientparId(id) {
    try {
      return await client.findByPk(id);
    } catch (error) {
      throw error;
    }
  }
   async  afficherHistoriqueRecherche(id) {
    try {
      const result = await rechercheuser.findAll({
        attributes: ["id_rechercheUser", "latitude", "longitude"],
          where: {
            id_user: id,          },
          include: [
            {
              model: client,
              attributes: ["nom", "prenom"],
            },
          ],
        });
        return result;
      } catch (erreur) {
        console.log(erreur)
        throw new Error(erreur);
      }
  }

  async  modifierUser(id_client, userr) {
    try {
      const resultat = await client.findByPk(id_client);
      if (resultat === null) {
        throw new Error('utilisateur non trouvé');
      } else {
        const updatedUser = { nom:userr.nom };
  
        if (userr.prenom !== undefined) {
          updatedUser.prenom = userr.prenom;
        }
        if (userr.password !== undefined) {
          const passe = await bcrypt.hash(userr.password, 10);
          updatedUser.password = passe;
        }
        if (userr.tel !== undefined) {
          updatedUser.tel = userr.tel;
        }
  
        if (userr.sexe !== undefined) {
          updatedUser.sexe = userr.sexe;
        }
        return await client.update(updatedUser, { where: { id_client} });
      }
    } catch (error) {
      throw new Error(error);
    }
  }
  async lister() {
    try {
    const tout= await client.findAll()
    if(tout.length===0){
      return 'le tableau est vide'
    }
     return tout
    } catch (error) {
      throw new Error(error);
    }
  }
}



module.exports = new ClientService();










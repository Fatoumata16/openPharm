const recherche = require('../modeles/recherche_user')
recherche.sync()
const recherchepharmacie=require('../modeles/recherche_pharmacie')
recherchepharmacie.sync()
const jours=require('../modeles/jours')
const pharmacie=require('../modeles/pharmacie')
const rechercheUser = require('../modeles/recherche_user')
const assurances = require('../modeles/assurance')
module.exports = {
     async  listePharmacie(jour) {
        try {
            const pharmacies = await pharmacie.findAll({
              attributes: ["id_pharmacie", "latitude", "longitude", "path", "numero", "nom"],
              where: {
                etat: "valider",
              },
              include: [
                {
                  model: assurances,
                  through: {
                    attributes: [], 
                  },
                  attributes: ["id_assurance", "libelle"],
                  // where: {
                  //   nom: jour,
                  // },
                },
                {
                  model: jours,
                  through: {
                    attributes: [], 
                  },
                  where: {
                    nom: jour,
                  },
                },
                
              ],
            });
            
            return pharmacies;
          } catch (erreur) {
            console.log(erreur)
            throw new Error(erreur);
          }
      }
    ,
    async creer(user,data){
      try {
     return await  recherche.create({latitude:data.latitude,longitude:data.longitude,date:new Date(),id_user:user})
      } catch (error) {
         throw new Error(error)
      }
    },
    async ajoutrechPharmacie(id_recherche_user, id_pharmacie){
          try {
         const res= await  rechercheUser.findByPk(id_recherche_user)
          const p=await pharmacie.findByPk(id_pharmacie)
            res.addPharmacie(p)
          } catch (error) {
            throw new Error(error)
          }
    }

}

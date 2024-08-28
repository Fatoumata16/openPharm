const assurance = require('../modeles/assurance');
const pharmacie = require('../modeles/pharmacie');
const pharmacie_assurance=require('../modeles/pharmacie_assurance')
module.exports = {
    async creer(id_assurance, id_pharmacie) {
        try {
          const assuranceInstance = await assurance.findOne({where:{id_assurance}});
          if (!assuranceInstance) {
            throw new Error("Assurance non trouvée");
          } else {
            const pharmacieInstance = await pharmacie.findOne({where:{id_pharmacie,etat:"valider"}});
            if (!pharmacieInstance) {
              throw new Error("Pharmacie non trouvé");
            } else {
              await pharmacieInstance.addAssurance(assuranceInstance);              // await pharmacie_assurance.create({id_pharmacie,id_assurance})
              return "Pharmacie ajouté à l'assurance avec succès";
            }
          }
        } catch (error) {
          throw new Error(error.message);
        }
      },
      async supprimer(id_assurance, id_pharmacie) {
        try {
          const assuranceInstance = await assurance.findByPk(id_assurance);
          if (assuranceInstance === null) {
            throw new Error("assurance Instance non trouvée");
          } else {
            const pharmacieInstance= await pharmacie.findByPk(id_pharmacie);
            if (pharmacieInstance=== null) {
              throw new Error("Pharmacie non trouvé");
            } else {
              await pharmacie_assurance.destroy({where:{id_pharmacie,id_assurance}})
              return "Relation pharmacie_assurance supprimée avec succès";
            }
          }
        } catch (error) {
          throw new Error(error.message);
        }
      },
      async  listerParPharm(id_pharmacie) {
        try {
          const pharmacies = await pharmacie.findOne({
            attributes: ["id_pharmacie","nom","numero","longitude","latitude"],
            include: [
              {
                model: assurance,
                through: {
                  attributes: [], 
                },
                attributes: ["id_assurance","adresse","tel","libelle"], 
              },
            ],
            where:{id_pharmacie:id_pharmacie}
          });
          return pharmacies;
          } catch (erreur) {
            
            throw new Error(erreur);
          }
      } ,
      async  lister() {
        try {
          const pharmacies = await pharmacie.findAll({
            attributes: ["id_pharmacie","nom","numero","longitude","latitude"],
            include: [
              {
                model: assurance,
                through: {
                  attributes: [], 
                },
                attributes: ["id_assurance","adresse","tel"], 
              },
            ],
          });
          return pharmacies;
          } catch (erreur) {
            
            throw new Error(erreur);
          }
      } 
  
  }
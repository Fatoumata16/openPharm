const categori = require('../modeles/categorie')
const mysql = require('mysql');
const dbConfig = require('../configuration/config');
const conseil=require('../modeles/conseil')
module.exports = {
  async creer(nom){
   try {
   return await categori.create({nom})
   } catch (error) {
    throw new Error(error)
   }
  },
  async trouver(nom){
    try {
      return await categori.findOne({where:{nom}})

    } catch (error) {
      throw new Error(error)
    }
  },
 
  async trouverparId(id_Categorie){
    try {
   return await categori.findByPk(id_Categorie)
    } catch (error) {
      throw new Error(error)
    }
  },
  async supprimerparId(id_Categorie){
    try {
     return await  categori.destroy({where:{id_Categorie:id_Categorie}})
    } catch (error) {
      throw new Error(error)
    }
  }
  ,
  async trouverConseilparCategorie(nom){
    try {
      const pharmacies = await categori.findAll({
        attributes: ["nom"],
        where: {
          nom: nom,
        },
        include: [
          {
            model: conseil,
            through: {
              attributes: [], 
            },
            attributes: ["id_conseil", "description", "date", "path"],
          },
        ],
      });
      if(pharmacies.length===0){
        throw new Error("categorie non trouve")
      }
      else{
        return pharmacies
      }
    } catch (error) {
       throw new Error(error)
    }
  },
  async toutCategorie(){
     try {
      return await  categori.findAll()

     } catch (error) {
      throw new Error(error)
     }
  }
}

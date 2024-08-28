const disponibilite_pharmacie = require('../modeles/disponibilite_pharmacie')
// disponibilite_pharmacie.sync()
const jour=require('../modeles/jours')
jour.sync();
const mysql = require('mysql');
const dbConfig = require('../configuration/config');
const jours = require('../modeles/jours');
const { Error } = require('sequelize');
const gardes = require('../modeles/disponibilite_pharmacie');
const pharmacie=require('../modeles/pharmacie')
module.exports = {
  async trouverJour(nom){
    try {
     return await jour.findOne({where:{nom:nom}})
    } catch (error) {
      throw new Error(error)
    }
  },
  async ajouter(id_pharmacie, id_jour){
   try {
  const pharm= await pharmacie.findByPk(id_pharmacie)
  if(pharm===null){ throw new Error("pharmacie pas trouve")}
  else{
  const j=await jour.findByPk(id_jour)
  if(j===null){throw new Error("pharmacie pas trouve")}
  else{
  return await pharm.addJours(j);}}
   } catch (error) {
    throw new Error(error)
   }
  },
  async trouverJourparId(id_jour) {
   try {
    return await jour.findByPk(id_jour)
   } catch (error) {
    throw new Error(error)
   }
  },
  async supprimerGarde(nom,id_pharmacie) {
    try {
    const jours=  await jour.findOne({where:{nom}})
    if (jours===null) {
      return 'jour non trouvé'
    }
    else{
      return  gardes.destroy({where:{id_jour:jours.id_jour,id_pharmacie:id_pharmacie}})
    }
    } catch (error) {
      throw new Error(error)

    }
  }

}

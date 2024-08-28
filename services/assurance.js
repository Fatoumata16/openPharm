const assurance=require('../modeles/assurance')

class assuranceService {
    async creer(assurances){
    const  {libelle,adresse,tel}=assurances;
    try {
   const assuranceInstance=  await assurance.findOne({where:{libelle}})
   if(assuranceInstance){
    throw new Error("ce assurance existe deja")
   }
   else{
      await assurance.create({libelle,adresse,tel})}
    } catch (error) {
       throw new Error(error)
    }
    }
    async  modifierAssurance(id_assurance, assurancer) {
        try {
          const res = await assurance.findByPk(id_assurance);
          if (res === null) {
            throw new Error('assurance non trouvé');
          } else {
            const updatedassurance = { libelle:assurancer.libelle }; // Initialiser avec les attributs à mettre à jour
      
            if (assurancer.adresse !== undefined) {
              updatedassurance.adresse = assurancer.adresse;
            }
            if (assurancer.tel !== undefined) {
              updatedassurance.tel = assurancer.tel;
            }
            return await assurance.update(updatedassurance, { where: { id_assurance} });
          }
        } catch (error) {
          throw new Error(error);
        }
      }
async supprimerParId(id_assurance){
    try {
    const assurances=  await assurance.findByPk(id_assurance)
    if(assurances){
      return await  assurance.destroy({where:{id_assurance}})
    }
    throw new Error("assurance introuvable")
    } catch (error) {
      throw new Error(error)
    }
  }
  async lister() {
    try {
    const tout= await assurance.findAll()
    if(tout.length===0){
      throw new Error ('le tableau est vide')
    }
     return tout
    } catch (error) {
      throw new Error(error);

    }
  }
}
module.exports = new assuranceService();










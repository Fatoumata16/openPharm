const categoriConseil = require('../modeles/categorie_conseil')
categoriConseil.sync()
const categorie=require('../modeles/categorie')
const conseil=require('../modeles/conseil')

module.exports = {
  async creer(id_Categorie,id_conseil){
     try {
      const cat= await categorie.findByPk(id_Categorie)
      if(!cat){
        throw new Error("categorie non trouve")
      }
      else{
        const con= await  conseil.findByPk(id_conseil)
        if(!con){
          throw new Error("conseil non trouve")

        }
       return await cat.addConseil(con)
      }
      
     } catch (error) {
       throw new Error(error)
     }
  },

  async modifier(id_conseils,id_categori,id_categorie_Conseils){
    try {
    return await categoriConseil.update({id_conseils:id_conseils,id_categori:id_categori},{where:{id_categorie_Conseils:id_categorie_Conseils}})
  
    } catch (error) {
      throw new Error(error)
    } 
  }
  ,
  async supprimerparid(id_categorie_Conseils){
    try {
      return await categoriConseil.destroy({where:{id_categorie_Conseils:id_categorie_Conseils}})
    } catch (error) {
      throw new Error(error)
    }
  }
}

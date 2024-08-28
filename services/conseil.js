const conseil=require('../modeles/conseil')
conseil.sync()
const mysql = require('mysql');
const dbConfig = require('../configuration/config');
const connection = mysql.createConnection(dbConfig);
const fs = require('fs');
connection.connect(async (err) => {
  if (err) throw err;
});
module.exports = {
  async creerConseil(conseilData,image,id_administrateur){
    try {
      return await  conseil.create({description:conseilData,date:new Date(),path:image,id_administrateur:id_administrateur})

    } catch (error) {
      throw new Error(error)
    }
  }
,
  async modifierConseil(id_conseil,description,imageUrl){
    try {
      const res=await conseil.findByPk(id_conseil)
      if (res===null) {
       throw new Error('Conseil non trouvé')
     } else {
      if (imageUrl !== "") {
        const filename = res.path.split('/images/')[1];
        fs.unlink(`images/${filename}`, (err) => {
            if (err) {
                console.error('Erreur lors de la suppression de l\'ancienne image :', err);
              }
        })
        return await  conseil.update({description:description,path:imageUrl},{where:{id_conseil:id_conseil}})        
      }
      else{
        return await  conseil.update({description:description},{where:{id_conseil:id_conseil}})        
      }
     }
    } catch (error) {
      throw new Error(error)
    }
},
async supprimerParId(id_conseil){
  try {
   const conseill=await conseil.findByPk(id_conseil)
   if(conseill===null){
    throw new Error("ce conseil n'existe pas")
   }
   const filename = conseill.path.split('/images/')[1];
   fs.unlink(`images/${filename}`, (err) => {
       if (err) {
           console.error('Erreur lors de la suppression de l\'ancienne image :', err);
         }
   })
   return await  conseil.destroy({where:{id_conseil:id_conseil}})
  } catch (error) {
    throw new Error(error)
  }
}
}

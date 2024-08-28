// const bcrypt = require('bcrypt');
const mysql = require('mysql');
const pharmacie=require('../modeles/pharmacie')
const bcrypt = require('bcrypt');
const admin=require('../modeles/admin')
admin.sync()
module.exports = {
  async creer(adminn, password) {
    const { nom, prenom, tel } = adminn;
    try {
      await admin.create({ nom, prenom, tel, password: password });
    } catch (error) {
      throw error;
    }
  },
      async  connecter(tel,password){
        try {
          const resultat = await admin.findOne({ where: { tel } });
          if (resultat === null) {
            throw new Error('utilisateur non trouve');
          } else {
         const result= await   bcrypt.compare(password, resultat.password)
              if (!result) {
                throw new Error('mot de passe incorrect');
              } else {
                return resultat;
              }
          }
        } catch (error) {
          throw new Error(error)
        }

      }
    }
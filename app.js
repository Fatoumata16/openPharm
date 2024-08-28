const express= require('express')
const mysql=require('mysql');
const myconnection=require('express-myconnection');
const routeClient=require('./routes/client')
const routeAdmin=require('./routes/admin')
const routeconseil=require('./routes/conseil')
const routePharmacie=require('./routes/pharmacie')
const multerr=require('./multer/multer_config')
const routedisponibilite=require('./routes/disponibilite_pharmacie')
const routerechercheUser=require('./routes/recherche_user')
const auth=require('./authentification/auth')
const routeCategorie=require('./routes/categorie')
const routeCategorieConseils=require('./routes/categorie_conseil')
const path = require('path');
const cors = require('cors');
const assurance=require('./routes/assurance')
const assurancePharm=require('./routes/pharmacie_assurance')
const assurancedispo=require('./modeles/disponibilite_pharmacie')
const optionbd={
  host:'localhost',
  user:'root',
  password:'',
  port :3306,
  database: 'OpenPharm'
};
const app= express();
app.use(express.json());
// app.use((req, res, next) => {
//   res.setHeader('Access-Control-Allow-Origin', 'http://localhost:53027, https://openpharm-c8ed3.web.app, http://localhost:4200');
//   res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
//   res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
//   next();
// });
app.use(cors({
  origin: [
    'http://localhost:53027',
    'https://openpharm-c8ed3.web.app',
    'http://localhost:4200',
  ],
  optionsSuccessStatus: 200 
}));
app.use('/images', express.static(path.join(__dirname, 'images')));
app.use("/client",routeClient)
app.use("/Pharmacie",routePharmacie)
app.use("/joursgarde",routedisponibilite)
app.use("/rechercheUser",routerechercheUser)
app.use("/admin",routeAdmin)
app.use("/conseil",routeconseil)
app.use("/assurance",assurance)
app.use("/pharmacieAssurance",assurancePharm)
app.use("/categorie",routeCategorie)
app.use("/categorieConseils",routeCategorieConseils)
module.exports =app;






















const http= require('http');
const app= require('./app')
// on dit sur quel port notre appli va tourner
app.set('port',3000)

// creation d'un serveur avec une  fonction qui sera executee a chaque requete
const server= http.createServer(app)

// ((req,res) =>{
//     // on utilise la methode end pour envoyer une reponse de type string 
//     res.end('voila la reponse du serveur')
// })
server.listen(3000);
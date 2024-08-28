const modele=require('../services/rechercheuser')
const  geolib=require('geolib')

exports.ajouter=async (req,res,next)=>{
  try {
    const user = req.auth.userId;
    const rayon = 45000;
    const data = req.body;
    const joursSemaine = ['dimanche', 'Lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'];
    const date = new Date();
    const jourSemaine = joursSemaine[date.getDay()];
    const result = await modele.creer(user, data);
    const pharmacies = await modele.listePharmacie(jourSemaine);
    const pharmaciesInRadius = pharmacies
      .filter((pharmacie) => {
        const distance = geolib.getDistance(
          { latitude: data.latitude, longitude: data.longitude },
          { latitude: pharmacie.latitude, longitude: pharmacie.longitude }
        );
        return distance <= rayon;
      })
      .map((pharmacie) => {
        return {
          id_pharmacie: pharmacie.id_pharmacie,
          nom_pharmacie: pharmacie.nom,
          image: pharmacie.path,
          Contact_pharmacie: pharmacie.numero,
          latitude: pharmacie.latitude,
          longitude: pharmacie.longitude,
          assurance_libelle: pharmacie.id_assurance,
          assurances: pharmacie.assurances.map((assurance) => {
            return {
              id_assurance: assurance.id_assurance,
              libelle: assurance.libelle,
            };
          }),
          distance:
            geolib.getDistance(
              { latitude: data.latitude, longitude: data.longitude },
              { latitude: pharmacie.latitude, longitude: pharmacie.longitude }
            ) / 1000, // Convertir la distance en kilomètres
        };
      });
    for (const pharmacie of pharmaciesInRadius) {
      await modele.ajoutrechPharmacie(result.id_recherche_user, pharmacie.id_pharmacie);
    }
    res.status(200).json({ pharmacies: pharmaciesInRadius });
  } catch (error) {
    res.status(500).json(error);
  }
}

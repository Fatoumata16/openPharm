-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 07 sep. 2023 à 13:13
-- Version du serveur :  10.4.19-MariaDB
-- Version de PHP : 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `openpharm`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `tel` bigint(20) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `assurances`
--

CREATE TABLE `assurances` (
  `id_assurance` int(11) NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `assurances`
--

INSERT INTO `assurances` (`id_assurance`, `libelle`, `adresse`, `tel`) VALUES
(2, 'BDM Pharm’Assur', 'Avenue Modibo Kéita\r\nBP 94 Bamako Mali', '20700400'),
(3, 'NSIA Assurances Mali', 'Immeuble du patronat, Hamdalaye ACI 2000, derrière le Gouvernorat du District de Bamako, Bamako · ~4.2 km\r\n', '20704400'),
(4, 'AGF MALI', 'Avenue de la nation ,Bamako-Mali', '20224161'),
(5, 'ASSUR6', 'Centre ville,Bamako-Mali', '20222378');

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id_Categorie` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `categorie_conseils`
--

CREATE TABLE `categorie_conseils` (
  `id_categorie_Conseils` int(11) NOT NULL,
  `id_conseils` int(11) DEFAULT NULL,
  `id_categori` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id_client` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `tel` bigint(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `sexe` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id_client`, `nom`, `prenom`, `tel`, `password`, `sexe`) VALUES
(45, 'Diamina', 'asssden', 68282337, '$2b$10$KeUUoQDjhvC38gqoiau.2.oa4dRmqYu50NiuW877DCbbZ1o9.cgGe', 'feminin'),
(46, 'fatoumattaa', 'asssden444444444', 682823379, '$2b$10$uiqzkccUTQSXkN6FHXJvYetkRC4HMVH9.izLjrjRSUxQJyjq/hvpC', 'feminin');

-- --------------------------------------------------------

--
-- Structure de la table `conseils`
--

CREATE TABLE `conseils` (
  `id_conseil` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `id_administrateur` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `path` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `gardes`
--

CREATE TABLE `gardes` (
  `id_pharmacie` int(11) NOT NULL,
  `id_jour` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `jours`
--

CREATE TABLE `jours` (
  `id_jour` int(11) NOT NULL,
  `nom` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `jours`
--

INSERT INTO `jours` (`id_jour`, `nom`) VALUES
(12, 'lundi'),
(13, 'mardi'),
(14, 'mercredi'),
(15, 'jeudi'),
(16, 'vendredi'),
(17, 'samedi'),
(18, 'dimanche');

-- --------------------------------------------------------

--
-- Structure de la table `pharmacie`
--

CREATE TABLE `pharmacie` (
  `id_pharmacie` int(11) NOT NULL,
  `nom` varchar(250) NOT NULL,
  `numero` int(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `path` varchar(250) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `etat` varchar(20) DEFAULT NULL,
  `email` varchar(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pharmacie_assurances`
--

CREATE TABLE `pharmacie_assurances` (
  `id_pharmacie` int(11) NOT NULL,
  `id_assurance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `recherchepharmacie`
--

CREATE TABLE `recherchepharmacie` (
  `id_recherchePharmacie` int(11) NOT NULL,
  `id_rech_user` int(11) DEFAULT NULL,
  `id_pharm` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `rechercheuser`
--

CREATE TABLE `rechercheuser` (
  `id_recherche_user` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `tel` (`tel`);

--
-- Index pour la table `assurances`
--
ALTER TABLE `assurances`
  ADD PRIMARY KEY (`id_assurance`),
  ADD UNIQUE KEY `tel` (`tel`);

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id_Categorie`);

--
-- Index pour la table `categorie_conseils`
--
ALTER TABLE `categorie_conseils`
  ADD PRIMARY KEY (`id_categorie_Conseils`),
  ADD KEY `id_conseils` (`id_conseils`),
  ADD KEY `id_categori` (`id_categori`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`),
  ADD UNIQUE KEY `tel` (`tel`);

--
-- Index pour la table `conseils`
--
ALTER TABLE `conseils`
  ADD PRIMARY KEY (`id_conseil`),
  ADD KEY `id_administrateur` (`id_administrateur`);

--
-- Index pour la table `gardes`
--
ALTER TABLE `gardes`
  ADD PRIMARY KEY (`id_pharmacie`,`id_jour`),
  ADD KEY `id_jour` (`id_jour`);

--
-- Index pour la table `jours`
--
ALTER TABLE `jours`
  ADD PRIMARY KEY (`id_jour`);

--
-- Index pour la table `pharmacie`
--
ALTER TABLE `pharmacie`
  ADD PRIMARY KEY (`id_pharmacie`),
  ADD UNIQUE KEY `numero` (`numero`);

--
-- Index pour la table `pharmacie_assurances`
--
ALTER TABLE `pharmacie_assurances`
  ADD PRIMARY KEY (`id_pharmacie`,`id_assurance`),
  ADD KEY `id_assurance` (`id_assurance`);

--
-- Index pour la table `recherchepharmacie`
--
ALTER TABLE `recherchepharmacie`
  ADD PRIMARY KEY (`id_recherchePharmacie`),
  ADD KEY `id_rechUser` (`id_rech_user`),
  ADD KEY `id_pharm` (`id_pharm`);

--
-- Index pour la table `rechercheuser`
--
ALTER TABLE `rechercheuser`
  ADD PRIMARY KEY (`id_recherche_user`),
  ADD KEY `id_user` (`id_user`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `assurances`
--
ALTER TABLE `assurances`
  MODIFY `id_assurance` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id_Categorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `categorie_conseils`
--
ALTER TABLE `categorie_conseils`
  MODIFY `id_categorie_Conseils` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT pour la table `conseils`
--
ALTER TABLE `conseils`
  MODIFY `id_conseil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `jours`
--
ALTER TABLE `jours`
  MODIFY `id_jour` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `pharmacie`
--
ALTER TABLE `pharmacie`
  MODIFY `id_pharmacie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT pour la table `recherchepharmacie`
--
ALTER TABLE `recherchepharmacie`
  MODIFY `id_recherchePharmacie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT pour la table `rechercheuser`
--
ALTER TABLE `rechercheuser`
  MODIFY `id_recherche_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `categorie_conseils`
--
ALTER TABLE `categorie_conseils`
  ADD CONSTRAINT `categorie_conseils_ibfk_1` FOREIGN KEY (`id_conseils`) REFERENCES `conseils` (`id_conseil`),
  ADD CONSTRAINT `categorie_conseils_ibfk_2` FOREIGN KEY (`id_categori`) REFERENCES `categorie` (`id_Categorie`);

--
-- Contraintes pour la table `conseils`
--
ALTER TABLE `conseils`
  ADD CONSTRAINT `conseils_ibfk_1` FOREIGN KEY (`id_administrateur`) REFERENCES `admin` (`id_admin`);

--
-- Contraintes pour la table `gardes`
--
ALTER TABLE `gardes`
  ADD CONSTRAINT `gardes_ibfk_1` FOREIGN KEY (`id_pharmacie`) REFERENCES `pharmacie` (`id_pharmacie`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gardes_ibfk_2` FOREIGN KEY (`id_jour`) REFERENCES `jours` (`id_jour`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `pharmacie_assurances`
--
ALTER TABLE `pharmacie_assurances`
  ADD CONSTRAINT `pharmacie_assurances_ibfk_1` FOREIGN KEY (`id_pharmacie`) REFERENCES `pharmacie` (`id_pharmacie`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pharmacie_assurances_ibfk_2` FOREIGN KEY (`id_assurance`) REFERENCES `assurances` (`id_assurance`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `recherchepharmacie`
--
ALTER TABLE `recherchepharmacie`
  ADD CONSTRAINT `recherchepharmacie_ibfk_1` FOREIGN KEY (`id_rech_user`) REFERENCES `rechercheuser` (`id_recherche_user`),
  ADD CONSTRAINT `recherchepharmacie_ibfk_2` FOREIGN KEY (`id_pharm`) REFERENCES `pharmacie` (`id_pharmacie`);

--
-- Contraintes pour la table `rechercheuser`
--
ALTER TABLE `rechercheuser`
  ADD CONSTRAINT `rechercheuser_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `client` (`id_client`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

import Foundation

class Pioche {
	private var carte : carte //inutile
	private var liste : [Carte]

	// init : -> Pioche
	// cette fonction permet d'initialiser la pioche, la pioche ne doit pas contenir de Roi. La pioche au départ a 20 cartes dont 9 soldats, 6 gardes, 5 archers, par défaut la pioche est crée avec 20 éléments.
	// pre : Ne prend rien en paramètre
	//post : Elle doit renvoyer la pioche, avec toutes les cartes sauf les rois, réparties de manière aléatoire.
	init() {
		var listeCarte : [Carte] //liste intermédiaire aidant à l'initialisation de la pioche
		var i : Int
		for i in 0...8 {
			var soldat : Carte = Carte(nom : "Soldat")
			listeCarte.append(soldat)
		}
		i=0
		for i in 0...5 {
			var garde : Carte = Carte(nom : "Garde")
			listeCarte.append(garde)
		}
		i=0
		for i in 0...4 {
			var archer : Carte = Carte(nom : "Archer")
			listeCarte.append(archer)
		}
		i=0


		for i in 0...19 {
			let randomIndex = Int(arc4random_uniform(listeCarte.count)) //Permet de récupérer un index aléatoire de la listeCarte
			self.liste.append(listeCarte[ramdomIndex]) //On ajoute dans la pioche une carte aléatoire
			listeCarte.remove(at: randomIndex) //on supprime la carte de la liste intermédiaire
		}

	}

	//estVide : Pioche -> Bool
	// cette fonction permet de savoir si la pioche est vide ou non
	//pre: Elle prend en entrée une pioche
	// post : doit renvoyer un booléen, true si la pioche est vide, false sinon
	func estVide() -> Bool {
		return self.liste.count == 0
	}

	//tirerCarte : Pioche -> (Carte|Vide)
	//cette fonction permet de tirer la carte au dessus de la pioche
	//pre: Elle prend en entrée une pioche
	//post : Elle renvoie une carte et s'il n'y a plus de carte renvoie vide
	func tirerCarte() -> Carte? {
		if !self.estVide() {
			return self.liste[0]
		}
		else{
			return nil
		}
	}

	//supprimerCartePioche : Pioche -> Pioche
	//cette fonction permet de supprimer une carte dans la pioche. Si plus de carte, ne fais rien.
	//pre : Elle prend une pioche en entrée.
	//post : ne renvoie rien
	func supprimerCartePioche() {
		if !self.estVide(){
			self.liste.remove(at: 0)
		}
	}
 
}

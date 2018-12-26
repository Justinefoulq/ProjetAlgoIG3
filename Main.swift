import Foundation

enum ShoudNotHappendError : Error{
	case PremiereCartePasRoi
	case MainDejaPleine
}

class Main : Sequence{
	private var Carte : Carte
	private var ItMain : IteratorProtocol
	private var liste : [Carte]

	//init : Carte -> Main
	//cette fonction permet de crée la Main, la main doit pouvoir contenir des cartes, et peut être vide, elle ne contient que 6 cartes au maximum. Initialement, elle est crée avec une carte dedans, celle rentrée en paramètre. 
	//pre: Elle prend une carte en paramètre (qui doit être un roi sinon renvoie une erreur)
	//post: Elle renvoie une Main, contenant que cette Carte
	init (roi : Carte) throws {
		if roi.estRoi(){
			self.liste = [roi]
		}
		else{
			throw ShoudNotHappendError.PremiereCartePasRoi
		}
	}

	//makeMainIterator : Main -> ItMain
	// Crée un itérateur sur les cartes de la main pour la parcourir (pas de contrainte sur l'ordre)
	func makeItMain() -> ItMain {
		return ItMain(self)
	}

	//getMain : Main -> [Carte]
	// Renvoie la liste contenant les carte de la main du joueur
	func getMain() -> [Carte]{
		return self.liste
	}

	//estVide : Main -> Bool
	// cette fonction doit permettre de savoir si la main demandée est complètement vide ou pas.
	// pre : Elle prend en paramètre une Main
	// post : Elle renvoie True si la main est sans carte (donc complètement Vide), False sinon.
	func estVide() -> Bool {
		return (self.nbrCarte() == 0) 
	}

	//EstPleine : Main -> Bool
	// cette fonction doit permettre de savoir si la main considérée est pleine, c'est à dire qu'elle a atteint le nombre maximum autorisé de carte : 6 cartes
	// pre : Elle prend en entrée une Main
	// post : Retourne True si elle est pleine (6 cartes), False sinon.
	func estPleine() -> Bool {
		return (self.nbrCarte() == 6)
	}

	//estDansLaMain : Main x Carte -> Bool
	// cette fonction doit permettre de savoir si une carte se trouve dans la main
	// pre : Prend en entrée une Carte
	// post : Renvoie un booléen, True si la carte est présente dans la main, False sinon.
	func estDansLaMain (c : Carte) -> Bool {
		var DansLaMain = false
		for carte in ItMain{
			if carte == c {
				DansLaMain = true
			}
		}
		return DansLaMain
	}

	//nbrCarte : Main -> Initialement
	// cette fonction permet de savoir le nombre de carte qu'il y a dans une Main
	// pre : Elle prend une Main en entrée
	// post : renvoie un entier, correspondant au nombre de carte total de la main (0<=i<=6)
	func nbrCarte() -> Int {
		return self.main.count
	}

	//getCarteMain : Main x String -> (Carte|Vide)
	// cette fonction permet à partir d'une main, et d'un nom de carte, de connaitre la carte associée.
	//pre : Elle prend en entrée une Main et un String, pouvant n'être que parmi Archer, Garde, Soldat, Roi1, Roi2
	//post : Elle renvoie la Carte associé au nom et à la Main s'il n'y en a pas dans la main ou que c'est un autre String, renvoie Vide
	func getCarteMain(nomDeLaCarte : String) -> Carte? {
		var carteMain : Carte? = nil
		if nomDeLaCarte == "Archer" || nomDeLaCarte == "Garde" || nomDeLaCarte == "Soldat" || nomDeLaCarte == "Roi1" || nomDeLaCarte == "Roi2" {

			for carte in ItMain {
				if carte.getNom() == nomDeLaCarte {
					carteMain = carte
				}
			}
			return carteMain
		}
		else{
			return nil
		}
	}

	//supprimerCarteMain : Main x Carte -> Main // ON NE SAIT PAS SI LA CARTE EST SUPPRIME
	// cette fonction doit permettre de supprimer une carte de la Main, si la main est Vide, ne fait rien. Si la carte n'est pas dans la main, rien ne se passe.
	//pre : prend en entrée une Carte, et la Main 
	//post : Ne renvoie rien
	func supprimerCarteMain(c : Carte) {
		if !self.estPleine() {
			var i : Int = 0
			for carte in ItMain {
				if carte == c {
					self.liste.remove(at: i)
				}
				i++
			}
		}
	}

	//ajouterCarteMain : Main x Carte -> Main
	// cette fonction permet d'ajouter une carte dans la main, si la main est pleine renvoie une erreur.
	//pre : Prend en entrée une Carte, et la main
	//post: Ne renvoie rien
	func ajouterCarteMain(c : Carte) throws {
		if !estPleine() {
			self.liste.append(c)
		}
		else{
			throw ShoudNotHappendError.MainDejaPleine
		}
	}


}

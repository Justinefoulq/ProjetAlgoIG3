import Foundation

// Comme mis en évidence ci-dessous, voici les nom de types qu'il faudra utiliser. De la même manière, le nom du type qui implémentera JoueurProtocol sera Joueur.

enum ShouldNotHappendError: Error{
	case PremiereCartePasRoi
	case NbrCarteAPiocherNegatif
	case MainDejaPleine
}
 

class Joueur : JoueurProtocol {
    associatedtype main : Main
    associatedtype front : Front
    associatedtype carte : Carte
    associatedtype pioche : Pioche
    associatedtype royaume : Royaume

    private var nomJ : String

    // init : String x Carte -> Joueur
    // Cette fonction crée un Joueur, le joueur doit avoir un Nom (renseigné), et les propriétés suivantes : Pioche / Main(Carte) / Royaume / Front 
    // pre : Elle prend en entrée un nom de joueur, et une Carte (Roi1 ou Roi2 uniquement sinon ERREUR)
    // post : Renvoi le joueur crée
    init (nomDuJoueur : String, roi : Carte) throws {
		if roi.getNom() ==  "Roi1" || roi.getNom() == "Roi2" {
			self.carte = roi
		}
		else {
			throw ShouldNotHappendError.PremiereCartePasRoi
		}
		self.nomJ = nomDuJoueur
		self.front = new Front()
		self.main = new Main(roi : self.carte)
		self.pioche = new Pioche()
		self.royaume = new Royaume()
	}

    
    // getNom : Joueur -> String
    // Renvoie le nom associé au joueur
    // pre : Joueur
    // post : nom du joueur
    func getNom() -> String {
		return self.nomJ
	}
    
    // getPioche : Joueur -> Pioche
    // Renvoie la pioche associée au joueur
    // pre : Joueur
    // post : pioche du joueur
    func getPioche() -> Pioche {
		return self.pioche
	}
    
    // getMain : Joueur -> Main
    // Renvoie la main  associée au joueur
    // pre : joueur
    // post : main du joueur
    func getMain() -> Main {
		return self.main
	}
    
    // getFront : Joueur -> Front
    // Renvoie le front associé au joueur
    // pre : joueur
    // post : front du joueur
    func getFront() -> Front {
		return self.front
	}
    
    // getRoyaume : Joueur -> Royaume
    // Renvoie le royaume associé au joueur
    // pre : joueur
    // post : royaume du joueur
    func getRoyaume() -> Royaume {
		return self.royaume
	}

    // piocher : Joueur x Int x Bool -> Joueur
    // Cette fonction permet de retirer un nbr de carte de la pioche du joueur pour la mettre dans la Main (pioche vide = aucune action, main pleine = ERREUR)
    // pre : Prend en entrée un Joueur, un entier positif correspondant au nombre de carte (si <0 renvoie une ERREUR) à retirer de la pioche (par défaut 1) et si l'on souhaite piocher vers le Royaume : Bool = True, si on veut piocher vers la Main, Bool = False
    // post : Ne renvoie rien
    mutating func piocher (nbr : Int, versRoyaume : Bool) throws {
		if nbr < 0 { //Si le nbr de carte à piocher est négatif retourne une erreur
			throw ShouldNotHappendError.NbrCarteAPiocherNegatif
		}
		var carteCourante : Carte
		for i in 1..nbr {. //boucle permettant de piocher nbr fois dans la pioche 
			if self.main.estPleine(){
				throw ShouldNotHappendError.MainDejaPleine
			}
			else if !self.pioche.estVide() {
				carteCourante = self.pioche.tirerCarte()
				self.pioche.supprimerCartePioche()

				if versRoyaume {	//Met la carte piochée dans le royaume
					self.royaume.ajouterCarteRoyaume(c : carteCourante)
				}
				else {		//Met la carte piochée dans la main 
					self.main.ajouterCarteMain(c : carteCourante)
				}
			}
		}
	}
    
    // mobiliser : Joueur x Carte? x String -> Joueur
    // Cette fonction permet de placer une carte de la main du Joueur sur une position du Front. Cas spécial : si on ne donne pas de carte, Il faut tirer la carte du royaume (et non pas de la main).
    // pre : On rentre en paramètre un Joueur, Une carte (Ou pas), et un texte, correspondant à la position à laquelle on veut placer la carte sur le front. (si la position n'existe pas ou est occupée, on lève une ERREUR). Si le Royaume est vide, rien ne se passe pour ce qui est de la main car ça ne peut pas arriver. Dans le cas ou la carte n'est pas dans la main, lève une ERREUR.
    // post : Ne renvoie rien
    mutating func mobiliser (carte : Carte?, position : String) throws {
		var carteCourante : Carte
		if carte == nil {
			if !self.royaume.estVide() {
				carteCourante = self.royaume.tirerCarte()
				if()
				self.front.ajouterCarteFront(position : position, carte : carteCourante)
				self.royaume.supprimerCarteRoyaume()
			}
		}
		else {
			self.front.ajouterCarteFront(position : position, carte : carte)
			self.front.supprimerCarteMain(c : carte)
		}
	}
    
    // demobiliser : Joueur x Carte -> Joueur
    // Cette fonction permet de déplacer une carte de la main, vers le Royaume
    // pre : Prend en entrée un Joueur et une Carte. Si la carte n'est pas dans la main rien ne se passe.
    // post : Ne renvoie rien
    mutating func demobiliser (carte : Carte) 
    
    // capturer : Joueur x Joueur x Carte -> Joueur
    // cette fonction prend une carte du front de l'adversaire et la met dans le royaume du joueur. Si la carte n'est pas sur le front de l'adversaire, rien ne se passe.
    // pre : Prend en entrée un joueur (type Joueur), un adversaire (type Joueur) et une carte.
    // post : Ne renvoie rien
    mutating func capturer (adversaire : Self, carte : Carte)
}
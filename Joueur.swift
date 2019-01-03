

enum ShouldNotHappenError: Error {
	case CaseOccuppe
	case MainDejaPleine
	case PremiereCartePasRoi
	case NbrCarteAPiocherNegatif
	case CartePasDansMain
}

class Joueur {
    //associatedtype main : Main
    //associatedtype front : Front
    //associatedtype carte : Carte
    //associatedtype pioche : Pioche
    //associatedtype royaume : Royaume

    private var nomJ : String
    private var front : Front
    private var main : Main
    private var pioche : Pioche
    private var royaume : Royaume

    // init : String x Carte -> Joueur
    // Cette fonction crée un Joueur, le joueur doit avoir un Nom (renseigné), et les propriétés suivantes : Pioche / Main(Carte) / Royaume / Front 
    // pre : Elle prend en entrée un nom de joueur, et une Carte (Roi1 ou Roi2 uniquement sinon ERREUR)
    // post : Renvoi le joueur crée
    init (nomDuJoueur : String, roi : Carte) throws {
		
		if roi.getNom() !=  "Roi1" && roi.getNom() != "Roi2" {
			throw ShouldNotHappenError.PremiereCartePasRoi
		}
		self.nomJ = nomDuJoueur
		self.front = Front()
		try self.main = Main(roi : roi)
		self.pioche = Pioche()
		self.royaume = Royaume()
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
    // Renvoie la main  associée au joueur
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
    func piocher (nbr : Int, versRoyaume : Bool) throws {
		if nbr < 0 { //Si le nbr de carte à piocher est négatif retourne une erreur
			throw ShouldNotHappenError.NbrCarteAPiocherNegatif
		}
		var carteCourante : Carte
		for _ in 1...nbr { //boucle permettant de piocher nbr fois dans la pioche 
			if self.main.estPleine(){
				throw ShouldNotHappenError.MainDejaPleine
			}
			else if !(self.pioche.estVide()) {
				carteCourante = self.pioche.tirerCarte()!
				self.pioche.supprimerCartePioche()

				if versRoyaume {	//Met la carte piochée dans le royaume
					self.royaume.ajouterCarteRoyaume(carte : carteCourante)
				}
				else {		//Met la carte piochée dans la main 
					try self.main.ajouterCarteMain(c : carteCourante)
				}
			}
		}
	}
    
    // mobiliser : Joueur x Carte? x String -> Joueur
    // Cette fonction permet de placer une carte de la main du Joueur sur une position du Front. Cas spécial : si on ne donne pas de carte, Il faut tirer la carte du royaume (et non pas de la main).
    // pre : On rentre en paramètre un Joueur, Une carte (Ou pas), et un texte, correspondant à la position à laquelle on veut placer la carte sur le front. (si la position n'existe pas ou est occupée, on lève une ERREUR). Si le Royaume est vide, rien ne se passe pour ce qui est de la main car ça ne peut pas arriver. Dans le cas ou la carte n'est pas dans la main, lève une ERREUR.
    // post : Ne renvoie rien
    func mobiliser (carte : Carte?, position : String) throws {
		var carteCourante : Carte
		var positionMobiliser : String = position
		var CaseVide : Bool = false
		try CaseVide = self.front.estCaseVide(pos : position)
		if !CaseVide { //Leve une ERREUR si la case n'existe pas ou est pleine
			throw ShouldNotHappenError.CaseOccuppe		 
		}
		else{
			if !self.front.estLibre(position : position){//Si le F(1,2,3) n'est pas plein et qu'on remplis le A(1,2,3) on avance en F
				switch position {
					case "A1":
						positionMobiliser = "F1"
					case "A2":
						positionMobiliser = "F2"
					case "A3":
						positionMobiliser = "F3"
					default : 
						positionMobiliser = position
				}
			}
		}
		if carte == nil { //On place la première carte du royaume du joueur
			if !self.royaume.estVide() {
				carteCourante = self.royaume.tirerCarte()!
				try self.front.ajouterCarteFront(position : positionMobiliser, carte : carteCourante)
				self.royaume.supprimerCarteRoyaume()
			}
		}
		else { //On place la carte de la main du joueur donné en paramètre
			if self.main.estDansLaMain(c: carte!){//Si la carte est dans la main
				try self.front.ajouterCarteFront(position : positionMobiliser, carte : carte!)
				self.main.supprimerCarteMain(c : carte!)
			}
			else{//On leve un ERREUR si la carte n'est aps dans la main
				throw ShouldNotHappenError.CartePasDansMain
			}
		}
	}
    
    // demobiliser : Joueur x Carte -> Joueur
    // Cette fonction permet de déplacer une carte de la main, vers le Royaume
    // pre : Prend en entrée un Joueur et une Carte. Si la carte n'est pas dans la main rien ne se passe.
    // post : Ne renvoie rien
    func demobiliser (carte : Carte) {
    	if self.main.estDansLaMain(c : carte) {
    		self.royaume.ajouterCarteRoyaume(carte : carte)
    		self.main.supprimerCarteMain(c : carte)
    	}
    }
    
    // capturer : Joueur x Joueur x Carte -> Joueur
    // cette fonction prend une carte du front de l'adversaire et la met dans le royaume du joueur. Si la carte n'est pas sur le front de l'adversaire, rien ne se passe.
    // pre : Prend en entrée un joueur (type Joueur), un adversaire (type Joueur) et une carte.
    // post : Ne renvoie rien
    func capturer(adversaire : Joueur, carte : Carte){
    	for carteFrontEnnemie in adversaire.getFront(){
    		if carteFrontEnnemie === carte {
    			self.royaume.ajouterCarteRoyaume(carte : carte)
    			adversaire.getFront().supprimerCarteFront(carte : carte)
    		}
    	}
    }
}



/*
var R1 : Carte
try R1 = Carte(nom : "Roi1")
var J1 : Joueur 
try J1 = Joueur(nomDuJoueur : "Fefe", roi : R1)
print(J1.getNom())
print(J1.getMain().getMain())
print(J1.getRoyaume().nbrCarte())
print(J1.getFront().estVide())
print(J1.getPioche().estVide())
try J1.piocher(nbr : 2, versRoyaume : true)
try J1.piocher(nbr : 3, versRoyaume : false)
print(J1.getMain().getMain())
print(J1.getRoyaume().nbrCarte())
try J1.mobiliser(carte : R1, position : "F2")
print(J1.getMain().getMain())
print(J1.getFront().estVide())
//try J1.mobiliser(carte : nil, position : "F2")
try J1.mobiliser(carte : nil, position : "F1")
print(J1.getFront().getCarteFront(position : "F1")!.getNom())
print(J1.getFront().getCarteFront(position : "F2")!.getNom())
try J1.mobiliser(carte : nil, position : "A3")
print(J1.getFront().getCarteFront(position : "F3")!.getNom())
try J1.mobiliser(carte : nil, position : "A3")
//print(J1.getFront().getCarteFront(position : "A3"))
//try J1.mobiliser(carte : R1, position : "A2")
J1.demobiliser(carte : J1.getMain().getMain()[0])
print(J1.getMain().getMain())
print(J1.getRoyaume().nbrCarte())
var R2 : Carte
try R2 = Carte(nom: "Roi2")
var J2 : Joueur 
try J2 = Joueur(nomDuJoueur : "Raph", roi : R2)
try J2.mobiliser(carte : R2, position : "F2")
J1.capturer(adversaire : J2, carte : R2)
print(J2.getMain().getMain())
print(J1.getRoyaume().nbrCarte())



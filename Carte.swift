enum ShouldNotHappenError: Error {
    case PasBonNomCarte
    case DegatNegatif
}

class Carte : CarteProtocol {
    associatedtype Main : MainProtocol

    private var nomC : String
    private var attaqueC : Int
    private var defdefC : Int
    private var defoffC : Int
    private var porteeC : String
    private var modedef : Bool
    private var degatsubis : Int
    // init : String -> Carte 
    // cette fonction permet de créer une carte, avec ses caractéristiques et son nom
    // pre : Elle prend en entrée un String, parmi Soldat, Garde, Archer, Roi1 et Roi2. Si ce n'est pas le cas, elle lève une EXCEPTION. Chaque unité à ses propres caractéristiques : 
    // Soldat ;
    // - attaque : Autant que d'unités dans la main (du joueur à qui appartient le soldat)
    // - défense (position défensive) : 2
    // - défense (position offensive) : 1
    // - portée : peut attaquer la position devant lui
    // Garde ;
    // - attaque : 1
    // - défense (position défensive) : 3
    // - défense (position offensive) : 2
    // - portée : peut attaquer la position devant lui
    // Archer ;
    // - attaque : 1
    // - défense (position défensive) : 2
    // - défense (position offensive) : 1
    // - portée : peut attaquer les 4 positions devant lui qui seraient les cases d'arrivée par un mouvement de cavalier aux échecs
    // Roi1 ;
    // - attaque : 1
    // - défense (position défensive) : 4
    // - défense (position offensive) : 4
    // - portée : il peut attaquer toute la ligne devant lui, et la position à une distance de 2 devant lui (c'est à dire la case juste derrière celle devant lui)
    // Roi2 ;
    // - attaque : 1
    // - défense (position défensive) : 5
    // - défense (position offensive) : 4
    // - portée : ce roi peut attaquer toute la ligne devant lui
    // post : Elle renvoie la Carte crée.
	init (nom : String) throws{
		switch nom {
			case "Soldat":
				self.attaqueC = 0
				self.defdefC = 2
				self.defoffC = 1
				self.porteeC = "peut attaquer la position devant lui"
				self.modedef = true
				self.degatsubis = 0
			case "Garde":
				self.attaqueC = 1
				self.defdefC = 3
				self.defoffC = 2
				self.porteeC = "peut attaquer la position devant lui"
				self.modedef = true
				self.degatsubis = 0
			case "Archer":
				self.attaqueC = 1
				self.defdefC = 2
				self.defoffC = 1
				self.porteeC = "peut attaquer les 4 positions devant lui qui seraient les cases d'arrivée par un mouvement de cavalier aux échecs"
				self.modedef = true
				self.degatsubis = 0
			case "Roi1":
				self.attaqueC = 1
				self.defdefC = 4
				self.defoffC = 4
				self.porteeC = "il peut attaquer toute la ligne devant lui, et la position à une distance de 2 devant lui (c'est à dire la case juste derrière celle devant lui)"
				self.modedef = true
				self.degatsubis = 0
			case "Roi2":
				self.attaqueC = 1
				self.defdefC = 5
				self.defoffC = 4
				self.porteeC = "ce roi peut attaquer toute la ligne devant lui"
				self.modedef = true
				self.degatsubis = 0
			default:
				throw ShouldNotHappenError.PasBonNomCarte
		}
	}
    
    // getNom : Carte -> String 
    // Cette fonction permet d'accéder au nom de la carte demandée
    // pre : Elle prend en paramètre une carte
    // post : elle renvoie le nom de cette carte en string.
    func getNom () -> String {
		return self.nomC
	}
    
    // getAtt : Carte x Main -> Int
    // Cette fonction permet de renvoyer l'attaque de la carte demandée.
    // pre : Elle prend en paramètre une carte et une main pour le cas du soldat
    // post : Elle renvoie l'attaque propre à la carte en Int.
    func getAtt (main : Main) -> Int {
		if self.nomC != "Soldat" {
			return self.attaqueC
		}
		else {
			return main.nbrCarte()
		}
	}
    
    // getDefOffensif : Carte -> Int 
    // Cette fonction permet de renvoyer la défense (en position offensive) de la carte demandée.
    // pre : Elle prend en paramètre une carte
    // post : Elle renvoie la défense (en position offensive) propre à la carte en Int.
    func getDefOffensif () -> Int{
		return self.defoffC
	}
    
    // getDefDefensif : Carte -> Int 
    // Cette fonction permet de renvoyer la défense (en position défensive) de la carte demandée.
    // pre : Elle prend en paramètre une carte
    // post : Elle renvoie la défense (en position défensive) propre à la carte en Int.
    func getDefDefensif () -> Int {
		return self.defdefC
	}
    
    // getDef : Carte -> Int 
    // Cette fonction permet de renvoyer la défense réellement active de la carte demandée (selon son état : défensif ou offensif).
    // pre : Elle prend en paramètre une carte
    // post : Elle renvoie la défense propre à la carte en Int.
    func getDef () -> Int{
		if self.modedef {
			return  self.getDefDefensif() 
		}
		else {
			return self.getDefOffensif()
		}
	}
    
    // getPortee : Carte -> String 
    // Cette fonction permet de renvoyer la portée de la carte demandée.
    // pre : Elle prend en paramètre une carte
    // post : Elle renvoie la portée propre à la carte en string.
    func getPortee () -> String {
		return self.porteeC
	}

    // getDeg : Carte -> Int 
    // Cette fonction permet de renvoyer subie par la carte au cours du tour actuel (temporaire, 0 par défaut)
    // pre : Elle prend en paramètre une carte
    // post : Elle renvoie les dégats propre à la carte et au tour en Int.
    func getDeg () -> Int{
		return self.degatsubis
	}

    // setDeg : Carte x Int -> Carte
    // Cette fonction permet de modifier les dégâts subis par la carte au cours du tour actuel (temporaire)
    // pre : Elle prend en paramètre une carte un Int (>0 ou =0) correspondant à la nouvelle valeur de dégâts. S'il est négatif, lève une EXCEPTION.
    // post : Elle ne renvoie rien
    mutating func setDeg (nbr : Int) throws{
		guard let nbr>=0 else{
			throw ShouldNotHappenError.DegatNegatif
		}
		self.degatsubis = nbr
	}
    
    // ModeOffensif : Carte -> Carte
    // Cette fonction permet de changer l'état d'une carte, de l'état défensif à offensif. Il faut donc lui associer la bonne défense parmi les deux proposées dans les stats. (Défensif : Mode par défaut)
    // pre : La fonction prend en entrée une Carte
    // post : Elle ne renvoie rien.
    mutating func modeOffensif () {
		self.modedef = false
	}
    
    // ModeDefensif : Carte -> Carte
    // Cette fonction permet de changer l'état d'une carte, de l'état offensif à defensif. Il faut donc lui associer la bonne défense parmi les deux proposées dans les stats. (Défensif : Mode par défaut)
    // pre : La fonction prend en entrée une Carte
    // post : Elle ne renvoie rien.
    mutating func modeDefensif () {
		self.modedef = true
	}
    
    // estRoi : Carte -> Bool
    // cette fonction permet de savoir si la carte demandée est un Roi.
    // pre : elle prend en entrée une Carte
    // post : retourne un Booléen, True si c'est le cas, False sinon.
    func estRoi () -> Bool{
		if (self.getNom() == "Roi1") || (self.getNom() == "Roi2"){
			return true
		}
		else{
			return false
		}
	}
    
    // estaSaPortee : Carte x String x String -> Bool 
    // Cette fonction permet de savoir en fonction de la portée de la carte demandée, si la position demandée est atteignable ou non 
    // pre : Elle prend en entrée une Carte, suivie de sa position, mais aussi une deuxième position, correspondant à la case ciblée, l'endroit où l'on veut viser (Rappel : Position du front -> F1,F2,F3,A1,A2,A3 et la casse ne compte pas)
    // post : Elle renvoie un Booléen, True si la case ciblée est à portée, False sinon. Si position inexistante renvoie False aussi.
    func estaSaportee (positionC : String, positionCible : String) -> Bool{
		
	}
}

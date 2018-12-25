import Foundation

enum ShouldNotHappenError: Error {
    case PasUneCase
}

class Front {
	
	private var fr : [Carte?]
	
	// init : -> Front
	// Cette fonction permet de créer un front : le front est le champ de bataille, il se représente avec 6 cases, 3 en première ligne (devant) et 3 en seconde ligne (derrière), les cases de la première ligne sont nommés : F1,F2,F3 ou f1,f2,f3 et ceux de la deuxième ligne sont nommés : A1,A2,A3 ou a1,a2,a3 (c'est comme ça qu'on les appelles dans le main). Autrement dit la casse n'importe pas. Les cases doivent pouvoir etre de type Carte, ou Vide
	//pre :
	//post : Elle renvoie le front une fois initialisée, sans unité dessus, donc les cases seront vide
	init(){
		self.fr = [nil,nil,nil,nil,nil,nil]
	}

	// makeItFront : Front -> ItFront
	// Crée un itérateur sur les cartes du front pour le parcourir dans l'ordre F1,F2,F3,A1,A2,A3
	//func makeItFront() -> ItFront{}

	//estLibre : String x Front -> Bool
	//Cette fonction permet de savoir si la case selectionnée est valide : sans unité placée dessus, Si jamais la case demandée est en seconde ligne (parmi les A ou a) il faut vérifier qu'il y ait bien une unité sur la case F ou f correspondant.
	//pre : Elle prend en paramètre une case du front (parmi : F1,F2,F3,A1,A2,A3,f1,f2,f3,a1,a2,a3), un Front. (Rappel : F1=f1...)
	//post : elle retourne Un booléen, True si la case est disponible, False sinon. Si la position n'existe pas renvoie false aussi
	func estLibre(position : String) -> Bool{
		var estok : Bool = false
		switch position {
			case "F1" :
				if self.fr[0]  == nil{
					estok = true
				}
			case "F2" :
				if self.fr[1]  == nil{
					estok = true
				}
			case "F3" :
				if self.fr[2]  == nil{
					estok = true
				}
			case "A1" :
				if (self.fr[3]  == nil) && (self.fr[0] != nil){
					estok = true
				}
			case "A2" :
				if (self.fr[4]  == nil) && (self.fr[1] != nil){
					estok = true
				}
			case "A3" :
				if (self.fr[5]  == nil) && (self.fr[3] != nil){
					estok = true
				}
			default :
				estok = false
		}
		return estok
	}
	//estVide : Front -> Bool
	//cette fonction doit permettre de savoir si le front demandé est complètement vide ou pas (Toutes les cases sont sans unité donc vide)
	//pre : Elle prend en paramètre un Front
	//post : Elle renvoit True si le front est totalement vide, False sinon
	func estVide() -> Bool{
		return (self.fr[0] == nil) && (self.fr[1] == nil) && (self.fr[2] == nil) && (self.fr[3] == nil) && (self.fr[4] == nil) && (self.fr[5] == nil)
	}

	//estCaseVide : Front x String-> Bool
	//cette fonction doit permettre de savoir si la case du front fourni est complètement vide ou pas
	//pre : Elle prend en paramètre un Front et un String correspondant à une position (F1,a2...)
	//post : Elle renvoit True si la case sur le front est vide, False sinon. Renvoie une ERREUR si la position n'existe pas
	func estCaseVide (pos : String) throws -> Bool{
		var estok : Bool = false
		switch pos {
			case "F1":
				if self.fr[0]  == nil{
					estok = true
				}
			case "F2" :
				if self.fr[1]  == nil{
					estok = true
				}
			case "F3" :
				if self.fr[2]  == nil{
					estok = true
				}
			case "A1" :
				if self.fr[3]  == nil{
					estok = true
				}
			case "A2" :
				if self.fr[4]  == nil{
					estok = true
				}
			case "A3" :
				if self.fr[5]  == nil{
					estok = true
				}
			default :
				throw ShouldNotHappenError.PasUneCase
		}
		return estok
	}

	//reinit : Front -> Front
	//Cette fonction permet de remettre à zero les dégats subis, et de passer en mode défensif toutes les cartes du front
	//pre : Elle prend en entrée un Front
	//post : Ne renvoie rien
	func reinit (){
		var i : Int = 0
		var c : Carte
		while i<6{
			if self.fr[i] != nil{
				c = self.fr[i]!
				do {
					try c.setDeg(nbr : 0)
				} catch {}
				c.modeDefensif()
				self.fr[i] = c
			}
			i=i+1
		}
	}

	//peutAttaquer : Front x Carte x String -> Bool
	//cette fonction doit permettre de savoir la Carte demandée, à la position renseignée à au moins une cible à sa portée. il faut donc regarder toutes les positions du front adverse avec la fonction estaSaPortee
	//pre : prend en entrée une Carte, sa position
	//post : renvoi un booléen, True si la Carte peut attaquer au moins une autre cible, False sinon
	func peutAttaquer (c : Carte, positionC : String) -> Bool{
		return c.estaSaPortee(positionC : positionC, positionCible : "F1") || c.estaSaPortee(positionC : positionC, positionCible : "F2") || c.estaSaPortee(positionC : positionC, positionCible : "F3") || c.estaSaPortee(positionC : positionC, positionCible : "A1") || c.estaSaPortee(positionC : positionC, positionCible : "A2") || c.estaSaPortee(positionC : positionC, positionCible : "A3")
	}

	//getCarteFront : Front x String -> (Carte | Vide)
	//Cette fonction permet a partir d'une position sur le Front de savoir la carte qui s'y trouve.
	// pre : Elle prend en entrée un Front, et une position de ce Front.
	//post : Elle renvoie la carte associée à cette position du Front. Si il n'y a pas de carte à cet emplacement, renvoie Vide.
	func getCarteFront (position : String) -> Carte?{
		switch position {
			case "F1":
				return self.fr[0]
			case "F2":
				return self.fr[1]
			case "F3":
				return self.fr[2]
			case "A1":
				return self.fr[3]
			case "A2":
				return self.fr[4]
			case "A3":
				return self.fr[5]
			default :
				return nil
		}
	}

	//supprimerCarteFront : Front x Carte -> Front
	//Cette ingénieuse fonction doit supprimer la carte renseignée du Front indiqué. La case correspondante sera donc Vide
	//pre : Elle prend en entrée un Front, et une Carte de ce Front (Attention, plusieurs position peuvent contenir la même carte... Utiliser "===" !). Si la carte n'est pas sur le front, rien ne se passe
	//post : Ne renvoie rien
	func supprimerCarteFront (carte : Carte){
		var i :Int = 0
		while i<6{
			if carte === self.fr[i]{
				self.fr[i] = nil
			}
			i=i+1
		}
	}

	//ajouterCarteFront : Front x String x Carte -> Front
	//Cette fonction permet d'ajouter une Carte sur la position du Front souhaitée.
	//pre : Elle prend en entrée un Front, une position de ce Front, et une Carte
	//post : Si la position n'existe pas, renvoie une ERREUR, si la position contient déjà une carte, on met la nouvelle
	func ajouterCarteFront (position : String, carte : Carte) throws{
		switch position {
			case "F1":
				self.fr[0] = carte
			case "F2":
				self.fr[1] = carte
			case "F3":
				self.fr[2] = carte
			case "A1":
				self.fr[3] = carte
			case "A2":
				self.fr[4] = carte
			case "A3":
				self.fr[5] = carte
			default :
				throw ShouldNotHappenError.PasUneCase
		}
	}
}

//var F : Front = Front()

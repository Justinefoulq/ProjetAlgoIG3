import Foundation

enum ShouldNotHappenError: Error {
    case PasUneCase
}


class Front : Sequence {
	
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
	func makeItFront() -> ItFront{}

	//estLibre : String x Front -> Bool
	//Cette fonction permet de savoir si la case selectionnée est valide : sans unité placée dessus, Si jamais la case demandée est en seconde ligne (parmi les A ou a) il faut vérifier qu'il y ait bien une unité sur la case F ou f correspondant.
	//pre : Elle prend en paramètre une case du front (parmi : F1,F2,F3,A1,A2,A3,f1,f2,f3,a1,a2,a3), un Front. (Rappel : F1=f1...)
	//post : elle retourne Un booléen, True si la case est disponible, False sinon. Si la position n'existe pas renvoie false aussi
	func estLibre(position : String) -> Bool{
		var estok : Bool = false
		switch position {
			case "F1" || "f1":
				if self.fr[0]  == nil{
					estok = true
				}
			case "F2" || "f2":
				if self.fr[1]  == nil{
					estok = true
				}
			case "F3" || "f3":
				if self.fr[2]  == nil{
					estok = true
				}
			case "A1" || "a1":
				if (self.fr[3]  == nil) && (self.fr[0] != nil){
					estok = true
				}
			case "A2" || "a2":
				if (self.fr[4]  == nil) && (self.fr[1] != nil){
					estok = true
				}
			case "A3" || "a3":
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
		return (self.fr[0] == vide) && (self.fr[1] == vide) && (self.fr[2] == vide) && (self.fr[3] == vide) && (self.fr[4] == vide) && (self.fr[5] == vide)
	}

	//estCaseVide : Front x String-> Bool
	//cette fonction doit permettre de savoir si la case du front fourni est complètement vide ou pas
	//pre : Elle prend en paramètre un Front et un String correspondant à une position (F1,a2...)
	//post : Elle renvoit True si la case sur le front est vide, False sinon. Renvoie une ERREUR si la position n'existe pas
	func estCaseVide (pos : String) throws -> Bool{
		var estok : Bool = false
		switch position {
			case "F1" || "f1":
				if self.fr[0]  == nil{
					estok = true
				}
			case "F2" || "f2":
				if self.fr[1]  == nil{
					estok = true
				}
			case "F3" || "f3":
				if self.fr[2]  == nil{
					estok = true
				}
			case "A1" || "a1":
				if self.fr[3]  == nil{
					estok = true
				}
			case "A2" || "a2":
				if self.fr[4]  == nil{
					estok = true
				}
			case "A3" || "a3":
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
	mutating func reinit (){
		var i : Int = 0
		while i<6{
			self.fr[i].setDeg(nbr : 0)
			self.fr[i].modeDefensif()
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

	


}

//var F : Front = Front()

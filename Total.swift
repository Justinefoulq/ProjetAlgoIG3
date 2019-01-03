import Foundation
// RÉPERTOIRE D'ERREURS //
// Attention : Ces erreurs ne peuvent pas arriver actuellement. Cependant, si le main est modifié, ces erreurs seront là pour éviter de faire n'importe quoi.
enum ShouldNotHappenError: Error {
  case ShouldBeKing
  case MustBeInHand
  case IsNotPosition
  case KingdomIsEmpty
  case PasBonNomCarte
  case DegatNegatif
  case PasUneCase
  case PremiereCartePasRoi
  case NbrCarteAPiocherNegatif
  case MainDejaPleine
  case CaseOccuppe
  case CartePasDansMain
}


class Carte {
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
  init (nom : String) throws{
    switch nom {
      case "Soldat":
        self.nomC = "Soldat"
        self.attaqueC = 0
        self.defdefC = 2
        self.defoffC = 1
        self.porteeC = "peut attaquer la position devant lui"
        self.modedef = true
        self.degatsubis = 0
      case "Garde":
        self.nomC = "Garde"
        self.attaqueC = 1
        self.defdefC = 3
        self.defoffC = 2
        self.porteeC = "peut attaquer la position devant lui"
        self.modedef = true
        self.degatsubis = 0
      case "Archer":
        self.nomC = "Archer"
        self.attaqueC = 1
        self.defdefC = 2
        self.defoffC = 1
        self.porteeC = "peut attaquer les 4 positions devant lui qui seraient les cases d'arrivée par un mouvement de cavalier aux échecs"
        self.modedef = true
        self.degatsubis = 0
      case "Roi1":
        self.nomC = "Roi1"
        self.attaqueC = 1
        self.defdefC = 4
        self.defoffC = 4
        self.porteeC = "il peut attaquer toute la ligne devant lui, et la position à une distance de 2 devant lui (c'est à dire la case juste derrière celle devant lui)"
        self.modedef = true
        self.degatsubis = 0
      case "Roi2":
        self.nomC = "Roi2"
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
  func getNom() -> String {
    return self.nomC
  }

  // getAtt : Carte x Main -> Int
  // Cette fonction permet de renvoyer l'attaque de la carte demandée.
  // pre : Elle prend en paramètre une carte et une main pour le cas du soldat
  // post : Elle renvoie l'attaque propre à la carte en Int.
  
  func getAtt(main : Main) -> Int {
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
  func getDefDefensif()-> Int{
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
  func getPortee() -> String{
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
  //mutating 
  func setDeg (nbr : Int) throws{
    if nbr < 0 {
      throw ShouldNotHappenError.DegatNegatif
    }
    else{
      self.degatsubis = nbr
    }
  }
  // ModeOffensif : Carte -> Carte
  // Cette fonction permet de changer l'état d'une carte, de l'état défensif à offensif. Il faut donc lui associer la bonne défense parmi les deux proposées dans les stats. (Défensif : Mode par défaut)
  // pre : La fonction prend en entrée une Carte
  // post : Elle ne renvoie rien.
  //mutating 
  func modeOffensif() {
    self.modedef = false
  }
  
  // ModeDefensif : Carte -> Carte
  // Cette fonction permet de changer l'état d'une carte, de l'état offensif à defensif. Il faut donc lui associer la bonne défense parmi les deux proposées dans les stats. (Défensif : Mode par défaut)
  // pre : La fonction prend en entrée une Carte
  // post : Elle ne renvoie rien.
  //mutating 
  func modeDefensif(){
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
  func estaSaPortee (positionC : String, positionCible : String) -> Bool{
    var estok : Bool = false
    switch self.getNom() {
      case "Soldat":
        switch positionC {
          case "F1": 
            if positionCible == "F3" || positionCible == "f3"{
              estok = true
            }
          case "F2":
            if positionCible == "F2" || positionCible == "f2"{
              estok = true
            }
          case "F3":
            if positionCible == "F1" || positionCible == "f1"{
              estok = true
            }
          case "f1": 
            if positionCible == "F3" || positionCible == "f3"{
              estok = true
            }
          case "f2":
            if positionCible == "F2" || positionCible == "f2"{
              estok = true
            }
          case "f3":
            if positionCible == "F1" || positionCible == "f1"{
              estok = true
            }
          default:
            estok = false
        }
      case "Garde":
        switch positionC {
          case "F1": 
            if positionCible == "F3" || positionCible == "f3"{
              estok = true
            }
          case "F2":
            if positionCible == "F2" || positionCible == "f2"{
              estok = true
            }
          case "F3":
            if positionCible == "F1" || positionCible == "f1"{
              estok = true
            }
          case "f1": 
            if positionCible == "F3" || positionCible == "f3"{
              estok = true
            }
          case "f2":
            if positionCible == "F2" || positionCible == "f2"{
              estok = true
            }
          case "f3":
            if positionCible == "F1" || positionCible == "f1"{
              estok = true
            }
          default:
            estok = false
        }

      case "Archer":
        switch positionC {
          case "F1":
            if (positionCible == "A2") || (positionCible == "F1") || (positionCible == "a2") || (positionCible == "f1"){
              estok = true
            }
          case "F2":
            if (positionCible == "A1") || (positionCible == "A3") || (positionCible == "a1") || (positionCible == "a3"){
              estok = true
            }
          case "F3":
            if (positionCible == "A2") || (positionCible == "F3") || (positionCible == "a2") || (positionCible == "f3"){
              estok = true
            }
          case "A1":
            if (positionCible == "F2") || positionCible == "f2"{
              estok = true
            }
          case "A2":
            if (positionCible == "F3") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f1"){
              estok = true
            }
          case "A3":
            if (positionCible == "F2") || positionCible == "f2"{
              estok = true
            }
          case "f1":
            if (positionCible == "A2") || (positionCible == "F1") || (positionCible == "a2") || (positionCible == "f1"){
              estok = true
            }
          case "f2":
            if (positionCible == "A1") || (positionCible == "A3") || (positionCible == "a1") || (positionCible == "a3"){
              estok = true
            }
          case "f3":
            if (positionCible == "A2") || (positionCible == "F3") || (positionCible == "a2") || (positionCible == "f3"){
              estok = true
            }
          case "a1":
            if (positionCible == "F2") || positionCible == "f2"{
              estok = true
            }
          case "a2":
            if (positionCible == "F3") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f1"){
              estok = true
            }
          case "a3":
            if (positionCible == "F2") || positionCible == "f2"{
              estok = true
            }
          default:
            estok = false
        }
      case "Roi1":
        switch positionC {
          case "F1":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "A3") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "a3") || (positionCible == "f1"){
              estok = true
            }
          case "F2":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1") || (positionCible == "A2") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1") || (positionCible == "a2"){
              estok = true
            }
          case "F3":
            if (positionCible == "F1") || (positionCible == "F2") || (positionCible == "A1") || (positionCible == "F3") || (positionCible == "f1") || (positionCible == "f2") || (positionCible == "a1") || (positionCible == "f3"){
              estok = true
            }
          case "A1":
            if (positionCible == "F3") || positionCible == "f3"{
              estok = true
            }
          case "A2":
            if (positionCible == "F2") || positionCible == "f2"{
              estok = true
            }
          case "A3":
            if (positionCible == "F1") || positionCible == "f1"{
              estok = true
            }
          case "f1":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "A3") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "a3") || (positionCible == "f1"){
              estok = true
            }
          case "f2":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1") || (positionCible == "A2") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1") || (positionCible == "a2"){
              estok = true
            }
          case "f3":
            if (positionCible == "F1") || (positionCible == "F2") || (positionCible == "A1") || (positionCible == "F3") || (positionCible == "f1") || (positionCible == "f2") || (positionCible == "a1") || (positionCible == "f3"){
              estok = true
            }
          case "a1":
            if (positionCible == "F3") || positionCible == "f3"{
              estok = true
            }
          case "a2":
            if (positionCible == "F2") || positionCible == "f2"{
              estok = true
            }
          case "a3":
            if (positionCible == "F1") || positionCible == "f1"{
              estok = true
            }
          default:
            estok = false
        }
      case "Roi2":
        switch positionC {
          case "F1":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1"){
              estok = true
            }
          case "F2":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1"){
              estok = true
            }
          case "F3":
            if (positionCible == "F1") || (positionCible == "F2") || (positionCible == "F3") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1"){
              estok = true
            }
          case "f1":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1"){
              estok = true
            }
          case "f2":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1"){
              estok = true
            }
          case "f3":
            if (positionCible == "F1") || (positionCible == "F2") || (positionCible == "F3") || (positionCible == "f3") || (positionCible == "f2") || (positionCible == "f1"){
              estok = true
            }
          default:
            estok = false
        }
      default:
        estok = false
    }
    return estok
  }
}

class FrontIterator : IteratorProtocol {
  let front: Front
    var i : Int = 0

    init(front: Front) {
        self.front = front
    }

    func next() -> Carte? {
      let liste = self.front.fr
        while (self.i < 6) && (liste[i] == nil){
          self.i = self.i + 1
        }
        if self.i < 0 || self.i >= 6 {
          return nil
        }
        else{
          self.i = self.i + 1
          return liste[self.i-1]
        }
    }
}

class Front : Sequence {
  
  var fr : [Carte?]
  
  // init : -> Front
  // Cette fonction permet de créer un front : le front est le champ de bataille, il se représente avec 6 cases, 3 en première ligne (devant) et 3 en seconde ligne (derrière), les cases de la première ligne sont nommés : F1,F2,F3 ou f1,f2,f3 et ceux de la deuxième ligne sont nommés : A1,A2,A3 ou a1,a2,a3 (c'est comme ça qu'on les appelles dans le main). Autrement dit la casse n'importe pas. Les cases doivent pouvoir etre de type Carte, ou Vide
  //pre :
  //post : Elle renvoie le front une fois initialisée, sans unité dessus, donc les cases seront vide
  init(){
    self.fr = [nil,nil,nil,nil,nil,nil]
  }

  // makeItFront : Front -> ItFront
  // Crée un itérateur sur les cartes du front pour le parcourir dans l'ordre F1,F2,F3,A1,A2,A3
  func makeIterator() -> FrontIterator{
    return FrontIterator(front : self)
  }

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
      case "f1" :
        if self.fr[0]  == nil{
          estok = true
        }
      case "f2" :
        if self.fr[1]  == nil{
          estok = true
        }
      case "f3" :
        if self.fr[2]  == nil{
          estok = true
        }
      case "a1" :
        if (self.fr[3]  == nil) && (self.fr[0] != nil){
          estok = true
        }
      case "a2" :
        if (self.fr[4]  == nil) && (self.fr[1] != nil){
          estok = true
        }
      case "a3" :
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
      case "f1":
        if self.fr[0]  == nil{
          estok = true
        }
      case "f2" :
        if self.fr[1]  == nil{
          estok = true
        }
      case "f3" :
        if self.fr[2]  == nil{
          estok = true
        }
      case "a1" :
        if self.fr[3]  == nil{
          estok = true
        }
      case "a2" :
        if self.fr[4]  == nil{
          estok = true
        }
      case "a3" :
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
    for carte in self{
      do {
        try carte.setDeg(nbr : 0)
      } catch {}
      carte.modeDefensif()
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
      case "f1":
        return self.fr[0]
      case "f2":
        return self.fr[1]
      case "f3":
        return self.fr[2]
      case "a1":
        return self.fr[3]
      case "a2":
        return self.fr[4]
      case "a3":
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
      case "f1":
        self.fr[0] = carte
      case "f2":
        self.fr[1] = carte
      case "f3":
        self.fr[2] = carte
      case "a1":
        self.fr[3] = carte
      case "a2":
        self.fr[4] = carte
      case "a3":
        self.fr[5] = carte
      default :
        throw ShouldNotHappenError.PasUneCase
    }
  }
}

class Royaume {
  private var file : [Carte]
  private var cmp : Int

  //init : -> Royaume
  //cette fonction initialise le royaume. Le royaume doit permettre de stocker des cartes, la première carte à rentrer dans le royaume doit être la première à sortir. Il n'a pas de taille maximum
  //pre :
  //post : Elle renvoie le royaume, vide
  init(){
    self.cmp = 0
    self.file = []
  }

  //estVide : Royaume -> Bool
  //cette fonction doit permettre de savoir si le royaume considéré est sans unité ou pas (soit elle est complètement vide ou non)
  //pre : Elle prend en paramètre un Royaume
  //post : Elle renvoie True si le Royaume est totalement vide, False sinon
  func estVide() -> Bool{
    return cmp == 0
  }

  //tirerCarte : Royaume -> (Carte | Vide)
  //cette fonction permet de retirer une carte du Royaume, cette carte doit obligatoirement être la première carte à être rentrée dans le royaume parmi toute celles qui s'y trouvent
  //pre : Elle prend un Royaume en paramètre
  //post : Elle renvoie la première carte à être rentrée dans le royaume s'il n'y en a plus, renvoie vide
  func tirerCarte() -> Carte?{
    if cmp == 0{
      return nil
    }
    else{
      return self.file[0]
    }
  }

  //supprimerCarteRoyaume : Royaume -> Royaume
  //Cette fonction permet de supprimer la première carte à être rentrée dans le royaume parmi toutes celles qui s'y trouvent. S'il n'y en a plus, ne fais rien
  //pre : Elle prend en entrée un Royaume
  //post : Ne renvoie rien
  func supprimerCarteRoyaume(){
    if cmp != 0{
      self.file.remove(at :0)
      self.cmp = self.cmp-1
    }
  }

  //ajouterCarteRoyaume : Carte x Royaume -> Royaume
  //Cette fonction permet de rajouter une Carte dans le Royaume
  //pre : Elle prend en entrée une Carte et un Royaume
  //post : Ne renvoie rien
  func ajouterCarteRoyaume(carte : Carte){
    self.file.append(carte)
    self.cmp = self.cmp+1
  }

  //nbrCarte : Royaume -> Int
  //Cette fonction permet de savoir le nombre de carte du royaume du joueur demandé
  //pre : elle prend en paramètre un Royaume
  //post : elle retourne un entier (>=0) correspondant au nombre total de carte du royaume correspondant
  func nbrCarte() -> Int{
    return self.cmp
  }
}

class MainIterator : IteratorProtocol {
    let main: Main
    var i : Int = 0

    init(main: Main) {
        self.main = main
    }

    func next() -> Carte? {
      let liste = self.main.getMain()
        if self.i < 0 || self.i >= self.main.getMain().count{
          return nil 
        }
        else {
          self.i = self.i+1
          return liste[self.i-1]
        }
    }
}

class Main : Sequence {
  //private var Carte : Carte
  //private var ItMain : ItMain
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
      throw ShouldNotHappenError.PremiereCartePasRoi
    }
  }
  
  //makeMainIterator : Main -> ItMain
  // Crée un itérateur sur les cartes de la main pour la parcourir (pas de contrainte sur l'ordre)
  func makeIterator() -> MainIterator {
    return MainIterator(main:self)
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
    for carte in self{
      if carte === c {
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
    return self.liste.count
  }

  //getCarteMain : Main x String -> (Carte|Vide)
  // cette fonction permet à partir d'une main, et d'un nom de carte, de connaitre la carte associée.
  //pre : Elle prend en entrée une Main et un String, pouvant n'être que parmi Archer, Garde, Soldat, Roi1, Roi2
  //post : Elle renvoie la Carte associé au nom et à la Main s'il n'y en a pas dans la main ou que c'est un autre String, renvoie Vide
  func getCarteMain(nomDeLaCarte : String) -> Carte? {
    var carteMain : Carte? = nil
    if nomDeLaCarte == "Archer" || nomDeLaCarte == "Garde" || nomDeLaCarte == "Soldat" || nomDeLaCarte == "Roi1" || nomDeLaCarte == "Roi2" {
      for carte in self {
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
      for carte in self {
        if carte === c {
          self.liste.remove(at: i)
        }
        i=i+1
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
      throw ShouldNotHappenError.MainDejaPleine
    }
  }
}

class Pioche {
  private var liste : [Carte]

  // init : -> Pioche
  // cette fonction permet d'initialiser la pioche, la pioche ne doit pas contenir de Roi. La pioche au départ a 20 cartes dont 9 soldats, 6 gardes, 5 archers, par défaut la pioche est crée avec 20 éléments.
  // pre : Ne prend rien en paramètre
  //post : Elle doit renvoyer la pioche, avec toutes les cartes sauf les rois, réparties de manière aléatoire.
  init() {
    var listeCarte : [Carte] = []//liste intermédiaire aidant à l'initialisation de la pioche
    self.liste = []
    for _ in 0...8 {
      var soldat : Carte 
      do{
        try soldat = Carte(nom : "Soldat")
        listeCarte.append(soldat)
      } catch {}

    }
    for _ in 0...5 {
      var garde : Carte 
      do{
        try garde = Carte(nom : "Garde")
        listeCarte.append(garde)
      } catch {}
    }

    for _ in 0...4 {
      var archer : Carte 
      do{
        try archer = Carte(nom : "Archer")
        listeCarte.append(archer)
      } catch {}
    }

    for i in 0...19 {
      //let randomIndex = Int(arc4random_uniform(UInt32(listeCarte.count))) //Permet de récupérer un index aléatoire de la listeCarte
      //self.liste.append(listeCarte[randomIndex]) //On ajoute dans la pioche une carte aléatoire
      self.liste.append(listeCarte[19-i])
      //listeCarte.remove(at: randomIndex) //on supprime la carte de la liste intermédiaire
      listeCarte.remove(at: 19-i)
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

        if versRoyaume {  //Met la carte piochée dans le royaume
          self.royaume.ajouterCarteRoyaume(carte : carteCourante)
        }
        else {    //Met la carte piochée dans la main 
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
          case "a1":
            positionMobiliser = "F1"
          case "a2":
            positionMobiliser = "F2"
          case "a3":
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


// Dans ce fichier vous trouverez les fonctions utilisées dans le main

// DEBUT // La mise en place du jeu
// miseEnPlace : String x Carte -> Joueur
// Initialise un joueur et ses cartes de départs
// pre : Le nom du joueur (String) et le Roi (Carte) qui lui sera attribué c'est à dire Roi1 ou Roi2
// post : Renvoie le joueur nouvellement créé
func miseEnPlace(nom : String, roi : Carte) throws -> Joueur {
  // Au cas ou ce n'est pas un roi en paramètre (très improbable !)
  if !roi.estRoi() { // cf : Carte -> ligne 100
    throw ShouldNotHappenError.ShouldBeKing
  }

  let joueur : Joueur = try! Joueur(nomDuJoueur : nom, roi : roi) // cf : Joueur -> ligne 16
  try! joueur.piocher(nbr : 3, versRoyaume : false) // cf : Joueur -> ligne 52
  try! joueur.piocher(nbr : 1, versRoyaume : true)

  print("Avant de commencer la partie,")
  let carteChoisie : Carte = try! choisirMain(joueur : joueur, aPlacerOu : "sur le front") // cf : bases -> ligne 17
  poserFront(joueur : joueur, carte : carteChoisie) // cf : bases -> ligne 48
  return joueur
}



// MILIEU // Un tour parmi tant d'autres
// tour : Joueur x Joueur -> (Bool,Joueur?)
// Cette fonction effectue le tour d'un des deux joueurs
// pre : 2 Joueurs, celui dont c'est le tour et son adversaire
// post : Un booléen pour dire si la partie est finie et un joueur (le vainqueur). Si vide et True, alors il y a match nul
func tour(joueur : Joueur, adversaire : Joueur) -> (Bool,Joueur?) {

  // Phase de préparation (redresser les cartes a lieu en fin de tour)
  try! joueur.piocher(nbr : 1, versRoyaume : false) // cf : Joueur -> ligne 52
  // Phase d'action
  let finDeLaPartie : Bool = try! action(j : joueur, a : adversaire) // cf : mainDetaille -> ligne 98
  // Phase de développement (que si le Roi n'est pas tombé où s'il n'y a pas eu d'effondrement)
  let m : Main = joueur.getMain() // cf : Joueur -> ligne 34
  if !m.estVide() && !finDeLaPartie { // cf : Main -> ligne 21
    var oui : Bool = false
    if m.estPleine() { // cf : Main -> ligne 27
      print("Ta main est pleine... Tu n'as donc pas le choix !\nIl faut démobiliser une de tes cartes dans ton Royaume")
      oui = true
    }
    else {
      var estReponse : Bool = false
      while !estReponse {
        print("Désires-tu démobiliser une carte de ta Main vers ton Royaume ? (oui/non)")
        let rep : String? = readLine()
        if let r=rep {
          if (r=="oui" || r=="o" || r=="OUI" || r=="Oui" || r=="ok" || r=="OK" || r=="Ok") {
            estReponse = true
            oui = true
          }
          else if (r=="non" || r=="n" || r=="NON" || r=="Non" || r=="Nop") {
            estReponse = true
          }
          else {
            print("Réponds par oui ou par non !")
          }
        }
        else {
          print("Oups, une erreur s'est glissée dans ta réponse...")
        }
      } // Arrêt : Réponse conforme
    }
    if oui {
      let c : Carte
      try! c = choisirMain(joueur : joueur, aPlacerOu : "dans le Royaume") // cf : bases -> ligne 17
      joueur.demobiliser(carte : c) // cf : Joueur -> ligne 64
    }
  }
  // Fin de tour
  let f : Front = adversaire.getFront() // cf : Joueur -> ligne 40
  f.reinit() // cf : Front -> ligne 39
  let p1 : Pioche = joueur.getPioche() // cf : Joueur -> ligne 28
  let p2 : Pioche = adversaire.getPioche()
  if finDeLaPartie || (p1.estVide() && p2.estVide()) {
    return (true, gagnant(j : joueur, a : adversaire)) // cf : mainDetaille -> ligne 290
  }
  return (false, nil)
}


// ZOOM SUR LA PHASE D'ACTION DU TOUR //
// action : Joueur x Joueur -> Bool
// Cette fonction fait partie du tour, elle représente la phase action
// pre : Un joueur et son adversaire (Joueur)
// post : un bool qui indique si la phase d'action a entrainé la fin de la partie
func action(j : Joueur, a : Joueur) throws -> Bool {
  print("Tu peux choisir entre les 3 actions suivantes :")
  print("1 : Dépoyer une unité de ta main sur le front")
  print("2 : Attaquer une fois ou plus ton adversaire")
  print("3 : Ne rien faire")
  var finDeLaPartie : Bool = false
  var estReponse : Bool = false

  print("Ecris le chiffre correspondant à ton choix (1, 2 ou 3)")
  var rep : String? = readLine()
  if let r=rep {
      if (r=="1" || r=="2" || r=="3" || r=="un" || r=="deux" || r=="trois") {
        estReponse = true
      }
      else {
        print("\(r) n'est pas une réponse correcte !")
      }
    }
  else {
      print("Oups, une erreur s'est glissée dans ta réponse...")
  }
  while !estReponse {
    print("Ecris le chiffre correspondant à ton choix (1, 2 ou 3)")
    rep = readLine()
    if let r=rep {
      if (r=="1" || r=="2" || r=="3" || r=="un" || r=="deux" || r=="trois") {
        estReponse = true
      }
      else {
        print("\(r) n'est pas une réponse correcte !")
      }
    }
    else {
      print("Oups, une erreur s'est glissée dans ta réponse...")
    }
  } // Arrêt : Réponse conforme
  let r = rep!
  // 1 - Poser une carte de la main sur le front
  if r=="1" || r=="un" {
    let c : Carte  
    try! c = choisirMain(joueur : j, aPlacerOu : "sur le front") // cf : bases -> ligne 17
    poserFront(joueur : j, carte : c) // cf : bases -> ligne 48
  }

  // 2 - Attaquer
  else if r=="2" || r=="deux" {
    var veutAttaquer : Bool = true
    while veutAttaquer && !finDeLaPartie {
      afficherFrontAdverse(a : a) // cf : bases -> 224
      afficherFrontStat(j : j) // cf : bases -> 152
      // Choix de l'attaquant
      let f1 : Front = j.getFront()
      let f2 : Front = a.getFront()
      estReponse = false
      print("Choisis la position et donc la carte avec laquelle tu désires attaquer (A1,f2...)")
      rep = readLine()
      if let r1=rep {
        if estPosition(p :r1) { // cf : bases -> ligne 139
          let caseVide : Bool = try! f1.estCaseVide(pos :r1) // cf : Front -> ligne 33
          if !caseVide {
            guard let c1 : Carte = f1.getCarteFront(position : r1) else {throw ShouldNotHappenError.IsNotPosition} // cf : Front -> ligne 51
            if f2.peutAttaquer(c : c1, positionC : r1) { // cf : Front -> ligne 45
              estReponse = true
            }
            else {
              print("Malheureusement, cette carte n'a aucun ennemi à sa portée... Change de stratégie !")
            }
          }
          else {
            print("Malheureusement cette position est vide... Change de stratégie")
          }
        }
        else {
          print(" ")
          print(" n'est pas une position correcte ou occupée !")
        }
      }
      while !estReponse {
        print("Choisis la position et donc la carte avec laquelle tu désires attaquer (A1,f2...)")
        rep = readLine()
        if let r1=rep {
          if estPosition(p :r1) { // cf : bases -> ligne 139
            let caseVide : Bool = try! f1.estCaseVide(pos :r1) // cf : Front -> ligne 33
            if !caseVide {
              guard let c1 : Carte = f1.getCarteFront(position : r1) else {throw ShouldNotHappenError.IsNotPosition} // cf : Front -> ligne 51
              if f2.peutAttaquer(c : c1, positionC : r1) { // cf : Front -> ligne 45
                estReponse = true
              }
              else {
                print("Malheureusement, cette carte n'a aucun ennemi à sa portée... Change de stratégie !")
              }
            }
            else {
              print("Malheureusement cette position est vide... Change de stratégie")
            }
          }
          else {
            print(" ")
            print(" n'est pas une position correcte ou occupée !")
          }
        }
        else {
          print("Oups, une erreur s'est glissée dans ta réponse...")
        }
      } // Arrêt : Réponse conforme et ennemi à portée de tir
      let r1 = rep!
      let c1 = f1.getCarteFront(position : r1)!
      afficherPortee(c : c1, pos : r1, a : a) // cf : bases -> 295
      // Choix de la cible
      estReponse = false
      print("Choisis la position et donc la carte que tu désires attaquer (A1,f2...)")
      var rep2 = readLine()
      if let r2 = rep2 {
        if estPosition(p :r2) {
          let caseVide : Bool = try! f2.estCaseVide(pos :r2)
          if !caseVide {
            guard let c2 : Carte = f2.getCarteFront(position : r2) else {throw ShouldNotHappenError.IsNotPosition}
            if c2.estaSaPortee(positionC : r1, positionCible : r2) { // cf : Carte -> ligne 106
              estReponse = true
            }
            else {
              print("Malheureusement, cette carte n'est pas à ta portée... Change de stratégie !")
            }
          }
          else {
            print("Malheureusement cette position est vide... Change de stratégie")
          }
        }
        else {
          print("\(r) n'est pas une position correcte ou occupée !")
        }
      }
      else {
        print("Oups, une erreur s'est glissée dans ta réponse...")
      }
      while !estReponse {
        print("Choisis la position et donc la carte que tu désires attaquer (A1,f2...)")
        rep2 = readLine()
        if let r2 = rep2 {
          if estPosition(p :r2) {
            let caseVide : Bool = try! f2.estCaseVide(pos :r2)
            if !caseVide {
              guard let c2 : Carte = f2.getCarteFront(position : r2) else {throw ShouldNotHappenError.IsNotPosition}
              if c2.estaSaPortee(positionC : r1, positionCible : r2) { // cf : Carte -> ligne 106
                estReponse = true
              }
              else {
                print("Malheureusement, cette carte n'est pas à ta portée... Change de stratégie !")
              }
            }
            else {
              print("Malheureusement cette position est vide... Change de stratégie")
            }
          }
          else {
            print("\(r) n'est pas une position correcte ou occupée !")
          }
        }
        else {
          print("Oups, une erreur s'est glissée dans ta réponse...")
        }
      } // Arrêt : Réponse conforme et ennemi à portée de tir
      let r2 = rep2!
      let c2 = f2.getCarteFront(position : r2)!
      // Phase d'attaque
      let RoiMort = attaquer(j : j, cAtt : c1, adv : a, cAdv : c2)
      finDeLaPartie = finDeLaPartie || RoiMort // cf : mainDetaille -> ligne 233
      // Potentielle phase de Conscription
      finDeLaPartie = try! finDeLaPartie || conscription(adv : a) // cf : mainDetaille -> ligne 257
      // Le joueur désire-t-il encore attaquer ?
      estReponse = false
      while !estReponse && !finDeLaPartie{
        print("Veux-tu encore attaquer ? (oui/non)")
        let rep3 : String? = readLine()
        if let r=rep3 {
          if (r=="oui" || r=="o" || r=="OUI" || r=="Oui" || r=="ok" || r=="OK" || r=="Ok") {
            estReponse = true
          }
          else if (r=="non" || r=="n" || r=="NON" || r=="Non" || r=="Nop") {
            estReponse = true
            veutAttaquer = false
          }
          else {
            print("Réponds par oui ou par non !")
          }
        }
        else {
          print("Oups, une erreur s'est glissée dans ta réponse...")
        }
      } // Arrêt : Réponse conforme
    } // Arrêt : Ne veut plus attaquer ou la fin de la partie est imminente
  }
  return finDeLaPartie
}


// ZOOM SUR L'ATTAQUE DURANT LA PHASE D'ACTION //
// attaquer : Joueur x Carte x Joueur x Carte -> Bool
// Cette fonction matérialise l'attaque entre deux cartes
// pre : Un joueur ainsi que la carte avec laquelle il attaque et son adversaire avec  la carte ciblée
// post : Si false, RAS, si true la fin de la partie est imminente car le roi est mort ou capturé
func attaquer(j : Joueur, cAtt : Carte, adv : Joueur, cAdv : Carte) -> Bool {
  let f2 : Front = adv.getFront() // cf : Joueur -> ligne 40
  let m1 : Main = j.getMain() // cf : Joueur -> ligne 34
  var pbl : Bool = cAdv.estRoi() // cf : Carte -> ligne 100
  if cAtt.getAtt(main : m1) == cAdv.getDef() && cAdv.getDeg() == 0 { // cf : Carte -> lignes 46, 64 et 76
    j.capturer(adversaire : adv, carte : cAdv) // cf : Joueur -> ligne 70
  }
  else if cAtt.getAtt(main : m1) + cAdv.getDeg() >= cAdv.getDef() {
    f2.supprimerCarteFront(carte : cAdv) // cf : Front -> ligne 57
  }
  else {
    pbl=false
    try! cAdv.setDeg(nbr : cAtt.getAtt(main : m1) + cAdv.getDeg()) // cf : Carte -> ligne 82
  }
  return pbl
}


// ZOOM SUR LA CONSCRIPTION DURANT LA PHASE D'ACTION //
// conscription : Joueur -> Bool
// Si nécessaire, effectue une conscription, autrement dit, il n'y a plus de carte sur le front donc on en prend une du Royuame ou à défaut, de la main.
// pre : Un joueur pour lequel il faut vérifier le Front
// post : false si RAS, true s'il y a effondrement
func conscription(adv : Joueur) throws -> Bool {
  let f : Front = adv.getFront()                                // cf : Joueur -> ligne 40
  let m : Main = adv.getMain()                                  // cf : Joueur -> ligne 34
  if f.estVide() {                                              // cf : Front  -> ligne 27
    print("Il a conscription chez \(adv.getNom())")             // cf : Joueur -> ligne 22
    let r : Royaume = adv.getRoyaume()                          // cf : Joueur -> ligne 46
    if !r.estVide() {                                           // cf : Royaume-> ligne 14
      print("Voici la carte que tu as tiré de ton Royaume")
      guard let c : Carte = r.tirerCarte() else {throw ShouldNotHappenError.KingdomIsEmpty}
      //                                                        // cf : Royaume-> ligne 20
      afficherStat(c : c, main : m)                                       // cf : bases  -> ligne 385
      poserFront(joueur : adv)                                  // cf : bases  -> ligne 48
    }
    else if !m.estVide() {                                      // cf : Main   -> ligne 21
      print("Tu n'as plus de carte dans ton Royaume...")
      let c : Carte 
      try c = choisirMain(joueur : adv, aPlacerOu : "sur le front") // cf : bases -> ligne 17
      poserFront(joueur : adv, carte : c)
    }
    else { // Il y a effondrement
      print("Tu n'as plus de carte ni dans ton Royaume ni dans ta Main...")
      return true
    }
  }
  return false
}



// FIN // A la fin de la partie on détermine le gagnant s'il y'en a un
// gagnant : Joueur x Joueur -> Joueur?
// Cette fonction renvoie le gagnant de la partie
// pre : Le joueur (Joueur) dont c'est le tour et son adversaire (Joueur)
// post : Renvoie le gagnant, si match nul renvoie Vide
func gagnant(j: Joueur, a : Joueur) -> Joueur? {
  print("Mais... Que se passe-t-il ?\nSerait-ce la fin de la partie ?!")

  // Cas de l'effondrement
  let f2 : Front = a.getFront()
  let r2 : Royaume = a.getRoyaume()
  let m2 : Main = a.getMain()
  if f2.estVide() && r2.estVide() && m2.estVide() {
    print("Il y a effondrement !")
    return j
  }

  // Cas des pioches vide
  let p1 : Pioche = j.getPioche()
  let p2 : Pioche = a.getPioche()
  if p1.estVide() && p2.estVide() {
    print("Vous êtes respectivement arrivés au bout de vos pioches, c'est la fin de la guerre.")
    print("Le gagnant est donc celui qui a le plus de citoyens dans son Royaume.")
    let r1 : Royaume = j.getRoyaume()
    let r2 : Royaume = a.getRoyaume()
    if r1.nbrCarte() > r2.nbrCarte() { // cf : Royaume -> ligne 38
      print("Avec \(r1.nbrCarte()) cartes,")
      return j
    }
    else if r2.nbrCarte() > r1.nbrCarte() {
      print("Avec \(r2.nbrCarte()) cartes,")
      return a
    }
    else { // Autant de citoyens dans chaque Royaume donc égalité
      return nil
    }
  }

  // Cas du Roi capturé ou envoyé au cimetière
  print("Il y a eu exécution !")
  return j
}



// RÉPERTOIRE DE FONCTIONS UTILES TOUT AU LONG DU MAIN //
// choisirMain : Joueur x String -> Carte
// Permet de sélectionner une carte de la main d'un joueur
// pre : Un joueur et le lieu où terminera la carte plus tard (uniquement pour interagir avec le joueur)
// post : une carte de la main du joueur (le cas vide n'est pas censer arriver)
func choisirMain(joueur : Joueur, aPlacerOu : String) throws -> Carte {
  var mauvaiseCarte : Bool = true
  let main : Main = joueur.getMain()
  print("Voici ta main actuelle " + joueur.getNom())
  for carte in joueur.getMain() { // cf : Joueur -> ligne 34
    afficherStat(c : carte, main : main) // cf : bases -> ligne 384
  }
  print("Désigne la carte que tu désires placer " + aPlacerOu + " par son nom")
  var carte : String? = readLine()
  if let c = carte {
    for carte1 in main{
      if carte1.getNom() == c{
        mauvaiseCarte = false
      }
    }
    if mauvaiseCarte {
      print("Désigne une carte qui est dans ta main !")
    }
  }
  else {
    print("Oups, une erreur s'est glissée dans ta réponse...")
  }
  while mauvaiseCarte {
    print("Voici ta main actuelle " + joueur.getNom())
    for carte in joueur.getMain() { // cf : Joueur -> ligne 34
      afficherStat(c : carte, main : main) // cf : bases -> ligne 384
    }
    print("Désigne la carte que tu désires placer " + aPlacerOu + " par son nom")
    carte = readLine()
    if let c = carte {
      for carte1 in main{
        if carte1.getNom() == c{
          mauvaiseCarte = false
        }
      }
      if mauvaiseCarte {
        print("Désigne une carte qui est dans ta main !")
      }
    }
    else {
      print("Oups, une erreur s'est glissée dans ta réponse...")
    }
  } // Arrêt : Carte valide et dans la main
  let c = carte!
  guard let c2 : Carte = main.getCarteMain(nomDeLaCarte : c) else {throw ShouldNotHappenError.MustBeInHand} // cf : Main -> ligne 45
  return c2
}



// poserFront : Joueur x Carte? ->
// Permet de poser une carte depuis la main (ou depuis le royaume si aucune carte fournie) vers une position précise du front
// Pre : Un joueur ainsi que l'une de ses cartes. Cas spécial : Si pas de carte, cela signifie qu'il faut la prendre du royaume
// Post :
func poserFront(joueur : Joueur, carte : Carte? = nil) {
  let f : Front = joueur.getFront() // cf : Joueur -> ligne 40
  var f1 : String = " "
  var f2 : String = " "
  var f3 : String = " "
  var a1 : String = " "
  var a2 : String = " "
  var a3 : String = " "
  // On récupère le front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 51
    f1 = F1.getNom() // cf : Carte -> ligne 40
  }
  else {
    f1 = "     Libre     "
  }

  if let F2 = f.getCarteFront(position : "f2") {
    f2 = F2.getNom()
  }
  else {
    f2 = "     Libre     "
  }

  if let F3 = f.getCarteFront(position : "f3") {
    f3 = F3.getNom()
  }
  else {
    f3 = "     Libre     "
  }


  if let A1 = f.getCarteFront(position : "a1") {
    a1 = A1.getNom()
  }
  else if f.estLibre(position : "a1") { // cf : Front -> ligne 21
    a1 = "     Libre     "
  }
  else {
    a1 = "Non mobilisable"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    a2 = A2.getNom()
  }
  else if f.estLibre(position : "a2") {
    a2 = "     Libre     "
  }
  else {
    a2 = "Non mobilisable"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    a3 = A3.getNom()
  }
  else if f.estLibre(position : "a3") {
    a3 = "     Libre     "
  }
  else {
    a3 = "Non mobilisable"
  }

  // On affiche le Front
  print("Voici ton front actuel :")
  print("F1 :" + f1 + "| F2 :" + f2 + "| F3 :" + f3)
  print("A1 :" + a1 + "| A2 :" + a2 + "| A3 :" + a3)

  // On demande où placer la carte
  var mauvaisePos : Bool = true

  print("En quelle position souhaites-tu placer ta carte ? (F1, a3...)")
  let pos : String? = readLine()
  if let p : String = pos {
    if estPosition(p : p) && f.estLibre(position : p) { // cf : bases -> ligne 139
      mauvaisePos = false
    }
    else if estPosition(p : p) {
      print("Cette position n'est pas libre...")
    }
    else {
      print("Indique une position valide !")
    }
  }
  else {
    print("Oups, une erreur s'est glissée dans ta réponse...")
  }
  while mauvaisePos {
    print("En quelle position souhaites-tu placer ta carte ? (F1, a3...)")
    let pos : String? = readLine()
    if let p : String = pos {
      if estPosition(p : p) && f.estLibre(position : p) { // cf : bases -> ligne 139
        mauvaisePos = false
      }
      else if estPosition(p : p) {
        print("Cette position n'est pas libre...")
      }
      else {
        print("Indique une position valide !")
      }
    }
    else {
      print("Oups, une erreur s'est glissée dans ta réponse...")
    }
  } // Arrêt : Position donnée et libre
  let p = pos!
  // On déplace la carte
  try! joueur.mobiliser(carte : carte, position : p) // cf : Joueur -> ligne 58
}



// estPosition : String -> Bool
// Permet d'identifier une position valide f1,f2,f3,a1,a2,a3 la casse n'important pas
// pre : un string
// post : Si oui renvoie true, sinon false
func estPosition(p : String) -> Bool {
  if p=="f1" || p=="f2" || p=="f3" || p=="a1" || p=="a2" || p=="a3" || p=="F1" || p=="F2" || p=="F3" || p=="A1" || p=="A2" || p=="A3" {
    return true
  }
  return false
}



// afficherFrontStat : Joueur ->
// Cette fonction affiche à l'écran le front d'un joueur dans le contexte de l'action
// pre : un joueur pour retrouver son Front
// post : rien
func afficherFrontStat(j : Joueur) {
  let f : Front = j.getFront() // cf : Joueur -> ligne 40
  let main : Main = j.getMain() // cf : Joueur -> ligne 34
  var f1 : String = " "
  var f2 : String = " "
  var f3 : String = " "
  var a1 : String = " "
  var a2 : String = " "
  var a3 : String = " "

  // On récupère les cartes du front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 51
    f1 = F1.getNom() // cf : Carte -> ligne 40
    f1 += " : Att="
    f1 += String(F1.getAtt(main : main)) // cf : Carte -> ligne 46
  }
  else {
    f1 = "     Vide     "
  }

  if let F2 = f.getCarteFront(position : "f2") {
    f2 = F2.getNom()
    f2 += " : Att="
    f2 += String(F2.getAtt(main : main))
  }
  else {
    f2 = "     Vide     "
  }

  if let F3 = f.getCarteFront(position : "f3") {
    f3 = F3.getNom()
    f3 += " : Att="
    f3 += String(F3.getAtt(main : main))
  }
  else {
    f3 = "     Vide     "
  }


  if let A1 = f.getCarteFront(position : "a1") {
    a1 = A1.getNom()
    a1 += " : Att="
    a1 += String(A1.getAtt(main : main))
  }
  else {
    a1 = "     Vide     "
  }

  if let A2 = f.getCarteFront(position : "a2") {
    a2 = A2.getNom()
    a2 += " : Att="
    a2 += String(A2.getAtt(main : main))
  }
  else {
    a2 = "     Vide     "
  }

  if let A3 = f.getCarteFront(position : "a3") {
    a3 = A3.getNom()
    a3 += " : Att="
    a3 += String(A3.getAtt(main : main))
  }
  else {
    a3 = "     Vide     "
  }

  // On affiche le Front
  print (" ")
  print("Voici ton front actuel :")
  print("F1 :" + f1 + "| F2 :" + f2 + "| F3 :" + f3)
  print("A1 :" + a1 + "| A2 :" + a2 + "| A3 :" + a3)
}



// afficherFrontAdverse : Joueur ->
// Cette fonction affiche à l'écran le front comme un miroir (vu en tant qu'adversaire)
// pre : un joueur pour retrouver son Front
// post : rien
func afficherFrontAdverse(a : Joueur) {
  let f : Front = a.getFront() // cf : Joueur -> ligne 40
  var f1 : String = " "
  var f2 : String = " "
  var f3 : String = " "
  var a1 : String = " "
  var a2 : String = " "
  var a3 : String = " "
  // On récupère les cartes du front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 44
    f1 = F1.getNom() // cf : Carte -> ligne 40
    f1 += " : Def="
    f1 += String(F1.getDef()-F1.getDeg()) // cf : Carte -> ligne 64
  }
  else {
    f1 = "     Vide     "
  }

  if let F2 = f.getCarteFront(position : "f2") {
    f2 = F2.getNom()
    f2 += " : Def="
    f2 += String(F2.getDef()-F2.getDeg())
  }
  else {
    f2 =  "     Vide     "
  }

  if let F3 = f.getCarteFront(position : "f3") {
    f3 = F3.getNom()
    f3 += " : Def="
    f3 += String(F3.getDef()-F3.getDeg())
  }
  else {
    f3 =  "     Vide     "
  }


  if let A1 = f.getCarteFront(position : "a1") {
    a1 = A1.getNom()
    a1 += " : Def="
    a1 += String(A1.getDef()-A1.getDeg())
  }
  else {
    a1  =  "     Vide     "
  }

  if let A2 = f.getCarteFront(position : "a2") {
    a2 = A2.getNom()
    a2 += " : Def="
    a2 += String(A2.getDef()-A2.getDeg())
  }
  else {
    a2 =  "     Vide     "
  }

  if let A3 = f.getCarteFront(position : "a3") {
    a3 = A3.getNom()
    a3 += " : Def="
    a3 += String(A3.getDef()-A3.getDeg())
  }
  else {
    a3 =  "     Vide     "
  }

  // On affiche le Front
  print("Voici le front actuel de ton adversaire:")
  print("A3 :" + a3 + "| A2 :" + a2 + "| A1 :" + a1)
  print("F3 :" + f3 + "| F2 :" + f2 + "| F1 :" + f1)
}



// afficherPortée : Joueur ->
// Cette fonction affiche à l'écran le front adverse en précisant les positions atteignables
// pre : une carte (Carte) pour savoir ce qu'elle peut atteindre, sa position (String) car sa portée est relative et le joueur  adverse (Joueur) pour retrouver son front
// post : rien
func afficherPortee(c : Carte, pos : String, a : Joueur) {
  let f : Front = a.getFront()
  var f1 : String = " "
  var f2 : String = " "
  var f3 : String = " "
  var a1 : String = " "
  var a2 : String = " "
  var a3 : String = " "
  // On récupère les cartes du front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 51
    f1 = F1.getNom() // cf : Carte -> ligne 40
    if c.estaSaPortee(positionC : pos, positionCible : "F1") { // cf : Carte -> ligne 106
      f1 += " : Cible Potentielle"
    }
    else {
      f1 += " : Hors de Portée"
    }
  }
  else {
    f1 = "Vide"
  }

  if let F2 = f.getCarteFront(position : "f2") {
    f2 = F2.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "F2") {
      f2 += " : Cible Potentielle"
    }
    else {
      f2 += " : Hors de Portée"
    }
  }
  else {
    f2 = "Vide"
  }

  if let F3 = f.getCarteFront(position : "f3") {
    f3 = F3.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "F3") {
      f3 += " : Cible Potentielle"
    }
    else {
      f3 += " : Hors de Portée"
    }
  }
  else {
    f3 = "Vide"
  }


  if let A1 = f.getCarteFront(position : "a1") {
    a1 = A1.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "A1") {
      a1 += " : Cible Potentielle"
    }
    else {
      a1 += " : Hors de Portée"
    }
  }
  else {
    a1 = "Vide"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    a2 = A2.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "A2") {
      a2 += " : Cible Potentielle"
    }
    else {
      a2 += " : Hors de Portée"
    }
  }
  else {
    a2 = "Vide"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    a3 = A3.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "A3") {
      a3 += " : Cible Potentielle"
    }
    else {
      a3 += " : Hors de Portée"
    }
  }
  else {
    a3 = "Vide"
  }

  // On affiche le Front
  print("Voici le front actuel de l'adversaire:")
  print("A1 :" + a1 + "| A2 :" + a2 + "| A3 :" + a3)
  print("F1 :" + f1 + "| F2 :" + f2 + "| F3 :" + f3)
}



// afficherStat : Carte ->
// Permet d'afficher les stats d'une carte en détail en attendant l'arrivée d'une représentation graphique
// pre : Une carte
// post : Rien
func afficherStat(c : Carte, main : Main) {
  let nom : String = c.getNom() // cf : Carte : ligne 40
  let att : Int = c.getAtt(main : main) // cf : Carte : ligne 46
  let defdef : Int = c.getDefDefensif() // cf : Carte : ligne 52
  let defoff : Int = c.getDefOffensif() // cf : Carte : ligne 58
  let portee : String = c.getPortee() // cf : Carte : ligne 70
  print("   \(nom)\nAttaque : \(att)\nDéfense en mode défensif : \(defdef)\nDéfense en mode offensif : \(defoff)\nPortée : \(portee)")
}



// import leNomDeVotrePackage
print("Bienvenue dans Art Of War !")

// MISE EN PLACE //
print("Pour démarrer cette partie, je vais avoir besoin de vos deux noms.")

// Joueur 1
var estReponse : Bool = false
print("Entrez le nom du premier joueur : ")
let rep1 : String? = readLine()
if let _ : String = rep1 {
  estReponse = true
}
else {
  print("Oups, une erreur s'est glissée dans votre réponse...")
}
while !estReponse {
  print("Entrez le nom du premier joueur : ")
  let rep1 : String? = readLine()
  if let _ : String = rep1 {
    estReponse = true
  }
  else {
    print("Oups, une erreur s'est glissée dans votre réponse...")
  }
} // Arrêt : Réponse donnée
let nom1 = rep1!
let roi1 : Carte = try! Carte(nom : "Roi1") // cf : Carte -> ligne 34
let joueur1 : Joueur = try! miseEnPlace(nom : nom1, roi : roi1) // cf : mainDetaille -> ligne 11
// Joueur 2
estReponse = false
print("Entrez le nom de l'autre joueur : ")
let rep2 : String? = readLine()
if let _ : String = rep2 {
  estReponse = true
}
else {
  print("Oups, une erreur s'est glissée dans votre réponse...")
}
while !estReponse {
  print("Entrez le nom de l'autre joueur : ")
  let rep2 : String? = readLine()
  if let _ : String = rep2 {
    estReponse = true
  }
  else {
    print("Oups, une erreur s'est glissée dans votre réponse...")
  }
} // Arrêt : Réponse donnée
let nom2 = rep2!
let roi2 : Carte = try! Carte(nom :"Roi2")
let joueur2 : Joueur = try! miseEnPlace(nom : nom2, roi : roi2)

print("Ravi de te revoir " + nom1 + " à moins que ce ne soit quelqu'un d'autre...")
print("J'ai pas la mémoire des visages !")
print("En tout cas, \(nom2) et toi allez vous affronter sur le Front.")
print("Vous piocherez des cartes que vous pourrez garder dans votre main.")
print("Charge à vous de les mobiliser au bon moment, ou bien d'en faire des citoyens dans votre royaume.")
print()
print("Ce qu'il faut retenir c'est que pour gagner il faut :")
print("Tuer ou capturer le Roi ennemi,")
print("Ou alors poussez votre ennemi dans ses derniers retranchements afin qu'il ne puisse plus faire de conscription,")
print("Ou enfin détenir plus de citoyens dans votre Royaume que votre adversaire si vous arrivez au bout de la pioche")
print()
print("Bref, je ne m'attarderais pas plus sur les règles. (Pensez à la pauvre personne qui doit les écrire !)")
print("Pour plus de précision, consultez la notice.")
print()
print("Il est temps de commencer. De manière totalement arbitraire et puisque tu me dis quelque chose, \(nom1) à toi l'honneur !")

// TOUR DES JOUEURS //
var joueur : Joueur = joueur1
var adversaire : Joueur = joueur2
var tmp : Joueur
var i : Int = 0
var resultat : (Bool, Joueur?) = (false, nil)
var finDeLaPartie : Bool = false

while !finDeLaPartie {
  if joueur === joueur1 {
    i+=1
  }
  print("\n\n\n")
  print("Tour \(i) : \(joueur.getNom())") // cf : Joueur -> ligne 22
  print()
  resultat = tour(joueur : joueur, adversaire : adversaire) // cf : mainDetaille -> ligne 33
  finDeLaPartie = resultat.0
  tmp=joueur
  joueur=adversaire
  adversaire=tmp
} // Arrêt : Partie Terminée
// ANNONCE DU VAINQUEUR //
if let vainqueur : Joueur = resultat.1 {
  print("La victoire reviens à \(vainqueur.getNom()), toutes mes félicitations !")
  print("Après l'important est de participer... Enfin... c'est bien une phrase de perdant !!!")
}
else {
  print("Il semblerait que vous avez le même nombre de citoyens. On peut donc déclarer un match nul !")
}
print("En espérant que vous ayez passez un bon moment !")
print("Art Of War et moi-même vous souhaitons une bonne continuation,")
print("A très bientôt !")
print("\n \n \n")
print("Crédits : Vincent VANBALBERGHE et Mathieu VEBER au codage, Takashi SAKAUE et Souya NAITO pour le jeu et Christophe FIORIO pour notre soudaine motivation à le coder !")


// Test Carte //
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

  init (nom : String)throws{
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

  func getNom () -> String {
    return self.nomC
  }

  func getAtt (main : Main) -> Int {
    if self.nomC != "Soldat" {
      return self.attaqueC
    }
    else {
      return main.nbrCarte()
    }
  }
  

  func getDefOffensif () -> Int{
    return self.defoffC
  }

  func getDefDefensif () -> Int{
    return self.defdefC
  }

  func getDef () -> Int{
    if self.modedef {
      return  self.getDefDefensif() 
    }
    else {
      return self.getDefOffensif()
    }
  }

  func getPortee () -> String{
    return self.porteeC
  }

  func getDeg () -> Int{
    return self.degatsubis
  }

  mutating func setDeg (nbr : Int) throws{
    guard let nbr>=0 else{
      throw ShouldNotHappenError.DegatNegatif
    }
    self.degatsubis = nbr
  }

  mutating func modeOffensif () {
    self.modedef = false
  }
  
  mutating func modeDefensif () {
    self.modedef = true
  }

  func estRoi () -> Bool{
    if (self.getNom() == "Roi1") || (self.getNom() == "Roi2"){
      return true
    }
    else{
      return false
    }
  }
  
  func estaSaportee (positionC : String, positionCible : String) -> Bool{
    var estok : Bool = false
    switch self.getNom() {
      case "Soldat":
        switch positionC {
          case "F1": 
            if positionCible == "F3" {
              estok = true
            }
          case "F2":
            if positionCible == "F2" {
              estok = true
            }
          case "F3":
            if positionCible == "F1" {
              estok = true
            }
        }
      case "Garde":
        switch positionC {
          case "F1": 
            if positionCible == "F3" {
              estok = true
            }
          case "F2":
            if positionCible == "F2" {
              estok = true
            }
          case "F3":
            if positionCible == "F1" {
              estok = true
            }
        }
      case "Archer":
        switch positionC {
          case "F1":
            if (positionCible == "A2") || (positionCible == "F1"){
              estok = true
            }
          case "F2":
            if (positionCible == "A1") || (positionCible == "A3"){
              estok = true
            }
          case "F3":
            if (positionCible == "A2") || (positionCible == "F3"){
              estok = true
            }
          case "A1":
            if (positionCible == "F2"){
              estok = true
            }
          case "A2":
            if (positionCible == "F3") || (positionCible == "F1"){
              estok = true
            }
          case "A3":
            if (positionCible == "F2"){
              estok = true
            }
        }
      case "Roi1":
        switch positionC {
          case "F1":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "A3") || (positionCible == "F1"){
              estok = true
            }
          case "F2":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1") || (positionCible == "A2"){
              estok = true
            }
          case "F3":
            if (positionCible == "F1") || (positionCible == "F2") || (positionCible == "A1") || (positionCible == "F3"){
              estok = true
            }
          case "A1":
            if (positionCible == "F3"){
              estok = true
            }
          case "A2":
            if (positionCible == "F2"){
              estok = true
            }
          case "A3":
            if (positionCible == "F1"){
              estok = true
            }
        }
      case "Roi2":
        switch positionC {
          case "F1":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1"){
              estok = true
            }
          case "F2":
            if (positionCible == "F3") || (positionCible == "F2") || (positionCible == "F1"){
              estok = true
            }
          case "F3":
            if (positionCible == "F1") || (positionCible == "F2") || (positionCible == "F3"){
              estok = true
            }
        }
    }
    return estok
  }
}

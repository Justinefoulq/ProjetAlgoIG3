// RÉPERTOIRE D'ERREURS //

// Attention : Ces erreurs ne peuvent pas arriver actuellement. Cependant, si le main est modifié, ces erreurs seront là pour éviter de faire n'importe quoi.
enum ShouldNotHappenError: Error {
    case ShouldBeKing
    case MustBeInHand
    case IsNotPosition
    case KingdomIsEmpty
}

// RÉPERTOIRE DE FONCTIONS UTILES TOUT AU LONG DU MAIN //

// choisirMain : Joueur x String -> Carte
// Permet de sélectionner une carte de la main d'un joueur
// pre : Un joueur et le lieu où terminera la carte plus tard (uniquement pour interagir avec le joueur)
// post : une carte de la main du joueur (le cas vide n'est pas censer arriver)
func choisirMain(joueur : Joueur, aPlacerOu : String) throws -> Carte {
  var mauvaiseCarte : Bool = True
  while mauvaiseCarte {
    print("Voici ta main actuelle "+nom)
    for carte in joueur.getMain() { // cf : Joueur -> ligne 34
      afficherStat(c : carte) // cf : bases -> ligne 384
    }
    var carte : String? = readLine("Désigne la carte que tu désires placer \(aPlacerOu) par son nom")
    if let c = carte {
      let main : Main = joueur.getMain()
      if main.estDansLaMain(c : c) { // cf : Main -> ligne 33
        mauvaiseCarte = false
      }
      else {
        print("Désigne une carte qui est dans ta main !")
      }
    }
    else {
      print("Oups, une erreur s'est glissée dans ta réponse...")
    }
  } // Arrêt : Carte valide et dans la main
  guard let c2 : Carte = getCarteMain(nomDeLaCarte : c) else {throw ShouldNotHappenError.MustBeInHand} // cf : Main -> ligne 45
  return c2
}



// poserFront : Joueur x Carte? ->
// Permet de poser une carte depuis la main (ou depuis le royaume si aucune carte fournie) vers une position précise du front
// Pre : Un joueur ainsi que l'une de ses cartes. Cas spécial : Si pas de carte, cela signifie qu'il faut la prendre du royaume
// Post :
func poserFront(joueur : Joueur, carte : Carte? = nil) {
  let f : Front = joueur.getFront() // cf : Joueur -> ligne 40

  // On récupère le front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 51
    let f1 : String = F1.getNom() // cf : Carte -> ligne 40
  }
  else {
    let f1 : String = "Libre"
  }

  if let F2 = f.getCarteFront(position : "f2") {
    let f2 : String = F2.getNom()
  }
  else {
    let f2 : String = "Libre"
  }

  if let F3 = f.getCarteFront(position : "f3") {
    let f3 : String = F3.getNom()
  }
  else {
    let f3 : String = "Libre"
  }


  if let A1 = f.getCarteFront(position : "a1") {
    let a1 : String = F1.getNom()
  }
  else if f.estLibre(position : "a1") { // cf : Front -> ligne 21
    let a1 : String = "Libre"
  }
  else {
    let a1 : String = "Non mobilisable"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    let a2 : String = A2.getNom()
  }
  else if f.estLibre(position : "a2") {
    let a2 : String = "Libre"
  }
  else {
    let a2 : String = "Non mobilisable"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    let a3 : String = A3.getNom()
  }
  else if f.estLibre(position : "a3") {
    let a3 : String = "Libre"
  }
  else {
    let a3 : String = "Non mobilisable"
  }

  // On affiche le Front
  print("Voici ton front actuel :")
  print("F1 : \(f1) | F2 : \(f2) | F3 : \(f3)")
  print("A1 : \(a1) | A2 : \(a2) | A3 : \(a3)")

  // On demande où placer la carte
  var mauvaisePos : Bool = false
  while mauvaisePos {
      let pos : String? = readLine("En quelle position souhaites-tu placer ta carte ? (F1, a3...)")
      if let p : String = pos {
        if estPosition(p : p) && f.estLibre(position : p) { // cf : bases -> ligne 139
          mauvaisePos = true
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

  // On déplace la carte
  try! joueur.mobiliser(carte : c, position : p) // cf : Joueur -> ligne 58
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
  let front : Front = j.getFront() // cf : Joueur -> ligne 40
  let main : Main = j.getMain() // cf : Joueur -> ligne 34

  // On récupère les cartes du front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 51
    var f1 : String = F1.getNom() // cf : Carte -> ligne 40
    f1 += " : Att="
    f1 += F1.getAtt(main : main) // cf : Carte -> ligne 46
  }
  else {
    let f1 : String = "Vide"
  }

  if let F2 = f.getCarteFront(position : "f2") {
    var f2 : String = F2.getNom()
    f2 += " : Att="
    f2 += F2.getAtt(main : main)
  }
  else {
    let f2 : String = "Vide"
  }

  if let F3 = f.getCarteFront(position : "f3") {
    var f3 : String = F3.getNom()
    f3 += " : Att="
    f3 += F3.getAtt(main : main)
  }
  else {
    let f3 : String = "Vide"
  }


  if let A1 = f.getCarteFront(position : "a1") {
    var a1 : String = F1.getNom()
    a1 += " : Att="
    a1 += A1.getAtt(main : main)
  }
  else {
    let a1 : String = "Vide"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    var a2 : String = A2.getNom()
    a2 += " : Att="
    a2 += A2.getAtt(main : main)
  }
  else {
    let a2 : String = "Vide"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    var a3 : String = A3.getNom()
    a3 += " : Att="
    a3 += A3.getAtt(main : main)
  }
  else {
    let a3 : String = "Vide"
  }

  // On affiche le Front
  print("Voici ton front actuel :")
  print("F1 : \(f1) | F2 : \(f2) | F3 : \(f3)")
  print("A1 : \(a1) | A2 : \(a2) | A3 : \(a3)")
}



// afficherFrontAdverse : Joueur ->
// Cette fonction affiche à l'écran le front comme un miroir (vu en tant qu'adversaire)
// pre : un joueur pour retrouver son Front
// post : rien
func afficherFrontAdverse(a : Joueur) {
  let front : Front = a.getFront() // cf : Joueur -> ligne 40

  // On récupère les cartes du front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 44
    var f1 : String = F1.getNom() // cf : Carte -> ligne 40
    f1 += " : Def="
    f1 += F1.getDef() // cf : Carte -> ligne 64
  }
  else {
    let f1 : String = "Vide"
  }

  if let F2 = f.getCarteFront(position : "f2") {
    var f2 : String = F2.getNom()
    f2 += " : Def="
    f2 += F2.getDef()
  }
  else {
    let f2 : String = "Vide"
  }

  if let F3 = f.getCarteFront(position : "f3") {
    var f3 : String = F3.getNom()
    f3 += " : Def="
    f3 += F3.getDef()
  }
  else {
    let f3 : String = "Vide"
  }


  if let A1 = f.getCarteFront(position : "a1") {
    var a1 : String = F1.getNom()
    a1 += " : Def="
    a1 += A1.getDef()
  }
  else {
    let a1 : String = "Vide"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    var a2 : String = A2.getNom()
    a2 += " : Def="
    a2 += A2.getDef()
  }
  else {
    let a2 : String = "Vide"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    var a3 : String = A3.getNom()
    a3 += " : Def="
    a3 += A3.getDef()
  }
  else {
    let a3 : String = "Vide"
  }

  // On affiche le Front
  print("Voici le front ennemi :")
  print("A1 : \(a3) | A2 : \(a2) | A3 : \(a1)")
  print("F1 : \(f3) | F2 : \(f2) | F3 : \(f1)")
}



// afficherPortée : Joueur ->
// Cette fonction affiche à l'écran le front adverse en précisant les positions atteignables
// pre : une carte (Carte) pour savoir ce qu'elle peut atteindre, sa position (String) car sa portée est relative et le joueur  adverse (Joueur) pour retrouver son front
// post : rien
func afficherPortee(c : Carte, pos : String, a : Joueur) {
  let front : Front = a.getFront()

  // On récupère les cartes du front
  if let F1 = f.getCarteFront(position : "f1") { // cf : Front -> ligne 51
    var f1 : String = F1.getNom() // cf : Carte -> ligne 40
    if c.estaSaPortee(positionC : pos, positionCible : "F1") { // cf : Carte -> ligne 106
      f1 += " : Cible Potentielle"
    }
    else {
      f1 += " : Hors de Portée"
    }
  }
  else {
    let f1 : String = "Vide"
  }

  if let F2 = f.getCarteFront(position : "f2") {
    var f2 : String = F2.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "F2") {
      f2 += " : Cible Potentielle"
    }
    else {
      f2 += " : Hors de Portée"
    }
  else {
    let f2 : String = "Vide"
  }

  if let F3 = f.getCarteFront(position : "f3") {
    var f3 : String = F3.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "F3") {
      f3 += " : Cible Potentielle"
    }
    else {
      f3 += " : Hors de Portée"
    }
  else {
    let f3 : String = "Vide"
  }


  if let A1 = f.getCarteFront(position : "a1") {
    var a1 : String = F1.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "A1") {
      a1 += " : Cible Potentielle"
    }
    else {
      a1 += " : Hors de Portée"
    }
  else {
    let a1 : String = "Vide"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    var a2 : String = A2.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "A2") {
      a2 += " : Cible Potentielle"
    }
    else {
      a2 += " : Hors de Portée"
    }
  else {
    let a2 : String = "Vide"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    var a3 : String = A3.getNom()
    if c.estaSaPortee(positionC : pos, positionCible : "A3") {
      a3 += " : Cible Potentielle"
    }
    else {
      a3 += " : Hors de Portée"
    }
  else {
    let a3 : String = "Vide"
  }

  // On affiche le Front
  print("Voici le front ennemi et la ou les position(s) à ta portée :")
  print("A1 : \(a3) | A2 : \(a2) | A3 : \(a1)")
  print("F1 : \(f3) | F2 : \(f2) | F3 : \(f1)")
}



// afficherStat : Carte ->
// Permet d'afficher les stats d'une carte en détail en attendant l'arrivée d'une représentation graphique
// pre : Une carte
// post : Rien
func afficherStat(c : Carte) {
  let nom : String = getNom() // cf : Carte : ligne 40
  let att : Int = getAtt() // cf : Carte : ligne 46
  let defdef : Int = getDefDefensif() // cf : Carte : ligne 52
  let defoff : Int = getDefOffensif() // cf : Carte : ligne 58
  let portee : Int = getPortee() // cf : Carte : ligne 70
  print("   \(nom)\nAttaque : \(att)\nDéfense en mode défensif : \(defdef)\nDéfense en mode offensif : \(defoff)\nPortée : \(portee)")
}

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
    f1 = "Vide"
  }

  if let F2 = f.getCarteFront(position : "f2") {
    f2 = F2.getNom()
    f2 += " : Att="
    f2 += String(F2.getAtt(main : main))
  }
  else {
    f2 = "Vide"
  }

  if let F3 = f.getCarteFront(position : "f3") {
    f3 = F3.getNom()
    f3 += " : Att="
    f3 += String(F3.getAtt(main : main))
  }
  else {
    f3 = "Vide"
  }


  if let A1 = f.getCarteFront(position : "a1") {
    a1 = A1.getNom()
    a1 += " : Att="
    a1 += String(A1.getAtt(main : main))
  }
  else {
    a1 = "Vide"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    a2 = A2.getNom()
    a2 += " : Att="
    a2 += String(A2.getAtt(main : main))
  }
  else {
    a2 = "Vide"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    a3 = A3.getNom()
    a3 += " : Att="
    a3 += String(A3.getAtt(main : main))
  }
  else {
    a3 = "Vide"
  }

  // On affiche le Front
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
    f1 += String(F1.getDef()) // cf : Carte -> ligne 64
  }
  else {
    f1 = "Vide"
  }

  if let F2 = f.getCarteFront(position : "f2") {
    f2 = F2.getNom()
    f2 += " : Def="
    f2 += String(F2.getDef())
  }
  else {
    f2 = "Vide"
  }

  if let F3 = f.getCarteFront(position : "f3") {
    f3 = F3.getNom()
    f3 += " : Def="
    f3 += String(F3.getDef())
  }
  else {
    f3 = "Vide"
  }


  if let A1 = f.getCarteFront(position : "a1") {
    a1 = A1.getNom()
    a1 += " : Def="
    a1 += String(A1.getDef())
  }
  else {
    a1  = "Vide"
  }

  if let A2 = f.getCarteFront(position : "a2") {
    a2 = A2.getNom()
    a2 += " : Def="
    a2 += String(A2.getDef())
  }
  else {
    a2 = "Vide"
  }

  if let A3 = f.getCarteFront(position : "a3") {
    a3 = A3.getNom()
    a3 += " : Def="
    a3 += String(A3.getDef())
  }
  else {
    a3 = "Vide"
  }

  // On affiche le Front
  print("Voici ton front actuel :")
  print("F1 :" + f1 + "| F2 :" + f2 + "| F3 :" + f3)
  print("A1 :" + a1 + "| A2 :" + a2 + "| A3 :" + a3)
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
  print("Voici ton front actuel :")
  print("F1 :" + f1 + "| F2 :" + f2 + "| F3 :" + f3)
  print("A1 :" + a1 + "| A2 :" + a2 + "| A3 :" + a3)
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


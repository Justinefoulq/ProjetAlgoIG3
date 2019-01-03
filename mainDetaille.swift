
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
  let rep : String? = readLine()
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
    let rep : String? = readLine()
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
      let rep : String? = readLine()
      if let r1=rep {
        if estPosition(p :r1) { // cf : bases -> ligne 139
          let caseVide : Bool = try! f1.estCaseVide(pos :r1) // cf : Front -> ligne 33
          if caseVide {
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
        let rep : String? = readLine()
        if let r1=rep {
          if estPosition(p :r1) { // cf : bases -> ligne 139
            let caseVide : Bool = try! f1.estCaseVide(pos :r1) // cf : Front -> ligne 33
            if caseVide {
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
      let rep2 : String? = readLine()
      if let r2 = rep2 {
        if estPosition(p :r2) {
          let caseVide : Bool = try! f2.estCaseVide(pos :r2)
          if caseVide {
            guard let c2 : Carte = f2.getCarteFront(position : r2) else {throw ShouldNotHappenError.IsNotPosition}
            if c2.estaSaPortee(positionC : r, positionCible : r2) { // cf : Carte -> ligne 106
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
        let rep2 : String? = readLine()
        if let r2 = rep2 {
          if estPosition(p :r2) {
            let caseVide : Bool = try! f2.estCaseVide(pos :r2)
            if caseVide {
              guard let c2 : Carte = f2.getCarteFront(position : r2) else {throw ShouldNotHappenError.IsNotPosition}
              if c2.estaSaPortee(positionC : r, positionCible : r2) { // cf : Carte -> ligne 106
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
      finDeLaPartie = finDeLaPartie || attaquer(j : j, cAtt : c1, adv : a, cAdv : c2) // cf : mainDetaille -> ligne 233
      // Potentielle phase de Conscription
      finDeLaPartie = try! finDeLaPartie || conscription(adv : a) // cf : mainDetaille -> ligne 257
      // Le joueur désire-t-il encore attaquer ?
      estReponse = false
      while !estReponse {
        print("Veux-tu encore attaquer ? (oui/non)")
        let rep : String? = readLine()
        if let r=rep {
          if (r=="oui" || r=="o" || r=="OUI" || r=="Oui" || r=="ok" || r=="OK" || r=="Ok") {
            estReponse = true
          }
          else if !(r=="non" || r=="n" || r=="NON" || r=="Non" || r=="Nop") {
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

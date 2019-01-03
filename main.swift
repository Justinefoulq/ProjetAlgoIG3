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


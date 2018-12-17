import Foundation

protocol MainProtocol : Sequence {
    associatedtype ItMain : IteratorProtocol
    associatedtype Carte : CarteProtocol
    
    // init : Carte -> Main
    // cette fonction permet de crée la Main, la main doit pouvoir contenir des cartes, et peut être vide, Elle ne contient que 6 cartes au maximum. Initialement, elle est crée avec une Carte dedans, celle rentrée en paramètre.
    // pre : Elle prend une Carte en paramètre (qui doit être un Roi sinon renvoie une ERREUR)
    // post : Elle renvoie une Main, contenant que cette Carte.
    init (roi : Carte) throws
    
    // makeMainIterator : Main -> ItMain
    // Crée un itérateur sur les cartes de la main pour la parcourir (pas de contrainte sur l'ordre)
    func makeItMain () -> ItMain
    
    // estVide : Main -> Bool
    // cette fonction doit permettre de savoir si la main demandée est complètement vide ou pas.
    // pre : Elle prend en paramètre une Main.
    // post : Elle renvoie True si la main est sans carte (Donc complètement Vide), False sinon.
    func estVide () -> Bool 
    
    //estPleine : Main -> Bool 
    // cette fonction doit permettre de savoir si la main considérée est pleine, c'est à dire qu'elle a atteint le nombre maximum autorisé de carte : 6 cartes.
    // pre : Elle prend en entrée une Main
    // post : Retourne True si elle est pleine (6 cartes), False sinon. 
    func estPleine () -> Bool

    //estDansLaMain : Main x Carte -> Bool
    // cette fonction doit permettre de savoir si une carte se trouve dans la main
    // pre : Prend en entrée une Carte
    // post : Renvoi un booléen, True si la carte est présente dans la main, False sinon.
    func estDansLaMain (c : Carte) -> Bool
    
    // nbrCarte : Main -> Int 
    // cette fonction permet de savoir le nombre de carte qu'il y a dans une Main.
    // pre : Elle prend une Main en entrée
    // post : renvoie un entier, correspondant au nombre de carte total de la Main (0<=i<=6).
    func nbrCarte () -> Int
    
    // getCarteMain : Main x String -> (Carte|Vide) 
    // cette fonction permet à partir d'une main, et d'un nom de carte, de connaitre la Carte associée.
    // pre : Elle prend en entrée une Main et un String, pouvant n'être que parmi Archer, Garde, Soldat, Roi1, Roi2
    // post : Elle renvoie la Carte associée au nom et à la Main s'il n'y en a pas dans la main ou que c'est un autre String, renvoie vide
    func getCarteMain (nomDeLaCarte : String) -> Carte? 
    
    // supprimerCarteMain : Main x Carte -> Main
    // cette fonction doit permettre de supprimer une Carte de la Main, s'il la main est vide, ne fait rien. Si la carte n'est pas dans la main, rien ne se passe.
    // pre : Prend en entrée une Carte, et la Main
    // post : Ne renvoie rien
    mutating func supprimerCarteMain (c : Carte)
    
    // ajouterCarteMain : Main x Carte -> Main
    // Cette fonction permet d'ajouter une carte dans la main, si la main est pleine renvoie une ERREUR.
    // pre : Prend en entrée une Carte, et la Main 
    // post : Ne renvoie rien
    mutating func ajouterCarteMain (c : Carte) throws
}

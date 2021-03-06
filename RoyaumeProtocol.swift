protocol RoyaumeProtocol {
    associatedtype Carte : CarteProtocol

    // init : -> Royaume
    // cette fonction initialise le royaume. Le royaume doit permettre de stocker des cartes, la première carte à rentrer dans le royaume doit être la première à sortir. Il n'a pas de taille maximum.
    // pre : 
    // post : Elle renvoie le royaume, vide.
    init () 
    
    // estVide : Royaume -> Bool
    // cette fonction doit permettre de savoir si le royaume considéré est sans unité ou pas (soit elle est complètement vide ou non).
    // pre : Elle prend en paramètre un Royaume.
    // post : Elle renvoie True si le Royaume est totalement vide, False sinon.
    func estVide () -> Bool 
    
    // tirerCarte : Royaume -> (Carte | Vide)
    // cette fonction permet de retirer une carte du Royaume, cette carte doit obligatoirement être la première carte à être rentrée dans le royaume parmi toute celles qui s'y trouvent.
    // pre : Elle prend un Royaume en paramètre
    // post : Elle renvoie la première carte à être rentrée dans le royaume s'il n'y en a plus, renvoie vide
    func tirerCarte () -> Carte? 
    
    // supprimerCarteRoyaume : Royaume -> Royaume
    // Cette fonction permet de supprimer la première carte à être rentrée dans le royaume parmi toutes celles qui s'y trouvent. S'il n'y en a plus, ne fais rien.
    // pre : Elle prend en entrée un Royaume.
    // post : Ne renvoie rien
    mutating func supprimerCarteRoyaume () 
    
    // ajouterCarteRoyaume : Carte x Royaume -> Royaume
    // Cette fonction permet de rajouter une Carte dans le Royaume
    // pre : Elle prend en entrée une Carte et un Royaume
    // post : Ne renvoie rien
    mutating func ajouterCarteRoyaume (carte : Carte) 
    
    // nbrCarte : Royaume -> Int
    // Cette fonction permet de savoir le nombre de carte du royaume du joueur demandé.
    // pre : elle prend en paramètre un Royaume
    // post : elle retourne un entier (>=0) correspondant au nombre total de carte du royaume correspondant.
    func nbrCarte () -> Int
}

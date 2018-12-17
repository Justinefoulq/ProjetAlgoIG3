protocol PiocheProtocol {
    associatedtype Carte : CarteProtocol

    // init :  -> Pioche
    // cette fonction permet d'initialiser la pioche, la pioche ne doit pas contenir de Roi. la pioche au départ a 20 cartes dont 9 soldats, 6 gardes, 5 archers, par défaut la pioche est créée avec 20 éléments.
    // pre : Ne prend rien en paramètre.
    // post : Elle doit renvoyer la pioche, avec toutes les cartes sauf les rois, réparties de manière aléatoire.
     init()
    
    // estVide : Pioche -> Bool
    // Cette fonction permet de savoir si la pioche est vide ou non.
    // pre : Elle prend en entrée une pioche
    // post : doit renvoyer un booléen, True si la pioche est vide, False sinon.
    func estVide () -> Bool
    
    // tirerCarte : Pioche -> (Carte | Vide)
    // cette fonction permet de tirer la carte au dessus la pioche.
    // pre : Elle prend en entrée une pioche
    // post : Elle renvoie une Carte et s'il n'y a plus de carte renvoie vide
    func tirerCarte () -> Carte?
    
    // supprimerCartePioche : Pioche -> Pioche
    // cette fonction permet de supprimer une carte dans la pioche. Si plus de carte, ne fais rien.
    // pre : Elle prend une Pioche en entrée
    // post : Ne renvoie rien
    mutating func supprimerCartePioche()
}

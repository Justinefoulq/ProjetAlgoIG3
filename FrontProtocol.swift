import Foundation

protocol FrontProtocol : Sequence {
    associatedtype ItFront : IteratorProtocol
    associatedtype Carte : CarteProtocol
    
    // init : -> Front
    // cette fonction permet de créer un front : le front est le champ de bataille, il se représente avec 6 cases, 3 en première ligne (devant) et 3 en seconde ligne (derrière), les cases de la première ligne sont nommés : F1,F2,F3 ou f1,f2,f3 et ceux de la deuxième ligne sont nommés : A1,A2,A3 ou a1,a2,a3 (c'est comme ça qu'on les appelles dans le main). Autrement dit la casse n'importe pas. Les cases doivent pouvoir etre de type Carte, ou Vide.
    // pre : 
    // post : Elle renvoie le front une fois initialisée, sans unité dessus, donc les cases seront vide
    init () 
    
    // makeItFront : Front -> ItFront
    // Crée un itérateur sur les cartes du front pour le parcourir dans l'ordre F1,F2,F3,A1,A2,A3
    func makeItFront() -> ItFront
    
    // estLibre : String x Front -> Bool
    // Cette fonction permet de savoir si la case selectionnée est valide : sans unité placée dessus, Si jamais la case demandée est en seconde ligne (parmi les A ou a) il faut vérifier qu'il y ait bien une unité sur la case F ou f correspondant. 
    // pre : Elle prend en paramètre une case du front (parmi : F1,F2,F3,A1,A2,A3,f1,f2,f3,a1,a2,a3), un Front. (Rappel : F1=f1...)
    // elle retourne Un booléen, True si la case est disponible, False sinon. Si la position n'existe pas renvoie false aussi.
    func estLibre(position : String) -> Bool 
    
    // estVide : Front -> Bool
    // cette fonction doit permettre de savoir si le front demandé est complètement vide ou pas (Toutes les cases sont sans unité donc vide)
    // pre : Elle prend en paramètre un Front.
    // post : Elle renvoit True si le front est totalement vide, False sinon.
    func estVide () -> Bool

    // estCaseVide : Front x String-> Bool
    // cette fonction doit permettre de savoir si la case du front fourni est complètement vide ou pas
    // pre : Elle prend en paramètre un Front et un String correspondant à une position (F1,a2...).
    // post : Elle renvoit True si la case sur le front est vide, False sinon. Renvoie une ERREUR si la position n'existe pas.
    func estCaseVide (pos : String) throws -> Bool
    
    // reinit : Front -> Front
    // Cette fonction permet de remettre à zero les dégats subis, et de passer en mode défensif toutes les cartes du front 
    // pre : Elle prend en entrée un Front.
    // post : Ne renvoie rien
    mutating func reinit ()
    
    // peutAttaquer : Front x Carte x String -> Bool
    // cette fonction doit permettre de savoir la Carte demandée, à la position renseignée à au moins une cible à sa portée. il faut donc regarder toutes les positions du front adverse avec la fonction estaSaPortee.
    // pre : prend en entrée une Carte, sa position.
    // post : renvoi un booléen, True si la Carte peut attaquer au moins une autre cible, False sinon.
    func peutAttaquer (c : Carte, positionC : String) -> Bool 
    
    // getCarteFront : Front x String -> (Carte | Vide)
    // Cette fonction permet a partir d'une position sur le Front de savoir la carte qui s'y trouve.
    // pre : Elle prend en entrée un Front, et une position de ce Front.
    // post : Elle renvoie la carte associée à cette position du Front. Si il n'y a pas de carte à cet emplacement, renvoie Vide.
    func getCarteFront (position : String) -> Carte?
    
    // supprimerCarteFront : Front x Carte -> Front
    // Cette ingénieuse fonction doit supprimer la carte renseignée du Front indiqué. La case correspondante sera donc Vide
    // pre : Elle prend en entrée un Front, et une Carte de ce Front (Attention, plusieurs position peuvent contenir la même carte... Utiliser "===" !). Si la carte n'est pas sur le front, rien ne se passe.
    // post : Ne renvoie rien
    mutating func supprimerCarteFront (carte : Carte)
    
    // ajouterCarteFront : Front x String x Carte -> Front
    // Cette fonction permet d'ajouter une Carte sur la position du Front souhaitée.
    // pre : Elle prend en entrée un Front, une position de ce Front, et une Carte
    // post : Si la position n'existe pas, renvoie une ERREUR, si la position contient déjà une carte, on met la nouvelle.
    mutating func ajouterCarteFront (position : String, carte : Carte) throws
}

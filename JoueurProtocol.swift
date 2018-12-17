import Foundation

// Comme mis en évidence ci-dessous, voici les nom de types qu'il faudra utiliser. De la même manière, le nom du type qui implémentera JoueurProtocol sera Joueur.

protocol JoueurProtocol {
    associatedtype Main : MainProtocol
    associatedtype Front : FrontProtocol
    associatedtype Carte : CarteProtocol
    associatedtype Pioche : PiocheProtocol
    associatedtype Royaume : RoyaumeProtocol

    // init : String x Carte -> Joueur
    // Cette fonction crée un Joueur, le joueur doit avoir un Nom (renseigné), et les propriétés suivantes : Pioche / Main(Carte) / Royaume / Front 
    // pre : Elle prend en entrée un nom de joueur, et une Carte (Roi1 ou Roi2 uniquement sinon ERREUR)
    // post : Renvoi le joueur crée
    init (nomDuJoueur : String, roi : Carte) throws
    
    // getNom : Joueur -> String
    // Renvoie le nom associé au joueur
    // pre : Joueur
    // post : nom du joueur
    func getNom() -> String
    
    // getPioche : Joueur -> Pioche
    // Renvoie la pioche associée au joueur
    // pre : Joueur
    // post : pioche du joueur
    func getPioche() -> Pioche
    
    // getMain : Joueur -> Main
    // Renvoie la main  associée au joueur
    // pre : joueur
    // post : main du joueur
    func getMain() -> Main
    
    // getFront : Joueur -> Front
    // Renvoie le front associé au joueur
    // pre : joueur
    // post : front du joueur
    func getFront() -> Front
    
    // getRoyaume : Joueur -> Royaume
    // Renvoie le royaume associé au joueur
    // pre : joueur
    // post : royaume du joueur
    func getRoyaume() -> Royaume

    // piocher : Joueur x Int x Bool -> Joueur
    // Cette fonction permet de retirer un nbr de carte de la pioche du joueur pour la mettre dans la Main (pioche vide = aucune action, main pleine = ERREUR)
    // pre : Prend en entrée un Joueur, un entier positif correspondant au nombre de carte (si <0 renvoie une ERREUR) à retirer de la pioche (par défaut 1) et si l'on souhaite piocher vers le Royaume : Bool = True, si on veut piocher vers la Main, Bool = False
    // post : Ne renvoie rien
    mutating func piocher (nbr : Int, versRoyaume : Bool) throws
    
    // mobiliser : Joueur x Carte? x String -> Joueur
    // Cette fonction permet de placer une carte de la main du Joueur sur une position du Front. Cas spécial : si on ne donne pas de carte, Il faut tirer la carte du royaume (et non pas de la main).
    // pre : On rentre en paramètre un Joueur, Une carte (Ou pas), et un texte, correspondant à la position à laquelle on veut placer la carte sur le front. (si la position n'existe pas, on lève une ERREUR). Si le Royaume est vide, rien ne se passe pour ce qui est de la main car ça ne peut pas arriver. Dans le cas ou la carte n'est pas dans la main, lève une ERREUR.
    // post : Ne renvoie rien
    mutating func mobiliser (carte : Carte?, position : String) throws
    
    // demobiliser : Joueur x Carte -> Joueur
    // Cette fonction permet de déplacer une carte de la main, vers le Royaume
    // pre : Prend en entrée un Joueur et une Carte. Si la carte n'est pas dans la main rien ne se passe.
    // post : Ne renvoie rien
    mutating func demobiliser (carte : Carte) 
    
    // capturer : Joueur x Joueur x Carte -> Joueur
    // cette fonction prend une carte du front de l'adversaire et la met dans le royaume du joueur. Si la carte n'est pas sur le front de l'adversaire, rien ne se passe.
    // pre : Prend en entrée un joueur (type Joueur), un adversaire (type Joueur) et une carte.
    // post : Ne renvoie rien
    mutating func capturer (adversaire : Self, carte : Carte)
}

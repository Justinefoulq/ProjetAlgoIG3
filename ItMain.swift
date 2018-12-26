struct ItMain: IteratorProtocol {
    let main: Main
    var i = 0

    init(_ main: Main) {
        self.main = Main
    }

    mutating func next() -> Carte? {
        let carte = self.main.getMain[i]
        guard i >= 0 && i < 6
            else { return nil }

        i += 1
        return carte
    }
}
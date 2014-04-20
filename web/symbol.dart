part of PokerDart;

class Symbol {
    static Symbol Hearts = new Symbol(1);
    static Symbol Diamonds = new Symbol(2);
    static Symbol Clubs = new Symbol(3);
    static Symbol Spades = new Symbol(4);
    static List<Symbol> AllSymbols = new List.generate(4, (i) => new Symbol(i+1));

    int symbolType;

    Symbol(symbolType){
        if (symbolType < 1 || symbolType > 4){
            throw new ArgumentError('The symbolType argument has to be in range: 1 <= symbolType <= 4, but was: $symbolType');
        }
        this.symbolType = symbolType;
    }

    String get color {
        switch (symbolType) {
            case 1:
            case 2:
                return 'Red';
            case 3:
            case 4:
                return 'Black';
            default:
                throw new Exception(
                        'Symbol type out of range, expected between 1-4 but was $symbolType');
        }
    }

    String toString() {
        switch (symbolType) {
            case 1:
                return 'Hearts';
            case 2:
                return 'Diamonds';
            case 3:
                return 'Clubs';
            case 4:
                return 'Spades';
            default:
                throw new Exception(
                        'Symbol type out of range, expected between 1-4 but was $symbolType');
        }
    }
}

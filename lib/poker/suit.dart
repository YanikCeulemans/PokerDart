part of Poker;

class Suit implements Comparable<Suit>{
    static Suit Hearts = new Suit._internal(1);
    static Suit Diamonds = new Suit._internal(2);
    static Suit Clubs = new Suit._internal(3);
    static Suit Spades = new Suit._internal(4);
    static List<Suit> AllSuits = new List.generate(4, (i) => new Suit._internal(i + 1));

    int _suitType;

    Suit._internal(suitType) {
        if (suitType < 1 || suitType > 4) {
            throw new ArgumentError('The suitType argument has to be in range: 1 <= suitType <= 4, but was: $suitType');
        }
        this._suitType = suitType;
    }

    String get color {
        switch (_suitType) {
            case 1:
            case 2:
                return 'Red';
            case 3:
            case 4:
                return 'Black';
            default:
                throw new Exception('Suit type out of range, expected between 1-4 but was $_suitType');
        }
    }

    @override
    String toString() {
        switch (_suitType) {
            case 1:
                return 'Hearts';
            case 2:
                return 'Diamonds';
            case 3:
                return 'Clubs';
            case 4:
                return 'Spades';
            default:
                throw new Exception('Suit type out of range, expected between 1-4 but was $_suitType');
        }
    }

    int compareTo(Suit other) {
        return _suitType - other._suitType;
    }

    @override
    int get hashCode => 17 + _suitType;

    @override
    bool operator ==(Suit other){
        return this._suitType == other._suitType;
    }
}

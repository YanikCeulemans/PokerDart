part of Poker;

class Suit implements Comparable<Suit>{
    static Suit Hearts = new Suit(1);
    static Suit Diamonds = new Suit(2);
    static Suit Clubs = new Suit(3);
    static Suit Spades = new Suit(4);
    static List<Suit> AllSuits = new List.generate(4, (i) => new Suit(i + 1));

    int suitType;

    Suit(suitType) {
        if (suitType < 1 || suitType > 4) {
            throw new ArgumentError('The suitType argument has to be in range: 1 <= suitType <= 4, but was: $suitType');
        }
        this.suitType = suitType;
    }

    String get color {
        switch (suitType) {
            case 1:
            case 2:
                return 'Red';
            case 3:
            case 4:
                return 'Black';
            default:
                throw new Exception('Suit type out of range, expected between 1-4 but was $suitType');
        }
    }

    @override
    String toString() {
        switch (suitType) {
            case 1:
                return 'Hearts';
            case 2:
                return 'Diamonds';
            case 3:
                return 'Clubs';
            case 4:
                return 'Spades';
            default:
                throw new Exception('Suit type out of range, expected between 1-4 but was $suitType');
        }
    }

    int compareTo(Suit other) {
        return suitType - other.suitType;
    }
}

library Poker;

class Suit {
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
}


class Card {
    Suit suit;
    int value;

    Card(int value, this.suit) {
        if (value > 0 && value <= 13) {
            this.value = value;
        } else {
            throw new Exception('A card must be in range: 0 < card <= 13, but was: $value');
        }
    }

    String get color => suit.color;

    String get valueString {
        switch (value) {
            case 1:
                return 'Ace';
            case 11:
                return 'Jack';
            case 12:
                return 'Queen';
            case 13:
                return 'King';
            default:
                return value.toString();
        }
    }

    String toString() => '$valueString of $suit';
}

class Combinations {
    List<Card> _cards;

    Combinations(this._cards);

    String check() {
        if (_isStraightFlush()) {
            return 'Straight Flush';
        }
        return 'No combination found';
    }

    bool _isStraightFlush() {
        Map<Suit, List<Card>> map = new Map<Suit, List<Card>>();

        _cards.forEach((c) => map.containsKey(c.suit) ? map[c.suit].add(c) : map[c.suit] = [c]);
        List<Suit> keys = map.keys.toList();
        for (int i = 0; i < keys.length; i++) {
            List<Card> currList = map[keys[i]];
            if (currList.length >= 5) {
                // check if they are a series: e.g. 1-2-3-4-5
                currList.sort((c1, c2) => c1.value - c2.value);
                int startValue = currList[0].value;
                for (var j = 1; j < currList.length; j++) {
                    int nextValue = currList[j].value;
                    if (nextValue - startValue != 1) {
                        return false;
                    }
                    startValue = nextValue;
                }
                return true;
            }
        }
        return false;
    }

    // check if the given cards contain a series: e.g. 1-2-3-4-5, but also
    // 1-4-5-6-7-8, or 4-5-6-7-8-11-13
    static bool isStraight(List<Card> cards) {
        if (cards.length < 5) return false;

        cards.sort((c1, c2) => c1.value - c2.value);
        int startValue = cards[0].value;

        for (var j = 1; j < 5; j++) {
            int nextValue = cards[j].value;
            if (nextValue - startValue != 1) {
                return isStraight(cards.skip(j).toList());
            }
            startValue = nextValue;
        }
        return true;
    }
}

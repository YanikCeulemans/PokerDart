part of PokerDart;

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

        _cards.forEach((c) => map.containsKey(c.symbol) ? map[c.symbol].add(c) :
                map[c.symbol] = [c]);
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
        // Check if the cards contain a straight, this should work for a list
        // of cards with a length greater than 5, eg 7
        cards.sort((c1, c2) => c1.value - c2.value);
        int startValue = cards[0].value;
        for (var j = 1; j < cards.length; j++) {
            int nextValue = cards[j].value;
            // TODO: improve the check here to account for subsets of 5 from a
            // larger set
            if (nextValue - startValue != 1) {
                return false;
            }
            startValue = nextValue;
        }
        return true;
    }
}

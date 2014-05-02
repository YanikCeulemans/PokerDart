part of Poker;

class Combinations {
    List<Card> _cards;
    static const int _amountOfCardsForStraight = 5;
    static const int _amountOfCardsForFlush = 5;
    static const int _amountOfCardsForFourOfAKind = 4;
    static const int _amountOfCardsForThreeOfAKind = 3;

    Combinations(this._cards);

    String check() {
        if (isStraightFlush()) {
            return 'Straight Flush';
        }
        return 'No combination found';
    }

    bool isStraightFlush() {
        var straightList = getStraight(_cards);
        if (straightList != null){
            return straightList.every((c) => c.suit == straightList.first.suit);
        }
        return false;
    }

    bool isStraight() {
        var straightList = getStraight(_cards);
        return straightList != null && straightList.length == _amountOfCardsForStraight;
    }

    /**
     * Returns a `List<Card>` that represents the straight found in the
     * parameter `cards`. If no straight was found, returns `null`
     *
     * Example of a straight: 1-2-3-4-5-8-10
     *
     * @param cards The list of cards from which the straight will be extracted
     */
    List<Card> getStraight(List<Card> cards){
        return _getCombination(cards, _amountOfCardsForStraight, (largeInt, smallInt){
            return largeInt - smallInt != 1;
        });
    }

    /**
     * Returns a `List<Card>` that represents the X of a kind found in the
     * parameter `cards`. If no X of a kind was found, returns `null`
     *
     * Example of a X of a kind (four of a kind): 4-4-4-4-8-7
     *
     * @param cards The list of cards from which the four of a kind will be extracted
     */
    List<Card> getXOfAKind(List<Card> cards, int amountOfCards){
        return _getCombination(cards, amountOfCards, (largeInt, smallInt){
            return largeInt - smallInt != 0;
        });
    }

    List<Card> _getCombination(List<Card> cards, int amountOfCards, bool combinationCondition(int largeInt, int smallInt)){
        if (cards.length < amountOfCards) return null;

        cards.sort((c1, c2) => c1.value - c2.value);
        var firstCard = cards.first;
        int startValue = firstCard.value;
        List<Card> result = [firstCard];

        for (var i = 1; i < amountOfCards; i++) {
            var currentCard = cards[i];
            int nextValue = currentCard.value;
            if (combinationCondition(nextValue, startValue)){
                return _getCombination(cards.skip(i).toList(), amountOfCards, combinationCondition);
            }
            result.add(currentCard);
            startValue = nextValue;
        }
        return result;
    }

    List<Card> getFlush(List<Card> cards){
        if (cards.length < _amountOfCardsForFlush) return null;

        cards.sort((c1, c2) => c1.suit.compareTo(c2.suit));

        var resultList = cards.take(_amountOfCardsForFlush).toList();
        if (!resultList.every((c) => c.suit == cards.first.suit)){
            return getFlush(cards.skip(1).toList());
        }
        return resultList;
    }
}

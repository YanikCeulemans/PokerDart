part of Poker;

class Combinations {
    List<Card> _cards;
    static const int _amountOfCardsForStraight = 5;
    static const int _amountOfCardsForFlush = 5;
    static const int _amountOfCardsForFullHouse = 5;
    static const int _amountOfCardsForFourOfAKind = 4;
    static const int _amountOfCardsForTwoPair = 4;
    static const int _amountOfCardsForThreeOfAKind = 3;

    Combinations(this._cards);

    Hand check() {
        int value = 1;
        List<Hand> possibleHands = new List<Hand>();
        possibleHands.add(new Hand('Straight flush', getStraightFlush(_cards), value++));
        possibleHands.add(new Hand('Four of a kind', getXOfAKind(_cards, 4), value++));
        possibleHands.add(new Hand('Full house', getFullHouse(_cards), value++));
        possibleHands.add(new Hand('Flush', getFlush(_cards), value++));
        possibleHands.add(new Hand('Straight', getStraight(_cards), value++));
        possibleHands.add(new Hand('Three of a kind', getXOfAKind(_cards, 3), value++));
        possibleHands.add(new Hand('Two pair', getTwoPair(_cards), value++));
        possibleHands.add(new Hand('One pair', getXOfAKind(_cards, 2), value++));
        possibleHands.add(new Hand('High card', getHighCard(_cards), value++));

        for (var i = 0; i < possibleHands.length; ++i) {
            var possibleHand = possibleHands[i];
            if (possibleHand.cardCombination != null) return possibleHand;
        }
        return null;
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


    List<Card> getStraightFlush(List<Card> cards){
        List<Card> straight = getStraight(cards);
        if (straight != null){
            List<Card> straightFlush = getFlush(straight);
            if (straightFlush != null) return straightFlush;
        }
        return null;
    }

    /**
     * Returns a `List<Card>` that represents the straight found in the
     * parameter `cards`. If no straight was found, returns `null`.
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
     * parameter `cards`. If no X of a kind was found, returns `null`.
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

    /**
     * Returns a `List<Card>` that represents the flush which was found
     * in the parameter `cards`. If no flush was found, returns `null`.
     *
     * @param cards The list of cards from which the flush will be extracted
     */
    List<Card> getFlush(List<Card> cards){
        if (cards.length < _amountOfCardsForFlush) return null;

        cards.sort((c1, c2) => c1.suit.compareTo(c2.suit));

        var resultList = cards.take(_amountOfCardsForFlush).toList();
        if (!resultList.every((c) => c.suit == cards.first.suit)){
            return getFlush(cards.skip(1).toList());
        }
        return resultList;
    }

    /**
     * Returns a `List<Card>` that represents the full house which was found
     * in the parameter `cards`. If no full house was found, returns `null`.
     *
     * Example of full house: 3-3-3-5-5-9-1
     *
     * @param cards The list of cards from which the full house will be extracted
     */
    List<Card> getFullHouse(List<Card> cards){
        return _getPairCombinations(cards, _amountOfCardsForFullHouse, 3, 2);
    }

    /**
     * Returns a `List<Card>` that represents the two pair which was found
     * in the parameter `cards`. If no two pair was found, returns `null`.
     *
     * Example of two pair: 3-3-5-5-10-9-1
     *
     * @param cards The list of cards from which the two pair will be extracted
     */
    List<Card> getTwoPair(List<Card> cards){
        return _getPairCombinations(cards, _amountOfCardsForTwoPair, 2, 2);
    }

    List<Card> _getPairCombinations(List<Card> cards, int amountOfCardsRequired, int firstPairAmount, int secondPairAmount){
        if (cards.length < amountOfCardsRequired) return null;

        List<Card> clonedList = new List<Card>.from(cards);

        List<Card> firstPair = getXOfAKind(clonedList, firstPairAmount);
        if (firstPair == null) return null;
        clonedList.removeWhere((c) => firstPair.contains(c));

        List<Card> secondPair = getXOfAKind(clonedList, secondPairAmount);
        if (secondPair == null) return null;

        var resultList = new List<Card>.from(firstPair);
        resultList.addAll(secondPair);

        return resultList;
    }

    /**
     * Returns a `Card` that represents the highest card which was found
     * in the parameter `cards`.
     *
     * @param cards The list of cards from which the highest card will be extracted
     */
    Card getHighCard(List<Card> cards){
        cards.sort((c1, c2) => c1.value - c2.value);
        return cards.last;
    }
}

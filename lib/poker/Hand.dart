part of Poker;

class Hand {
    static List<String> _combs = ['Straight flush', 'Four of a kind', 'Full house', 'Flush', 'Straight', 'Three of a kind', 'Two pair', 'One pair', 'High card'];
    String name;
    List<Card> cardCombination;
    int _value;
    int _cardsValue;

    Hand(String name, List<Card> cardCombination) {
        this.name = name;
        this.cardCombination = cardCombination;
        if (cardCombination != null) {
            _cardsValue = cardCombination.fold(0, (prevValue, element) => prevValue + element.value);
        }
        _value = _combs.indexOf(name);
    }

    int get value => _value;

    int get cardsValue => _cardsValue;

    String toString() => '$name ($_value : $_cardsValue) List: $cardCombination ----- ';
}

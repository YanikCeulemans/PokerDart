part of Poker;

class Hand {
    String name;
    List<Card> cardCombination;
    int value;

    Hand(this.name, this.cardCombination, this.value);

    String toString() => '$name ($value) List: $cardCombination ----- ';
}

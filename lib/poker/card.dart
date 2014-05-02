part of Poker;

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

    @override
    bool operator ==(Card other){
        return this.suit == other.suit && this.value == other.value;
    }

    @override
    int get hashCode{
        int hash = 1;
        hash = hash * 17 + this.suit.suitType;
        hash = hash * 31 + this.value;
        return hash;
    }
}

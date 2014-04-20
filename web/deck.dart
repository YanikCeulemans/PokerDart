part of PokerDart;

class Deck{
    static List<Card> Fulldeck = new List<Card>.generate(52, (i) => new Card((i % 13) + 1, Symbol.AllSymbols[ (i / 13).floor() ] ));
    List<Card> _cards;

    Deck({List<Card> cards : null}){
        if (cards != null){
            _cards = cards;
        }else{
            _cards = new List<Card>.from(Deck.Fulldeck);
            _cards.shuffle();
        }
    }

    String toString(){
        String result = '';
        _cards.forEach((c) => result += '$c, ');
        return result;
    }

    void addCard(Card c){
        _cards.add(c);
    }

    List<Card> deal([int amount = 1]){
        if (amount < 1){
            throw new ArgumentError('The amount argument cannot be less than 1, but was: $amount');
        }
        List<Card> result = new List<Card>();
        if (amount >= _cards.length){
            result = new List<Card>.from(_cards);
            _cards = new List<Card>();
        }else{
            result.addAll(_cards.getRange(0, amount));
            _cards.removeRange(0, amount);
        }
        return result;
    }
}

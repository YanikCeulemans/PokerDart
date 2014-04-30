part of PokerDart;

class Deck{
    static List<HtmlCard> Fulldeck = new List<HtmlCard>.generate(52, (i) => new HtmlCard((i % 13) + 1, Suit.AllSuits[ (i / 13).floor() ] ));
    List<HtmlCard> _cards;

    Deck({List<HtmlCard> cards : null}){
        if (cards != null){
            _cards = cards;
        }else{
            _cards = new List<HtmlCard>.from(Deck.Fulldeck);
            _cards.shuffle();
        }
    }

    String toString(){
        String result = '';
        _cards.forEach((c) => result += '$c, ');
        return result;
    }

    void addCard(HtmlCard c){
        _cards.add(c);
    }

    List<HtmlCard> deal([int amount = 1]){
        if (amount < 1){
            throw new ArgumentError('The amount argument cannot be less than 1, but was: $amount');
        }
        List<HtmlCard> result = new List<HtmlCard>();
        if (amount >= _cards.length){
            result = new List<HtmlCard>.from(_cards);
            _cards = new List<HtmlCard>();
        }else{
            result.addAll(_cards.getRange(0, amount));
            _cards.removeRange(0, amount);
        }
        return result;
    }
}

part of PokerDart;

class Player implements IHtmlRenderable {
    String name;
    List<Card> _cards;

    Player(this.name, {List<Card> cards: null}) {
        if (cards != null) {
            _cards = cards;
        } else {
            _cards = new List<Card>();
        }
    }

    void addCard(Card c){
        _cards.add(c);
    }

    void addCards(Iterable<Card> cards){
        _cards.addAll(cards);
    }

    @override
    HtmlElement render() {
        HtmlElement container = new DivElement();
        container.classes.add('player-container');
        HtmlElement player = new DivElement();
        HtmlElement name = new HeadingElement.h2();
        name.text = this.name;

        player.classes.add('card-container');
        _cards.forEach((c) => player.append(c.render()));

        container.append(name);
        container.append(player);
        return container;
    }
}

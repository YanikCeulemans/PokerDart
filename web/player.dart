part of PokerDart;

class Player implements IHtmlRenderable, IObserver {
    String name;
    ObservableList<Card> _cards;
    HtmlElement _playerElement;

    Player(this.name, {ObservableList<Card> cards: null}) {
        if (cards != null) {
            _cards = cards;
        } else {
            _cards = new ObservableList<Card>();
        }
        _cards.registerObserver(this);

        _playerElement = new DivElement();
        _playerElement.classes.add('card-container');
    }

    void addCard(Card c) {
        _cards.add(c);
    }

    void addCards(Iterable<Card> cards) {
        _cards.addAll(cards);
    }

    void clearHand() {
        _cards.clear();
    }

    void renderHandTo(HtmlElement element){
        _cards.forEach((c) => element.append(c.render()));
    }

    @override
    HtmlElement render() {
        HtmlElement container = new DivElement();
        container.classes.add('player-container');
        HtmlElement name = new HeadingElement.h2();
        name.text = this.name;

        container.append(name);
        container.append(_playerElement);
        return container;
    }

    @override
    void notify() {
        _playerElement.innerHtml = '';
        renderHandTo(_playerElement);
    }
}

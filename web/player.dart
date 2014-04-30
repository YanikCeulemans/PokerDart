part of PokerDart;

class Player implements IHtmlRenderable, IObserver {
    String name;
    bool isAi;
    ObservableList<HtmlCard> _cards;
    HtmlElement _playerElement;

    Player(this.name, this.isAi, {ObservableList<HtmlCard> cards: null}) {
        if (cards != null) {
            _cards = cards;
        } else {
            _cards = new ObservableList<HtmlCard>();
        }
        _cards.registerObserver(this);

        _playerElement = new DivElement();
        _playerElement.classes.add('card-container');
    }

    void addCard(HtmlCard c) {
        _cards.add(c);
    }

    void addCards(Iterable<HtmlCard> cards) {
        _cards.addAll(cards);
    }

    void clearHand() {
        _cards.clear();
    }

    void renderHandTo(HtmlElement element){
        if (!isAi){
            _cards.forEach((c) => element.append(c.render()));
        }
    }

    @override
    HtmlElement render() {
        HtmlElement container = new DivElement();
        container.classes.add('player-container');
        if (isAi){
            container.classes.add('player-ai');
        }
        HtmlElement name = new HeadingElement.h2();
        name.text = this.name;
        container.append(name);
        if (!isAi){
            container.append(_playerElement);
        }

        return container;
    }

    @override
    void notify() {
        _playerElement.innerHtml = '';
        renderHandTo(_playerElement);
    }
}

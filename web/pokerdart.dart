library PokerDart;
import 'dart:html';
import 'package:pokerdart/observable.dart';
import 'package:pokerdart/bootstrap_factory.dart';
import 'package:pokerdart/poker/poker.dart';
part 'player.dart';
part 'deck.dart';

HtmlElement playerElement;
HtmlElement communityCards;
Deck deck;
Player player;
PlayTable playTable;

List<String> names = ['Patrick', 'Spongebob', 'Mr.Krabs'];

void main() {
    HtmlElement startBtn = querySelector('#btn-start');
    InputElement nameInput = querySelector('#name');

    startBtn.onClick.listen((e) => startGame(nameInput.value));
}

void startGame(String playerName) {
    deck = new Deck();
    player = new Player(playerName, false);
    var ais = new List<Player>.generate(3, (index) => new Player(names[index], true));
    List<Player> players = new List<Player>();
    players.add(player);
    players.addAll(ais);

    players.forEach((p) => p.addCards(deck.deal(2)));

    playTable = new PlayTable(deck, players);

    querySelector('.jumbotron').classes.add('hidden');

    querySelector('body').append(playTable.render());

    Combinations combinations = new Combinations(deck.deal(7));
    combinations.check();
}

abstract class IHtmlRenderable {
    HtmlElement render();
}



class PlayTable implements IHtmlRenderable, IObserver {
    ObservableList<HtmlCard> _cards;
    int _gameStage;
    Deck _deck;
    List<Player> _players;
    HtmlElement _playTable;
    HtmlElement _communityCards;
    ButtonElement _continueButton;

    PlayTable(this._deck, this._players) {
        this._gameStage = 1;
        _communityCards = new DivElement();
        _communityCards.classes.add('card-container');

        _cards = new ObservableList<HtmlCard>();
        _cards.registerObserver(this);

        _playTable = new DivElement();
        _playTable.classes.add('play-table');

        _continueButton = BootstrapFactory.CreateButton('Continue!', BootstrapButtonType.primaryType);
        _continueButton.onClick.listen(nextStage);

        _playTable.append(_continueButton);

        _players.forEach((p) => _playTable.append(p.render()));

        _playTable.append(_communityCards);
    }

    void nextStage(e) {
        switch (_gameStage) {
            case 0:
                _cards.clear();
                _continueButton.text = 'Continue!';
                _deck = new Deck();
                _players.forEach(_dealNewHand);
                _gameStage++;
                break;
            case 1:
                _cards.addAll(_deck.deal(3));
                _gameStage++;
                break;
            case 2:
                _cards.addAll(_deck.deal());
                _gameStage++;
                break;
            case 3:
                _cards.addAll(_deck.deal());
                _continueButton.text = 'Next game';
                _gameStage = 0;
                break;
        }
    }

    void _dealNewHand(Player p) {
        p.clearHand();
        p.addCards(_deck.deal(2));
    }

    @override
    HtmlElement render() {
        return _playTable;
    }

    @override
    void notify() {
        _communityCards.innerHtml = '';
        _cards.forEach((c) => _communityCards.append(c.render()));
    }
}

class HtmlCard extends Card implements IHtmlRenderable {
    HtmlCard(int value, Suit suit): super(value, suit);

    @override
    HtmlElement render() {
        HtmlElement card = new DivElement();
        card.classes.add('card');
        card.classes.add('card-color-${color.toLowerCase()}');
        card.innerHtml = this.toString();
        return card;
    }

    HtmlElement renderFaceDown() {
        HtmlElement card = new DivElement();
        card.classes.add('card card-color-blue');
        return card;
    }
}


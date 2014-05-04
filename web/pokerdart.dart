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
}

abstract class IHtmlRenderable {
    HtmlElement render();
}

class PlayTable implements IHtmlRenderable, IObserver {
    ObservableList<HtmlCard> _communityCards;
    int _gameStage;
    Deck _deck;
    List<Player> _players;
    HtmlElement _playTable;
    HtmlElement _communityCardsContainer;
    ButtonElement _continueButton;

    PlayTable(this._deck, this._players) {
        this._gameStage = 1;
        _communityCardsContainer = new DivElement();
        _communityCardsContainer.classes.add('card-container');

        _communityCards = new ObservableList<HtmlCard>();
        _communityCards.registerObserver(this);

        _playTable = new DivElement();
        _playTable.classes.add('play-table');

        _continueButton = BootstrapFactory.CreateButton('Continue!', BootstrapButtonType.primaryType);
        _continueButton.onClick.listen(nextStage);

        _playTable.append(_continueButton);

        _players.forEach((p) => _playTable.append(p.render()));

        _playTable.append(_communityCardsContainer);
    }

    void nextStage(e) {
        switch (_gameStage) {
            case 0:
                _communityCards.clear();
                _continueButton.text = 'Continue!';
                _deck = new Deck();
                _players.forEach(_dealNewHand);
                _gameStage++;
                break;
            case 1:
                _communityCards.addAll(_deck.deal(3));
                _gameStage++;
                break;
            case 2:
                _communityCards.addAll(_deck.deal());
                _gameStage++;
                break;
            case 3:
                _communityCards.addAll(_deck.deal());
                _continueButton.text = 'Next game';
                _gameStage = 0;


                List<Hand> playerHands = new List<Hand>();
                _players.forEach((p){
                    List<HtmlCard> currentCards = p.hand;
                    currentCards.addAll(_communityCards.toList());
                    var playerHand = new Combinations(currentCards).check();
                    playerHands.add(playerHand);
                });

                playerHands.forEach((hand) => _playTable.appendText(hand.toString()));

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
        _communityCardsContainer.innerHtml = '';
        _communityCards.forEach((c) => _communityCardsContainer.append(c.render()));
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

    String toString() => super.toString();
}


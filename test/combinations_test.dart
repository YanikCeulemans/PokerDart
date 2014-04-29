library combinations_test;

import 'package:unittest/unittest.dart';
import 'package:pokerdart/poker/poker.dart';

void main(){
    List<Card> cards;
    Combinations combinations;
    group('Combinations', (){
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('isStraight() happy path', () =>
            expect(Combinations.isStraight(cards), isTrue));
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(9, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
        });
        test('isStraight() incorrect card list retruns false', () =>
                    expect(Combinations.isStraight(cards), isFalse));
    });

}
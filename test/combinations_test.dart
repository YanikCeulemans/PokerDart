library combinations_test;

import 'package:unittest/unittest.dart';
import 'package:pokerdart/poker/poker.dart';

void main(){
    List<Card> cards;
    Combinations combinations;
    group('Combinations isStraight()', (){
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(4, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('List of less than 5 cards is never a straight', () =>
            expect(Combinations.isStraight(cards), isFalse));
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('ordered happy path is a straight', () =>
            expect(Combinations.isStraight(cards), isTrue));
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('unordered happy path is a straight', () =>
            expect(Combinations.isStraight(cards), isTrue));
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(9, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
        });
        test('incorrect list of 5 cards is not a straight', () =>
            expect(Combinations.isStraight(cards), isFalse));
        setUp((){
            cards = [new Card(3, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(9, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
        });
        test('incorrect list of 6 cards is not a straight', () =>
            expect(Combinations.isStraight(cards), isFalse));
        setUp((){
            cards = [new Card(3, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
        });
        test('correct 5 cards in 6 card list is a straight', () =>
            expect(Combinations.isStraight(cards), isTrue));
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(5, Suit.Clubs),
                     new Card(13, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(6, Suit.Clubs)];
        });
        test('incorrect list of 7 cards is not a straight', () =>
            expect(Combinations.isStraight(cards), isFalse));
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(5, Suit.Clubs),
                     new Card(7, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(6, Suit.Clubs)];
        });
        test('correct 5 cards in 7 card list (lower bound of range and higher bound out of range) is a straight', () =>
            expect(Combinations.isStraight(cards), isTrue));
    });

}
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
            expect(combinations.isStraight(), isFalse));
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('ordered happy path is a straight', () =>
            expect(combinations.isStraight(), isTrue));
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('unordered happy path is a straight', () =>
            expect(combinations.isStraight(), isTrue));
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(9, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('incorrect list of 5 cards is not a straight', () =>
            expect(combinations.isStraight(), isFalse));
        setUp((){
            cards = [new Card(3, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(9, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('incorrect list of 6 cards is not a straight', () =>
            expect(combinations.isStraight(), isFalse));
        setUp((){
            cards = [new Card(3, Suit.Clubs),
                     new Card(2, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(5, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('correct 5 cards in 6 card list is a straight', () =>
            expect(combinations.isStraight(), isTrue));
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(5, Suit.Clubs),
                     new Card(13, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('incorrect list of 7 cards is not a straight', () =>
            expect(combinations.isStraight(), isFalse));
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(5, Suit.Clubs),
                     new Card(7, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('correct 5 cards in 7 card list (lower bound of range and higher bound out of range) is a straight', () =>
            expect(combinations.isStraight(), isTrue));
    });

    group('Combinations isStraightFlush()', (){
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Clubs),
                     new Card(5, Suit.Clubs),
                     new Card(7, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('unordered happy path is straight flush', (){
            expect(combinations.isStraightFlush(), isTrue);
        });
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(3, Suit.Hearts),
                     new Card(1, Suit.Diamonds),
                     new Card(5, Suit.Clubs),
                     new Card(7, Suit.Clubs),
                     new Card(11, Suit.Clubs),
                     new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('unordered list of different suits is not a straight flush', (){
            expect(combinations.isStraightFlush(), isFalse);
        });
    });

    group('Combinations getFourOfAKind()', (){
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                     new Card(4, Suit.Clubs),
                     new Card(4, Suit.Diamonds),
                     new Card(4, Suit.Spades)];
            combinations = new Combinations(cards);
        });
        test('happy path is four of a kind', (){
            expect(combinations.getXOfAKind(cards, 4), equals(cards));
        });
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                     new Card(3, Suit.Clubs),
                     new Card(1, Suit.Spades),
                     new Card(5, Suit.Clubs),
                     new Card(7, Suit.Diamonds),
                     new Card(11, Suit.Hearts),
                     new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Incorrect cards are not four of a kind', (){
            expect(combinations.getXOfAKind(cards, 4), isNull);
        });
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                     new Card(4, Suit.Clubs),
                     new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Less than 4 cards can never be four of a kind', (){
            expect(combinations.getXOfAKind(cards, 4), isNull);
        });
    });

    group('Combinations getThreeOfAKind()', (){
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                    new Card(4, Suit.Clubs),
                    new Card(4, Suit.Diamonds),
                    new Card(4, Suit.Spades)];
            combinations = new Combinations(cards);
        });
        test('four of a kind is three of a kind', (){
            expect(combinations.getXOfAKind(cards, 3), equals(cards.take(3).toList()));
        });
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                    new Card(3, Suit.Clubs),
                    new Card(1, Suit.Spades),
                    new Card(5, Suit.Clubs),
                    new Card(7, Suit.Diamonds),
                    new Card(11, Suit.Hearts),
                    new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Incorrect cards are not three of a kind', (){
            expect(combinations.getXOfAKind(cards, 3), isNull);
        });
        setUp((){
            cards = [new Card(4, Suit.Clubs),
                new Card(4, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Less than 2 cards can never be three of a kind', (){
            expect(combinations.getXOfAKind(cards, 3), isNull);
        });
    });

    group('Combinations getFlush()', (){
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                    new Card(4, Suit.Clubs),
                    new Card(4, Suit.Diamonds),
                    new Card(4, Suit.Spades)];
            combinations = new Combinations(cards);
        });
        test('4 cards can never be a flush', (){
            expect(combinations.getFlush(cards), isNull);
        });
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                    new Card(3, Suit.Clubs),
                    new Card(1, Suit.Spades),
                    new Card(5, Suit.Clubs),
                    new Card(7, Suit.Diamonds),
                    new Card(11, Suit.Hearts),
                    new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Incorrect cards are not a flush', (){
            expect(combinations.getFlush(cards), isNull);
        });
        setUp((){
            cards = [new Card(1, Suit.Clubs),
                    new Card(3, Suit.Clubs),
                    new Card(6, Suit.Clubs),
                    new Card(7, Suit.Clubs),
                    new Card(3, Suit.Hearts),
                    new Card(7, Suit.Spades),
                    new Card(10, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Happy path is flush', (){
            expect(combinations.getFlush(cards), equals([new Card(1, Suit.Clubs),
                                                        new Card(3, Suit.Clubs),
                                                        new Card(6, Suit.Clubs),
                                                        new Card(7, Suit.Clubs),
                                                        new Card(10, Suit.Clubs)]));
        });
    });

    group('Combinations getFullHouse()', (){
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                    new Card(4, Suit.Clubs),
                    new Card(4, Suit.Diamonds),
                    new Card(4, Suit.Spades)];
            combinations = new Combinations(cards);
        });
        test('4 cards can never be a full house', (){
            expect(combinations.getFullHouse(cards), isNull);
        });
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                    new Card(3, Suit.Clubs),
                    new Card(1, Suit.Spades),
                    new Card(5, Suit.Clubs),
                    new Card(7, Suit.Diamonds),
                    new Card(11, Suit.Hearts),
                    new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Incorrect cards are not a full house', (){
            expect(combinations.getFullHouse(cards), isNull);
        });
        setUp((){
            cards = [new Card(1, Suit.Hearts),
                    new Card(3, Suit.Clubs),
                    new Card(3, Suit.Spades),
                    new Card(6, Suit.Spades),
                    new Card(6, Suit.Hearts),
                    new Card(6, Suit.Diamonds),
                    new Card(10, Suit.Hearts)];
            combinations = new Combinations(cards);
        });
        test('Happy path is full house', (){
            expect(combinations.getFullHouse(cards), unorderedEquals([new Card(3, Suit.Clubs),
                                                                    new Card(3, Suit.Spades),
                                                                    new Card(6, Suit.Spades),
                                                                    new Card(6, Suit.Hearts),
                                                                    new Card(6, Suit.Diamonds)]));
        });
    });

    group('Combinations getTwoPair()', (){
        setUp((){
            cards = [new Card(4, Suit.Hearts),
            new Card(4, Suit.Clubs),
            new Card(4, Suit.Spades)];
            combinations = new Combinations(cards);
        });
        test('3 cards can never be two pair', (){
            expect(combinations.getTwoPair(cards), isNull);
        });
        setUp((){
            cards = [new Card(4, Suit.Hearts),
                    new Card(3, Suit.Clubs),
                    new Card(1, Suit.Spades),
                    new Card(5, Suit.Clubs),
                    new Card(7, Suit.Diamonds),
                    new Card(11, Suit.Hearts),
                    new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Incorrect cards are not two pair', (){
            expect(combinations.getTwoPair(cards), isNull);
        });
        setUp((){
            cards = [new Card(1, Suit.Hearts),
                    new Card(3, Suit.Clubs),
                    new Card(3, Suit.Spades),
                    new Card(6, Suit.Spades),
                    new Card(6, Suit.Hearts),
                    new Card(4, Suit.Diamonds),
                    new Card(10, Suit.Hearts)];
            combinations = new Combinations(cards);
        });
        test('Happy path is two pair', (){
            expect(combinations.getTwoPair(cards), unorderedEquals([new Card(3, Suit.Clubs),
                                                                    new Card(3, Suit.Spades),
                                                                    new Card(6, Suit.Spades),
                                                                    new Card(6, Suit.Hearts)]));
        });
    });

    group('Combinations getHighCard()', (){
        setUp((){
            cards = [new Card(4, Suit.Hearts),
            new Card(3, Suit.Clubs),
            new Card(1, Suit.Spades),
            new Card(5, Suit.Clubs),
            new Card(7, Suit.Diamonds),
            new Card(11, Suit.Hearts),
            new Card(6, Suit.Clubs)];
            combinations = new Combinations(cards);
        });
        test('Incorrect cards are not two pair', (){
            expect(combinations.getHighCard(cards), equals(new Card(11, Suit.Hearts)));
        });
    });


}

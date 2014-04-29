part of PokerDart;

class Card implements IHtmlRenderable{
    Suit symbol;
    int value;

    Card(int value, this.symbol){
        if (value > 0 && value <= 13){
            this.value = value;
        }else{
            throw new Exception('A card must be in range: 0 < card <= 13, but was: $value');
        }
    }

    String get color => symbol.color;

    String get valueString {
        switch (value) {
            case 1:
                return 'Ace';
            case 11:
                return 'Jack';
            case 12:
                return 'Queen';
            case 13:
                return 'King';
            default:
                return value.toString();
        }
    }

    String toString() => '$valueString of $symbol';

  @override
  HtmlElement render() {
      HtmlElement card = new DivElement();
      card.classes.add('card');
      card.classes.add('card-color-${color.toLowerCase()}');
      card.innerHtml = this.toString();
      return card;
  }

  HtmlElement renderFaceDown(){
      HtmlElement card = new DivElement();
      card.classes.add('card card-color-blue');
      return card;
  }
}

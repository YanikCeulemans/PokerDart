library Bootstrap;

import 'dart:html';

class BootstrapButtonType{
    String _buttonType;

    static BootstrapButtonType defaultType = new BootstrapButtonType._internal('btn-default');
    static BootstrapButtonType primaryType = new BootstrapButtonType._internal('btn-primary');

    BootstrapButtonType._internal(String buttonType){
        _buttonType = buttonType;
    }

    String get buttonType => _buttonType;
}

class BootstrapFactory{
    static ButtonElement CreateButton(String text, [BootstrapButtonType bbType]){
        var buttonElement = new ButtonElement();
        if (bbType == null){
            bbType = BootstrapButtonType.defaultType;
        }
        buttonElement.classes.add('btn ${bbType.buttonType}');
        buttonElement.text = text;
        return buttonElement;
    }
}

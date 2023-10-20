import 'package:flutter/material.dart';
import 'keypad_button.dart' show KeyPadButton, KeyPadButtonState;
import '../palette.dart' show Palette;

class KeyPad extends StatefulWidget {
  final  Function(int)onPressed;
  final int selectedKey;

  const KeyPad({
    super.key,
    required this.onPressed,
    required this.selectedKey,
  });

  @override
  State<KeyPad> createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> {

  final List<GlobalKey<KeyPadButtonState>> _keyPadButtonKeys = <GlobalKey<KeyPadButtonState>>[
    for (int i = 0; i < 10; i++)
      GlobalKey<KeyPadButtonState>(),
  ];

  void _keyPress(int keyNumber) {
    widget.onPressed(keyNumber);

    for (int i = 0; i < 10; i++) {
      if (i != keyNumber - 1) {
        _keyPadButtonKeys[i].currentState!.buttonColor = Palette.btnNormal;
      } else if (i == keyNumber - 1) {
        _keyPadButtonKeys[i].currentState!.buttonColor = Palette.btnEnabled;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (int i = 0; i < 10; i++)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: KeyPadButton(
                keyNumber: i != 9 ? i + 1 : 0,
                onPressed: _keyPress,
                isSelected: widget.selectedKey == i + 1,
                key: _keyPadButtonKeys[i],
              ),
            )
        ],
      )
    );
  }
}

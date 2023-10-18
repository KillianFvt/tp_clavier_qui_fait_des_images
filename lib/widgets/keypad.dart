import 'package:flutter/material.dart';
import 'keypad_button.dart';

class KeyPad extends StatefulWidget {
  final Function(int) onPressed;

  const KeyPad({
    super.key,
    required this.onPressed,
  });

  @override
  State<KeyPad> createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (int i = 0; i < 10; i++)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: KeyPadButton(
                  keyNumber: i != 9 ? i + 1 : 0,
                  onPressed: widget.onPressed,
              ),
            )
        ],
      )
    );
  }
}

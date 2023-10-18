import 'package:flutter/material.dart';

class KeyPadButton extends StatefulWidget {

  final Function(int) onPressed;

  final int keyNumber;

  const KeyPadButton({
    super.key,
    required this.keyNumber,
    required this.onPressed,
  });

  @override
  State<KeyPadButton> createState() => _KeyPadButtonState();
}

class _KeyPadButtonState extends State<KeyPadButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          widget.onPressed(widget.keyNumber);

          final snackBar = SnackBar(
            duration: const Duration(milliseconds: 750),
            content: Text('Image n°${widget.keyNumber} affichée !'),
            action: SnackBarAction(
              label: 'Fermer',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },

        style: ElevatedButton.styleFrom(

          elevation: 10.0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          backgroundColor: const Color(0xFF21295c),
          foregroundColor: Colors.white,

          textStyle: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        child: Text('${widget.keyNumber}')
    );
  }
}

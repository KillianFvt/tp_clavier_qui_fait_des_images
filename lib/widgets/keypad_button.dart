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

class _KeyPadButtonState extends State<KeyPadButton> with SingleTickerProviderStateMixin {

  static double _bottomShift = 0;

  static const _durationMilliseconds = 250;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: _durationMilliseconds),
    vsync: this,

  )..addListener(() {
    setState(() => _bottomShift = _animation.value);
  });


  late final Animation<double> _animationCurve = CurvedAnimation(parent: _controller, curve: Curves.easeInSine);

  late final Animation<double> _animation = Tween(begin: 0.0, end: 10.0).animate(_animationCurve);

  void press() {
    _controller.forward();
  }

  void release() {
    _controller.reverse();
  }

  void pressAndRelease() {
    press();
    Future.delayed(
      const Duration(milliseconds: _durationMilliseconds),
          () => release(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _bottomShift,

          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
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

                  pressAndRelease();
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
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class PixelAdventureGameButton extends StatefulWidget {
  final void Function() onPressed;
  final String name;

  const PixelAdventureGameButton({
    super.key,
    required this.onPressed,
    required this.name,
  });

  @override
  State<PixelAdventureGameButton> createState() =>
      _PixelAdventureGameButtonState();
}

class _PixelAdventureGameButtonState extends State<PixelAdventureGameButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: const ButtonStyle(
        iconSize: MaterialStatePropertyAll(150),
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        elevation: MaterialStatePropertyAll(0),
      ),
      child: Image.asset(
        "assets/images/Menu/Buttons/${widget.name}.png",
        fit: BoxFit.cover,
        width: 50,
      ),
    );
  }
}

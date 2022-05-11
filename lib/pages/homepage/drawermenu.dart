import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final String text;
  final Function() function;
  const DrawerMenu({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Flexible(
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'PoppinsLight', fontSize: 20),
        ),
      ),
    );
  }
}

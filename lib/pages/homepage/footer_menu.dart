import 'package:flutter/material.dart';
import 'package:valecode/pages/browserpage.dart';

class FooterMenu extends StatelessWidget {
  final String text;
  final String url;
  const FooterMenu({
    required this.text,
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WebPage(url: url)));
      },
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.white, fontFamily: 'PoppinsLight'),
      ),
    );
  }
}

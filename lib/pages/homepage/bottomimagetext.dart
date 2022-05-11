//widget: image for hats and caps
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BottomImageText extends StatelessWidget {
  final String image;
  final String text;
  const BottomImageText({
    required this.image,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: image),
          const SizedBox(
            height: 22.0,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: "PoppinsExtraLight", fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
//widget: Images for 'Explore Collections'
import 'package:flutter/material.dart';
import 'package:valecode/pages/listofproducts/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CollectionWidget extends StatelessWidget {
  final String index1;
  final String index2;
  final String brand1;
  final String brand2;
  const CollectionWidget({
    Key? key,
    required this.index1,
    required this.index2,
    required this.brand1,
    required this.brand2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Loader("default", brand1),
                    ),
                  );
                },
                child: CachedNetworkImage(imageUrl: index1)),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Loader("default", brand2),
                    ),
                  );
                },
                child: CachedNetworkImage(imageUrl: index2)),
          ),
        ],
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valecode/models/cart_model.dart';
import 'package:valecode/pages/browserpage.dart';
import 'package:valecode/pages/homepage/homepage.dart';
import 'package:valecode/pages/loader.dart';

class ShoppingCart extends StatelessWidget {
  final List<CartModel> cartmodel;
  const ShoppingCart({Key? key, required this.cartmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E7),
      bottomNavigationBar: Container(
          height: 80,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    '\$${cartmodel.length * 69}',
                    style: const TextStyle(
                        fontFamily: 'PoppinsSemiBold',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const WebPage(url: "https://rzp.io/l/GYKjfpcUC")));
                },
                child: Row(
                  children: const [
                    Text(
                      'Checkout ',
                      style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              )
            ],
          )),
      body: (cartmodel.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your cart is empty',
                    style:
                        TextStyle(fontSize: 30, fontFamily: 'PoppinsSemiBold'),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'PoppinsLight',
                            decoration: TextDecoration.underline),
                      )),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListView.builder(
                  itemCount: cartmodel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection(
                                    "${FirebaseAuth.instance.currentUser?.email}")
                                .doc(cartmodel[index].title)
                                .delete();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const CartLoader()),
                            );
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              CachedNetworkImage(
                                  imageUrl: cartmodel[index].coverimage),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\n   ${(cartmodel[index].title).replaceAll("\\n", " ")}",
                                    style: const TextStyle(
                                        fontFamily: 'PoppinsSemiBold',
                                        fontSize: 18),
                                  ),
                                  const Text(
                                    "    \$69 • tap to remove",
                                    style:
                                        TextStyle(fontFamily: 'PoppinsLight'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}

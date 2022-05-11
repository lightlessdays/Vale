import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valecode/models/cover_model.dart';
import 'package:valecode/pages/browserpage.dart';
import 'package:valecode/pages/loader.dart';
import 'package:valecode/pages/login/login.dart';

class ProductPage extends StatelessWidget {
  final int selectedcolor;
  final CoverModel coverModel;
  const ProductPage(
      {Key? key, required this.coverModel, this.selectedcolor = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () { 
                  // ignore: non_constant_identifier_names
                  var FirebaseEmail = FirebaseAuth.instance.currentUser?.email;
                  FirebaseFirestore.instance
                      .collection("$FirebaseEmail")
                      .doc(coverModel.title)
                      .set({'title': coverModel.title, 'url': coverModel.url});

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => (FirebaseEmail == null)
                          ? const LogInScreen()
                          : const CartLoader()));
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: const Center(
                      child: Text(
                    "ADD TO CART",
                    style: TextStyle(
                        fontFamily: 'PoppinsSemiBold',
                        fontSize: 14.0,
                        color: Colors.black),
                  )),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WebPage(
                          url:
                              "https://razorpay.com/payment-link/plink_JTpMEtx5p19zgx")));
                },
                child: Container(
                  height: 80,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 14.0,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      coverModel.title.replaceAll('\\n', '\n'),
                      style: const TextStyle(
                          color: Color(0x34000000),
                          fontSize: 39.0,
                          fontFamily: 'PoppinsSemiBold'),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      coverModel.brand.replaceAll('\\n', '\n'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 17.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.75),
                    onPageChanged: (page) {},
                    itemCount: 2,
                    pageSnapping: true,
                    itemBuilder: (context, pagePosition) {
                      return Container(
                          margin: const EdgeInsets.all(10),
                          child: CachedNetworkImage(
                              imageUrl: coverModel.urlofimages[
                                  pagePosition + (selectedcolor * 2)]));
                    }),
              ),
              const Center(
                child: Text(
                  "\$69.0",
                  style:
                      TextStyle(fontSize: 30.0, fontFamily: 'PoppinsSemiBold'),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: coverModel.colors.length,
                      mainAxisExtent: 30,
                      childAspectRatio: 1 / 1),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: coverModel.colors.length,
                  itemBuilder: (BuildContext context, index) {
                    return CircleAvatar(
                      backgroundColor: toColor(coverModel.colors[index]),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ProductPage(
                                          coverModel: coverModel,
                                          selectedcolor: index,
                                        ),
                                transitionDuration:
                                    const Duration(milliseconds: 0)),
                          );
                        },
                        child: CircleAvatar(
                            radius: 12.5,
                            backgroundColor: (selectedcolor == index)
                                ? toColor(coverModel.colors[index])
                                : Colors.white),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

//function to convert hexadecimal Strings to Colors
toColor(String hex) {
  var hexColor = hex.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}

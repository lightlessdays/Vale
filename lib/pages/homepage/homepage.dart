import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valecode/pages/listofproducts/loader.dart';
import 'package:valecode/pages/loader.dart';
import 'package:valecode/pages/login/login.dart';
import 'package:valecode/pages/login/register.dart';
import 'footer.dart';
import 'collections.dart';
import 'bottomimagetext.dart';
import 'drawermenu.dart';

//These are the images for homescreen in list format
final List<String> hatCategories = [ ''
  "https://i.pinimg.com/originals/18/87/a6/1887a646e1196c8d1c639b12a018ad8a.jpg",
  "https://i.pinimg.com/originals/35/60/75/3560757687265a2856ee0b5e36dd1376.jpg",
  "https://i.pinimg.com/originals/66/43/68/664368b3faa0dc5e6799eaa354cbba0f.jpg",
  "https://i.pinimg.com/originals/6c/20/b2/6c20b2c71e0fce9679822e28b8dc83ef.jpg",
];

var _auth=FirebaseAuth.instance;
// ignore: non_constant_identifier_names
final List<String> URLs = ['classic', 'beanie', 'visor', 'hat'];

class HomePage extends StatelessWidget { const
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
          backgroundColor: const Color(0xFF070707),
          child: (FirebaseAuth.instance.currentUser != null)
              ? Container(
                  height: 150,
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Icon(Icons.account_circle,color: Colors.white,size: 90,),
                const SizedBox(height: 25,),
                DrawerMenu(text: "${_auth.currentUser?.email}", function: (){}),
                const Divider(color: Colors.grey,),
                DrawerMenu(text: "Shopping Cart", function: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CartLoader()
                    ),
                  );
                }),
                DrawerMenu(text: "Log out", function: () async {
                  await _auth.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                      const HomePage(),
                    ),
                  );
                }),
              ],
            ),
                )
              : Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      DrawerMenu(
                        text: "Register",
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegistrationScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DrawerMenu(
                        text: "Log In",
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const LogInScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://i.pinimg.com/originals/16/41/56/164156ea67abb926201568fa67f42d8c.jpg",
                width: double.infinity,
              ),
              const SizedBox(
                height: 55.0,
              ),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Loader(URLs[index], "default"),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: hatCategories[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  }),
              const SizedBox(
                height: 45.0,
              ),
              const Text(
                "Explore Collections",
                style: TextStyle(
                  fontFamily: "PoppinsExtraLight",
                  fontSize: 32.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Column(
                children: const [
                  CollectionWidget(
                      index1:
                          "https://i.pinimg.com/originals/5f/82/51/5f82513e6c045f3932afd8a876df0fb8.jpg",
                      index2:
                          "https://i.pinimg.com/originals/e3/67/40/e367401150d64513e4446b366dad2516.jpg",
                      brand1: 'flexfit',
                      brand2: 'sportsman'),
                  CollectionWidget(
                      index1:
                          "https://i.pinimg.com/originals/89/d6/8b/89d68b2af420d418748cb249cacafabb.jpg",
                      index2:
                          "https://i.pinimg.com/originals/e5/a1/bb/e5a1bbdb8266e73d33ec61a8ab6b10d6.jpg",
                      brand1: 'richardson',
                      brand2: 'beechfield'),
                  CollectionWidget(
                      index1:
                          "https://i.pinimg.com/originals/7d/2a/0c/7d2a0cb337cd8e10dca8f12a83e7071d.jpg",
                      index2:
                          "https://i.pinimg.com/originals/f9/9b/e3/f99be30fd49ec44cb68d709c5b315b35.jpg",
                      brand1: 'otto',
                      brand2: 'yupoong')
                ],
              ),
              const SizedBox(
                height: 68.0,
              ),
              const BottomImageText(
                text:
                    'every piece of headwear ordered is hand prepared by us at one of our shops at Italy, China and France, before it is shipped to you.\n\n',
                image:
                    'https://i.pinimg.com/originals/ce/69/33/ce69334f2419500ec3e49109f96f9902.jpg',
              ),
              const BottomImageText(
                text:
                    'we work with the best fabric sourced exclusively from Italy, drawing from our unique Italian heritage and craftsmanship, with scrupulous attention to quality and fit.\n\n',
                image:
                    'https://i.pinimg.com/originals/6a/b0/4b/6ab04b278e07031882790ffb69588901.jpg',
              ),
              const BottomImageText(
                text:
                    'a hat from vale is a hat for life. the hats we supply are made with best materials from around the globe. if taken care of properly, our hats can last a lifetime!\n\n',
                image:
                    'https://i.pinimg.com/originals/6d/cd/81/6dcd812e41f708cd96b8a38b3a977e7b.jpg',
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}






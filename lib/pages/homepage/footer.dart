import 'package:flutter/material.dart';
import 'footer_menu.dart';

class Footer extends StatelessWidget { const
  Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:35.0 ,vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("     "),
                Image.asset("images/vale.png",width: 150.0,)
              ],
            ),
            const SizedBox(height: 10.0,),
            const Text("      Vale is a luxury headwear brand that was originated in Italy, around 50 years ago. As a family business, our hats have gone through generations of design changes that helped us to redesign and redefine the headwear industry. Drawing from our unique Italian heritage and craftsmanship, we create both traditional and modern hat designs, with great attention to quality and fit. Each hat purchased is carefully and expertly hand-prepared in our shops in China by our skilled craftsmen. Each hat is made from quality materials imported from our textile industry in France and Italy. Everytime you wear our hats, you will be reminded of the process that each hat went through.",style: TextStyle(color: Colors.white,fontFamily: "PoppinsLight"),),
            const SizedBox(height: 30.0,),
            Row(

              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      FooterMenu(text: '      About Vale', url: 'https://github.com/lightlessdays/vale',),
                      FooterMenu(text: '      Store Locator',url: 'https://www.google.com/maps/d/u/0/edit?mid=1t5tMuinZCkta4oecCo9QlKO5GWtTKl4Y&usp=sharing/',),
                      FooterMenu(text: '      Return a Product',url: 'https://notacceptingreturns.carrd.co/',),
                    ],
                  ),

                ),
                const SizedBox(width: 30.0,),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      FooterMenu(text: '      Privacy Policy',url: 'https://privacypolicyforvale.carrd.co/',),
                      FooterMenu(text: '      Returns Policy',url: 'https://notacceptingreturns.carrd.co/',),
                      FooterMenu(text: '      Terms of Use',url: 'https://termsofusecardfucck.carrd.co/',),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


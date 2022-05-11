import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:valecode/models/cover_model.dart';
import 'package:valecode/pages/listofproducts/loader.dart';
import 'package:valecode/pages/productpage.dart';

// ignore: must_be_immutable
class ListofProducts extends StatelessWidget {
  List<CoverModel> covermodels=[];
  ListofProducts(this.covermodels, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                    return ListView(
                      children: [
                        GestureDetector(
                          onTap:(){
                            covermodels.sort((a,b){return a.title.compareTo(b.title);});
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ListofProducts(covermodels),
                            ),);

                          },
                            child: const ListTile(title: Text('Alphabetically (A-Z)',style: TextStyle(fontSize: 14.0,fontFamily: 'PoppinsSemiBold'),),)),
                        GestureDetector(
                            onTap:(){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ListofProducts(covermodels),
                                ),);

                            },
                            child: const ListTile(title: Text('by Price',style: TextStyle(fontSize: 14.0,fontFamily: 'PoppinsSemiBold'),),))
                      ],
                    );
                  });
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "SORT ",
                          style: TextStyle(
                              fontFamily: 'PoppinsSemiBold',
                              fontSize: 14.0,
                              color: Colors.black),
                        ),
                        Icon(
                          Icons.swap_vert,
                          color: Colors.black,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                    return ListView(
                      children: const [
                        ExpansionTile(title: Text('by Brand',style: TextStyle(color: Colors.black,fontFamily: 'PoppinsSemiBold',fontSize: 20),),children: [
                          FilterMenu(brandName: 'FlexFit',),
                          FilterMenu(brandName: 'Sportsman',),
                          FilterMenu(brandName: 'Otto',),
                          FilterMenu(brandName: 'Yupoong',),
                        ],),
                        ExpansionTile(title: Text('by Category',style: TextStyle(color: Colors.black,fontFamily: 'PoppinsSemiBold',fontSize: 20),),children: [
                          FilterMenu(hatCategory:  'Hat',),
                          FilterMenu(hatCategory: 'Visor',),
                          FilterMenu(hatCategory: 'Beanie',),
                          FilterMenu(hatCategory: 'Classic',),
                        ],)
                      ],
                    );
                  });
                },
                child: Container(
                  height: 80,
                  color: Colors.black,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "FILTER ",
                          style: TextStyle(
                              fontFamily: 'PoppinsSemiBold',
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.filter_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  ' a hat for life.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 39.0,
                      fontFamily: 'PoppinsSemiBold'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3 / 4.2),
                  shrinkWrap: true,
                  itemCount: covermodels.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductPage(coverModel: covermodels[index],),
                      ),
                    );},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.black, width: 0.8),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(imageUrl: covermodels[index].url),
                          Text(
                            "\n${covermodels[index].title.replaceAll('\\n', ' ')}",
                            style: const TextStyle(
                                fontFamily: 'PoppinsLight', fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterMenu extends StatelessWidget {
  final String brandName;
  final String hatCategory;
  const FilterMenu({
    Key? key, this.brandName="default", this.hatCategory="default"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                Loader(hatCategory.toLowerCase(),brandName.toLowerCase()) ),
        );
      },
        child: ListTile(title: (brandName=="default")?Text(hatCategory):Text(brandName),));
  }
}

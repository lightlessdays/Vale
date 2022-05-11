import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:valecode/models/cover_model.dart';
import 'package:valecode/pages/listofproducts/listofproducts.dart';

List<CoverModel> covermodels = [];

class Loader extends StatefulWidget {
  final String filterHat;
  final String filterBrand;
  const Loader(this.filterHat, this.filterBrand, {Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  final databaseReference = FirebaseFirestore.instance;
  bool finishedLoading = true;
  @override
  void initState() {
    covermodels = [];
    super.initState();
    fetchDataCaller();
  }

  Future<void> fetchDataCaller() async {
    await fetchData();
   // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListofProducts(covermodels)));}

  Future<void> fetchData() async {
    String filterBrand = widget.filterBrand;
    String filterHat = widget.filterHat;
    var data = await databaseReference.collection("Covers").get();
    for (int i = 0; i < data.docs.length; i++) {
      var docData=data.docs[i].data();
      String typeofHat = docData['type'];
      String nameOfBrand = docData['brand'];
      CoverModel model = CoverModel(
        docData['title'],
        nameOfBrand,
        docData['url'],
        typeofHat,
          List.from(docData['colors']),
          List.from(docData['images'])
      );
      if (filterBrand == "default") {
        if (filterHat == typeofHat) {
          covermodels.add(model);
        }
      } else {
        if (filterBrand == nameOfBrand) {
          covermodels.add(model);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Padding(
        padding: EdgeInsets.all(46.0),
        child: Center(
          child: Text(
            'how a hat makes you feel is what it is all about.',
            style: TextStyle(fontFamily: 'PoppinsSemiBold', fontSize: 34),
          ),
        ),
      ),
    );
  }
}
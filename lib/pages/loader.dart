import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valecode/models/cart_model.dart';
import 'package:valecode/pages/shoppingcart.dart';

List<CartModel> cartmodels=[];

class CartLoader extends StatefulWidget {
  const CartLoader({Key? key}) : super(key: key);

  @override
  State<CartLoader> createState() => _CartLoaderState();
}

class _CartLoaderState extends State<CartLoader> {
  final cartReference=FirebaseFirestore.instance;
  
  @override
  void initState(){
    cartmodels=[];
    super.initState();
    fetchDataCaller();
  }
  
  Future<void> fetchDataCaller() async
{
    await fetchData();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ShoppingCart(cartmodel: cartmodels,)));}

  @override
  Widget build(BuildContext context) {
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
  
  Future<void>fetchData()async{
  var data= await FirebaseFirestore.instance.collection(
      "${FirebaseAuth.instance.currentUser?.email}").get();
  for(int i=0;i<data.docs.length;i++){
    var docData=data.docs[i].data();
    CartModel model=CartModel(docData['title'], docData['url']);
    cartmodels.add(model);
  }
  }
  
  
  





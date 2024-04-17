import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../cart_screen/view/cart_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var itemname = [
    'Apple',
    'Banana',
    'Grape',
    'Kiwi',
    'Mango',
    'Orange',
    'Watermelon'
  ];
  var item = [
    'assets/images/apple.png',
    "assets/images/banana.png",
    "assets/images/grape.png",
    "assets/images/kiwi.png",
    "assets/images/mango.png",
    "assets/images/orange.png",
    "assets/images/watermelon.png"
  ];
  var itemprice = ["90", "50", "85", "40", "70", "60", "55"];

  int _cartCount = 0;
  List<String> _cartItemNames = [];
  List<String> _cartItemPrices = [];
  List<String> _cartItemImages = [];

  void addToCart(String itemName, String itemPrice, String itemImage) {
    setState(() {
      _cartItemNames.add(itemName);
      _cartItemPrices.add(itemPrice);
      _cartItemImages.add(itemImage);
      _cartCount = _cartItemNames.length; // Update _cartCount
    });
  }

  void removeFromCart(int index) {
    setState(() {
      _cartItemNames.removeAt(index);
      _cartItemPrices.removeAt(index);
      _cartItemImages.removeAt(index);
      _cartCount = _cartItemNames.length; // Update _cartCount
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products",style:TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 1, end: 1),
            badgeContent: Text(
              "$_cartCount",
              style: TextStyle(color: Colors.white),
            ),
            child: Center(
              child: IconButton(
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        itemNames: _cartItemNames,
                        itemPrices: _cartItemPrices,
                        itemImages: _cartItemImages,
                        removeFromCart: removeFromCart,
                      ),
                    ),
                  );
                }, // Navigate to CartScreen
                icon: Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itemname.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Image.asset(item[index]),
                      title: Text(
                        itemname[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "KG" + " " + r"$" + itemprice[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      trailing: MaterialButton(
                        onPressed: () {
                          addToCart(itemname[index], itemprice[index], item[index]);
                        },
                        color: Colors.yellow,
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

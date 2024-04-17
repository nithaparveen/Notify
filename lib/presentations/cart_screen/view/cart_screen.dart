import 'package:flutter/material.dart';
class CartScreen extends StatefulWidget {
  final List<String> itemNames;
  final List<String> itemPrices;
  final List<String> itemImages;
  final Function(int) removeFromCart;

  CartScreen({
    required this.itemNames,
    required this.itemPrices,
    required this.itemImages,
    required this.removeFromCart,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart',style:TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.itemNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(widget.itemImages[index]),
            title: Text(widget.itemNames[index]),
            subtitle: Text('\$${widget.itemPrices[index]}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.removeFromCart(index);
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
              Text(
                '\$${calculateTotal(widget.itemPrices)}',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            widget.itemNames.clear();
            widget.itemPrices.clear();
            widget.itemImages.clear();
          });
        },
        label: Text('Delete All'),
        icon: Icon(Icons.delete_forever),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String calculateTotal(List<String> prices) {
    double total = 0;
    for (var price in prices) {
      total += double.parse(price);
    }
    return total.toStringAsFixed(2);
  }
}

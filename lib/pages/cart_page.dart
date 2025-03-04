import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
              radius: 30,
            ),
            trailing: IconButton(onPressed: () {
              showDialog(
                barrierDismissible: true,
               context: context,
               builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Delete Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  content: Text(
                    'Are you sure you want to remove this product from cart ?'
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("No",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),)),
                    TextButton(onPressed: (){
                      context.read<CartProvider>().removeProduct(cartItem);
                      Navigator.of(context).pop();
                    }, child: Text("Yes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ))),
                  ],
                );
               }
              );
            }, icon: const Icon(Icons.delete, color: Colors.red,),),
            title: Text(cartItem['title'].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Size : ${cartItem['size']}"),
          );
        },
      )
    );
  }
}
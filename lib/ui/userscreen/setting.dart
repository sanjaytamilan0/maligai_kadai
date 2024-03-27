import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/ui/userscreen/cart.dart';

class Setting extends StatelessWidget {
  Setting({Key? key});

  Future<void> addToCart(DocumentSnapshot product) async {
    try {
      final QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('carts')
          .where('name', isEqualTo: product['name'])
          .get();
      if (cartSnapshot.docs.isNotEmpty) {
        print('Item already exists in the cart.');
        return ;
      }
      await FirebaseFirestore.instance.collection('carts').add({
        'cartId': FirebaseFirestore.instance.collection('carts').doc().id,
        'name': product['name'],
        'description': product['description'],
        'price': product['price'],
        'image': product['imageURL'],
        'Qty': 1,
        'cartPrice': product['price']
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No products found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final product = snapshot.data!.docs[index];
              return ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product['imageURL'] ?? 'no image'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Text(product['name'] ?? ''),
                subtitle: Text(product['description'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('₹ ${product['price'] ?? ''}'),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                           addToCart(product);
                      },
                      child: const Text('Add to Cart'),
                    ),

                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shoes extends StatefulWidget {
  const Shoes({super.key});

  @override
  State<Shoes> createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final shoe = snapshot.data?.docs[index];
                return ListTile(
                  title: Text(shoe?['category'] ?? 'No category'),
                  subtitle: Text(shoe?['id'] ?? 'No id'),
                  onTap: () {
                    // Example of setting values in Firestore
                    FirebaseFirestore.instance.collection('categories').doc(shoe?.id).set({
                      'category': 'shoes',
                      // 'id': 'new_id_value'
                      // Add other fields as needed
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

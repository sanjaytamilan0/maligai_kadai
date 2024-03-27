import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img_upload_cubit.dart';

class Cart extends StatelessWidget {
  Cart({
    super.key,
  });

  final fireIns = FirebaseFirestore.instance.collection('carts');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: fireIns.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final localCart = snapshot.data?.docs[index];
                  return Row(
                    children: [
                      SizedBox(
                        height: 160,
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            localCart?['image'] ??
                                                'no image'))),
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(localCart?['name'] ?? '!'),
                                    Text(localCart?['description'] ?? '!'),
                                    Text('₹ ${localCart?['price']}')
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 66,
                                child: Center(
                                    child: Container(
                                  width: 66,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            final QuerySnapshot snapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('carts')
                                                    .where('name',
                                                        isEqualTo:
                                                            localCart?['name'])
                                                    .get();

                                            for (var doc in snapshot.docs) {
                                              doc.reference.update({
                                                'Qty': 1 + localCart?['Qty'],
                                                'cartPrice':
                                                 ( localCart?['Qty'] * int.parse(localCart?['cartPrice'])).toString()
                                              }).then((_) {
                                                print(
                                                    'Document ${doc.id} updated successfully.');
                                              }).catchError((error) {
                                                print(
                                                    'Error updating document ${doc.id}: $error');
                                              });
                                            }
                                          },
                                          child:
                                              const Icon(Icons.arrow_drop_up)),
                                      Text(localCart!['Qty'].toString()),
                                      InkWell(
                                          onTap: () async {
                                            final QuerySnapshot snapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('carts')
                                                    .where('name',
                                                        isEqualTo:
                                                            localCart?['name'])
                                                    .get();

                                            for (var doc in snapshot.docs) {
                                              doc.reference.update({
                                                'Qty': localCart?['Qty'] - 1,
                                                'cartPrice': int.parse(
                                                        localCart?['price']) -
                                                    int.parse(
                                                        localCart?['cartPrice'])
                                              }).then((_) {
                                                print(
                                                    'Document ${doc.id} updated successfully.');
                                              }).catchError((error) {
                                                print(
                                                    'Error updating document ${doc.id}: $error');
                                              });
                                            }
                                          },
                                          child:
                                              const Icon(Icons.arrow_drop_down))
                                    ],
                                  ),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            BlocProvider.of<ImageUploadCubit>(
                                                    context)
                                                .removeFromCart(localCart!.id);
                                          },
                                          child: const Icon(Icons.close)),
                                      const SizedBox(
                                        height: 29,
                                      ),
                                      Text(localCart['cartPrice'].toString())
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          }
        });
  }
}

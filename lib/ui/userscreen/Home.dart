import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img.cubit.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img_upload_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  bool isFavorite = false;
  var viewAllColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    final witdh = MediaQuery.of(context).size.width;
    print(witdh);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            height: witdh / 3.2,
            child: StreamBuilder<QuerySnapshot>(
              stream: context.read<ImageCubit>().categoryDb.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final catry = snapshot.data?.docs;
                  return AnotherCarousel(
                    boxFit: BoxFit.cover,
                    images: catry?.map((doc) {
                      return NetworkImage(doc['categoryImage']);
                    }).toList() ?? [],
                  );
                }
              },
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 25,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('All Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text('View all >',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: viewAllColor,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            width: witdh,
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: snapshots.data?.docs.length,
                      itemBuilder: (context, index) {
                        final myGatoreries = snapshots.data?.docs[index];
                        return Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          myGatoreries?['categoryImage']))),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 20,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child:
                                    Center(child: Text(myGatoreries?['category'])),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: witdh,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Hot Deals',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'View all >',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: viewAllColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: witdh,
            height: 200,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshots.hasError) {
                  return const Text('this screen have some error');
                } else {
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 4,
                      childAspectRatio: 1,
                    ),
                    itemCount: snapshots.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final myHotProduct = snapshots.data?.docs[index];
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    myHotProduct?['imageURL'],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 32,
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text('₹ ${myHotProduct?['price']}'),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      },
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite
                                            ? Colors.red
                                            : Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: witdh,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Drinks Parole',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'View all >',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: viewAllColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: witdh,
            height: 160,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshots.hasError) {
                  return Text('No data');
                } else {
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 4,
                      childAspectRatio: 1,
                    ),
                    itemCount: snapshots.data?.docs.length,
                    // Use the length of productList
                    itemBuilder: (BuildContext context, int index) {
                      final myProduct = snapshots.data?.docs[index];

                      return Card(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    myProduct?['imageURL'] ??
                                        '', // Remove quotes around productList[index].image
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text('₹ ${myProduct?['price']}'),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<ImageUploadCubit>()
                                            .addToCart(myProduct!);
                                      },
                                      icon: const Icon(Icons.shopping_cart)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

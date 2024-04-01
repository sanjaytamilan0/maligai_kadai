import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class Favorite extends StatefulWidget {
  Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final myHeight = MediaQuery.of(context).size.height;
    final myWidth = MediaQuery.of(context).size.width;
    print(myHeight);
    print(myWidth);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'MY FAVORITE',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                IconButton(onPressed: () {}, icon: Icon(Icons.access_alarm)),
                IconButton(onPressed: () {}, icon: Icon(Icons.person_off))
              ],
            ),
          ],
        ),
        Center(
          child: Text(
            'favorites',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
        SizedBox(
          height: 23,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where('favorite', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final favoriteProducts = snapshot.data!.docs;

                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2 / 3,
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 6
                      ),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return
                          Stack(
                          children: [
                            Container(
                              height: 150,


                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(product['imageURL']

                                ),fit: BoxFit.cover)
                              ),
                            ),
                                    Positioned(
                                      left:0,top: 0,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: product['favorite']
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.red,
                                                )),
                                    ),
                                    // Positioned(
                                    //   top:50,
                                    //   left:30,
                                    //   child: Container(
                                    //     height: 100,
                                    //     width: 100,
                                    //     decoration: BoxDecoration(
                                    //         image: DecorationImage(
                                    //             fit: BoxFit.fill,
                                    //             image: NetworkImage(
                                    //                 product['imageURL']))),
                                    //
                                    // ),

                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     // IconButton(onPressed: () {}, icon: product['favorite'] ?  Icon(Icons.favorite,
                                    //     //   color: Colors.red,
                                    //     // ):
                                    //     //     Icon(Icons.favorite_border,
                                    //     //       color: Colors.red,
                                    //     //     )
                                    //     // ),
                                    //     // IconButton(
                                    //     //     onPressed: () {},
                                    //     //     icon: Icon(Icons.close)),
                                    //   ],
                                    // ),
                                    // Center(
                                    //   // child: Container(
                                    //   //   height: 100,
                                    //   //   width: 100,
                                    //   //   decoration: BoxDecoration(
                                    //   //       image: DecorationImage(
                                    //   //           fit: BoxFit.fill,
                                    //   //           image: NetworkImage(
                                    //   //               product['imageURL']))),
                                    //   // ),
                                    // ),

                            // ),
                            Positioned(
                              right:0,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.close)),
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
        ),
      ],
    );
  }
}

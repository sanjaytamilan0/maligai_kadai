import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img.cubit.dart';

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
    final imgCubit = context.read<ImageCubit>();
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
                'My Favorite',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [


                !imgCubit.searchbar
                    ? Container(
                                      color: Colors.white,
                      width: 150,
                      height: 30,
                      child: TextField(

                        decoration: InputDecoration(
                          icon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  imgCubit.searchbar = !imgCubit.searchbar;
                                });
                                print(imgCubit.searchbar);

                                print('_______=============________');
                              },
                              child: Icon(Icons.search)),
                        ),
                      ),
                    )
                    :
                   GestureDetector(
                       onTap: (){
                         setState(() {
                           imgCubit.searchbar = !imgCubit.searchbar;
                         });

                         print(imgCubit.searchbar);

                         print('_______________');
                       },
                       child: Icon(Icons.search)),

                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('favorite', isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            top: 7,
                            right: 15,
                            child: Center(
                                child:
                                    CircularProgressIndicator()), // Show a loading indicator while fetching data
                          ),
                        ],
                      );
                    } else {
                      final favoriteProducts = snapshot.data!.docs;
                      final favoriteCount = favoriteProducts.length;

                      return Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            top: 7,
                            right: 15,
                            child: Text(
                              '$favoriteCount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),

              ],
            ),
          ],
        ),
        SizedBox(
          height: 23,
        ),
        Expanded(
          child: Padding(
            padding: myWidth > 600
                ? const EdgeInsets.only(left: 90, right: 90, top: 100)
                : const EdgeInsets.only(left: 25, right: 25, top: 20),
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
                      gridDelegate: myWidth > 600
                          ? SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:3/2,
                              crossAxisCount: 4,
                              crossAxisSpacing: 17,
                              mainAxisSpacing: 7)
                          : SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2 /3,
                              crossAxisCount: 3,
                              crossAxisSpacing: 27,
                              mainAxisSpacing: 5),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        final productId = product.id;
                        final isFavorite = product['favorite'];
                        return Stack(
                          children: [
                            Container(
                              height:myWidth > 600? 250: 150,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset.zero,
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(product['imageURL']),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: IconButton(
                                  hoverColor: Colors.transparent,
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(productId)
                                        .update({'favorite': !isFavorite});
                                  },
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
                              right: 0,
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.close)),
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

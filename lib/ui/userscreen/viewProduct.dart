import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img.cubit.dart';

class ViewProduct extends StatefulWidget {
  ViewProduct({Key? key}) : super(key: key);

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products')
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
                            child: CircularProgressIndicator(), // Show a loading indicator while fetching data
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
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.access_alarm)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.person_off))
              ],
            ),
          ],
        ),
        myWidth > 800
            ? SizedBox(
          height: 60,
        )
            : SizedBox(
          height: 6,
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
                          childAspectRatio: 4 / 4,
                          crossAxisCount: 5,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 9)
                          : SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2 / 3,
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 6),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        final productId = product.id;
                        final isFavorite = product['favorite'];
                        return Stack(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
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
                                  icon: isFavorite
                                      ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                      : Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  )),
                            ),
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

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/colors/colors.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img.cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Shoes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var viewAllColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    final witdh = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(witdh);
    return SingleChildScrollView(
        child: Column(children: [
      const SizedBox(
        height: 5,
      ),
      witdh > 500
          ? Container(
              height: height * 0.84,
              width: witdh,
              child: StreamBuilder(
                stream: context.read<ImageCubit>().categoryDb.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.flickr(
                        leftDotColor: const Color(0xFF1A1A3F),
                        rightDotColor: Color.fromARGB(255, 12, 110, 42),
                        size: 50,
                      ),


                        // child: const CircularProgressIndicator()
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final catry = snapshot.data?.docs;
                    return AnotherCarousel(
                      boxFit: BoxFit.cover,
                      images: catry?.map((doc) {
                            return NetworkImage(doc['categoryImage']);
                          }).toList() ??
                          [],
                    );
                  }
                },
              ),
            )
          : Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:LoadingAnimationWidget.fourRotatingDots(
                        color: Color.fromARGB(255, 12, 110, 42),
                        size: 50,
                      ),
                    );
                    // return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final products = snapshot.data?.docs ?? [];
                  return CarouselSlider(
                    items: products.map((doc) {
                      String imageURL = doc['categoryImage'] ?? '';
                      return Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(imageURL),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      // Adjust carousel options as needed
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                    ),
                  );
                },
              ),
            ),
      SizedBox(
        height: 5,
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(color: MyColors.appbarColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            const Text('Special Category',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              width: witdh,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Center(
                  child: Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Center(
                            child: SizedBox(
                              width: 300,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 3,
                                ),
                                itemCount: snapshots.data?.docs.length,
                                itemBuilder: (context, index) {
                                  final myGatoreries =
                                      snapshots.data?.docs[index];
                                  return Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Shoes()));
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
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
                                              image: NetworkImage(myGatoreries?[
                                                  'categoryImage']),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Center(
                                              child: Text(
                                                  myGatoreries?['category'])),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
          color: MyColors.appbarColor,
          child: Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              const Text('All Products',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: witdh,
                // Adjust width according to your layout needs
                height: witdh * 3,
                // Adjust height according to your layout needs
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshots.hasError) {
                      return Text('This screen has some error');
                    } else {
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: witdh > 800
                            ? const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.8,
                              )
                            : SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.8,
                              ),
                        itemCount: snapshots.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final myHotProduct = snapshots.data?.docs[index];

                          return Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 300,
                                    height:
                                        witdh > 540 ? (witdh / 2) - 10 : 228,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          myHotProduct?['imageURL'],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 38,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Price: ₹ ${myHotProduct?['price']},',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        myHotProduct?['name'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
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
          ))
    ]));
  }
}

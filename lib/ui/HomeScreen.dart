import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/log_out_cubit.dart';
import 'package:flutter_store/colors/colors.dart';
import 'package:flutter_store/routes/routes_name.dart';
import 'package:flutter_store/ui/userscreen/Home.dart';
import 'package:flutter_store/Widgets/Register.dart';
import 'package:flutter_store/ui/userscreen/admin_catogery_addscreen.dart';
import 'package:flutter_store/ui/userscreen/cart.dart';
import 'package:flutter_store/ui/userscreen/favorite.dart';
import 'package:flutter_store/ui/userscreen/product_adding.dart';
import 'package:flutter_store/ui/userscreen/setting.dart';
import 'package:flutter_store/ui/userscreen/viewProduct.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController appSearch = TextEditingController();

  int selectedScreen = 0;
  final auth=FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    List screens = [
      const Home(),
     Cart(),

      if (auth  == 'sanjay@gmail.com') ...[
        const AdminCategoryAddScreen(),
       AddProduct() ,

      ]
      else...[
        Favorite(),
         ViewProduct()
     ],

      Setting(),

    ];


    return Scaffold(

      appBar: PreferredSize(

        preferredSize: Size.fromHeight(100),

        child: AppBar(
          toolbarHeight: 100,
          backgroundColor: MyColors.appbarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   const Text('BUY',
                    style:
                    TextStyle(
                      color: Colors.black,
                      fontSize: 25
                    ),
                  ),
                  SizedBox(width: 8,),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                       RotateAnimatedText('New',),
                      RotateAnimatedText('Trends'),
                      RotateAnimatedText('Best'),
                    ],
                  )
                ],
              ),
              width > 600?
              Container(
                width: width/2.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(

                      focusColor: MyColors.buttonSecondColor,
                      splashColor: MyColors.buttonColor,

                      onTap: () {
                        context.goNamed(RoutesName.home);
                      },
                      child: Container(

                        child: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 15,
                            color:Colors.black,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.goNamed(RoutesName.cart);
                      },
                      child: Container(

                        child: const Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 15,
                            color:Colors.black,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.goNamed(RoutesName.favorite);
                      },
                      child: Container(

                        child: Text(
                          'Favorite',
                          style: TextStyle(
                            fontSize: 15,
                            color:Colors.black,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.goNamed(RoutesName.user);
                      },
                      child: Container(

                        child: Text(
                          'User',
                          style: TextStyle(
                            fontSize: 15,
                            color:Colors.black,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.goNamed(RoutesName.setting);
                      },
                      child: Container(

                        child: Text(
                          'Setting',
                          style: TextStyle(
                            fontSize: 15,
                            color:Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ):
              Container(
              ),
            ],
          ),
          actions: [
            BlocConsumer<LogOutCubit, LogOutState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    const Text('LogOut'),
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Logout'),
                              content: const Text('Are you sure you want to log out?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    print("Logging out...");
                                    await context.read<LogOutCubit>().signOut();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.exit_to_app),
                    ),
                  ],
                );
              },
            ),
          ],
        ),

      ),

      bottomNavigationBar: width > 600? null:  BottomNavigationBar(
        elevation:20,
        currentIndex:selectedScreen,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.green,
        type:BottomNavigationBarType.fixed ,
        selectedLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight:FontWeight.bold,
            fontSize: 14
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined,
              color: Colors.black,
            ),
            label: 'Store',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            label: 'Cart',

          ),
          BottomNavigationBarItem(
            icon:  Icon(auth == 'sanjay@gmail.com'? Icons.category: Icons.favorite_border,
              color: Colors.black,),
            label:  auth == 'sanjay@gmail.com'? 'CategoryAssigning' :'Favorites',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.details_outlined,
              color: Colors.black,),
            label : auth == 'sanjay@gmail.com'? 'Admin Screen' : 'User',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.cabin_outlined,
            color: Colors.black,
          ),

            label: 'Settings',
          )],
        onTap: (index){
          setState(() {
            selectedScreen = index ;

          });
        },
      )
      ,
      body:
      // state is ImageUploading? Center(
    //     child: CircularProgressIndicator(),
    // ):

      screens[
      selectedScreen
      ],
    );
  // },
// );
  }
}


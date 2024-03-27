import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/log_out_cubit.dart';
import 'package:flutter_store/User/login_cubit.dart';
import 'package:flutter_store/User/register_cubit.dart';
import 'package:flutter_store/Widgets/web_customDrag.dart';
import 'package:flutter_store/firebase_options.dart';
import 'package:flutter_store/routes/routes_config.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img.cubit.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img_upload_cubit.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/product_cubit/product_cubit.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ImageCubit()
          ),
          BlocProvider(
            create: (context) => RegistrationCubit(),
          ),
          BlocProvider(
            create: (context) =>LoginCubit(),
          ),
          BlocProvider(
            create: (context) =>LogOutCubit(),
          ),
          BlocProvider(
            create: (context) =>ImageUploadCubit(),
          ),
          BlocProvider(
              create:(context) => ProductCubit()..fetchProducts()
          )
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return  MaterialApp.router(

      routerConfig: RouteConfig.returnRouterName(),

      scrollBehavior: WebCustomScrollView(),


      // home:auth.currentUser!= null? HomeScreen():  Login(),
      debugShowCheckedModeBanner: false,
      // home: UserScreen(),

    );
  }
}















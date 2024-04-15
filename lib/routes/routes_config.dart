import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/Widgets/Login.dart';
import 'package:flutter_store/Widgets/Register.dart';
import 'package:flutter_store/Widgets/forget_password.dart';
import 'package:flutter_store/Widgets/otp_screen.dart';
import 'package:flutter_store/admin/Setting/setting_ui/profile.dart';
import 'package:flutter_store/admin/add_product/add_product_ui/add_product.dart';
import 'package:flutter_store/admin/admin_dashboard/admin_dashboard_ui/admin_dashboard.dart';
import 'package:flutter_store/routes/routes_name.dart';
import 'package:flutter_store/ui/HomeScreen.dart';
import 'package:flutter_store/ui/userscreen/cart.dart';
import 'package:flutter_store/ui/userscreen/setting.dart';
import 'package:flutter_store/ui/userscreen/user_home/user_home.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class RouteConfig {
  static GoRouter returnRouterName() {
    final auth = FirebaseAuth.instance;
    return GoRouter(initialLocation: '/', routes: [
      GoRoute(
        path: '/',
        name: RoutesName.initial,
        pageBuilder: (context, state) {
          return MaterialPage(
              child: auth.currentUser != null
                  ? auth.currentUser?.email == 'sanjay@gmail.com'
                      ? AdminDashBoard()
                      : HomeScreen()
                  : Register());
        },
      ),
      GoRoute(
          path: '/login',
          name: RoutesName.login,
          pageBuilder: (context, state) {
            return const MaterialPage(child: Login());
          },
          routes: [
            GoRoute(path:'userHome',
              name: RoutesName.userHome,
              pageBuilder: (context, state) {
                return MaterialPage(child: UserHome());
              },

            ),
            GoRoute(
                path: 'adminDashBoard',
                name: RoutesName.adminDashBoard,
                pageBuilder: (context, state) {
                  return MaterialPage(child: AdminDashBoard());
                },
                routes: [
                  GoRoute(
                      path: 'addProduct',
                      name: RoutesName.addProduct,
                      pageBuilder: (context, state) {
                        return MaterialPage(child: AddProduct());
                      }),
                  GoRoute(
                      path: 'profile',
                      name: RoutesName.profile,
                      pageBuilder: (context, state) {
                        return MaterialPage(child: Profile());
                      }),
                ]),
            GoRoute(
                path: 'otpScreen',
                name: RoutesName.otpScreen,
                pageBuilder: (context, state) {
                  return MaterialPage(
                      child: OTPScreen(phoneNumber: '6383266214'));
                }),
            GoRoute(
                path: 'forget',
                name: RoutesName.forget,
                pageBuilder: (context, state) {
                  return const MaterialPage(child: ForgetPassword());
                }),
            GoRoute(
                path: 'homeScreen',
                name: RoutesName.homeScreen,
                pageBuilder: (context, state) {
                  return MaterialPage(child: HomeScreen());
                },
                routes: [
                  GoRoute(
                      path: 'home',
                      name: RoutesName.home,
                      pageBuilder: (context, state) {
                        return MaterialPage(child: Cart());
                      }),
                  GoRoute(
                      path: 'favorite',
                      name: RoutesName.favorite,
                      pageBuilder: (context, state) {
                        return MaterialPage(child: Cart());
                      }),
                  GoRoute(
                      path: 'user',
                      name: RoutesName.user,
                      pageBuilder: (context, state) {
                        return MaterialPage(child: Cart());
                      }),
                  GoRoute(
                      path: 'cart',
                      name: RoutesName.cart,
                      pageBuilder: (context, state) {
                        return MaterialPage(child: Cart());
                      }),
                  GoRoute(
                      path: 'setting',
                      name: RoutesName.setting,
                      pageBuilder: (context, state) {
                        return MaterialPage(child: Setting());
                      }),
                ])
          ]),
    ]);
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/log_out_cubit.dart';
import 'package:flutter_store/routes/routes_name.dart';
import 'package:go_router/go_router.dart';
import '../../../../Widgets/Register.dart';
import '../../../../colors/colors.dart';

Widget drawerPanel(BuildContext context ) {
  // List <DrawerData> drawerList =[
  //   DrawerData(text: 'dashboard', icon: Icons.dashboard),
  //   DrawerData(text: 'category', icon: Icons.category),
  //   DrawerData(text: 'Product', icon: Icons.shop),
  // ];
  return Drawer(
    backgroundColor: Colors.white,
    // shadowColor:Colors.black ,
    surfaceTintColor: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MyColors.defaultPadding,),
          Center(
            child: Icon(Icons.manage_accounts,
              size: 40,
            ),
          ),
          SizedBox(height: MyColors.defaultPadding,),
          Text('Menu'),
          // Expanded(
          //   child:
          //   ListView.builder(
          //     itemCount: drawerList.length,
          //       itemBuilder: (context,index){
          //       final data = drawerList[index];
          //       return customListTile(icon: data.icon, text: data.text, onTap: () {  });
          //       }),),
          // Text('Other'),
          // customListTile(icon:Icons.settings , text: 'Setting', onTap: () {  }),
          // customListTile(icon: Icons.logout, text: 'LogOut', onTap: () {  }),
          ListTile(
            hoverColor: MyColors.dashBoardButton,
            onTap: () {},
            leading: Icon(Icons.dashboard),
            title: Text('dashboard'),
          ),
          ListTile(
            hoverColor: MyColors.dashBoardButton,
            onTap: () {},
            leading: Icon(Icons.ad_units),
            title: Text('banner'),
          ),
          ListTile(
            hoverColor: MyColors.dashBoardButton,
            onTap: () {
              context.goNamed(RoutesName.addProduct);
            },
            leading: Icon(Icons.add_shopping_cart),
            title: Text('product'),
          ),
          ListTile(
            hoverColor: MyColors.dashBoardButton,
            onTap: () {},
            leading: Icon(Icons.account_box),
            title: Text('order'),
          ),
          Text('Other'),
          ListTile(
            hoverColor: MyColors.dashBoardButton,
            onTap: () {
              context.goNamed(RoutesName.profile);
            },
            leading: Icon(Icons.settings),
            title: Text('profile'),
          ),
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
              return ListTile(
                hoverColor: MyColors.dashBoardButton,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content: const Text(
                              'Are you sure you want to log out?'),
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
                      }
                  );
                },
                leading: Icon(Icons.logout),
                title: Text('LogOut'),
              );
            },
          ),

        ],
      ),
    ),
  );
}
// Widget customListTile({required IconData icon,required String text,required void Function() onTap}){
//   return ListTile(
//     onTap:onTap,
//     leading:  Icon(icon),
//     title: Text(text) ,
//   );
// }

// class DrawerData{
//   final String text;
//  final  IconData icon;
//  const DrawerData({required this.text, required this.icon});
// }
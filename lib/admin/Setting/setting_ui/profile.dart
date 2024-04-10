import 'package:flutter/material.dart';
import 'package:flutter_store/size_manager.dart';
import 'package:go_router/go_router.dart';
import '../../add_product/add_product_ui/add_product_widget/custom_product_container.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SizeManager sizeManager = SizeManager();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Column(children: [
            Container(

              color: Colors.white,
              child: InkWell(
                  // focusColor:Colors.white,
                  //  hoverColor:Colors.blueGrey,
                  // highlightColor: Colors.green,
                  // splashColor: Colors.red,
                  onTap: () {
                    context.pop(context);
                  },
                  child: Icon(Icons.home)),

            ),
          ])),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(child: CustomProductContainer()))
        ],
      ),
    );
  }
}


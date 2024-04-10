import 'package:flutter/material.dart';
import 'package:flutter_store/admin/add_product/add_product_ui/add_product_widget/product_details.dart';
import 'package:flutter_store/admin/add_product/add_product_ui/add_product_widget/product_image.dart';
import 'package:flutter_store/admin/add_product/add_product_ui/add_product_widget/product_setting.dart';
import 'package:flutter_store/admin/add_product/add_product_ui/add_product_widget/product_status.dart';
import 'package:flutter_store/admin/add_product/add_product_ui/add_product_widget/product_type.dart';
import 'package:flutter_store/colors/colors.dart';

import 'date_time_picker.dart';

class CustomProductContainer extends StatelessWidget {
  const CustomProductContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(

            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Create a New Product',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  Icon(Icons.add)
                ],
              ),
            ),
          ),
          SizedBox(height: MyColors.defaultPadding,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,

                  child: Column(
                    
                    
                    children: [
                      ProductImage(),
                      ProductSetting(),
                      CustomDropDown(),
                      DateTimePicker(context)
                    ],
                  )
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      ProductType(),
                      SizedBox(height: 10,),
                      ProductDetails(),
                      SizedBox(height: 20,),
                      Center(
                        child: TextButton(
                          style:ButtonStyle(
                            backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                          )
                          ,
                            onPressed: (){},
                            child: Text('Add Product',
                              style: TextStyle(
                               fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                        ),
                      ),

                    ],
                  )
              )
            ],
          ),

        ],
      ),
    );
  }
}
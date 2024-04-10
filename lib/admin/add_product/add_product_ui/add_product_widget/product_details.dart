import 'package:flutter/material.dart';

import 'input_text_feild.dart';

Widget ProductDetails() {
  TextEditingController productName =TextEditingController();
  TextEditingController brand =TextEditingController();
  TextEditingController price =TextEditingController();
  TextEditingController discount =TextEditingController();
  TextEditingController productDescription =TextEditingController();
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Product Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Product Name',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    InputTextField(
                      productName
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Brand',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    InputTextField(
                      brand
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Price',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    InputTextField(
                      price
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Discount',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    InputTextField(
                      discount
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          child: Column(
            children: [
              Text(
                'Product Description',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              InputTextField(productDescription),
            ],
          ),
        ),
      ],
    ),
  );
}

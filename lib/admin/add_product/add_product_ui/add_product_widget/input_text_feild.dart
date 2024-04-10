import 'package:flutter/material.dart';

Widget InputTextField(addProduct){
  return  Container(
    margin: EdgeInsets.all(10),
    child: TextFormField(
      controller: addProduct,
      decoration:InputDecoration(
        border: OutlineInputBorder(
          gapPadding: 4
        )
      )
    ),
  );
}
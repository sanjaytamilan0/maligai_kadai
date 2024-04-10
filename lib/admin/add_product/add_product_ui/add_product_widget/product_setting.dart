import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ProductSetting(){
  return   Container(
    margin: EdgeInsets.all(10),

    decoration: BoxDecoration(
      color: Colors.white,
        // border: Border.all(
        //     color: Colors.black
        // ),
        borderRadius: BorderRadius.circular(10)
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Setting',
            style:TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Limited Product?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
             Transform.scale(
               scale:0.7,
               child: CupertinoSwitch(value:false,
                    activeColor:Colors.amber ,
                    focusColor:Colors.amber,onChanged: (bool){

                }),
             )
            ],
          ),
        )
      ],
    ),
  );
}
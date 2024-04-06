import 'dart:js';

import 'package:flutter/material.dart';

Widget DashBoardHeader (){
  return Container(
    height: 50,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 240 ,
          margin: EdgeInsets.only(top: 5, left: 15, bottom: 5),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black, // Border color
                  width: 2.0,
                  // Border width
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Icon(Icons.notifications_outlined),
            SizedBox(width:10,),
            Icon(Icons.account_circle),
            SizedBox(width:7,),
            // Container(
            //   width: 20,
            //   height: 20,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(100),
            //     image: DecorationImage(
            //      
            //       fit: BoxFit.fill,
            //       image: NetworkImage(
            //         '!'
            //       )
            //     )
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Column(

                children: [
                  Text('Admin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),

                  Text('admin@gmail.com',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}
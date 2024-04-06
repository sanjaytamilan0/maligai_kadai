import 'package:flutter/material.dart';

Widget DashBoardDetailsList (String title,int price, int percentage,String description){
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              10
          )
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹ ${price.toString()}',
                style: TextStyle (
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),


                  ),
              Column(
                children: [
                  Text("% ${percentage.toString()}↑",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(description,
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              )
            ],
          )
    
        ],
      ),
    ),
  );
}
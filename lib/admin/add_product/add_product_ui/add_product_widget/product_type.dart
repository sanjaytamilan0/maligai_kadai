import 'package:flutter/material.dart';

Widget ProductType(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Product Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 150, // Set your desired height here
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio:1/2,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: Center(
                    child: Text(index.toString()),
                  ),
                );
              },
            ),
          ),
        )

      ],
    ),
  );
}
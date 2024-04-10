import 'package:flutter/material.dart';

Widget DateTimePicker(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
          borderRadius: BorderRadius.circular(10)
    ),
    child: Container(
      width: 200,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Expire Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            SizedBox(height: 10,),
            TextButton(
              onPressed: () {}
           ,
              child: Text(
                ' Picker Your Date',
                style: TextStyle(
                  fontSize: 16, // Adjust font size as needed
                ),
              ),
            )

          ],
        ),
      ),
    )
  );
}
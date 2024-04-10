import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
   String dropDownValue ='' ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Status',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),

          ),
          Container(
            width: 400,
            child: DropdownButtonFormField(
              isExpanded: true,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10)
                ),

                menuMaxHeight: 100.0,
                items: [
                  DropdownMenuItem(
                    child: Text('mango'),
                    value: 'mango',
                  ),
                  DropdownMenuItem(
                    child: Text('orange'),
                    value: 'orange',
                  ),
                  DropdownMenuItem(
                    child: Text('cake'),
                    value: 'cake',
                  ),
                  DropdownMenuItem(
                    child: Text('apple'),
                    value: 'apple',
                  ),
                  DropdownMenuItem(
                    child: Text('coco'),
                    value: 'coco',
                  ),
                  DropdownMenuItem(
                    child: Text('choco'),
                    value: 'choco',
                  ),

                  DropdownMenuItem(
                    child: Text('food'),
                    value: 'food',
                  ),

                ],
                hint: Text('Status',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                // value: dropDownValue,
                onChanged: (value) {


                  print(value);
                }),
          )
        ],
      ),
    );
  }
}

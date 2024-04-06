import 'package:flutter/material.dart';

Widget DashBoardTabel (){
  bool check = false;
  return  Container(
    margin: EdgeInsets.all(10),
    padding:  EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
    ),
    child: DataTable(
      columns: [
        DataColumn(label: Checkbox(
          value: check,onChanged: (check){},
        )),
        DataColumn(label: Text('Order')),
        DataColumn(label: Text('Dofe')),
        DataColumn(label: Text('Neme')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Ament')),
      ],
      rows: [
        DataRow(cells: [
          DataCell( Checkbox(
            value: check,onChanged: (check){},
          )),
          DataCell(Text('10')),
          DataCell(Text('Shaped')),
          DataCell(Text('0478')),
          DataCell(Text('27 Mar 2004')),
          DataCell(Text('')),
        ]),
        DataRow(cells: [
          DataCell( Checkbox(
            value: check,onChanged: (check){},
          )),
          DataCell(Text('7')),
          DataCell(Text('')),
          DataCell(Text('5443')),
          DataCell(Text('24M 2004')),
          DataCell(Text('')),
        ]),
        DataRow(cells: [
          DataCell( Checkbox(
            value: check,onChanged: (check){},
          )),
          DataCell(Text('8')),
          DataCell(Text('')),
          DataCell(Text('5443')),
          DataCell(Text('24M 2004')),
          DataCell(Text('')),
        ]),
        DataRow(cells: [
          DataCell( Checkbox(
            value: check,onChanged: (check){},
          )),
          DataCell(Text('9')),
          DataCell(Text('')),
          DataCell(Text('5443')),
          DataCell(Text('24M 2004')),
          DataCell(Text('')),
        ]),
        DataRow(cells: [
          DataCell( Checkbox(
            value: check,onChanged: (check){},
          )),
          DataCell(Text('4')),
          DataCell(Text('')),
          DataCell(Text('5443')),
          DataCell(Text('24M 2004')),
          DataCell(Text('')),
        ]),
      ],
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

Widget DashboardOrderStatus(){
  return Container(
    margin: EdgeInsets.all(25),
    padding:  EdgeInsets.all(30),
    height: 400,
    width: 400,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Status',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 8,),
        Expanded(
          child: PieChart(
            chartType : ChartType.ring,
            dataMap: {
              '68000':1,
              '500':1,
              '5000':2 ,
              '40000':2
            },
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendLabels: {
            'pending' :'68000',
                'deliver':'500',
                '':'5000' ,
                'cancel':'40000'

              }
            ),
            ringStrokeWidth: 30,
          
          ),
        ),
      ],
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget DashboardBoxChart (){
  return  Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
    
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Weekly Sales',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10),
          ),
        ),
        SfCartesianChart(
          borderWidth: 4,
          plotAreaBorderWidth: 1,

          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          series: [
            ColumnSeries<SalesData, String>(
              width: 0.2,
              dataSource: <SalesData>[
                SalesData('sun ', 500,
                ),
                SalesData('mon ', 1000),
                SalesData('tue ', 200),
                SalesData('wed', 300),
                SalesData('thu', 500),
                SalesData('fri', 200),
                SalesData('sat', 0),
              ],
              xValueMapper: (SalesData sales, _) =>
              sales.week,
              yValueMapper: (SalesData sales, _) =>
              sales.sales,
              dataLabelSettings:
              DataLabelSettings(isVisible: false),
            ),
          ],
        ),
      ],
    ),
  );
}
class SalesData {
  final String week;
  final double sales;

  SalesData(this.week, this.sales);
}
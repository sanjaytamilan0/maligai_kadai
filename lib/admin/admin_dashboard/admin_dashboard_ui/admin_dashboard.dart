import 'package:flutter/material.dart';
import 'package:flutter_store/admin/admin_dashboard/admin_dashboard_ui/dashboard_widget/dashboard_box_chart.dart';
import 'package:flutter_store/admin/admin_dashboard/admin_dashboard_ui/dashboard_widget/dashboard_tabel.dart';
import 'package:flutter_store/colors/colors.dart';
import 'dashboard_widget/dashboard_details_list.dart';
import 'dashboard_widget/dashboard_header.dart';
import 'dashboard_widget/dashboard_order_status.dart';
import 'dashboard_widget/drawer_pannel.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
  //

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    return Scaffold(
      key: scaffoldKey,
      // appBar:500>screenWidth? AppBar():AppBar(),
      drawer: screenWidth <= 950
          ? Drawer(
              elevation: 0,
              width: 200,
              clipBehavior: Clip.none,
              child: drawerPanel(context))
          : null,
      // Drawer(
      //   backgroundColor: Colors.transparent,
      //
      //   width: 0,),
      body: Row(
        children: [
          950 < screenWidth
              ? Expanded(
                  child: drawerPanel(context),
                )
              : Container(),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    950 < screenWidth
                        ? DashBoardHeader()
                        : Container(
                            height: 50,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      openDrawer();
                                    },
                                    child: Icon(Icons.menu)),
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: Icon(Icons.search)),
                                    Icon(Icons.notifications_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.account_circle),
                                    SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                    // DashBoardHeader(),
                    SizedBox(
                      height: MyColors.defaultPadding,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'DashBoard',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: MyColors.defaultPadding,
                    ),
                    screenWidth > 750
                        ? Row(
                            children: [
                              DashBoardDetailsList(
                                  'total sales', 95000, 95, 'march'),
                              DashBoardDetailsList(
                                  'Average OrderValue', 65000, 65, 'march'),
                              DashBoardDetailsList(
                                  'total Order', 75000, 75, 'march'),
                              DashBoardDetailsList(
                                  'total Visitors', 10000, 100, 'march'),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  DashBoardDetailsList(
                                      'total sales', 95000, 95, 'march'),
                                  DashBoardDetailsList(
                                      'Average OrderValue', 65000, 65, 'march'),
                                ],
                              ),
                              Row(
                                children: [
                                  DashBoardDetailsList(
                                      'total sales', 95000, 95, 'march'),
                                  DashBoardDetailsList(
                                      'Average OrderValue', 65000, 65, 'march'),
                                ],
                              ),
                            ],
                          ),
                    screenWidth > 700
                        ? Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    DashboardBoxChart(),
                                    DashBoardTabel()
                                  ],
                                ),
                              ),
                              Expanded(child: DashboardOrderStatus()),
                            ],
                          )
                        : Column(
                            children: [
                              DashboardBoxChart(),
                              DashBoardTabel(),
                              DashboardOrderStatus(),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

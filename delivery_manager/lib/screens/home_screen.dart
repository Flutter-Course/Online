import 'package:delivery_manager/widgets/background_container.dart';
import 'package:delivery_manager/widgets/chart.dart';
import 'package:delivery_manager/widgets/homescreen_title.dart';
import 'package:delivery_manager/widgets/order_item.dart';
import 'package:delivery_manager/widgets/sticky_header_head.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  bool showUpButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundContainer(),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  HomeScreenTitle(),
                  Chart(),
                  Expanded(
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels > 40 &&
                            showUpButton == false) {
                          setState(() {
                            showUpButton = true;
                          });
                        } else if (notification.metrics.pixels <= 40 &&
                            showUpButton == true) {
                          setState(() {
                            showUpButton = false;
                          });
                        }
                        return true;
                      },
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 56,
                        ),
                        physics: BouncingScrollPhysics(),
                        children: [
                          StickyHeader(
                            header: StickyHeaderHead('19/10/2020'),
                            content: Column(
                              children: [
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                              ],
                            ),
                          ),
                          StickyHeader(
                            header: StickyHeaderHead('18/10/2020'),
                            content: Column(
                              children: [
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                              ],
                            ),
                          ),
                          StickyHeader(
                            header: StickyHeaderHead('17/10/2020'),
                            content: Column(
                              children: [
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                                OrderItem(
                                  price: 15,
                                  deliveryMan: 'Ahmed Aly',
                                  time: '4:00PM',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 2 * kFloatingActionButtonMargin),
        child: Row(
          mainAxisAlignment: (showUpButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (showUpButton)
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.grey,
                child: Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  scrollController.jumpTo(0.0);
                },
              ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

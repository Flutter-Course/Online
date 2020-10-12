import 'package:delivery_manager/widgets/order_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Text(
                      'Delivery Manager',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ).add(
                      EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'No Orders Yet',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        OrderItem(
                          price: 50,
                          deliveryMan: 'Muhammed Aly',
                          time: '2:00PM',
                        ),
                        OrderItem(
                          price: 500,
                          deliveryMan: 'Toka Ehab',
                          time: '3:00PM',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

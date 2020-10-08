import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final double price;
  final String deliveryMan, time;
  OrderItem(
      {@required this.price, @required this.deliveryMan, @required this.time});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ).add(
        EdgeInsets.only(
          bottom: 8,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '$price\$',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(deliveryMan),
          subtitle: Text(time),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

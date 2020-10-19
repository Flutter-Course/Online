import 'package:flutter/foundation.dart';

class Order {
  int id;
  String deliveryMan;
  DateTime orderDate;
  double price;

  Order(
      {@required this.id,
      @required this.deliveryMan,
      @required this.orderDate,
      @required this.price});
}

import 'package:my_shop/models/user.dart';
import 'package:my_shop/models/vendor.dart';

class Customer extends User {
  Customer.fromFirebase(userId, doc) : super.fromFirebase(userId, doc);
  Customer.fromVendor(Vendor vendor) : super.fromUser(vendor);
  Future<void> init() async {}
}

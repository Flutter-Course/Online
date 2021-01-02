import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/models/user.dart';
import 'package:my_shop/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Vendor extends User {
  Vendor.fromFirebase(userId, doc) : super.fromFirebase(userId, doc);

  Vendor.fromCustomer(Customer customer) : super.fromUser(customer);

  List<Product> _products;

  List<Product> get products => [..._products];

  Future<void> init() async {
    final documents = await FirebaseFirestore.instance
        .collection('products')
        .where('vendorId', isEqualTo: userId)
        .get();

    if (documents.docs.length == 0) {
      _products = [];
    } else {
      _products = documents.docs
          .map((document) => Product.fromDocument(document))
          .toList();
    }
  }

  Future<List<String>> uploadImages(List<File> files) async {
    List<Reference> refs = [];
    files.forEach((image) {
      refs.add(FirebaseStorage.instance
          .ref('products/$userId/${image.path.split('/').last}'));
    });

    int index = 0;
    await Future.wait(refs.map((ref) => ref.putFile(files[index++])));
    return await Future.wait(refs.map((ref) => ref.getDownloadURL()));
  }

  Future<bool> addProduct(
      title, category, forWho, description, photos, price) async {
    try {
      final photosUrls = await uploadImages(photos);
      final date = DateFormat('yyyyMMdd').format(DateTime.now());
      final doc = await FirebaseFirestore.instance.collection('products').add({
        'title': title,
        'category': category,
        'forWho': forWho,
        'description': description,
        'date': date,
        'available': true,
        'price': price,
        'photos': photosUrls,
        'vendorId': userId,
      });
      _products.add(Product(doc.id, title, category, forWho, description, date,
          photosUrls, true, price));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editProduct(id, title, category, forWho, description, date,
      photosUrls, available, price) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(id).update({
        'title': title,
        'category': category,
        'forWho': forWho,
        'description': description,
        'available': available,
        'price': price,
        //        'photos': photosUrls,
        'vendorId': userId,
      });
      int index = _products.indexWhere((element) => element.id == id);
      _products.removeWhere((element) => element.id == id);

      _products.insert(
          index,
          Product(id, title, category, forWho, description, date, photosUrls,
              available, price));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

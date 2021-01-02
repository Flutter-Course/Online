import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String _id, _title, _category, _forWho, _description, _date;
  List<String> _photosUrls;
  bool _available;
  double _price;

  String get id => _id;

  get title => _title;

  double get price => _price;

  bool get available => _available;

  List<String> get photosUrls => _photosUrls;

  get date => _date;

  get description => _description;

  get forWho => _forWho;

  get category => _category;

  Product(
      this._id,
      this._title,
      this._category,
      this._forWho,
      this._description,
      this._date,
      this._photosUrls,
      this._available,
      this._price);

  Product.fromDocument(QueryDocumentSnapshot document)
      : this._id = document.id,
        this._title = document.data()['title'],
        this._category = document.data()['category'],
        this._forWho = document.data()['forWho'],
        this._description = document.data()['description'],
        this._date = document.data()['date'],
        this._photosUrls = document.data()['photoUrls'],
        this._available = document.data()['available'],
        this._price = document.data()['price'];
}

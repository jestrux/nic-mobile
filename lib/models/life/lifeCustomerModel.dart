import 'package:nic/models/life/LifeproductModel.dart';

class LifeCustomerModel {
  String? _id;
  String? _firstName;
  String? _middleName;
  String? _lastName;
  String? _customerNumber;

  LifeCustomerModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _firstName = map['firstName'];
    _middleName = map['middleName'];
    _lastName = map['lastName'];
    _customerNumber = map['customerNumber'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['firstName'] = _firstName;
    map['middleName'] = _middleName;
    map['lastName'] = _lastName;
    map['customerNumber'] = _customerNumber;

    return map;
  }

  LifeCustomerModel({id, firstName, middleName, lastName, customerNumber}) {
    _id = id;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _customerNumber = customerNumber;
  }

  LifeCustomerModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _firstName = jsonData['firstName'];
    _middleName = jsonData['middleName'];
    _lastName = jsonData['lastName'];
    _customerNumber = jsonData['customerNumber'];
  }

  String? get id => _id;
  String? get firstName => _firstName;
  String? get middleName => _middleName;
  String? get lastName => _lastName;
}

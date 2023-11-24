import 'package:nic/models/life/lifeCustomerModel.dart';

class OrganizationBillModel {
  String? _id;
  double? _amount;
  String? _controlNumber;
  String? _description;
  String? _gfsCode;
  LifeCustomerModel? _customer;

  OrganizationBillModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _amount = map['amount'];
    _controlNumber = map['controlNumber'];
    _description = map['description'];
    _gfsCode = map['gfsCode'];
    _customer = LifeCustomerModel.fromMap(map['customer']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['controlNumber'] = _controlNumber;
    map['descriptioin'] = _description;
    map['gfsCode'] = _gfsCode;
    map['customer'] = _customer;

    return map;
  }

  OrganizationBillModel(
      {id, amount, controlNumber, description, gfsCode, customer}) {
    _id = id;
    _amount = amount;
    _controlNumber = controlNumber;
    _description = description;
    _gfsCode = gfsCode;
    _customer = customer;
  }

  OrganizationBillModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _amount = jsonData['amount'];
    _controlNumber = jsonData['controlNumber'];
    _description = jsonData['description'];
    _gfsCode = jsonData['gfsCode'];
    _customer = jsonData['customer'];
  }

  String? get id => _id;
  double? get amount => _amount;
  String? get controlNumber => _controlNumber;
  LifeCustomerModel? get customer => _customer;
}

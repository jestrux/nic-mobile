import 'package:nic/models/life/lifeCustomerModel.dart';
import 'package:nic/models/life/LifeproductModel.dart';

class LifePolicyModel {
  String? _id;
  String? _policyNumber;
  String? _checkNumber;
  double? _premium;
  double? _sumInsured;
  LifeProductModel? _product;
  LifeCustomerModel? _customer;

  LifePolicyModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _policyNumber = map['policyNumber'];
    _checkNumber = map['checkNumber'];
    _premium = map['premium'];
    _sumInsured = map['sumInsured'];
    _product = LifeProductModel.fromMap(map['product']);
    _customer = LifeCustomerModel.fromMap(map['customer']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['policyNumber'] = _policyNumber;
    map['checkNumber'] = _checkNumber;
    map['premium'] = _premium;
    map['sumInsured'] = _sumInsured;
    map['product'] = _product;
    map['customer'] = _customer;

    return map;
  }

  LifePolicyModel(
      {id, policyNumber, checkNumber, premium, sumInsured, product, customer}) {
    _id = id;
    _policyNumber = policyNumber;
    _checkNumber = checkNumber;
    _sumInsured = sumInsured;
    _premium = premium;
    _product = product;
    _customer = customer;
  }

  LifePolicyModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _policyNumber = jsonData['policyNumber'];
    _checkNumber = jsonData['checkNumber'];
    _premium = jsonData['premium'];
    _sumInsured = jsonData['sumInsured'];
    _product = jsonData['product'];
    _customer = jsonData['customer'];
  }

  String? get id => _id;
  String? get policyNumber => _policyNumber;
  String? get checkNumber => _checkNumber;
  double? get sumInsured => _sumInsured;
  double? get premium => _premium;
  LifeCustomerModel? get customer => _customer;
  LifeProductModel? get product => _product;
}

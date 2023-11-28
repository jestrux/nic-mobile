// import 'package:nic/models/life/LifeProposalModel.dart';
import 'package:nic/models/life/lifeCustomerModel.dart';
import 'package:nic/models/life/LifeproductModel.dart';

class LifePolicyModel {
  String? _id;
  String? _policyNumber;
  String? _checkNumber;
  int? _premiumPaymentMethod;
  double? _premium;
  double? _sumInsured;
  LifeProductModel? _product;
  LifeCustomerModel? _customer;
  // LifeProposalModel? _proposal;

  LifePolicyModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _policyNumber = map['policyNumber'];
    _checkNumber = map['checkNumber'];
    _premium = map['premium'];
    _sumInsured = map['sumInsured'];
    _premiumPaymentMethod = map['premiumPaymentMethod'];
    _product = LifeProductModel.fromMap(map['product']);
    _customer = LifeCustomerModel.fromMap(map['customer']);
    // _proposal = LifeProposalModel.fromMap(map['proposal']);
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
    map['premiumPaymentMethod'] = _premiumPaymentMethod;
    // map['proposal'] = _proposal;

    return map;
  }

  LifePolicyModel(
      {id,
      policyNumber,
      checkNumber,
      premium,
      sumInsured,
      product,
      customer,
      proposal,
      premiumPaymentMethod}) {
    _id = id;
    _policyNumber = policyNumber;
    _checkNumber = checkNumber;
    _sumInsured = sumInsured;
    _premium = premium;
    _product = product;
    _customer = customer;
    _premiumPaymentMethod = premiumPaymentMethod;
    // _proposal = proposal;
  }

  LifePolicyModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _policyNumber = jsonData['policyNumber'];
    _checkNumber = jsonData['checkNumber'];
    _premium = jsonData['premium'];
    _sumInsured = jsonData['sumInsured'];
    _product = jsonData['product'];
    _customer = jsonData['customer'];
    _premiumPaymentMethod = jsonData['premiumPaymentMethod'];
    // _proposal = jsonData['proposal'];
  }

  String? get id => _id;
  String? get policyNumber => _policyNumber;
  String? get checkNumber => _checkNumber;
  int? get premiumPaymentMethod => _premiumPaymentMethod;
  double? get sumInsured => _sumInsured;
  double? get premium => _premium;
  LifeCustomerModel? get customer => _customer;
  LifeProductModel? get product => _product;
  // LifeProposalModel? get proposal => _proposal;
}

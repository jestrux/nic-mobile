import 'package:nic/models/life/allocationModel.dart';

class PremiumCardModel {
  String? _id;
  double? _amount;
  AllocationModel? _allocation;

  PremiumCardModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _amount = map['amount'];
    _allocation = AllocationModel.fromMap(map['allocation']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['allocation'] = _allocation;

    return map;
  }

  LifePolicyModel({id, amount, allocation}) {
    _id = id;
    _amount = amount;
    _allocation = allocation;
  }

  PremiumCardModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _amount = jsonData['amount'];
    _allocation = jsonData['allocation'];
  }

  void setPolicyAmount(String value) {
    _amount = value as double?;
  }

  String? get id => _id;
  double? get amount => _amount;
  AllocationModel? get allocation => _allocation;

  // String? get amount => _amount;
}

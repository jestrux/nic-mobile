class AllocationModel {
  String? _id;
  double? _amount;
  String? _allocationDate;

  AllocationModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _amount = map['amount'];
    _allocationDate = map['allocationDate'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['allocationDate'] = _allocationDate;
    return map;
  }

  AllocationModel({id, amount, allocationDate}) {
    _id = id;
    _amount = amount;
    _allocationDate = allocationDate;
  }

  AllocationModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _amount = jsonData['amount'];
    _allocationDate = jsonData['allocationDate'];
  }

  void setAllocationDate(String value) {
    _allocationDate = value;
  }

  String? get id => _id;
  double? get amount => _amount;
  String? get allocationDate => _allocationDate;

  // String? get amount => _amount;
}

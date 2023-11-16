class LifePolicyModel {
  String? _id;
  String? _policyNumber;
  String? _checkNumber;
  // String? _premium;
  // String? _sumInsured;

  LifePolicyModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _policyNumber = map['policyNumber'];
    _checkNumber = map['checkNumber'];
    // _premium = map['premium'];
    // _sumInsured = map['sumInsured'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['policyNumber'] = _policyNumber;
    map['checkNumber'] = _checkNumber;
    // map['premium'] = _premium;
    // map['sumInsured'] = _sumInsured;

    return map;
  }

  LifePolicyModel({id, policyNumber, checkNumber}) {
    _id = id;
    _policyNumber = policyNumber;
    _checkNumber = checkNumber;
    // _premium = premium;
    // _sumInsured = sumInsured;
  }

  LifePolicyModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _policyNumber = jsonData['policyNumber'];
    _checkNumber = jsonData['checkNumber'];
    // _premium = jsonData['premium'];
    // _sumInsured = jsonData['sumInsured'];
  }

  // void setPolicyId(String value) {
  //   _policyId = value;
  // }

  void setPolicyNumber(String value) {
    _policyNumber = value;
  }

  void setCheckNumber(String value) {
    _checkNumber = value;
  }

  // void setPremium(String value) {
  //   _premium = value;
  // }

  // void setSumInsured(String value) {
  //   _sumInsured = value;
  // }

  // String? get policyId => _policyId;

  String? get id => _id;

  String? get policyNumber => _policyNumber;

  String? get checkNumber => _checkNumber;

  // String? get premium => _premium;

  // String? get sumInsured => _sumInsured;
}

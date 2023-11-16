class LifePolicyModel {
  String? _id;
  String? _policyNumber;
  String? _checkNumber;
  String? _productName;

  LifePolicyModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _policyNumber = map['policyNumber'];
    _checkNumber = map['checkNumber'];
    _productName = map['productName'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['policyNumber'] = _policyNumber;
    map['checkNumber'] = _checkNumber;
    map['productName'] = _productName;

    return map;
  }

  LifePolicyModel({id, policyNumber, checkNumber, productName}) {
    _id = id;
    _policyNumber = policyNumber;
    _checkNumber = checkNumber;
    _productName = productName;
  }

  LifePolicyModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _policyNumber = jsonData['policyNumber'];
    _checkNumber = jsonData['checkNumber'];
    _productName = "${jsonData['product']['name']}";
  }

  void setPolicyNumber(String value) {
    _policyNumber = value;
  }

  void setCheckNumber(String value) {
    _checkNumber = value;
  }

  String? get id => _id;

  String? get policyNumber => _policyNumber;

  String? get checkNumber => _checkNumber;

  String? get productName => _productName;
}

class LifeProductModel {
  String? _id;
  String? _name;

  LifeProductModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

  LifeProductModel({id, name}) {
    _id = id;
    _name = name;
  }

  LifeProductModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _name = jsonData['name'];
  }

  String? get id => _id;
  String? get name => _name;

  // String? get amount => _amount;
}

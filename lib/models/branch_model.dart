// part 'branch_model.g.dart';

// @HiveType(typeId: 1)
class BranchModel {
  String? _id;
  String? _code;
  String? _name;
  String? _phone;
  String? _street;
  String? _latitude;
  String? _longitude;

  BranchModel({String? id, String? code, String? name,String? phone,String? street, String? latitude, String? longitude}) {
    this._id = id;
    this._code = code;
    this._name = name;
    this._phone = _phone;
    this._street = street;
    this._latitude = latitude;
    this._longitude = longitude;
  }

  BranchModel.fromJson(Map<String, dynamic> jsonData) {
    this._id = jsonData['id'];
    this._code = jsonData['code'];
    this._name = jsonData['name'];
    this._phone = jsonData['contacts']['contact'];
    this._street = jsonData['addresses']['street'];
    this._latitude = jsonData['locations']['latitude'];
    this._longitude = jsonData['locations']['longitude'];
  }

  String? get id => this._id;
  String? get code => this._code;
  String? get name => this._name;
  String get phone => this.phone;
  String? get street => this._street;
  String? get latitude => this._latitude;
  String? get longitude => this._longitude;
}

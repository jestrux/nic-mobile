class RecoverUserModel{
  String? _firstName;
  String? _lastName;
  String? _phone;
  String? _email;
  String? _id;

  RecoverUserModel({
    firstName,
    lastName,
    phone,
    email,
    id}){
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
    _email = email;
    _id = id;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['phone'] = _phone;
    map['email'] = _email;
    map['id'] = _id;
    return map;
  }

  RecoverUserModel.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData != null) {
      _id = jsonData['id'];
      if(jsonData['phone'] != null){
        _phone = jsonData['phone'];
      }
      if(jsonData['user'] != null ){
        if(jsonData['firstName'] != null){
          _firstName = jsonData['firstName'];
        }
        if(jsonData['lastName'] != null){
          _lastName = jsonData['lastName'];
        }
        if(jsonData['email'] != null){
          _email = jsonData['email'];
        }
      }
    }
  }

  String? get firstName => this._firstName;
  set firstName(String? value){
    this._firstName = value;
  }

  String? get lastName => this._lastName;
  set lastName(String? value){
    this._lastName = value;
  }

  String? get phone => this._phone;
  set phone(String? value){
    this._phone = value;
  }

  String? get email => this._email;
  set email(String? value){
    this._email = value;
  }
  String? get id => this._id;
  set id(String? value){
    this._id = value;
  }
}
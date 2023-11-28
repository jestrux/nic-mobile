class ClaimModel {
  String? _claimantNumber;
  String? _claimNumber;
  String? _claimantStatus;
  String? _propertyName;
  String? _intimationDate;
  dynamic _claimAmount;
  dynamic _netPayable;
  String? _corporate;
  String? _displayName;

  ClaimModel({
    claimantNumber,
    claimNumber,
    claimantStatus,
    propertyName,
    intimationDate,
    claimAmount,
    netPayable,
    corporate,
    displayName
  }) {
    this._claimantNumber = claimantNumber;
    this._claimNumber = claimNumber;
    this._claimantStatus = claimantStatus;
    this._propertyName = propertyName;
    this._intimationDate = intimationDate;
    this._claimAmount = claimAmount;
    this._netPayable = netPayable;
    this._corporate = corporate;
    this._displayName = displayName;
  }

  void setclaimantNumber(String value) {
    this._claimantNumber = value;
  }


  void setclaimNumber(String value) {
    this._claimNumber = value;
  }

  void setclaimantStatus(String value) {
    this._claimantStatus = value;
  }

  void setpropertyName(String value) {
    this._propertyName = value;
  }

  void setintimationDate(String value) {
    this._intimationDate = value;
  }

  void setclaimAmount(dynamic value) {
    this._claimAmount = value;
  }

  void setnetPayable(dynamic value) {
    this._netPayable = value;
  }

  void setcorporate(String value) {
    this._corporate = value;
  }
void displayName(String value){
    this._displayName = value;
}
  String? get claimantNumber => this._claimantNumber;
  String? get fullClaimantName {
    return _displayName;
  }

  String? get claimNumber => this._claimNumber;
  String? get claimantStatus => this._claimantStatus;
  String? get propertyName => this._propertyName;
  String? get intimationDate => this._intimationDate;
  dynamic get claimAmount => this._claimAmount;
  dynamic get netPayable => this._netPayable;
  String? get corporate => this._corporate;
}


class ClaimantModel {
  // var formatter = NumberFormat.currency(locale: "sw_TZ", symbol: 'TSh. ', decimalDigits: 2);
  String? _claimantId;
  String? _claimId;
  String? _claimNumber;
  double? _claimAmount;
  String? _claimantFirstName;
  String? _claimantMiddleName;
  String? _claimantLastName;
  String? _claimantNumber;
  String? _claimantStatus;
  double? _claimantClaimAmount;
  double? _claimantNetPayable;
  String? _created;

  ClaimantModel.fromMap(Map<String, dynamic> map) {
    this._claimantId = map['claimantId'];
    this._claimId = map['claimId'];
    this._claimNumber = map['claimNumber'];
    this._claimAmount = map['claimAmount'];
    this._claimantFirstName = map['claimantFirstName'];
    this._claimantMiddleName = map['claimantMiddleName'];
    this._claimantLastName = map['claimantLastName'];
    this._claimantNumber = map['claimantNumber'];
    this._claimantStatus = map['claimantStatus'];
    this._claimantClaimAmount = map['claimantClaimAmount'];
    this._claimantNetPayable = map['claimantNetPayable'];
    this._created = map['created'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['claimantId'] = this._claimantId;
    map['claimId'] = this._claimId;
    map['claimNumber'] = this._claimNumber;
    map['claimAmount'] = this._claimAmount;
    map['claimantFirstName'] = this._claimantFirstName;
    map['claimantMiddleName'] = this._claimantMiddleName;
    map['claimantLastName'] = this._claimantLastName;
    map['claimantNumber'] = this._claimantNumber;
    map['claimantStatus'] = this._claimantStatus;
    map['claimantClaimAmount'] = this._claimantClaimAmount;
    map['claimantNetPayable'] = this._claimantNetPayable;
    map['created'] = this._created;
    return map;
  }

  ClaimantModel(
      {claimantId,
        claimId,
        claimNumber,
        claimAmount,
        claimantFirstName,
        claimantMiddleName,
        claimantLastName,
        claimantNumber,
        claimantStatus,
        claimantClaimAmount,
        claimantNetPayable,
        created}) {
    this._claimantId = claimantId;
    this._claimId = claimId;
    this._claimNumber = claimNumber;
    this._claimAmount = claimAmount;
    this._claimantFirstName = claimantFirstName;
    this._claimantMiddleName = claimantMiddleName;
    this._claimantLastName = claimantLastName;
    this._claimantNumber = claimantNumber;
    this._claimantStatus = claimantStatus;
    this._claimantClaimAmount = claimantClaimAmount;
    this._claimantNetPayable = claimantNetPayable;
    this._created = created;
  }

  ClaimantModel.fromJson(Map<String, dynamic> jsonData) {
    this._claimantId = jsonData['id'];
    this._claimId = jsonData['claim']['id'];
    this._claimNumber = jsonData['claim']['claimNumber'];
    this._claimAmount = jsonData['claim']['claimAmount'] != null
        ? double.parse(jsonData['claim']['claimAmount'].toString())
        : 0.0;
    this._claimantFirstName = jsonData['user']['firstName'];
    this._claimantMiddleName = jsonData['user']['profile']['middleName'];
    this._claimantLastName = jsonData['user']['lastName'];
    this._claimantNumber = jsonData['claimantNumber'];
    this._claimantStatus = jsonData['claimantStatus'];
    this._claimantClaimAmount = jsonData['claimantClaimAmount'] != null
        ? double.parse(jsonData['claimantClaimAmount'].toString())
        : 0.0;
    this._claimantNetPayable = jsonData['claimantNetPayable'] != null?double.parse(jsonData['claimantNetPayable'].toString()): 0.0;
    this._created = jsonData['created'];
  }

  String? get claimantId => this._claimantId;

  String? get claimId => this._claimId;

  String? get claimNumber => this._claimNumber;

  double? get claimAmount => this._claimAmount;

  String? get claimantFirstName => this._claimantFirstName;

  String? get claimantMiddleName => this._claimantMiddleName;

  String? get claimantLastName => this._claimantLastName;

  String? get claimantNumber => this._claimantNumber;

  String? get claimantStatus => this._claimantStatus;

  double? get claimantClaimAmount => this._claimantClaimAmount;

  double? get claimantNetPayable => this._claimantNetPayable;

  String? get created => this._created;

  // String getFormattedClaimAmount() {
  //   return formatter.format(this._claimAmount);
  // }
  //
  // String getFormattedClaimantClaimAmount() {
  //   return formatter.format(this._claimantClaimAmount);
  // }
  //
  // String getFormattedClaimantNetPayable() {
  //   return formatter.format(this._claimantNetPayable);
  // }
}

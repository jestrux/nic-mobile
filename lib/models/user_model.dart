import 'package:nic/models/branch_model.dart';

class UserModel {
  String? _token;
  String? _id;
  String? _firstName;
  String? _middleName;
  String? _lastName;
  String? _phone;
  String? _email;
  String? _pic;
  String? _customCustomerNumber;
  int? _customerNumberType = 0;
  int? _totalPolicies = 0;
  int? _totalLifePolicies = 0;
  int? _totalProposals = 0;
  int? _totalNonLifePolicies = 0;
  int? _totalClaims = 0;
  bool? _needPasswordChange = false;
  int? _customerType = 3;
  String? _intermediaryName;
  BranchModel? _branch;

  UserModel({
    token,
    id,
    firstName,
    middleName,
    lastName,
    email,
    phone,
    BranchModel? branch,
    pic,
    customCustomerNumber,
    customerNumberType,
    totalPolicies,
    totalLifePolicies,
    totalProposals,
    totalNonLifePolicies,
    totalClaims,
    needPasswordChange,
    customerType,
    intermediaryName,
  }) {
    _token = token;
    _id = id;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _branch = branch;
    _pic = pic;
    _customCustomerNumber = customCustomerNumber;
    _customerNumberType = customerNumberType;
    _totalPolicies = totalPolicies;
    _totalLifePolicies = totalLifePolicies;
    _totalProposals = totalProposals;
    _totalNonLifePolicies = totalNonLifePolicies;
    _totalClaims = totalClaims;
    _needPasswordChange = needPasswordChange;
    _customerType = customerType;
    _intermediaryName = intermediaryName;
  }

  Map<String, dynamic> toMap() {
    return {
      'token': _token,
      'id': _id,
      'firstName': _firstName,
      'middleName': _middleName,
      'lastName': _lastName,
      'email': _email,
      'phone': _phone,
      'fullName': fullName,
      'branchName': _branch != null ? _branch!.name : '',
      'pic': _pic,
      'customCustomerNumber': _customCustomerNumber,
      'customerNumberType': _customerNumberType,
      'total_policies': _totalPolicies,
      'total_life_policies': _totalLifePolicies,
      'total_non_life_policies': _totalNonLifePolicies,
      'total_proposals': _totalProposals,
      'total_claims': _totalClaims,
      'needPasswordChange': _needPasswordChange,
      'intermediaryName': _intermediaryName,
      'customerType': _customerType,
    };
  }

  UserModel.fromJson(Map<String, dynamic>? data) {
    if (data == null) return;

    _token = data['token'];
    _id = data['id'];
    _firstName = data['firstName'];
    _lastName = data['lastName'];
    _email = data['email'];
    _middleName = data['middleName'];
    _phone = data['phone'];
    _pic = data['pic'];
    _customCustomerNumber = data['customCustomerNumber'];
    _customerNumberType = data['customerNumberType'];
    _totalPolicies = data['totalPolicies'];
    _totalLifePolicies = data['totalLifePolicies'];
    _totalNonLifePolicies = data['totalNonLifePolicies'];
    _totalProposals = data['totalProposals'];
    _totalClaims = data['totalClaims'];
    _needPasswordChange = data['needPasswordChange'];
    _customerType = data['customerType'];
    _intermediaryName = data['intermediaryName'];

    if (data['branch'] != null) {
      var branch = data['branch'];
      _branch = BranchModel(
        id: branch['id'],
        name: branch['name'],
        code: branch['code'],
      );
    }
  }
  //
  // UserModel.fromPolicyJson(Map<String, dynamic>? jsonData) {
  //   if (jsonData != null) {
  //     if (jsonData['policyVerification'] != null) {
  //       _token = jsonData['policyVerification']['token'];
  //       if (jsonData['policyVerification']['user'] != null) {
  //         _id = jsonData['policyVerification']['user']['id'];
  //         _firstName = jsonData['policyVerification']['user']['firstName'];
  //         _lastName = jsonData['policyVerification']['user']['lastName'];
  //         _email = jsonData['policyVerification']['user']['email'];
  //         if (jsonData['policyVerification']['user']['profile'] != null) {
  //           _middleName =
  //           jsonData['policyVerification']['user']['profile']['middleName'];
  //           _phone = jsonData['policyVerification']['user']['profile']['phone'];
  //           _pic = jsonData['policyVerification']['user']['profile']['pic'];
  //           _customCustomerNumber = jsonData['policyVerification']['user']['profile']['customCustomerNumber'];
  //           _customerNumberType = jsonData['policyVerification']['user']['profile']['customerNumberType'];
  //           _totalPolicies =
  //           jsonData['policyVerification']['user']['profile']['totalPolicies'];
  //           _totalLifePolicies =
  //           jsonData['policyVerification']['user']['profile']['totalLifePolicies'];
  //           _totalNonLifePolicies = jsonData['policyVerification']['user']['profile']
  //           ['totalNonLifePolicies'];
  //           _totalProposals =
  //           jsonData['policyVerification']['user']['profile']['totalProposals'];
  //           _totalClaims =
  //           jsonData['policyVerification']['user']['profile']['totalClaims'];
  //           if (jsonData['policyVerification']['user']['profile']['branch'] != null) {
  //             _branch = BranchModel(
  //                 id: jsonData['policyVerification']['user']['profile']['branch']['id'],
  //                 name: jsonData['policyVerification']['user']['profile']['branch']
  //                 ['name'],
  //                 code: jsonData['policyVerification']['user']['profile']['branch']
  //                 ['code']);
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
  //
  // UserModel.fromProposalJson(Map<String, dynamic> jsonData) {
  //   if (jsonData != null) {
  //     if (jsonData['initialForm'] != null) {
  //       _token = jsonData['initialForm']['token'];
  //       if (jsonData['initialForm']['user'] != null) {
  //         _id = jsonData['initialForm']['user']['id'];
  //         _firstName = jsonData['initialForm']['user']['firstName'];
  //         _lastName = jsonData['initialForm']['user']['lastName'];
  //         _email = jsonData['initialForm']['user']['email'];
  //         if (jsonData['initialForm']['user']['profile'] != null) {
  //           _middleName =
  //           jsonData['initialForm']['user']['profile']['middleName'];
  //           _phone = jsonData['initialForm']['user']['profile']['phone'];
  //           _pic = jsonData['initialForm']['user']['profile']['pic'];
  //           _customCustomerNumber = jsonData['initialForm']['user']['profile']['customCustomerNumber'];
  //           _customerNumberType = jsonData['initialForm']['user']['profile']['customerNumberType'];
  //           _totalPolicies =
  //           jsonData['initialForm']['user']['profile']['totalPolicies'];
  //           _totalLifePolicies =
  //           jsonData['initialForm']['user']['profile']['totalLifePolicies'];
  //           _totalNonLifePolicies = jsonData['initialForm']['user']['profile']['totalNonLifePolicies'];
  //           _totalProposals =jsonData['initialForm']['user']['profile']['totalProposals'];
  //           _totalClaims =jsonData['initialForm']['user']['profile']['totalClaims'];
  //           if (jsonData['initialForm']['user']['profile']['branch'] != null) {
  //             _branch = BranchModel(
  //                 id: jsonData['initialForm']['user']['profile']['branch']['id'],
  //                 name: jsonData['initialForm']['user']['profile']['branch']['name'],
  //                 code: jsonData['policyVerification']['user']['profile']['branch']['code']);
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
  //

  UserModel.fromRegisterJson(Map<String, dynamic>? data) {
    if (data == null) return;

    _token = data['token'];
    _id = data['id'];
    _firstName = data['firstName'];
    _lastName = data['lastName'];
    _email = data['email'];

    _middleName = data['middleName'];
    _phone = data['phone'];
    _pic = data['pic'];
    _customCustomerNumber = data['customCustomerNumber'];
    _customerNumberType = data['customerNumberType'];
    _totalPolicies = data['totalPolicies'];
    _totalLifePolicies = data['totalLifePolicies'];
    _totalNonLifePolicies = data['totalNonLifePolicies'];
    _totalProposals = data['totalProposals'];
    _totalClaims = data['totalClaims'];
    _needPasswordChange = data['needPasswordChange'];
    _customerType = data['customerType'];
    _intermediaryName = data['intermediaryName'];

    if (data['branch'] != null) {
      _branch = BranchModel(
          id: data['branch']['id'],
          name: data['branch']['name'],
          code: data['branch']['code']);
    }
  }

  String? get id => this._id;

  set id(String? value) {
    this._id = value;
  }

  // ignore: unnecessary_getters_setters
  String? get email => this._email;

  // ignore: unnecessary_getters_setters
  set email(String? value) {
    _email = value;
  }

  // ignore: unnecessary_getters_setters
  String? get phone => _phone;

  // ignore: unnecessary_getters_setters
  set phone(String? value) {
    _phone = value;
  }

  // ignore: unnecessary_getters_setters
  String? get lastName => _lastName;

  // ignore: unnecessary_getters_setters
  set lastName(String? value) {
    _lastName = value;
  }

  // ignore: unnecessary_getters_setters
  String? get middleName => _middleName;

  // ignore: unnecessary_getters_setters
  set middleName(String? value) {
    _middleName = value;
  }

  // ignore: unnecessary_getters_setters
  String? get firstName => _firstName;

  // ignore: unnecessary_getters_setters
  set firstName(String? value) {
    _firstName = value;
  }

  String get fullName =>
      "${_firstName ?? ""} ${_middleName ?? ""} ${_lastName ?? ""}";

  // ignore: unnecessary_getters_setters
  String? get token => _token;

  // ignore: unnecessary_getters_setters
  set token(String? value) {
    _token = value;
  }

  BranchModel? get branch => this._branch;

  set branch(BranchModel? branch) {
    this._branch = branch;
  }

  bool? get needPasswordChange => _needPasswordChange;

  set needPasswordChange(bool? value) {
    _needPasswordChange = value;
  }

  int? get customerType => _customerType;

  set customerType(int? value) {
    _customerType = value;
  }

  String? get intermediaryName => _intermediaryName;

  set intermediaryName(String? value) {
    _intermediaryName = value;
  }

  String? get pic => this._pic;
  String? get customCustomerNumber => this._customCustomerNumber;
  int? get customerNumberType => this._customerNumberType;
  int? get totalProposals => this._totalProposals;
  int? get totalPolicies => this._totalPolicies;
  int? get totalLifePolicies => this._totalLifePolicies;
  int? get totalNonLifePolicies => this._totalNonLifePolicies;
  int? get totalClaims => this._totalClaims;
}

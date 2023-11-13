import 'package:intl/intl.dart';

class PolicyModel {
  var formatter =
      NumberFormat.currency(locale: "sw_TZ", symbol: 'TSh ', decimalDigits: 2);
  String? _policyId;
  String? _displayName;
  String? _policyPropertyName;
  String? _policyNumber;
  double? _basePremium;
  double? _vat;
  double? _premium;
  String? _startDate;
  String? _endDate;
  String? _enforcedDate;
  String? _productId;
  String? _productName;
  int? _status;
  String? _statusName;
  String? _currencyName;
  String? _proposalDocument;
  String? _policyDocument;
  String? _covernoteDocument;
  String? _receiptVoucher;
  String? _taxinvoiceDocument;
  bool? _isPaid;
  bool? _isExpired;
  bool? _isLife;

  var statuses = {
    "1": "INFORCE",
    "2": "APPROVED",
    "3": "CANCELLED",
    "4": "PENDING",
    "5": "PROCESSING",
    "6": "EXPIRED",
    "7": "LAPSED",
    "8": "PAIDUP(DOMANT)",
    "9": "ENDORSED",
    "10": "PAIDUP PAID",
    "11": "MATURITY",
    "12": "MATURITY PAID",
    "13": "SURRENDER",
    "14": "SURRENDER PAID",
    "15": "PAIDUP",
    "16": "INFORCE (WAVED PREMIUM)"
  };

  PolicyModel.fromMap(Map<String, dynamic> map) {
    _policyId = map['policyId'];
    _displayName = map['displayName'];
    _policyPropertyName = map['policyPropertyName'];
    _premium = map['premium'];
    _basePremium = map['basePremium'];
    _vat = map['vat'];
    _policyNumber = map['policyNumber'];
    _startDate = map['startDate'];
    _endDate = map['endDate'];
    _enforcedDate = map['enforcedDate'];
    _productId = map['productId'];
    _productName = map['productName'];
    _isPaid = map['isPaid'];
    _isExpired = map['isExpired'];
    _status = map['status'];
    _statusName = map['statusName'];
    _currencyName = map['currencyName'];
    _proposalDocument = map['proposalDocument'];
    _policyDocument = map['policyDocument'];
    _covernoteDocument = map['covernoteDocument'];
    _receiptVoucher = map['receiptVoucher'];
    _taxinvoiceDocument = map['taxinvoiceDocument'];
    _isLife = map['isLife'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['policyId'] = _policyId;
    map['displayName'] = _displayName;
    map['policyPropertyName'] = _policyPropertyName;
    map['policyNumber'] = _policyNumber;
    map['basePremium'] = _basePremium;
    map['vat'] = _vat;
    map['premium'] = _premium;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['enforcedDate'] = _enforcedDate;
    map['productId'] = _productId;
    map['productName'] = _productName;
    map['status'] = _status;
    map['statusName'] = _statusName;
    map['currencyName'] = _currencyName;
    map['proposalDocment'] = _proposalDocument;
    map['policyDocument'] = _policyDocument;
    map['covernoteDocument'] = _covernoteDocument;
    map['receiptVoucher'] = _receiptVoucher;
    map['taxinvoiceDocument'] = _taxinvoiceDocument;
    map['isPaid'] = _isPaid;
    map['isExpired'] = _isExpired;
    map['isLife'] = _isLife;
    return map;
  }

  PolicyModel({
    policyId,
    displayName,
    policyPropertyName,
    basePremium,
    premium,
    vat,
    policyNumber,
    startDate,
    endDate,
    enforcedDate,
    productId,
    productName,
    isPaid,
    isExpired,
    status,
    statusName,
    currencyName,
    proposalDocument,
    policyDocument,
    covernoteDocument,
    receiptVoucher,
    taxinvoiceDocument,
    isLife,
  }) {
    _policyId = policyId;
    _displayName = displayName;
    _policyPropertyName = policyPropertyName;
    _premium = premium;
    _basePremium = basePremium;
    _vat = vat;
    _policyNumber = policyNumber;
    _startDate = startDate;
    _endDate = endDate;
    _enforcedDate = enforcedDate;
    _productId = productId;
    _productName = productName;
    _isPaid = isPaid;
    _isExpired = isExpired;
    _status = status;
    _statusName = statusName;
    _currencyName = currencyName;
    _proposalDocument = proposalDocument;
    _policyDocument = policyDocument;
    _covernoteDocument = covernoteDocument;
    _receiptVoucher = receiptVoucher;
    _taxinvoiceDocument = taxinvoiceDocument;
    _isLife = isLife;
  }

  PolicyModel.fromJson(Map<String, dynamic> jsonData) {
    _policyId = jsonData['id'];
    _displayName = jsonData['displayName'];
    _policyPropertyName = jsonData['policyPropertyName'];
    _policyNumber = jsonData['policyNumber'];
    _basePremium =
        double.parse(jsonData['totalPremiumVatExclusive'].toString());
    _vat = double.parse(jsonData['premiumVat'].toString());
    _premium = double.parse(jsonData['totalPremium'].toString());
    _startDate = jsonData['startDate'];
    _endDate = jsonData['endDate'];
    _enforcedDate = jsonData['enforcedDate'];
    _productId = jsonData['product']['id'];
    _isPaid = jsonData['isPaid'];
    _isExpired = jsonData['isExpired'];
    _status = jsonData['status'];
    _statusName = jsonData['statusName'];
    _currencyName =
        jsonData['currency'] != null ? jsonData['currency']['code'] : 'TZS';
    _productName =
        "${jsonData['product']['name']} ${jsonData['product']['productClass']['name']}";
    _proposalDocument = jsonData['proposalDocument'];
    _policyDocument = jsonData['policyDocument'];
    _covernoteDocument = jsonData['covernoteDocument'];
    _receiptVoucher = jsonData['receiptVoucher'];
    _taxinvoiceDocument = jsonData['taxinvoiceDocument'];
    _isLife = jsonData['isLife'];
  }

  void setPolicyId(String value) {
    _policyId = value;
  }

  void setDisplayName(String value) {
    _displayName = value;
  }

  void setPolicyNumber(String value) {
    _policyNumber = value;
  }

  void setStartDate(String value) {
    _startDate = value;
  }

  void setEndDate(String value) {
    _endDate = value;
  }

  void setEnforcedDate(String value) {
    _enforcedDate = value;
  }

  void setProductId(String value) {
    _productId = value;
  }

  void setProductName(String value) {
    _productName = value;
  }

  void setIsLife(bool value) {
    _isLife = value;
  }

  String? get policyId => _policyId;

  String? get displayName => _displayName;

  String? get policyPropertyName => _policyPropertyName;

  String? get policyNumber => _policyNumber;

  String? get startDate => _startDate;

  String? get endDate => _endDate;

  String? get enforcedDate => _enforcedDate;

  String? get productId => _productId;

  String? get productName => _productName;

  double? get premium => _premium;

  double? get basePremium => _basePremium;

  double? get vat => _vat;

  bool? get isPaid => _isPaid;

  bool? get isExpired => _isExpired;

  int? get status => _status;

  String? get statusName => _statusName;

  String? get currencycName => _currencyName;

  String? get proposalDocument => _proposalDocument;

  String? get policyDocument => _policyDocument;

  String? get covernoteDocument => _covernoteDocument;

  String? get receiptVoucher => _receiptVoucher;

  String? get taxinvoiceDocument => _taxinvoiceDocument;

  bool? get isLife => _isLife;

  String getFormattedTotalPremium() {
    return formatter.format(_premium);
  }

  String getFormattedBasePremium() {
    return formatter.format(_basePremium);
  }

  String getFormattedVat() {
    return formatter.format(_vat);
  }
}

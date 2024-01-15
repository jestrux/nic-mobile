import 'package:intl/intl.dart';

class ProposalModel {
  var formatter =
      NumberFormat.currency(locale: "sw_TZ", symbol: 'TSh ', decimalDigits: 2);
  String? _policyId;
  String? _displayName;
  String? _policyPropertyName;
  double? _basePremium;
  double? _vat;
  double? _premium;
  String? _startDate;
  String? _endDate;
  String? _createdDate;
  String? _productName;
  String? _currencyName;
  String? _proposalDocument;
  String? _taxinvoiceDocument;
  bool? _isPaid;


  ProposalModel.fromMap(Map<String, dynamic> map) {
    _policyId = map['policyId'];
    _displayName = map['displayName'];
    _policyPropertyName = map['policyPropertyName'];
    _premium = map['premium'];
    _basePremium = map['basePremium'];
    _vat = map['vat'];
    _startDate = map['startDate'];
    _endDate = map['endDate'];
    _createdDate = map['createdDate'];
    _productName = map['productName'];
    _isPaid = map['isPaid'];
    _currencyName = map['currencyName'];
    _proposalDocument = map['proposalDocument'];
    _taxinvoiceDocument = map['taxinvoiceDocument'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['policyId'] = _policyId;
    map['displayName'] = _displayName;
    map['policyPropertyName'] = _policyPropertyName;
    map['basePremium'] = _basePremium;
    map['vat'] = _vat;
    map['premium'] = _premium;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['createdDate'] = _createdDate;
    map['productName'] = _productName;
    map['currencyName'] = _currencyName;
    map['proposalDocment'] = _proposalDocument;
    map['taxinvoiceDocument'] = _taxinvoiceDocument;
    map['isPaid'] = _isPaid;
    return map;
  }

  ProposalModel({
    policyId,
    displayName,
    policyPropertyName,
    basePremium,
    premium,
    vat,
    startDate,
    endDate,
    createdDate,
    productName,
    isPaid,
    isExpired,
    currencyName,
    proposalDocument,
    taxinvoiceDocument,
    isLife,
  }) {
    _policyId = policyId;
    _displayName = displayName;
    _policyPropertyName = policyPropertyName;
    _premium = premium;
    _basePremium = basePremium;
    _vat = vat;
    _startDate = startDate;
    _endDate = endDate;
    _createdDate = createdDate;
    _productName = productName;
    _isPaid = isPaid;
    _currencyName = currencyName;
    _proposalDocument = proposalDocument;
    _taxinvoiceDocument = taxinvoiceDocument;
  }

  ProposalModel.fromJson(Map<String, dynamic> jsonData) {
    _policyId = jsonData['id'];
    _displayName = jsonData['displayName'];
    _policyPropertyName = jsonData['policyPropertyName'];
    _basePremium =
        double.parse(jsonData['totalPremiumVatExclusive'].toString());
    _vat = double.parse(jsonData['premiumVat'].toString());
    _premium = double.parse(jsonData['totalPremium'].toString());
    _startDate = jsonData['startDate'];
    _endDate = jsonData['endDate'];
    _createdDate = jsonData['createdDate'];
    _isPaid = jsonData['isPaid'];
    _currencyName =
        jsonData['currency'] != null ? jsonData['currency']['code'] : 'TZS';
    _productName =
        "${jsonData['product']['name']} ${jsonData['product']['productClass']['name']}";
    _proposalDocument = jsonData['proposalDocument'];
    _taxinvoiceDocument = jsonData['taxinvoiceDocument'];
  }

  void setPolicyId(String value) {
    _policyId = value;
  }

  void setDisplayName(String value) {
    _displayName = value;
  }

  void setStartDate(String value) {
    _startDate = value;
  }

  void setEndDate(String value) {
    _endDate = value;
  }

  void setcreatedDate(String value) {
    _createdDate = value;
  }

  void setProductName(String value) {
    _productName = value;
  }


  String? get policyId => _policyId;

  String? get displayName => _displayName;

  String? get policyPropertyName => _policyPropertyName;

  String? get startDate => _startDate;

  String? get endDate => _endDate;

  String? get createdDate => _createdDate;

  String? get productName => _productName;

  double? get premium => _premium;

  double? get basePremium => _basePremium;

  double? get vat => _vat;

  bool? get isPaid => _isPaid;

  String? get currencycName => _currencyName;

  String? get proposalDocument => _proposalDocument;

  String? get taxinvoiceDocument => _taxinvoiceDocument;

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

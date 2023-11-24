class LifeProposalModel {
  String? _id;
  String? _proposalNumber;

  LifeProposalModel.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _proposalNumber = map['proposalNumber'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['proposalNumber'] = _proposalNumber;

    return map;
  }

  LifeProposalModel({id, proposalNumber}) {
    _id = id;
    _proposalNumber = proposalNumber;
  }

  LifeProposalModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _proposalNumber = jsonData['proposalNumber'];
  }

  String? get id => _id;
  String? get proposalNumber => _proposalNumber;
}

class FrikiModel {
  int? iD;
  String? nAMEFRIKI;
  String? lASTNAMEFRIKI;
  String? eMAILFRIKI;
  String? pASSWORDFRIKI;
  String? iMAGEFRIKI;

  FrikiModel(
      {this.iD,
      this.nAMEFRIKI,
      this.lASTNAMEFRIKI,
      this.eMAILFRIKI,
      this.pASSWORDFRIKI,
      this.iMAGEFRIKI});

  FrikiModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAMEFRIKI = json['NAME_FRIKI'];
    lASTNAMEFRIKI = json['LASTNAME_FRIKI'];
    eMAILFRIKI = json['EMAIL_FRIKI'];
    pASSWORDFRIKI = json['PASSWORD_FRIKI'];
    iMAGEFRIKI = json['IMAGE_FRIKI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NAME_FRIKI'] = nAMEFRIKI;
    data['LASTNAME_FRIKI'] = lASTNAMEFRIKI;
    data['EMAIL_FRIKI'] = eMAILFRIKI;
    data['PASSWORD_FRIKI'] = pASSWORDFRIKI;
    data['IMAGE_FRIKI'] = iMAGEFRIKI;
    return data;
  }
}

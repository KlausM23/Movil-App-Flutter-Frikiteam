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
    data['NAME_FRIKI'] = nAMEFRIKI!.toString();
    data['LASTNAME_FRIKI'] = lASTNAMEFRIKI!.toString();
    data['EMAIL_FRIKI'] = eMAILFRIKI!.toString();
    data['PASSWORD_FRIKI'] = pASSWORDFRIKI!.toString();
    data['IMAGE_FRIKI'] = iMAGEFRIKI!.toString();
    return data;
  }
}

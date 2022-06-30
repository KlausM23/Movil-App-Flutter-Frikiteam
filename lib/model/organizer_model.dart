class OrganizerModel {
  String? nAMEORGANIZER;
  String? lASTNAMEORGANIZER;
  String? eMAILORGANIZER;
  String? pASSWORDORGANIZER;
  String? iMAGEORGANIZER;
  int? iD;

  OrganizerModel(
      {this.nAMEORGANIZER,
      this.lASTNAMEORGANIZER,
      this.eMAILORGANIZER,
      this.pASSWORDORGANIZER,
      this.iMAGEORGANIZER,
      this.iD});

  OrganizerModel.fromJson(Map<String, dynamic> json) {
    nAMEORGANIZER = json['NAME_ORGANIZER'];
    lASTNAMEORGANIZER = json['LASTNAME_ORGANIZER'];
    eMAILORGANIZER = json['EMAIL_ORGANIZER'];
    pASSWORDORGANIZER = json['PASSWORD_ORGANIZER'];
    iMAGEORGANIZER = json['IMAGE_ORGANIZER'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NAME_ORGANIZER'] = nAMEORGANIZER;
    data['LASTNAME_ORGANIZER'] = lASTNAMEORGANIZER;
    data['EMAIL_ORGANIZER'] = eMAILORGANIZER;
    data['PASSWORD_ORGANIZER'] = pASSWORDORGANIZER;
    data['IMAGE_ORGANIZER'] = iMAGEORGANIZER;
    return data;
  }
}

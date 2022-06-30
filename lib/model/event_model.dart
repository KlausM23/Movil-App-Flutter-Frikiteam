import 'package:app_flutter_frikiteam/model/organizer_model.dart';

class EventModel {
  int? iD;
  String? nAMEEVENT;
  String? dESCRIPTION;
  String? lOGO;
  String? lOGO2;
  String? aDDRESS;
  String? pRICE;
  int? aMOUNT;
  OrganizerModel? organizerModel;

  EventModel(
      {this.iD,
      this.nAMEEVENT,
      this.dESCRIPTION,
      this.lOGO,
      this.lOGO2,
      this.aDDRESS,
      this.pRICE,
      this.aMOUNT,
      this.organizerModel});

  EventModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAMEEVENT = json['NAME_EVENT'];
    dESCRIPTION = json['DESCRIPTION'];
    lOGO = json['LOGO'];
    lOGO2 = json['LOGO2'];
    aDDRESS = json['ADDRESS'];
    pRICE = json['PRICE'];
    aMOUNT = json['AMOUNT'];
    organizerModel = json['ORGANIZER_ID'] != null
        ? OrganizerModel.fromJson(json['ORGANIZER_ID'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['NAME_EVENT'] = nAMEEVENT;
    data['DESCRIPTION'] = dESCRIPTION;
    data['LOGO'] = lOGO;
    data['LOGO2'] = lOGO2;
    data['ADDRESS'] = aDDRESS;
    data['PRICE'] = pRICE;
    data['AMOUNT'] = aMOUNT;
    if (organizerModel != null) {
      data['ORGANIZER_ID'] = organizerModel!.toJson();
    }
    return data;
  }
}

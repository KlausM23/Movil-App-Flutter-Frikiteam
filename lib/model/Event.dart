class Event {
  int? id;
  String? logo;
  String? information;
  String? name;
  double? price;
  int? quantity;
  int? sold;
  bool? verified;
  int? startDate;
  int? endDate;
  int? eventTypeId;
  int? organizerId;
  int? placeId;

  Event(
      {this.id,
      this.logo,
      this.information,
      this.name,
      this.price,
      this.quantity,
      this.sold,
      this.verified,
      this.startDate,
      this.endDate,
      this.eventTypeId,
      this.organizerId,
      this.placeId});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    information = json['information'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    sold = json['sold'];
    verified = json['verified'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    eventTypeId = json['eventTypeId'];
    organizerId = json['organizerId'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['information'] = this.information;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['sold'] = this.sold;
    data['verified'] = this.verified;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['eventTypeId'] = this.eventTypeId;
    data['organizerId'] = this.organizerId;
    data['placeId'] = this.placeId;
    return data;
  }
}

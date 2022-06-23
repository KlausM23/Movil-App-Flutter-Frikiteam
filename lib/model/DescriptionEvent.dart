class DescriptionEvent {
  int? id;
  String? title;
  String? description;
  String? image;

  DescriptionEvent({this.id, this.title, this.description, this.image});

  DescriptionEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}

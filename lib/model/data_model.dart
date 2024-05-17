class DataModel {
  String name;
  String img;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? img5;
  String? img6;
  String? img7;
  String? img8;
  String description;
  String location;
  String? googlemapyid; // This can be null in your JSON data
  String web;

  DataModel({
    required this.name,
    required this.img,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.img5,
    this.img6,
    this.img7,
    this.img8,
    required this.description,
    required this.location,
    this.googlemapyid,
    required this.web,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json["name"],
      img: json["img"],
      img1: json["img1"],
      img2: json["img2"],
      img3: json["img3"],
      img4: json["img4"],
      img5: json["img5"],
      img6: json["img6"],
      img7: json["img7"],
      img8: json["img8"],
      description: json["description"],
      location: json["location"],
      googlemapyid: json["googlemapyid"],
      web: json["web"],
    );
  }
}

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
  String googlemapyid;

  DataModel({
    required this.name,
    required this.img,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.img6,
    required this.img7,
    required this.img8,
    required this.description,
    required this.location,
    required this.googlemapyid,
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
    );
  }
}

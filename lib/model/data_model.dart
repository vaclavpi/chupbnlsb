class DataModel {
  String name;
  String img;
  String description;
  String location;
  String googlemapyid;

  DataModel({
    required this.name,
    required this.img,
    required this.description,
    required this.location,
    required this.googlemapyid,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json["name"],
      img: json["img"],
      description: json["description"],
      location: json["location"],
      googlemapyid: json["googlemapyid"],
    );
  }
}

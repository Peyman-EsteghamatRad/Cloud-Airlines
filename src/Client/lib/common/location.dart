




class Location{

  Location(
      this.id,
      this.type,
      this.subType,
      this.name,
      this.geoCode,
      this.category,
      this.tags,
      this.rank,
      );

  String id;
  String type;
  String subType;
  String name;
  dynamic geoCode;
  String category;
  List<String> tags;
  int rank;


  factory Location.fromJson(Map<String,dynamic> json){
    return Location(
      json["id"],
      json["type"],
        json["subType"],
      json["name"],
      json["geoCode"],
      json["category"],
      List<String>.from(json["tags"]),
      json["rank"],
    );
  }


}




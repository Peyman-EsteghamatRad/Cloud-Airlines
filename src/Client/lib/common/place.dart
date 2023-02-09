class Place {
  Place(this.id, this.name, this.category, this.address, this.imgURL,
      this.website, this.description, this.latitude, this.longitude);

  String id;
  String name;
  String category;
  String address;
  String imgURL;
  String? website;
  String? description;
  double? latitude;
  double? longitude;

  factory Place.fromJson(Map<String, dynamic> json) {
    try{
      return Place(
        json["fsq_id"],
        json["name"],
        json["categories"][0]["name"],
        json["location"]["formatted_address"],
        json["categories"][0]["icon"]["prefix"] +
            "64" +
            json["categories"][0]["icon"]["suffix"],
        json["website"],
        json["description"],
        json["geocodes"]["main"]["latitude"],
        json["geocodes"]["main"]["longitude"],

      );
    }
    catch(e){
      return Place(
        json["fsq_id"],
        json["name"],
        json["categories"][0]["name"],
        json["location"]["formatted_address"],
        json["categories"][0]["icon"]["prefix"] +
            "64" +
            json["categories"][0]["icon"]["suffix"],
        json["website"],
        json["description"],
        null,
        null
      );
    }
  }


  @override
  String toString(){
    return name;
  }
}

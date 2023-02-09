

class POI {

  int idPOI;
  String pointOfIntNr;

  POI(
      this.idPOI,
      this.pointOfIntNr
      );

  factory POI.fromJson(Map<String, dynamic> json){
    return POI(
      json["idPOI"],
      json["pointOfIntNr"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "idPOI": idPOI,
      "pointOfIntNr": pointOfIntNr
    };
  }

  @override
  String toString(){
    return "$pointOfIntNr: $idPOI";
  }


}
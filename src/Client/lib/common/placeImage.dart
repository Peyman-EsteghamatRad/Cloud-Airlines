
import 'package:flutter/cupertino.dart';

class PlaceImage {

  PlaceImage(this.prefix, this.suffix, this.width, this.heigth);

  final int width, heigth;
  final String prefix;
  final String suffix;


  String getImageURL({bool squared=true, int maxSideSize = 500}){
    if(squared) {
      int side = width;
      if (heigth < width) {
        side = heigth;
      }
      if (side > maxSideSize) {
        side = maxSideSize;
      }
      return prefix + "$side" + "x$side" + suffix;
    }
    else{
      return prefix + "original" + suffix;
    }
  }


  factory PlaceImage.fromJSON(Map<String,dynamic> json){
    return PlaceImage(json["prefix"], json["suffix"], json["width"], json["height"]);
  }

  @override
  String toString(){
    return getImageURL();
  }

}

import "package:flutter/material.dart";
import 'package:frontend/components/CustomTextWidget.dart';
import 'package:frontend/controllers/poicontroller.dart';
import 'package:http/http.dart';

import '../common/poi.dart';

class ApiTestView extends StatefulWidget {
  const ApiTestView({Key? key}) : super(key: key);

  @override
  State<ApiTestView> createState() => _ApiTestViewState();
}

class _ApiTestViewState extends State<ApiTestView> {

  List<POI> poiList = [];

  @override
  Widget build(BuildContext context) {

    String result = "";
    for(POI p in poiList){
      result += p.toString();
    }
    POI poi = POI(1,"hallo was geht");
    return Column(
      children: [
        MaterialButton(onPressed: (){
          POIController.addPOI(poi.toJson());
        }, child: Container(color: Colors.orange, height: 200, width: 200,),),
        MaterialButton(onPressed: (){
          getPOIs();
        }, child: Container(color: Colors.black,height: 200, width: 200)),
        MaterialButton(onPressed: (){
          POIController.deletePOI(poiList.removeLast().idPOI);
        }, child: Container(color: Colors.redAccent,height: 200, width: 200)),
        CustomTextWidget(result, color: Colors.black,)

      ],
    );
  }


  void getPOIs() async {
    List<POI> tmp = await POIController.getAllPOIs();
    setState(
        (){
          poiList = tmp;
        }
    );
  }
}

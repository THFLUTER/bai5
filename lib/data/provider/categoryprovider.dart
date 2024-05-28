import 'dart:convert';

import 'package:bai5/data/model/categorymodel.dart';
import 'package:flutter/services.dart';

class ReadData{
  Future<List<Category>> loadData() async{
    var data = await rootBundle.loadString("assets/files/categorylist.json");
    var dataJson = jsonDecode(data);
    return(dataJson["data"] as List).map((e) => Category.fomeJson(e)).toList();
  }

  Future<Iterable<Category>> loadDataByCat(int catId) async{
    var data= await rootBundle.loadString("assets/files/categorylist.json");
    var dataJson=jsonDecode(data);
    return(dataJson["data"]as List)
    .map((e) => Category.fomeJson(e))
    .where((e) => e.id == catId)//gettdata withcatid
    .toList();
  }
}
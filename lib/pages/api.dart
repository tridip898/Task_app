import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/model/api_model.dart';

class APIData extends StatefulWidget {
  const APIData({Key? key}) : super(key: key);

  @override
  State<APIData> createState() => _APIDataState();
}

class _APIDataState extends State<APIData> {
  List<APIModel> apilist=[];
  Future getData() async{
    var response=await http.get(Uri.parse('https://hajjmanagment.online/api/external/atab/m360ict/get/video/app/test'));
    var jsonData=jsonDecode(response.body);
    print(jsonData);
    print("tr");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (_,snapshot){
        if(snapshot.data == null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
            return ListTile(
              title: Text("Tridip"),
            );
          });
        }
      }),
    ));
  }
}

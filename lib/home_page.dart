import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse='';
  late List listResponse;

  Future apiCall() async{
    http.Response response;
    response= await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode==200){
      setState(() {
        // stringResponse=response.body;
        mapResponse=json.decode(response.body);
        listResponse=mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
  apiCall();
    super.initState();
  }
   late Map mapResponse;
  late Map dataResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Api Integration"),
      ),
        body:ListView.separated(
          scrollDirection: Axis.vertical,
            // ignore: unnecessary_null_comparison
            itemCount: listResponse==null ? 0:listResponse.length,
            shrinkWrap: true,
            itemBuilder: (context ,index){
          return ListTile(
            tileColor: Colors.white,

            leading: CircleAvatar(
              radius: 35.0,
              child: Image.network(listResponse[index]["avatar"]),
            ),
            title: Row(
              children: [
                Text(listResponse[index]['first_name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                ),
                SizedBox(width: 10.0,),
                Text(listResponse[index]['last_name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            subtitle: Text(listResponse[index]['email'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            ),
            trailing: CircleAvatar(
              radius: 17.0,
              backgroundColor: listResponse[index]['id']<10 ? Colors.blueAccent:Colors.red,
              child: Text(listResponse[index]['id'].toString(),
              style: TextStyle(
                color: Colors.white,
              ),
              ),
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) {
            return Divider();
        },
        )
    );
  }
}
// Center(
// child: Container(
// color: Colors.blue,
// width: 300,
// height: 400,
// child: Center(
// // ignore: unnecessary_null_comparison
// child: listResponse==null ?  Text('Data is loading'):Text(listResponse[0].toString()),
//
// ),
// ),
// ),

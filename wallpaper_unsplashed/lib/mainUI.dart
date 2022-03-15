import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';

class MainUI extends StatefulWidget {
  const MainUI({Key? key}) : super(key: key);

  @override
  _MainUIState createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {

  List<PhotoList> _photos = [];

  Future<List<PhotoList>> fetchJson() async {
    int r = Random().nextInt(5000);
    var response = await http.get(Uri.parse('https://api.unsplash.com/photos?client_id=Sp-dh4HdBINWnBEiNml6br1AfjS0kYc1fjnTU87F714&page=$r'));
    List<PhotoList> pList = [];
    if(response.statusCode == 200){
      var urJson = json.decode(response.body);
      debugPrint(urJson);
      for(var jsondata in urJson){
        pList.add(PhotoList.fromJson(jsondata));
      }
    }
    return pList;
  }
  
  @override
  void initState() {
    fetchJson().then((value) {
      setState(() {
        _photos.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Fetch Image'),
      ),
      body: GestureDetector(
        onHorizontalDragDown: (context){
          setState(() {
            fetchJson().then((value) {
              setState(() {
                _photos = [];
                _photos.addAll(value);
              });
            });
          });
        },
        child: GridView.count(
          crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            children: List.generate(_photos.length, (index) {
              return Card(
                color: HexColor(_photos[index].color),
                child: Column(
                  children: [
                    Image.network(_photos[index].urls.small, height: 200, width: 200, fit: BoxFit.cover,),
                    const SizedBox(height: 10.0,),
                    Text('Hit : ${_photos[index].likes}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                  ],
                ),
              );
            },)
        ),
      ),
      );

  }
  
}



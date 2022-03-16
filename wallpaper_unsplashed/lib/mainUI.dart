import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';


class MainUI extends StatefulWidget {
  const MainUI({Key? key}) : super(key: key);

  @override
  _MainUIState createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {

  List<PhotoList> _photos = [];

  Future<List<PhotoList>> fetchJson() async {
    _photos = [];
    int r = Random().nextInt(299)+1;
    var response = await http.get(Uri.parse('https://raw.githubusercontent.com/mrmezan06/Unsplash-Json-File/main/unsplash_json%20(${r.toString()}).json'));
    List<PhotoList> pList = [];
    if(response.statusCode == 200){
      //print(response.body);
      var urJson = json.decode(response.body);

      //debugPrint(urJson);
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
        onPanEnd: (context){
          fetchJson().then((value) {
            setState(() {
              _photos.addAll(value);
            });
          });
        },
        child: GridView.count(
          crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            children: List.generate(_photos.length, (index) {
              return Card(
                shadowColor: Colors.deepOrangeAccent,
                color: HexColor(_photos[index].color),
                child: Column(
                  children: [
                     CachedNetworkImage(
                        width: 200,
                        height: 140,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        imageUrl: _photos[index].urls.small,
                      ),
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



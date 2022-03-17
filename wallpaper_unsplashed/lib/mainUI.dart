import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_unsplashed/imageUI.dart';
import 'album.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
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
              childAspectRatio: 0.6,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              crossAxisCount: 2,
              children: List.generate(_photos.length, (index) {
                return GridTile(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ImageUI(imageObject: _photos[index],)),
                        );
                      },
                        child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                    imageUrl: _photos[index].urls.small,
                                    placeholder: (context, url) => Container(
                                      color: const Color(0xfff5f8fd),
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                    )
                );
              }
    )
          ),
      ),
      );

  }
  
}

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.white, fontFamily: 'Overpass'),
      ),
      Text(
        "Store",
        style: TextStyle(color: Colors.deepOrange, fontFamily: 'Overpass'),
      )
    ],
  );
}



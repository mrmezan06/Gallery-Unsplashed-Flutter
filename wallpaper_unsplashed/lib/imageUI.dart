import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallpaper_unsplashed/album.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_unsplashed/mainUI.dart';

class ImageUI extends StatelessWidget {
  const ImageUI({Key? key, required this.imageObject}) : super(key: key);

  final PhotoList imageObject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:  CachedNetworkImage(imageUrl: imageObject.urls.full,
                  height: 400,
                  width: 400,
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: pleaseWait(),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFFF22),
                            Color(0xFFF2F2FF),
                            Color(0xFF22FFFF)
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)
                    ),
                  ),
                  fit: BoxFit.cover,
              ),
            ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () {

                      _save(context, imageObject.urls.full);

                      //Navigator.pop(context);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        //save1
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white24, width: 1),
                                borderRadius: BorderRadius.circular(40),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "Save HD",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  "Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white70),
                                ),
                              ],
                            )),
                      ],
                    ),
                ),
                const SizedBox(height: 16,),
                InkWell(
                  onTap: () {

                    _save(context, imageObject.urls.raw);

                    //Navigator.pop(context);
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff1C1B1B).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      //save1
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.white24, width: 1),
                              borderRadius: BorderRadius.circular(40),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0x36FFFFFF),
                                    Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                "Save FHD",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                "Image will be saved in gallery",
                                style: TextStyle(
                                    fontSize: 8, color: Colors.white70),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _save(BuildContext context,String url) async {
    await _askPermission();

    var response = await Dio().get(url,
        options: Options(responseType: ResponseType.bytes));
    //final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));

    const snackBar = SnackBar(
      content: Text('Image Saved In Gallery!'),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //print(result);
   // Navigator.pop(context);
  }

  _askPermission() async {
    /*await PermissionHandler()
        .checkPermissionStatus(Permission.storage);*/
    Permission.storage;
  }
}

Widget pleaseWait() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        "Please",
        style: TextStyle(color: Colors.redAccent, fontFamily: 'Overpass', fontSize: 22, fontWeight: FontWeight.bold),
      ),
      Text(
        "Wait",
        style: TextStyle(color: Colors.deepOrange, fontFamily: 'Overpass' , fontSize: 22, fontWeight: FontWeight.bold),
      ),
      Text(
        "...",
        style: TextStyle(color: Colors.red, fontFamily: 'Overpass', letterSpacing: 2.0, fontSize: 22, fontWeight: FontWeight.bold),
      )
    ],
  );
}

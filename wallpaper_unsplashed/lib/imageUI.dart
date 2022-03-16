import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallpaper_unsplashed/album.dart';

class ImageUI extends StatelessWidget {
  const ImageUI({Key? key, required this.imageObject}) : super(key: key);

  final PhotoList imageObject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Image'),
      ),
      body: Card(
        color: HexColor(imageObject.color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CachedNetworkImage(
                    fit: BoxFit.cover,
                    fadeOutCurve: Curves.fastLinearToSlowEaseIn,
                    fadeInCurve: Curves.easeIn,
                    fadeInDuration: const Duration(milliseconds: 1500),
                    fadeOutDuration: const Duration(milliseconds: 1500),
                      height: MediaQuery.of(context).size.height*.50,
                      width: MediaQuery.of(context).size.width,
                    placeholder: (context, url) => const CircularProgressIndicator(
                    color: Colors.lightGreen,
                    strokeWidth: 1.0,
                    ),
                  imageUrl: imageObject.urls.full,
              ),
            const SizedBox(height: 5,),
            Text('Uploaded: ${imageObject.createdAt.toString()}',style: const TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18,
            ),),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('MaxSize: ${imageObject.width.toString()}X${imageObject.height.toString()}', style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24,
                ),),
                Text('Hit: ${imageObject.likes.toString()}',style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24,
                ),),
              ],
            ),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: (){
              // set wallpaper
             // print('tapped');
            },
                child: const Text('Set Wallpaper',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28,
                  backgroundColor: Colors.deepOrange,
                  letterSpacing: 2.0,
            ),
                ),
            ),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: (){
                // set Lock Screen
                // print('tapped');
              },
              child: const Text('Set Lock Screen',style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28,
                backgroundColor: Colors.deepOrange,
                letterSpacing: 2.0,
              ),
              ),
            ),
            //const Spacer(),
          ],
        ),
      ),
    );
  }
}

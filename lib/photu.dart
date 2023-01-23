import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';

class PhotuPage extends StatefulWidget {
  const PhotuPage({Key? key}) : super(key: key);

  @override
  State<PhotuPage> createState() => _PhotuPageState();
}

File? _globalImage;
String popText='Download';
class _PhotuPageState extends State<PhotuPage> {
  @override
  Widget build(BuildContext context) {
    Future getCamera() async {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      File tempImage = File(image.path);
      setState(() {
        _globalImage = tempImage;
      });
    }

    Future getGallery() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      File tempImage = File(image.path);
      setState(() {
        _globalImage = tempImage;
      });
    }
    void saveImage() {
      if(_globalImage==null){
        return;
      }
      else{
        setState(() {
          popText='Downloading';
        });
        GallerySaver.saveImage(_globalImage!.path);
        setState(() {
          popText='Downloaded';
        });
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                getCamera();
                popText='Download';
              },
              child: Text(
                'From Camera',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                getGallery();
                popText='Download';
              },
              child: Text(
                'From Gallery',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                saveImage();
              },
              child: Text(
                '$popText',
              ),
            ),
          ],
        ),
        _globalImage != null
            ? Image.file(
                _globalImage!,
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              )
            : Image.network(
                'https://s.keepmeme.com/files/en_posts/20200819/2e7175697eab40b392acf06d02002004cat-with-loading-sign-on-head.jpg',
                height: 130,
                width: 130,
                fit: BoxFit.cover),
      ],
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  final Map arg;
  NewPost({required this.arg});

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    print(widget.arg);
    return Scaffold(
      body: CircularProgressIndicator(),
    );
    //File? image;
    //String? url;
    //image = widget.arg['image'];
    //url = widget.arg['url'];
    //print(image);
    //print(url);
//
    //if (image != null) {
    //  return Scaffold(
    //    body: Column(children: [
    //      Image.file(image),
    //    ]),
    //  );
    //} else {
    //  return Scaffold(body: Center(child: CircularProgressIndicator()));
    //}
  }
}

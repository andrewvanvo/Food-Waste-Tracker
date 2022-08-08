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
  File? imageLink;
  Future grabImage() async {
    imageLink = widget.arg['url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.file(widget.arg['image']),
        )
      ],
    ));
  }
}

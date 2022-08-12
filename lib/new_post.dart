import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class NewPost extends StatefulWidget {
  final Map arg;
  NewPost({required this.arg});

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File? imageLink;
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  String? getDate() {
    String? formattedDate;
    DateTime date = DateTime.now();
    final DateFormat formatter = DateFormat('E, MMMM, d, y');
    return formattedDate = formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    //getDate();
    final formKey = GlobalKey<FormState>();
    String? formValue;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        leading: GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, 'home');
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Latitude: ${locationData?.latitude}',
          ),
          Text(
            'Longitude:  ${locationData?.longitude}',
          ),
          Center(
            child: Image.file(widget.arg['image']),
          ),
          Center(
              child: Form(
                  key: formKey,
                  child: TextFormField(
                    autofocus: true,
                    decoration:
                        InputDecoration(labelText: 'Number of Wasted Items'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSaved: (value) {
                      formValue = value;
                    },
                    validator: (String? value) {
                      //if validator returns null, it's good
                      if (value!.isEmpty) {
                        return "Please enter an amount";
                      } else {
                        return null;
                      }
                    },
                  )))
        ],
      ),
      floatingActionButton: Semantics(
          child: FloatingActionButton.extended(
            onPressed: () async {
              final date = getDate();
              final id = DateTime.now().toString();
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                uploadData(id, date, widget.arg['url'], formValue,
                    locationData?.latitude, locationData?.longitude);
                Navigator.of(context).popAndPushNamed('home');
              }
            },
            icon: Icon(Icons.upload),
            label: Text('Upload'),
          ),
          button: true,
          onTapHint: "Upload Data to Cloud Storage"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

void uploadData(id, date, url, quantity, lat, long) async {
  final passedid = id;
  final passeddate = date;
  final passedurl = url;
  final passedquantity = quantity;
  final passedlat = lat;
  final passedlon = long;
  FirebaseFirestore.instance.collection('wastetracker').add({
    'id': passedid,
    'date': passeddate,
    'url': passedurl,
    'quantity': passedquantity,
    'latitude': passedlat,
    'longitude': passedlon
  });
}

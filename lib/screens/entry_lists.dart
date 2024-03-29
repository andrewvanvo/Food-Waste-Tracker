import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodwastetracker/model/data_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'new_post.dart';
import 'loading_page.dart';
import '../model/data_fields.dart';

class EntryLists extends StatefulWidget {
  @override
  _EntryListsState createState() => _EntryListsState();
}

class _EntryListsState extends State<EntryLists> {
  @override
  Widget build(BuildContext context) {
    var id = DateTime.now().toString();

    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('wastetracker')
              .orderBy('id')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.docs != null &&
                snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    DataFields? data;
                    data?.id = post['id'];
                    data?.date = post['date'];
                    data?.url = post['url'];
                    data?.quantity = post['quantity'];
                    data?.lat = post['latitude'];
                    data?.lon = post['longitude'];
                    return ListTile(
                      title: Text(post['date']),
                      trailing: Text(post['quantity'].toString()),
                      onTap: () {
                        Navigator.of(context).pushNamed('entry', arguments: {
                          'date': post['date'],
                          'url': post['url'],
                          'quantity': post['quantity'],
                          'lat': post['latitude'].toString(),
                          'lon': post['longitude'].toString(),
                        });
                      },
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: Semantics(
        child: NewEntryButton(),
        button: true,
        onTapHint: "Press to select an image",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class NewEntryButton extends StatefulWidget {
  @override
  State<NewEntryButton> createState() => _NewEntryButtonState();
}

class _NewEntryButtonState extends State<NewEntryButton> {
  File? image;
  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    setState(() {});
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.photo_camera),
        onPressed: () async {
          Navigator.of(context).pushNamed('loading');

          final url = await getImage();
          if (url != null) {
            Navigator.of(context).pushNamed('camera', arguments: {
              'image': image,
              'url': url,
            });
          }
        });
  }
}

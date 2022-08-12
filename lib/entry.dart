import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  final Map arg;
  Entry({required this.arg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Flexible(
              child: Row(
            children: [Text(arg['date'])],
          )),
          Flexible(
              child: Row(
            children: [
              Image.network(arg['url']),
            ],
          )),
          Flexible(
              child: Row(
            children: [Text(arg['quantity'])],
          )),
          Flexible(
              child: Row(
            children: [Text(arg['lat'])],
          )),
          Flexible(
              child: Row(
            children: [Text(arg['lon'])],
          )),
        ],
      )),
    );
  }
}

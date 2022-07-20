import 'package:flutter/material.dart';

class CircularGraphModel {
  final String type;
  final int value;
  final Color color;
  CircularGraphModel({required this.type, required this.value, required this.color});
}

late List<CircularGraphModel> circularGraphData;

getCircularGraphData({required int published, required int unPublished}){
  circularGraphData = [
    CircularGraphModel(type: 'Published', value: published, color:  Color(0xFF7367f0)),
    CircularGraphModel(type: 'Unpublishded', value:  unPublished, color: Color(0xFFfa742b)),
  ];
}

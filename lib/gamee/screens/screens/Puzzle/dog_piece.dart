import 'package:flutter/material.dart';

class Piece {
  Piece({
    required this.index,
    required this.size,
    required this.path,
    required this.correctX,
    required this.correctY,
    required this.x,
    required this.y,
    required this.rotationDeg,
  });

  final int index;
  final Size size;
  final String path;

  final double correctX;
  final double correctY;

  double x;
  double y;
  int rotationDeg;
}
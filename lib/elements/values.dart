import 'package:flutter/material.dart';

int rowLength = 10;
int coloumLength = 15;

enum Direction { left, right, down }

enum Tetromino { I, J, L, O, S, T, Z }

Map<Tetromino, Color> tetromino_colors = {
  Tetromino.I: const Color.fromRGBO(186, 118, 117, 1),
  Tetromino.J: const Color.fromRGBO(25, 124, 189, 1),
  Tetromino.L: const Color.fromRGBO(249, 215, 64, 1),
  Tetromino.O: const Color.fromRGBO(157, 215, 235, 1),
  Tetromino.S: const Color.fromRGBO(218, 55, 72, 1),
  Tetromino.T: const Color.fromRGBO(230, 128, 79, 1),
  Tetromino.Z: const Color.fromRGBO(158, 198, 84, 1),
};

import 'package:tetris/elements/gameboard.dart';
import 'package:tetris/elements/values.dart';
import 'package:flutter/material.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  Color get color {
    return tetromino_colors[type] ?? Colors.black;
  }

  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool positionOfPieceValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }
      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }

//The argument type 'int' can't be assigned to the parameter type 'List<int>?
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];

        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];

        break;

      case Tetromino.I:
        position = [-4, -5, -6, -7];

        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];

        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];

        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];

        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];

        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  int rotate = 1;
  void rotatePiece() {
    List<int> newPosition = [];
    switch (type) {
      case Tetromino.L:
        switch (rotate) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotate) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
        }

        break;

      case Tetromino.I:
        switch (rotate) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
        }

        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];

        break;
      case Tetromino.S:
        switch (rotate) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
        }

        break;
      case Tetromino.T:
        switch (rotate) {
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotate) {
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            if (positionOfPieceValid(newPosition)) {
              position = newPosition;
              rotate = (rotate + 1) % 4;
            }
            break;
        }

        break;
      default:
    }
  }
}

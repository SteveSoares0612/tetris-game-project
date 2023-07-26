import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetris/elements/piece.dart';
import 'package:tetris/elements/pixel.dart';
import 'package:tetris/elements/values.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  coloumLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.I);
  int currentScore = 0;
  bool gameOver = false;
  bool isStart = false;
  Duration frames = const Duration(milliseconds: 0);

  void startGame() {
    print("object");
    isStart = true;
    currentPiece.initializePiece();
    frames = const Duration(milliseconds: 400);
    gameLoop(frames);
  }

  void gameLoop(Duration frames) {
    Timer.periodic(frames, (timer) {
      setState(() {
        clearLines();
        checkLanding();

        if (gameOver == true) {
          timer.cancel();
          isStart = false;
          showGameOver();
        }
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  void showGameOver() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Your Score is $currentScore"),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard = List.generate(
      coloumLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );
    gameOver = false;
    isStart = true;
    currentScore = 0;
    createNewPiece();
    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= coloumLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down) || checkPieceLanded()) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  bool checkPieceLanded() {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // check if the cell below is already occupied
      if (row + 1 < coloumLength &&
          row >= 0 &&
          gameBoard[row + 1][col] != null) {
        return true;
      }
    }

    return false;
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotate() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    for (int row = coloumLength - 1; row >= 0; row--) {
      bool rowFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowFull = false;
          break;
        }
      }
      if (rowFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 252, 242, 1),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     TextButton(
      //       onPressed: isStart == false ? startGame : () {},
      //       child: isStart == false ? const Text('Start') : const Text('Pause'),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * coloumLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  if (currentPiece.position.contains(index)) {
                    return BoardPixel(
                      color: currentPiece.color,
                      child: '',
                    );
                  } else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return BoardPixel(
                        color: tetromino_colors[tetrominoType], child: '');
                  } else {
                    return BoardPixel(
                      color: CupertinoColors.lightBackgroundGray,
                      child: '',
                    );
                  }
                  return null;
                }),
          ),
          Text(
            "Score: $currentScore",
            style: const TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
              onPressed: isStart == false ? startGame : () {},
              style: ElevatedButton.styleFrom(
                elevation: 1,
                // backgroundColor: const Color.fromRGBO(220, 26, 34, 1),
                backgroundColor: const Color.fromRGBO(252, 252, 242, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                side: const BorderSide(
                  width: 4,
                  color: Colors.black,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isStart == false
                        ? FontAwesomeIcons.play
                        : FontAwesomeIcons.pause,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    isStart == false ? 'Start' : 'Pause',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: moveLeft,
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: rotate,
                  icon: const Icon(
                    Icons.rotate_right,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: moveRight,
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

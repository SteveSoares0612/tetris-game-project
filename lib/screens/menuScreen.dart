import 'package:flutter/material.dart';

import '../elements/gameboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  bool musicOn = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: const Color.fromARGB(208, 220, 26, 32),
            color: Colors.white,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    // backgroundImage: AssetImage(
                    //   "assets/images/TicTacLogo.png",
                    // ),
                    child: Image.asset(
                      "assets/images/Tetris menu.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const GameBoard(),
                          ),
                        );
                      },
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.diceD6,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Play",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

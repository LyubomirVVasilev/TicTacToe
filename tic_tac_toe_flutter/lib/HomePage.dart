import 'package:flutter/material.dart';
import 'Board.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage edit = AssetImage("images/edit.png");
  Board board = Board();

  @override
  void initState() {
    super.initState();
    setState(() {
      board.resetGame();
    });
  }

  AssetImage getImage(String value) {
    switch (value) {
      case (Board.emptyState):
        return edit;
        break;
      case (Board.crossState):
        return cross;
        break;
      case (Board.circleState):
        return circle;
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
             Expanded(
             child: Opacity(
                opacity: board.hasGameFinished ? 0.3 : 1.0,
              child: GridView.builder(
                padding: EdgeInsets.all(15.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0),
                itemCount: board.boardState.length,
                itemBuilder: (context, i) => GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 1.0)),
                    child: Center(
                      child: MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            board.makeAMoveAt(i);
                          });
                        },
                        child: Image(
                          image: this.getImage(board.boardState[i]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Text(
              board.currentPlayerMessage,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              board.gameResultMessage,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: MaterialButton(
              color: Colors.blueGrey,
              minWidth: 300.0,
              height: 50.0,
              child: Text(
                "Reset Game",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  board.resetGame();
                });
              },
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

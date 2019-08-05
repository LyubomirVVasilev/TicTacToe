import 'package:flutter/material.dart';
import 'Board.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static AssetImage cross = AssetImage("images/cross.png");
  static AssetImage circle = AssetImage("images/circle.png");
  static AssetImage edit = AssetImage("images/edit.png");

  Board board = Board();
  bool hasPlayerSelectedIcon = false;

  //MARK: Layout constants
  static const double _sidePadding = 30;
  static const _homePageStandartInset =
      EdgeInsets.fromLTRB(_sidePadding, 5, _sidePadding, 5);

  @override
  void initState() {
    super.initState();
    setState(() {
      board.resetGame();
    });
  }

  //MARK: Selection of who plays first helper
  Column _buildButtonColumn(Color color, AssetImage icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: MaterialButton(
            onPressed: () {
              if (label == Board.crossState) {
                this.board.isCross = true;
              } else {
                this.board.isCross = false;
              }
              setState(() {
                this.hasPlayerSelectedIcon = true;
                this.board.resolveCurrentPlayerText();
              });
            },
            child: Image(
              height: 20,
              width: 20,
              image: icon,
            ),
          ),
        ),
      ],
    );
  }

  AssetImage _getImageFor(String value) {
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

  double _getBoardsOpacity() {
    if (!hasPlayerSelectedIcon) {
      return 0;
    } else
      return board.hasGameFinished ? 0.3 : 1.0;
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
              opacity: _getBoardsOpacity(),
              child: GridView.builder(
                padding: EdgeInsets.all(_sidePadding),
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
                          image: this._getImageFor(board.boardState[i]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: _homePageStandartInset,
            child: Text(
              board.gameStatusMessage,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: _homePageStandartInset,
            child: Opacity(
              opacity: hasPlayerSelectedIcon ? 0.0 : 1.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 1.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 1),
                      child: Text(
                        "Pick who plays first:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    _buildButtonColumn(
                        Colors.blueAccent, cross, Board.crossState),
                    _buildButtonColumn(
                        Colors.blueAccent, circle, Board.circleState),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(_sidePadding, 20, _sidePadding, _sidePadding),
            child: MaterialButton(
              color: Colors.blueGrey,
              minWidth: double.maxFinite,
              height: 40.0,
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
                  hasPlayerSelectedIcon = false;
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

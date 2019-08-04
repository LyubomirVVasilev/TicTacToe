class Board {
  bool isCross = true;
  String gameStatusMessage;
  bool hasGameFinished = false;

  List<String> boardState;

  static const String emptyState = "Empty";
  static const String crossState = "Cross";
  static const String circleState = "Circle";

  makeAMoveAt(int index) {
    if (this.boardState[index] == emptyState) {
      this.isCross ? this.boardState[index] = crossState :  this.boardState[index] = circleState;
      this.isCross = !this.isCross;
      this.evaluateBoard();
    }
  }

  resolveCurrentPlayerText() {
    this.isCross ? gameStatusMessage = "Cross's player turn" :  gameStatusMessage = "Circle's player turn";
  }

  resetGame() {
    this.boardState = [
      emptyState,
      emptyState,
      emptyState,
      emptyState,
      emptyState,
      emptyState,
      emptyState,
      emptyState,
      emptyState,
    ];
    this.hasGameFinished = false;
    this.gameStatusMessage = "";
  }

  static const _winConditionsList = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  bool isBoardFull() {
    for (var val in boardState) {
      if (val == emptyState) return false;
    }
    return true;
  }

  /// Returns the current state of the board [winning player, draw or no winners yet(empty)]
  String evaluateBoard() {
    for (var list in _winConditionsList) {
      if (boardState[list[0]] != emptyState && // if a player has played here AND
          boardState[list[0]] ==  boardState[ list[1]] && // if all three positions are of the same player
          boardState[list[0]] == boardState[list[2]]) {
        this.gameStatusMessage = '${boardState[list[0]]} wins';
        hasGameFinished = true;
        return boardState[list[0]];
      } else {
        if (isBoardFull()) {
          this.gameStatusMessage = 'The Game is Draw';
          hasGameFinished = true;
        } else {
          this.resolveCurrentPlayerText();
        }
      }
    }
    return emptyState;
  }
}

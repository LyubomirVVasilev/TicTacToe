class Board {
  bool isCross = true;
  String gameResultMessage;
  String currentPlayerMessage;
  bool hasGameFinished = false;

  List<String> boardState;

  static const String emptyState = "empty";
  static const String crossState = "cross";
  static const String circleState = "circle";

  makeAMoveAt(int index) {
    if (this.boardState[index] == emptyState) {
      if (this.isCross) {
        this.boardState[index] = crossState;
      } else {
        this.boardState[index] = circleState;
      }
      this.isCross = !this.isCross;
      this.evaluateBoard();
      this.resolveCurrentPlayerText();
    }
  }

  resolveCurrentPlayerText() {
    if (hasGameFinished) {
      currentPlayerMessage = "";
      return;
    }
    if (this.isCross) {
      currentPlayerMessage = "Cross's player turn";
    } else {
      currentPlayerMessage = "Circle's player turn";
    }
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
    this.gameResultMessage = "";
    currentPlayerMessage = "";
  }

  static const _WIN_CONDITIONS_LIST = [
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

  /// Returns the current state of the board [winning player, draw or no winners yet]
  String evaluateBoard() {
    for (var list in _WIN_CONDITIONS_LIST) {
      if (boardState[list[0]] !=
              emptyState && // if a player has played here AND
          boardState[list[0]] ==
              boardState[
                  list[1]] && // if all three positions are of the same player
          boardState[list[0]] == boardState[list[2]]) {
        this.gameResultMessage = '${boardState[list[0]]} wins';
        hasGameFinished = true;
        return boardState[list[0]];
      } else {
        if (isBoardFull()) {
          this.gameResultMessage = 'The Game is Draw';
          hasGameFinished = true;
        }
      }
    }
    return emptyState;
  }
}

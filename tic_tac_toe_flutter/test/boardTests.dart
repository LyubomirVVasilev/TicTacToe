// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:tic_tac_toe_flutter/Board.dart';

void main() {
  test('Displaying Cross player turn correctly', () {
    Board board = Board();
    board.isCross = true;
    board.resolveCurrentPlayerText();
    expect(board.gameStatusMessage, Board.crossPlayerTurnText);
  });

  test('Displaying Circle player turn correctly', () {
    Board board = Board();
    board.isCross = false;
    board.resolveCurrentPlayerText();
    expect(board.gameStatusMessage, Board.circlePlayerTurnText);
  });

  test('Switching turns; Cross to Circle', () {
    Board board = Board();
    board.resetGame();
    board.isCross = true;
    board.makeAMoveAt(1);
    board.resolveCurrentPlayerText();
    expect(board.gameStatusMessage, Board.circlePlayerTurnText);
  });

  test('Endgame state - Cross wins, Winning combination [2, 4, 6]', () {
    Board board = Board();
    board.resetGame();
    board.isCross = true;
    board.makeAMoveAt(0);
    board.makeAMoveAt(1);
    board.makeAMoveAt(2);
    board.makeAMoveAt(3);
    board.makeAMoveAt(4);
    board.makeAMoveAt(5);
    board.makeAMoveAt(6);
    bool crossWins = board.gameStatusMessage.contains(board.boardState[0]);
    expect(crossWins, true);
  });

  test('Endgame state - Circle wins, Winning combination [0, 3, 6]', () {
    Board board = Board();
    board.resetGame();
    board.isCross = false;
    board.makeAMoveAt(0);
    board.makeAMoveAt(1);
    board.makeAMoveAt(3);
    board.makeAMoveAt(4);
    board.makeAMoveAt(6);
    bool circleWins = board.gameStatusMessage.contains(board.boardState[0]);
    expect(circleWins, true);
  });

  test('Endgame state - Draw', () {
    Board board = Board();
    board.resetGame();
    board.isCross = false;
    board.makeAMoveAt(0);
    board.makeAMoveAt(3);
    board.makeAMoveAt(6);
    board.makeAMoveAt(7);
    board.makeAMoveAt(8);
    board.makeAMoveAt(2);
    board.makeAMoveAt(1);
    board.makeAMoveAt(4);
    board.makeAMoveAt(5);

    bool isDraw = board.gameStatusMessage.contains(Board.gameResultDrawText);
    expect(isDraw, true);
  });


  test('is board full', () {
    Board board = Board();
    board.resetGame();
    board.isCross = true;
    board.makeAMoveAt(0);
    board.makeAMoveAt(1);
    board.makeAMoveAt(2);
    board.makeAMoveAt(3);
    board.makeAMoveAt(4);
    board.makeAMoveAt(5);
    board.makeAMoveAt(6);
    board.makeAMoveAt(7);
    board.makeAMoveAt(8);
    expect(board.isBoardFull(), true);
  });
}

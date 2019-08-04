# TicTacToe

This application implements a basic Tic Tac Toe game in Flutter, where:
* The board is a 3x3 game board.
* Implements logic for allowing the players to play a turn, one at a time.
* for the first move, a player must choose whether to play with Cross or a Circle.
* indicate when one of the players has won, or the game is a draw.

 
# Implementation details:
The first consideration for the interaction design was drag and drop, but due to time limitations and the fact that it is not optimal in terms of UX(since unlike chess items don't change position once set on the board) I used a click on the board as a means of taking a turn.
Components: 
HomePage - a stateful widget holding the UI.
Board - a UI independent class encapsulating the game/business logic. 
BoardTests - Tests focused on business logic using the "Test" flutter framework. 

%Modified Game list Information
%Game = [boardGame,HeightBoard,NumPiecesBoard, Winner value, starPlayer, gameMode, num of flat pieces, num of holed pieces, num of double level reversible pieces]
%Game = [Board, HeightBoard, NumPicesBoard, noWinner, firstPlayer, hvh, 8, 8, 8]


%board procedures -------------------------------
get_board([Board|_],Board).

set_board(Board,Game,ModifiedGame):-
        set_list_element(0,Board,Game,ModifiedGame).
%board procedures -------------------------------


%Game Mode Procedures----------------------------
human_vs_human(Game):-
        %unifies inicial_board with Board
        inicial_board(PieceBoard),
        
        %unifies inicial_heignt board with HeightBoard
        inicial_height(HeightBoard),
        
        %unifies inicial_number_pieces with NumPiecesBoard
        inicial_number_pieces(NumPiecesBoard),
        
        Game = [PieceBoard, HeightBoard, NumPiecesBoard, noWinner, firstPlayer, hvh,8 ,8, 8].

human_vs_computer(Game):-
        %unifies inicial_board with Board
        inicial_board(PieceBoard),
        
        %unifies inicial_heignt board with HeightBoard
        inicial_height(HeightBoard),
        
        %unifies inicial_number_pieces with NumPiecesBoard
        inicial_number_pieces(NumPiecesBoard),
        
        Game = [PieceBoard, HeightBoard, NumPiecesBoard, noWinner, firstPlayer, hvc,8 ,8, 8].

computer_vs_computer(Game):-
        %unifies inicial_board with Board
        inicial_board(PieceBoard),
        
        %unifies inicial_heignt board with HeightBoard
        inicial_height(HeightBoard),
        
        %unifies inicial_number_pieces with NumPiecesBoard
        inicial_number_pieces(NumPiecesBoard),
        
        Game = [PieceBoard, HeightBoard, NumPiecesBoard, noWinner, firstPlayer, cvc,8 ,8, 8].

%get the game mode
get_game_mode(Game,Mode):-
        get_list_element(3,Game,Mode).
%Game Mode Procedures----------------------------

%Winner Procedures----------------------------
get_winner_value(Game,WinnerValue):-
        get_list_element(3,Game,WinnerValue).

set_winner_value(Game,WinnerValue,ModifiedGame):-
        set_list_element(3,WinnerValue,Game,ModifiedGame).
%Winner Procedures----------------------------
  
%Player Procedures ------------------------------
%gets what player turn
get_player_turn(Game,Player):-
        get_list_element(4,Game,Player).

%sets the player turn
set_player_turn(Player,Game,ModifiedPlayerGame):-
        set_list_element(4,Player,Game,ModifiedPlayerGame).

%change the players turn
change_player_turn(Temporary_Game,Modified_Game):-
        get_player_turn(Temporary_Game,Old_Turn),
        Old_Turn == firstPlayer,
        NewPlayer = secondPlayer,
        set_player_turn(NewPlayer,Temporary_Game,Modified_Game).

change_player_turn(Temporary_Game,Modified_Game):-
        get_player_turn(Temporary_Game,Old_Turn),
        Old_Turn == secondPlayer,
        NewPlayer = firstPlayer,
        set_player_turn(NewPlayer,Temporary_Game,Modified_Game).

%decrement the piece played from the pieces available
decrement_piece_number(Game,PieceType,ModifiedGame):-
        PieceType == 'f',
        get_list_element(6,Game,NumPieces),
        NumPieces > 0,
        NumPieces1 is NumPieces - 1,
        set_list_element(6,NumPieces1,Game,ModifiedGame).

decrement_piece_number(Game,PieceType,ModifiedGame):-
        PieceType == 'h',
        get_list_element(7,Game,NumPieces),
        NumPieces > 0,
        NumPieces1 is NumPieces - 1,
        set_list_element(7,NumPieces1,Game,ModifiedGame).

decrement_piece_number(Game,PieceType,ModifiedGame):-
        PieceType == 'df',
        get_list_element(8,Game,NumPieces),
        NumPieces > 0,
        NumPieces1 is NumPieces - 1,
        set_list_element(8,NumPieces1,Game,ModifiedGame).       

decrement_piece_number(Game,PieceType,ModifiedGame):-        
        PieceType == 'dh',
        get_list_element(8,Game,NumPieces),
        NumPieces > 0,
        NumPieces1 is NumPieces - 1,
        set_list_element(6,NumPieces1,Game,ModifiedGame).
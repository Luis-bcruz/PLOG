%makes a move - this rule is in case the game has a winning condition
make_move(SrcRow,SrcCol,NewPiece,Game,ModifiedPlayerGame):-
        %get the PieceBoard
        get_list_element(0,Game,PieceBoard),
        %get the HeightBoard
        get_list_element(1,Game,HeightBoard),
        %get the NumPiecesBoard
        get_list_element(2,Game,NumPiecesBoard),

        %validate the piece placement
        validate_move(SrcRow, SrcCol, NewPiece, PieceBoard, NumPiecesBoard),

        %place the piece on the board
        move_piece(SrcRow, SrcCol ,NewPiece, PieceBoard, HeightBoard, NumPiecesBoard, ModifiedPieceBoard, ModifiedHeightBoard, ModifiedNumPiecesBoard),

        %decrement the new piece from the pieces available
        decrement_piece_number(Game, NewPiece, TempModifiedGame),

        %update the Piece Board on the Game
        set_list_element(0, ModifiedPieceBoard, TempModifiedGame, ModifiedGameWithPieces),
        %update the Height Board on the Game
        set_list_element(1, ModifiedHeightBoard, ModifiedGameWithPieces, ModifiedGameWithHeight),
        %update the NumPieces Board on the Game
        set_list_element(2, ModifiedNumPiecesBoard, ModifiedGameWithHeight, ModifiedGame),

        %determin if there is a winning condition on this turn
        %if it fails continue playing
        determine_winner(0,0,ModifiedHeightBoard,ModifiedPieceBoard,ModifiedGame,ModifiedWinnerGame),

        %change the player
        change_player_turn(ModifiedWinnerGame,ModifiedPlayerGame).

%makes a move - this rule is in case the game does not have a winning condition
make_move(SrcRow,SrcCol,NewPiece,Game,ModifiedPlayerGame):-
        %get the PieceBoard
        get_list_element(0,Game,PieceBoard),
        %get the HeightBoard
        get_list_element(1,Game,HeightBoard),
        %get the NumPiecesBoard
        get_list_element(2,Game,NumPiecesBoard),

        %validate the piece placement
        validate_move(SrcRow, SrcCol, NewPiece, PieceBoard, NumPiecesBoard),

        %place the piece on the board
        move_piece(SrcRow, SrcCol ,NewPiece, PieceBoard, HeightBoard, NumPiecesBoard, ModifiedPieceBoard, ModifiedHeightBoard, ModifiedNumPiecesBoard),

        %decrement the new piece from the pieces available
        decrement_piece_number(Game, NewPiece, TempModifiedGame),

        %update the Piece Board on the Game
        set_list_element(0, ModifiedPieceBoard, TempModifiedGame, ModifiedGameWithPieces),
        %update the Height Board on the Game
        set_list_element(1, ModifiedHeightBoard, ModifiedGameWithPieces, ModifiedGameWithHeight),
        %update the NumPieces Board on the Game
        set_list_element(2, ModifiedNumPiecesBoard, ModifiedGameWithHeight, ModifiedGame),

        %change the player
        change_player_turn(ModifiedGame,ModifiedPlayerGame).


%places the piece on the board
move_piece(SrcRow,SrcCol,NewPiece,PiecesBoard,HeightBoard,NumPiecesBoard,ModifiedPieceBoard,ModifiedHeightBoard,ModifiedNumPiecesBoard):-
        %get the height from the new piece to be placed on board
        get_cell_symbol(NewPiece,Symbol),
        get_piece_height(Symbol,NewPieceHeight),

        %get the height from the Source cell
        get_matrix_element(SrcRow,SrcCol,HeightBoard,SrcHeight),
        SrcHeight1 is SrcHeight + NewPieceHeight,

        %get the number of pieces in that cell
        get_matrix_element(SrcRow,SrcCol,NumPiecesBoard,SrcNumPieces),
        SrcNumPieces1 is SrcNumPieces + 1,

        %update the pieces board with the new top piece
        set_matrix_element(SrcRow,SrcCol,NewPiece,PiecesBoard,ModifiedPieceBoard),

        %update the height board after placing the new piece
        set_matrix_element(SrcRow,SrcCol,SrcHeight1,HeightBoard,ModifiedHeightBoard),

        %update the numPieces board after placing the new piece
        set_matrix_element(SrcRow,SrcCol,SrcNumPieces1,NumPiecesBoard,ModifiedNumPiecesBoard).


%validate the piece placement acconding to restrictions
validate_move(SrcRow,SrcCol,NewPiece,PiecesBoard,NumPiecesBoard):-
        validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard),
        validate_number_pieces(SrcRow,SrcCol,NumPiecesBoard).

%Restriction1-
%It is not permited to place single level pieces on top of two level pieces
validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'f',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece \= 'df',
        SrcPiece \= 'dh'.

validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'f',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece == 'df',
        write('Invalid move! Cant place single-level on top of double-level. '),nl,
        fail.

validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'f',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece == 'dh',
        write('Invalid move! Cant place single-level on top of double-level. '),nl,
        fail.

validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'h',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece \= 'df',
        SrcPiece \= 'dh'.

validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'h',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece == 'df',
        write('Invalid move! Cant place single-level on top of double-level. '),nl,
        fail.

validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'h',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece == 'dh',
        write('Invalid move! Cant place single-level on top of double-level. '),nl,
        fail.

validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'df',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece \= 'df',
        SrcPiece \= 'dh'.

validate_hight(SrcRow,SrcCol,NewPiece,PiecesBoard):-
        %check if the piece is double level
        NewPiece == 'dh',

        %the the type of piece on the cell
        get_matrix_element(SrcRow,SrcCol,PiecesBoard,SrcPiece),!,

        SrcPiece \= 'df',
        SrcPiece \= 'dh'.


%Restricton2-
%No board cell should have more than two pieces.
validate_number_pieces(SrcRow,SrcCol,NumPieceBoard):-
        %get the number of pieces of the board cell
        get_matrix_element(SrcRow,SrcCol,NumPieceBoard,SrcNumPieces),!,
        SrcNumPieces < 2.

validate_number_pieces(_,_,_):-
        write('Invalid move! Cant place more pieces there. '),nl,
        fail.

%determine if there is a draw
determine_draw(Game):-
        \+determine_draw_Flat(Game),
        \+determine_draw_Holed(Game),
        \+determine_draw_doubleLevel(Game),
        display_game_draw,
        !.

determine_draw_Flat(Game):-
        get_list_element(6,Game,NumFlatPieces),!,
        NumFlatPieces \= 0.

determine_draw_Holed(Game):-
        get_list_element(7,Game,NumHoledPieces),!,
        NumHoledPieces \= 0.

determine_draw_doubleLevel(Game):-
        get_list_element(8,Game,NumDoubleLevelPieces),!,
        NumDoubleLevelPieces \= 0.

%determine the winner
determine_winner(Row,Col,HeightBoard,_,Game,ModifiedGame):-
        \+ three_step_stair(Row,Col,HeightBoard),
        write('There is a three step stair!'),nl,
        display_game_won(Game,ModifiedGame),
        !.

determine_winner(Row,Col,HeightBoard,_,Game,ModifiedGame):-
        four_in_a_row(Row,Col,HeightBoard),
        write('There is a four in a row of the same height!'),nl,
        display_game_won(Game,ModifiedGame),
        !.

determine_winner(Row,Col,_,ModifiedPieceBoard,Game,ModifiedGame):-
        four_in_a_row_diagonal(Row,Col,ModifiedPieceBoard),
        write('There is a diagonal four in a row with the same piece type!'),nl,
        display_game_won(Game,ModifiedGame),
        !.



%winning conditions -------------------------------------------------------------
three_step_stair(3,2,_):-
        true.

three_step_stair(Row,Col,HeightBoard):-
       Col =< 1,
       Row \= 3,
       findall(Value, matrix(HeightBoard,Row,_,Value),ResultantHeightRow),
       findall(Value, matrix(HeightBoard,_,Col,Value),ResultantHeightCol),

       %If there is not a horizontal or vertical stair, continue to other values
       \+ check_horizontal_tree_step(Row,Col,ResultantHeightRow),
       \+ check_vertical_tree_step(Row,Col,ResultantHeightCol),
       \+ check_horizontal_reverse_tree_step(Row,Col,ResultantHeightRow),
       \+ check_vertical_reverse_tree_step(Row,Col,ResultantHeightCol),

       Col1 is Col + 1,
       three_step_stair(Row,Col1,HeightBoard).

three_step_stair(Row,Col,HeightBoard):-
       Col = 2,
       Row < 2,

       findall(Value, matrix(HeightBoard,_,Col,Value),ResultantHeightCol),
       \+ check_vertical_tree_step(Row,Col,ResultantHeightCol),
       \+ check_vertical_reverse_tree_step(Row,Col,ResultantHeightCol),
       Col1 is Col + 1,
       three_step_stair(Row,Col1,HeightBoard).

three_step_stair(Row,Col,HeightBoard):-
       Row == 2,
       Col < 2,
       findall(Value, matrix(HeightBoard,Row,_,Value),ResultantHeightRow),

       \+ check_horizontal_tree_step(Row,Col,ResultantHeightRow),
       \+ check_horizontal_reverse_tree_step(Row,Col,ResultantHeightRow),
       Col1 is Col + 1,
       three_step_stair(Row,Col1,HeightBoard).

three_step_stair(Row,Col,HeightBoard):-
       Col == 3 ,

       findall(Value, matrix(HeightBoard,_,Col,Value),ResultantHeightCol),

       \+ check_vertical_tree_step(Row,Col,ResultantHeightCol),
       \+ check_vertical_reverse_tree_step(Row,Col,ResultantHeightCol),

       Row1 is Row + 1,!,
       three_step_stair(Row1,0,HeightBoard).

three_step_stair(Row,Col,HeightBoard):-
       Row == 2,
       Col == 2,
       Row1 is Row + 1,
       three_step_stair(Row1,0,HeightBoard).

three_step_stair(Row,Col,HeightBoard):-
       Row == 3,
       findall(Value, matrix(HeightBoard,Row,_,Value),ResultantHeightRow),

       \+ check_horizontal_tree_step(Row,Col,ResultantHeightRow),
       \+ check_horizontal_reverse_tree_step(Row,Col,ResultantHeightRow),

       Col1 is Col + 1,
       three_step_stair(Row,Col1,HeightBoard).

%check if, in a list that represents a row of the board, there is a horizontal three step stair
check_horizontal_reverse_tree_step(_,Col,ResultantHeightRow):-
      %get the fist element of the row
      get_list_element(Col,ResultantHeightRow,RowHeightValue1),!,
      RowHeightValue1 == 3,
      %get the secound element of the row
      Col1 is Col + 1,
      get_list_element(Col1,ResultantHeightRow,RowHeightValue2),!,
      RowHeightValue2 == 2,
      %get the third element of the row
      Col2 is Col1 + 1,
      get_list_element(Col2,ResultantHeightRow,RowHeightValue3),!,
      RowHeightValue3 == 1.

%check if, in a list that represents a row of the board, there is a vertical three step stair
check_vertical_reverse_tree_step(Row,_,ResultantHeightCol):-
        %get the first element of the col
        get_list_element(Row,ResultantHeightCol,ColHeightValue1),!,
        ColHeightValue1 == 3,
        %get the secound element of the column
        Row1 is Row + 1,
        get_list_element(Row1,ResultantHeightCol,ColHeightValue2),!,
        ColHeightValue2 == 2,
        %get the third element of the column
        Row2 is Row1 + 1,
        get_list_element(Row2,ResultantHeightCol,ColHeightValue3),!,
        ColHeightValue3 == 1.

%check if, in a list that represents a row of the board, there is a horizontal three step stair
check_horizontal_tree_step(_,Col,ResultantHeightRow):-
      %get the fist element of the row
      get_list_element(Col,ResultantHeightRow,RowHeightValue1),!,
      RowHeightValue1 == 1,
      %get the secound element of the row
      Col1 is Col + 1,
      get_list_element(Col1,ResultantHeightRow,RowHeightValue2),!,
      RowHeightValue2 == 2,
      %get the third element of the row
      Col2 is Col1 + 1,
      get_list_element(Col2,ResultantHeightRow,RowHeightValue3),!,
      RowHeightValue3 == 3.


%check if, in a list that represents a column of the board, there is a vertical three step stair
check_vertical_tree_step(Row,_,ResultantHeightCol):-
        %get the first element of the col
        get_list_element(Row,ResultantHeightCol,ColHeightValue1),!,
        ColHeightValue1 == 1,
        %get the secound element of the column
        Row1 is Row + 1,
        get_list_element(Row1,ResultantHeightCol,ColHeightValue2),!,
        ColHeightValue2 == 2,
        %get the third element of the column
        Row2 is Row1 + 1,
        get_list_element(Row2,ResultantHeightCol,ColHeightValue3),!,
        ColHeightValue3 == 3.


%goes through the board diagonals and check for a four-in-a-row of the same piece type
four_in_a_row_diagonal(_,_,Board):-
        four_in_a_row_descendent_diagonal(0,0,Board).

four_in_a_row_diagonal(_,_,Board):-
        four_in_a_row_ascendant_diagonal(3,0,Board).

four_in_a_row_descendent_diagonal(3,3,_).

four_in_a_row_descendent_diagonal(Row,Col,PiecesBoard):-
        findall(Value, matrix(PiecesBoard,Row,Col,Value),DiagonalPiece1),

        get_list_element(0,DiagonalPiece1,Piece1),
        get_piece_symbol(Piece1,Symbol1),
        Piece1 \= empty,

        Row1 is Row + 1,
        Col1 is Col + 1,

        findall(Value, matrix(PiecesBoard,Row1,Col1,Value),DiagonalPiece2),

        get_list_element(0,DiagonalPiece2,Piece2),
        get_piece_symbol(Piece2,Symbol2),

        Symbol1 == Symbol2,

        four_in_a_row_descendent_diagonal(Row1,Col1,PiecesBoard).

four_in_a_row_ascendant_diagonal(0,3,_).

four_in_a_row_ascendant_diagonal(Row,Col,PiecesBoard):-
        findall(Value, matrix(PiecesBoard,Row,Col,Value),DiagonalPiece1),

        get_list_element(0,DiagonalPiece1,Piece1),
        get_piece_symbol(Piece1,Symbol1),
        Piece1 \= empty,

        Row1 is Row - 1,
        Col1 is Col + 1,

        findall(Value, matrix(PiecesBoard,Row1,Col1,Value),DiagonalPiece2),

        get_list_element(0,DiagonalPiece2,Piece2),
        get_piece_symbol(Piece2,Symbol2),

        Symbol1 == Symbol2,

        four_in_a_row_ascendant_diagonal(Row1,Col1,PiecesBoard).

%check if where is a vertical or horizontal four-in-a-row
four_in_a_row(Row,_,HeightBoard):-
        %if it failed that means that there is a horizontal four in a row
        \+ four_in_a_row_horizontal(Row,HeightBoard).

four_in_a_row(_,Col,HeightBoard):-
        %if it failed that means that there is a vertical four in a row
        \+ four_in_a_row_vertical(Col,HeightBoard).


%check if there is a horizontal four-in-a-row
%all peices must have the same height
four_in_a_row_horizontal(4,_):-
        true.

four_in_a_row_horizontal(Row,HeightBoard):-
        findall(Value, matrix(HeightBoard,Row,_,Value),ResultantHeightRow),

        %if he does not succeed then continue seaching
        \+ go_through_row(0,ResultantHeightRow),
        Row1 is Row + 1,
        Row1 =< 4,
        four_in_a_row_horizontal(Row1,HeightBoard).


%check if there is a vertical four-in-a-row
%%all peices must have the same height
four_in_a_row_vertical(4,_):-
        true.

four_in_a_row_vertical(Col,HeightBoard):-
        findall(Value, matrix(HeightBoard,_,Col,Value),ResultantHeightCol),

        %if he does not succeed then continue seaching
        \+ go_through_row(0,ResultantHeightCol),
        Col1 is Col + 1,
        Col1 =< 4,
        four_in_a_row_vertical(Col1,HeightBoard).


%goes through_the list representing a row or col
go_through_row(3,_).

go_through_row(Col,Row):-
        %get the fist element of the row
        get_list_element(Col,Row,ResultantHeightValue1),
        ResultantHeightValue1 > 0,
        Col1 is Col + 1,
        Col1 =< 3,
        %get the consecutive element of the row
        get_list_element(Col1,Row,ResultantHeightValue2),!,
        ResultantHeightValue2 > 0,
        % see if both have the same height
        ResultantHeightValue1 == ResultantHeightValue2,
        go_through_row(Col1,Row).

%makes a computer move
computer_play(Game,ModifiedGame):-
        repeat,
        get_board(Game,PieceBoard),
        display_megateh_board(0,Game,PieceBoard,4),
        display_turn_info(Game),nl,
        
        random(0,4,SrcRow),
        write('Random Row: '), write(SrcRow),nl,
        random(0,4,SrcCol),
        write('Random Col: '),write(SrcCol),nl,

        random_piece(NewPiece),
        write('NewPiece is: '),write(NewPiece),nl,

        make_move(SrcRow,SrcCol,NewPiece,Game,ModifiedGame),
        !.

random_piece(Piece):-
        random(0,3,Num),
        choosePiece(Num,Piece).

choosePiece(Num,f):-
        Num == 0.

choosePiece(Num,h):-
        Num == 1.

choosePiece(Num,df):-
        Num == 2.

choosePiece(Num,dh):-
        Num == 3.
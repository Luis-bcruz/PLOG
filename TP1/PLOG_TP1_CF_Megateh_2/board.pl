%symbols
symbol(f,'f ').
symbol(h,'h ').
symbol(df,'df').
symbol(dh,'dh').
symbol(empty,'  ').

%gets the cells symbols
get_cell_symbol(' ',empty).
get_cell_symbol('f',flat).
get_cell_symbol('h',holed).
get_cell_symbol('df',dF).
get_cell_symbol('dh',dH).

get_cell_display_symbol('  ',empty).
get_cell_display_symbol('f ',flat).
get_cell_display_symbol('h ',holed).
get_cell_display_symbol('df',dF).
get_cell_display_symbol('dh',dH).

get_piece_symbol(' ',empty).
get_piece_symbol('f',flat).
get_piece_symbol('h',holed).
get_piece_symbol('df',flat).
get_piece_symbol('dh',holed).

%gets the cells height
get_piece_height(empty,0).
get_piece_height(flat,1).
get_piece_height(holed,1).
get_piece_height(dF,2).
get_piece_height(dH,2).


matrix(Matrix,I,J,Value):-
        nth0(I,Matrix,Row),
        nth0(J,Row,Value).


%get the board cell
%decrements the row to get to the row we want
get_board_cell(0,Col,[HeadList|_],Symbol):-
        get_list_element(Col,HeadList,Symbol).

get_board_cell(Row,Col,[_|TailList], Symbol):-
        Row > 0,
        Row1 is Row - 1,
        get_board_cell(Row1,Col,TailList,Symbol).


%inicial board---------------------------------------
inicial_board([[empty,empty,empty,empty],
               [empty,empty,empty,empty],
               [empty,empty,empty,empty],
               [empty,empty,empty,empty]
              ]).


%inicial height list---------------------------------
inicial_height([[0,0,0,0],
                [0,0,0,0],
                [0,0,0,0],
                [0,0,0,0]
               ]).


%inicial number pieces list--------------------------
inicial_number_pieces([[0,0,0,0],
                       [0,0,0,0],
                       [0,0,0,0],
                       [0,0,0,0]
                      ]).

%display of board------------------------------------
display_megateh_board(4,_,[],_):-
        write('     '), write('  ---------------------------------------------'), nl, nl,
        write('     '), write('        A          B          C          D       '), nl.

display_megateh_board(Row,Game,[Head|Tail],R):-
        get_list_element(1,Game,HeightBoard),
        write('    '), write('   ---------------------------------------------'),nl,
        write('    '), display_empty_line([]),
        write('   '), write(R), display_line(Row,0,HeightBoard,Head), nl,
        write('    '), display_empty_line([]),
        Row1 is Row + 1,
        R1 is R - 1,
        display_megateh_board(Row1,Game,Tail,R1),!.



%display empty line---------------------------------
display_empty_line([]):-
        write('   '), write('|'),write('          '),
        write('|'), write('          '), write('|'),
        write('          '), write('|'),write('          '),
        write('|'), nl.



%display line---------------------------------------
display_line(_,4,_,[]) :-
        write('   |   ').

display_line(Row,Col,HeightBoard,[H|T]) :-
        findall(Value, matrix(HeightBoard,Row,Col,Value),Cell),
        symbol(H,S),
        get_list_element(0,Cell,CellHeight),
        CellHeight \= 0,
        write('   |    '),
        write(CellHeight),
        write(S),
        Col1 is Col + 1,
        display_line(Row,Col1,HeightBoard,T).

display_line(Row,Col,HeightBoard,[H|T]) :-
        findall(Value, matrix(HeightBoard,Row,Col,Value),Cell),
        symbol(H,S),
        get_list_element(0,Cell,_),
        write('   |    '),
        write(' '),
        write(S),
        Col1 is Col + 1,
        display_line(Row,Col1,HeightBoard,T).

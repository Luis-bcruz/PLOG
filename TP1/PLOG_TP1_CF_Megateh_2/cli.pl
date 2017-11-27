%the main menu
megateh_main_menu(Input):-
        Input == 1, 
        human_vs_human(Game), 
        game_loop(Game),!.

megateh_main_menu(Input):-
        Input == 2, 
        human_vs_computer(Game), 
        game_loop(Game),!.

megateh_main_menu(Input):-
        Input \= 3,
        write('Wrong number try again'),nl,fail.

megateh_main_menu(Input):-
        Input == 3,
        computer_vs_computer(Game), 
        game_loop(Game),!.

%prints the menu
print_menu:-
        write('        Megateh game'), nl, nl,
        write('  [1] Human vs. Human'), nl,
        write('  [2] Human vs. Computer'), nl,
        write('  [3] Computer vs. Computer'), nl, nl,
        write('Enter game mode number:'), nl.


%display the turns information
display_turn_info(Game):-
        get_player_turn(Game,Player),
        get_player_name(Player,PlayerName),
        
        get_list_element(6,Game,NumFlatPieces),
        get_list_element(7,Game,NumHoledPieces),
        get_list_element(8,Game,NumDoubleLevelPieces),

        nl,write(PlayerName),write(' turn to play! '),nl,
        write('Flat: '),write(NumFlatPieces),write('    '),
        write('Holed: '),write(NumHoledPieces),write('    '),
        write('2 Leveld: '),write(NumDoubleLevelPieces),
        nl.

%display the win information
display_game_won(Game,ModifiedGame):-
        get_player_turn(Game,Player),
        get_player_name(Player,PlayerName),
        set_winner_value(Game,winner,ModifiedGame),
        write(PlayerName),
        write(' Won!'),nl,true,!.

%display the draw information
display_game_draw:-
        write('No winning condition and no more pieces, its a DRAW! '),nl,true,
        !.

%get the type of piece from the player, to be placed on the board
get_new_type_piece(NewPiece):-
        write('Please enter the type of piece (ex: f, h df, dh) you wish to place: '),nl,
        read(NewPiece),
        get_return_key.
        

%get the Coordinates from the player in order to place a new piece on the board
get_new_piece_source_coordinartes(SrcRow,SrcCol):-
        write('Enter the column and row (ex:a1) of the piece to be placed followed by <CR>: '),nl,
        get_coordinates(SrcRow,SrcCol).


%get value of coordinates
get_coordinates(Row,Col):-
        get_integer(C),
        get_integer(R),
        get_return_key,
        Row is 4-R,
        Col is C-49.

%get the value of imput
get_integer(Input):-
        get_code(TempInput),
        Input is TempInput - 48.

%ignore a key
get_return_key:-
        get_code(_).
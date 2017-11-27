%includes
:- use_module(library(random)).
:- use_module(library(system)).
:-use_module(library(lists)).
:-use_module(library(det)).
:- include('board.pl').
:- include('cli.pl').
:- include('computer.pl').
:- include('game.pl').
:- include('logic.pl').
:- include('utils.pl').

%game
megateh:-
        initialize_random_seed,
        print_menu,
        repeat,
        read(Input),
        get_return_key,
        megateh_main_menu(Input),!.

%players
player(firstPlayer).
player(secondPlayer).

%get the players names
get_player_name(firstPlayer,'First Player').
get_player_name(secondPlayer,'Second Player').


%The main game loop for human_vs_human gameplay
game_loop(Game):-
      get_list_element(5,Game,Mode),
      Mode = hvh,
      
      get_winner_value(Game,WinnerValue),
      WinnerValue \= winner,
      
      \+ determine_draw(Game),
      
      human_play(Game,ModifiedGame),
      game_loop(ModifiedGame).

%The main game loop for human_vs_computer gameplay
game_loop(Game):-
      get_list_element(5,Game,Mode),
      Mode = hvc,
      
      get_winner_value(Game,WinnerValue),
      WinnerValue \= winner,
      
      \+ determine_draw(Game),
      
      get_player_turn(Game,Player),
      Player == firstPlayer,
      
      human_play(Game,ModifiedGame),
      
      game_loop(ModifiedGame).

game_loop(Game):-
      get_list_element(5,Game,Mode),
      Mode = hvc,
      
      get_winner_value(Game,WinnerValue),
      WinnerValue \= winner,
      
      \+ determine_draw(Game),
    
      get_player_turn(Game,Player),
      Player == secondPlayer,
      
      computer_play(Game,ModifiedGame),
      
      game_loop(ModifiedGame).

%The main game loop for computer_vs_computer gameplay
game_loop(Game):-
      get_list_element(5,Game,Mode),
      Mode = cvc,
      
      get_winner_value(Game,WinnerValue),
      WinnerValue \= winner,
      
      \+ determine_draw(Game),
      
      computer_play(Game,ModifiedGame),
      
      game_loop(ModifiedGame).

%The game loop end condition
game_loop(Game):-
      get_board(Game,PieceBoard),
      display_megateh_board(0,Game,PieceBoard,4),
      get_winner_value(Game,WinnerValue),
      WinnerValue == winner,
      true.

game_loop(Game):-
      get_board(Game,PieceBoard),
      display_megateh_board(0,Game,PieceBoard,4),
      \+ determine_draw(Game),
      true.

human_play(Game,ModifiedGame):-
        repeat,
        get_board(Game,PieceBoard),
        display_megateh_board(0,Game,PieceBoard,4),
        display_turn_info(Game),nl,
        get_new_piece_source_coordinartes(SrcRow,SrcCol),
        get_new_type_piece(NewPiece),
        make_move(SrcRow,SrcCol,NewPiece,Game,ModifiedGame),
        !.
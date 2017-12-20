:-use_module(library(system)).
:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).
:-use_module(library(aggregate)).
:-include('empresaTest.pl').

% variavel com tamanho igual ao numero de medidas, com dominio entre 0 e 1. 1 quer dizer que toma essa medida,
% a soma dos custos deve ser menor ou igual ao orcamento.
main(Medidas,Prioridades,Custos,Orcamento,Vars):-
       length(Medidas,L),
       length(Vars,L),
       domain(Vars,0,1),
       calcMelhorias(Medidas,Prioridades,Melhorias),
       write('Melhorias= '),write(Melhorias),nl,
       
      
       scalar_product(Melhorias,Vars,#=,Escolhas),
       scalar_product(Custos,Vars,#=,Total),
       
       Escolhas #> 0,
       Total #=< Orcamento,
       statistics(walltime,_),
       labeling(maximize(Escolhas),Vars),
       statistics(walltime, [_, ElapsedTime | _]),
       format('An answer has been found!~nElapsed time: ~3d seconds', ElapsedTime), nl,
       fd_statistics,
       write('Custos= '),write(Custos),nl,
       write('Escolhas= '),write(Escolhas),nl,
       write('Total= '),write(Total),nl.

calcMelhorias([],_,[]).
calcMelhorias([Medida | Resto],Prioridades,Melhorias):-
       calcMelhorias(Resto,Prioridades,NovaMelhoria),
       scalar_product(Medida,Prioridades,#=,Resultado),
       Melhorias = [Resultado | NovaMelhoria].



enume(Var,_,BB0,BB):-
       fd_set(Var,Set),
       select_best_value(Set,Value),
       (
          first_bound(BB0,BB), Var #= Value;
          later_bound(BB0,BB), Var #\= Value
       ).

select_best_value(Set,BestValue):-
        fdset_to_list(Set,Lista),
        length(Lista,Len),
        random(0,Len,RandomIndex),
        nth0(RandomIndex,Lista,BestValue).
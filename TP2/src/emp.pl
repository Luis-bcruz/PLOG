:-use_module(library(system)).
:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).
:-use_module(library(aggregate)).
:-include('empresaTest.pl').

% variavel com tamanho igual ao numero de medidas, com dominio entre 0 e 1. 1 quer dizer que toma essa medida,
% a soma dos custos deve ser menor ou igual ao orcamento.
main(Medidas,Prioridades,Custos,Orcamento):-
       length(Medidas,L),
       length(Vars,L),
       domain(Vars,0,1),
       
       calcMelhorias(Medidas,Prioridades,Melhorias),

       scalar_product(Melhorias,Vars,#=,Escolhas),
       scalar_product(Custos,Vars,#=,Total),
       
       Escolhas #> 0,
       Total #=< Orcamento,
       statistics(walltime,_),
       labeling(maximize(Escolhas),Vars),
       statistics(walltime, [_, ElapsedTime | _]),
       format('An answer has been found!~nElapsed time: ~3d seconds', ElapsedTime), nl,
       fd_statistics,nl,
       resultado(Vars,Medidas,Resultado),
       write('Vars = '),write(Vars),nl,
       write('Melhorias = '),write(Melhorias),nl,
       write('Custos = '),write(Custos),nl,
       write('Escolhas: '),nl,printResultado(Resultado,1),
       write('Melhoria Final = '),write(Escolhas),nl,
       write('Total = '),write(Total),nl.
      

printResultado([Medida | Resto],N):-
       write('Medida '),write(N),write(': '),write(Medida),nl,
       N1 is N+1,
       printResultado(Resto,N1).
printResultado([],_).

resultado([],[],[]).
resultado([Var | Vars],[Medida | Medidas],Resultado):-
       resultado(Vars,Medidas,NovoResultado),
       Var == 1,
       Resultado = [Medida | NovoResultado].

resultado([_ | Vars],[_ | Medidas],NovoResultado):-
       resultado(Vars,Medidas,NovoResultado).
       
calcMelhorias([],_,[]).
calcMelhorias([Medida | Resto],Prioridades,Melhorias):-
       calcMelhorias(Resto,Prioridades,NovaMelhoria),
       scalar_product(Medida,Prioridades,#=,Resultado),
       Melhorias = [Resultado | NovaMelhoria].
:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).

% Variaveis:
%   - Medidas: conjuntos de critérios
%   - Critérios: valores positivos ou negativos
%   - Prioridades: valores entre 0 1 cuja soma tem de ser  igual a 1
%   - Orçamento: valor positivo
estrategia:-
        write('Para correr, deve escrever:'),nl,
        write('estrategia(NumMedidas,NumCriterios)'),nl,
        write('NumMedidas - Numero de medidas'),nl,
        write('NumCriterios - Numero de criterios'),
        nl.

estrategia(NumMedidas,NumCriterios):-
        length(Criterios,5),
        length(Medidas,5),
        all_distinct(Criterios),
        all_distinct(Medidas),
        domain(Criterios, -10, 10),
        labeling([value(enume)],Criterios),
        divideCri(Criterios,DecimalCriterios),
        
        prioridades(NumCriterios,Prioridades),
        custos(NumMedidas,Custos),
        
        Orcamento = 1200,
        
        calc_Melhoria(Criterios,Prioridades,ListMelhoria),
        sumlist(ListMelhoria,Melhoria).

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
                           
divideCri([],[]).
divideCri([Criterio | Resto],Criterios):-
       divideCri(Resto,NovoCriterio),
       Decimal is Criterio / 10,
       Criterios = [Decimal | NovoCriterio].

custos(0,[]).
custos(M,Custos):-
        random(100,1200,RandCusto),
        M1 is M -1,
        Custos = [RandCusto | NovoRandCusto],
        custos(M1,NovoRandCusto).

prioridades(0,[]).
prioridades(N,Prioridades):-
        random(0.0,0.1,Rand),
        N1 is N - 1,
        Prioridades = [Rand | NovoRand],
        prioridades(N1,NovoRand).        

calc_Melhoria([],[],0).
calc_Melhoria([Cri | TailCriterios],[Prio | TailPrioridades],ListMelhoria):-
        calc_Melhoria(TailCriterios,TailPrioridades,NewMelhoria),
        Melhoria is Cri*Prio,
        ListMelhoria = [ Melhoria| NewMelhoria].
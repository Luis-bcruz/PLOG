:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).

estrategia:-
        write('Para correr, deve escrever:'),nl,
        write('estrategia(NumMedidas,NumCriterios)'),nl,
        write('NumMedidas - Numero de medidas'),nl,
        write('NumCriterios - Numero de criterios'),
        nl.

estrategia(NumMedidas,NumCriterios):-
        statistics(walltime,_),
        gerarMedidas(NumMedidas,NumCriterios,Medidas),
        gerarPrioridades(NumCriterios,Prioridades),
        gerarCustos(NumMedidas,Custos),
        Orcamento = 1200,
        calcMelhorias(Medidas,Prioridades,ListaMelhorias),
        write('Melhorias   = '),write(ListaMelhorias),nl,
        lista_max(ListaMelhorias, Melhoria),
        nth1(Index,ListaMelhorias,Melhoria),
        nth1(Index,Custos,Custo),
        Custo #=< Orcamento,
        Melhoria #>= 0,
        dividePri(Prioridades,PrioridadesDivididas),
        divideCri(ListaMelhorias,MelhoriasDivididas),
        MelhoriaDividida is Melhoria / 10,
        statistics(walltime, [_, ElapsedTime | _]),
        write('Prioridades = '),write(PrioridadesDivididas),nl,
        write('Medidas     = '),write(MelhoriasDivididas),nl,
        write('Custos      = '),write(Custos),nl,
        write('Melhoria    = '),write(MelhoriaDividida),nl,
        write('Custo       = '),write(Custo),nl,
        format('An answer has been found!~nElapsed time: ~3d seconds', ElapsedTime), nl,
        fd_statistics.
        
lista_max([Medida|Resto], MaxCriterio) :-
    lista_max_AUX(Resto, Medida, MaxCriterio).

lista_max_AUX([], MaxCriterio, MaxCriterio).
lista_max_AUX([Medida| Resto], Max0, MaxCriterio) :-
    MaxNovo #= max(Max0,Medida),
    lista_max_AUX(Resto, MaxNovo, MaxCriterio).

calcMelhorias([],_,[]).
calcMelhorias([Medida | RestoMedidas] ,Prioridades,ListaMelhorias):-
        calcMelhorias(RestoMedidas,Prioridades,NovaMelhoria),
        calcProducto(Medida,Prioridades,Producto),
        sumlist(Producto,Melhoria),
        %format('~2f',[Melhoria]),
        ListaMelhorias = [Melhoria| NovaMelhoria].
       

calcProducto([],[],_).
calcProducto([Cri | RestoCri],[Prio | RestoPrio], Melhorias):-
        calcProducto(RestoCri,RestoPrio,NovaMelhoria),
        Melhoria is Cri*Prio,
        Melhorias = [Melhoria | NovaMelhoria].

gerarPrioridades(NumPrioridades,Prioridades):-
        length(Prioridades,NumPrioridades),
        domain(Prioridades,1,10),
        sum(Prioridades,#=,10),
        labeling([value(enume)],Prioridades).
        %dividePri(Prioridades,DecimalPrioridades).
        
gerarMedidas(0,_,[]).
gerarMedidas(NumMedidas,NumCriterios,Medidas):-
       length(Criterios,NumCriterios),
       all_distinct(Criterios),
       domain(Criterios, -10, 10),
       labeling([value(enume)],Criterios),
       %divideCri(Criterios,DecimalCriterios),
       Medidas = [Criterios | NovoMedidas],
       Num1 is NumMedidas - 1,
       gerarMedidas(Num1,NumCriterios,NovoMedidas).

gerarCustos(NumCustos,Custos):-
        length(Custos,NumCustos),
        domain(Custos,1,3000),
        labeling(value(enume),Custos).

dividePri([],[]).
dividePri([Prioridade | Resto],Prioridades):-
       dividePri(Resto,NovaPrioridade),
       Decimal is Prioridade / 10,
       Prioridades = [Decimal | NovaPrioridade].

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

prioridades(0,[]).
prioridades(N,Prioridades):-
        random(0.0,0.1,Rand),
        N1 is N - 1,
        Prioridades = [Rand | NovoRand],
        prioridades(N1,NovoRand).        
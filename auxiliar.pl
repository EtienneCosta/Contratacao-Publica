%------------------------------------------------------------------------------%
%----------------------------- Regras auxiliares ------------------------------%
%------------------------------------------------------------------------------%

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Termo -> {V, F}
nao(T):-T, 
		    !, 
	     	fail.
nao(T).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%teste: L -> {V,F}
teste([]).
teste([I|Is]):-I,teste(Is).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%insercao: T -> {V,F}
insercao(T):- assert(T).
insercao(T):- retract(T), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%remocao: T -> {V,F}
remocao(T):- retract(T).
remocao(T):- assert(T), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%evolucao: T -> {V,F}
evolucao(T):- findall(I,+T::I,Li),
              insercao(T),
              teste(Li).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%involucao: T -> {V,F}
involucao(T):- findall(I,-T::I,Li),
               remocao(T),
               teste(Li).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
evolucaoNeg(T):- findall(I,+(-T)::I,Li),
                 insercao(-T),
                 teste(Li).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
involucaoNeg(T):- findall(I,+(-T)::I,Li),
                  remocao(-T), 
                  teste(Li).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do meta-predicado demo: Questao,Resposta -> {V,F,D}
demo(Questao,verdadeiro):-Questao.
demo(Questao,falso):- -Questao.
demo(Questao,desconhecido):-nao(Questao),
	         				          nao(-Questao).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do meta-predicado demoList: [Questao],[Resposta] -> {V,F,D}
demoLista([],[]).
demoLista([H|T],[X|Xs]):- demo(H,X),
                          demoLista(T,Xs).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado demo: Questao1, Tipo, Questao2, Flag -> {V, F, D}
% Tipo :
% ou - disjuncao
% e  - conjuncao

demo(Q1, ou, Q2, F) :- demo(Q1, F1),
                       demo(Q2, F2),
                       disjuncao(F1, F2, F).

demo(Q1, e, Q2, F) :- demo(Q1, F1),
                      demo(Q2, F2),
                      conjuncao(F1, F2, F).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensao do meta-predicado demoList: [Questao],Resposta -> {V,F,D}

demoConjuncao([],R).
demoConjuncao([H],R):-demo(H,R).
demoConjuncao([H|T],R):- demo(H,R1),
                         demoConjuncao(T,R2),
                         conjuncao(R1,R2,R).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

demoDisjuncao([],R).
demoDisjuncao([H],R):-demo(H,R).
demoDisjuncao([H|T],R):-demo(H,R1),
                        demoDisjuncao(T,R2),
                        disjuncao(R1,R2,R).

                        

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado disjuncao: Tipo, Tipo, Tipo -> {V, F, D}

disjuncao(verdadeiro,_,verdadeiro).
disjuncao(_,verdadeiro,verdadeiro).
disjuncao(falso,falso,falso).
disjuncao(falso,desconhecido,desconhecido).
disjuncao(desconhecido,falso,desconhecido).
disjuncao(desconhecido,desconhecido,desconhecido).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado conjuncao: Tipo, Tipo, Tipo -> {V, F, D}

conjuncao(verdadeiro,verdadeiro,verdadeiro).
conjuncao(verdadeiro,desconhecido,desconhecido).
conjuncao(desconhecido,verdadeiro,desconhecido).
conjuncao(desconhecido,desconhecido,desconhecido).
conjuncao(falso,_,falso).
conjuncao(_,falso,falso).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Verifica a existência de um elemento na lista.

pertence(X,[X|_]).
pertence(X,[_|Tail]):- pertence(X,Tail).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
data(D, M, A) :-
  A >= 0,
    pertence(M, [1, 3, 5, 7, 8, 10, 12]),
  D >= 1,
  D =< 31.
data(D, M, A) :-
  A >= 0,
    pertence(M, [4, 6, 9, 11]),
  D >= 1,
  D =< 30.
data(D, 2, A) :-
  A >= 0,
    A mod 4 =\= 0, 
  D >= 1,
  D =< 28.
data(D, 2, A) :-
    A >= 0,
  A mod 4 =:= 0,
  D >= 1,
  D =< 29.

validaData((D,M,A)) :- data(D,M,A).

getYear((D,M,A),A).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
procedimento(_,_,_,IdsAnuncio,TipoContrato,TipoProcedimento,_,Valor,Prazo,_,Data):-pertence(TipoProcedimento,['Ajuste direto']),
                                       !,
                                       pertence(TipoContrato,['Aquisicao de servicos','Locacao de bens moveis','Contrato de aquisicao']),
                                       validaValor(Valor),
                                       validaPrazo(Prazo),
                                       length(IdsAnuncio,0).

% remover o Concurso publico do procedimento .... 
procedimento(_,_,_,IdsAnuncio,TipoContrato,TipoProcedimento,_,Valor,Prazo,_,Data):-pertence(TipoProcedimento,['Consulta previa']),
                                     pertence(TipoContrato,['Aquisicao de servicos','Locacao de bens moveis','Contrato de aquisicao']),
                                     Valor>0,
                                     Prazo>0,
                                     length(IdsAnuncio,0).

procedimento(_,_,_,IdsAnuncio,TipoContrato,TipoProcedimento,_,Valor,Prazo,_,Data):-pertence(TipoProcedimento,['Concurso publico']),
                                     pertence(TipoContrato,['Aquisicao de servicos','Locacao de bens moveis','Contrato de aquisicao']),
                                     Valor>0,
                                     Prazo>0,
                                     length(IdsAnuncio,1),
                                     head(IdsAnuncio,I),
                                     integer(I),
                                     getDataAnuncio(IdsAnuncio,K),
                                     afterAnun(Data,K).


getDataAnuncio(IdsAnuncio,R):-(somatorio(IdsAnuncio,Id),
                               findall(Data,anuncio(Id,_,_,_,_,_,_,Data),R1),
                               head(R1,R)).



afterAnun((D1,M1,A1),(D2,M2,A2)) :- 
                                    A1 > A2.

afterAnun((D1,M1,A1),(D2,M2,A2)):-  A1 >= A2,
                                    M1 > M2.

afterAnun((D1,M1,A1),(D2,M2,A2)) :- 
                                    A1 >= A2,
                                    M1 >= M2,
                                    D1 > D2.
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

somatorio([],0).
somatorio([H|T],R):-somatorio(T,R1),
                    R is H + R1.
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
validaPrazo(Prazo):- Prazo>0,
                     Prazo=<365.
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
validaValor(Valor):-  Valor>0,
                      Valor=< 5000.
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
foreach([]).
foreach([H|T]):-integer(H),
                foreach(T).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -


pertence2([],[]).
pertence2([Head|Tail],A):-pertence(Head,A),
                         pertence2(Tail,A).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

foreach2([],[]).
foreach2([Id|T],[X|Xs]):-adjudicataria(Id,X,_,_),
                         foreach2(T,Xs). 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -


zip([],[],[]).
zip([X|XS],[Y|YS], [(X,Y)|Z]) :- zip(XS,YS,Z).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

concatenar([],L2,L2).
concatenar(L1,[],L1).
concatenar([Head|Tail],X,[Head|R]):-concatenar(Tail,X,R).

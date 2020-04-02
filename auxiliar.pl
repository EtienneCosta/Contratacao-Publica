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
involucao(T):- T,
               findall(I,-T::I,Li),
               remocao(T),
               teste(Li).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
evolucaoNeg(T):- findall(I,+(-T)::I,Li),
                 teste(Li),
                 assert(-T).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
involucaoNeg(T):- findall(I,+(-T)::I,Li),
                  teste(Li),
                  retract(-T). 

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
% Prazo válido
prazo(X):- X =< 365.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Custo válido

% custo(X):-  X=< 5000.




% SICStus PROLOG: Contratação Pública
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag(unknown,fail).
:- use_module(library(lists)).


:- op( 900, xfy,'::').
:- dynamic (::)/2.
:- dynamic '-'/1.
:- dynamic (excecao/1).
:- dynamic (adjudicante/4).
:- dynamic (adjudicataria/4).
:- dynamic (contrato/11).
:- dynamic (anuncio/8).
:- dynamic (concorrente/2).
:- dynamic (nulo/1).


:-include('bc.pl').
:-include('update.pl').
:-include('invariantes.pl').
:-include('auxiliar.pl').




%------------------------------------------------------------------------------%
% Pressuposto do Mundo Fechado

-adjudicante(IdAd,Nome,NIF,Morada):- 
									nao(adjudicante(IdAd,Nome,NIF,Morada)),
									nao(excecao(adjudicante(IdAd,Nome,NIF,Morada))).

-adjudicataria(IdAda,Nome,NIF,Morada):- 
									nao(adjudicataria(IdAda,Nome,NIF,Morada)),
									nao(excecao(adjudicataria(IdAda,Nome,NIF,Morada))).

-contrato(IdC,IdAd,IdAda,IdsAnuncio,TipoContrato,TipoProcedimento,Descricao ,Valor,Prazo,Local,Data):-
									nao(contrato(IdC,IdAd,IdAda,IdsAnuncio,TipoContrato,TipoProcedimento,Descricao ,Valor,Prazo,Local,Data)),
									nao(excecao(contrato(IdC,IdAd,IdAda,IdsAnuncio,TipoContrato,TipoProcedimento,Descricao ,Valor,Prazo,Local,Data))).		

-anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,Preco,Prazo,Data):-
									nao(anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,Preco,Prazo,Data)),
									nao(excecao(anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,Preco,Prazo,Data))).

-concorrente(IdAnuncio,IdsAd):-		
									nao(concorrente(IdAnuncio,IdsAd)),
									nao(excecao(concorrente(IdAnuncio,IdsAd))).



%------------------------------------------------------------------------------%
% Lista todos os adjudicatários que participaram num determinado concurso.


getConcorrentes(IdC,R):-findall(IdsAnuncio,contrato(IdC,_,_,IdsAnuncio,_,'Concurso publico',_,_,_,_,_),S),
					   head(S,X),
					   head(X,IdAnun),
					   findall(IdsAd,concorrente(IdAnun,IdsAd),S1),
					   head(S1,S2),
					   foreach2(S2,R).



% Total gasto por um adjudicante 

totalGasto(IdAd,R):-findall(Valor,contrato(_,IdAd,_,_,_,_,_,Valor,_,_,_),S),
					findall(Nome,adjudicante(IdAd,Nome,_,_),N),
					somatorio(S,T),
					concatenar([T],[],Total),
					zip(N,Total,R1),
					head(R1,R).



% Total recebido por uma entidade  adjudicatária.

totalRecebido(IdAdA,R):-findall(Valor,contrato(_,_,IdAdA,_,_,_,_,Valor,_,_,_),S),
						findall(Nome,adjudicataria(IdAdA,Nome,_,_),N),
						somatorio(S,T),
						concatenar([T],[],Total),
						zip(N,Total,R1),
						head(R1,R).









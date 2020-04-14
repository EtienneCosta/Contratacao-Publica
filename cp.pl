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













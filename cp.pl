% SICStus PROLOG: Contratação Pública
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag(unknown,fail).

:-include('bc.pl').
:-include('update.pl').
:-include('invariantes.pl').
:-include('auxiliar.pl').

:- op( 900, xfy,'::').
:- dynamic (::)/2.
:- dynamic ('-'/1).
:- dynamic (excecao/1).
:- dynamic (adjudicante/4).
:- dynamic (adjudicataria/4).
:- dynamic (contrato/10).
:- dynamic (anuncio/9).
:- dynamic (concorrente/2).




%------------------------------------------------------------------------------%
% Pressuposto do Mundo Fechado

-adjudicante(IdAd,Nome,NIF,Morada):- 
									nao(adjudicante(IdAd,Nome,NIF,Morada)),
									nao(excecao(adjudicante(IdAd,Nome,NIF,Morada))).

-adjudicataria(IdAda,Nome,NIF,Morada):- 
									nao(adjudicataria(IdAd,Nome,NIF,Morada)),
									nao(excecao(adjudicataria(IdAd,Nome,NIF,Morada))).











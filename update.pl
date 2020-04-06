
%------------------------------------------------------------------------------%
%-------------------------------- Inserções -----------------------------------%
%------------------------------------------------------------------------------%


 % Registo de adjudicante
 registarAdjudicante(IdAd,Nome,NIF,Morada):-
 			evolucao(adjudicante(IdAd,Nome,NIF,Morada)).



 % Registo de adjudicataria 
 registarAdjudicataria(IdAd,Nome,NIF,Morada):-
 			evolucao(adjudicataria(IdAd,Nome,NIF,Morada)).



 % Registo de contrato 
registarContrato(IdC,IdAd,IdAda,IdsAnuncio,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,Data):-
			evolucao(contrato(IdC,IdAd,IdAda,IdsAnuncio,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,Data)).



 % Registo de anuncio 

registarAnuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,Preco,Prazo,Data):-
		evolucao(anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,Preco,Prazo,Data)).


 % Registo de concorrentes

 registarConcorrente(IdAnuncio,IdsAd):-
 		evolucao(concorrente(IdAnuncio,IdsAd)). 



%------------------------------------------------------------------------------%
%-------------------------------- Remoções ------------------------------------%
%------------------------------------------------------------------------------%


% Remover Adjudicante 

 removerAdjudicante(IdAd):- involucao(adjudicante(IdAd,_,_,_)).


% Remover Adjudicataria

 removerAdjudicataria(IdAda):- involucao(adjudicataria(IdAda,_,_,_)).


% Remover Contrato 

 removerContrato(IdContrato):- involucao(contrato(IdContrato,_,_,_,_,_,_,_,_,_,_)).


% Remover Anuncio 

removerAnuncio(IdAnuncio):- involucao(anuncio(IdAnuncio,_,_,_,_,_,_,_)).



%------------------------------------------------------------------------------%
%-------------------------------- Regras --------------------------------------%
%------------------------------------------------------------------------------%





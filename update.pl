
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
registarContrato(IdC,IdAd,IdAda,IdsAnuncio,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,(D,M,A)):-
			evolucao(contrato(IdC,IdAd,IdAda,IdsAnuncio,TipoContrato,TipoProcedimento,Descricao,Valor,Prazo,Local,(D,M,A))).



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
%-------------------------------- Inserções -----------------------------------%
%                          CONHECIMENTO IMPERFEITO INCERTO                     %
%------------------------------------------------------------------------------%

% Insere conhecimento imperfeito incerto: Adjudicante com nome desconhecido.
evolucaoNomeIncerto(adjudicante(IdAd,NomeIncerto,NIF,Morada)) :-
        evolucao(adjudicante(IdAd,NomeIncerto,NIF,Morada)),
        insercao(((excecao(adjudicante(I,No,Ni,M))) :- adjudicante(I,NomeIncerto,Ni,M))).
        

evolucaoNifIncerto(adjudicante(IdAd,Nome,NIFIncerto,Morada)) :-
        evolucao(adjudicante(IdAd,Nome,NIFIncerto,Morada)),
        insercao(((excecao(adjudicante(I,No,Ni,M))) :- adjudicante(I,No,NIFIncerto,M))).


%------------------------------------------------------------------------------%
%-------------------------------- Inserções -----------------------------------%
%                          CONHECIMENTO IMPERFEITO IMPRECISO                   %
%------------------------------------------------------------------------------%
        
evolucaoImpreciso(T):- findall(I,+(excecao(T))::I, Lint),
					   insercao(excecao(T)),
					   teste(Lint).



evolucaoPrecoImpreciso(anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,PrecoImpreciso,Prazo,Data),LimiteInf,LimiteSup):-
			insercao((excecao(anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,PrecoImpreciso,Prazo,Data)):-
						PrecoImpreciso >=LimiteInf , PrecoImpreciso =< LimiteSup)).
                        
                    



%------------------------------------------------------------------------------%
%-------------------------------- Inserções -----------------------------------%
%                          CONHECIMENTO IMPERFEITO INTERDITO                   %
%------------------------------------------------------------------------------%


evolucaoNomeInterdito(adjudicataria(IdAda,NomeInterdito,NIF,Morada)) :-
    evolucao(adjudicataria(IdAda,NomeInterdito,NIF,Morada)),
    insercao((excecao(adjudicataria(I,No,Ni,M)) :-
                adjudicataria(I,NomeInterdito,Ni,M))),
    insercao((nulo(NomeInterdito))),
    insercao(+adjudicataria(ID,NO,NI,MO)::(findall(Nome,(adjudicataria(IdAda,Nome,NIF,Morada),nao(nulo(Nome))),S),
                                  length(S,0))).


    

%------------------------------------------------------------------------------%
%-------------------------------- Inserções -----------------------------------%
%                          CONHECIMENTO Perfeito Positivo                     %
%------------------------------------------------------------------------------%


evolucaoNomePerfeito(adjudicante(IdAd,Nome,NIF,Morada)) :-
		involucaoNomeIncerto(adjudicante(IdAd,NomeIncerto,NIF,Morada)),
        evolucao(adjudicante(IdAd,Nome,NIF,Morada)).

evolucaoNomePerfeito(adjudicataria(IdAd,Nome,NIF,Morada)) :-
        involucaoNomeIncerto(adjudicataria(IdAd,NomeIncerto,NIF,Morada)),
        evolucao(adjudicataria(IdAd,Nome,NIF,Morada)).

evolucaoNifPerfeito(adjudicante(IdAd,Nome,NIF,Morada)) :-
		involucaoNifIncerto(adjudicante(IdAd,Nome,NIFIncerto,Morada)),
        evolucao(adjudicante(IdAd,Nome,NIF,Morada)).




%------------------------------------------------------------------------------%
%-------------------------------- Remoções -----------------------------------%
%                          CONHECIMENTO Imperfeito Incerto                     %
%------------------------------------------------------------------------------%

involucaoNomeIncerto(adjudicante(IdAd,NomeIncerto,NIF,Morada)) :-
    involucao(adjudicante(IdAd,NomeIncerto,NIF,Morada)),
    remocao((excecao(adjudicante(I,No,Ni,M)):-
                     adjudicante(I,NomeIncerto,Ni,M))).

involucaoNomeIncerto(adjudicataria(IdAd,NomeIncerto,NIF,Morada)) :-
    involucao(adjudicataria(IdAd,NomeIncerto,NIF,Morada)),
    remocao((excecao(adjudicataria(I,No,Ni,M)):-
                     adjudicataria(I,NomeIncerto,Ni,M))).



involucaoNifIncerto(adjudicante(IdAd,Nome,NIFIncerto,Morada)) :-
    involucao(adjudicante(IdAd,Nome,NIFIncerto,Morada)),
    remocao((excecao(adjudicante(I,No,Ni,M)):-
                     adjudicante(I,No,NIFIncerto,M))).


%------------------------------------------------------------------------------%
%-------------------------------- Remoções ------------------------------------%
%                          CONHECIMENTO Imperfeito Impreciso                   %
%------------------------------------------------------------------------------%

involucaoImpreciso(T):- findall(I,-(excecao(T))::I,Lint),
    					remocao(excecao(T)),
    					teste(Lint).



involucaoPrecoImpreciso(anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,PrecoImpreciso,Prazo,Data),LimiteInf,LimiteSup) :-
    retract((excecao(anuncio(IdAnuncio,IdAd,Nome,Descricao,TipoContrato,PrecoImpreciso,Prazo,Data)):-
                    PrecoImpreciso >= LimiteInf, PrecoImpreciso =< LimiteSup)).


%------------------------------------------------------------------------------%
%-------------------------------- Remoções ------------------------------------%
%                          CONHECIMENTO Imperfeito Interdito                   %
%------------------------------------------------------------------------------%


% Involução de conhecimento imperfeito interdito

% Retira conhecimento imperfeito interdito na base de conhecimento
% no caso de utente com nome interdito
 involucaoNomeInterdito(adjudicataria(IdAda,NomeInterdito,NIF,Morada)):-
    involucao(adjudicataria(IdAda,NomeInterdito,NIF,Morada)),
    remocao((excecao(adjudicataria(I,No,Ni,M)):-
                adjudicataria(IdAda,NomeInterdito,NIF,Morada))),
    remocao(nulo(NomeInterdito)).






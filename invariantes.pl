
%------------------------------------------------------------------------------%
%-------------------------------- Invariantes ---------------------------------%
%------------------------------------------------------------------------------%




%-------------------------------- Invariantes Estruturais e Referenciais: Adjudicante  ---------------------------------%
% adjudicante: #IdAd, Nome, NIF , Morada 

% Invariante que garante que o id de cada Adjudicante é único para conhecimento positivo.
+adjudicante(IdAd,_,_,_)::(integer(IdAd),
						   findall(IdAd,adjudicante(IdAd,_,_,_),R),
						   length(R,1)).

% Invariante que garante que o NIF de cada Adjudicante é único para conhecimento positivo.
+adjudicante(_,_,NIF,_)::(findall(NIF,adjudicante(_,_,NIF,_),R),
									length(R,1)).

% Invariante que garante que adjudicantes com ids  diferentes têm diferente informação .
+adjudicante(IdAd,Nome,NIF,Morada)::((findall(Nome,adjudicante(_,Nome,_,_),R),
									 length(R,1))).

% Invariante que garante que o id de cada Adjudicante é único para conhecimento negativo.
+(-adjudicante(IdAd,_,_,_))::(integer(IdAd),
						   findall(IdAd,(-adjudicante(IdAd,_,_,_)),R),
						   length(R,2)).

% Invariante que garante que adjudicantes com ids  diferentes têm diferente informação.
-adjudicante(IdAd,_,_,_)::(findall(IdAd,adjudicante(IdAd,_,_,_),R),
						   length(R,0)).

-adjudicante(IdAd,_,_,_)::(findall(IdAd,contrato(_,IdAd,_,_,_,_,_,_,_,_,_),R),
						   length(R,0)).



%-------------------------------- Invariantes Estruturais e Referenciais: Adjudicatarias  ---------------------------------%

% adjudicatária: #IdAda, Nome, NIF , Morada ↝ { 𝕍,𝔽,𝔻 }

% Invariante que garante que o id de cada adjudicataria é único para conhecimento positivo.

+adjudicataria(IdAda,_,_,_)::(integer(IdAda),
						   	  findall(IdAda,adjudicataria(IdAda,_,_,_),R),
						      length(R,1)).


% Invariante que garante que o NIF de cada Adjudicante é único para conhecimento positivo.

+adjudicataria(_,_,NIF,_)::(findall(NIF,adjudicataria(_,_,NIF,_),R),
									length(R,1)).

% Invariante que garante que adjudicantes com ids  diferentes têm diferente informação .

+adjudicataria(IdAda,Nome,NIF,Morada)::((findall((Nome,NIF,Morada),adjudicataria(_,Nome,NIF,Morada),R),
									     length(R,1))).


-adjudicataria(IdAda,_,_,_)::(findall(IdAda,adjudicataria(IdAda,_,_,_),R),
						    length(R,0)).

-adjudicataria(IdAda,_,_,_)::(findall(IdAda,contrato(_,_,IdAda,_,_,_,_,_,_,_,_),R),
						   length(R,0)).

%-------------------------------- Invariantes Estruturais e Referenciais: Contrato  ---------------------------------%


% contrato: #IdC ,#IdAd, #IdAda,[#IdAnuncio], Tipo de Contrato, Tipo de Procedimento , Descrição , Valor , Prazo , Local ,Data ↝ { 𝕍,𝔽,𝔻 }

% contratos válidos :(['Aquisicao de servicos','Locacao de bens moveis','Contrato de aquisicao']).
% procedimentos válidos : (['Ajuste direto','Consulta previa','Concurso publico']).

+contrato(Idc,_,_,_,_,_,_,_,_,_,_)::(integer(Idc),
									 findall(Idc,contrato(Idc,_,_,_,_,_,_,_,_,_,_),R),
								     length(R,1)).


+contrato(_,IdAd,IdAda,_,_,_,_,_,_,_,_)::(integer(IdAd),
										  integer(IdAda),
										  findall(IdAd,adjudicante(IdAd,_,_,_),R1),
										  findall(IdAda,adjudicataria(IdAda,_,_,_),R2),
								    	  length(R1,1),
								    	  length(R2,1)).

+contrato(_,_,_,_,_,_,_,_,_,_,Data)::(validaData(Data)).


+contrato(_,_,_,IdsAnuncio,TipoContrato,TipoProcedimento,_,Valor,Prazo,_,Data)::procedimento(_,_,_,IdsAnuncio,TipoContrato,TipoProcedimento,_,Valor,Prazo,_,Data).


+contrato(_,IdAd,IdAda,_,TC,_,Descricao,Valor,_,_,(D,M,A))::(Ano1 is A,
															Ano2 is A-1,
															Ano3 is A-2,
															findall(V,
															contrato(_,IdAd,IdAda,_,TC,_,Descricao,V,_,_,(_,_,Ano1)),
															S1),
															findall(V,
															contrato(_,IdAd,IdAda,_,TC,_,Descricao,V,_,_,(_,_,Ano2)),
															S2),
															findall(V,
															contrato(_,IdAd,IdAda,_,TC,_,Descricao,V,_,_,(_,_,Ano3)),
															S3),
															somatorio(S1,VA1),
															somatorio(S2,VA2),
															somatorio(S3,VA3),
															Soma is VA1 + VA2 + VA3 - Valor,
															Soma<75000).




%Remocao de contrato 


-contrato(Idc,_,_,IdsAnuncio,_,_,_,_,_,_,_)::(findall(Idc,contrato(Idc,_,_,_,_,_,_,_,_,_,_),R),
											  length(R,0)).


-contrato(Idc,_,_,IdsAnuncio,_,_,_,_,_,_,_)::(findall(IdsAnuncio,contrato(Idc,_,_,IdsAnuncio,_,_,_,_,_,_,_),R),
											  head(R,R1),
											  length(R1,0)).




%-------------------------------- Invariantes Estruturais e Referenciais: Anúncio  ---------------------------------%

% anúncio: #IdAnuncio, #IdAd, Nome,Descrição,Tipo de Contrato,Preço, Prazo, Data.


+anuncio(IdAnuncio,IdAd,Nome,_,_,_,_,_)::(integer(IdAnuncio),
												 integer(IdAd),
												 findall((IdAd,Nome),adjudicante(IdAd,Nome,_,_),R1),
												 length(R1,1),
												 findall(IdAnuncio,anuncio(IdAnuncio,_,_,_,_,_,_,_),R2),
												 length(R2,1)).

+anuncio(_,_,_,_,TipoContrato,Preco,Prazo,Data)::(Preco>0,
									   Prazo>0,
								       validaData(Data),
                                       pertence(TipoContrato,['Aquisicao de servicos','Locacao de bens moveis','Contrato de aquisicao'])).
%Remocao de anuncio


-anuncio(IdAnuncio,IdAd,Nome,_,_,_,_,_)::(findall(IdAnuncio,anuncio(IdAnuncio,IdAd,Nome,_,_,_,_,_),R),
										  length(R,0)).
 
-anuncio(IdAnuncio,IdAd,Nome,_,_,_,_,_)::(findall(IdAnuncio,concorrente(IdAnuncio,_),R),
											  length(R,0)).

%-------------------------------- Invariantes Estruturais e Referenciais: Concorrente  ---------------------------------%

% concorrente: #IdAnuncio, [#IdsAd].

+concorrente(IdAnuncio,IdsAd)::(findall(IdAnuncio,concorrente(IdAnuncio,_),R),
								length(R,1),
								foreach(IdsAd),
								findall(Id,adjudicante(Id,_,_,_),L),
								pertence2(IdsAd,L)).

-concorrente(IdAnuncio,_)::(findall(IdAnuncio,concorrente(IdAnuncio,_),R),
							length(R,0)).



%-------------------------------- Invariantes Estruturais e Referenciais: Conhecimento Imperfeito  ---------------------------------%


% Invariante que garante que não existem excecoes repetidas

+(excecao(T)):: (findall(T,excecao(T),R),
                 length(R,1)).










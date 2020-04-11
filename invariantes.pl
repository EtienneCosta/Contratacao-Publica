
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

+adjudicante(IdAd,Nome,NIF,Morada)::((findall((Nome,NIF,Morada),adjudicante(_,Nome,NIF,Morada),R),
									 length(R,1))).


% Invariante que garante que o id de cada Adjudicante é único para conhecimento negativo.


+(-adjudicante(IdAd,_,_,_))::(integer(IdAd),
						   findall(IdAd,-adjudicante(IdAd,_,_,_),R),
						   length(R,1)).

% Invariante que garante que o NIF de cada Adjudicante é único para conhecimento negativo.

+(-adjudicante(_,_,NIF,_))::(findall(NIF,-adjudicante(_,_,NIF,_),R),
									length(R,1)).


% Invariante que garante que adjudicantes com ids  diferentes têm diferente informação.

+(-adjudicante(IdAd,Nome,NIF,Morada))::((findall((Nome,NIF,Morada),-adjudicante(_,Nome,NIF,Morada),R),
									 length(R,1))).

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


% Invariante que garante que o id de cada Adjudicante é único para conhecimento negativo.


+(-adjudicataria(IdAda,_,_,_))::(integer(IdAda),
						         findall(IdAda,-adjudicataria(IdAda,_,_,_),R),
						         length(R,1)).

% Invariante que garante que o NIF de cada Adjudicante é único para conhecimento negativo.

+(-adjudicataria(_,_,NIF,_))::(findall(NIF,-adjudicataria(_,_,NIF,_),R),
									length(R,1)).


% Invariante que garante que adjudicantes com ids  diferentes têm diferente informação.

+(-adjudicataria(IdAda,Nome,NIF,Morada))::((findall((Nome,NIF,Morada),-adjudicataria(_,Nome,NIF,Morada),R),
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



% contrato: #IdC ,#IdAd, #IdAda,[#IdAnuncio], Tipo de Contrato, Tipo de Procedimento , Descrição , Valor , Prazo , Local ,Data ↝ { 𝕍,𝔽,𝔻 }


% Regra dos 3 anos válida para todos os contratos ...
% +contrato(_,IdAd,IdAda,_,TC,_,Descricao,Valor,_,_,Data)::(treeyears(_,IdAd,IdAda,_,TC,_,Descricao,Valor,_,_,Data)).






+(-contrato(Idc,_,_,_,_,_,_,_,_,_,_))::(integer(Idc),
									 findall(Idc,-contrato(Idc,_,_,_,_,_,_,_,_,_,_),R),
								     length(R,1)).
																

+(-contrato(_,IdAd,IdAda,_,_,_,_,_,_,_,_))::(integer(IdAd),
										     integer(IdAda),
										  	 findall(IdAd,adjudicante(IdAd,_,_,_),R1),
										     findall(IdAda,adjudicataria(IdAda,_,_,_),R2),
								    	     length(R1,1),
								    	     length(R2,1)).														


+(-contrato(_,_,_,_,_,_,_,_,_,_,Data))::(validaData(Data)).


+(-contrato(_,_,_,IdsAnuncio,TipoContrato,TipoProcedimento,_,Valor,Prazo,_,Data))::procedimento(_,_,_,IdsAnuncio,TipoContrato,TipoProcedimento,_,Valor,Prazo,_,Data).


%Remocao de contrato 

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



%-------------------------------- Invariantes Estruturais e Referenciais: Concorrente  ---------------------------------%

% concorrente: #IdAnuncio, [#IdAd].

+concorrente(IdAnuncio,IdsAd)::(findall(IdAnuncio,concorrente(IdAnuncio,_),R),
								length(R,1),
								foreach(IdsAd),
								findall(Id,adjudicante(Id,_,_,_),L),
								pertence2(IdsAd,L)).





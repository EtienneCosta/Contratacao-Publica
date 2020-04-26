%--------------------BASE DE CONHECIMENTO---------------------------------------------------------------

% Extensão do predicado adjudicante: #IdAd, Nome, NIF , Morada ↝ { 𝕍,𝔽,𝔻 }

% Conhecimento Positivo 
adjudicante(1,'Direcao Regional da Energia',600087158,'Portugal-Lisboa').
adjudicante(2,'Ordem dos Contabilistas Certificados',503692310,'Portugal-Lisboa').
adjudicante(3,'Municipio de Vila Nova de Gaia',505335018,'Portugal-Porto').
adjudicante(4,'Instituto Politecnico de Lisboa',508519713,'Portugal-Lisboa').
adjudicante(5,'Policia Judiciaria',600011712,'Portugal-Lisboa').
adjudicante(6,'Ordem dos Engenheiros',500839166,'Portugal').
adjudicante(7,'Direcao Geral da Saude',600037100,'Portugal-Lisboa').
adjudicante(8,'Universidade do Minho',502011378,'Portugal-Braga').


% Conhecimento Negativo
-adjudicante(9,'Municipio de Valongo',501138960,'Portugal-Porto').
-adjudicante(10,'Aguas do Norte, S.A',513606084,'Portugal-Vila Real'). 


% Conhecimento Imperfeito Incerto
adjudicante(11,'Municipio de Guimaraes',x001,'Portugal-Guimaraes').
excecao(adjudicante(Id,Nome,NIF,Morada)):-
    adjudicante(Id,Nome,x001,Morada).

adjudicante(12,'Universidade Aberta',502110660,x002).
excecao(adjudicante(Id,Nome,NIF,Morada)):-
    adjudicante(Id,Nome,NIF,x002).


% Conhecimento Imperfeito Impreciso
excecao(adjudicante(13,'Freguesia de Caldas das Taipas',507186265,'Portugal-Guimaraes')).
excecao(adjudicante(13,'Freguesia de Caldelas',507186265,'Portugal-Guimaraes')).



% Conhecimento Imperfeito Interdito : NIF nunca será conhecido.

nulo(np001).
excecao(adjudicante(Ida,Nome,NIF,Morada)):-
    adjudicante(Ida,Nome,np001,Morada).

adjudicante(14,'Municipio de Vizela',np001,'Portugal-Vizela').

+adjudicante(IdAda,Nome,NIF,Morada):: (findall(N,(adjudicante(14,'Municipio de Vizela',N,'Portugal-Vizela'),
                                       nao(nulo(N))),S),
                                       length(S,0)).

%-------------------------------------------------------------------------------------------------------
% Conhecimento Positivo

% adjudicatária: #IdAda, Nome, NIF , Morada ↝ { 𝕍,𝔽,𝔻 }

adjudicataria(1,'EVCE Power, Lda',514385472,'Portugal').
adjudicataria(2,'Junior Salgado',232830185,'Portugal').
adjudicataria(3,'Dilicontas, Lda',504906232,'Portugal').
adjudicataria(4,'Etienne Costa',700000003,'Franca').
adjudicataria(5,'X LIGHT, LDA',515325180,'Portugal').
adjudicataria(6,'Pedro Costa',700000004,'Portugal').
adjudicataria(7,'Securitas',500243719,'Portugal').
adjudicataria(8,'Grafica 99. Lda',503956759,'Portugal').
adjudicataria(9,'PETROGAL S.A',500697370,'Portugal').
adjudicataria(10,'SDL Global Solutions LTD',48733689,'Paises Baixos').
adjudicataria(11,'BBZ - Publicidade e Marketing, SA',503453838,'Espanha').

% Conhecimento Negativo

-adjudicataria(12,'Ricardo Lopes',700000005,'Italia').
-adjudicataria(13,'Mario Santos',700000006,'Andorra').


% Conhecimento Imperfeito Incerto
adjudicataria(14,'Pichelaria Chaves, Lda',500125512, x003).
excecao(adjudicataria(Id,Nome,NIF,Morada)):-
        adjudicataria(Id,Nome,NIF,x003).

adjudicataria(15,'Serralharia Martins,Lda',520426412, x004).
excecao(adjudicataria(Id,Nome,NIF,Morada)):-
        adjudicataria(Id,Nome,NIF,x004).


% Conhecimento Imperfeito Impreciso

excecao(adjudicataria(16,'ERT - Advogados, Lda',521141825, 'Portugal-Famalicao')).
excecao(adjudicataria(16,'ERT - Advogados, SA',521141825, 'Portugal-Famalicao')).

% Conhecimento Imperfeito Interdito

%morada nunca sera conhecida.

nulo(np002).
excecao(adjudicataria(IdAda,Nome,NIF,Morada)):-
       adjudicataria(IdAda,Nome,NIF,np002).

adjudicataria(16,'Energias Renovaveis,Lda',551464123, np002).


+adjudicataria(IdAda,Nome,NIF,Morada):: (findall(M,(adjudicataria(16,'Energias Renovaveis,Lda',551464123,M),nao(nulo(M))),S),
                                        length(S,0)).


%-------------------------------------------------------------------------------------------------------

% Conhecimento Positivo

% contrato: #IdC ,#IdAd, #IdAda,#[IdAnuncio],Tipo de Contrato, Tipo de Procedimento , Descrição , Valor , Prazo , Local ,Data ↝ { 𝕍,𝔽,𝔻 }
% contratos válidos :(['Aquisicao de servicos','Locacao de bens moveis','Contrato de aquisicao']).
% procedimentos válidos : (['Ajuste direto','Consulta previa','Concurso publico']).

contrato(1,1,1,[1],'Locacao de bens moveis','Concurso publico','Arranjar uma Descricao melhor',632502.50,365,'Portugal',(26,07,2019)).
contrato(2,1,2,[],'Aquisicao de servicos','Ajuste direto','Prestacao de servicos de assessoria tecnica, em regime de avenca, na area de Geologia',3600,200,'Portugal',(30,08,2018)).
contrato(3,2,2,[],'Aquisicao de servicos','Ajuste direto','Aquisicao de servicos de elaboracao de manual',1250,180,'Portugal',(06,02,2020)).
contrato(4,8,8,[2],'Aquisicao de servicos','Concurso publico','Instalacao e programacao de controlo de acessos RACS5',37500,29,'Portugal',(03,12,2019)).


% Conhecimento Negativo

-contrato(5,3,4,[],'Aquisicao de servicos','Consulta previa','Prestacao de servicos de contabilidade',124000,100,'Portugal',(02,05,2020)).
-contrato(6,8,7,[],'Aquisicao de servicos','Ajuste direto','Presta de servicos de seguranca',30000,30,'Franca',(12,01,2005)).

% Conhecimento Imperfeito Incerto

%valor desconhecido
contrato(7,5,6,[],'Aquisicao de servicos','Consulta previa','Reparacao',x005,15,'Portugal',(01,02,2020)).
excecao(contrato(IdC,Ida,IdAda,IdsAnun,TC,TP,Desc,V,P,L,D)):-contrato(IdC,Ida,IdAda,IdsAnun,TC,TP,Dec,x005,P,L,D).


contrato(8,8,7,[],'Aquisicao de servicos','Ajuste direto','Presta de servicos de seguranca',3000,30,'Franca',x006).
excecao(contrato(IdC,Ida,IdAda,IdsAnun,TC,TP,Desc,V,P,L,D)):-contrato(IdC,Ida,IdAda,IdsAnun,TC,TP,Dec,V,P,L,x006).



% Conhecimento Imperfeito Impreciso

%valor do contrato entre 100 e 4000
excecao(contrato(9,6,10,[],'Aquisicao de servicos', 'Ajuste direto', 'Prestacao de servicos de sistemas informaticos',Valor,90,'Portugal',(24,04,2020))):-
    Valor>=100, Valor =<4000.

%data do contrato ou foi dia 01-03-2020 ou 01-04-2020
%Anuncio ----
excecao(contrato(10,7,7,[3],'Aquisicao de servicos', 'Concurso Publico', 'Prestacao de servicos de seguranca',3000,60,'Portugal',(01,03,2020))).
excecao(contrato(10,7,7,[3],'Aquisicao de servicos', 'Concurso Publico', 'Prestacao de servicos de seguranca',3000,60,'Portugal',(01,04,2020))).


% Conhecimento Imperfeito Interdito

nulo(np003).
excecao(contrato(IdC,Ida,IdAda,IdsAnun,TC,TP,Desc,V,P,L,D)):-
    contrato(IdC,Ida,IdAda,IdsAnun,TC,TP,Dec,np003,P,L,D).

contrato(11,4,2,[],'Aquisicao de servicos','Ajuste direto','Instalacao paineis solares',np003,30,'Portugal-Lisboa',(20,10,2019)).


+contrato(IdC,Ida,IdAda,IdsAnun,TC,TP,Desc,V,P,L,D)::(findall(Valor,
                                                              (contrato(11,4,2,[],'Aquisicao de servicos','Ajuste direto','Instalacao paineis solares',Valor,30,'Portugal-Lisboa',(20,10,2019)),
                                                               nao(nulo(Valor))),S),
                                                               length(S,0)).

%-------------------------------------------------------------------------------------------------------
% Conhecimento Positivo

% anúncio: #IdAnuncio, #IdAd, Nome,Descrição,Tipo de Contrato,Preço, Prazo, Data.

anuncio(1,1,'Direcao Regional da Energia','Concurso Publico Internacional','Aquisicao de bens moveis',650000,45,(12,05,2019)).
anuncio(2,8,'Universidade do Minho','Instalacao e programacao de controlo de acessos RACS5','Aquisicao de Servicos',200000,30,(02,12,2019)).
anuncio(3,7,'Direcao Geral da Saude','Prestacao de servicos de seguranca','Aquisicao de servicos',3500,60,(01,01,2020)).

%-------------------------------------------------------------------------------------------------------

% Conhecimento Positivo

% concorrente: #IdAnuncio, [#IdAds].

concorrente(1,[1,5,10,11]).
concorrente(2,[2,4,6,8]).
concorrente(3,[7]).








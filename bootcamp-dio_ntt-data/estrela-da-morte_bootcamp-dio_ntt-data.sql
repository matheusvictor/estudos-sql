CREATE DATABASE estrela_da_morte;

USE estrela_da_morte;

CREATE TABLE Planetas(
	IdPlaneta INT NOT NULL, -- chave candidata (possui potencial caráter identificador da tabela)
	Nome VARCHAR(50) NOT NULL,
	Rotacao FLOAT NOT NULL,
	Orbita FLOAT NOT NULL,
	Diametro FLOAT NOT NULL,
	Clima VARCHAR(50) NOT NULL,
	Populacao INT NOT NULL,
)
GO

ALTER TABLE Planetas ADD CONSTRAINT PK_Planetas PRIMARY KEY(IdPlaneta);

CREATE TABLE Naves(
	IdNave INT NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Modelo VARCHAR(150),
	Passageiros INT,
	Carga FLOAT,
	Classe VARCHAR(100),
	CONSTRAINT PK_Naves PRIMARY KEY(IdNave)
)
GO

CREATE TABLE Pilotos(
	IdPiloto INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	AnoNascimento VARCHAR(10) NOT NULL,
	IdPlaneta INT NOT NULL
)
GO

ALTER TABLE Pilotos ADD CONSTRAINT PK_Pilotos PRIMARY KEY(IdPiloto);
GO
ALTER TABLE Pilotos ADD CONSTRAINT FK_Pilotos_Planetas FOREIGN KEY(IdPlaneta) REFERENCES Planetas (IdPlaneta);

CREATE TABLE PilotosNaves(
	IdPiloto INT NOT NULL,
	IdNave INT NOT NULL,
	FlagAutorizado BIT NOT NULL,
)
GO
ALTER TABLE PilotosNaves ADD CONSTRAINT PK_PilotosNaves PRIMARY KEY(IdPiloto, IdNave);
GO
ALTER TABLE PilotosNaves ADD CONSTRAINT FK_PilotosNaves_Pilotos FOREIGN KEY(IdPiloto) REFERENCES Pilotos(IdPiloto);
GO
ALTER TABLE PilotosNaves ADD CONSTRAINT FK_PilotosNaves_Naves FOREIGN KEY(IdNave) REFERENCES Naves(IdNave);
GO
ALTER TABLE PilotosNaves ADD CONSTRAINT DF_PilotosNaves_FlagAutorizado DEFAULT (1) FOR FlagAutorizado;

CREATE TABLE HistoricoViagens(
	IdNave INT NOT NULL,
	IdPiloto INT NOT NULL,
	DtSaida DATETIME NOT NULL,
	DtChegada DATETIME NULL
)
GO

ALTER TABLE HistoricoViagens ADD CONSTRAINT FK_HistoricoViagens_PilotosNaves FOREIGN KEY(IdPiloto, IdNave)
REFERENCES PilotosNaves (IdPiloto, IdNave);
GO

ALTER TABLE HistoricoViagens CHECK CONSTRAINT FK_HistoricoViagens_PilotosNaves;

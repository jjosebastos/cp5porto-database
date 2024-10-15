CREATE TABLE T_CON_AUTORIZADA(
    id_autorizada INTEGER PRIMARY KEY,
    nm_autorizada VARCHAR2(30) NOT NULL,
    nr_cnpj VARCHAR2(18)UNIQUE NOT NULL
);


CREATE TABLE T_CON_CLIENTE (
    id_cliente INTEGER PRIMARY KEY,
    tp_cliente VARCHAR2(2) NOT NULL,
    st_cliente VARCHAR2(1) NOT NULL,
    CONSTRAINT CK_CON_CLIENTE
    CHECK (tp_cliente in ('PF','PJ'))
);

CREATE TABLE T_CON_PESSOA_FISICA(
    id_cliente INTEGER PRIMARY KEY,
    nm_cliente VARCHAR2(50) NOT NULL,
    dt_nascimento DATE NOT NULL,
    nr_cpf VARCHAR2(14)UNIQUE NOT NULL,
    ds_genero VARCHAR2(20) NOT NULL,
    CONSTRAINT CK_CON_GENERO
    CHECK (ds_genero IN ('Masculino', 'Feminino', 'Outro')),
    CONSTRAINT FK_CON_CLIENTE_PFISICA
    FOREIGN KEY (id_cliente)
        REFERENCES T_CON_CLIENTE(id_cliente)
);

CREATE TABLE T_CON_PESSOA_JURIDICA (
    id_cliente INTEGER PRIMARY KEY,
    nr_cnpj VARCHAR2(18) UNIQUE NOT NULL,
    nm_razao_social VARCHAR2(100) NOT NULL,
    nm_fantasia VARCHAR2(100),
    CONSTRAINT FK_CON_CLIENTE_PJURIDICA FOREIGN KEY (id_cliente)
        REFERENCES T_CON_CLIENTE(id_cliente)
);

CREATE TABLE T_CON_VEICULO (
    id_veiculo INTEGER PRIMARY KEY,
    nr_placa VARCHAR2(7) NOT NULL,
    ds_marca VARCHAR2(15) NOT NULL,
    nm_modelo VARCHAR2(15) NOT NULL,
    nr_chassi VARCHAR2(17),
    id_cliente INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) 
        REFERENCES T_CON_CLIENTE(id_cliente)
);

CREATE TABLE T_CON_HISTORICO_VEICULO (
    id_historico INTEGER PRIMARY KEY,
    dt_aquisicao DATE NOT NULL,
    dt_venda DATE,
    id_cliente INTEGER NOT NULL,
    id_veiculo INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) 
        REFERENCES T_CON_CLIENTE(id_cliente),
    FOREIGN KEY (id_veiculo) 
        REFERENCES T_CON_VEICULO(id_veiculo)
);

CREATE TABLE T_CON_SEGURADORA (
    id_seguradora INTEGER PRIMARY KEY,
    nm_seguradora VARCHAR2(30) NOT NULL,
    nr_cnpj CHAR(18) NOT NULL,
    id_veiculo INTEGER,
    FOREIGN KEY (id_veiculo) 
        REFERENCES T_CON_VEICULO(id_veiculo)
);
CREATE TABLE T_CON_TELEFONE (
    id_telefone INTEGER PRIMARY KEY,
    nr_ddd VARCHAR2(3) NOT NULL,
    nr_telefone VARCHAR2(9) NOT NULL,
    tp_telefone VARCHAR2(20) NOT NULL,
    id_seguradora INTEGER,
    id_autorizada INTEGER,
    id_cliente INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES T_CON_CLIENTE(id_cliente),
    FOREIGN KEY (id_seguradora) REFERENCES T_CON_SEGURADORA(id_seguradora),
    FOREIGN KEY (id_autorizada) REFERENCES T_CON_AUTORIZADA(id_autorizada)
);
CREATE TABLE T_CON_ENDERECO (
    id_endereco INTEGER PRIMARY KEY,
    nm_rua VARCHAR2(25) NOT NULL,
    nr_endereco VARCHAR2(5),
    nm_bairro VARCHAR2(20) NOT NULL,
    nm_cidade VARCHAR2(15) NOT NULL,
    sg_unidade_federativa CHAR(2) NOT NULL,
    ds_complemento VARCHAR2(40),
    id_cliente INTEGER,
    id_seguradora INTEGER,
    id_autorizada INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES T_CON_CLIENTE(id_cliente),
    FOREIGN KEY (id_seguradora) REFERENCES T_CON_SEGURADORA(id_seguradora),
    FOREIGN KEY (id_autorizada) REFERENCES T_CON_AUTORIZADA(id_autorizada)
);
CREATE TABLE T_CON_TECNICO (
    id_tecnico INTEGER PRIMARY KEY,
    nm_tecnico VARCHAR2(30) NOT NULL,
    dt_nascimento DATE NOT NULL,
    nr_registro_matricula VARCHAR2(20) NOT NULL,
    id_autorizada INTEGER,
    FOREIGN KEY (id_autorizada) REFERENCES T_CON_AUTORIZADA(id_autorizada)
);

CREATE TABLE T_CON_ORCAMENTO (
    id_orcamento INTEGER PRIMARY KEY,
    dt_hora_criacao DATE NOT NULL,
    st_aprovacao CHAR(15) 
        CHECK (st_aprovacao in ('aprovado', 'reprovado', 'em espera'))
        NOT NULL,
    ds_diagnostico_inicial VARCHAR2(100) NOT NULL,
    id_veiculo INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES T_CON_VEICULO(id_veiculo),
    FOREIGN KEY (id_tecnico) REFERENCES T_CON_TECNICO(id_tecnico)
);

CREATE TABLE T_CON_REPARO (
    id_reparo INTEGER PRIMARY KEY,
    dt_inicio_reparo DATE NOT NULL,
    dt_fim_reparo DATE,
    ds_servico VARCHAR2(200) NOT NULL,
    vl_servico DECIMAL(8,2) NOT NULL,
    id_tecnico INTEGER NOT NULL,
    id_orcamento INTEGER,
    FOREIGN KEY (id_tecnico) REFERENCES T_CON_TECNICO(id_tecnico),
    FOREIGN KEY (id_orcamento) REFERENCES T_CON_ORCAMENTO(id_orcamento)
);

CREATE TABLE T_CON_PAGAMENTO (
    id_pagamento INTEGER PRIMARY KEY,
    dt_pagamento DATE NOT NULL,
    vl_pagamento DECIMAL(10,2) NOT NULL,
    st_pagamento VARCHAR2(20) NOT NULL,
    id_cliente INTEGER NOT NULL,
    id_seguradora INTEGER,
    id_autorizada INTEGER,
    tp_pagamento VARCHAR2(20),
    FOREIGN KEY (id_cliente) REFERENCES T_CON_CLIENTE(id_cliente),
    FOREIGN KEY (id_seguradora) REFERENCES T_CON_SEGURADORA(id_seguradora),
    FOREIGN KEY (id_autorizada) REFERENCES T_CON_AUTORIZADA(id_autorizada)
);



DROP TABLE T_CON_ENDERECO;
DROP TABLE T_CON_TELEFONE;
DROP TABLE T_CON_HISTORICO_VEICULO;
DROP TABLE T_CON_REPARO;
DROP TABLE T_CON_ORCAMENTO;
DROP TABLE T_CON_SEGURADORA;
DROP TABLE T_CON_TECNICO;
DROP TABLE T_CON_PAGAMENTO;
DROP TABLE T_CON_AUTORIZADA;
DROP TABLE T_CON_SEGURADORA;
DROP TABLE T_CON_VEICULO;
DROP TABLE T_CON_CLIENTE;
DROP TABLE T_CON_MOTO;
DROP TABLE T_CON_CARRO;
DROP TABLE T_CON_CLIENTE_PESSOA_FISICA;
DROP TABLE T_CON_CLIENTE_PESSOA_JURIDICA;
-- CREATE SCHEMA
ALTER SESSION SET " ORACLE SCRIPT"=true;
CREATE USER TEST IDENTIFIED BY 1234;
GRANT dba to TEST;

-- DDL
CREATE TABLE role (
    cod_role NUMBER(1) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1)
        CONSTRAINT pk_role PRIMARY KEY,

    type_role VARCHAR2(1) CONSTRAINT nn_typeRole NOT NULL,
    CONSTRAINT chk_typeRole CHECK ( type_role in ('C', 'W'))
);

CREATE TABLE country (
    cod_country NUMBER(3) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1)
        CONSTRAINT pk_country PRIMARY KEY,

    name_country VARCHAR2(50) CONSTRAINT nn_nameCountry NOT NULL
);

CREATE TABLE city (
    cod_city NUMBER(3) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1)
        CONSTRAINT pk_city PRIMARY KEY,

    cod_postal NUMBER(6) CONSTRAINT chk_codPostal CHECK ( cod_postal>0 ),

    name_city VARCHAR2(50) CONSTRAINT nn_nameCity NOT NULL,

    fk_idCountry NUMBER(2) CONSTRAINT nn_fkIdCountry NOT NULL,
    CONSTRAINT fk_idCountry FOREIGN KEY (fk_idCountry)
        REFERENCES COUNTRY(COD_COUNTRY)
);

CREATE TABLE store (
    cod_store NUMBER(3) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1)
        CONSTRAINT pk_store PRIMARY KEY,

    name_store VARCHAR2(20) CONSTRAINT nn_nameStore NOT NULL,

    address_store VARCHAR2(50) CONSTRAINT nn_Address NOT NULL,

    fk_idCity NUMBER(3) CONSTRAINT nn_fkIdCity NOT NULL,
    CONSTRAINT fk_idCity FOREIGN KEY (fk_idCity)
        REFERENCES CITY(COD_CITY)
);

CREATE TABLE user_store (
    code_user NUMBER(3) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1)
        CONSTRAINT pk_user PRIMARY KEY,

    first_user VARCHAR2(20) CONSTRAINT nn_firstUser NOT NULL,

    last_user VARCHAR2(20) CONSTRAINT nn_lastUser NOT NULL,

    email_user VARCHAR2(20) CONSTRAINT nn_email NOT NULL,

    status CHAR(1) CONSTRAINT nn_status NOT NULL,
    CONSTRAINT chk_status CHECK ( status IN ('1', '0')),

    username VARCHAR2(20),

    password VARCHAR2(20),

    register_date TIMESTAMP,

    address VARCHAR2(50) CONSTRAINT nn_addressUser NOT NULL,

    fk_idRol NUMBER(1) CONSTRAINT nn_fkIdRolUsr NOT NULL,
    CONSTRAINT fk_idRolUsr FOREIGN KEY (fk_idRol) REFERENCES ROLE(COD_ROLE),

    fk_idStore NUMBER(3) CONSTRAINT nn_fkIdStoreUsr NOT NULL,
    CONSTRAINT fk_idStrUsr FOREIGN KEY (fk_idStore) REFERENCES STORE(COD_STORE),

    fk_idCity NUMBER(3) CONSTRAINT nn_fkIdCityUsr NOT NULL,
    CONSTRAINT fk_idCityUsr FOREIGN KEY (fk_idCity) REFERENCES CITY(COD_CITY),

    fk_idChief NUMBER(3),
    CONSTRAINT fk_idChfUsr FOREIGN KEY (fk_idChief) REFERENCES user_store(code_user)
);

CREATE TABLE languaje (
    cod_languaje NUMBER(3) CONSTRAINT pk_codLanguaje PRIMARY KEY,

    languaje_movie VARCHAR2(20) CONSTRAINT nn_languejMovie NOT NULL
);

CREATE TABLE actor (
    cod_actor NUMBER(3) CONSTRAINT pk_actor PRIMARY KEY,

    first_actor VARCHAR2(25) CONSTRAINT nn_firstAct NOT NULL,

    last_actor VARCHAR2(25) CONSTRAINT nn_lastAct NOT NULL
);

CREATE TABLE category (
    cod_category NUMBER(3) CONSTRAINT pk_codCategory PRIMARY KEY,

    name_category VARCHAR2(25) CONSTRAINT nn_nameCategory NOT NULL
);

CREATE TABLE movie (
    cod_movie NUMBER(3) CONSTRAINT pk_movie PRIMARY KEY,

    title_movie VARCHAR2(20) CONSTRAINT nn_title NOT NULL,

    desc_movie VARCHAR2(20) CONSTRAINT nn_desc NOT NULL,

    release_year NUMBER(5) CONSTRAINT nn_releaseYear NOT NULL
                   CONSTRAINT chk_releareYear CHECK ( release_year>1900 ),

    duration NUMBER(2) CONSTRAINT nn_duration NOT NULL
                   CONSTRAINT chk_duration CHECK ( duration>0 ),

    cant_max_days NUMBER(2) CONSTRAINT nn_cant_max_days NOT NULL
                   CONSTRAINT chk_cantDaysMax CHECK ( cant_max_days>0 ),

    unit_cost NUMBER(5, 2) CONSTRAINT nn_unitCost NOT NULL
                   CONSTRAINT chk_unitCost CHECK ( unit_cost>0 ),

    surcharge_cost NUMBER(8, 2) CONSTRAINT nn_surchargue_cost NOT NULL
                   CONSTRAINT chk_surcharge CHECK ( surcharge_cost>0 ),

    classification VARCHAR2(10) CONSTRAINT nn_class NOT NULL
);

CREATE TABLE mov_lang (
    fk_cod_mov NUMBER(3),
    CONSTRAINT fk_codMovie FOREIGN KEY (fk_cod_mov) REFERENCES MOVIE(COD_MOVIE),

    fk_cod_category NUMBER(3),
    CONSTRAINT fk_codCategory FOREIGN KEY (fk_cod_category) REFERENCES CATEGORY(COD_CATEGORY),

    CONSTRAINT pk_movLang PRIMARY KEY (fk_cod_category, fk_cod_mov)
);

CREATE TABLE mov_act (
    fk_cod_mov NUMBER(3),
    CONSTRAINT fk_codMovieAct FOREIGN KEY (fk_cod_mov) REFERENCES MOVIE(COD_MOVIE),

    fk_cod_actor NUMBER(3),
    CONSTRAINT fk_codActor FOREIGN KEY (fk_cod_actor) REFERENCES ACTOR(COD_ACTOR),

    CONSTRAINT pk_movAct PRIMARY KEY (fk_cod_actor, fk_cod_mov)
);

CREATE TABLE mov_category (
    fk_cod_mov NUMBER(3),
    CONSTRAINT fk_codMovieCat FOREIGN KEY (fk_cod_mov) REFERENCES MOVIE(COD_MOVIE),

    mov_category NUMBER(3),
    CONSTRAINT fk_codMovCategory FOREIGN KEY (mov_category) REFERENCES CATEGORY(COD_CATEGORY),

    CONSTRAINT pk_movCat PRIMARY KEY (mov_category, fk_cod_mov)
);

CREATE TABLE rent (
    pay_date DATE,

    rent_date DATE,

    delivery_date DATE CONSTRAINT nn_deliveryDate NOT NULL,

    amount_pay NUMBER(8,2) CONSTRAINT nn_amounPay NOT NULL
                  CONSTRAINT chk_amountPay CHECK ( amount_pay>0 ),

    fk_idClient NUMBER(3) CONSTRAINT nn_FkIdClient NOT NULL,
    CONSTRAINT fk_idClientRent FOREIGN KEY (fk_idClient)
        REFERENCES USER_STORE(CODE_USER),

    fk_idWorker NUMBER(3) CONSTRAINT nn_FkIdWorker NOT NULL,
    CONSTRAINT fk_idWorkerRent FOREIGN KEY (fk_idWorker)
        REFERENCES USER_STORE(CODE_USER),

    fk_idMovie NUMBER(3) CONSTRAINT nn_FkIdMovie NOT NULL,
    CONSTRAINT fk_idMovieRent FOREIGN KEY (fk_idMovie)
        REFERENCES MOVIE(COD_MOVIE),

    CONSTRAINT pk_rent PRIMARY KEY (pay_date, rent_date)
);

CREATE TABLE inventory (
    cod_store NUMBER(3),
    CONSTRAINT fk_codStoreInv FOREIGN KEY (cod_store) REFERENCES STORE(COD_STORE),

    cod_movie NUMBER(3),
    CONSTRAINT fk_codMovInv FOREIGN KEY (cod_movie) REFERENCES MOVIE(COD_MOVIE),

    quantity NUMBER(10) CONSTRAINT nn_quantity NOT NULL,

    CONSTRAINT pk_inventory PRIMARY KEY (cod_movie, cod_store)
);

-- temp
CREATE TABLE Temp (
    NOMBRE_CLIENTE VARCHAR2(50),
    CORREO_CLIENTE VARCHAR2(50),
    CLIENTE_ACTIVO VARCHAR2(2),
    FECHA_CREACION VARCHAR2(20),
    TIENDA_PREFERIDA VARCHAR2(10),
    DIRECCION_CLIENTE VARCHAR2(50),
    CODIGO_POSTAL_CLIENTE VARCHAR2(5),
    CIUDAD_CLIENTE VARCHAR2(50),
    PAIS_CLIENTE VARCHAR2(25),
    FECHA_RENTA VARCHAR2(25),
    FECHA_RETORNO VARCHAR2(25),
    MONTO_A_PAGAR VARCHAR2(10),
    FECHA_PAGO VARCHAR2(25),
    NOMBRE_EMPLEADO VARCHAR2(30),
    CORREO_EMPLEADO VARCHAR2(50),
    EMPLEADO_ACTIVO VARCHAR2(2),
    TIENDA_EMPLEADO VARCHAR2(10),
    USUARIO_EMPLEADO VARCHAR2(20),
    CONTRASENA_EMPLEADO VARCHAR2(50),
    DIRECCION_EMPLEADO VARCHAR2(25),
    CODIGO_POSTAL_EMPLEADO VARCHAR2(5),
    CIUDAD_EMPLEADO VARCHAR2(20),
    PAIS_EMPLEADO VARCHAR2(25),
    NOMBRE_TIENDA VARCHAR2(10),
    ENCARGADO_TIENDA VARCHAR2(30),
    DIRECCION_TIENDA VARCHAR2(25),
    CODIGO_POSTAL_TIENDA VARCHAR2(5),
    CIUDAD_TIENDA VARCHAR2(20),
    PAIS_TIENDA VARCHAR2(25),
    TIENDA_PELICULA VARCHAR2(10),
    NOMBRE_PELICULA VARCHAR2(25),
    DESCRIPCION_PELICULA VARCHAR2(60),
    ANO_LANZAMIENTO VARCHAR2(5),
    DIAS_RENTA VARCHAR2(2),
    COSTO_RENTA VARCHAR2(7),
    DURACION VARCHAR2(4),
    COSTO_POR_DANO VARCHAR2(7),
    CLASIFICACION VARCHAR2(5),
    LENGUAJE_PELICULA VARCHAR2(20),
    CATEGORIA_PELICULA VARCHAR2(20),
    ACTOR_PELICULA VARCHAR2(25)
)

-- Ejecutar con:
-- sqlldr userid=TEST/1234 control=load.ctl
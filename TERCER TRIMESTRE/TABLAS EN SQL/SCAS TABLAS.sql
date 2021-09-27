create database SCAS;
use SCAS;

create table if not exists tipodocumento
(
id_tipodocumento int (10) primary key unique,
nombre varchar (20)

);


create table if not exists personas
(
id_persona int (10) primary key auto_increment,
id_tipodocumento int (10) not null,
numerodocumento bigint (15) unique not null,
nombres varchar (50),
apellidos varchar (50),
telefono bigint (20),
correo varchar (30),

constraint fk_tipoDocumento_personas
foreign key (id_tipodocumento)
references tipoDocumento (id_tipodocumento)

);


create table if not exists tipovehiculo
(
id_tipovehiculo int (10) primary key auto_increment,
tipo text (20) not null
);


create table if not exists marcavehiculo
(
id_marcavehiculo int (10) primary key auto_increment,
marca text (30) not null
);


create table if not exists opciones
(
id_opciones int (10) primary key auto_increment,
opcion text (20) not null
);


create table if not exists vehiculo
(
id_vehiculo int (10) primary key auto_increment,
id_tipovehiculo int (10) not null,
id_marcavehiculo int (10) not null,
color text (15),
placa varchar(10) not null unique,
soat text (15) not null,
tecnomecanica text (15) not null,
foto text (15),

constraint fk_marcaVehiculo_vehiculo
foreign key (id_marcavehiculo)
references marcaVehiculo (id_marcavehiculo),

constraint fk_tipovehiculo_vehiculo
foreign key (id_tipovehiculo)
references tipovehiculo (id_tipovehiculo)
);


create table if not exists cargoempleado
(
id_cargoempleado int (10) primary key auto_increment,
cargo text (20) not null
);

create table if not exists usuario
(
id_usuario int (10) primary key auto_increment,
id_persona int (10) not null,
nombre_user varchar (20) not null,
password_user varchar (20) not null,

constraint fk_personas_usuario
foreign key (id_persona)
references personas (id_persona)
);

create table if not exists empleado
(
id_empleado int (10) primary key auto_increment,
id_cargoempleado int (10) not null,
id_usuario int (10) not null,

constraint fk_cargoempleado_empleado
foreign key (id_cargoempleado)
references cargoempleado (id_cargoempleado),

constraint fk_usuario_empleado
foreign key (id_usuario)
references usuario (id_usuario)

);

create table if not exists franjahoraria
(
id_franjahoraria int (10) primary key auto_increment,
Hora_entrada time not null,
Hora_salida time not null
);

create table if not exists solicitud
(
id_solicitud int (10) primary key auto_increment,
id_usuario int (10) not null,
id_vehiculo int (10) not null,
id_franjahoraria int (10),

constraint fk_usuario_solicitud
foreign key (id_usuario)
references usuario (id_usuario),

constraint fk_vehiculo_solicitud
foreign key (id_vehiculo)
references vehiculo (id_vehiculo),

constraint fk_franjahoraria_solicitud
foreign key (id_franjahoraria)
references franjahoraria (id_franjahoraria)
);

create table if not exists espaciodeparqueo
(
id_espaciodeparqueo int (10) primary key auto_increment,
numero int (10) 
);

create table if not exists cupoasignado
(
id_cupoasignado int (10) primary key auto_increment,
id_espaciodeparqueo int (10),
id_solicitud int (10) not null,
fechaacceso time,

constraint fk_espaciodeparqueo_cupoAsignado
foreign key (id_espaciodeparqueo)
references espaciodeparqueo (id_espaciodeparqueo),

constraint fk_solicitud_cupoAsignado
foreign key (id_solicitud)
references solicitud (id_solicitud)
);


create table if not exists registro
(
id_registro int (10) primary key auto_increment unique,
fecha_registro date not null,
horaingreso time not null,
horasalida time,
id_usuario int (10) not null,
id_vehiculo int (10) not null,
id_cupoasignado int (10) not null,

constraint fk_usuario_registro
foreign key (id_usuario)
references usuario (id_usuario),

constraint fk_vehiculo_registro
foreign key (id_vehiculo)
references vehiculo (id_vehiculo),

constraint fk_cupoAsignado_registro
foreign key (id_cupoasignado)
references cupoAsignado (id_cupoasignado)

);


-- Insercion de datos tabla catalogo tipoducumento

insert into tipodocumento (Id_tipodocumento, nombre)
values (1,'Cedula de Ciudadania'),
	   (2,'Tarjeta de Identidad'),
       (3,'Pasaporte');
       
-- Insercion de datos tabla catalogo tipovehiculo

insert into tipovehiculo (Id_tipovehiculo, tipo)
values	(1,'Motocicleta'),
		(2,'Automovil'),
		(3,'Bicicleta');

-- Insercion de datos tabla catalogo cargoempleado

insert into cargoempleado (Id_cargoempleado, cargo)
values	(1,'Administrativo'),
        (2,'Vigilante');

-- Insercion de datos tabla catalogo cargoempleado

insert into marcavehiculo (Id_marcavehiculo, marca)
values	(1,'suzuki'),
        (2,'bajaj'),
        (3,'yamaha'),
        (4,'akt'),
        (5,'victory'),
        (6,'hero'),
        (7,'tvs'),
        (8,'kymco'),
        (9,'ktm'),
        (10,'honda'),
        (11,'renault'),
        (12,'mazda'),
        (13,'nissan'),
        (14,'kia'),
		(15,'toyota'),
        (16,'volkswagen'),
        (17,'hyundai'),
        (18,'ford'),
        (19,'bmw'),
        (20,'gw'),
		(21,'scott'),
        (22,'trek'),
		(23,'shimano'),
        (24,'canyon'),
        (25,'optimus');
        
               
       

     
               
	



		



create database SCAS;
use SCAS;

create table if not exists TipoDocumento
(

Id_tipodocumento int (10) primary key unique,
nombre varchar (20)

);


create table if not exists Personas
(
id_persona int (10) primary key auto_increment,
id_tipodocumento int (10) not null,
Numerodocumento int (15) unique not null,
nombres varchar (50),
apellidos varchar (50),
telefono int (20),
correo varchar (30),

constraint fk_tipoDocumento_personas
foreign key (id_tipodocumento)
references tipoDocumento (id_tipodocumento)

);


create table if not exists TipoVehiculo
(
Id_tipovehiculo int (10) primary key auto_increment,
tipo text (20) not null
);


create table if not exists MarcaVehiculo
(
Id_marcavehiculo int (10) primary key auto_increment,
marca text (30) not null
);


create table if not exists Vehiculo
(
Id_vehiculo int (10) primary key auto_increment,
Id_tipovehiculo int (10) not null,
Id_marcavehiculo int (10) not null,
color text (15),
placa varchar(10) not null unique,
soat text (15) not null,
tecnomecanica text (15) not null,
foto text (15),

constraint fk_MarcaVehiculo_Vehiculo
foreign key (Id_marcavehiculo)
references MarcaVehiculo (Id_marcavehiculo),

constraint fk_TipoVehiculo_Vehiculo
foreign key (Id_tipovehiculo)
references TipoVehiculo (Id_tipovehiculo)
);


create table if not exists CargoEmpleado
(
Id_cargoempleado int (10) primary key auto_increment,
cargo text (20) not null
);


create table if not exists Empleado
(
Id_empleado int (10) primary key auto_increment,
Id_cargoempleado int (10) not null,
Id_persona int (10) not null,

constraint fk_CargoEmpleado_Empleado
foreign key (Id_cargoempleado)
references CargoEmpleado (Id_cargoempleado),

constraint fk_Personas_Empleado
foreign key (Id_persona)
references Personas (Id_persona)

);


create table if not exists Usuario
(
Id_usuario int (10) primary key auto_increment,
Id_persona int (10) not null,
nombre_user varchar (20) not null,
password_user varchar (20) not null,

constraint fk_Personas_Usuario
foreign key (Id_persona)
references Personas (Id_persona)
);


create table if not exists Solicitud
(
Id_solicitud int (10) primary key auto_increment,
Id_usuario int (10) not null,
Id_vehiculo int (10) not null,

constraint fk_Usuario_Solicitud
foreign key (Id_usuario)
references Usuario (Id_usuario),

constraint fk_Vehiculo_Solicitud
foreign key (Id_vehiculo)
references Vehiculo (Id_vehiculo)

);


create table if not exists FranjaHoraria
(
Id_franjahoraria int (10) primary key auto_increment,
horaentrada datetime null,
horasalida datetime null
);


create table if not exists CupoAsignado
(
Id_cupoasignado int (10) primary key auto_increment,
numeroespacio int (10) not null,
Id_franjahoraria int (10) not null,
fechaacceso date not null,
Id_solicitud int (10) not null,

constraint fk_FranjaHoraria_CupoAsignado
foreign key (Id_franjahoraria)
references FranjaHoraria (Id_franjahoraria),

constraint fk_Solicitud_CupoAsignado
foreign key (Id_solicitud)
references Solicitud (Id_solicitud)

);


create table if not exists Registro
(
Id_registro int (10) primary key auto_increment unique,
fecha_registro date not null,
horaingreso time not null,
horasalida time,
Id_usuario int (10) not null,
Id_vehiculo int (10) not null,
Id_cupoasignado int (10) not null,

constraint fk_Usuario_Registro
foreign key (Id_usuario)
references Usuario (Id_usuario),

constraint fk_Vehiculo_Registro
foreign key (Id_vehiculo)
references Vehiculo (Id_vehiculo),

constraint fk_CupoAsignado_Registro
foreign key (Id_cupoasignado)
references CupoAsignado (Id_cupoasignado)

);

-- Proyecto formativo - Entrega 1.

insert into personas (Id_persona, Id_tipodocumento, Numerodocumento, nombres, apellidos, telefono, correo)
values (1,1234567801,'Luis Alberto','Flores Ramirez',3121234561,'lflores@gmail.com');

insert into tipodocumento (Id_tipodocumento, nombre)
values (1,'Cedula de Ciudadania');
       
insert into tipodocumento (Id_tipodocumento, nombre)
values	(2,'Tarjeta de Identidad'),
       (3,'Pasaporte');


insert into tipovehiculo (Id_tipovehiculo, tipo)
values	(1,'Motocicleta'),
       (2,'Automovil'),
       (3,'Bicicleta');
       
       
insert into cargoempleado (Id_cargoempleado, cargo)
values	(1,'Administrativo'),
       (2,'Vigilante');
       
       
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
        
insert into personas ( Id_tipodocumento, Numerodocumento, nombres, apellidos, telefono, correo)
values (1,1020433218,'Maicol','Cubillos',3174302138,'maicol@gmail.com');

-- Consultas

-- llamar al usuario por el documento
select * from pendientes
where idEstatusPendiente = 4;

-- que me arroje toda la info acerca de ese cupo 
        

        
       



























       
       
       
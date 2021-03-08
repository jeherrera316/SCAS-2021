create database SCAS;
use SCAS;

create table if not exists TipoDocumento
(

Id_tipodocumento int (10) primary key unique,
nombre varchar (20)

);


create table if not exists Personas
(
Id_persona int (10) primary key auto_increment,
Id_tipodocumento int (10),

constraint fk_TipoDocumento_Personas
foreign key (Id_tipodocumento)
references TipoDocumento (Id_tipodocumento),

Numerodocumento int (15) unique,
nombres varchar (50),
apellidos varchar (50),
telefono int (20) unique,
correo varchar (30) unique

);


create table if not exists TipoVehiculo
(
Id_tipovehiculo int (10) primary key auto_increment unique,
tipo text (20)
);


create table if not exists MarcaVehiculo
(
Id_marcavehiculo int (10) primary key auto_increment unique,
marca text (30)
);


create table if not exists Vehiculo
(
Id_vehiculo int (10) primary key auto_increment unique,
Id_tipovehiculo int (10),

constraint fk_TipoVehiculo_Vehiculo
foreign key (Id_tipovehiculo)
references TipoVehiculo (Id_tipovehiculo),

Id_marcavehiculo int (10),

constraint fk_MarcaVehiculo_Vehiculo
foreign key (Id_marcavehiculo)
references MarcaVehiculo (Id_marcavehiculo),

color text (15),
placa varchar (10),
soat text (15),
tecnomecanica text (15),
foto text (15)

);


create table if not exists CargoEmpleado
(
Id_cargoempleado int (10) primary key auto_increment unique,
cargo text (20)
);


create table if not exists Empleado
(
Id_empleado int (10) primary key auto_increment unique,
Id_cargoempleado int (10),

constraint fk_CargoEmpleado_Empleado
foreign key (Id_cargoempleado)
references CargoEmpleado (Id_cargoempleado),

Id_persona int (10),

constraint fk_Personas_Empleado
foreign key (Id_persona)
references Personas (Id_persona)

);


create table if not exists Usuario
(
Id_usuario int (10) primary key auto_increment unique,
Id_persona int (10),

constraint fk_Personas_Usuario
foreign key (Id_persona)
references Personas (Id_persona),

certificado varchar (30)
);


create table if not exists Solicitud
(
Id_solicitud int (10) primary key auto_increment unique,
Id_usuario int (10),

constraint fk_Usuario_Solicitud
foreign key (Id_usuario)
references Usuario (Id_usuario),

Id_vehiculo int (10),

constraint fk_Vehiculo_Solicitud
foreign key (Id_vehiculo)
references Vehiculo (Id_vehiculo)

);


create table if not exists FranjaHoraria
(
Id_franjahoraria int (10) primary key,
horaentrada datetime,
horasalida datetime
);


create table if not exists CupoAsignado
(
Id_cupoasignado int (10) primary key auto_increment,
numeroespacio int (10),
Id_franjahoraria int (10),

constraint fk_FranjaHoraria_CupoAsignado
foreign key (Id_franjahoraria)
references FranjaHoraria (Id_franjahoraria),

fechaacceso date,
Id_solicitud int (10),

constraint fk_Solicitud_CupoAsignado
foreign key (Id_solicitud)
references Solicitud (Id_solicitud)

);


create table if not exists Registro
(
Id_registro int (10) primary key auto_increment unique,
fecha date,
horaingreso time,
horasalida time,
Id_usuario int (10),

constraint fk_Usuario_Registro
foreign key (Id_usuario)
references Usuario (Id_usuario),

Id_vehiculo int (10),

constraint fk_Vehiculo_Registro
foreign key (Id_vehiculo)
references Vehiculo (Id_vehiculo),

Id_cupoasignado int (10),

constraint fk_CupoAsignado_Registro
foreign key (Id_cupoasignado)
references CupoAsignado (Id_cupoasignado)

);
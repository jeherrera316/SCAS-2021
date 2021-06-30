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
fechaacceso date,

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


-- Insercion datos tabla catalogo tipodocumento

insert into tipodocumento (Id_tipodocumento, nombre)
values (1,'Cedula de Ciudadania'),
 	   (2,'Tarjeta de Identidad'),
       (3,'Pasaporte');

-- Insercion datos tabla catalogo tipovehiculo 

insert into tipovehiculo (Id_tipovehiculo, tipo)
values	(1,'Motocicleta'),
       (2,'Automovil'),
       (3,'Bicicleta');
       
-- Insercion datos tabla catalogo cargoempleado

insert into cargoempleado (Id_cargoempleado, cargo)
values	(1,'Administrativo'),
       (2,'Vigilante');
       
	
-- Insercion datos tabla catalogo marcavehiculo 

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
        
-- Insercion de datos a la tabla personas

insert into personas(id_tipodocumento, numerodocumento, nombres, apellidos, telefono, correo)
values (1,1784654534,'juan josŽ','berrocal herrero',7516812532,'jose@gmail.com'),
		(1,7813412410,'miguel angel','abril igo',6838781709,'miguel@gmail.com'),
		(1,6565420984,'juan sebastian','gamero esquinas',7536115521,'juan@gmail.com'),
		(1,6842444213,'samuel david','mora salmeron',8297249152,'samul@gmail.com'),
		(1,6193257220,'juan david','barrionuevo serna',8650728274,'david@gmail.com'),
		(2,8527279962,'juan pablo','peralta del rosario',6942481400,'pablo@gmail.com'),
		(2,6871918110,'juan diego','huerta novas',800319208,'diego@gmail.com'),
		(2,7190549934,'angel david','cubillo fabra',8662018114,'angel@gmail.com'),
		(1,7506192909,'juan esteban', 'casanova vadillo',8797470165,'esteban@gmail.com'),
		(1,679376654,'andres felipe','insua aguilera',6346106865,'felipe@gmail.com'),
		(1,7245254625,'maria jose','solsona rial',6646113781,'maria@gmail.com'),
		(2,6510797613,'maria','cuadrado duro',6724794721,'mariac@gmail.com'),
		(1,660855102,'maria teresa','monreal sanz',8829286670,'teresa@gmail.com'),
		(1,783468518,'juan antonio ','mangas cuellar',6529995066,'antonio@gmail.com'),
		(1,1453297227,'adrian ','pelayo grande',8154848652,'adrianc@gmail.com'),
		(1,6166775382,'jose ignacio','lemos arrizabalaga',8617339775,'ignacio@gmail.com'),
		(2,818891718,'antonio ','canovas giron',6991046203,'antonioc@gmail.com'),
		(1,785189642,'jose antonio', 'suero mateo',8692824221,'antonio@gmail.com'),
		(1,7510204092,'andrea', 'seijas naranjo',8268361500,'andreac@gmail.com'),
		(1,2764754534,'sandra','lopez cruz',4566761500,'sandra@gmail.com');
               
     
-- Insercion de datos a la tabla espaciodeparqueo

insert into espaciodeparqueo (numero)
values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
		(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);               

-- Orden de importar tablas: usuario, vehiculo, franjahoraria, empleado, solicitud, cupoasignado, registro
-- actualizar usuarios 

SET SQL_SAFE_UPDATES = 0;

		



use scas;


-- CONTEO DE LAS PERSONAS REGISTRADAS --

SELECT count(*)
FROM PERSONAS;

-- MOSTRAR CUANTOS USUARIOS INGRESAN EN CIERTA FRANJA DE TIEMPO--

select * 
from registro 
where horaingreso between '06:00:00' and '10:00:00';

-- MOSTRAR EL TIPO DE VEHICULO QUE TIENE EL USUARIO --

SELECT P.nombres, P.apellidos, S.id_vehiculo, V.id_tipovehiculo, TV.tipo
FROM personas P
INNER JOIN usuario U USING (id_persona)
INNER JOIN solicitud S USING (id_usuario)
INNER JOIN vehiculo V USING (id_vehiculo)
INNER JOIN tipovehiculo TV USING (Id_tipovehiculo);


--  usuario, vehiculo que tiene, parqueadero asignado

select us.*, sd.id_vehiculo, cp.id_espaciodeparqueo, sp.numero
from usuario us
join solicitud sd using (id_usuario)
join cupoasignado cp using (id_solicitud)
join espaciodeparqueo sp using (id_espaciodeparqueo);


-- saber el tipo y marca del vehiculo del usuario

SELECT P.nombres, P.apellidos,TV.tipo,  MV.marca
FROM personas P
INNER JOIN usuario U USING (id_persona)
INNER JOIN solicitud S USING (id_usuario)
INNER JOIN vehiculo V USING (id_vehiculo)
INNER JOIN tipovehiculo TV USING (Id_tipovehiculo)
INNER JOIN marcavehiculo MV USING (id_marcavehiculo);

-- saber el espacio de parqueo --

SELECT * 
FROM cupoasignado CA 
INNER JOIN espaciodeparqueo EP USING (id_espaciodeparqueo);

-- busqueda de vehIculo por color --

SELECT *
FROM vehiculo 
where color = 'negro';

-- EN QUE NUMERO DE PARQUEO ESTA EL USUARIO --

SELECT P.id_persona, P.nombres, P.apellidos, EP.numero
FROM personas P
INNER JOIN usuario U USING (id_persona)
INNER JOIN registro R USING (id_usuario)
INNER JOIN cupoasignado CA USING (id_cupoasignado)
INNER JOIN espaciodeparqueo EP USING (id_espaciodeparqueo)
WHERE id_persona = 5;


-- CONTEO DE LAS FRANJAS HORARIAS DE LAS SOLICITUDES --

select count(id_franjahoraria) as total from solicitud
where id_franjahoraria = 3;


-- CONSULTAR LA HORA DE INGRESO CON EL RESPECTIVO NUMERO DE PARQUEO Y EL USUARIO --

select R.id_registro, R.fecha_registro, R.horaingreso, R.horasalida, EP.numero, P.numerodocumento, P.nombres, P.apellidos
from registro R
inner join cupoasignado CA using (id_cupoasignado)
inner join espaciodeparqueo EP using (id_espaciodeparqueo)
inner join usuario U using (id_usuario)
inner join personas P using (id_persona)
where R.horaingreso between '06:00:00' and '10:00:00';


-- SOLICTUDES POR FRANJA HORARIA, CON SU USUARIO Y VEHICULO --

select S.id_solicitud, FH.id_franjahoraria, FH. hora_entrada, FH.hora_salida, P.numerodocumento, P.nombres, P.apellidos, TV.tipo, MV.marca
from solicitud S
inner join franjahoraria FH using (id_franjahoraria)
inner join usuario U using (id_usuario)
inner join personas P using (id_persona)
inner join vehiculo V using (id_vehiculo) 
inner join tipovehiculo TV using (id_tipovehiculo)
inner join marcavehiculo MV using (id_marcavehiculo)
order by FH.id_franjahoraria;


-- JORNADA EN LA QUE REQUIERE LA SOLICITUD --
select S.id_solicitud, FH.id_franjahoraria, FH. hora_entrada, FH.hora_salida, P.numerodocumento, P.nombres, P.apellidos, TV.tipo, MV.marca,
(case
when FH.hora_entrada = '06:00:00' then 'JORNADA DIURNA'
when FH.hora_entrada = '12:00:00' then 'JORNADA TARDE'
when FH.hora_entrada = '18:00:00' then 'JORNADA NOCTURNA'
end) as Jornada
from solicitud S
inner join franjahoraria FH using (id_franjahoraria)
inner join usuario U using (id_usuario)
inner join personas P using (id_persona)
inner join vehiculo V using (id_vehiculo) 
inner join tipovehiculo TV using (id_tipovehiculo)
inner join marcavehiculo MV using (id_marcavehiculo)
order by FH.id_franjahoraria;


-- CREACION VISTA VEHICULO QUE POSEE EL USUARIO --

create view Vehiculo_del_usuario
as
SELECT P.nombres, P.apellidos, S.id_vehiculo, V.id_tipovehiculo, TV.tipo
FROM personas P
INNER JOIN usuario U USING (id_persona)
INNER JOIN solicitud S USING (id_usuario)
INNER JOIN vehiculo V USING (id_vehiculo)
INNER JOIN tipovehiculo TV USING (Id_tipovehiculo);

select * from Vehiculo_del_usuario;


-- CREACION VISTA NUMERO DE PARQUEO --
create view Numero_de_parqueo
as
select us.*, sd.id_vehiculo, cp.id_espaciodeparqueo, sp.numero
from usuario us
join solicitud sd using (id_usuario)
join cupoasignado cp using (id_solicitud)
join espaciodeparqueo sp using (id_espaciodeparqueo);

select * from Numero_de_parqueo;



-- PROCEDIMIENTOS ALMACENADOS --

-- CREARCION SP PARA REGISTRAR PERSONAS --

DELIMITER //
create procedure SP_InsertarPersonas (
in in_id_tipodocumento int (10),
in in_numerodocumento bigint (15),
in in_nombres varchar (50),
in in_apellidos varchar (50),
in in_telefono bigint (20),
in in_correo varchar (30)
)
begin

insert into personas (id_tipodocumento, numerodocumento, nombres, apellidos, telefono, correo)
values               (in_id_tipodocumento, in_numerodocumento, in_nombres, in_apellidos, in_telefono, in_correo);


end //
DELIMITER ;

call SP_InsertarPersonas (1, 1076623989, 'Carlos Andres', 'Quintero Camacho', 3133369585, 'cquintero@gmail.com');


-- CREACION DE SP PARA ELIMINAR A UNA PERSONA -- 

DELIMITER // 
create procedure SP_EliminacionPersonas (
in in_numerodocumento bigint (15)
)
begin 

delete
from personas  
where numerodocumento = in_numerodocumento;


end // 
DELIMITER ; 

call SP_EliminacionPersonas (1076623989);


-- SP COMO PARAMETRO DE ENTRADA EL ID PERONA, PARA VALIDAR EL VEHICULO Y SU MARCA --

DELIMITER //
create procedure SP_Vehiculo_del_usuario (
in in_id_persona int (10)
)
begin

select P.numerodocumento, P.nombres, P.apellidos, TV.tipo, MV.marca
from personas P
inner join usuario U using (id_persona)
inner join solicitud S using (id_usuario)
inner join vehiculo V using (id_vehiculo)
inner join tipovehiculo TV using (Id_tipovehiculo)
inner join marcavehiculo MV using (id_marcavehiculo)
where id_persona = in_id_persona;

end //
DELIMITER ; 

call SP_Vehiculo_del_usuario (10);

-- SP con parametro de entrada el id del empleado y que me arroje que cargo tiene -- 

DELIMITER //
create procedure SP_Cargo_Empleado(
in in_id_empleado int (10),
out out_cargo tinytext 
 )
begin

select CE.cargo
into out_cargo
from empleado E
inner join cargoempleado CE using (id_cargoempleado)
inner join usuario U using (id_usuario)
where id_empleado = in_id_empleado;

end //
DELIMITER ; 

call SP_Cargo_Empleado (5, @out_cargo);
select @out_cargo as cargo;


-- SP CON PARAMETRO DE ENTRADA NUMERO DE DOCUNENTO PARA VALIDAR LA HORA DE INGRESO --

DELIMITER //
create procedure SP_Hora_de_Ingreso (
in in_numerodocumento bigint (15)
)
begin

select R.fecha_registro, R.horaingreso, R.horasalida, EP.numero, P.numerodocumento, P.nombres, P.apellidos
from registro R
inner join cupoasignado CA using (id_cupoasignado)
inner join espaciodeparqueo EP using (id_espaciodeparqueo)
inner join usuario U using (id_usuario)
inner join personas P using (id_persona)
where P. numerodocumento = in_numerodocumento;

end //
DELIMITER ; 

call SP_hora_de_ingreso (7813412410);


-- SP CONTEO DE VEHICULOS REGISTRADOS --

DELIMITER //
create procedure SP_total_tipo_vehiculo_registrado (
in in_tipovehiculo tinytext,
out out_tipo tinytext 
)
begin

select count(*)
into out_tipo
from registro R
inner join  vehiculo V using (id_vehiculo)
inner join tipovehiculo TV using (id_tipovehiculo)
where tv.tipo = in_tipovehiculo;


end //
DELIMITER ; 

call SP_total_tipo_vehiculo_registrado ('motocicleta', @out_tipo);
select @out_tipo as total_registro;




DELIMITER //
create procedure SP_Cupo_Persona (
in in_numerocupo int (10)
)
begin

select P.numerodocumento, concat(P.nombres, ' ', P.apellidos) as nombres_apellidos
from espaciodeparqueo EP
inner join cupoasignado CA using (id_espaciodeparqueo)
inner join solicitud S using (id_solicitud)
inner join usuario U using (id_usuario)
inner join personas P using (id_persona)
where EP.numero = in_numerocupo;

end //
DELIMITER ; 

call SP_Cupo_Persona (11);















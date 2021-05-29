select * from registro
where id_registro = 4;

SELECT count(*)
FROM PERSONAS;

SELECT P.nombres, P.apellidos, S.id_vehiculo, V.id_tipovehiculo, TV.tipo
FROM personas P
INNER JOIN usuario U USING (id_persona)
INNER JOIN solicitud S USING (id_usuario)
INNER JOIN vehiculo V USING (id_vehiculo)
INNER JOIN tipovehiculo TV USING (Id_tipovehiculo);

--  usuario, vehiculo que tiene, parqueadero asignado, franja horaria

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

SELECT * 
FROM cupoasignado CA 
INNER JOIN espaciodeparqueo EP USING (id_espaciodeparqueo);

SELECT *
FROM vehiculo 
where color = 'negro';
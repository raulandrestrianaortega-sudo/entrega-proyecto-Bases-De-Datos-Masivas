CREATE KEYSPACE mensajeria
WITH replication = {
'class':'SimpleStrategy',
'replication_factor':3
};

USE mensajeria;

CREATE TABLE mensajes (
chat_id UUID,
timestamp TIMESTAMP,
usuario_id UUID,
mensaje TEXT,
PRIMARY KEY (chat_id, timestamp)
);

INSERT INTO mensajes (chat_id, timestamp, usuario_id, mensaje)
VALUES (uuid(), toTimestamp(now()), uuid(), 'Hola este es el primer mensaje');

INSERT INTO mensajes (chat_id, timestamp, usuario_id, mensaje)
VALUES (uuid(), toTimestamp(now()), uuid(), 'Mensaje numero 2');

INSERT INTO mensajes (chat_id, timestamp, usuario_id, mensaje)
VALUES (uuid(), toTimestamp(now()), uuid(), 'Mensaje numero 3');

SELECT * FROM mensajes;

# entrega-proyecto-Bases-De-Datos-Masivas
PS C:\Users\ASUS> docker run --name cassandra-db -p 9042:9042 -d cassandra
PS C:\Users\ASUS> docker exec -it cassandra-db cqlsh
Connection error: ('Unable to connect to any servers', {'127.0.0.1:9042': ConnectionRefusedError(111, "Tried connecting to [('127.0.0.1', 9042)]. Last error: Connection refused")})
PS C:\Users\ASUS> docker exec -it cassandra-db cqlsh
Connected to Test Cluster at 127.0.0.1:9042
[cqlsh 6.2.0 | Cassandra 5.0.6 | CQL spec 3.4.7 | Native protocol v5]
Use HELP for help.
cqlsh> CREATE KEYSPACE mensajeria
   ... WITH replication = {
   ... 'class':'SimpleStrategy',
   ... 'replication_factor':3
   ... };

Warnings :
Your replication factor 3 for keyspace mensajeria is higher than the number of nodes 1

cqlsh> DESCRIBE KEYSPACES;

mensajeria  system_auth         system_schema  system_views
system      system_distributed  system_traces  system_virtual_schema

cqlsh> USE mensajeria;
cqlsh:mensajeria> CREATE TABLE mensajes (
              ... chat_id UUID,
              ... timestamp TIMESTAMP,
              ... usuario_id UUID,
              ... mensaje TEXT,
              ... PRIMARY KEY (chat_id, timestamp)
              ... );
cqlsh:mensajeria> DESCRIBE TABLES;

mensajes

cqlsh:mensajeria> INSERT INTO mensajes (chat_id, timestamp, usuario_id, mensaje)
              ... VALUES (uuid(), toTimestamp(now()), uuid(), 'Hola este es el primer mensaje');
cqlsh:mensajeria> INSERT INTO mensajes (chat_id, timestamp, usuario_id, mensaje)
              ... VALUES (uuid(), toTimestamp(now()), uuid(), 'Mensaje numero 2');
cqlsh:mensajeria> INSERT INTO mensajes (chat_id, timestamp, usuario_id, mensaje)
              ... VALUES (uuid(), toTimestamp(now()), uuid(), 'Mensaje numero 3');
cqlsh:mensajeria> SELECT * FROM mensajes;

 chat_id                              | timestamp                       | mensaje                        | usuario_id
--------------------------------------+---------------------------------+--------------------------------+--------------------------------------
 11afb2ea-999f-4fe8-b3af-8e60ac3d97c6 | 2026-03-20 21:30:17.599000+0000 | Hola este es el primer mensaje | f4355d7b-bf7b-4dd2-94e2-281ae8924250
 08c7da92-a7d2-43d9-8bc2-49ef05cbae69 | 2026-03-20 21:30:28.369000+0000 |               Mensaje numero 3 | 6c2a0457-dbae-4e73-a529-b55fb0706990
 6fa756e7-df5e-45bb-9f8b-58ad1f74bcc1 | 2026-03-20 21:30:22.970000+0000 |               Mensaje numero 2 | 3abb7679-102a-4dd7-ad82-c4bc711eb2df

(3 rows)
cqlsh:mensajeria> UPDATE mensajes
              ... SET mensaje = 'Mensaje actualizado'
              ... WHERE chat_id = 6e03aa13-3a24-4ede-93cf-486cb0ede6c7
              ... AND timestamp = '2026-03-12 22:05:38.049000+0000';
cqlsh:mensajeria> DELETE FROM mensajes
              ... WHERE chat_id = 227f547b-2df0-4a1c-b1ff-4dea1de078e2
              ... AND timestamp = '2026-03-12 22:06:56.517000+0000';
cqlsh:mensajeria> DESCRIBE TABLE mensajes;

CREATE TABLE mensajeria.mensajes (
    chat_id uuid,
    timestamp timestamp,
    mensaje text,
    usuario_id uuid,
    PRIMARY KEY (chat_id, timestamp)
) WITH CLUSTERING ORDER BY (timestamp ASC)
    AND additional_write_policy = '99p'
    AND allow_auto_snapshot = true
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND cdc = false
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '16', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND memtable = 'default'
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND incremental_backups = true
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99p';
cqlsh:mensajeria> exit

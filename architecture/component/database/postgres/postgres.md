# PostgreSQL设置自增长从当前最大值开始
select setval('tablename_id_seq',(select max(id) from tablename))
将tablename换成具体的表名即可
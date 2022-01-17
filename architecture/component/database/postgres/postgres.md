# PostgreSQL设置自增长从当前最大值开始
select setval('tablename_id_seq',(select max(id) from tablename))
将tablename换成具体的表名即可

# 备份数据库
pg_dump -h localhost -p 5432 -U emspf -d emspf_debug -f "C:\Users\iwase\Desktop\emspf_20211213_059ban.backup"

# 恢复数据库
psql -h localhost -p 5432 -U emspf -d emspf_debug -f "C:\Users\iwase\Desktop\emspf_20211213_059ban.backup"
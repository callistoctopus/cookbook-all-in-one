# 参考链接
https://dev.mysql.com/doc/c-api/8.0/en/c-api-function-reference.html
https://www.mysqlzh.com/api/25.html

# 连接数据库
mysql_init()                获取或初始化MYSQL结构。
mysql_real_connect()        连接到MySQL服务器。
mysql_close()               关闭服务器连接。

# 获取数据库错误
mysql_errno()               返回上次调用的MySQL函数的错误编号。
mysql_error()               返回上次调用的MySQL函数的错误消息。

# 执行SQL
mysql_query()               执行指定为“以Null终结的字符串”的SQL查询。

mysql_store_result()        检索完整的结果集至客户端。
mysql_use_result()          初始化逐行的结果集检索。

mysql_num_fields()          返回结果集中的列数。
mysql_num_rows()            返回结果集中的行数。

mysql_fetch_field()         返回下一个表字段的类型。            MYSQL_FIELD * mysql_fetch_field(MYSQL_RES *result)

mysql_data_seek()           在查询结果集中寻找任意行。 
mysql_fetch_row()           检索结果集的下一行。       

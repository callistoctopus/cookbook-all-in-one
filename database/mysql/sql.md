
## 数据查询语言**DQL**
```
SELECT 字段名表  FROM 表或视图名  WHERE 查询条件
```

## 数据操纵语言**DML**
```
插入：INSERT  
更新：UPDATE  
删除：DELETE  
```

## 数据定义语言**DDL**
```
CREATE TABLE/VIEW/INDEX/SYN/CLUSTER
```

## 数据控制语言**DCL**
```
 GRANT：授权。  
 ROLLBACK [WORK] TO [SAVEPOINT]：回退到某一点。  
 COMMIT [WORK]：提交。 
 ```
*** 

**显式提交**  
用COMMIT命令直接完成的提交为显式提交。其格式为：
```
SQL>COMMIT；
```
**隐式提交**  
用SQL命令间接完成的提交为隐式提交。这些命令是：
```
ALTER，AUDIT，COMMENT，CONNECT，CREATE，DISCONNECT，DROP，
EXIT，GRANT，NOAUDIT，QUIT，REVOKE，RENAME。
```
**自动提交**  
若把AUTOCOMMIT设置为ON，则在插入、修改、删除语句执行后，
系统将自动进行提交，这就是自动提交。其格式为：
```
SQL>SET AUTOCOMMIT ON；
```

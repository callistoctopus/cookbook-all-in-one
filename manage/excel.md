# 使用excel画曲线图
https://jingyan.baidu.com/article/e2284b2b371481e2e6118d83.html

# excel if 表达式
 IF(logical_test,value_if_true,value_if_false)

# 获取Sheet名表达式
=RIGHT(CELL("filename",A1),LEN(CELL("filename",A1))-FIND("]",CELL("filename",A1)))
# QMap介绍与使用

## 定义
QMap<QString,QString> m_map; 

## 判断是否为空
m_map.isEmpty()

## 是否包含某一key
m_map.contains("222") 

## 添加键值对
m_map.insert("222", "bbb"); 
m_map["333"] = "ccc";

## 遍历
QMap<QString,QString>::iterator it; //遍历map  
for ( it = m_map.begin(); it != m_map.end(); ++it ) {  
    qDebug( "%s: %s", it.key(), it.value()); //用key()value()分别获取“键”和“值”  
} 


# QFile
QFile file(filePath);
if (file.exists())
{
    if(file.remove())
    {
        qDebug() << "删除成功";
    }
    else
    {
        qDebug() << "删除失败";
    }
}

# 预定义标识符
函数名: __FUNCSIG__   返回完整的函数类型、所属类名、函数名、函数参数列表。
函数名: __FUNCTION__  返回所属类名、函数名。
函数名: __FUNCDNAME__ 返回装饰后的所属类名、函数名等。 （Decorated function name）
当前函数名: __func__   返回函数名。
当前文件名: __FILE__   返回当前源代码文件名。
当前代码行数: __LINE__ 返回当前代码行数（源代码文件中的所在行数）。

# 添加Q_OBJECT后编译报错
重新qmake
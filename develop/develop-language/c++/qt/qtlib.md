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
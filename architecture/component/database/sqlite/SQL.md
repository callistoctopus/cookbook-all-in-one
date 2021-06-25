# 检索结果保留小数

    SELECT
        battery_no AS batteryNo,
        ((time_series * time_interval)/1000.0) AS T3,
        vol_Slope AS Y
    FROM
        module_battery_data_info
    WHERE
        module_type = 'FN123'
        AND battery_code = '123456789001'
        AND test_seq = '0'

# strftime()函数
strftime()函数可以把YYYY-MM-DD HH:MM:SS格式的日期字符串转换成其它形式的字符串。
strftime()的语法是strftime(格式, 日期/时间, 修正符, 修正符, …)

%d 日期, 01-31
%f 小数形式的秒，SS.SSS
%H 小时, 00-23
%j 算出某一天是该年的第几天，001-366
%m 月份，00-12
%M 分钟, 00-59
%s 从1970年1月1日到现在的秒数
%S 秒, 00-59
%w 星期, 0-6 (0是星期天)
%W 算出某一天属于该年的第几周, 01-53
%Y 年, YYYY
%% 百分号

select strftime(‘%Y-%m’,日期)
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
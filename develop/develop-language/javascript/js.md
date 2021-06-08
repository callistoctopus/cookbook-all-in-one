## AngularJS
https://angular.io/  

# BootstrapTable请求数据时设置超时(timeout)的方法
$("#event_table").bootstrapTable({
 url: urlAddr,
 ajaxOptions: {async:true,timeout:5000},
});
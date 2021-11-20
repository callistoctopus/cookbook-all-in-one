☆

https://www.odoo.com/zh_CN/

Odoo大V社-odoo中文开发手册 
http://www.odoov.com/index.php?title=%E9%A6%96%E9%A1%B5

odoo框架如何深入理解? - 知乎
https://registry.hub.docker.com/_/odoo

# 第三方应用市场
https://apps.odoo.com/apps
https://apps.odoo.com/apps/modules/14.0/dhx_gantt/

10M 20211018

docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name db postgres:13
docker run -p 8069:8069 --name odoo  -v $PWD/addons:/mnt/extra-addons --link db:db -t odoo:14
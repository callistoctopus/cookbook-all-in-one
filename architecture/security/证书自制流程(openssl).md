# 证书自制流程
1. 模拟证书颁发中心(CA)  
  · 创建根证书库(自签)(包含私钥和自签证书)  
  · 导出证书(公钥)

2. 待认证的端末生成请求证书(公钥)  
   · 创建服务端证书库(包含私钥和自签证书)  
   · 创建客户端证书库(包含私钥和自签证书)  
   · 服务端发起证书认证请求(公钥)  
   · 客户端发起证书认证请求(公钥)

3. 模拟证书颁发中心认证请求证书(用CA私钥对请求证书(公钥)签名)  
   · 根证书颁发(签名认证)服务端请求  
   · 根证书颁发(签名认证)客户端请求

4. 将已颁发的证书添加到发出请求的证书库  
   · 服务端证书库添加根证书  
   · 客户端证书库添加根证书  
   · 服务端添加已认证的服务端证书  
   · 客户端添加已认证的客户端证书 

5. 端末间相互信任  
   · 服务端信任客户端  
   · 客户端信任服务端  



## 模拟证书颁发中心(CA) 

### 生成根证书私钥(key文件)                                          
openssl genrsa -out ca.key 2048 
<openssl genrsa -out ca.key 3072>     
                     
### 生成根证书签发申请文件(csr文件) 

openssl req -new -key ca.key -out ca.csr -subj "/C=CN/ST=zj/L=hz/O=fuji/OU=hzfuji/CN=SEJ CA" 
<openssl req -new -key ca.key -out ca.csr -subj "/C=CN/ST=ZJ/L=HZ/O=narada/OU=narada.internet/CN=NARADA CA">

### 自签发根证书(cer文件)
openssl x509 -req -days 365 -sha1 -extensions v3_ca -signkey ca.key -in ca.csr -out ca.cer
<openssl x509 -req -days 365 -sha256 -extensions v3_ca -signkey ca.key -in ca.csr -out ca.cer -extfile /usr/lib/ssl/openssl.cnf>

### 查看证书
<openssl x509 -noout -text -in ca.cer>



## 待认证的端末生成请求证书(公钥)

### 生成服务端私钥
openssl genrsa -out server.key 2048  
<openssl genrsa -out server.key 2048>

### 生成证书请求文件
openssl req -new -key server.key -out server.csr -subj "/C=CN/ST=zj/L=hz/O=fuji/OU=hzfuji/CN=10.225.143.145"
<openssl req -new -key server.key -out server.csr -subj "/C=CN/ST=ZJ/L=HZ/O=narada/OU=narada.internet/CN=EMS">

### 生成客户端私钥
openssl genrsa -out client.key 2048
<openssl genrsa -out client.key 2048>

### 生成证书请求文件
openssl req -new -key client.key -out client.csr -subj "/C=CN/ST=zj/L=hz/O=fuji/OU=hzfuji/CN=gui-qi"
<openssl req -new -key client.key -out client.csr -subj "/C=CN/ST=ZJ/L=HZ/O=narada/OU=narada.internet/CN=endpoint-001">




## 模拟证书颁发中心认证请求证书(用CA私钥对请求证书(公钥)签名)  

### 使用根证书签发服务端证书
openssl x509 -req -days 365 -sha1 -extensions v3_req -CA ca.cer -CAkey ca.key -CAserial ca.srl -CAcreateserial -in server.csr -out server.cer
<openssl x509 -req -days 365 -sha256 -extensions v3_req -CA ca.cer -CAkey ca.key -CAserial ca.srl -CAcreateserial -in server.csr -out server.cer -extfile /usr/lib/ssl/openssl.cnf>

### 使用CA证书验证server端证书
openssl verify -CAfile ca.cer  server.cer
<openssl verify -CAfile ca.cer  server.cer>

### 查看证书
<openssl x509 -in server.cer -text -noout>

### 使用根证书签发客户端证书
openssl x509 -req -days 365 -sha1 -extensions v3_req -CA ca.cer -CAkey ca.key -CAserial ca.srl -CAcreateserial -in client.csr -out client.cer
<openssl x509 -req -days 365 -sha256 -extensions v3_req -CA ca.cer -CAkey ca.key -CAserial ca.srl -CAcreateserial -in client.csr -out client.cer -extfile /usr/lib/ssl/openssl.cnf>

### 使用CA证书验证client端证书
openssl verify -CAfile ca.cer  client.cer
<openssl verify -CAfile ca.cer  client.cer>

### 查看证书
<openssl x509 -in client.cer -text -noout>



### 生成浏览器接受的证书
openssl pkcs12 -export -inkey client.key -in client.cer -out client.p12
<openssl pkcs12 -export -inkey client.key -in client.cer -out client.p12>



## 端末间相互信任 

### 服务端配置（nginx）
```
server {
		#listen       8081;
        listen       8082 ssl;
        server_name  localhost;
		
		ssl_certificate      ../crt/server.cer;
		ssl_certificate_key  ../crt/server.key;
		
		ssl_protocols SSLv2 SSLv3 TLSv1;
		
		ssl_session_cache    shared:SSL:1m;
		ssl_session_timeout  5m;
		
		ssl_ciphers  HIGH:!aNULL:!MD5;
		ssl_prefer_server_ciphers  on;
		
		ssl_client_certificate ../crt/ca.cer;
		
		ssl_verify_client on;

        location / {
			proxy_pass http://192.168.168.202:80;
        }
		
		location /tomcat/ {
			proxy_pass http://localhost:8080/;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }
```

<
```
server {
		listen       443 ssl;
		server_name  localhost;
		
		ssl_certificate      /etc/nginx/cert/server.cer;
		ssl_certificate_key  /etc/nginx/cert/server.key;
		
		# ssl_protocols SSLv2 SSLv3 TLSv1;
		ssl_protocols SSLv2 SSLv3 TLSv1 TLSv1.1 TLSv1.2;
		
		ssl_session_cache    shared:SSL:1m;
		ssl_session_timeout  5m;
		
		ssl_ciphers  HIGH:!aNULL:!MD5;
		ssl_prefer_server_ciphers  on;
		
		ssl_client_certificate /etc/nginx/cert/ca.cer;
		
		ssl_verify_client on;

		location / {
			proxy_cookie_domain 10.10.111.203 $host; 
			proxy_pass http://10.10.111.203:8091;
		}

		#error_page  404              /404.html;

		# redirect server error pages to the static page /50x.html
		#
		error_page   500 502 503 504  /50x.html;
		location = /50x.html {
			root   html;
		}
```
>
### 客户端配置

### 安装根证书<ca.cer>

### 安装客户端证书<client.p12>



### openssl.conf配置

```
[ v3_req ]

# Extensions to add to a certificate request

basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
IP.1 = 10.10.111.151
```

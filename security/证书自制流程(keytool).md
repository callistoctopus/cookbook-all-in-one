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

***
## 模拟证书颁发中心(CA)  

### 创创建根证书库(自签)(包含私钥和自签证书) 
```
keytool -genkey -alias key_basic -keyalg RSA -validity 365 -keystore basic.keystore
```  
### 导出证书(公钥)
```
keytool -export -v -alias key_basic -keystore basic.keystore -file basic.cer 
```
***
## 待认证的端末生成请求证书(公钥)  
### 创建服务端证书库(包含私钥和自签证书)
```
keytool -genkey -alias key_server -keyalg RSA -validity 365 -keystore server.keystore 
```
### 创建客户端证书库(包含私钥和自签证书)  
```
keytool -genkey -alias key_client -keyalg RSA -storetype PKCS12 -keystore client.p12
```
### 服务端发起证书认证请求(公钥)
```
keytool -certreq -alias key_server -keystore server.keystore -file server_req.csr 
```
### 客户端发起证书认证请求(公钥)
```
keytool -certreq -alias key_client -keystore client.p12 -file client_req.csr
```
***
## 模拟证书颁发中心认证请求证书(用CA私钥对请求证书(公钥)签名)  

### 根证书颁发(签名认证)服务端请求 
```
keytool -gencert -v -alias key_basic -infile server_req.csr -outfile res_server.cer -keystore basic.keystore
```

### 根证书颁发(签名认证)客户端请求
```
keytool -gencert -v -alias key_basic -infile client_req.csr -outfile res_client.cer -keystore basic.keystore
```
***
## 将已颁发的证书添加到发出请求的证书库
### 服务端证书库添加根证书
```
keytool -importcert -v -alias key_basic -file basic.cer -keystore server.keystore
```
### 客户端证书库添加根证书
```
keytool -importcert -v -alias key_basic -file basic.cer -keystore client.p12
```

### 服务端添加已认证的服务端证书 
```
keytool -importcert -v -alias key_server -file res_server.cer -keystore server.keystore 
```

### 客户端添加已认证的服务器证书
```
keytool -importcert -v -alias key_client -file res_client.cer -keystore client.p12
```
***

## 端末间相互信任 
### 客户端导出cer
```
keytool -export -v -alias key_client -keystore client.p12 -file client.cer
```

### 服务器证书库添加信任客户端证书
```
keytool -importcert -alias key_client -keystore server.keystore -file client.cer
```
***
## 服务端配置（Tomcat）  
**server.xml**
```
<Connector port="443" protocol="HTTP/1.1"
    SSLEnabled="true" maxThreads="150" scheme="https" secure="true"
        clientAuth="false" sslProtocol="TLS" keystoreFile="conf/server.keystore" 
    keystorePass="server" truststoreFile="conf/server.keystore" 
    truststorePass="server"/>
```

**web.xml**  
```
<login-config> 
    <auth-method>CLIENT-CERT</auth-method> 
    <realm-name>Client Cert Users-only Area</realm-name> 
</login-config> 

<security-constraint> 
    <web-resource-collection > 
        <web-resource-name >SSL</web-resource-name> 
        <url-pattern>/*</url-pattern> 
    </web-resource-collection> 
    <user-data-constraint> 
    <transport-guarantee>CONFIDENTIAL</transport-guarantee> 
    </user-data-constraint> 
</security-constraint>
```
















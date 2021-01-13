## Base64
Base64编码是从**二进制到字符**的过程，可用于在HTTP环境下传递较长的标识信息。采用Base64编码具有**不可读性**，需要解码后才能阅读。

Base64要求把每三个8Bit的字节转换为四个6Bit的字节（3\*8 = 4\*6 = 24），然后把6Bit再添两位高位0，组成四个8Bit的字节，也就是说，转换后的字符串理论上将要比原来的长1/3。
```
java.util.Base64
```

```
Base64.Decoder decoder = Base64.getDecoder();
Base64.Encoder encoder = Base64.getEncoder();
String text = "字串文字";
byte[] textByte = text.getBytes("UTF-8");
//编码
String encodedText = encoder.encodeToString(textByte);
System.out.println(encodedText);
//解码
System.out.println(new String(decoder.decode(encodedText), "UTF-8"));
```
# 字符串换行符,也叫宏延续运算符
\ 

# C语言strtok()函数：字符串分割

# shmget---分配一个system V 共享内存段
#include <sys/ipc.h>
#include <sys/shm.h>

int shmget(key_t key, size_t size, int shmflg);

# 查看栈默认限制大小，stack 字段，单位Kbytes
ulimit -s
注：实际使用时，比如默认8192Kbytes = 8M，实际申请内存达不到8M。

# 查看当前所有的资源限制，单位Kbytes
ulimit -a


# 字符串函数---itoa()函数

功能：将整数value 转换成字符串存入string 指向的内存空间 ,radix 为转换时所用基数(保存到字符串中的数据的进制基数)。
返回值：函数返回一个指向 str，无错误返回。

itoa():char *itoa( int value, char *string,int radix);

value：欲转换的数据。
string：目标字符串的地址。
radix：转换后的进制数，可以是10进制、16进制等，范围必须在 2-36。

# 使用printf打印各种数据类型的方式

%[flags][width][.prec][F|N|h|I][type]

格式控制字符串由3部分组成：普通字符、转义字符、输出项格式说明。
  （1）普通字符。普通字符在输出时，按原样输出，主要用于输出提示信息。
  （2）转义字符。转义字符指明特定的操作，如"\n"表示换行，"\t"表示水平制表等。
  （3）格式说明部分由“%”和“格式字符串”组成，他表示按规定的格式输出数据。

转换说明符
占位符	    说明
%a(%A)	    浮点数、十六进制数字和p-(P-)记数法(C99)
%c	        字符
%d	        有符号十进制整数
%f	        浮点数(包括float和doulbe)
%e(%E)	    浮点数指数输出[e-(E-)记数法]
%g(%G)	    浮点数不显无意义的零"0"
%i	        有符号十进制整数(与%d相同)
%u	        无符号十进制整数
%o	        八进制整数 e.g. 0123
%x(%X)	    十六进制整数<?xml:namespace prefix = st1 />() e.g. 0x1234
%p	        指针
%s	        字符串
%%	        “%”

特殊标志
显示	占位符	使用示例
左对齐	“-”	    “%-20s”
右对齐	“+”	    “%+20s”
空格	若符号为正，则显示空格，负则显示"-"	"% "
'#	对c,s,d,u类无影响；对o类，在输出时加前缀o；对x类，在输出时加前缀0x；对e,g,f 类当结果有小数时才给出小数点。	

格式字符串（格式）
［标志］［输出最少宽度］［．精度］［长度］类型
"％-md" ：左对齐，若m比实际少时，按实际输出。
"%m.ns"：输出m位，取字符串(左起)n位，左补空格，当n>m or m省略时m=n。
"%m.nf"：输出浮点数，m为输出宽度，n为小数点右边数位
长度：为ｈ短整形量,ｌ为长整形量

格式控制的完整格式
① %     表示格式说明的起始符号，不可缺少。
② -     有-表示左对齐输出，如省略表示右对齐输出。
③ 0     有0表示指定空位填0,如省略表示指定空位不填。
④ m.n   m指域宽，即对应的输出项在输出设备上所占的字符数。N指精度。用于说明输出的实型数的小数位数。为指定n时，隐含的精度为n=6位。
⑤ l或h  l对整型指long型，对实型指double型。h用于将整型的格式字符修正为short型。

一个h表示short，即short int
两个h表示short short，即 char。
%hhx 用于输出char
%hx 用于输出short int.




# signal和sigset
signal和sigset都是注册信号函数

signal是ANSI C的信号处理函数
sigset是System V的信号处理函数

ANSI C（标准C）是所有平台C程序都支持的，System V只在Unix/Linux使用。


# C语言结构体数组指针运算

ptr为某一结构体数组的初始地址

<错误>
ptr = ptr + 8;

<正确>
for(int i = 0; i < 数组大小; i++){
  if(ptr && (ptr = ptr + i)){
    if(i == 8) {
      break;
    }
  }
}
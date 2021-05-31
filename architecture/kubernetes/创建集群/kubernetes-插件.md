# 创建和使用插件
你可以将插件视为在现有 kubectl 命令之上构建更复杂功能的一种方法

# 查看可用的所有 kubectl 插件
kubectl plugin list

# 用任何语言创建一个简单的插件，并为生成的可执行文件命名
# 以前缀 "kubectl-" 开始
cat ./kubectl-hello

# 这个插件打印单词 "hello world"
'
#!/bin/sh
echo "hello world"
'

sudo chmod a+x ./kubectl-hello

# 并将其移动到路径中的某个位置
sudo mv ./kubectl-hello /usr/local/bin
sudo chown root:root /usr/local/bin

# 你现在已经创建并"安装了"一个 kubectl 插件。
# 你可以开始使用这个插件，从 kubectl 调用它，就像它是一个常规命令一样
kubectl hello

# 你可以"卸载"一个插件，只需从你的路径中删除它
sudo rm /usr/local/bin/kubectl-hello


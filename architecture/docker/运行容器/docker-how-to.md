# docker-centos-gnome-vnc
docker pull centos:7
docker run --name centos-desktop-vnc --privileged -p 5901:5901 --ulimit memlock=-1 -td centos:7 /usr/sbin/init
docker exec -it centos-desktop-vnc bash

curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache

yum update -y
yum grouplist
yum groupinstall -y 'Server with GUI' --allowerasing 
yum groupinstall -y 'GNOME Desktop'

unlink  /etc/systemd/system/default.target
ln -sf  /lib/systemd/system/graphical.target /etc/systemd/system/default.target

yum -y install tigervnc-server tigervnc-server-module

cp /lib/systemd/system/vncserver@.service /lib/systemd/system/vncserver@:1.service
vi /lib/systemd/system/vncserver@:1.service

[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=simple

ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver %i"
PIDFile=/home/root/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target


vncserver

systemctl daemon-reload
systemctl start vncserver@:1.service && systemctl enable vncserver@:1.service

systemctl disable firewalld.service
systemctl stop firewalld.service

# vpn
Windows 10 and 8.x
右键单击系统托盘中的无线/网络图标。
选择 打开网络和共享中心。或者，如果你使用 Windows 10 版本 1709 或以上，选择 打开"网络和 Internet"设置，然后在打开的页面中单击 网络和共享中心。
单击 设置新的连接或网络。
选择 连接到工作区，然后单击 下一步。
单击 使用我的Internet连接 (VPN)。
在 Internet地址 字段中输入你的 VPN 服务器 IP。
在 目标名称 字段中输入任意内容。单击 创建。
返回 网络和共享中心。单击左侧的 更改适配器设置。
右键单击新创建的 VPN 连接，并选择 属性。
单击 安全 选项卡，从 VPN 类型 下拉菜单中选择 "使用 IPsec 的第 2 层隧道协议 (L2TP/IPSec)"。
单击 允许使用这些协议。选中 "质询握手身份验证协议 (CHAP)" 和 "Microsoft CHAP 版本 2 (MS-CHAP v2)" 复选框。
单击 高级设置 按钮。
单击 使用预共享密钥作身份验证 并在 密钥 字段中输入你的 VPN IPsec PSK。
单击 确定 关闭 高级设置。
单击 确定 保存 VPN 连接的详细信息。

注： 在首次连接之前需要修改一次注册表，以解决 VPN 服务器 和/或 客户端与 NAT （比如家用路由器）的兼容问题。
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 0x0 /f
完成后必须重启计算机。

如果你使用 Windows 10 并且 VPN 卡在 "正在连接" 状态超过几分钟，尝试以下步骤：

右键单击系统托盘中的无线/网络图标。
选择 打开"网络和 Internet"设置，然后在打开的页面中单击左侧的 VPN。
选择新的 VPN 连接，然后单击 连接。如果出现提示，在登录窗口中输入 你的 VPN 用户名 和 密码 ，并单击 确定。
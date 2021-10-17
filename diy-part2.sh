#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#=================================================================================================================
#
# 这里的脚本在获取feeds后执行
#=====================================================================================================
# Modify default IP 更改默认IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#更改机器名
#sed -i 's/OpenWrt/LEDE/g' package/base-files/files/bin/config_generate
#添加软件源
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
sed -i '$a src-git git clone https://github.com/gdck/openwrt-packages' feeds.conf.default
#=====================================================================================================
#更改版本号为编译时间
#sed -i 's/R20.10.20/R$(date +%Y.%m.%d.%H:%M)/g' package/lean/default-settings/files/zzz-default-settings
sed -i "s/R2020.10.27.09:55/R$(date +%Y.%m.%d.%H:%M)/g" package/lean/default-settings/files/zzz-default-settings
sed -i "s/R20.10.20/R$(date +%Y.%m.%d.%H:%M)/g" package/lean/default-settings/files/zzz-default-settings
#=====================================================================================================
sed -i '46i 151.101.76.133 raw.githubusercontent.com' package/base-files/files/etc/hosts
#=====================================================================================================
#本地启动脚本
#启动脚本插入到 'exit 0' 之前即可随系统启动运行。
sed -i '3i /etc/init.d/samba stop' package/base-files/files/etc/rc.local #停止samba服务
sed -i '4i /etc/init.d/samba disable' package/base-files/files/etc/rc.local #禁止samba服务开机自动
#=====================================================================================================
#git clone https://github.com/kenzok8/openwrt-packages package/op-packages
# 获取Lienol-package
#git clone https://github.com/Lienol/openwrt-package package/diy-packages/lienol
# 获取gdck-package
#git clone https://github.com/gdck/openwrt-packages package/gdck
#================================================================================================================
# 获取luci-app-diskman和依赖
mkdir -p package/diy-packages/luci-app-diskman && \
mkdir -p package/diy-packages/parted && \
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Makefile -O package/lean/luci-app-diskman/Makefile
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/lean/parted/Makefile
#================================================================================================================
# 获取应用过滤luci-app-oaf
git clone https://github.com/destan19/OpenAppFilter package/lean/luci-app-oaf
# 获取luci-app-cupsd
git clone https://github.com/gdck/luci-app-cupsd package/lean/luci-app-cupsd
#==================================================================================================================
# 获取hello world和依赖
#git clone https://github.com/jerrykuku/lua-maxminddb package/diy-packages/helloworld/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr package/diy-packages/helloworld/luci-app-vssr
#==========================================================================================================
# 获取passwall
#git clone -b 3.6-40 https://github.com/liuran001/luci-app-passwall package/diy-packages/passwall
svn co  https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall package/lean/luci-app-passwall
#git clone -b https://github.com/gdck/luci-app-passwall-plus package/lean/passwall
svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-passwall package/lean/luci-app-passwall
svn co  https://github.com/gdck/openwrt-packages/trunk/dns2socks package/lean/dns2socks
svn co  https://github.com/gdck/openwrt-packages/trunk/ipt2socks package/lean/ipt2socks
svn co  https://github.com/gdck/openwrt-packages/trunk/iptvhelper package/lean/iptvhelper
svn co  https://github.com/gdck/openwrt-packages/trunk/microsocks package/lean/microsocks
svn co  https://github.com/gdck/openwrt-packages/trunk/ssocks package/lean/ssocks
svn co  https://github.com/gdck/openwrt-packages/trunk/tcping package/lean/tcping
svn co  https://github.com/gdck/openwrt-packages/trunk/trojan-go package/lean/trojan-go
svn co  https://github.com/gdck/openwrt-packages/trunk/trojan-plus package/lean/trojan-plus
svn co  https://github.com/gdck/openwrt-packages/trunk/trojan package/lean/trojan
svn co  https://github.com/gdck/openwrt-packages/trunk/v2ray-plugin package/lean/v2ray-plugin
svn co  https://github.com/gdck/openwrt-packages/trunk/v2ray package/lean/v2ray
svn co  https://github.com/gdck/openwrt-packages/trunk/naiveproxy package/lean/naiveproxy
svn co  https://github.com/gdck/openwrt-packages/trunk/brook package/lean/brook
#==========================================================================================================
# 获取网络端口状态
git clone  https://github.com/gdck/luci-app-tn-netports package/lean/luci-app-luci-app-tn-netports
#==========================================================================================================
# 获取luci-app-qosv4
#git clone https://github.com/gdck/luci-app-qosv4 package/lean/luci-app-qosv4
#==========================================================================================================
# 获取luci-app-speederv2#UDPspeeder辅助插件
git clone https://github.com/halldong/luci-app-speederv2 package/lean/luci-app-speederv2
#==========================================================================================================
# 获取uci-app-radius Radius服务器
#git clone https://github.com/MuJJus/luci-app-radius package/lean/luci-app-radius
#==========================================================================================================
# 获取luci-app-wifidog web认证界面
#git clone https://github.com/gdck/luci-app-wifidog package/lean/luci-app-wifidog
#==========================================================================================================
# 获取通过arp实现的在线人员查看的luci界面，统计误差为arp老化时间
git clone https://github.com/gdck/luci-app-onliner package/lean/luci-app-onliner
#==========================================================================================================
# 获取日志查看器
git clone https://github.com/gdck/luci-app-tn-logview package/lean/luci-app-tn-logview
#==========================================================================================================
# 获取网易云音乐解锁mini
git clone https://github.com/gdck/luci-app-unblockneteasemusic-mini package/lean/luci-app-unblockneteasemusic-mini
#==========================================================================================================
# 获取可道云 luci-app-kodexplorer
#git clone https://github.com/silime/luci-app-kodexplorer package/lean/luci-app-kodexplorer
#================================================================================================================
# 获取luci-app-serverchan
git clone https://github.com/tty228/luci-app-serverchan package/lean/luci-app-serverchan
# 获取luci-app-control-weburl
git clone https://github.com/gdck/luci-app-control-weburl package/lean/luci-app-control-weburl
#=====================================================================================================================
# 获取luci-app-smartdns
rm -rf package/lean/luci-app-smartdns
svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-smartdns package/lean/luci-app-smartdns
rm -rf package/lean/smartdns
svn co  https://github.com/gdck/openwrt-packages/trunk/smartdns package/lean/smartdns
#=============================================================================================================================
# 获取luci-app-chinadns-ng
svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-chinadns-ng package/lean/luci-app-chinadns-ng
svn co  https://github.com/gdck/openwrt-packages/trunk/chinadns-ng package/lean/chinadns-ng 
#===============================================================================================================
# 获取luci-app-adguardhome
#pushd package/lean
rm -rf package/lean/luci-app-adguardhome
git clone https://github.com/gdck/luci-app-adguardhome package/lean/luci-app-adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome package/lean/luci-app-adguardhome
#============================================================================================================
# 获取luci-app-ser2net串口网络透传
svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-ser2net package/lean/luci-app-ser2net
#==========================================================================================================
#  获取luci-app-socat一个多功能的网络工具
#svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-socat package/lean/luci-app-socat
#==========================================================================================================
#==========================================================================================================
#==========================================================================================================
# MTK闭源驱动
src-git mtk https://github.com/Nossiac/mtk-openwrt-feeds;lede-17.01
#然后执行：
#scripts/feeds update -f mtk
#scripts/feeds install -a -p mtk
#不要先以下模块
#rt2x00
#mt76
#cfg80211
#mac80211
#wpad
#supplicant
#==========================================================================================================
# 获取luci-app-wrtbwmon
#svn co https://github.com/gdck/openwrt-packages/branches/packages-19.07/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
#svn co https://github.com/gdck/openwrt-packages/branches/packages-19.07/wrtbwmon package/lean/wrtbwmon
#git clone https://github.com/kongfl888/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
git clone https://github.com/brvphoenix/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
#======================================================================================================================
# 获取luci-app-koolproxy
git clone https://github.com/gdck/luci-app-koolproxy package/lean/luci-app-koolproxy
#======================================================================================================================
# 获取luci-app-qos-gargoyle
git clone https://github.com/gdck/luci-app-qos-gargoyle package/lean/luci-app-qos-gargoyle
#======================================================================================================================
# 获取luci-app-openclash 编译po2lmo
#git clone -b master https://github.com/vernesong/OpenClash package/diy-packages/openclash
#pushd package/diy-packages/openclash/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#===============================================================================================================================
# 清除旧版argon主题并拉取最新版
pushd package/lean
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd
#===============================================================================================================================
#===============================================================================================================================
#pushd package/lean
#rm -rf baidupcs-web
#git clone https://github.com/liuran001/baidupcs-web-lede baidupcs-web
#popd

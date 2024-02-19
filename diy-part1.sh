#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Clean up dependencies
find feeds -name Makefile -exec dirname {} \; | grep -wE 'brook|gn|chinadns-ng|dns2socks|dns2tcp|hysteria|ipt2socks|microsocks|naiveproxy|pdnsd-alt|redsocks2|sagernet-core|shadowsocks-rust|shadowsocksr-libev|simple-obfs|sing-box|ssocks|tcping|trojan|trojan-go|trojan-plus|v2ray-core|v2ray-geodata|v2ray-plugin|v2raya|xray-core|xray-plugin|lua-neturl|luci-app-ssr-plus|mosdns' | xargs rm -rf

# Modify default IP
sed -i 's/192.168.6.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default Hostname
#sed -i 's/ImmortalWrt/Railgun/g' package/base-files/files/bin/config_generate

- name: 替换默认主题 luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-design/' feeds/luci/collections/luci/Makefile

# 替换源 
sed -i 's,mirrors.vsean.net/openwrt,mirrors.pku.edu.cn/immortalwrt,g'  package/emortal/default-settings/files/99-default-settings-chinese

# Update Go to 1.21 for Xray-core build
rm -rf feeds/packages/lang/golang
git_sparse_clone https://github.com/immortalwrt/packages openwrt-23.05 lang/golang feeds/packages/lang/golang

# Make tailsale config persistent during sysupgrades
echo "/etc/tailscale/" >> package/base-files/files/etc/sysupgrade.conf

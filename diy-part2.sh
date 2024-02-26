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
#

# Clean up dependencies
find feeds -name Makefile -exec dirname {} \; | grep -wE 'brook|gn|chinadns-ng|dns2socks|dns2tcp|hysteria|ipt2socks|microsocks|naiveproxy|pdnsd-alt|redsocks2|sagernet-core|shadowsocks-rust|shadowsocksr-libev|simple-obfs|sing-box|ssocks|tcping|trojan|trojan-go|trojan-plus|v2ray-core|v2ray-geodata|v2ray-plugin|v2raya|xray-core|xray-plugin|lua-neturl|luci-app-ssr-plus|mosdns' | xargs rm -rf

# Modify default IP
sed -i 's/192.168.[0-9]\{1,3\}.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# name: 替换默认主题 luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-design/' feeds/luci/collections/luci/Makefile

# Update Go to 1.21
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 21.x feeds/packages/lang/golang\

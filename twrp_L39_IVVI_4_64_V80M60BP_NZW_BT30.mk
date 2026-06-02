#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# 继承编译配置（从最具体的开始）
# 继承 64 位系统核心配置
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
# 继承完整基础手机配置（含通话/基带）
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# 继承当前设备的配置文件（已修正路径）
$(call inherit-product, device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30/device.mk)

# ==============================
# OrangeFox  Recovery 专属配置
# ==============================
# 维护者名称
OF_MAINTAINER := "pipi"
# 开启 TWRP 兼容模式（保证脚本通用）
OF_TWRP_COMPATIBILITY_MODE := 1
# 支持所有分区 OTA 升级
OF_SUPPORT_ALL_BLOCK_OTA := 1
# 禁用小米 MIUI 专属功能（避免报错）
OF_DISABLE_MIUI_SPECIFIC_FEATURES := 1
# 启用手电筒功能
OF_FLASHLIGHT_ENABLE := 1
# 屏幕高度分辨率
OF_SCREEN_H := 2340
# 状态栏高度
OF_STATUS_H := 80
# 状态栏左侧边距
OF_STATUS_INDENT_LEFT := 48
# 状态栏右侧边距
OF_STATUS_INDENT_RIGHT := 48
# 禁止隐藏导航栏
OF_ALLOW_DISABLE_NAVBAR := 0
# 时钟位置：1=左侧
OF_CLOCK_POS := 1
# 使用 Magisk 启动补丁
OF_USE_MAGISKBOOT := 1
# 对所有分区补丁使用 Magiskboot
OF_USE_MAGISKBOOT_FOR_ALL_PATCHES := 1
# 不对加密设备执行补丁
OF_DONT_PATCH_ENCRYPTED_DEVICE := 1
# 跳过 Treble 兼容性检查
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
# 自动补丁 AVB 2.0 验证（解决无法开机）
OF_PATCH_AVB20 := 1
# 忽略 FBE 加密元数据分区挂载错误
OF_FBE_METADATA_MOUNT_IGNORE := 1

# ==============================
# 设备基础信息（必须与系统一致）
# ==============================
# 设备代号
PRODUCT_DEVICE := L39_IVVI_4_64_V80M60BP_NZW_BT30
# 编译名称（与 Makefile 一致）
PRODUCT_NAME := twrp_L39_IVVI_4_64_V80M60BP_NZW_BT30
# 设备品牌
PRODUCT_BRAND := 5G
# 设备型号
PRODUCT_MODEL := 20221212A
# 制造商
PRODUCT_MANUFACTURER := 5g

# 系统构建指纹（用于系统识别、防校验错误）
BUILD_FINGERPRINT := 5G/20221212A/L39:11/RP1A.200720.011/1708419017:user/release-keys

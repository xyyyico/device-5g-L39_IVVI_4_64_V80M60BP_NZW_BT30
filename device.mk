#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# 定义当前设备树所在路径（固定不变）
LOCAL_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# --------------------------
# A/B 分区 OTA 升级配置
# --------------------------
# A/B 系统 OTA 升级后优化脚本配置
AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_system=true \
	POSTINSTALL_PATH_system=system/bin/otapreopt_script \
	FILESYSTEM_TYPE_system=ext4 \
	POSTINSTALL_OPTIONAL_system=true

# --------------------------
# 启动控制 HAL 服务（A/B 分区必须）
# Android 12 兼容稳定版
# --------------------------
PRODUCT_PACKAGES += \
	android.hardware.boot@1.0-impl \
	android.hardware.boot@1.0-service \
	bootctrl.mt6768

# --------------------------
# A/B 分区 OTA 升级核心组件
# --------------------------
PRODUCT_PACKAGES += \
	otapreopt_script \
	cppreopts.sh \
	update_engine \
	update_verifier \
	update_engine_sideload

#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# 定义当前设备树所在路径（固定不变）
LOCAL_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# ==============================================================
# 平台 & MTK 硬件（MT6768 必须）
# ==============================================================
TARGET_BOARD_PLATFORM := mt6768
BOARD_USES_MTK_HARDWARE := true
BOARD_HAS_MTK_HARDWARE := true

# ==============================================================
# A/B 分区 + 动态分区（你机型核心）
# ==============================================================
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    system \
    product \
    vendor \
    vbmeta_system \
    vbmeta_vendor \
    boot

# A/B 系统 OTA 升级后优化脚本配置
AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_system=true \
	POSTINSTALL_PATH_system=system/bin/otapreopt_script \
	FILESYSTEM_TYPE_system=ext4 \
	POSTINSTALL_OPTIONAL_system=true

# 动态分区
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# ==============================================================
# 启动控制 HAL 服务（A/B 分区必须）
# Android 12 兼容稳定版
# ==============================================================
PRODUCT_PACKAGES += \
	android.hardware.boot@1.0-impl \
	android.hardware.boot@1.0-service \
	bootctrl.mt6768

# ==============================================================
# A/B 分区 OTA 升级核心组件
# ==============================================================
PRODUCT_PACKAGES += \
	otapreopt_script \
	cppreopts.sh \
	update_engine \
	update_verifier \
	update_engine_sideload

# ==============================================================
# Recovery/TWRP/OrangeFox 文件复制（关键！否则脚本不进 ramdisk）
# ==============================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init:root/init \
    $(LOCAL_PATH)/recovery/root/init.orig:root/init.orig \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt6768.rc:root/init.recovery.rc

# ==============================================================
# fstab（如果有就复制，没有就先注释，编译会提示）
# ==============================================================
# PRODUCT_COPY_FILES += \
#     $(LOCAL_PATH)/fstab.mt6768:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt6768

# ==============================================================
# 系统属性（基本）
# ==============================================================
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware=mt6768 \
    ro.mediatek.platform=mt6768

# ==============================================================
# 64位 + AAPT 配置
# ==============================================================
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi
TARGET_SUPPORTS_64_BIT_APPS := true

# ==============================================================
# 禁止 ELF 预编译报错（MTK 常用）
# ==============================================================
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

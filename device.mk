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
    RUN_POSTINSTALL_system=true \          # 系统升级后执行优化
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \  # 优化脚本路径
    FILESYSTEM_TYPE_system=ext4 \          # 系统分区文件系统格式
    POSTINSTALL_OPTIONAL_system=true       # 该优化步骤为可选

# --------------------------
# 启动控制 HAL 服务（A/B 分区必须）
# Android 12 兼容稳定版
# --------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \       # Boot 控制 HAL 实现库
    android.hardware.boot@1.0-service \    # Boot 控制后台服务
    bootctrl.mt6768 \                      # MT6768 芯片专用 Boot 控制驱动

# 旧版 PRODUCT_STATIC_BOOT_CONTROL_HAL 已删除
# 作用：避免编译报错，新版 TWRP 不再需要该配置

# --------------------------
# A/B 分区 OTA 升级核心组件
# --------------------------
PRODUCT_PACKAGES += \
    otapreopt_script \        # OTA 升级预优化脚本
    cppreopts.sh \            # 编译优化脚本
    update_engine \           # 系统更新引擎（A/B 升级核心）
    update_verifier \         # 更新包校验工具
    update_engine_sideload    # 线刷/ADBA 升级支持

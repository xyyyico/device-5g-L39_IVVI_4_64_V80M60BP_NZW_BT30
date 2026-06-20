#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# 定义当前设备树所在路径（标准变量 DEVICE_PATH）
DEVICE_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# ====================== A/B 分区全局总开关（必须前置，缺失会导致OTA失效） ======================
AB_OTA_UPDATER := true

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

# ====================== 修复文件拷贝项 ======================
# 1. fstab仅拷贝至first_stage_ramdisk，删除recovery根目录冗余拷贝，避免分区重复挂载冲突
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/fstab.mt6768:recovery/root/first_stage_ramdisk/fstab.mt6768

# 2. 拷贝自定义recovery.fstab到recovery根目录（TWRP/OF标准读取路径）
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery.fstab:recovery/root/recovery.fstab

# 3. 【SELinux修复】cil直接放到recovery根目录，不再创建sepolicy文件夹，解决 rm: Is a directory 编译报错
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/sepolicy/recovery_sepolicy.cil:recovery/root/recovery_sepolicy.cil

# 声明recovery加载自定义cil规则（关键，否则SELinux规则不生效）
BOARD_RECOVERY_SEPOLICY += $(TARGET_RECOVERY_ROOT_OUT)/recovery_sepolicy.cil

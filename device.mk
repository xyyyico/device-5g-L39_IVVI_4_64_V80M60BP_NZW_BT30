#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# 定义当前设备树所在路径（标准变量 DEVICE_PATH）
DEVICE_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

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

# ====================== 修复文件拷贝项（修正路径，无编译报错） ======================
# 1. 将原厂fstab.mt6768复制到recovery ramdisk，解决 Unable to parse vendor fstab
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/fstab.mt6768:recovery/root/fstab.mt6768 \
    $(DEVICE_PATH)/fstab.mt6768:recovery/root/first_stage_ramdisk/fstab.mt6768

# 2. 拷贝自定义recovery.fstab到recovery根目录（TWRP/OF标准读取路径）
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery.fstab:recovery/root/recovery.fstab

# 3. 【SELinux权限修复】仅拷贝编译好的cil规则到ramdisk（.te编译阶段使用，无需打包进镜像）
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/sepolicy/recovery_sepolicy.cil:recovery/root/sepolicy/recovery_sepolicy.cil

# 4. MTK 补充：拷贝设备 vintf 清单，解决vendor分区vintf解析失败（按需保留）
# PRODUCT_COPY_FILES += \
#     $(DEVICE_PATH)/manifest.xml:recovery/root/vendor/etc/vintf/manifest.xml

# 5. 屏蔽USB OTG报错配套、AVB vbmeta补丁拷贝区域（后续添加文件可在此扩展）

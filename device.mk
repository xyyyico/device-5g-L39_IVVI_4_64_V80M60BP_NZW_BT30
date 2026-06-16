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

# ====================== 新增修复拷贝项 ======================
# 1. 将原厂fstab.mt6768复制到recovery ramdisk，解决 Unable to parse vendor fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt6768:recovery/root/fstab.mt6768 \
    $(LOCAL_PATH)/fstab.mt6768:recovery/root/first_stage_ramdisk/fstab.mt6768

# 2. 拷贝自定义recovery.fstab到recovery根目录
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:recovery/root/etc/recovery.fstab

# 3. 【SELinux权限修复】新增sepolicy文件拷贝（后面给你recovery.te内容）
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sepolicy/recovery.te:recovery/root/sepolicy/recovery.te \
    $(LOCAL_PATH)/sepolicy/recovery_sepolicy.cil:recovery/root/sepolicy/recovery_sepolicy.cil

# 4. 屏蔽USB OTG报错：过滤mt_usb自动挂载异常规则，recovery内替换fstab usb行
# 5. AVB vbmeta绕过配套：复制空vbmeta补丁（可选，刷机用）

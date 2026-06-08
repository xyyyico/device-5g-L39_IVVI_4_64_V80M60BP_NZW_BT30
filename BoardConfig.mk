#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# ------------------------------------------------------
# 1. 基础继承
# ------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# ------------------------------------------------------
# 2. 设备标识（必须，否则 lunch 不认）
# ------------------------------------------------------
PRODUCT_DEVICE := L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_NAME := twrp_L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_BRAND := 5G
PRODUCT_MODEL := 20221212A
PRODUCT_MANUFACTURER := 5g

# ------------------------------------------------------
# 3. 平台
# ------------------------------------------------------
TARGET_BOARD_PLATFORM := mt6768
BOARD_USES_MTK_HARDWARE := true
BOARD_HAS_MTK_HARDWARE := true

# ------------------------------------------------------
# 4. A/B + 动态分区
# ------------------------------------------------------
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    system \
    product \
    vendor \
    vbmeta_system \
    vbmeta_vendor \
    boot

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# ------------------------------------------------------
# 5. Boot HAL（MT6768 稳定写法）
# ------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    bootctrl.mt6768

# ------------------------------------------------------
# 6. OTA
# ------------------------------------------------------
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# ------------------------------------------------------
# 7. Recovery 工具
# ------------------------------------------------------
PRODUCT_PACKAGES += \
    charger_res_images \
    resize2fs \
    e2fsck \
    tune2fs

# ------------------------------------------------------
# 8. 拷贝 TWRP 关键文件到 ramdisk（非常重要）
# ------------------------------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/recovery.fstab:recovery/root/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt6768.rc:recovery/root/init.recovery.rc

# 系统 fstab（你原来的）
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt6768:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt6768

# ------------------------------------------------------
# 9. 系统属性
# ------------------------------------------------------
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware=mt6768 \
    ro.mediatek.platform=mt6768

# ------------------------------------------------------
# 10. 64位 & AAPT
# ------------------------------------------------------
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi
TARGET_SUPPORTS_64_BIT_APPS := true

# ------------------------------------------------------
# 11. 编译容错（MTK 常用）
# ------------------------------------------------------
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

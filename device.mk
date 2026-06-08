#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# ------------------------------------------------------
# 1. 基础配置
# ------------------------------------------------------
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# ------------------------------------------------------
# 2. 平台
# ------------------------------------------------------
TARGET_BOARD_PLATFORM := mt6768
BOARD_USES_MTK_HARDWARE := true
BOARD_HAS_MTK_HARDWARE := true

# ------------------------------------------------------
# 3. A/B + 动态分区
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
# 4. Boot HAL
# ------------------------------------------------------
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-recovery \
    android.hardware.boot@1.1-service

# ------------------------------------------------------
# 5. OTA
# ------------------------------------------------------
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# ------------------------------------------------------
# 6. 工具
# ------------------------------------------------------
PRODUCT_PACKAGES += \
    charger_res_images \
    resize2fs \
    e2fsck \
    tune2fs

# ------------------------------------------------------
# 7. 单 ramdisk 自动模式 → 不手动复制 init
# ------------------------------------------------------

# ------------------------------------------------------
# 8. fstab 启用（你已经有 fstab.mt6768）
# ------------------------------------------------------
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.mt6768:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt6768

# ------------------------------------------------------
# 9. 属性
# ------------------------------------------------------
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware=mt6768 \
    ro.mediatek.platform=mt6768

# ------------------------------------------------------
# 10. 编译优化
# ------------------------------------------------------
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

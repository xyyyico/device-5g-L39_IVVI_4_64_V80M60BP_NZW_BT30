#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_NAME := twrp_L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_BRAND := ivvi
PRODUCT_MODEL := IVVI L39 4GB+64GB
PRODUCT_MANUFACTURER := ivvi
PRODUCT_RELEASE_NAME := L39_IVVI

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enable A/B OTA
AB_OTA_UPDATER := true

# Copy recovery.fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:system/etc/recovery.fstab

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock

# USB
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# TWRP Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.boot=1 \
    ro.twrp.version=3.7.0 \
    ro.twrp.device.name=L39_IVVI

# Security & Debug
PRODUCT_PROPERTY_OVERRIDES += \
    ro.secure=1 \
    ro.adb.secure=0 \
    ro.allow.mock.location=0

# Extra properties
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="ivvi_l39-user 12 SP1A.210812.016 eng.build.20250101 test-keys"

# Device fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT=ivvi/L39_IVVI/L39_IVVI:12/SP1A.210812.016/20250101:user/release-keys

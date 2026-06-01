#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from L39_IVVI_4_64_V80M60BP_NZW_BT30 device
$(call inherit-product, device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30/device.mk)

PRODUCT_DEVICE := L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_NAME := omni_L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_BRAND := 5G
PRODUCT_MODEL := 20221212A
PRODUCT_MANUFACTURER := 5g

PRODUCT_GMS_CLIENTID_BASE := android-5g

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_L39_IVVI_4_64_V80M60BP_NZW_BT30-user 11 RP1A.200720.011 1708419017 release-keys"

BUILD_FINGERPRINT := 5G/20221212A/L39:11/RP1A.200720.011/1708419017:user/release-keys

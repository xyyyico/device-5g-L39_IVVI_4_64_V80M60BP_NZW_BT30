#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 xyyyico's TWRP Device Tree
#
# SPDX-License-Identifier: Apache-2.0
#

# 继承64位基础编译配置
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# 手机通讯设备基础配置
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# 加载设备device.mk配置
$(call inherit-product, device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30/device.mk)

# ======================
# 设备基础信息
# ======================
PRODUCT_DEVICE := L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_NAME := twrp_$(PRODUCT_DEVICE)
PRODUCT_BRAND := 5g
PRODUCT_MODEL := 20221212A
PRODUCT_MANUFACTURER := 5g

# 系统指纹
BUILD_FINGERPRINT := 5G/20221212A/L39:11/RP1A.200720.011/1708419017:user/release-keys

# 覆盖系统属性，修复error code:0xb指纹只读报错
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT) \
    ro.product.device=$(PRODUCT_DEVICE) \
    ro.product.model=$(PRODUCT_MODEL) \
    ro.product.brand=$(PRODUCT_BRAND)

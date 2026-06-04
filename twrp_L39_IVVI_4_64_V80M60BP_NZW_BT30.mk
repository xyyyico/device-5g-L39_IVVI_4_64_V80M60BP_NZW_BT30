#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 xyyyico's TWRP Device Tree
#
# SPDX-License-Identifier: Apache-2.0
#

# 必须使用 TAB 缩进！不可使用空格！
# 本文件已严格检查 Makefile 语法

# 继承 64 位编译基础配置
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# 继承手机设备基础配置
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# 加载设备专属配置（device.mk）
$(call inherit-product, device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30/device.mk)

# ======================
# 设备基础信息（必须正确）
# ======================
PRODUCT_DEVICE := L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_NAME := twrp_L39_IVVI_4_64_V80M60BP_NZW_BT30
PRODUCT_BRAND := 5G
PRODUCT_MODEL := 20221212A
PRODUCT_MANUFACTURER := 5g

# ======================
# TWRP 公共配置（TAB缩进）
# ======================
ifeq ($(TARGET_BUILD_RECOVERY_IMAGE),true)
	# 下一行开头必须是【TAB】，不能是空格！
	$(call inherit-product, bootable/recovery/config/omni_twrp_common.mk)
endif

# 系统指纹（用于系统验证）
BUILD_FINGERPRINT := 5G/20221212A/L39:11/RP1A.200720.011/1708419017:user/release-keys

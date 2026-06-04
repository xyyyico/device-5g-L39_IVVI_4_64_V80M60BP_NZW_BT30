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
PRODUCT_BRAND := IVVI
PRODUCT_MODEL := 20221212A
PRODUCT_MANUFACTURER := IVVI

# ======================
# TWRP 公共配置【重点修改】
# ======================
# 标准TWRP通用引入，删掉ifeq判断，Action自动识别编译rec
$(call inherit-product, vendor/twrp/config/common.mk)

# 系统指纹（用于系统验证）
BUILD_FINGERPRINT := IVVI/20221212A/L39:11/RP1A.200720.011/1708419017:user/release-keys

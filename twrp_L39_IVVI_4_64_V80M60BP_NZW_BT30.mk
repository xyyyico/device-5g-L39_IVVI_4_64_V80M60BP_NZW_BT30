#
# SPDX-License-Identifier: Apache-2.0
#

# 定义设备路径
DEVICE_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# 允许缺失依赖（TWRP 编译必备）
ALLOW_MISSING_DEPENDENCIES := true

# =============================================================================
# ✅ 修复：正确的 A/B + Recovery-as-Boot 配置
# 作用：正常开机进系统，按键可进 Recovery
# =============================================================================
AB_OTA_UPDATER := true                      # 启用 A/B 分区升级
AB_OTA_PARTITIONS += \                      # A/B 包含的分区
    system \
    product \
    vendor \
    vbmeta_system \
    vbmeta_vendor \
    boot

BOARD_USES_RECOVERY_AS_BOOT := true         # 使用 boot 分区承载 recovery
TARGET_NO_RECOVERY := true                  # 没有独立 recovery 分区
BOARD_HAS_NO_RECOVERY_PARTITION := true     # 设备不存在 recovery 分区
BOARD_BUILD_RECOVERY_IMAGE := true          # 必须开启，否则无法打包正常 boot
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_BOOT := false  # 🔥 关键：不把 REC 强行写入 boot
TARGET_RECOVERY_IN_BOOT_IMAGE := false      # 🔥 关键：关闭默认进 REC

# 动态分区必须开启元数据分区
BOARD_USES_METADATA_PARTITION := true
TARGET_RECOVERY_USE_QEMU_STORAGE := true

# A/B OTA 后优化脚本配置
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# =============================================================================
# 设备 CPU 架构（ARM64 + 兼容 32 位）
# =============================================================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# 旧机型 APEX 兼容
OVERRIDE_TARGET_FLATTEN_APEX := true

# =============================================================================
# Bootloader 配置
# =============================================================================
TARGET_BOOTLOADER_BOARD_NAME := k69v1_64
TARGET_NO_BOOTLOADER := true

# =============================================================================
# 屏幕显示配置
# =============================================================================
TARGET_SCREEN_DENSITY := 320

# =============================================================================
# 内核与 boot.img 基础参数
# =============================================================================
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user ro.verified.status=verified droi.magic=86F31946579580B3780EE79D4B61A815
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000

# boot.img 编译附加参数
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image

# =============================================================================
# 使用预编译内核（不编译内核源码）
# =============================================================================
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_SKIP_ANDROID_DTB_BUILD := true
endif

# 关闭内核源码编译
TARGET_KERNEL_SOURCE :=
TARGET_KERNEL_CONFIG :=

# =============================================================================
# 分区与文件系统配置
# =============================================================================
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432  # boot 分区大小 32MB

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Super 动态分区配置
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := 5g_dynamic_partitions
BOARD_5G_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_5G_DYNAMIC_PARTITIONS_SIZE := 9122611200

# =============================================================================
# 平台芯片组：MT6768
# =============================================================================
TARGET_BOARD_PLATFORM := mt6768

# =============================================================================
# 文件系统支持
# =============================================================================
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# =============================================================================
# 安全补丁版本
# =============================================================================
VENDOR_SECURITY_PATCH := 2021-08-01

# =============================================================================
# AVB 验证启动配置
# =============================================================================
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# =============================================================================
# 防回滚保护（TWRP 必须）
# =============================================================================
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# =============================================================================
# TWRP 基础配置
# =============================================================================
TW_THEME := portrait_hdpi                  # 竖屏主题
TW_EXTRA_LANGUAGES := true                 # 多语言支持
TW_SCREEN_BLANK_ON_BOOT := true             # 启动时黑屏防闪烁
TW_INPUT_BLACKLIST := "hbtp_vm"             # 屏蔽错误输入设备
TW_USE_TOOLBOX := true                     # 使用工具箱
TW_INCLUDE_REPACKTOOLS := true             # 包含镜像打包工具

# 屏幕亮度配置
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1024
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness

# =============================================================================
# MTP 文件传输配置
# =============================================================================
TW_MTP_DEVICE := /sdcard
TW_USB_VENDOR_ID := 0x0e8d                 # 联发科 VID
TW_USB_PRODUCT_ID := 0x201c                # 设备 PID
TW_USE_MODEL_HARDWARE_ID_FOR_USB := true

# =============================================================================
# OrangeFox 配置
# =============================================================================
OF_MAINTAINER := xy
OF_NO_ADDON := true

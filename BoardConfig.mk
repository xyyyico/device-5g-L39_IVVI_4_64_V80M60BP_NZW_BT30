#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30
ALLOW_MISSING_DEPENDENCIES := true

# ----------------------------
# A/B 分区（修复报错）
# ----------------------------
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    product \
    vbmeta_system \
    vbmeta_vendor

# ----------------------------------------------------------------
# 架构
# ----------------------------------------------------------------
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# ----------------------------------------------------------------
# 平台 MT6768
# ----------------------------------------------------------------
TARGET_BOARD_PLATFORM := mt6768
TARGET_BOOTLOADER_BOARD_NAME := k69v1_64
TARGET_NO_BOOTLOADER := true

# ----------------------------------------------------------------
# 单 Ramdisk + A/B + Recovery 内嵌 Boot（核心！不会死循环）
# ----------------------------------------------------------------
TARGET_IS_AB_DEVICE := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
BOARD_HAS_NO_RECOVERY_PARTITION := true
TARGET_RECOVERY_IN_BOOT_IMAGE := true
BOARD_BUILD_RECOVERY_IMAGE := false

# 单 Ramdisk 模式（TWRP 自动生成双启动 init）
TW_SINGLE_RAMDISK := true

# 绝对禁止永远进 recovery
BOARD_ALWAYS_IN_RECOVERY := false
TW_FORCE_RECOVERY := false

# ----------------------------------------------------------------
# 内核 & 预编译内核（你已有的 prebuilt）
# ----------------------------------------------------------------
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000

BOARD_MKBOOTIMG_ARGS += \
    --header_version $(BOARD_BOOTIMG_HEADER_VERSION) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

BOARD_KERNEL_IMAGE_NAME := Image
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_SKIP_ANDROID_DTB_BUILD := true

# ----------------------------------------------------------------
# 分区大小 & 动态分区 Super（MT6768 A/B 标准）
# ----------------------------------------------------------------
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_USES_METADATA_PARTITION := true

# Super 分区（动态分区）
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := 5g_dynamic_partitions
BOARD_5G_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_5G_DYNAMIC_PARTITIONS_SIZE := 9122611200

# 文件系统
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# ----------------------------------------------------------------
# AVB 必须关闭（MTK 机型刷入不卡第一屏）
# ----------------------------------------------------------------
BOARD_AVB_ENABLE := false
BOARD_AVB_VBMETA_SYSTEM := false
BOARD_AVB_VBMETA_VENDOR := false

# ----------------------------------------------------------------
# TWRP 基础功能
# ----------------------------------------------------------------
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := zh_CN
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 800
TW_MTP_DEVICE := /sdcard
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_TOOLBOX := true

# A/B 专用
TW_AB_DEVICE := true
TW_NO_AB_UPDATE_RECOVERY := true

# ----------------------------------------------------------------
# 编译兼容
# ----------------------------------------------------------------
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2099-12-31
OVERRIDE_TARGET_FLATTEN_APEX := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

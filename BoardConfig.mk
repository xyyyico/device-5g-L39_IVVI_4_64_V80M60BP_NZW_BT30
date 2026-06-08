#
# SPDX-License-Identifier: Apache-2.0
#

# 定义当前设备路径（固定，不能乱改）
DEVICE_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# 允许使用最小化源码清单编译（TWRP专用）
ALLOW_MISSING_DEPENDENCIES := true

# ----------------------------
# A/B 分区 + 单 Ramdisk 核心（修复版）
# ----------------------------
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
	system \
	product \
	vendor \
	vbmeta_system \
	vbmeta_vendor \
	boot

# 【关键：单 Ramdisk + 无 Recovery 分区】
TARGET_IS_AB_DEVICE := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
BOARD_HAS_NO_RECOVERY_PARTITION := true
TARGET_RECOVERY_IN_BOOT_IMAGE := true
BOARD_BUILD_RECOVERY_IMAGE := false

# 【关闭双 ramdisk 模式，强制单 ramdisk】
TW_INCLUDE_RECOVERY_FROM_BOOT_PATCH := false
TW_SINGLE_RAMDISK := true

# 【绝对禁止永远进 recovery】
BOARD_ALWAYS_IN_RECOVERY := false
TW_FORCE_RECOVERY := false
TW_NO_REBOOT_RECOVERY := false

# 动态分区必须
BOARD_USES_METADATA_PARTITION := true
TARGET_RECOVERY_USE_QEMU_STORAGE := true

# A/B OTA
AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_system=true \
	POSTINSTALL_PATH_system=system/bin/otapreopt_script \
	FILESYSTEM_TYPE_system=ext4 \
	POSTINSTALL_OPTIONAL_system=true

# ----------------------------------------------------------------
# 第一阶段 ramdisk（保持你原生不变）
# ----------------------------------------------------------------
BOARD_USES_FIRST_STAGE_RAMDISK := true
TARGET_NO_FIRST_STAGE_RAMDISK := false
BOARD_GENERIC_RAMDISK_OUT := $(DEVICE_PATH)/ramdisk
BOARD_MOUNT_GENERIC_RAMDISK := true

# ----------------------------
# CPU架构 原样保留
# ----------------------------
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

OVERRIDE_TARGET_FLATTEN_APEX := true

# ----------------------------
# Bootloader
# ----------------------------
TARGET_BOOTLOADER_BOARD_NAME := k69v1_64
TARGET_NO_BOOTLOADER := true

# ----------------------------
# 屏幕
# ----------------------------
TARGET_SCREEN_DENSITY := 320

# ----------------------------
# 内核boot参数 原参数不动
# ----------------------------
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user ro.verified.status=verified droi.magic=86F31946579580B3780EE79D4B61A815
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image

# 预编译内核不变
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_SKIP_ANDROID_DTB_BUILD := true
endif
TARGET_KERNEL_SOURCE :=
TARGET_KERNEL_CONFIG :=

# ----------------------------
# 分区大小、动态分区 原样保留
# ----------------------------
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := 5g_dynamic_partitions
BOARD_5G_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_5G_DYNAMIC_PARTITIONS_SIZE := 9122611200

# ----------------------------
# 平台 MT6768
# ----------------------------
TARGET_BOARD_PLATFORM := mt6768

# 文件系统
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# ----------------------------
# AVB 保持关闭（你原生正确）
# ----------------------------
BOARD_AVB_ENABLE := false
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# 安全补丁
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# ----------------------------
# TWRP 配置
# ----------------------------
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true

TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1024
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness

TW_MTP_DEVICE := /sdcard
TW_USB_VENDOR_ID := 0x0e8d
TW_USB_PRODUCT_ID := 0x201c
TW_USE_MODEL_HARDWARE_ID_FOR_USB := true

# A/B 专用（必须加）
TW_AB_DEVICE := true
TW_NO_AB_UPDATE_RECOVERY := true

OF_MAINTAINER := xy
OF_NO_ADDON := true

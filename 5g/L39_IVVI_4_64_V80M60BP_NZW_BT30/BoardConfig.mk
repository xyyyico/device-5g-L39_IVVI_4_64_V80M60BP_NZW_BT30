#
# SPDX-License-Identifier: Apache-2.0
#

# 定义当前设备路径（固定，不能乱改）
DEVICE_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# 允许使用最小化源码清单编译（TWRP专用）
ALLOW_MISSING_DEPENDENCIES := true

# ----------------------------
# A/B 分区 + kexec按键进OF（方案2：原生boot保留安卓，按键kexec跳REC）
# ----------------------------
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
	system \
	product \
	vendor \
	vbmeta_system \
	vbmeta_vendor \
	boot

# ===== 方案2 核心：全部注释，不替换系统boot =====
#BOARD_USES_RECOVERY_AS_BOOT := true
#TARGET_NO_RECOVERY := true
#TARGET_RECOVERY_IN_BOOT_IMAGE := true
#BOARD_HAS_NO_RECOVERY_PARTITION := true
#BOARD_BUILD_RECOVERY_IMAGE := false
#BOARD_INCLUDE_RECOVERY_RAMDISK_IN_BOOT := true

# 开启kexec 按键跳转REC
TARGET_RECOVERY_KEXEC_BOOT := true
OF_USE_KEXEC_BOOT := true
TARGET_KEXEC_SUPPORT := true
OF_REC_KEY_VOL_UP_POWER := true

# 动态分区必须
BOARD_USES_METADATA_PARTITION := true
TARGET_RECOVERY_USE_QEMU_STORAGE := true

# A/B OTA 优化脚本
AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_system=true \
	POSTINSTALL_PATH_system=system/bin/otapreopt_script \
	FILESYSTEM_TYPE_system=ext4 \
	POSTINSTALL_OPTIONAL_system=true

# 第一阶段ramdisk（保证系统正常启动）
BOARD_USES_FIRST_STAGE_RAMDISK := true
TARGET_NO_FIRST_STAGE_RAMDISK := false
BOARD_GENERIC_RAMDISK_OUT := $(DEVICE_PATH)/ramdisk
BOARD_MOUNT_GENERIC_RAMDISK := true

# ----------------------------
# 设备 CPU 架构配置
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
# 引导加载程序配置
# ----------------------------
TARGET_BOOTLOADER_BOARD_NAME := k69v1_64
TARGET_NO_BOOTLOADER := true

# ----------------------------
# 屏幕显示配置
# ----------------------------
TARGET_SCREEN_DENSITY := 320

# ----------------------------
# 内核与 Boot 镜像基础参数
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

# ----------------------------
# 预编译内核
# ----------------------------
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
# 分区与文件系统配置
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
BOARD_5G_DYNAMIC_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_5G_DYNAMIC_DYNAMIC_PARTITIONS_SIZE := 9122611200

# ----------------------------
# 设备平台配置
# ----------------------------
TARGET_BOARD_PLATFORM := mt6768

# ----------------------------
# Recovery 文件系统支持
# ----------------------------
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# ----------------------------
# 安全补丁 / 版本
# ----------------------------
VENDOR_SECURITY_PATCH := 2021-08-01
PLATFORM_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# ----------------------------
# AVB 验证启动
# ----------------------------
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# ----------------------------
# TWRP 通用配置
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

# --------------------------
# MTP 文件传输
# --------------------------
TW_MTP_DEVICE := /sdcard
TW_USB_VENDOR_ID := 0x0e8d
TW_USB_PRODUCT_ID := 0x201c
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

# --------------------------
# OrangeFox 配置
# --------------------------
OF_MAINTAINER := xy
OF_NO_ADDON := true
OF_DISABLE_ADB_AUTH := true

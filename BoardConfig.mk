#
# SPDX-License-Identifier: Apache-2.0
#

# 定义当前设备路径（固定，不能乱改）
DEVICE_PATH := device/5g/L39_IVVI_4_64_V80M60BP_NZW_BT30

# 允许使用最小化源码清单编译（TWRP专用）
ALLOW_MISSING_DEPENDENCIES := true

# ----------------------------
# A/B 分区 + Recovery 内置到 Boot 分区核心配置
# ----------------------------
# 启用 A/B 无缝更新支持
AB_OTA_UPDATER := true
# 参与 A/B 升级的分区列表
AB_OTA_PARTITIONS += \
	system \
	product \
	vendor \
	vbmeta_system \
	vbmeta_vendor \
	boot

# 关键：使用 Boot 分区同时承载 Android 系统和 Recovery（无独立 Recovery 分区）
BOARD_USES_RECOVERY_AS_BOOT := true
# 系统没有独立 recovery 分区
TARGET_NO_RECOVERY := true
# Recovery 镜像内置在 boot 分区中
TARGET_RECOVERY_IN_BOOT_IMAGE := true
# 设备不存在 recovery 分区
BOARD_HAS_NO_RECOVERY_PARTITION := true
# 不单独编译 recovery.img（因为集成在 boot 里）
BOARD_BUILD_RECOVERY_IMAGE := false
# 将 Recovery ramdisk 打包进 boot 镜像
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_BOOT := true

# 启用元数据分区（动态分区必须）
BOARD_USES_METADATA_PARTITION := true
# Recovery 使用 QEMU 存储驱动
TARGET_RECOVERY_USE_QEMU_STORAGE := true

# A/B 系统 OTA 后安装优化脚本配置
AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_system=true \
	POSTINSTALL_PATH_system=system/bin/otapreopt_script \
	FILESYSTEM_TYPE_system=ext4 \
	POSTINSTALL_OPTIONAL_system=true

# ----------------------------------------------------------------
# 第一阶段 ramdisk 修复配置（解决 Unable to parse vendor fstab）
# ----------------------------------------------------------------
# 使用第一阶段 ramdisk
BOARD_USES_FIRST_STAGE_RAMDISK := true
# 不关闭第一阶段 ramdisk
TARGET_NO_FIRST_STAGE_RAMDISK := false

# 【修复1】强制指定Recovery挂载配置文件
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
BOARD_RECOVERY_RAMDISK_FSTAB := $(DEVICE_PATH)/recovery.fstab

# ----------------------------
# 设备 CPU 架构配置
# ----------------------------
# 主架构：64 位 ARM
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

# 副架构：32 位 ARM（兼容库）
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# APEX 镜像使用扁平格式（旧机型兼容）
OVERRIDE_TARGET_FLATTEN_APEX := true

# ----------------------------
# 引导加载程序配置
# ----------------------------
# Bootloader 设备名称
TARGET_BOOTLOADER_BOARD_NAME := k69v1_64
# 无需单独编译 bootloader
TARGET_NO_BOOTLOADER := true

# ----------------------------
# 屏幕显示配置
# ----------------------------
# 屏幕像素密度
TARGET_SCREEN_DENSITY := 320

# ----------------------------
# 内核与 Boot 镜像基础参数
# ----------------------------
# Boot 镜像头部版本
BOARD_BOOTIMG_HEADER_VERSION := 2
# 内核基地址
BOARD_KERNEL_BASE := 0x40078000
# 内核启动命令行参数
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user ro.verified.status=verified droi.magic=86F31946579580B3780EE79D4B61A815
# 内核页大小
BOARD_KERNEL_PAGESIZE := 2048
# Ramdisk 偏移地址
BOARD_RAMDISK_OFFSET := 0x07c08000
# 内核标签偏移地址
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
# 编译 boot 镜像额外参数
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
# 内核镜像文件名
BOARD_KERNEL_IMAGE_NAME := Image

# ----------------------------
# 使用预编译内核（不编译源码内核）
# ----------------------------
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
# 预编译内核路径
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
# 设备树二进制文件路径
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
# 把 DTB 写入 boot 镜像
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
# 跳过安卓自带 DTB 编译
BOARD_SKIP_ANDROID_DTB_BUILD := true
endif

# 不使用内核源码编译
TARGET_KERNEL_SOURCE :=
TARGET_KERNEL_CONFIG :=

# ----------------------------
# 分区与文件系统配置
# ----------------------------
# 闪存块大小
BOARD_FLASH_BLOCK_SIZE := 131072
# Boot 分区大小 32MB
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432

# 支持大文件系统
BOARD_HAS_LARGE_FILESYSTEM := true
# 系统分区格式
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
# 数据分区格式
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
# 厂商分区格式
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
# 拷贝 vendor 分区输出
TARGET_COPY_OUT_VENDOR := vendor

# Super 动态分区总大小
BOARD_SUPER_PARTITION_SIZE := 9126805504
# Super 分区组名称
BOARD_SUPER_PARTITION_GROUPS := 5g_dynamic_partitions
# 动态分区包含的子分区
BOARD_5G_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
# 动态分区可用空间
BOARD_5G_DYNAMIC_PARTITIONS_SIZE := 9122611200

# 【修复3】开启super dm设备软链接生成，解决dm-0/dm-1链接失效
TWRP_SUPER_SYMLINKS := true
orangefox.super.partition := true

# ----------------------------
# 设备平台配置
# ----------------------------
# 芯片平台：MT6768
TARGET_BOARD_PLATFORM := mt6768
# 标记联发科平台，加载MTK专属权限适配
TARGET_MTK_PLATFORM := mt6768
# MTK动态Super分区补丁开关
BOARD_MTK_DYNAMIC_SUPER := true

# ----------------------------
# Recovery 文件系统挂载全局参数
# ----------------------------
# 支持 ext4 格式
TARGET_USERIMAGES_USE_EXT4 := true
# 支持 f2fs 格式
TARGET_USERIMAGES_USE_F2FS := true
# 【修复4】全局挂载参数，解决ext4 vendor权限拒绝
BOARD_RECOVERY_MOUNT_OPTIONS := ro,seclabel,allow_discard,errors=reboot

# ----------------------------
# 安全补丁版本
# ----------------------------
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# ----------------------------
# AVB/Verity 核心修复（解决vendor Permission denied）
# ----------------------------
# 系统AVB保持开启
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
# 【修复5】Recovery绕过dm-verity校验，彻底拦截挂载拒绝
TW_IGNORE_AVB := true
TW_NO_VERITY := true
TW_ROLLBACK_IGNORE := true

# 【修复6】允许Recovery修改系统属性，消除error code:0xb报错
TW_ALTER_PROP_ALLOW_ALL := true

# ----------------------------
# TWRP 通用基础配置
# ----------------------------
# Recovery 主题：竖屏高清
TW_THEME := portrait_hdpi
# 支持多语言
TW_EXTRA_LANGUAGES := true
# 启动黑屏防闪烁
TW_SCREEN_BLANK_ON_BOOT := true
# 屏蔽异常触摸设备
TW_INPUT_BLACKLIST := "hbtp_vm"
# 使用精简toolbox
TW_USE_TOOLBOX := true
# 镜像解包打包工具
TW_INCLUDE_REPACKTOOLS := true
# 【修复7】内置logcat，解决sh: /system/bin/logcat: inaccessible
TW_INCLUDE_LOGCAT := true
# 文件系统修复工具
TW_INCLUDE_FSCK_TOOLS := true
# 内置vintf解析，修复找不到manifest
TW_INCLUDE_VINTF := true

# 屏幕亮度配置
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1024
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness

# --------------------------
# MTP / OTG USB 修复（消除 E:Unknown File System: '/devices/platform/mt_usb*'）
# --------------------------
# MTP内置存储挂载路径
TW_MTP_DEVICE := /sdcard
# MTK USB VID/PID
TW_USB_VENDOR_ID := 0x0e8d
TW_USB_PRODUCT_ID := 0x201c
TW_USE_MODEL_HARDWARE_ID_FOR_USB := true
# 【修复8】开启USB外置存储，关闭禁用开关
TW_USB_STORAGE := true
TW_NO_USB_STORAGE := false
# MTK USB fstab规则过滤，消除未知文件系统警告
TW_USB_FILTER_MTK := true

# --------------------------
# OrangeFox 专属修复开关（匹配日志orangefox.*属性）
# --------------------------
# 维护者名称
OF_MAINTAINER := xy
# 不加载附加组件
OF_NO_ADDON := true
# 【修复9】开启权限替换，对应日志 ro.orangefox.substitute_permissions=1
OF_SUBSTITUTE_PERMISSIONS := true
# 【修复10】开机自动SELinux宽容模式，根除Permission denied
OF_FORCE_PERMISSIVE_SELINUX := true
# 【修复11】启用system_root模式，读取system/build.prop
OF_USE_SYSTEM_ROOT := true
# SAR分区兼容
OF_PROPER_SAR := true
# 强制加载vendor vintf清单文件
OF_LOAD_VENDOR_VINTF := true
# 忽略prop缺失告警，修复无法识别ROM
OF_IGNORE_PROP_MISS := false
# 日志Virtual_AB: no，关闭虚拟AB
TW_VIRTUAL_AB := false

# --------------------------
# SELinux 权限补丁路径声明
# --------------------------
# 自定义Recovery sepolicy路径
TARGET_RECOVERY_SEPOLICY := $(DEVICE_PATH)/sepolicy/recovery.te
# 完整SELinux支持
TW_FULL_SELINUX_SUPPORT := true

#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm845
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
  boot \
  system \
  vendor
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
PRODUCT_PACKAGES += \
  update_engine \
  update_verifier
TARGET_USES_UEFI := true


# Android Verified Boot #For later usage
#BOARD_AVB_ENABLE := false
#BOARD_BUILD_DISABLED_VBMETAIMAGE := true

# Kernel
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 service_locator.enable=1 swiotlb=2048 androidboot.configfs=true firmware_class.path=/vendor/firmware_mnt/image loop.max_part=7 zram.backend=z3fold loop.max_part=7 panic_on_err=1 msm_drm.dsi_display0=dsi_panel_cmd_display:config0 buildvariant=user
BOARD_KERNEL_CMDLINE += skip_override androidboot.fastboot=1
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000
TARGET_PREBUILT_KERNEL := device/sony/akari/prebuilt/Image.gz-dtb

# Platform
TARGET_BOARD_PLATFORM := sdm845
TARGET_BOARD_PLATFORM_GPU := qcom-adreno630

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4227858432
# Reserve space for data encryption (44712771584-16384)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 44712755200
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 1056714752
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true

# TWRP specific build flags
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_SUPERSU := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 1023
TW_THEME := portrait_hdpi
TARGET_RECOVERY_DEVICE_MODULES += android.hardware.boot@1.0
TW_RECOVERY_ADDITIONAL_RELINK_FILES := ${OUT}/system/lib64/android.hardware.boot@1.0.so
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TW_NO_SCREEN_BLANK := true

# Encryption
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2025-12-31
TW_INCLUDE_CRYPTO := true
#TARGET_KEYMASTER_WAIT_FOR_QSEE := true
#TW_INCLUDE_FBE := true

# Extras
# Disable secure discard because it's SLOW
BOARD_SUPPRESS_SECURE_ERASE := true
TW_USE_LEDS_HAPTICS := true

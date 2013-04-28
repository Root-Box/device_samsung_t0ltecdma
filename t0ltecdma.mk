#
# Copyright (C) 2012 The CyanogenMod Project
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

LOCAL_PATH := device/samsung/t0ltecdma

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.smdk4x12.rc:root/init.smdk4x12.rc \
    $(LOCAL_PATH)/init.smdk4x12.usb.rc:root/init.smdk4x12.usb.rc \
    $(LOCAL_PATH)/ueventd.smdk4x12.rc:root/ueventd.smdk4x12.rc \
    $(LOCAL_PATH)/init.bt.rc:root/init.bt.rc \
    $(LOCAL_PATH)/lpm.rc:root/lpm.rc \
    $(LOCAL_PATH)/ueventd.smdk4x12.rc:recovery/root/ueventd.smdk4x12.rc

# Audio
PRODUCT_PACKAGES += \
    tiny_hw

# GPS
PRODUCT_COPY_FILES += \
    device/samsung/t0ltecdma/configs/gps.conf:system/etc/gps.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/Diag_zero.cfg:system/etc/Diag_zero.cfg \
    $(LOCAL_PATH)/configs/Diag.cfg:system/etc/Diag.cfg \
    $(LOCAL_PATH)/configs/nvram_net.txt:system/etc/wifi/nvram_net.txt

# Camera
COMMON_GLOBAL_CFLAGS += -DCAMERA_WITH_CITYID_PARAM

# Product specific Packages
PRODUCT_PACKAGES += \
    GalaxyNote2Settings \
    SamsungServiceMode

# NFC
PRODUCT_PACKAGES += \
    nfc.exynos4 \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag

PRODUCT_COPY_FILES += \
    packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
    frameworks/base/nfc-extras/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access_debug.xml
endif

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    Stk

$(call inherit-product, $(LOCAL_PATH)/configs/nfc_enhanced.mk)

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril_class=SamsungCDMAQualcommRIL \
    mobiledata.interfaces=pdp0,wlan0,gprs,ppp0,rmnet_usb0 \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml

#Misc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/secomxregistry:/system/etc/secomxregistry \
    $(LOCAL_PATH)/configs/security_profile.dat:/system/etc/security_profile.dat

# Include common makefile
$(call inherit-product, device/samsung/smdk4412-common/common.mk)
$(call inherit-product, device/samsung/smdk4412-qcom-common/common.mk)

$(call inherit-product-if-exists, vendor/samsung/t0ltecdma/t0ltecdma-vendor.mk)

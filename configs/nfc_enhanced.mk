# Set LOCAL_PATH
LOCAL_PATH := device/samsung/t0ltecdma

# This device supports CM enhanced NFC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/com.cyanogenmod.nfc.enhanced.xml:system/etc/permissions/com.cyanogenmod.nfc.enhanced.xml

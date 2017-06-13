# Copyright (C) 2015 The Android Open Source Project
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
DEVICE_PACKAGE_OVERLAYS := device/nextbit/robin/overlay

TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

# copy customized media_profiles and media_codecs xmls for 8992
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/nextbit/robin/media/media_profiles.xml:system/etc/media_profiles.xml \
                      device/nextbit/robin/media/media_codecs.xml:system/etc/media_codecs.xml \
                      device/nextbit/robin/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml
endif  #TARGET_ENABLE_QC_AV_ENHANCEMENTS

$(call inherit-product, device/nextbit/robin/common64.mk)

# This jar is needed for MSIM manual provisioning and for other
# telephony related functionalities to work
PRODUCT_BOOT_JARS += qti-telephony-common

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8992/msm8992.mk

PRODUCT_COPY_FILES += \
    device/nextbit/robin/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    device/nextbit/robin/audio/mixer_paths.xml:system/etc/mixer_paths.xml

PRODUCT_PACKAGES += audiod

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/nextbit/robin/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/nextbit/robin/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/nextbit/robin/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/wifi/WCNSS_qcom_wlan_nv.bin

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_PACKAGES += \
    wpa_supplicant \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/nextbit/robin/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:system/etc/permissions/android.hardware.sensor.relative_humidity.xml

PRODUCT_COPY_FILES += \
    device/nextbit/robin/sensors/hals.conf:system/etc/sensors/hals.conf

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

PRODUCT_PACKAGES += \
    sensors.msm8992

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res \
        $(PRODUCT_PACKAGE_OVERLAYS)

# QPerformance
PRODUCT_BOOT_JARS += QPerformance

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# Fingerprint
PRODUCT_PACKAGES += fingerprintd
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml

# NFC
PRODUCT_COPY_FILES += \
    device/nextbit/robin/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
    device/nextbit/robin/nfc/libnfc-nxp.conf:system/etc/libnfc-nxp.conf \
    device/nextbit/robin/nfc/nfcee_access.xml:system/etc/nfcee_access.xml

# NextBit specific Ramdisk scripts
PRODUCT_PACKAGES += \
    init.fih.fqcaudio.rc \
    init.fih.nbq.rc \
    init.nbq.charger.rc \
    init.nbq.fingerprint.rc \
    init.nbq.fs.rc \
    init.nbq.lcm.rc \
    init.nbq.led.rc \
    init.nbq.poweroff_charging.rc \
    init.nbq.smartamp.rc \
    init.nbq.smartamp.sh \
    init.nbq.smartamp_mode.sh \
    init.nbq.smartamp_post.sh \
    init.nbq.target.rc \
    init.qcom.fs.rc \
    init.qcom.target.rc

# Tools
PRODUCT_PACKAGES += \
    libxml2 \
    libtinyxml \
    libtinyxml2 \
    libjson \
    libprotobuf-cpp-full

# Amplifier
PRODUCT_PACKAGES += \
    audio_amplifier.msm8992

# Media
PRODUCT_PACKAGES += \
    libOmxSwVencHevc \
    libOmxVidcCommon \
    libstagefright_soft_flacenc

# Call the proprietary setup
$(call inherit-product-if-exists, vendor/nextbit/robin/robin-vendor.mk)

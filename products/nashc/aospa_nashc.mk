#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_nashc, $(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
# Precompile the framework boot image to avoid compiling it on the phone.
OVERRIDE_DISABLE_DEXOPT_ALL := false

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/realme/nashc/device.mk)

# Inherit the AOSPA product configuration.
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_INCLUDE_GOOGLE_APPS := false
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

ifeq ($(TARGET_INCLUDE_GOOGLE_APPS),false)
PRODUCT_PACKAGES += \
    Dialer \
    LatinIME
endif

# Override the inherited ART default: this 4.19 kernel has no userfaultfd.
PRODUCT_ENABLE_UFFD_GC := false

PRODUCT_NAME := aospa_nashc
PRODUCT_DEVICE := nashc
PRODUCT_MANUFACTURER := realme
PRODUCT_BRAND := Realme
PRODUCT_MODEL := RMX3085

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildFingerprint=realme/RMX3085/RMX3085L1:13/SP1A.210812.016/R.1913398-178f6:user/release-keys \
    DeviceName=RMX3085L1 \
    DeviceProduct=RMX3085 \
    SystemDevice=RMX3085L1 \
    SystemName=RMX3085

# AOSPA already provides the Lineage charging-control interface and service.
PRODUCT_SOURCE_ROOT_DIRS += -hardware/lineage/interfaces/health

# Nashc uses the Oplus hardware services and ships the AOSPA settings apps.
PRODUCT_SOURCE_ROOT_DIRS += -hardware/oplus/packages -hardware/oplus/audio_amplifier

# These Qualcomm vendor components require headers and libraries from Qualcomm device trees.
PRODUCT_SOURCE_ROOT_DIRS += \
    -hardware/qcom/bootctrl \
    -vendor/qcom/common/vendor \
    -vendor/qcom/opensource/data-ipa-cfg-mgr \
    -vendor/qcom/opensource/data-ipa-cfg-mgr-legacy \
    -vendor/qcom/opensource/dataservices/rmnetctl \
    -vendor/qcom/opensource/libvmmem \
    -vendor/qcom/opensource/recovery-ext/oem-recovery \
    -vendor/qcom/opensource/thermal-hal

endif

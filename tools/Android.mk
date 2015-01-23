LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := cch_zip_static
LOCAL_MODULE_FILENAME := zip
LOCAL_SRC_FILES := $(TARGET_ARCH_ABI)/libzip.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../include
include $(PREBUILT_STATIC_LIBRARY)

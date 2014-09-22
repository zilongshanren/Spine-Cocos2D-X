LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := spine_static
LOCAL_MODULE_FILENAME := spine
LOCAL_SRC_FILES := $(TARGET_ARCH_ABI)/libspine.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../include
include $(PREBUILT_STATIC_LIBRARY)

# Copyright (C) 2008 The Android Open Source Project
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


LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false
LOCAL_SHARED_LIBRARIES := liblog libutils libcutils libexynosutils libexynosv4l2 libhwcutils libdisplay libhwcutilsmodule libmpp

ifeq ($(BOARD_USES_GSC_VIDEO), true)
	LOCAL_CFLAGS += -DGSC_VIDEO
else
ifeq ($(BOARD_USES_VP_VIDEO),true)
	LOCAL_CFLAGS += -DVP_VIDEO
endif
endif

LOCAL_CFLAGS += -DLOG_TAG=\"hdmi\"

ifeq ($(BOARD_USES_FIMC), true)
	LOCAL_CFLAGS += -DUSES_FIMC
endif

ifeq ($(BOARD_USES_VIRTUAL_DISPLAY), true)
	LOCAL_CFLAGS += -DUSES_VIRTUAL_DISPLAY
endif

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../libhwcutils \
	$(LOCAL_PATH)/../libdisplay \
	$(LOCAL_PATH)/../libhwc \
	$(TOP)/hardware/samsung_slsi/$(TARGET_BOARD_PLATFORM)/include \
	$(TOP)/hardware/samsung_slsi/exynos/libexynosutils \
	$(TOP)/hardware/samsung_slsi/$(TARGET_SOC)/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_SOC)/libhwcmodule \
	$(TOP)/hardware/samsung_slsi/$(TARGET_SOC)/libhwcutilsmodule \
        $(TOP)/system/core/libsync/include \
	$(TOP)/hardware/samsung_slsi/exynos/libmpp

LOCAL_ADDITIONAL_DEPENDENCIES += \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_SRC_FILES := \
	ExynosExternalDisplay.cpp

ifneq ($(filter 3.10, $(TARGET_LINUX_KERNEL_VERSION)),)
LOCAL_SRC_FILES += \
	dv_timings.c
LOCAL_CFLAGS += -DUSE_DV_TIMINGS
endif

LOCAL_MODULE_TAGS := eng
LOCAL_MODULE := libhdmi
include $(BUILD_SHARED_LIBRARY)


############################################################################
#			ATBM WiFi Product Select
#CONFIG_ATBM601x: 1T1R 80211b/g/n, HT20
#if yout want to change .conf, please do make menuconfig in current path
############################################################################
-include $(src)/.config

############################################################################
#
#	The Following Code Of The Makefile Should Not Be Changed
#
############################################################################
PWD := $(shell pwd)
WIFI_INSTALL_DIR := $(PWD)/output

NOSTDINC_FLAGS := -I$(src)/include/ \
	-include $(src)/include/linux/compat-2.6.h \
	-DCOMPAT_STATIC

#####################################################
export
ifeq ($(CONFIG_ATBM_MODULE_NAME),)
CONFIG_ATBM_MODULE_NAME = atbm_wifi
endif

ifeq ($(CONFIG_ATBM_WIFIIF1_NAME),)
CONFIG_ATBM_WIFIIF1_NAME = "wlan%d"
endif

ifeq ($(CONFIG_ATBM_WIFIIF2_NAME),)
CONFIG_ATBM_WIFIIF2_NAME = "p2p%d"
endif

ifeq ($(CONFIG_ATBM_USB_VID),)
CONFIG_ATBM_USB_VID = 0x007a
endif

ifeq ($(CONFIG_ATBM_USB_PID),)
CONFIG_ATBM_USB_PID = 0x8888
endif

ifeq ($(CONFIG_ATBM_SDIO_VID),)
CONFIG_ATBM_SDIO_VID = 0x007a
endif

ifeq ($(CONFIG_ATBM_SDIO_PID),)
CONFIG_ATBM_SDIO_PID = 0x6011
endif

ifeq ($(CONFIG_ATBM_MODULE_DRIVER_NAME),)
CONFIG_ATBM_MODULE_DRIVER_NAME = "atbm_wlan"
endif

ifeq ($(CONFIG_ATBM_PLATFORM_DEVICE_NAME),)
CONFIG_ATBM_PLATFORM_DEVICE_NAME = "atbm_dev_wifi"
endif

ifeq ($(CONFIG_ATBM_MODULE_PM_STAYAWK),)
CONFIG_ATBM_PLATFORM_DEVICE_NAME = "pm_stayawake"
endif

ifeq ($(CONFIG_ATBM_FW_NAME),)
CONFIG_ATBM_FW_NAME="fw.bin"
endif

export
SDIO_HOST      ?= $(shell echo $(CONFIG_ATBM_SDIO_MMCx))
IF1NAME        ?= $(shell echo $(CONFIG_ATBM_WIFIIF1_NAME))
IF2NAME        ?= $(shell echo $(CONFIG_ATBM_WIFIIF2_NAME))
FW             ?= $(shell echo $(CONFIG_ATBM_FW_NAME))
MODULES_NAME   ?= $(shell echo $(CONFIG_ATBM_MODULE_NAME))
USBVID		   ?= $(shell echo $(CONFIG_ATBM_USB_VID))
USBPID		   ?= $(shell echo $(CONFIG_ATBM_USB_PID))
SDIOVID			?=$(shell echo $(CONFIG_ATBM_SDIO_VID))
SDIOPID			?=$(shell echo $(CONFIG_ATBM_SDIO_PID))
MODDRVNAME	   ?= $(shell echo $(CONFIG_ATBM_MODULE_DRIVER_NAME))
PLFDEVNAME	   ?= $(shell echo $(CONFIG_ATBM_PLATFORM_DEVICE_NAME))
MODPMSTAYAWK   ?= $(shell echo $(CONFIG_ATBM_MODULE_PM_STAYAWK))

SAEAUTHEN      ?= $(CONFIG_ATBM_FUNC_SAE_AUTHEN)
LOAD_FW_H      ?= $(CONFIG_ATBM_USE_FIRMWARE_H)
SKB_DEBUG      ?= $(CONFIG_ATBM_FUNC_SKB_DEBUG)
MEM_DEBUG      ?= $(CONFIG_ATBM_FUNC_SKB_DEBUG)
BRIDGE         ?= $(CONFIG_ATBM_SUPPORT_BRIDGE)
MONITOR        ?= $(CONFIG_ATBM_FUNC_MONITOR)
EARLYSUSPEND   ?= $(CONFIG_ATBM_FUNC_EARLYSUSPEND)
NOTXCONFIRM    ?= $(CONFIG_ATBM_FUNC_NOTXCONFIRM)
CH5G           ?= $(CONFIG_ATBM_FUNC_CHANNEL_5G_PRETEND_2G)
ONLY_HT20		?= $(CONFIG_ATBM_WITHBAND_ONLY_HT20)
USBAGGTX       ?= $(CONFIG_ATBM_FUNC_USB_AGGRTX)
USBDMABUFF     ?= $(CONFIG_ATBM_FUNC_USB_DMABUFF)
USBCMDENHANCE  ?= $(CONFIG_ATBM_FUNC_USB_CMD_ENHANCE)
USBDATAENHANCE ?= $(CONFIG_ATBM_FUNC_USB_DATA_ENHANCE)
PMRELODDFW     ?= $(CONFIG_ATBM_FUNC_PS_WAKEUP_RELOAD_FW)
USB_BUS        ?= $(CONFIG_ATBM_USB_BUS)
SDIO_BUS       ?= $(CONFIG_ATBM_SDIO_BUS)
SPI_BUS        ?= $(CONFIG_ATBM_SPI_BUS)
CHECKSUM       ?= $(CONFIG_ATBM_FUNC_HW_CHSUM)
SWRATECTRL     ?= $(CONFIG_ATBM_SW_RATE_CTRL)
P2PENABLE      ?= $(CONFIG_ATBM_FUNC_P2P_ENABLE)
SWENC          ?= $(CONFIG_ATBM_FUNC_SW_ENC)
MODULEFS       ?= $(CONFIG_ATBM_FUNC_MODULE_FS)
DEVCTRL        ?= $(CONFIG_ATBM_FUNC_DEV_CTRL_API)
SMARTCONFIG    ?= $(CONFIG_ATBM_FUNC_SMARTCONFIG)
CONFIG_ATHENAB ?= $(CONFIG_ATBM601x)$(CONFIG_ATBM602x)
CONFIG_ARESB   ?= $(CONFIG_ATBM603x)
CONFIG_HERA    ?= $(CONFIG_ATBM6041)
NEED_SCOND_INTERFACE ?= $(CONFIG_NEED_P2P0_INTERFACE)
CUSTORMSPECIAL ?= y
CONFIG_NOT_SUPPORT_40M_CHW ?= $(CONFIG_ATBM601x)
DRVLOADERFAST  ?= $(CONFIG_ATBM_FUNC_DRV_LOADER_FAST)
PRI_IE         ?= $(CONFIG_ATBM_FUNC_PRIVE_IE)
MONHDRPRISM         ?= $(CONFIG_ATBM_FUNC_MONITOR_HDR_PRISM)

##################################################
#ATBM6041 only use SDIO
ifeq ($(CONFIG_HERA),y)
SDIO_BUS=y
endif

ifeq ($(CONFIG_ATBM_SDIO_24M),y)
ifeq ($(CONFIG_ATHENAB),y)
CONFIG_ATHENAB_24M=y
CONFIG_ATHENAB=n
endif
endif

MULT_NAME=y
ATBM_MAKEFILE_SUB=y

#####################################################
export
ifeq ($(CONFIG_ATBM_APOLLO),)
CONFIG_ATBM_APOLLO=m
endif

############################################
export
-include $(src)/Makefile.build.kernel

export
ATBM_WIFI__EXT_CCFLAGS = -DATBM_WIFI_PLATFORM=31

export DRIVER_PATH ?= $(PWD)

################### WIRELESS #########################
ifeq ($(USB_BUS),y)
HIF := usb
endif

ifeq ($(SDIO_BUS),y)
HIF := sdio
endif

ifeq ($(SPI_BUS),y)
HIF := spi
endif

all: get_ver modules install

get_ver:
	@echo "**************************************"
	@echo "driver version"
	@cat hal_apollo/svn_version.h | awk '{print $3}'
	@echo "**************************************"

modules: clean
	@echo "arch=$(ARCH)"
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(shell pwd) modules

strip:
	$(CROSS_COMPILE)strip $(WIFI_INSTALL_DIR)/$(MODULES_NAME).ko --strip-unneeded

menuconfig:
	$(MAKE) -C atbm_kconf clean
	$(MAKE) -C atbm_kconf mconf -f Makefile
	@atbm_kconf/mconf atbm_kconf/Kconfig

install: modules
	mkdir -p $(WIFI_INSTALL_DIR)
	chmod 777 $(WIFI_INSTALL_DIR)
	cp hal_apollo/*.ko $(WIFI_INSTALL_DIR)

clean: hal_clean
	rm -rf hal_apollo/*.o
	rm -rf hal_apollo/*.ko
	rm -rf hal_apollo/modules.order
	rm -rf modules.* Module.*
	rm -rf .tmp_versions/

hal_clean:
	rm -rf hal_apollo/*.ko
	rm -rf hal_apollo/*.o
	rm -rf hal_apollo/*.mod.c
	rm -rf hal_apollo/*.cmd
	rm -rf hal_apollo/.*.cmd
	rm -rf hal_apollo/modules.order
	rm -rf hal_apollo/mac80211/*.cmd
	rm -rf hal_apollo/mac80211/.*.cmd
	rm -rf hal_apollo/mac80211/*.o
	rm -rf driver_install/*.ko
	rm -rf .tmp_versions/

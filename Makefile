ifneq ($(CROSS_COMPILE),)
CROSS-COMPILE:=$(CROSS_COMPILE)
endif
#CROSS-COMPILE:=/workspace/buildroot/buildroot-qemu_mips_malta_defconfig/output/host/usr/bin/mips-buildroot-linux-uclibc-
#CROSS-COMPILE:=/workspace/buildroot/buildroot-qemu_arm_vexpress_defconfig/output/host/usr/bin/arm-buildroot-linux-uclibcgnueabi-
#CROSS-COMPILE:=/workspace/buildroot-git/qemu_mips64_malta/output/host/usr/bin/mips-gnu-linux-
ifeq ($(CC),cc)
CC:=$(CROSS-COMPILE)gcc
endif
LD:=$(CROSS-COMPILE)ld

QL_CM_SRC=QmiWwanCM.c GobiNetCM.c main.c MPQMUX.c QMIThread.c util.c udhcpc.c qmap_bridge_mode.c mbim-cm.c device.c

release: clean qmi-proxy
	$(CC) -Wall -s ${QL_CM_SRC} -o quectel-CM -lpthread -ldl

debug: clean
	$(CC) -Wall -g -DCM_DEBUG ${QL_CM_SRC} -o quectel-CM -lpthread -ldl

qmi-proxy:
	$(CC) -Wall -s quectel-qmi-proxy.c  -o quectel-qmi-proxy -lpthread -ldl

clean:
	rm -rf quectel-CM *~
	rm -rf quectel-qmi-proxy

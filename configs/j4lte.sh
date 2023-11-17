#!/bin/bash

cat ./BootShim/AARCH64/BootShim.bin "./Build/j4ltePkg-AARCH64/${_TARGET_BUILD_MODE}_CLANG38/FV/J4LTE_UEFI.fd" > ./ImageResources/bootpayload.bin||exit 1

python3 ./ImageResources/mkbootimg.py \
	--kernel ./ImageResources/bootpayload.bin \
	--ramdisk ./ImageResources/ramdisk \
	--dtb "./ImageResources/DTBs/j4lte.dtb" \
	--kernel_offset 0x00000000 \
	--ramdisk_offset 0x00000000 \
	--tags_offset 0x00000000 \
	--dtb_offset 0x00000000 \
	--os_version 13.0.0 \
	--os_patch_level "$(date '+%Y-%m')" \
	--header_version 1 \
	-o boot.img \
	||_error "\nFailed to create Android Boot Image!\n"

# Compress Boot Image in a tar File for Odin/heimdall Flash
tar -c boot.img -f Mu-j4lte.tar||exit 1
mv boot.img Mu-j4lte.img||exit 1
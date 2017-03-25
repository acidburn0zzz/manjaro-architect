#!/usr/bin/bash
#
# mode rescue functions 

# check if efi
mount_test_efi() {
    if [[ "$(ini system.bios)" == "UEFI" ]]; then
        menu_item_insert "home" "efi/esp" "mount_partition efi"
        # TODO: autodetect efi and automount ...
    fi
}

mnu_return(){ return "${1:-98}"; } 

mount_r_partitions() {
    umount_partitions
    mount_partitions "rescue"
}

check_r_mounted(){
    if [[ $(lsblk -o MOUNTPOINT | grep ${MOUNTPOINT}) == "" ]]; then
        DIALOG " $_ErrTitle " --msgbox "\n$_ErrNoMount\n " 0 0
        return "${2:-98}"
    fi
    [[ -n "$1" ]] && $1
    return 0
}

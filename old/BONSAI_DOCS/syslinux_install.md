# BIOS SYSLINUX INSTALL

1. **make sure your drive has the "boot" flag enabled**

    `fdisk /dev/sdX`
    
    Use the 'a' key to toggle bootable flag

2. **make directory and copy files**

    ```bash
    mkdir -p /boot/syslinux
    cp -f /src/pkgs/syslinux/share/syslinux/*.c32 /boot/syslinux/
    cp -f /src/pkgs/syslinux/share/syslinux/*.bin /boot/syslinux/
    ```
3. **install to drive**
   
    ```bash
    extlinux --install /boot/syslinux
    ```

4. **install the MBR**

    ```
    dd bs=440 count=1 conv=notrunc if=/src/pkgs/syslinux/share/syslinux/mbr.bin of=/dev/sdX
    ```

5. **create settings**

    ```bash
    cat > /boot/syslinux/syslinux.cfg << EOF
    PROMPT 0
    TIMEOUT 0
    DEFAULT bonsai

    LABEL bonsai
        LINUX ../vmlinuz
        APPEND root=/dev/sdXx rw
    EOF
    ```
    
    Where `/dev/sdXx` is your **root** partition (not boot)
    
    <sub>NOTE: THESE ARE **TABS** NOT SPACES!</sub>

6. **make sure ext4 filesytem uses 32 bit sizes, (64 incompatible with** `syslinux`)

    ```bash
    e2fsck -f /dev/sdXx 
    resize2fs -s /dev/sdXx
    ```

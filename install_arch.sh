#! /bin/bash
echo
echo
echo "####################################################"
echo "#                                                  #"
echo "#              Arch Linux Auto Install             #"
echo "#                                                  #"
echo "#                               created by N       #"
echo "#                               (2018.07.26)       #"
echo "#                                                  #"
echo "####################################################"
echo
echo


function format_disk ()
{
	disk=`fdisk -l | grep /dev/ | awk '{print $1}'`

	for i in $disk; do
		if [ $i != "Disk" ];then

			while true
			do
				echo -n "Input format Type $i (fat | ext4) : "
				read ftype

				case $ftype in
					"fat") #mkfs.fat -F32 $i
						echo "[ OK ] mkfs.fat -F32 $i"
						echo
						break
						;;
					"ext4") #mkfs.ext4 $i
						echo "[ OK ] mkfs.ext4 $i"
						echo
						break
						;;	
					*) echo "[Error] Do not a format-type"
						echo
						;;
				esac
			done
		fi
	done
}

function mount_disk ()
{
	disk=`fdisk -l | grep /dev/ | awk '{print $1}'`

	for i in $disk; do
		if [ $i != "Disk" ]; then

			dtype=`fdisk -l | grep $i | awk '{print $6,$7}'`
			case $dtype in
				"Linux filesystem") 
					#mount $i /mnt
					echo "[ OK ] mount $i /mnt"
					echo
					continue
					;;
				"EFI System")
					#mkdir /mnt/boot
					echo "[ OK ] mkdir /mnt/boot"
					#mount $i /mnt/boot
					echo "[ OK ] mount $i /mnt/boot"
					echo
					continue
					;;
				"Linux swap")
					#mkswap $i
					echo "[ OK ] mkswap $i"
					#swapon $i
					echo "[ OK ] swapon $i"
					echo
					continue
					;;
			esac
		fi

	done
}


sleep 1

### Step 1. Disk Configuration ###
#cfdisk /dev/sda

### Step 2. Format the disks ###
#format_disk

### Step 3. Mount the disks ###
mount_disk
#cp -f pacman.conf /etc/pacman.conf

### Step 4. Install package ###
#pacstrap /mnt base base-devel
sleep 1
genfstab -U -p /mnt > /mnt/etc/fstab
cat /mnt/etc/fstab

### Step 5. System Configuration ###
arch-chroot /mnt

echo "testing.........."

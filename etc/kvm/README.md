1) Copy the xml definition of your virtual machine from original host to your new host into /etc/libvirt/qemu/
# cp Win7-x64_Cuckoo1.xml /etc/libvirt/qemu/Win7-x64_Cuckoo1.xml

2) Copy the original image too /var/lib/libvirt/images
# cd /var/lib/libvirt/images
# cp Win7-x64_Cuckoo1-sparse.img /var/lib/libvirt/images/Win7-x64_Cuckoo1-sparse.img
Copying sparse file? use rsync instead of cp, otherwise cp will copy the full size of file
http://dougsland.livejournal.com/118882.html

3) Create necessary virtual network
# sudo virsh net-define lab-network.xml
If not started:
# sudo virsh net-start lab-network

4) Use virsh to enable your the virtual machine
# sudo virsh define /etc/libvirt/qemu/Win7-x64_Cuckoo1.xml
in case of error: "Cannot check QEMU binary /usr/libexec/qemu-kvm: No such file or directory": 
Edit the XML and change the <emulator> element to point to the real location of the qemu binary.

5) Create snapshot
# sudo virsh snapshot-create-as --domain Win7-x64_Cuckoo1 --name Clean-R



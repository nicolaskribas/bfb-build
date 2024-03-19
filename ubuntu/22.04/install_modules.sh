#!/bin/sh

mkdir /tmp/modules
cd /tmp/modules

# list of BlueField Linux drivers taken from:
# https://docs.nvidia.com/networking/display/bluefielddpuosv460/installing+popular+linux+distributions+on+bluefield#src-2571331403_InstallingPopularLinuxDistributionsonBlueField-BlueFieldLinuxDrivers
# installing only the ones that are not in upstream: ipmb-host mlxbf-livefish mlxbf-pka mlx-trio
for driver in ipmb-host-1.0 mlxbf-livefish-1.0 mlxbf-pka-1.0 mlx-trio-0.2
do
	wget -q https://linux.mellanox.com/public/repo/bluefield/4.6.0-13035/extras/SOURCES/${driver}.tar.gz
	tar xzf ${driver}.tar.gz
	rm ${driver}.tar.gz
	mv ${driver} /usr/src
	echo "$driver" | sed 's/\(.*\)-/\1\//' | xargs dkms install -k "$(/bin/ls -1tr /lib/modules | tail -1)/$(uname -m)"
done

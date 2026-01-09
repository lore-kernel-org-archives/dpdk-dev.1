Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67FD232C8
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 07:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5656A402A7;
	Fri,  9 Jan 2026 08:05:14 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6E43F400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 08:05:12 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2B8A1471C3; Fri,  9 Jan 2026 08:05:12 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1866] [dpdk-23.11.6rc1][Cryptodev][LTS test]
 virtio_perf_cryptodev_func/testvirtio_aes_cbc_sha1_hmac: Failed to use virtio
 device - Segmentation fault
Date: Fri, 09 Jan 2026 07:05:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yux.jiang@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1866-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

http://bugs.dpdk.org/show_bug.cgi?id=3D1866

            Bug ID: 1866
           Summary: [dpdk-23.11.6rc1][Cryptodev][LTS test]
                    virtio_perf_cryptodev_func/testvirtio_aes_cbc_sha1_hma
                    c: Failed to use virtio device - Segmentation fault
           Product: DPDK
           Version: 23.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

[DPDK Version]
commit 63864b90e2bf91b38d9f4accb588c52ed90cac4e (HEAD -> v23.11.6-rc1, tag:
v23.11.6-rc1, origin/23.11, 23.11)
Author: Shani Peretz <shperetz@nvidia.com>
Date:   Tue Jan 6 15:04:17 2026 +0200

    version: 23.11.6-rc1

    Signed-off-by: Shani Peretz <shperetz@nvidia.com>


[Reproduce]
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Dlibdir=3Dlib --default-library=3Dstatic x86_64-native-linu=
xapp-gcc
ninja -C x86_64-native-linuxapp-gcc
meson configure -Dexamples=3Dvhost_crypto x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

SW Device:
rm -r /tmp/*
x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto -l 1,2,3 -a 0000:00:0=
0.0
--vdev crypto_aesni_mb_pmd_1 --socket-mem 2048,0 -n 4 -- --config
"(2,0,0),(3,0,0)" --socket-file 2,/tmp/vm0_crypto0.sock
--socket-file=3D3,/tmp/vm0_crypto1.sock

Create a NIC VF:
echo 1 > /sys/bus/pci/devices/0000\:3b\:00.0/sriov_numvfs
usertools/dpdk-devbind.py --bind=3Dvfio-pci 0000:3b:02.0

lsof -n -i:6600
taskset -c 11,12,13,14,15,16,17,18 /root/qemu-2.12/bin/qemu-system-x86_64=20
-name vm0 -enable-kvm -pidfile /tmp/.vm0.pid \
-daemonize -monitor unix:/tmp/vm0_monitor.sock,server,nowait -device
e1000,netdev=3Dnttsip1  \
-netdev user,id=3Dnttsip1,hostfwd=3Dtcp:10.239.252.147:6600-:22 -device
vfio-pci,host=3D0000:3b:02.0,id=3Dpt_0 \
-cpu host -smp 8 -m 4096 -object
memory-backend-file,id=3Dmem,size=3D4096M,mem-path=3D/dev/hugepages,share=
=3Don \
-numa node,memdev=3Dmem -mem-prealloc -vnc :1 \
-chardev socket,path=3D/tmp/vm0_qga0.sock,server,nowait,id=3Dvm0_qga0 -devi=
ce
virtio-serial -device
virtserialport,chardev=3Dvm0_qga0,name=3Dorg.qemu.guest_agent.0 \
-chardev socket,path=3D/tmp/vm0_crypto0.sock,id=3Dvm0_crypto0 -object
cryptodev-vhost-user,id=3Dcryptodev0,chardev=3Dvm0_crypto0 -device
virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0 \
-chardev socket,path=3D/tmp/vm0_crypto1.sock,id=3Dvm0_crypto1 -object
cryptodev-vhost-user,id=3Dcryptodev1,chardev=3Dvm0_crypto1 -device
virtio-crypto-pci,id=3Dcrypto1,cryptodev=3Dcryptodev1 \
-drive file=3D/root/VMs/virtio_crypto_vm1.img

In VM:
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson  -Dlibdir=3Dlib --default-library=3Dstatic x86_64-native-lin=
uxapp-gcc
ninja -C x86_64-native-linuxapp-gcc -j8

awk '/Hugepagesize/ {print $2}' /proc/meminfo=20=20=20=20=20
echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages=20=20=20
echo 1024 >
/sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages

In VM:
modprobe uio_pci_generic=20=20=20=20=20=20=20=20
lspci -d:1054|awk '{{print $1}}'=20=20=20=20=20=20
echo 0000:00:07.0 > /sys/bus/pci/devices/0000\:00\:07.0/driver/unbind=20=20=
=20=20=20=20
echo 0000:00:06.0 > /sys/bus/pci/devices/0000\:00\:06.0/driver/unbind=20=20=
=20=20=20=20
echo "1af4 1054" > /sys/bus/pci/drivers/uio_pci_generic/new_id=20=20

TestVirtioPerfCryptodevFunc: Test Case test_virtio_aes_cbc_sha1_hmac Begin
virtdut.10.239.252.147:6600:=20
x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf  -l 0,1 -a 00:06.0
--socket-mem 512,0 -n 4  -- --ptest throughput --silent  --total-ops 100000
--burst-sz 32 --buffer-sz 64,128,256,512,1024,2048 --devtype crypto_virtio
--optype cipher-then-auth --cipher-algo aes-cbc --cipher-op encrypt
--cipher-key-sz 16 --cipher-iv-sz 16 --auth-algo sha1-hmac --auth-op genera=
te
--auth-key-sz 64 --digest-sz 12

[Actual log]
vm1:~/dpdk# x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf  -l 0,1 -a
00:06.0 --socket-mem 512,0 -n 4  -- --ptest throughput --silent  --total-ops
100000 --burst-sz 32 --buffer-sz 64,128,256,512,1024,2048 --devtype
crypto_virtio --optype cipher-then-auth --cipher-algo aes-cbc --cipher-op
encrypt --cipher-key-sz 16 --cipher-iv-sz 16 --auth-algo sha1-hmac --auth-op
generate --auth-key-sz 64 --digest-sz 12
EAL: Detected CPU lcores: 8
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
EAL: Probe PCI driver: crypto_virtio (1af4:1054) device: 0000:00:06.0 (sock=
et
-1)
CRYPTODEV: Creating cryptodev 0000:00:06.0
CRYPTODEV: Initialisation parameters - name: 0000:00:06.0,socket id: -1, max
queue pairs: 0
EAL: Requested device 0000:00:06.0 cannot be used
EAL: Bus (pci) probe failed.
Segmentation fault (core dumped)


[Bad commit]
commit 9c9ce1e0cef63b173df003aa9d5f0d975ed85cf2 (HEAD -> 9c9ce1e0ce)
Author: Rajesh Mudimadugula <rmudimadugul@marvell.com>
Date:   Wed May 28 10:53:47 2025 +0000

    crypto/virtio: fix driver ID

    [ upstream commit 9843181aa5e764fd6876f50e8a795353e9261cb1 ]

    This patch corrects driver id for virtio and virtio_user
    pmds.

    Fixes: 25500d4b8076 ("crypto/virtio: support device init")

    Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>
    Acked-by: Akhil Goyal <gakhil@marvell.com>

Compare that dpdk stable branch has some gaps with dpdk main branch, may ne=
ed
rebase.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

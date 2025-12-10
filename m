Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A6AD3B9A9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 07:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E3C54028F;
	Wed, 10 Dec 2025 08:25:47 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9F8B040285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 08:25:46 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 56D2247001; Wed, 10 Dec 2025 08:25:46 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1849] [dpdk-22.11.11rc1]
 virtio_perf_cryptodev_func/test_virtio_aes_cbc_sha1_hmac:
 dpdk-test-crypto-perf EAL: Error: Invalid memory
Date: Wed, 10 Dec 2025 07:25:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 22.11
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
Message-ID: <bug-1849-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1849

            Bug ID: 1849
           Summary: [dpdk-22.11.11rc1]
                    virtio_perf_cryptodev_func/test_virtio_aes_cbc_sha1_hm
                    ac: dpdk-test-crypto-perf EAL: Error: Invalid memory
           Product: DPDK
           Version: 22.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

Reproduce Step:

[Environment]

DPDK version: v22.11.11rc1

commit 8ab51c7334ee8958d2a7a16ee35808df64c83695 (HEAD -> 22.11, origin/22.1=
1)
Author: Radu Nicolau <radu.nicolau@intel.com>
Date: =C2=A0 Mon Dec 8 12:45:15 2025 +0000=C2=A0 =C2=A0 "crypto/qat: fix ba=
ckported patch=C2=A0 =C2=A0
Backported patch below was applied to the wrong QAT function.=C2=A0 =C2=A0 =
Fixes:
96a4318baabd ("crypto/qat: fix out-of-place chain/cipher/auth headers")=C2=
=A0 =C2=A0
Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>commit
12b1ff867e6f508462720cb00c2b3ffafcb7068a (tag: v22.11.11-rc1)
Author: Luca Boccassi <luca.boccassi@gmail.com>
Date: =C2=A0 Thu Dec 4 00:49:08 2025 +0000=C2=A0 =C2=A0 version: 22.11.11-r=
c1=C2=A0 =C2=A0
Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>


[Test Setup]

1, Build dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Denable_kmods=3DFalse -Dlibdir=3Dlib --default-library=3Dst=
atic
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc
meson configure -Dexamples=3Dvhost_crypto x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2, Bind 1 NIC VF to dpdk
echo 1 > /sys/bus/pci/devices/0000\:3b\:00.0/sriov_numvfs
usertools/dpdk-devbind.py --bind=3Dvfio-pci 0000:3b:02.0

3, Start vhost_crypto
rm -r /tmp/*
x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto -l 1,2,3 -a 0000:00:0=
0.0
--vdev crypto_aesni_mb_pmd_1 --socket-mem 2048,0 -n 4 -- --config
"(2,0,0),(3,0,0)" --socket-file 2,/tmp/vm0_crypto0.sock
--socket-file=3D3,/tmp/vm0_crypto1.sock

4, Start VM

lsof -n -i:6600
taskset -c 11,12,13,14 /root/qemu-2.12/bin/qemu-system-x86_64 =C2=A0-name v=
m0
-enable-kvm -pidfile /tmp/.vm0.pid \
-daemonize -monitor unix:/tmp/vm0_monitor.sock,server,nowait -device
e1000,netdev=3Dnttsip1 =C2=A0\
-netdev user,id=3Dnttsip1,hostfwd=3Dtcp:10.239.252.147:6600-:22 -device
vfio-pci,host=3D0000:3b:02.0,id=3Dpt_0 \
-cpu host -smp 4 -m 4096 -object
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
-drive file=3D/home/image/ubuntu2404.2.img

5, IN VM, set hugepage and set virtio device
modprobe uio_pci_generic =C2=A0 =C2=A0
lspci -d:1054|awk '{{print $1}}' =C2=A0 =C2=A0 =C2=A0
echo 0000:00:07.0 > /sys/bus/pci/devices/0000\:00\:07.0/driver/unbind =C2=
=A0 =C2=A0 =C2=A0
echo 0000:00:06.0 > /sys/bus/pci/devices/0000\:00\:06.0/driver/unbind =C2=
=A0 =C2=A0 =C2=A0
echo "1af4 1054" > /sys/bus/pci/drivers/uio_pci_generic/new_id =C2=A0
awk '/Hugepagesize/ {print $2}' /proc/meminfo =C2=A0 =C2=A0 =C2=A0
echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages =C2=A0 =C2=
=A0 =C2=A0
echo 1024 >
/sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages

6, IN VM, run Test Case test_virtio_aes_cbc_sha1_hmac
x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf =C2=A0-l 0,1 -a 00:06.0
--socket-mem 512,0 -n 4 =C2=A0-- --ptest throughput --silent =C2=A0--total-=
ops 100000
--burst-sz 32 --buffer-sz 64,128,256,512,1024,2048 --devtype crypto_virtio
--optype cipher-then-auth --cipher-algo aes-cbc --cipher-op encrypt
--cipher-key-sz 16 --cipher-iv-sz 16 --auth-algo sha1-hmac --auth-op genera=
te
--auth-key-sz 64 --digest-sz 12



[Actual Result]

VM: root@ub2404-2:~/dpdk# x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-p=
erf=20
-l 0,1 -a 00:06.0 --socket-mem 512,0 -n 4 =C2=A0-- --ptest throughput --sil=
ent=20
--total-ops 100000 --burst-sz 32 --buffer-sz 64,128,256,512,1024,2048 --dev=
type
crypto_virtio --optype cipher-then-auth --cipher-algo aes-cbc --cipher-op
encrypt --cipher-key-sz 16 --cipher-iv-sz 16 --auth-algo sha1-hmac --auth-op
generate --auth-key-sz 64 --digest-sz 12
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: Probe PCI driver: crypto_virtio (1af4:1054) device: 0000:00:06.0 (sock=
et
-1)
CRYPTODEV: Creating cryptodev 0000:00:06.0
CRYPTODEV: Initialisation parameters - name: 0000:00:06.0,socket id: -1, max
queue pairs: 0
Allocated pool "sess_mp_0" on socket 0
=C2=A0 =C2=A0 lcore id =C2=A0 =C2=A0Buf Size =C2=A0Burst Size =C2=A0 =C2=A0=
Enqueued =C2=A0 =C2=A0Dequeued =C2=A0Failed Enq=20
Failed Deq =C2=A0 =C2=A0 =C2=A0 =C2=A0MOps =C2=A0 =C2=A0 =C2=A0 =C2=A0Gbps =
=C2=A0Cycles/Buf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A064 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
32 =C2=A0 =C2=A0 =C2=A0100000 =C2=A0 =C2=A0 =C2=A0100000 =C2=A0 =C2=A0 =C2=
=A0247186 =C2=A0 =C2=A0 =C2=A0258255 =C2=A0 =C2=A0 =C2=A01.0802 =C2=A0 =C2=
=A0 =C2=A00.5531 =C2=A0 =C2=A0
2305.03
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 128 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032 =C2=A0 =C2=A0 =C2=A0100000 =C2=A0 =C2=
=A0 =C2=A0100000 =C2=A0 =C2=A0 =C2=A0384848 =C2=A0 =C2=A0=20
384874 =C2=A0 =C2=A0 =C2=A01.0093 =C2=A0 =C2=A0 =C2=A01.0336 =C2=A0 =C2=A0 =
2466.95
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 256 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032 =C2=A0 =C2=A0 =C2=A0100000 =C2=A0 =C2=
=A0 =C2=A0100000 =C2=A0 =C2=A0 =C2=A0375349 =C2=A0 =C2=A0=20
375371 =C2=A0 =C2=A0 =C2=A00.8821 =C2=A0 =C2=A0 =C2=A01.8064 =C2=A0 =C2=A0 =
2822.96
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 512 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032 =C2=A0 =C2=A0 =C2=A0100000 =C2=A0 =C2=
=A0 =C2=A0100000 =C2=A0 =C2=A0 =C2=A0381865 =C2=A0 =C2=A0=20
430148 =C2=A0 =C2=A0 =C2=A00.8622 =C2=A0 =C2=A0 =C2=A03.5317 =C2=A0 =C2=A0 =
2887.86
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A01024 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032 =C2=A0 =C2=A0 =C2=A0100000 =C2=A0 =C2=
=A0 =C2=A0100000 =C2=A0 =C2=A0 =C2=A0795137 =C2=A0 =C2=A0=20
826088 =C2=A0 =C2=A0 =C2=A00.5592 =C2=A0 =C2=A0 =C2=A04.5811 =C2=A0 =C2=A0 =
4452.69
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A02048 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032 =C2=A0 =C2=A0 =C2=A0100000 =C2=A0 =C2=
=A0 =C2=A0100000 =C2=A0 =C2=A0 1073023 =C2=A0 =C2=A0
1088023 =C2=A0 =C2=A0 =C2=A00.4712 =C2=A0 =C2=A0 =C2=A07.7207 =C2=A0 =C2=A0=
 5283.97
EAL: Error: Invalid memory
EAL: Error: Invalid memory

--=20
You are receiving this mail because:
You are the assignee for the bug.=

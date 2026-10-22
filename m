Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2110E606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 01:41:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B3BD40299;
	Thu, 22 Oct 2026 03:41:42 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 97EBD400D7
 for <dev@dpdk.org>; Thu, 22 Oct 2026 03:41:40 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 70A664D25B; Thu, 22 Oct 2026 03:41:40 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: =?UTF-8?B?W0RQREsvdmhvc3QvdmlydGlvIEJ1ZyAyMDY3XSBbZHBkay0yNi4x?=
 =?UTF-8?B?MV12bTJ2bV92aXJ0aW9fcG1kL3ZtMnZtX3Zob3N0X3VzZXJfdmlydGlvOTVf?=
 =?UTF-8?B?cG1kX3dpdGhfbWVyZ2VhYmxlX3BhdGhfd2l0aF9wYXlsb2FkX3ZhbGlkX2No?=
 =?UTF-8?B?ZWNrOiBzdGFydCBkcGRrLXBkdW1wIGluIFZNIHdpdGggdmlydGlvLTAuOTUg?=
 =?UTF-8?B?cHJvdG9jb2wgZmFpbGVk?=
Date: Thu, 22 Oct 2026 01:41:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2067-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2067

            Bug ID: 2067
           Summary: [dpdk-26.11]vm2vm_virtio_pmd/vm2vm_vhost_user_virtio95
                    _pmd_with_mergeable_path_with_payload_valid_check:
                    start dpdk-pdump in VM with virtio-0.95 protocol
                    failed
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

---------------------------------------------------------------------------=
-----
DPDK version: dpdk 9a45341f18 (HEAD -> main, tag: v26.11-rc1, origin/main,
origin/HEAD) version: 26.11-rc1
Other software versions: QEMU emulator version 11.1.2
OS: Ubuntu26.04.1 LTS/7.0.0-38-generic
Compiler: gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) Platinum 8468H
---------------------------------------------------------------------------=
-----
Test Setup
Steps to reproduce

1. Use the following command to build DPDK:

rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Dlibdir=3Dlib  --default-library=3Dstatic x86_64-native-lin=
uxapp-gcc
-Dmax_lcores=3D160
ninja -C x86_64-native-linuxapp-gcc

2.Use the following command to launch dpdk-testpmd in Host:

x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-2 -n 4
--file-prefix=3Dvhost-user --no-pci \
--vdev 'net_vhost0,iface=3Dvhost-net0,queues=3D1' \
--vdev 'net_vhost1,iface=3Dvhost-net1,queues=3D1' \
-- -i --nb-cores=3D1 --txd=3D1024 --rxd=3D1024
testpmd> set fwd mac
testpmd> start

3.Use the following command to launch VM by QEMU with virtio95:

taskset -c 20,21,22,23,24,25,26,27 /home/qemu-11.1/bin/qemu-system-x86_64 -=
name
vm0 -enable-kvm -pidfile /tmp/.vm0.pid -daemonize \
-monitor unix:/tmp/vm0_monitor.sock,server,nowait \
-netdev user,id=3Dnttsip1,hostfwd=3Dtcp:127.0.0.1:6000-:22 \
-device e1000,netdev=3Dnttsip1 \
-chardev socket,id=3Dchar0,path=3D/root/dpdk/vhost-net0 \
-netdev type=3Dvhost-user,id=3Dnetdev0,chardev=3Dchar0,vhostforce \
-device
virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,disable-modern=3Dtr=
ue,mrg_rxbuf=3Don,csum=3Don,guest_csum=3Don,host_tso4=3Don,guest_tso4=3Don,=
guest_ecn=3Don
\
-cpu host -smp 8 -m 8192 \
-object memory-backend-file,id=3Dmem,size=3D8192M,mem-path=3D/dev/hugepages=
,share=3Don
\
-numa node,memdev=3Dmem -mem-prealloc \
-chardev socket,path=3D/tmp/vm0_qga0.sock,server,nowait,id=3Dvm0_qga0 \
-device virtio-serial \
-device virtserialport,chardev=3Dvm0_qga0,name=3Dorg.qemu.guest_agent.0 -vn=
c :4 \
-drive file=3D/home/image/ubuntu1.img

4.Use the following command to enter the VM, bind virtio-net-pci to vfio-pci
and start dpdk-testpmd in VM:

ssh root@127.0.0.1 -p 6000

cd dpdk;./usertools/dpdk-hugepages.py -p 2M --setup 2G
modprobe vfio-pci
echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
./usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:00:04.0
dpdk# ./usertools/dpdk-devbind.py -s

Network devices using DPDK-compatible driver
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0000:00:04.0 'Virtio network device 1000' drv=3Dvfio-pci unused=3Dvirtio_pci

x86_64-native-linuxapp-gcc/app/dpdk-testpmd -c 0x3 -n 4 -a 0000:00:04.0
--file-prefix=3Dvirtio_898526_20261020104610 \
-- -i --rx-offloads=3D0x00002000 --txd=3D1024 --rxd=3D1024 --max-pkt-len=3D=
9600
testpmd> set fwd rxonly
testpmd> start

5.Use the following command to create a new SSH connection and start dpdk-p=
dump
APP in VM:

ssh root@127.0.0.1 -p 6000
x86_64-native-linuxapp-gcc/app/dpdk-pdump -v
--file-prefix=3Dvirtio_898526_20261020104610 -- --pdump
'port=3D0,queue=3D*,rx-dev=3D/root/pdump-rx.pcap,mbuf-size'

Show the output from the previous commands=EF=BC=9A=EF=BC=9A
dpdk# x86_64-native-linuxapp-gcc/app/dpdk-pdump -v
--file-prefix=3Dvirtio_898526_20261020104610 -- --pdump
'port=3D0,queue=3D*,rx-dev=3D/root/pdump-rx.pcap,mbuf-size=3D8000'
EAL: Detected CPU lcores: 8
EAL: Detected NUMA nodes: 1
EAL: RTE Version: 'DPDK 26.11.0-rc0'
EAL: Detected static linkage of DPDK
EAL: Multi-process socket
/var/run/dpdk/virtio_898526_20261020104610/mp_socket_1513_42ae79e13e
EAL: VFIO support initialized: group mode, IOVA as PA
EAL: Selected IOVA mode 'PA'
VIRTIO_INIT: eth_virtio_pci_init(): Failed to remap PCI device
EAL: Failed to probe device 0000:00:04.0
EAL: Error - exiting with code: 1
No Ethernet ports - bye
root@ubuntu26:~/dpdk#

---------------------------------------------------------------------------=
-----
Expected Result
start dpdk-pdump successfully

---------------------------------------------------------------------------=
-----
Is this issue a regression: (Y/N) Y

Version the regression was introduced:=20
commit 63a0dbf661e5b92ab1bef9c1b22f3477520e63c2 (HEAD ->
8-63a0dbf661-F-badcommit)
Author: David Marchand <david.marchand@redhat.com>
Date:   Wed Oct 14 18:43:10 2026 +0200

    interrupts: mark FDs invalid on allocation

    Initialize fd, dev_fd, and all efds array elements as invalid in
    rte_intr_instance_alloc().
    This follows Unix convention, avoiding confusion with fd 0
    which could result from zero-initialization.

    Update the API documentation to reflect this behavior and add a
    unit test check to verify the fd is invalid after allocation.

    Update the FreeBSD PCI implementation that checked against a 0 FD.

    Add a hack in the unit test to let the UIO simulated tests pass.

    Remove now-redundant initialization calls that were setting the fd
    invalid right after allocation.

    Signed-off-by: David Marchand <david.marchand@redhat.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

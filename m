Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B903C282DE
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 01:40:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4702E4025D;
	Fri, 14 Mar 2025 02:40:17 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6AEDE4025A
 for <dev@dpdk.org>; Fri, 14 Mar 2025 02:40:16 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3FE8C463AA; Fri, 14 Mar 2025 02:40:16 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1676] [dpdk-25.03]
 virtio_ipsec_cryptodev_func/test_aesni_mb_aes_cbc_sha1_hmac: Failed to start
 qemu after launch dpdk-vhost_crypto sample
Date: Fri, 14 Mar 2025 01:40:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 25.03
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
Message-ID: <bug-1676-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17419164160.AF3AcB.3088712
Content-Transfer-Encoding: 7bit
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


--17419164160.AF3AcB.3088712
Date: Fri, 14 Mar 2025 02:40:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1676

            Bug ID: 1676
           Summary: [dpdk-25.03]
                    virtio_ipsec_cryptodev_func/test_aesni_mb_aes_cbc_sha1
                    _hmac: Failed to start qemu after launch
                    dpdk-vhost_crypto sample
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

[Environment]

DPDK version: commit 5f37ee9c 25.03-rc2
OS: Ubuntu 18.04.5 LTS (Bionic Beaver); 5.4.0-150-generic
Compiler: gcc version 7.5.0
Hardware platform: Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
QEMU: qemu-2.12
qemu version >=3D 2.12 in qemu enable vhost-user-crypto:
        ./configure --target-list=3Dx86_64-softmmu --enable-vhost-crypto
--prefix=3D/root/qemu-2.12 && make && make install
Qemu version: 2.12
QAT: C62x Chipset QuickAssist Technology 37c8

[Bad commit Debug Info]:
  d1b484bf18 vhost/crypto: support asymmetric RSA ////////////////Failed to
launch qemu
  f7cf44d49b examples/vhost_crypto: fix user callbacks ///////also failed to
build dpdk
  b1d02713d3 vhost/crypto: update session parameters
  b03cb9c87a vhost/crypto: skip fetch before vring init
  88c73b5434 vhost/crypto: fix thread safety check /////////Failed to build
dpdk
  1992e3ffac (1992e3ffac-pass) net/nfp: fix init failure handling
////////PASSED

[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1, Build dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson --werror -Denable_kmods=3DFalse -Dlibdir=3Dlib -Dexamples=3D=
all
--default-library=3Dstatic x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc -j 110
ls x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto

2, Bind QAT device and run the dpdk vhost sample in HOST side
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:1a:01.0 0000:1c:01=
.0
0000:1e:01.0
x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto  -l 1,2,3,4,5 -a
0000:1a:01.0 -a 0000:1c:01.0 -a 0000:1e:01.0 --vdev
crypto_scheduler_pmd_1,worker=3D0000:1a:01.0_qat_sym,worker=3D0000:1c:01.0_=
qat_sym,worker=3D0000:1e:01.0_qat_sym,mode=3Dround-robin,ordering=3Denable
--socket-mem 2048,0 -n 4  -- --config "(2,0,0),(3,0,0),(4,0,0),(5,0,0)"
--socket-file 2,/tmp/vm0_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D3,/tmp/vm0_crypto1.sock=20=20=20=20=20=20=20
--socket-file=3D4,/tmp/vm1_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D5,/tmp/vm1_crypto1.sock

3, Bind NIC PF to vfio-pci
usertools/dpdk-devbind.py --bind=3Dvfio-pci 0000:60:00.0 0000:60:00.1
0000:3b:00.0 0000:3b:00.1

4, Start VM0 by the qemu:
taskset -c 11,12,13,14 /usr/local/qemu-2.12.0/bin/qemu-system-x86_64  -name=
 vm0
-enable-kvm -pidfile /tmp/.vm0.pid -daemonize -monitor
unix:/tmp/vm0_monitor.sock,server,nowait -device e1000,netdev=3Dnttsip1  -n=
etdev
user,id=3Dnttsip1,hostfwd=3Dtcp:10.67.118.199:6410-:22 -device
vfio-pci,host=3D0000:3b:00.0,id=3Dpt_0 -device vfio-pci,host=3D0000:3b:00.1=
,id=3Dpt_1
-cpu host -smp 4 -m 4096 -object
memory-backend-file,id=3Dmem,size=3D4096M,mem-path=3D/dev/hugepages,share=
=3Don -numa
node,memdev=3Dmem -mem-prealloc -chardev
socket,path=3D/tmp/vm0_qga0.sock,server,nowait,id=3Dvm0_qga0 -device virtio=
-serial
-device virtserialport,chardev=3Dvm0_qga0,name=3Dorg.qemu.guest_agent.0 -vn=
c :1
-chardev socket,path=3D/tmp/vm0_crypto0.sock,id=3Dvm0_crypto0 -object
cryptodev-vhost-user,id=3Dcryptodev0,chardev=3Dvm0_crypto0 -device
virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0 -chardev
socket,path=3D/tmp/vm0_crypto1.sock,id=3Dvm0_crypto1 -object
cryptodev-vhost-user,id=3Dcryptodev1,chardev=3Dvm0_crypto1 -device
virtio-crypto-pci,id=3Dcrypto1,cryptodev=3Dcryptodev1 -drive
file=3D/root/VMs/ubuntu2004-0.img


[Actual Result]
VM0 log: qemu-system-x86_64: -device vfio-pci,host=3D0000:3b:00.0,id=3Dpt_0=
: vfio
error: 0000:3b:00.0: failed to open /dev/vfio/78: No such file or directory

DPDK VHOST sample HOST log:=20
root@dpdk-yaobing-purely147:~/dpdk#
x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto  -l 1,2,3,4,5 -a
0000:1a:01.0 -a 0000:1c:01.0 -a 0000:1e:01.0 --vdev
crypto_scheduler_pmd_1,worker=3D0000:1a:01.0_qat_sym,worker=3D0000:1c:01.0_=
qat_sym,worker=3D0000:1e:01.0_qat_sym,mode=3Dround-robin,ordering=3Denable
--socket-mem 2048,0 -n 4  -- --config "(2,0,0),(3,0,0),(4,0,0),(5,0,0)"
--socket-file 2,/tmp/vm0_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D3,/tmp/vm0_crypto1.sock=20=20=20=20=20=20=20
--socket-file=3D4,/tmp/vm1_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D5,/tmp/vm1_crypto1.sock
EAL: Detected CPU lcores: 112
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
CRYPTODEV: Creating cryptodev 0000:1a:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:1a:01.0_qat_asym,socket i=
d:
0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1a:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:1a:01.0_qat_sym,socket id=
: 0,
max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1c:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:1c:01.0_qat_asym,socket i=
d:
0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1c:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:1c:01.0_qat_sym,socket id=
: 0,
max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1e:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:1e:01.0_qat_asym,socket i=
d:
0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1e:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:1e:01.0_qat_sym,socket id=
: 0,
max queue pairs: 0
CRYPTODEV: Creating cryptodev crypto_scheduler_pmd_1
CRYPTODEV: Initialisation parameters - name: crypto_scheduler_pmd_1,socket =
id:
0, max queue pairs: 8
SCHEDULER_DRIVER: cryptodev_scheduler_create() line 158:   Scheduling mode =
=3D
round-robin
SCHEDULER_DRIVER: cryptodev_scheduler_create() line 213:   Packet ordering =
=3D
enable
USER1: Processing on Core 2 started
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) logging feature is disabled in async =
copy
mode
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) vhost-user server: socket created, fd=
: 48
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) binding succeeded
CRYPTODEV: rte_cryptodev_start() line 1334: Device with dev_id=3D0 already
started
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) logging feature is disabled in async =
copy
mode
USER1: Processing on Core 3 started
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) vhost-user server: socket created, fd=
: 51
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) binding succeeded
CRYPTODEV: rte_cryptodev_start() line 1334: Device with dev_id=3D0 already
started
VHOST_CONFIG: (/tmp/vm1_crypto0.sock) logging feature is disabled in async =
copy
mode
VHOST_CONFIG: (/tmp/vm1_crypto0.sock) vhost-user server: socket created, fd=
: 52
USER1: Processing on Core 4 started
VHOST_CONFIG: (/tmp/vm1_crypto0.sock) binding succeeded
CRYPTODEV: rte_cryptodev_start() line 1334: Device with dev_id=3D0 already
started
VHOST_CONFIG: (/tmp/vm1_crypto1.sock) logging feature is disabled in async =
copy
mode
VHOST_CONFIG: (/tmp/vm1_crypto1.sock) vhost-user server: socket created, fd=
: 53
USER1: Processing on Core 5 started
VHOST_CONFIG: (/tmp/vm1_crypto1.sock) binding succeeded
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) new vhost user connection is 54
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) new device, handle is 0
USER1: New Vhost-crypto Device /tmp/vm0_crypto0.sock, Device ID 0
VHOST_CRYPTO: rte_vhost_crypto_fetch_requests() line 2006: Invalid virtqueu=
e 0
....................
VHOST_CRYPTO: rte_vhost_crypto_fetch_requests() line 2006: Invalid virtqueu=
e 0
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) read message VHOST_USER_SET_VRING_CALL
VHOST_CRYPTO: rte_vhost_crypto_fetch_requests() line 2006: Invalid virtqueu=
e 0
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) vring call idx:0 file:59
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) vhost peer closed
USER1: Vhost Crypto Device 1 Removed
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) vhost peer closed
USER1: Vhost Crypto Device 0 Removed

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17419164160.AF3AcB.3088712
Date: Fri, 14 Mar 2025 02:40:16 +0100
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - [dpdk-25.03] virtio_ipsec_cryptodev_func/test_aes=
ni_mb_aes_cbc_sha1_hmac: Failed to start qemu after launch dpdk-vhost_crypt=
o sample"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1676">1676</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.03] virtio_ipsec_cryptodev_func/test_aesni_mb_aes_cb=
c_sha1_hmac: Failed to start qemu after launch dpdk-vhost_crypto sample
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>vhost/virtio
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>yux.jiang&#64;intel.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">[Environment]

DPDK version: commit 5f37ee9c 25.03-rc2
OS: Ubuntu 18.04.5 LTS (Bionic Beaver); 5.4.0-150-generic
Compiler: gcc version 7.5.0
Hardware platform: Intel(R) Xeon(R) Platinum 8180 CPU &#64; 2.50GHz
QEMU: qemu-2.12
qemu version &gt;=3D 2.12 in qemu enable vhost-user-crypto:
        ./configure --target-list=3Dx86_64-softmmu --enable-vhost-crypto
--prefix=3D/root/qemu-2.12 &amp;&amp; make &amp;&amp; make install
Qemu version: 2.12
QAT: C62x Chipset QuickAssist Technology 37c8

[Bad commit Debug Info]:
  d1b484bf18 vhost/crypto: support asymmetric RSA ////////////////Failed to
launch qemu
  f7cf44d49b examples/vhost_crypto: fix user callbacks ///////also failed to
build dpdk
  b1d02713d3 vhost/crypto: update session parameters
  b03cb9c87a vhost/crypto: skip fetch before vring init
  88c73b5434 vhost/crypto: fix thread safety check /////////Failed to build
dpdk
  1992e3ffac (1992e3ffac-pass) net/nfp: fix init failure handling
////////PASSED

[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1, Build dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson --werror -Denable_kmods=3DFalse -Dlibdir=3Dlib -Dexamples=3D=
all
--default-library=3Dstatic x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc -j 110
ls x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto

2, Bind QAT device and run the dpdk vhost sample in HOST side
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:1a:01.0 0000:1c:01=
.0
0000:1e:01.0
x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto  -l 1,2,3,4,5 -a
0000:1a:01.0 -a 0000:1c:01.0 -a 0000:1e:01.0 --vdev
crypto_scheduler_pmd_1,worker=3D0000:1a:01.0_qat_sym,worker=3D0000:1c:01.0_=
qat_sym,worker=3D0000:1e:01.0_qat_sym,mode=3Dround-robin,ordering=3Denable
--socket-mem 2048,0 -n 4  -- --config &quot;(2,0,0),(3,0,0),(4,0,0),(5,0,0)=
&quot;
--socket-file 2,/tmp/vm0_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D3,/tmp/vm0_crypto1.sock=20=20=20=20=20=20=20
--socket-file=3D4,/tmp/vm1_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D5,/tmp/vm1_crypto1.sock

3, Bind NIC PF to vfio-pci
usertools/dpdk-devbind.py --bind=3Dvfio-pci 0000:60:00.0 0000:60:00.1
0000:3b:00.0 0000:3b:00.1

4, Start VM0 by the qemu:
taskset -c 11,12,13,14 /usr/local/qemu-2.12.0/bin/qemu-system-x86_64  -name=
 vm0
-enable-kvm -pidfile /tmp/.vm0.pid -daemonize -monitor
unix:/tmp/vm0_monitor.sock,server,nowait -device e1000,netdev=3Dnttsip1  -n=
etdev
user,id=3Dnttsip1,hostfwd=3Dtcp:10.67.118.199:6410-:22 -device
vfio-pci,host=3D0000:3b:00.0,id=3Dpt_0 -device vfio-pci,host=3D0000:3b:00.1=
,id=3Dpt_1
-cpu host -smp 4 -m 4096 -object
memory-backend-file,id=3Dmem,size=3D4096M,mem-path=3D/dev/hugepages,share=
=3Don -numa
node,memdev=3Dmem -mem-prealloc -chardev
socket,path=3D/tmp/vm0_qga0.sock,server,nowait,id=3Dvm0_qga0 -device virtio=
-serial
-device virtserialport,chardev=3Dvm0_qga0,name=3Dorg.qemu.guest_agent.0 -vn=
c :1
-chardev socket,path=3D/tmp/vm0_crypto0.sock,id=3Dvm0_crypto0 -object
cryptodev-vhost-user,id=3Dcryptodev0,chardev=3Dvm0_crypto0 -device
virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0 -chardev
socket,path=3D/tmp/vm0_crypto1.sock,id=3Dvm0_crypto1 -object
cryptodev-vhost-user,id=3Dcryptodev1,chardev=3Dvm0_crypto1 -device
virtio-crypto-pci,id=3Dcrypto1,cryptodev=3Dcryptodev1 -drive
file=3D/root/VMs/ubuntu2004-0.img


[Actual Result]
VM0 log: qemu-system-x86_64: -device vfio-pci,host=3D0000:3b:00.0,id=3Dpt_0=
: vfio
error: 0000:3b:00.0: failed to open /dev/vfio/78: No such file or directory

DPDK VHOST sample HOST log:=20
root&#64;dpdk-yaobing-purely147:~/dpdk#
x86_64-native-linuxapp-gcc/examples/dpdk-vhost_crypto  -l 1,2,3,4,5 -a
0000:1a:01.0 -a 0000:1c:01.0 -a 0000:1e:01.0 --vdev
crypto_scheduler_pmd_1,worker=3D0000:1a:01.0_qat_sym,worker=3D0000:1c:01.0_=
qat_sym,worker=3D0000:1e:01.0_qat_sym,mode=3Dround-robin,ordering=3Denable
--socket-mem 2048,0 -n 4  -- --config &quot;(2,0,0),(3,0,0),(4,0,0),(5,0,0)=
&quot;
--socket-file 2,/tmp/vm0_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D3,/tmp/vm0_crypto1.sock=20=20=20=20=20=20=20
--socket-file=3D4,/tmp/vm1_crypto0.sock=20=20=20=20=20=20=20
--socket-file=3D5,/tmp/vm1_crypto1.sock
EAL: Detected CPU lcores: 112
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
CRYPTODEV: Creating cryptodev 0000:1a:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:1a:01.0_qat_asym,socket i=
d:
0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1a:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:1a:01.0_qat_sym,socket id=
: 0,
max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1c:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:1c:01.0_qat_asym,socket i=
d:
0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1c:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:1c:01.0_qat_sym,socket id=
: 0,
max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1e:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:1e:01.0_qat_asym,socket i=
d:
0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:1e:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:1e:01.0_qat_sym,socket id=
: 0,
max queue pairs: 0
CRYPTODEV: Creating cryptodev crypto_scheduler_pmd_1
CRYPTODEV: Initialisation parameters - name: crypto_scheduler_pmd_1,socket =
id:
0, max queue pairs: 8
SCHEDULER_DRIVER: cryptodev_scheduler_create() line 158:   Scheduling mode =
=3D
round-robin
SCHEDULER_DRIVER: cryptodev_scheduler_create() line 213:   Packet ordering =
=3D
enable
USER1: Processing on Core 2 started
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) logging feature is disabled in async =
copy
mode
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) vhost-user server: socket created, fd=
: 48
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) binding succeeded
CRYPTODEV: rte_cryptodev_start() line 1334: Device with dev_id=3D0 already
started
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) logging feature is disabled in async =
copy
mode
USER1: Processing on Core 3 started
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) vhost-user server: socket created, fd=
: 51
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) binding succeeded
CRYPTODEV: rte_cryptodev_start() line 1334: Device with dev_id=3D0 already
started
VHOST_CONFIG: (/tmp/vm1_crypto0.sock) logging feature is disabled in async =
copy
mode
VHOST_CONFIG: (/tmp/vm1_crypto0.sock) vhost-user server: socket created, fd=
: 52
USER1: Processing on Core 4 started
VHOST_CONFIG: (/tmp/vm1_crypto0.sock) binding succeeded
CRYPTODEV: rte_cryptodev_start() line 1334: Device with dev_id=3D0 already
started
VHOST_CONFIG: (/tmp/vm1_crypto1.sock) logging feature is disabled in async =
copy
mode
VHOST_CONFIG: (/tmp/vm1_crypto1.sock) vhost-user server: socket created, fd=
: 53
USER1: Processing on Core 5 started
VHOST_CONFIG: (/tmp/vm1_crypto1.sock) binding succeeded
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) new vhost user connection is 54
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) new device, handle is 0
USER1: New Vhost-crypto Device /tmp/vm0_crypto0.sock, Device ID 0
VHOST_CRYPTO: rte_vhost_crypto_fetch_requests() line 2006: Invalid virtqueu=
e 0
....................
VHOST_CRYPTO: rte_vhost_crypto_fetch_requests() line 2006: Invalid virtqueu=
e 0
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) read message VHOST_USER_SET_VRING_CALL
VHOST_CRYPTO: rte_vhost_crypto_fetch_requests() line 2006: Invalid virtqueu=
e 0
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) vring call idx:0 file:59
VHOST_CONFIG: (/tmp/vm0_crypto1.sock) vhost peer closed
USER1: Vhost Crypto Device 1 Removed
VHOST_CONFIG: (/tmp/vm0_crypto0.sock) vhost peer closed
USER1: Vhost Crypto Device 0 Removed
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1676">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17419164160.AF3AcB.3088712--

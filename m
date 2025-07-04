Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E6CC8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 11:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 579B14028B;
	Fri,  4 Jul 2025 13:24:11 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E06C140267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 13:24:10 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CBDD846AF6; Fri,  4 Jul 2025 13:24:10 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1747] [dpdk-25.07] virtio_pvp_regression:
 perf drop
Date: Fri, 04 Jul 2025 11:24:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: unspecified
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
Message-ID: <bug-1747-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17516282500.F33df472.1904402
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
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


--17516282500.F33df472.1904402
Date: Fri, 4 Jul 2025 13:24:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1747

            Bug ID: 1747
           Summary: [dpdk-25.07] virtio_pvp_regression: perf drop
           Product: DPDK
           Version: unspecified
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

DPDK version:=20
commit 20460dcffd08a4680f881c39916ae783ee830374 (HEAD -> main, tag: v25.07-=
rc2,
origin/main, origin/HEAD)
Author: Thomas Monjalon <thomas@monjalon.net>
Date:   Mon Jun 30 00:23:49 2025 +0200

    version: 25.07-rc2

    Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

OS: Ubuntu 24.04.2 LTS (Noble Numbat); 6.8.0-62-generic
Compiler: gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04)
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz  CPU @ 2.3G=
Hz
QEMU: qemu-10.0.2
NIC: Ethernet Controller E810-C for QSFP 1592

[Bad commit Debug Info]:
  3e3c7f3fa5 net/virtio: fix check of threshold for Tx freeing
[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1, Build dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Denable_kmods=3DTrue -Dlibdir=3Dlib  --default-library=3Dst=
atic
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2, Bind one NIC port and launch vhost-user
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:4b:00.0
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 5-7 -n 8 -a 0000:4b:00.0
--file-prefix=3Dvhost_343434_20250703181552 --vdev
'eth_vhost0,iface=3D/root/dpdk/vhost-net,queues=3D2,client=3D1' -- -i --nb-=
cores=3D2
--rxq=3D2 --txq=3D2  --txd=3D1024 --rxd=3D1024
set fwd mac
start

3, Launch qemu and start testpmd
lsof -n -i:6000
taskset -c 20,21,22,23,24,25,26,27
/home/QEMU/qemu-10.0.2/bin/qemu-system-x86_64 -name vm0 -enable-kvm -pidfile
/tmp/.vm0.pid -daemonize -monitor unix:/tmp/vm0_monitor.sock,server,nowait
-netdev user,id=3Dnttsip1,hostfwd=3Dtcp:10.239.252.245:6000-:22 -device
e1000,netdev=3Dnttsip1 -chardev socket,id=3Dchar0,path=3D/root/dpdk/vhost-n=
et,server
-netdev type=3Dvhost-user,id=3Dnetdev0,chardev=3Dchar0,vhostforce,queues=3D=
2 -device
virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,disable-modern=3Dtr=
ue,mrg_rxbuf=3Doff,rx_queue_size=3D1024,tx_queue_size=3D1024,mq=3Don,vector=
s=3D15
-cpu host -smp 8 -m 8192 -object
memory-backend-file,id=3Dmem,size=3D8192M,mem-path=3D/dev/hugepages,share=
=3Don -numa
node,memdev=3Dmem -mem-prealloc -chardev
socket,path=3D/tmp/vm0_qga0.sock,server,nowait,id=3Dvm0_qga0 -device virtio=
-serial
-device virtserialport,chardev=3Dvm0_qga0,name=3Dorg.qemu.guest_agent.0 -vn=
c :4
-drive file=3D/home/image/ubuntu2004.img

IN VM:
echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
echo 1024 >
/sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
modprobe vfio
modprobe vfio-pci
echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci --noiommu-mode 0000:00:=
04.0
x86_64-native-linuxapp-gcc/app/dpdk-testpmd  -c 0x7 -n 4 -- -i
--enable-hw-vlan-strip --nb-cores=3D2 --rxq=3D2 --txq=3D2 --txd=3D1024 --rx=
d=3D1024
set fwd mac
start

4, Use trex to send pkgs
Ether(dst=3D"40:a6:b7:96:e4:00")/IP(src=3D"192.168.4.1")/("X"*26)

5, on Vhost side check NIC statistics:
testpmd> show port stats all

[Actual Result]
testpmd> show port stats all

  ######################## NIC statistics for port 0  #####################=
###
  RX-packets: 1335228256 RX-missed: 3852467168 RX-bytes:  1257101091618
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 1335227072 TX-errors: 0          TX-bytes:  922022159232

  Throughput (since last show)
  Rx-pps:      2082875          Rx-bps:   8546636528
  Tx-pps:      2082875          Tx-bps:  10284137360
  #########################################################################=
###

  ######################## NIC statistics for port 1  #####################=
###
  RX-packets: 1335227200 RX-missed: 0          RX-bytes:  2021533980800
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 1335227392 TX-errors: 0          TX-bytes:  2021534271488

  Throughput (since last show)
  Rx-pps:      2082875          Rx-bps:  25227789696
  Tx-pps:      2082875          Tx-bps:  25227789696
  #########################################################################=
###
testpmd>


[Expect Result]
testpmd> show port stats all

  ######################## NIC statistics for port 0  #####################=
###
  RX-packets: 161121824  RX-missed: 290949041  RX-bytes:  684435274430
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 161069126  TX-errors: 0          TX-bytes:  243858650692

  Throughput (since last show)
  Rx-pps:      2880720          Rx-bps:  98209559280
  Tx-pps:      2880658          Tx-bps:  34890425968
  #########################################################################=
###

  ######################## NIC statistics for port 1  #####################=
###
  RX-packets: 161069346  RX-missed: 0          RX-bytes:  243858989844
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 161070988  TX-errors: 50004      TX-bytes:  243861475832

  Throughput (since last show)
  Rx-pps:      2880737          Rx-bps:  34891493424
  Tx-pps:      2880737          Tx-bps:  34891493424
  ########

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17516282500.F33df472.1904402
Date: Fri, 4 Jul 2025 13:24:10 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - [dpdk-25.07] virtio_pvp_regression: perf drop"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1747">1747</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.07] virtio_pvp_regression: perf drop
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
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

DPDK version:=20
commit 20460dcffd08a4680f881c39916ae783ee830374 (HEAD -&gt; main, tag: v25.=
07-rc2,
origin/main, origin/HEAD)
Author: Thomas Monjalon &lt;<a href=3D"mailto:thomas&#64;monjalon.net">thom=
as&#64;monjalon.net</a>&gt;
Date:   Mon Jun 30 00:23:49 2025 +0200

    version: 25.07-rc2

    Signed-off-by: Thomas Monjalon &lt;<a href=3D"mailto:thomas&#64;monjalo=
n.net">thomas&#64;monjalon.net</a>&gt;

OS: Ubuntu 24.04.2 LTS (Noble Numbat); 6.8.0-62-generic
Compiler: gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04)
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU &#64; 2.30GHz  CPU &#=
64; 2.3GHz
QEMU: qemu-10.0.2
NIC: Ethernet Controller E810-C for QSFP 1592

[Bad commit Debug Info]:
  3e3c7f3fa5 net/virtio: fix check of threshold for Tx freeing
[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1, Build dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Denable_kmods=3DTrue -Dlibdir=3Dlib  --default-library=3Dst=
atic
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2, Bind one NIC port and launch vhost-user
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:4b:00.0
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 5-7 -n 8 -a 0000:4b:00.0
--file-prefix=3Dvhost_343434_20250703181552 --vdev
'eth_vhost0,iface=3D/root/dpdk/vhost-net,queues=3D2,client=3D1' -- -i --nb-=
cores=3D2
--rxq=3D2 --txq=3D2  --txd=3D1024 --rxd=3D1024
set fwd mac
start

3, Launch qemu and start testpmd
lsof -n -i:6000
taskset -c 20,21,22,23,24,25,26,27
/home/QEMU/qemu-10.0.2/bin/qemu-system-x86_64 -name vm0 -enable-kvm -pidfile
/tmp/.vm0.pid -daemonize -monitor unix:/tmp/vm0_monitor.sock,server,nowait
-netdev user,id=3Dnttsip1,hostfwd=3Dtcp:10.239.252.245:6000-:22 -device
e1000,netdev=3Dnttsip1 -chardev socket,id=3Dchar0,path=3D/root/dpdk/vhost-n=
et,server
-netdev type=3Dvhost-user,id=3Dnetdev0,chardev=3Dchar0,vhostforce,queues=3D=
2 -device
virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,disable-modern=3Dtr=
ue,mrg_rxbuf=3Doff,rx_queue_size=3D1024,tx_queue_size=3D1024,mq=3Don,vector=
s=3D15
-cpu host -smp 8 -m 8192 -object
memory-backend-file,id=3Dmem,size=3D8192M,mem-path=3D/dev/hugepages,share=
=3Don -numa
node,memdev=3Dmem -mem-prealloc -chardev
socket,path=3D/tmp/vm0_qga0.sock,server,nowait,id=3Dvm0_qga0 -device virtio=
-serial
-device virtserialport,chardev=3Dvm0_qga0,name=3Dorg.qemu.guest_agent.0 -vn=
c :4
-drive file=3D/home/image/ubuntu2004.img

IN VM:
echo 0 &gt; /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
echo 1024 &gt;
/sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
modprobe vfio
modprobe vfio-pci
echo 1 &gt; /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci --noiommu-mode 0000:00:=
04.0
x86_64-native-linuxapp-gcc/app/dpdk-testpmd  -c 0x7 -n 4 -- -i
--enable-hw-vlan-strip --nb-cores=3D2 --rxq=3D2 --txq=3D2 --txd=3D1024 --rx=
d=3D1024
set fwd mac
start

4, Use trex to send pkgs
Ether(dst=3D&quot;40:a6:b7:96:e4:00&quot;)/IP(src=3D&quot;192.168.4.1&quot;=
)/(&quot;X&quot;*26)

5, on Vhost side check NIC statistics:
testpmd&gt; show port stats all

[Actual Result]
testpmd&gt; show port stats all

  ######################## NIC statistics for port 0  #####################=
###
  RX-packets: 1335228256 RX-missed: 3852467168 RX-bytes:  1257101091618
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 1335227072 TX-errors: 0          TX-bytes:  922022159232

  Throughput (since last show)
  Rx-pps:      2082875          Rx-bps:   8546636528
  Tx-pps:      2082875          Tx-bps:  10284137360
  #########################################################################=
###

  ######################## NIC statistics for port 1  #####################=
###
  RX-packets: 1335227200 RX-missed: 0          RX-bytes:  2021533980800
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 1335227392 TX-errors: 0          TX-bytes:  2021534271488

  Throughput (since last show)
  Rx-pps:      2082875          Rx-bps:  25227789696
  Tx-pps:      2082875          Tx-bps:  25227789696
  #########################################################################=
###
testpmd&gt;


[Expect Result]
testpmd&gt; show port stats all

  ######################## NIC statistics for port 0  #####################=
###
  RX-packets: 161121824  RX-missed: 290949041  RX-bytes:  684435274430
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 161069126  TX-errors: 0          TX-bytes:  243858650692

  Throughput (since last show)
  Rx-pps:      2880720          Rx-bps:  98209559280
  Tx-pps:      2880658          Tx-bps:  34890425968
  #########################################################################=
###

  ######################## NIC statistics for port 1  #####################=
###
  RX-packets: 161069346  RX-missed: 0          RX-bytes:  243858989844
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 161070988  TX-errors: 50004      TX-bytes:  243861475832

  Throughput (since last show)
  Rx-pps:      2880737          Rx-bps:  34891493424
  Tx-pps:      2880737          Tx-bps:  34891493424
  ########
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
?id=3D1747">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17516282500.F33df472.1904402--

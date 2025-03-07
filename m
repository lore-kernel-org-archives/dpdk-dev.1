Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3209DC19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 06:21:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE1A40A75;
	Fri,  7 Mar 2025 07:21:09 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 259394029E
 for <dev@dpdk.org>; Fri,  7 Mar 2025 07:21:08 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 06EA146362; Fri,  7 Mar 2025 07:21:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1671] [dpdk-25.03]
 loopback_virtio_user_server_mode: failed to launch dpdk-pdump
Date: Fri, 07 Mar 2025 06:21:07 +0000
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
Message-ID: <bug-1671-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17413284670.75f2.1279620
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


--17413284670.75f2.1279620
Date: Fri, 7 Mar 2025 07:21:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1671

            Bug ID: 1671
           Summary: [dpdk-25.03] loopback_virtio_user_server_mode: failed
                    to launch dpdk-pdump
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
OS: Ubuntu 24.04.1 LTS (Noble Numbat); 6.8.0-52-generic
Compiler: gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) Platinum 8280M CPU @ 2.70GHz

[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1.Build dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Denable_kmods=3DTrue -Dlibdir=3Dlib --default-library=3Dsta=
tic
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2.Launch vhost as client mode
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 4-6 -n 4 --file-prefix=3Dvho=
st
--no-pci   --vdev 'eth_vhost0,iface=3Dvhost-net,client=3D1,queues=3D8' -- -=
i --rxq=3D8
--txq=3D8 --nb-cores=3D1 --txd=3D1024 --rxd=3D1024

3, Launch virtio-user as server mode
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-3 -n 4  --file-prefix=3Dvi=
rtio
--no-pci   --vdev
'net_virtio_user0,mac=3D00:01:02:03:04:05,path=3Dvhost-net,server=3D1,queue=
s=3D8,mrg_rxbuf=3D1,in_order=3D1'
-- -i --txd=3D1024 --rxd=3D1024 --nb-cores=3D1 --rxq=3D8 --txq=3D8

4, Launch dpdk-pdump
x86_64-native-linuxapp-gcc/app/dpdk-pdump  -v --file-prefix=3Dvirtio -- --p=
dump=20
'device_id=3Dnet_virtio_user0,queue=3D0,rx-dev=3D/root/pdump-rx-q0.pcap,mbu=
f-size=3D8000'
--pdump=20
'device_id=3Dnet_virtio_user0,queue=3D1,rx-dev=3D/root/pdump-rx-q1.pcap,mbu=
f-size=3D8000'

[Actual Result]
root@dut220:~/dpdk# x86_64-native-linuxapp-gcc/app/dpdk-pdump  -v
--file-prefix=3Dvirtio -- --pdump=20
'device_id=3Dnet_virtio_user0,queue=3D0,rx-dev=3D/root/pdump-rx-q0.pcap,mbu=
f-size=3D8000'
--                             pdump=20
'device_id=3Dnet_virtio_user0,queue=3D1,rx-dev=3D/root/pdump-rx-q1.pcap,mbu=
f-size=3D8000'
EAL: Detected CPU lcores: 112
EAL: Detected NUMA nodes: 2
EAL: RTE Version: 'DPDK 25.03.0-rc1'
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/virtio/mp_socket_371105_2b2d9d66c56=
30c
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
Port 1 MAC: 02 70 63 61 70 00
EAL: failed to send to (/var/run/dpdk/virtio/mp_socket) due to No such file=
 or
directory
EAL: Fail to send request /var/run/dpdk/virtio/mp_socket:eal_dev_mp_request
EAL: Cannot send request to primary
EAL: Failed to send hotplug request to primary
EAL: failed to send to (/var/run/dpdk/virtio/mp_socket) due to No such file=
 or
directory
EAL: Cannot send message to primary
EAL: Error - exiting with code: 1
vdev creation failed:create_mp_ring_vdev:764


[Expected Result]
Launch successfully

[Regression]
Is this issue a regression: (Y)
Bad commit id:
commit 2d87f8569934ddbb7ffa7f9d70b3d72196bdbdf7 (HEAD -> 2d87f85699)
Author: Huisong Li <lihuisong@huawei.com>
Date:   Tue Feb 18 19:31:56 2025 +0800

    app/testpmd: fix queue numbers after device attach

    Testpmd doesn't modify the Rx/Tx queue number of all ports after
    attaching a new device. The root cause is that
     "port config all rxq <value>" would check if all ports are stopped and
    the status of this port is still in 'RTE_PORT_HANDLING'. This status is
    later changed to 'RTE_PORT_STOPPED' in setup_attached_port()
    when starting the port.

    In addition, this new port needs to be initialized in advance because
    this information is depended by many commands. Otherwise other commands
    like "port config xxx" may also encounter similar issues.
    The initialization can't be done in new event callback.
    This patch moves setup_attached_port() to the time point 100ms
    after receiving the new event.

    Bugzilla ID: 1663
    Fixes: 994635edb2c0 ("app/testpmd: add port attach/detach for multiple
process")

    Signed-off-by: Huisong Li <lihuisong@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17413284670.75f2.1279620
Date: Fri, 7 Mar 2025 07:21:07 +0100
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
   title=3D"UNCONFIRMED - [dpdk-25.03] loopback_virtio_user_server_mode: fa=
iled to launch dpdk-pdump"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1671">1671</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.03] loopback_virtio_user_server_mode: failed to laun=
ch dpdk-pdump
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
OS: Ubuntu 24.04.1 LTS (Noble Numbat); 6.8.0-52-generic
Compiler: gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) Platinum 8280M CPU &#64; 2.70GHz

[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1.Build dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Denable_kmods=3DTrue -Dlibdir=3Dlib --default-library=3Dsta=
tic
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2.Launch vhost as client mode
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 4-6 -n 4 --file-prefix=3Dvho=
st
--no-pci   --vdev 'eth_vhost0,iface=3Dvhost-net,client=3D1,queues=3D8' -- -=
i --rxq=3D8
--txq=3D8 --nb-cores=3D1 --txd=3D1024 --rxd=3D1024

3, Launch virtio-user as server mode
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-3 -n 4  --file-prefix=3Dvi=
rtio
--no-pci   --vdev
'net_virtio_user0,mac=3D00:01:02:03:04:05,path=3Dvhost-net,server=3D1,queue=
s=3D8,mrg_rxbuf=3D1,in_order=3D1'
-- -i --txd=3D1024 --rxd=3D1024 --nb-cores=3D1 --rxq=3D8 --txq=3D8

4, Launch dpdk-pdump
x86_64-native-linuxapp-gcc/app/dpdk-pdump  -v --file-prefix=3Dvirtio -- --p=
dump=20
'device_id=3Dnet_virtio_user0,queue=3D0,rx-dev=3D/root/pdump-rx-q0.pcap,mbu=
f-size=3D8000'
--pdump=20
'device_id=3Dnet_virtio_user0,queue=3D1,rx-dev=3D/root/pdump-rx-q1.pcap,mbu=
f-size=3D8000'

[Actual Result]
root&#64;dut220:~/dpdk# x86_64-native-linuxapp-gcc/app/dpdk-pdump  -v
--file-prefix=3Dvirtio -- --pdump=20
'device_id=3Dnet_virtio_user0,queue=3D0,rx-dev=3D/root/pdump-rx-q0.pcap,mbu=
f-size=3D8000'
--                             pdump=20
'device_id=3Dnet_virtio_user0,queue=3D1,rx-dev=3D/root/pdump-rx-q1.pcap,mbu=
f-size=3D8000'
EAL: Detected CPU lcores: 112
EAL: Detected NUMA nodes: 2
EAL: RTE Version: 'DPDK 25.03.0-rc1'
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/virtio/mp_socket_371105_2b2d9d66c56=
30c
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
Port 1 MAC: 02 70 63 61 70 00
EAL: failed to send to (/var/run/dpdk/virtio/mp_socket) due to No such file=
 or
directory
EAL: Fail to send request /var/run/dpdk/virtio/mp_socket:eal_dev_mp_request
EAL: Cannot send request to primary
EAL: Failed to send hotplug request to primary
EAL: failed to send to (/var/run/dpdk/virtio/mp_socket) due to No such file=
 or
directory
EAL: Cannot send message to primary
EAL: Error - exiting with code: 1
vdev creation failed:create_mp_ring_vdev:764


[Expected Result]
Launch successfully

[Regression]
Is this issue a regression: (Y)
Bad commit id:
commit 2d87f8569934ddbb7ffa7f9d70b3d72196bdbdf7 (HEAD -&gt; 2d87f85699)
Author: Huisong Li &lt;<a href=3D"mailto:lihuisong&#64;huawei.com">lihuison=
g&#64;huawei.com</a>&gt;
Date:   Tue Feb 18 19:31:56 2025 +0800

    app/testpmd: fix queue numbers after device attach

    Testpmd doesn't modify the Rx/Tx queue number of all ports after
    attaching a new device. The root cause is that
     &quot;port config all rxq &lt;value&gt;&quot; would check if all ports=
 are stopped and
    the status of this port is still in 'RTE_PORT_HANDLING'. This status is
    later changed to 'RTE_PORT_STOPPED' in setup_attached_port()
    when starting the port.

    In addition, this new port needs to be initialized in advance because
    this information is depended by many commands. Otherwise other commands
    like &quot;port config xxx&quot; may also encounter similar issues.
    The initialization can't be done in new event callback.
    This patch moves setup_attached_port() to the time point 100ms
    after receiving the new event.

    Bugzilla ID: 1663
    Fixes: 994635edb2c0 (&quot;app/testpmd: add port attach/detach for mult=
iple
process&quot;)

    Signed-off-by: Huisong Li &lt;<a href=3D"mailto:lihuisong&#64;huawei.co=
m">lihuisong&#64;huawei.com</a>&gt;
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
?id=3D1671">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17413284670.75f2.1279620--

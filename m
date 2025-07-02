Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2987C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 00:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 962BF40298;
	Wed,  2 Jul 2025 02:49:17 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2FD3940264
 for <dev@dpdk.org>; Wed,  2 Jul 2025 02:49:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 14A0F46ABD; Wed,  2 Jul 2025 02:49:16 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1735] [dpdk-25.07-rc2]
 vf_pf_reset/test_vlan_rx_restore_vf_reset_all_ports: Unable to receive VLAN
 packets
Date: Wed, 02 Jul 2025 00:49:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daxuex.gao@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1735-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17514173550.c2A6d.135684
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


--17514173550.c2A6d.135684
Date: Wed, 2 Jul 2025 02:49:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1735

            Bug ID: 1735
           Summary: [dpdk-25.07-rc2]
                    vf_pf_reset/test_vlan_rx_restore_vf_reset_all_ports:
                    Unable to receive VLAN packets
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: daxuex.gao@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 25.07.0-rc2: 20460dcffd08a468
OS: Ubuntu 24.04 LTS/6.8.0-60-generic
Compiler: gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
NIC hardware: Intel Corporation Ethernet Controller E810-C for SFP [8086:15=
93]
NIC firmware:=20
 driver: vfio-pci
 kdriver: 6.8.0-60-generic
 firmware-version: 4.70 0x8001f7b9 1.3755.0
 pkg: ice os default 1.3.36.0
scapy: 2.4.4

Test Setup
Steps to reproduce
List the steps to reproduce the issue.

1.dut:
# echo 2 > /sys/bus/pci/devices/0000\:05\:00.0/sriov_numvfs
# echo 2 > /sys/bus/pci/devices/0000\:05\:00.1/sriov_numvfs#
./usertools/dpdk-devbind.py -b vfio-pci 05:01.0  05:01.1
# ip link set ens785f0np0 vf 0 mac 00:11:22:33:44:11
# ip link set ens785f0np0 vf 1 mac 00:11:22:33:44:12
# x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-2 -n 4 -a 0000:05:01.0 -a
0000:05:01.1 --file-prefix=3Ddpdk_1907210_20250702192518    -- -i

2.dut-testpmd:
testpmd> set fwd mac
testpmd> set verbose 1
testpmd> vlan set filter on 0
testpmd> rx_vlan add 1 0
IAVF_DRIVER: iavf_execute_vf_cmd(): Cmd 28 not supported
IAVF_DRIVER: iavf_disable_vlan_strip(): Failed to execute command of
OP_DISABLE_VLAN_STRIPPING
rte_eth_dev_vlan_filter(port_pi=3D0, vlan_id=3D1, on=3D1) failed diag=3D-5
testpmd> rx_vlan add 1 1
IAVF_DRIVER: iavf_execute_vf_cmd(): Cmd 28 not supported
IAVF_DRIVER: iavf_disable_vlan_strip(): Failed to execute command of
OP_DISABLE_VLAN_STRIPPING
rte_eth_dev_vlan_filter(port_pi=3D1, vlan_id=3D1, on=3D1) failed diag=3D-5
testpmd> show port stats all
testpmd> clear port stats all
testpmd> port stop all
testpmd> port reset all
testpmd> port start all
testpmd> start
testpmd> show port stats all

3.tester-scapy send vlan package:
>>> sendp(
>>> Ether(dst=3D'00:11:22:33:44:11')/Dot1Q(vlan=3D1)/IP()/Raw(load=3Db'xxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
>>> iface=3D"ens161f0",count=3D10,inter=3D0.01,verbose=3DFalse)

4.Show the output from the previous commands.
testpmd> show port stats all
  ######################## NIC statistics for port 0  #####################=
###
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 0          TX-errors: 0          TX-bytes:  0  Throughput (si=
nce
last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###=20
######################## NIC statistics for port 1  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 0          TX-errors: 0          TX-bytes:  0  Throughput (si=
nce
last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###

Expected Result
=3D=3D=3D=3D=3D=3D=3D=3D
testpmd> show port stats all  ######################## NIC statistics for p=
ort
0  ########################
  RX-packets: 10         RX-missed: 0          RX-bytes:  1020
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 0          TX-errors: 0          TX-bytes:  0  Throughput (si=
nce
last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###=20
######################## NIC statistics for port 1  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 10         TX-errors: 0          TX-bytes:  1020  Throughput
(since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###
Regression
Is this issue a regression: (Y/N)Y

commit 3bfad066f9b4764981c9ad90a750fa6f1afcf15a (HEAD)
Author: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date:   Mon Jun 23 23:41:36 2025 +0530

    net/iavf: fix VLAN strip setting after enabling filter

    For i40e kernel drivers which support either vlan(v1) or vlan(v2)
    VIRTCHNL OP, it will set strip on when setting filter on.
    But DPDK side will not change strip flag.
    To be consistent with DPDL side, explicitly disable strip again.

    Bugzilla ID: 1725
    Fixes: e25c7ed114b2 ("net/iavf: fix VLAN offload strip flag")
    Cc: stable@dpdk.org

    Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
    Reviewed-by: Ciara Loftus <ciara.loftus@intel.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17514173550.c2A6d.135684
Date: Wed, 2 Jul 2025 02:49:15 +0200
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
   title=3D"UNCONFIRMED - [dpdk-25.07-rc2] vf_pf_reset/test_vlan_rx_restore=
_vf_reset_all_ports: Unable to receive VLAN packets"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1735">1735</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.07-rc2] vf_pf_reset/test_vlan_rx_restore_vf_reset_al=
l_ports: Unable to receive VLAN packets
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
          <td>testpmd
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>daxuex.gao&#64;intel.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 25.07.0-rc2: 20460dcffd08a468
OS: Ubuntu 24.04 LTS/6.8.0-60-generic
Compiler: gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) CPU E5-2699 v4 &#64; 2.20GHz
NIC hardware: Intel Corporation Ethernet Controller E810-C for SFP [8086:15=
93]
NIC firmware:=20
 driver: vfio-pci
 kdriver: 6.8.0-60-generic
 firmware-version: 4.70 0x8001f7b9 1.3755.0
 pkg: ice os default 1.3.36.0
scapy: 2.4.4

Test Setup
Steps to reproduce
List the steps to reproduce the issue.

1.dut:
# echo 2 &gt; /sys/bus/pci/devices/0000\:05\:00.0/sriov_numvfs
# echo 2 &gt; /sys/bus/pci/devices/0000\:05\:00.1/sriov_numvfs#
./usertools/dpdk-devbind.py -b vfio-pci 05:01.0  05:01.1
# ip link set ens785f0np0 vf 0 mac 00:11:22:33:44:11
# ip link set ens785f0np0 vf 1 mac 00:11:22:33:44:12
# x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-2 -n 4 -a 0000:05:01.0 -a
0000:05:01.1 --file-prefix=3Ddpdk_1907210_20250702192518    -- -i

2.dut-testpmd:
testpmd&gt; set fwd mac
testpmd&gt; set verbose 1
testpmd&gt; vlan set filter on 0
testpmd&gt; rx_vlan add 1 0
IAVF_DRIVER: iavf_execute_vf_cmd(): Cmd 28 not supported
IAVF_DRIVER: iavf_disable_vlan_strip(): Failed to execute command of
OP_DISABLE_VLAN_STRIPPING
rte_eth_dev_vlan_filter(port_pi=3D0, vlan_id=3D1, on=3D1) failed diag=3D-5
testpmd&gt; rx_vlan add 1 1
IAVF_DRIVER: iavf_execute_vf_cmd(): Cmd 28 not supported
IAVF_DRIVER: iavf_disable_vlan_strip(): Failed to execute command of
OP_DISABLE_VLAN_STRIPPING
rte_eth_dev_vlan_filter(port_pi=3D1, vlan_id=3D1, on=3D1) failed diag=3D-5
testpmd&gt; show port stats all
testpmd&gt; clear port stats all
testpmd&gt; port stop all
testpmd&gt; port reset all
testpmd&gt; port start all
testpmd&gt; start
testpmd&gt; show port stats all

3.tester-scapy send vlan package:
<span class=3D"quote">&gt;&gt;&gt; sendp(
&gt;&gt;&gt; Ether(dst=3D'00:11:22:33:44:11')/Dot1Q(vlan=3D1)/IP()/Raw(load=
=3Db'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
&gt;&gt;&gt; iface=3D&quot;ens161f0&quot;,count=3D10,inter=3D0.01,verbose=
=3DFalse)</span >

4.Show the output from the previous commands.
testpmd&gt; show port stats all
  ######################## NIC statistics for port 0  #####################=
###
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 0          TX-errors: 0          TX-bytes:  0  Throughput (si=
nce
last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###=20
######################## NIC statistics for port 1  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 0          TX-errors: 0          TX-bytes:  0  Throughput (si=
nce
last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###

Expected Result
=3D=3D=3D=3D=3D=3D=3D=3D
testpmd&gt; show port stats all  ######################## NIC statistics fo=
r port
0  ########################
  RX-packets: 10         RX-missed: 0          RX-bytes:  1020
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 0          TX-errors: 0          TX-bytes:  0  Throughput (si=
nce
last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###=20
######################## NIC statistics for port 1  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 10         TX-errors: 0          TX-bytes:  1020  Throughput
(since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:            0          Tx-bps:            0
  #########################################################################=
###
Regression
Is this issue a regression: (Y/N)Y

commit 3bfad066f9b4764981c9ad90a750fa6f1afcf15a (HEAD)
Author: Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.mohakud&#64;=
gmail.com">amiyaranjan.mohakud&#64;gmail.com</a>&gt;
Date:   Mon Jun 23 23:41:36 2025 +0530

    net/iavf: fix VLAN strip setting after enabling filter

    For i40e kernel drivers which support either vlan(v1) or vlan(v2)
    VIRTCHNL OP, it will set strip on when setting filter on.
    But DPDK side will not change strip flag.
    To be consistent with DPDL side, explicitly disable strip again.

    Bugzilla ID: 1725
    Fixes: e25c7ed114b2 (&quot;net/iavf: fix VLAN offload strip flag&quot;)
    Cc: <a href=3D"mailto:stable&#64;dpdk.org">stable&#64;dpdk.org</a>

    Signed-off-by: Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.m=
ohakud&#64;gmail.com">amiyaranjan.mohakud&#64;gmail.com</a>&gt;
    Reviewed-by: Ciara Loftus &lt;<a href=3D"mailto:ciara.loftus&#64;intel.=
com">ciara.loftus&#64;intel.com</a>&gt;
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
?id=3D1735">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17514173550.c2A6d.135684--

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724CDC021A0
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 08:35:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EFD6400D5;
	Mon, 17 Feb 2025 09:35:55 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id A514440041
 for <dev@dpdk.org>; Mon, 17 Feb 2025 09:35:53 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8B2A046246; Mon, 17 Feb 2025 09:35:53 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1662] [dpdk-25.03] [NNT] pmd_bonded_8023ad: port
 start failed after set bonding lacp
Date: Mon, 17 Feb 2025 08:35:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 24.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: songx.jiale@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1662-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17397813530.12f3.3445304
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


--17397813530.12f3.3445304
Date: Mon, 17 Feb 2025 09:35:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1662

            Bug ID: 1662
           Summary: [dpdk-25.03] [NNT] pmd_bonded_8023ad: port start
                    failed after set bonding lacp
           Product: DPDK
           Version: 24.07
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: songx.jiale@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: e5176f23ae8b31437c3e5eb875c81f95bf3a9942 version: 25.03-rc1
OS: Ubuntu24.04.1 LTS (Noble Numbat)/6.8.0-41-generic
Compiler:  gcc version 13.2.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz
NIC hardware: NNT(82599ES 10-Gigabit SFI/SFP+ Network Connection 10fb)
NIC firmware:=20
  driver: ixgbe-5.22.25
  FW: 0x000161bf

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. bind ports to dpdk=20
./usertools/dpdk-devbind.py -b vfio-pci 0000:b1:00.0 0000:b1:00.1
2. launch testpmd
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-39 -n 4 -a 0000:b1:00.0 -a
0000:b1:00.1 -- -i
3. create bonding device
port stop all
create bonding device 4 1
add bonding member 0 2
add bonding member 1 2
4. set bonding lacp
set bonding lacp dedicated_queues 2 enable
port start all
show port info all


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
the link status of all ports is down and have some error info.

Please remove port 0 from bonding device.
Please remove port 1 from bonding device.
Configuring Port 2 (socket 1)
ETHDEV: Device with port_id=3D0 already stopped
ETHDEV: Device with port_id=3D1 already stopped
ETHDEV: Device with port_id=3D0 already stopped
IXGBE_INIT: ixgbe_dev_tx_queue_setup(): tx_rs_thresh + tx_free_thresh must =
not
exceed nb_desc. (tx_rs_thresh=3D32 tx_free_thresh=3D32 nb_desc=3D32 port =
=3D 0 queue=3D1)
BOND: member_configure_slow_queue(1726) - rte_eth_tx_queue_setup: port=3D0
queue_id 1, err (-22)
ETHDEV: Device with port_id=3D1 already stopped
IXGBE_INIT: ixgbe_dev_tx_queue_setup(): tx_rs_thresh + tx_free_thresh must =
not
exceed nb_desc. (tx_rs_thresh=3D32 tx_free_thresh=3D32 nb_desc=3D32 port =
=3D 1 queue=3D1)
BOND: member_configure_slow_queue(1726) - rte_eth_tx_queue_setup: port=3D1
queue_id 1, err (-22)
Port 2: 90:E2:BA:D5:B2:38
Checking link statuses...
Done

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The status of all ports is normal.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 4da0705bf896327af062212b5a1e6cb1f1366aa5
Author: Long Wu <long.wu@corigine.com>
Date:   Thu Dec 26 09:26:18 2024 +0800

    net/bonding: fix dedicated queue setup

    The bonding PMD hardcoded the value of dedicated hardware Rx/Tx
    queue size as (128/512). This will cause the bonding port start
    fail if some NIC requires more Rx/Tx descriptors than the hardcoded
    number.

    Therefore, use the minimum hardware queue size of the member port
    to initialize dedicated hardware Rx/Tx queue. If obtaining the
    minimum queue size failed, use the default queue size.

    Fixes: 112891cd27e5 ("net/bonding: add dedicated HW queues for LACP
control")
    Cc: stable@dpdk.org

    Signed-off-by: Long Wu <long.wu@corigine.com>
    Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>

 drivers/net/bonding/rte_eth_bond_8023ad.h |  3 +++
 drivers/net/bonding/rte_eth_bond_pmd.c    | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions, 3 deletions

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17397813530.12f3.3445304
Date: Mon, 17 Feb 2025 09:35:53 +0100
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
   title=3D"UNCONFIRMED - [dpdk-25.03] [NNT] pmd_bonded_8023ad: port start =
failed after set bonding lacp"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1662">1662</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.03] [NNT] pmd_bonded_8023ad: port start failed after=
 set bonding lacp
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.07
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
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
          <td>songx.jiale&#64;intel.com
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
DPDK version: e5176f23ae8b31437c3e5eb875c81f95bf3a9942 version: 25.03-rc1
OS: Ubuntu24.04.1 LTS (Noble Numbat)/6.8.0-41-generic
Compiler:  gcc version 13.2.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU &#64; 2.30GHz
NIC hardware: NNT(82599ES 10-Gigabit SFI/SFP+ Network Connection 10fb)
NIC firmware:=20
  driver: ixgbe-5.22.25
  FW: 0x000161bf

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. bind ports to dpdk=20
./usertools/dpdk-devbind.py -b vfio-pci 0000:b1:00.0 0000:b1:00.1
2. launch testpmd
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-39 -n 4 -a 0000:b1:00.0 -a
0000:b1:00.1 -- -i
3. create bonding device
port stop all
create bonding device 4 1
add bonding member 0 2
add bonding member 1 2
4. set bonding lacp
set bonding lacp dedicated_queues 2 enable
port start all
show port info all


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
the link status of all ports is down and have some error info.

Please remove port 0 from bonding device.
Please remove port 1 from bonding device.
Configuring Port 2 (socket 1)
ETHDEV: Device with port_id=3D0 already stopped
ETHDEV: Device with port_id=3D1 already stopped
ETHDEV: Device with port_id=3D0 already stopped
IXGBE_INIT: ixgbe_dev_tx_queue_setup(): tx_rs_thresh + tx_free_thresh must =
not
exceed nb_desc. (tx_rs_thresh=3D32 tx_free_thresh=3D32 nb_desc=3D32 port =
=3D 0 queue=3D1)
BOND: member_configure_slow_queue(1726) - rte_eth_tx_queue_setup: port=3D0
queue_id 1, err (-22)
ETHDEV: Device with port_id=3D1 already stopped
IXGBE_INIT: ixgbe_dev_tx_queue_setup(): tx_rs_thresh + tx_free_thresh must =
not
exceed nb_desc. (tx_rs_thresh=3D32 tx_free_thresh=3D32 nb_desc=3D32 port =
=3D 1 queue=3D1)
BOND: member_configure_slow_queue(1726) - rte_eth_tx_queue_setup: port=3D1
queue_id 1, err (-22)
Port 2: 90:E2:BA:D5:B2:38
Checking link statuses...
Done

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The status of all ports is normal.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 4da0705bf896327af062212b5a1e6cb1f1366aa5
Author: Long Wu &lt;<a href=3D"mailto:long.wu&#64;corigine.com">long.wu&#64=
;corigine.com</a>&gt;
Date:   Thu Dec 26 09:26:18 2024 +0800

    net/bonding: fix dedicated queue setup

    The bonding PMD hardcoded the value of dedicated hardware Rx/Tx
    queue size as (128/512). This will cause the bonding port start
    fail if some NIC requires more Rx/Tx descriptors than the hardcoded
    number.

    Therefore, use the minimum hardware queue size of the member port
    to initialize dedicated hardware Rx/Tx queue. If obtaining the
    minimum queue size failed, use the default queue size.

    Fixes: 112891cd27e5 (&quot;net/bonding: add dedicated HW queues for LACP
control&quot;)
    Cc: <a href=3D"mailto:stable&#64;dpdk.org">stable&#64;dpdk.org</a>

    Signed-off-by: Long Wu &lt;<a href=3D"mailto:long.wu&#64;corigine.com">=
long.wu&#64;corigine.com</a>&gt;
    Reviewed-by: Chaoyong He &lt;<a href=3D"mailto:chaoyong.he&#64;corigine=
.com">chaoyong.he&#64;corigine.com</a>&gt;

 drivers/net/bonding/rte_eth_bond_8023ad.h |  3 +++
 drivers/net/bonding/rte_eth_bond_pmd.c    | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions, 3 deletions
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
?id=3D1662">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17397813530.12f3.3445304--

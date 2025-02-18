Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85849C021A9
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 01:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D3BA4014F;
	Tue, 18 Feb 2025 02:35:35 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DA6CF400EF
 for <dev@dpdk.org>; Tue, 18 Feb 2025 02:35:33 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C4D0246254; Tue, 18 Feb 2025 02:35:33 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1663] [dpdk-25.03]
 flexible_rxd/check_IPv4_IPv6_TCP_fields_in_RXD_on_specific_queues: port
 config rxq/txq failed after attach port
Date: Tue, 18 Feb 2025 01:35:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.03
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
Message-ID: <bug-1663-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17398425330.AbACC4.3933122
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


--17398425330.AbACC4.3933122
Date: Tue, 18 Feb 2025 02:35:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1663

            Bug ID: 1663
           Summary: [dpdk-25.03]
                    flexible_rxd/check_IPv4_IPv6_TCP_fields_in_RXD_on_spec
                    ific_queues: port config rxq/txq failed after attach
                    port
           Product: DPDK
           Version: 25.03
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
NIC hardware: Intel Corporation Ethernet Controller E810-C for SFP [8086:15=
93]
(rev 01)
NIC firmware:=20
  driver: ice-1.16.3
  FW: 4.70 0x8001f7e2 1.3755.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. bind ports to dpdk=20=20
./usertools/dpdk-devbind.py -b vfio-pci 0000:af:00.0
2. launch testpmd=20
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-3 -n 4 -a 0000:af:00.0 -- =
-i=20
3. detach and attach ports
port stop all
port detach 0
port attach 0000:af:00.0
port stop all
4. config port rxq/txq=20
port config all rxq 16
port config all txq 16=20=20


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
The status of the port is down, but it cannot be configured.
testpmd> port config all rxq 16
Please stop all ports first
testpmd> port config all txq 16
Please stop all ports first

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Can successfully configure rxq/txq after attaching the port.
testpmd> port config all rxq 16
testpmd> port config all txq 16

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 994635edb2c038e64617bcf2790a8cd326c3e8e0
Author: Huisong Li <lihuisong@huawei.com>
Date:   Mon Jan 20 14:42:18 2025 +0800

    app/testpmd: add port attach/detach for multiple process

    The port information needs to be updated due to attaching and detaching
    port. Currently, it is done in the same thread as removing or probing
    device, which doesn't satisfy the operation of attaching and detaching
    device in multiple process.

    If this operation is performed in one process, the other process can
    receive 'new' or 'destroy' event. So we can move updating port informat=
ion
    to event callback to support attaching and detaching port in primary and
    secondary process.

    Note: the reason for adding an alarm callback in 'destroy' event is that
    the ethdev state is changed from 'ATTACHED' to 'UNUSED' only after the
    event callback finished. But the remove_invalid_ports() function removes
    invalid port only if ethdev state is 'UNUSED'. If we don't add alarm
    callback, this detached port information can not be removed.

    Signed-off-by: Huisong Li <lihuisong@huawei.com>
    Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
    Acked-by: Chengwen Feng <fengchengwen@huawei.com>

 app/test-pmd/testpmd.c | 68 +++++++++++++++++++++++++++++++++++++---------=
----
 1 file changed, 51 insertions, 17 deletions

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17398425330.AbACC4.3933122
Date: Tue, 18 Feb 2025 02:35:33 +0100
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
   title=3D"UNCONFIRMED - [dpdk-25.03] flexible_rxd/check_IPv4_IPv6_TCP_fie=
lds_in_RXD_on_specific_queues: port config rxq/txq failed after attach port"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1663">1663</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.03] flexible_rxd/check_IPv4_IPv6_TCP_fields_in_RXD_o=
n_specific_queues: port config rxq/txq failed after attach port
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
NIC hardware: Intel Corporation Ethernet Controller E810-C for SFP [8086:15=
93]
(rev 01)
NIC firmware:=20
  driver: ice-1.16.3
  FW: 4.70 0x8001f7e2 1.3755.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. bind ports to dpdk=20=20
./usertools/dpdk-devbind.py -b vfio-pci 0000:af:00.0
2. launch testpmd=20
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-3 -n 4 -a 0000:af:00.0 -- =
-i=20
3. detach and attach ports
port stop all
port detach 0
port attach 0000:af:00.0
port stop all
4. config port rxq/txq=20
port config all rxq 16
port config all txq 16=20=20


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
The status of the port is down, but it cannot be configured.
testpmd&gt; port config all rxq 16
Please stop all ports first
testpmd&gt; port config all txq 16
Please stop all ports first

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Can successfully configure rxq/txq after attaching the port.
testpmd&gt; port config all rxq 16
testpmd&gt; port config all txq 16

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 994635edb2c038e64617bcf2790a8cd326c3e8e0
Author: Huisong Li &lt;<a href=3D"mailto:lihuisong&#64;huawei.com">lihuison=
g&#64;huawei.com</a>&gt;
Date:   Mon Jan 20 14:42:18 2025 +0800

    app/testpmd: add port attach/detach for multiple process

    The port information needs to be updated due to attaching and detaching
    port. Currently, it is done in the same thread as removing or probing
    device, which doesn't satisfy the operation of attaching and detaching
    device in multiple process.

    If this operation is performed in one process, the other process can
    receive 'new' or 'destroy' event. So we can move updating port informat=
ion
    to event callback to support attaching and detaching port in primary and
    secondary process.

    Note: the reason for adding an alarm callback in 'destroy' event is that
    the ethdev state is changed from 'ATTACHED' to 'UNUSED' only after the
    event callback finished. But the remove_invalid_ports() function removes
    invalid port only if ethdev state is 'UNUSED'. If we don't add alarm
    callback, this detached port information can not be removed.

    Signed-off-by: Huisong Li &lt;<a href=3D"mailto:lihuisong&#64;huawei.co=
m">lihuisong&#64;huawei.com</a>&gt;
    Signed-off-by: Dongdong Liu &lt;<a href=3D"mailto:liudongdong3&#64;huaw=
ei.com">liudongdong3&#64;huawei.com</a>&gt;
    Acked-by: Chengwen Feng &lt;<a href=3D"mailto:fengchengwen&#64;huawei.c=
om">fengchengwen&#64;huawei.com</a>&gt;

 app/test-pmd/testpmd.c | 68 +++++++++++++++++++++++++++++++++++++---------=
----
 1 file changed, 51 insertions, 17 deletions
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
?id=3D1663">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17398425330.AbACC4.3933122--

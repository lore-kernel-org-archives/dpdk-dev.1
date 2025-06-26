Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F5C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 19:13:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24E354026F;
	Thu, 26 Jun 2025 21:13:41 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8A7574026C
 for <dev@dpdk.org>; Thu, 26 Jun 2025 21:13:40 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 81E4046A65; Thu, 26 Jun 2025 21:13:40 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1732] E830 Tx packet pacing support causing seg
 fault on E810
Date: Thu, 26 Jun 2025 19:13:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mmahajan@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1732-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17509652200.3Baf39d.489296
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


--17509652200.3Baf39d.489296
Date: Thu, 26 Jun 2025 21:13:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1732

            Bug ID: 1732
           Summary: E830 Tx packet pacing support causing seg fault on
                    E810
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: mmahajan@iol.unh.edu
  Target Milestone: ---

Hello,

A new patch was committed to dpdk-next-net-intel a few days ago, and since =
then
our Intel E810 100G forwarding performance test has not been running because
testpmd is segfaulting on startup.

The patch that introduced the issue is: "net/intel: add Tx packet pacing
support for E830" (commit ID: fd8ef1fc471f7eef6b103ece65f00de655f13ed4). It=
 was
authored by Soumyadeep Hore and merged into dpdk-next-net-intel on 2025-06-=
23.


EAL:
build/app/dpdk-testpmd \
  -l 4-5 -n 4 \
  --file-prefix=3Ddpdk_179921_20250626115614 \
  -a 0000:4b:00.0 -a 0000:4b:00.1 \
  -- -i \
  --portmask=3D0x3 \
  --rxq=3D1 \
  --txq=3D1 \
  --port-topology=3Dloop \
  --txd=3D512 \
  --rxd=3D512 \
  --nb-cores=3D1
EAL: Detected CPU lcores: 128
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_179921_20250626115614/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.39.1, ICE OS Default
Package (double VLAN mode)
ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.39.1, ICE OS Default
Package (double VLAN mode)
Interactive-mode selected
testpmd: create a new mbuf pool <mb_pool_0>: n=3D155456, size=3D2176, socke=
t=3D0
testpmd: preferred mempool ops selected: ring_mp_mc
Configuring Port 0 (socket 0)
Segmentation fault (core dumped)


NIC info:
Intel Corporation Ethernet Controller E810-C for QSFP

ethtool:
driver: ice
version: 5.15.0-142-generic
firmware-version: 4.80 0x80020543 1.3805.0
bus-info: 0000:4b:00.0

Ice version: 1.3.39.1

OS: Ubuntu VERSION=3D"22.04.3 LTS (Jammy Jellyfish)"
Arch: x86
CPU: Intel(R) Xeon(R) Platinum 8360Y CPU @ 2.40GHz

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17509652200.3Baf39d.489296
Date: Thu, 26 Jun 2025 21:13:40 +0200
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
   title=3D"UNCONFIRMED - E830 Tx packet pacing support causing seg fault o=
n E810"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1732">1732</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>E830 Tx packet pacing support causing seg fault on E810
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
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>mmahajan&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hello,

A new patch was committed to dpdk-next-net-intel a few days ago, and since =
then
our Intel E810 100G forwarding performance test has not been running because
testpmd is segfaulting on startup.

The patch that introduced the issue is: &quot;net/intel: add Tx packet paci=
ng
support for E830&quot; (commit ID: fd8ef1fc471f7eef6b103ece65f00de655f13ed4=
). It was
authored by Soumyadeep Hore and merged into dpdk-next-net-intel on 2025-06-=
23.


EAL:
build/app/dpdk-testpmd \
  -l 4-5 -n 4 \
  --file-prefix=3Ddpdk_179921_20250626115614 \
  -a 0000:4b:00.0 -a 0000:4b:00.1 \
  -- -i \
  --portmask=3D0x3 \
  --rxq=3D1 \
  --txq=3D1 \
  --port-topology=3Dloop \
  --txd=3D512 \
  --rxd=3D512 \
  --nb-cores=3D1
EAL: Detected CPU lcores: 128
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_179921_20250626115614/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.39.1, ICE OS Default
Package (double VLAN mode)
ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.39.1, ICE OS Default
Package (double VLAN mode)
Interactive-mode selected
testpmd: create a new mbuf pool &lt;mb_pool_0&gt;: n=3D155456, size=3D2176,=
 socket=3D0
testpmd: preferred mempool ops selected: ring_mp_mc
Configuring Port 0 (socket 0)
Segmentation fault (core dumped)


NIC info:
Intel Corporation Ethernet Controller E810-C for QSFP

ethtool:
driver: ice
version: 5.15.0-142-generic
firmware-version: 4.80 0x80020543 1.3805.0
bus-info: 0000:4b:00.0

Ice version: 1.3.39.1

OS: Ubuntu VERSION=3D&quot;22.04.3 LTS (Jammy Jellyfish)&quot;
Arch: x86
CPU: Intel(R) Xeon(R) Platinum 8360Y CPU &#64; 2.40GHz
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
?id=3D1732">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17509652200.3Baf39d.489296--

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D0EC369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 20:23:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ABFD402AE;
	Tue,  8 Apr 2025 22:23:49 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id F32074026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 22:23:47 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0D23B46539; Tue,  8 Apr 2025 22:23:47 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1695] pdump regression caused by test-pmd change
Date: Tue, 08 Apr 2025 20:23:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1695-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17441438260.F29B8d4EF.661809
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


--17441438260.F29B8d4EF.661809
Date: Tue, 8 Apr 2025 22:23:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1695

            Bug ID: 1695
           Summary: pdump regression caused by test-pmd change
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Using pdump on test-pmd no longer works because of recent regression.
When new device is attached such as pdump using hotplug load pcap PMD;
testpmd now tries to configure it and gets all confused.

# ./build/app/dpdk-testpmd  -l 0-3 --vdev=3Dnet_tap0 -- -i
EAL: Detected CPU lcores: 20
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
Interactive-mode selected
testpmd: create a new mbuf pool <mb_pool_0>: n=3D171456, size=3D2176, socke=
t=3D0
testpmd: preferred mempool ops selected: ring_mp_mc

Warning! port-topology=3Dpaired and odd forward ports number, the last port=
 will
pair with itself.

Configuring Port 0 (socket 0)
Port 0: 4E:FB:7B:20:DA:C2
Checking link statuses...
Done
testpmd> Port 1 is probed. Now total ports is 2
Warning: NUMA should be configured manually by using --port-numa-config and
--ring-numa-config parameters along with --numa.
ETHDEV: The port (ID=3D1) is already configured
EAL: Error - exiting with code: 1
Error when negotiating Rx meta features on port 1: Device or resource busy

# ./build/app/dpdk-pdump -l 5 -- --pdump
'port=3D0,queue=3D*,rx-dev=3D/tmp/rx-pdump.pcap'
EAL: Detected CPU lcores: 20
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_157372_1614979f4fed
EAL: Selected IOVA mode 'VA'
Port 1 MAC: 02 70 63 61 70 00
 core (5), capture for (1) tuples
 - port 0 device ((null)) queue 65535
Primary process is no longer active, exiting..

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17441438260.F29B8d4EF.661809
Date: Tue, 8 Apr 2025 22:23:46 +0200
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
   title=3D"UNCONFIRMED - pdump regression caused by test-pmd change"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1695">1695</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>pdump regression caused by test-pmd change
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
          <td>major
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
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Using pdump on test-pmd no longer =
works because of recent regression.
When new device is attached such as pdump using hotplug load pcap PMD;
testpmd now tries to configure it and gets all confused.

# ./build/app/dpdk-testpmd  -l 0-3 --vdev=3Dnet_tap0 -- -i
EAL: Detected CPU lcores: 20
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
Interactive-mode selected
testpmd: create a new mbuf pool &lt;mb_pool_0&gt;: n=3D171456, size=3D2176,=
 socket=3D0
testpmd: preferred mempool ops selected: ring_mp_mc

Warning! port-topology=3Dpaired and odd forward ports number, the last port=
 will
pair with itself.

Configuring Port 0 (socket 0)
Port 0: 4E:FB:7B:20:DA:C2
Checking link statuses...
Done
testpmd&gt; Port 1 is probed. Now total ports is 2
Warning: NUMA should be configured manually by using --port-numa-config and
--ring-numa-config parameters along with --numa.
ETHDEV: The port (ID=3D1) is already configured
EAL: Error - exiting with code: 1
Error when negotiating Rx meta features on port 1: Device or resource busy

# ./build/app/dpdk-pdump -l 5 -- --pdump
'port=3D0,queue=3D*,rx-dev=3D/tmp/rx-pdump.pcap'
EAL: Detected CPU lcores: 20
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_157372_1614979f4fed
EAL: Selected IOVA mode 'VA'
Port 1 MAC: 02 70 63 61 70 00
 core (5), capture for (1) tuples
 - port 0 device ((null)) queue 65535
Primary process is no longer active, exiting..
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
?id=3D1695">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17441438260.F29B8d4EF.661809--

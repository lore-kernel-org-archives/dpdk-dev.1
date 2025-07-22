Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8709C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 15:20:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBC4F40269;
	Tue, 22 Jul 2025 17:20:08 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CC76F4003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 17:20:06 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B8C8246BE9; Tue, 22 Jul 2025 17:20:06 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1760] Failed to send message on primary process exit
Date: Tue, 22 Jul 2025 15:20:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
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
Message-ID: <bug-1760-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17531976060.FbdD7B.3369805
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


--17531976060.FbdD7B.3369805
Date: Tue, 22 Jul 2025 17:20:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1760

            Bug ID: 1760
           Summary: Failed to send message on primary process exit
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

When a secondary process detects primary process has exited and calls
eal_cleanup a warning message is generated.

Primary: testpmd
# dpdk-testpmd  -l 0-3  --vdev=3Dnet_tap0 -- -i

testpmd> start
...
testpmd> quit


Secondary: dumpcap
# dpdk-dumpcap
File: /tmp/dpdk-dumpcap_0_net_tap0_20250722081556.pcapng
Capturing on 'net_tap0'
Packets captured: 34 Primary process is no longer active, exiting...
EAL: failed to send to (/var/run/dpdk/rte/mp_socket) due to No such file or
directory
EAL: Fail to send request /var/run/dpdk/rte/mp_socket:mp_pdump
PDUMP: pdump_prepare_client_request(): client request for pdump enable/disa=
ble
failed
EAL: failed to send to (/var/run/dpdk/rte/mp_socket) due to No such file or
directory
EAL: Cannot send message to primary

Dumpcap is doing the right thing and detecing, the problem is internal to E=
AL.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17531976060.FbdD7B.3369805
Date: Tue, 22 Jul 2025 17:20:06 +0200
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
   title=3D"UNCONFIRMED - Failed to send message on primary process exit"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1760">1760</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Failed to send message on primary process exit
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.07
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
          <td>core
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
          <pre class=3D"bz_comment_text">When a secondary process detects p=
rimary process has exited and calls
eal_cleanup a warning message is generated.

Primary: testpmd
# dpdk-testpmd  -l 0-3  --vdev=3Dnet_tap0 -- -i

testpmd&gt; start
...
testpmd&gt; quit


Secondary: dumpcap
# dpdk-dumpcap
File: /tmp/dpdk-dumpcap_0_net_tap0_20250722081556.pcapng
Capturing on 'net_tap0'
Packets captured: 34 Primary process is no longer active, exiting...
EAL: failed to send to (/var/run/dpdk/rte/mp_socket) due to No such file or
directory
EAL: Fail to send request /var/run/dpdk/rte/mp_socket:mp_pdump
PDUMP: pdump_prepare_client_request(): client request for pdump enable/disa=
ble
failed
EAL: failed to send to (/var/run/dpdk/rte/mp_socket) due to No such file or
directory
EAL: Cannot send message to primary

Dumpcap is doing the right thing and detecing, the problem is internal to E=
AL.
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
?id=3D1760">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17531976060.FbdD7B.3369805--

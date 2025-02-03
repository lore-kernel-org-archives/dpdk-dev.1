Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AF6C0218F
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 02:39:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA7C1400EF;
	Mon,  3 Feb 2025 03:39:46 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 19E69400D7
 for <dev@dpdk.org>; Mon,  3 Feb 2025 03:39:46 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id F363E4617B; Mon,  3 Feb 2025 03:39:45 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1627] Not all variants of supported NIC types have
 been used in testing
Date: Mon, 03 Feb 2025 02:39:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nandinipersad361@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1627-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385503850.8FeDaF.2106775
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


--17385503850.8FeDaF.2106775
Date: Mon, 3 Feb 2025 03:39:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1627

            Bug ID: 1627
           Summary: Not all variants of supported NIC types have been used
                    in testing
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: nandinipersad361@gmail.com
  Target Milestone: ---

Description:
The supported network interface cards can come in a number of variants with
different device ID=E2=80=99s. Not all of these variants have been tested w=
ith the
DPDK.

The NIC device identifiers used during testing:

Intel=C2=AE Ethernet Controller XL710 for 40GbE QSFP+ [8086:1584]

Intel=C2=AE Ethernet Controller XL710 for 40GbE QSFP+ [8086:1583]

Intel=C2=AE Ethernet Controller X710 for 10GbE SFP+ [8086:1572]

Intel=C2=AE 82576 Gigabit Ethernet Controller [8086:10c9]

Intel=C2=AE 82576 Quad Copper Gigabit Ethernet Controller [8086:10e8]

Intel=C2=AE 82580 Dual Copper Gigabit Ethernet Controller [8086:150e]

Intel=C2=AE I350 Quad Copper Gigabit Ethernet Controller [8086:1521]

Intel=C2=AE 82599 Dual Fibre 10 Gigabit Ethernet Controller [8086:10fb]

Intel=C2=AE Ethernet Server Adapter X520-T2 [8086: 151c]

Intel=C2=AE Ethernet Controller X540-T2 [8086:1528]

Intel=C2=AE 82574L Gigabit Network Connection [8086:10d3]

Emulated Intel=C2=AE 82540EM Gigabit Ethernet Controller [8086:100e]

Emulated Intel=C2=AE 82545EM Gigabit Ethernet Controller [8086:100f]

Intel=C2=AE Ethernet Server Adapter X520-4 [8086:154a]

Intel=C2=AE Ethernet Controller I210 [8086:1533]

Implication:
Risk of issues with untested variants.

Resolution/Workaround:
Use tested NIC variants. For those supported Ethernet controllers, addition=
al
device IDs may be added to the software if required.

Affected Environment/Platform:
All.

Driver/Module:
Poll-mode drivers

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385503850.8FeDaF.2106775
Date: Mon, 3 Feb 2025 03:39:45 +0100
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
   title=3D"UNCONFIRMED - Not all variants of supported NIC types have been=
 used in testing"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1627">1627</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Not all variants of supported NIC types have been used in tes=
ting
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
          <td>nandinipersad361&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Description:
The supported network interface cards can come in a number of variants with
different device ID=E2=80=99s. Not all of these variants have been tested w=
ith the
DPDK.

The NIC device identifiers used during testing:

Intel=C2=AE Ethernet Controller XL710 for 40GbE QSFP+ [8086:1584]

Intel=C2=AE Ethernet Controller XL710 for 40GbE QSFP+ [8086:1583]

Intel=C2=AE Ethernet Controller X710 for 10GbE SFP+ [8086:1572]

Intel=C2=AE 82576 Gigabit Ethernet Controller [8086:10c9]

Intel=C2=AE 82576 Quad Copper Gigabit Ethernet Controller [8086:10e8]

Intel=C2=AE 82580 Dual Copper Gigabit Ethernet Controller [8086:150e]

Intel=C2=AE I350 Quad Copper Gigabit Ethernet Controller [8086:1521]

Intel=C2=AE 82599 Dual Fibre 10 Gigabit Ethernet Controller [8086:10fb]

Intel=C2=AE Ethernet Server Adapter X520-T2 [8086: 151c]

Intel=C2=AE Ethernet Controller X540-T2 [8086:1528]

Intel=C2=AE 82574L Gigabit Network Connection [8086:10d3]

Emulated Intel=C2=AE 82540EM Gigabit Ethernet Controller [8086:100e]

Emulated Intel=C2=AE 82545EM Gigabit Ethernet Controller [8086:100f]

Intel=C2=AE Ethernet Server Adapter X520-4 [8086:154a]

Intel=C2=AE Ethernet Controller I210 [8086:1533]

Implication:
Risk of issues with untested variants.

Resolution/Workaround:
Use tested NIC variants. For those supported Ethernet controllers, addition=
al
device IDs may be added to the software if required.

Affected Environment/Platform:
All.

Driver/Module:
Poll-mode drivers
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
?id=3D1627">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385503850.8FeDaF.2106775--

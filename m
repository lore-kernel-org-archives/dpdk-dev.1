Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369E4C83F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 15:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1D16402E6;
	Wed, 30 Jul 2025 17:18:25 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BFC13402C3
 for <dev@dpdk.org>; Wed, 30 Jul 2025 17:18:24 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A4DFA46C55; Wed, 30 Jul 2025 17:18:24 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1761] rte_raw_cksum_mbuf obtain incorrect cksum when
 a packet in mbuf split mode.
Date: Wed, 30 Jul 2025 15:18:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: yanglanping@bytedance.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1761-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17538887040.0CCA229.508620
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


--17538887040.0CCA229.508620
Date: Wed, 30 Jul 2025 17:18:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1761

            Bug ID: 1761
           Summary: rte_raw_cksum_mbuf obtain incorrect cksum when a
                    packet in mbuf split mode.
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: yanglanping@bytedance.com
  Target Milestone: ---

Hi.

This issue is about calc cksum, in rte_raw_cksum_mbuf function, when the pa=
cket
data is stored in multiple mbufs, below code easy overflow.

File rte_cksum.h
    line 159: if (done & 1)
    line 160:     tmp =3D rte_bswap16((uint16_t)tmp);=20
    line 161: sum +=3D tmp;

The tmp(uint32_t) variable can easily be greater than 0xFFFF, so (uint16_t)=
tmp
will discard the high 16bit, cause incorrect result.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17538887040.0CCA229.508620
Date: Wed, 30 Jul 2025 17:18:24 +0200
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
   title=3D"UNCONFIRMED - rte_raw_cksum_mbuf obtain incorrect cksum when a =
packet in mbuf split mode."
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1761">1761</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>rte_raw_cksum_mbuf obtain incorrect cksum when a packet in mb=
uf split mode.
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
          <td>critical
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
          <td>yanglanping&#64;bytedance.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hi.

This issue is about calc cksum, in rte_raw_cksum_mbuf function, when the pa=
cket
data is stored in multiple mbufs, below code easy overflow.

File rte_cksum.h
    line 159: if (done &amp; 1)
    line 160:     tmp =3D rte_bswap16((uint16_t)tmp);=20
    line 161: sum +=3D tmp;

The tmp(uint32_t) variable can easily be greater than 0xFFFF, so (uint16_t)=
tmp
will discard the high 16bit, cause incorrect result.
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
?id=3D1761">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17538887040.0CCA229.508620--

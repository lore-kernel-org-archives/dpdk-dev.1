Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62B7C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 15:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA7AB42DC7;
	Wed, 21 May 2025 17:21:25 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 000F942DB0
 for <dev@dpdk.org>; Wed, 21 May 2025 17:21:23 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EB9FA467B0; Wed, 21 May 2025 17:21:23 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1710] net/bnxt build failure with LTO enabled
Date: Wed, 21 May 2025 15:21:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
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
Message-ID: <bug-1710-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17478408830.2275.2314791
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


--17478408830.2275.2314791
Date: Wed, 21 May 2025 17:21:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1710

            Bug ID: 1710
           Summary: net/bnxt build failure with LTO enabled
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

3472/3591] Linking target drivers/librte_net_bnxt.so.25.2
In function =E2=80=98tfo_open=E2=80=99,
    inlined from =E2=80=98tfc_open=E2=80=99 at ../drivers/net/bnxt/tf_core/=
v3/tfc_init.c:34:2,
    inlined from =E2=80=98ulp_tfc_ctx_attach=E2=80=99 at
../drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c:783:7:
../drivers/net/bnxt/tf_core/v3/tfo.c:108:17: warning: =E2=80=98rte_free=E2=
=80=99 called on
pointer =E2=80=98bp_44(D)=E2=80=99 with nonzero offset 800 [-Wfree-nonheap-=
object]
  108 |                 rte_free(tfo);
      |                 ^
In function =E2=80=98tfo_open=E2=80=99,
    inlined from =E2=80=98tfc_open=E2=80=99 at ../drivers/net/bnxt/tf_core/=
v3/tfc_init.c:34:2,
    inlined from =E2=80=98ulp_tfc_init=E2=80=99 at
../drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c:957:7:
../drivers/net/bnxt/tf_core/v3/tfo.c:108:17: warning: =E2=80=98rte_free=E2=
=80=99 called on
pointer =E2=80=98bp_74(D)=E2=80=99 with nonzero offset 800 [-Wfree-nonheap-=
object]
  108 |                 rte_free(tfo);
      |                 ^

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17478408830.2275.2314791
Date: Wed, 21 May 2025 17:21:23 +0200
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
   title=3D"UNCONFIRMED - net/bnxt build failure with LTO enabled"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1710">1710</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/bnxt build failure with LTO enabled
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
          <pre class=3D"bz_comment_text">3472/3591] Linking target drivers/=
librte_net_bnxt.so.25.2
In function =E2=80=98tfo_open=E2=80=99,
    inlined from =E2=80=98tfc_open=E2=80=99 at ../drivers/net/bnxt/tf_core/=
v3/tfc_init.c:34:2,
    inlined from =E2=80=98ulp_tfc_ctx_attach=E2=80=99 at
../drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c:783:7:
../drivers/net/bnxt/tf_core/v3/tfo.c:108:17: warning: =E2=80=98rte_free=E2=
=80=99 called on
pointer =E2=80=98bp_44(D)=E2=80=99 with nonzero offset 800 [-Wfree-nonheap-=
object]
  108 |                 rte_free(tfo);
      |                 ^
In function =E2=80=98tfo_open=E2=80=99,
    inlined from =E2=80=98tfc_open=E2=80=99 at ../drivers/net/bnxt/tf_core/=
v3/tfc_init.c:34:2,
    inlined from =E2=80=98ulp_tfc_init=E2=80=99 at
../drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c:957:7:
../drivers/net/bnxt/tf_core/v3/tfo.c:108:17: warning: =E2=80=98rte_free=E2=
=80=99 called on
pointer =E2=80=98bp_74(D)=E2=80=99 with nonzero offset 800 [-Wfree-nonheap-=
object]
  108 |                 rte_free(tfo);
      |                 ^
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
?id=3D1710">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17478408830.2275.2314791--

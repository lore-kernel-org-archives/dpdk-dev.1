Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2769DC77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F2D340267;
	Thu,  3 Jul 2025 18:55:44 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6BB7240264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:55:43 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 5DB4646AE8; Thu,  3 Jul 2025 18:55:43 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1740] net/bnxt: duplicate code in branches
Date: Thu, 03 Jul 2025 16:55:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-1740-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515617430.EAeDd8a4.1302848
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


--17515617430.EAeDd8a4.1302848
Date: Thu, 3 Jul 2025 18:55:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1740

            Bug ID: 1740
           Summary: net/bnxt: duplicate code in branches
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building with compiler warning about duplicate branches finds:

[834/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_flow.c.o
../drivers/net/bnxt/bnxt_flow.c: In function
=E2=80=98bnxt_validate_and_parse_flow_type=E2=80=99:
../drivers/net/bnxt/bnxt_flow.c:263:80: warning: this condition has identic=
al
branches [-Wduplicated-branches]
  263 |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_MACADDR :
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
       ^
../drivers/net/bnxt/bnxt_flow.c:383:79: warning: this condition has identic=
al
branches [-Wduplicated-branches]
  383 |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
HWRM_CFA_NTUPLE_FILTER_ALLOC_INPUT_IP_ADDR_TYPE_IPV4 :
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      ^
../drivers/net/bnxt/bnxt_flow.c:448:75: warning: this condition has identic=
al
branches [-Wduplicated-branches]
  448 |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
NTUPLE_FLTR_ALLOC_INPUT_IP_ADDR_TYPE_IPV6 :
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  ^
[835/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_stats.c.o
[836/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_rxq.c.o
[837/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_txq.c.o
[838/3631] Compiling C object
drivers/libtmp_rte_net_bnx2x.a.p/net_bnx2x_bnx2x_stats.c.o
[839/3631] Compiling C object
drivers/libtmp_rte_net_bnx2x.a.p/net_bnx2x_ecore_sp.c.o
[840/3631] Compiling C object
drivers/libtmp_rte_common_qat.a.p/crypto_qat_qat_asym.c.o
[841/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_txr.c.o
../drivers/net/bnxt/bnxt_txr.c: In function =E2=80=98bnxt_start_xmit=E2=80=
=99:
../drivers/net/bnxt/bnxt_txr.c:410:74: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  410 |                 } else if ((tx_pkt->ol_flags &
PKT_TX_OIP_IIP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:402:78: note: previously used here
  402 |                 } else if ((tx_pkt->ol_flags &
PKT_TX_OIP_IIP_TCP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:418:70: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  418 |                 } else if ((tx_pkt->ol_flags & PKT_TX_IIP_UDP_CKSUM=
) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:414:74: note: previously used here
  414 |                 } else if ((tx_pkt->ol_flags &
PKT_TX_IIP_TCP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:430:70: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  430 |                 } else if ((tx_pkt->ol_flags & PKT_TX_OIP_UDP_CKSUM=
) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:426:74: note: previously used here
  426 |                 } else if ((tx_pkt->ol_flags &
PKT_TX_OIP_TCP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:450:73: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  450 |                 } else if ((tx_pkt->ol_flags & RTE_MBUF_F_TX_UDP_CK=
SUM)
=3D=3D
../drivers/net/bnxt/bnxt_txr.c:442:70: note: previously used here
  442 |                 } else if ((tx_pkt->ol_flags & PKT_TX_TCP_UDP_CKSUM=
) =3D=3D
[842/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_reps.c.o

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515617430.EAeDd8a4.1302848
Date: Thu, 3 Jul 2025 18:55:43 +0200
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
   title=3D"UNCONFIRMED - net/bnxt: duplicate code in branches"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1740">1740</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/bnxt: duplicate code in branches
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
          <td>minor
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
          <pre class=3D"bz_comment_text">Building with compiler warning abo=
ut duplicate branches finds:

[834/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_flow.c.o
../drivers/net/bnxt/bnxt_flow.c: In function
=E2=80=98bnxt_validate_and_parse_flow_type=E2=80=99:
../drivers/net/bnxt/bnxt_flow.c:263:80: warning: this condition has identic=
al
branches [-Wduplicated-branches]
  263 |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_MACADDR :
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
       ^
../drivers/net/bnxt/bnxt_flow.c:383:79: warning: this condition has identic=
al
branches [-Wduplicated-branches]
  383 |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
HWRM_CFA_NTUPLE_FILTER_ALLOC_INPUT_IP_ADDR_TYPE_IPV4 :
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
      ^
../drivers/net/bnxt/bnxt_flow.c:448:75: warning: this condition has identic=
al
branches [-Wduplicated-branches]
  448 |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
NTUPLE_FLTR_ALLOC_INPUT_IP_ADDR_TYPE_IPV6 :
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  ^
[835/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_stats.c.o
[836/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_rxq.c.o
[837/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_txq.c.o
[838/3631] Compiling C object
drivers/libtmp_rte_net_bnx2x.a.p/net_bnx2x_bnx2x_stats.c.o
[839/3631] Compiling C object
drivers/libtmp_rte_net_bnx2x.a.p/net_bnx2x_ecore_sp.c.o
[840/3631] Compiling C object
drivers/libtmp_rte_common_qat.a.p/crypto_qat_qat_asym.c.o
[841/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_txr.c.o
../drivers/net/bnxt/bnxt_txr.c: In function =E2=80=98bnxt_start_xmit=E2=80=
=99:
../drivers/net/bnxt/bnxt_txr.c:410:74: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  410 |                 } else if ((tx_pkt-&gt;ol_flags &amp;
PKT_TX_OIP_IIP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:402:78: note: previously used here
  402 |                 } else if ((tx_pkt-&gt;ol_flags &amp;
PKT_TX_OIP_IIP_TCP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:418:70: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  418 |                 } else if ((tx_pkt-&gt;ol_flags &amp; PKT_TX_IIP_UD=
P_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:414:74: note: previously used here
  414 |                 } else if ((tx_pkt-&gt;ol_flags &amp;
PKT_TX_IIP_TCP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:430:70: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  430 |                 } else if ((tx_pkt-&gt;ol_flags &amp; PKT_TX_OIP_UD=
P_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:426:74: note: previously used here
  426 |                 } else if ((tx_pkt-&gt;ol_flags &amp;
PKT_TX_OIP_TCP_UDP_CKSUM) =3D=3D
../drivers/net/bnxt/bnxt_txr.c:450:73: warning: duplicated =E2=80=98if=E2=
=80=99 condition
[-Wduplicated-cond]
  450 |                 } else if ((tx_pkt-&gt;ol_flags &amp; RTE_MBUF_F_TX=
_UDP_CKSUM)
=3D=3D
../drivers/net/bnxt/bnxt_txr.c:442:70: note: previously used here
  442 |                 } else if ((tx_pkt-&gt;ol_flags &amp; PKT_TX_TCP_UD=
P_CKSUM) =3D=3D
[842/3631] Compiling C object
drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_reps.c.o
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
?id=3D1740">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515617430.EAeDd8a4.1302848--

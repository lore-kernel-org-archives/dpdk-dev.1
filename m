Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19763CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 03:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5BA840292;
	Thu, 21 Aug 2025 05:11:39 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CE7A94026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 05:11:37 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A571646D80; Thu, 21 Aug 2025 05:11:37 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1779] Packet segments do not get freed in
 mprq_buf_to_pkt() upon encountering MLX5_RXQ_CODE_NOMBUF
Date: Thu, 21 Aug 2025 03:11:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: canary.overflow@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1779-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17557458970.c3DfF50.1832711
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


--17557458970.c3DfF50.1832711
Date: Thu, 21 Aug 2025 05:11:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1779

            Bug ID: 1779
           Summary: Packet segments do not get freed in mprq_buf_to_pkt()
                    upon encountering MLX5_RXQ_CODE_NOMBUF
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: canary.overflow@gmail.com
  Target Milestone: ---

drivers/net/mlx5/mlx5_rx.h mprq_buf_to_pkt(...):

There are 2 issues:=20

- uint32_t seg_len =3D RTE_MIN(len, (uint32_t)(pkt->buf_len -
RTE_PKTMBUF_HEADROOM)) seems unnecessary as to hit this code, len has to be
greater than (uint32_t)(pkt->buf_len - RTE_PKTMBUF_HEADROOM) due to the if
condition

- If the allocation struct rte_mbuf *next =3D rte_pktmbuf_alloc(rxq->mp) fa=
ils
and packet has more than 2 segs, the segs that were allocated previously do=
 not
get freed=20

    mprq_buf_to_pkt(...) {
        ...=20=20=20=20=20=20=20=20
        } else if (rxq->strd_scatter_en) {
            struct rte_mbuf *prev =3D pkt;
            uint32_t seg_len =3D RTE_MIN(len, (uint32_t)
            (pkt->buf_len - RTE_PKTMBUF_HEADROOM));
            uint32_t rem_len =3D len - seg_len;

            rte_memcpy(rte_pktmbuf_mtod(pkt, void *), addr, seg_len);
            DATA_LEN(pkt) =3D seg_len;
            while (rem_len) {
                struct rte_mbuf *next =3D rte_pktmbuf_alloc(rxq->mp);

                if (unlikely(next =3D=3D NULL))
                    return MLX5_RXQ_CODE_NOMBUF;
                ...
            }
            ...
        }
        ...
    }

Should rte_pktmbuf_free() be used instead?

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17557458970.c3DfF50.1832711
Date: Thu, 21 Aug 2025 05:11:37 +0200
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
   title=3D"UNCONFIRMED - Packet segments do not get freed in mprq_buf_to_p=
kt() upon encountering MLX5_RXQ_CODE_NOMBUF"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1779">1779</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Packet segments do not get freed in mprq_buf_to_pkt() upon en=
countering MLX5_RXQ_CODE_NOMBUF
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>22.11
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
          <td>canary.overflow&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">drivers/net/mlx5/mlx5_rx.h mprq_bu=
f_to_pkt(...):

There are 2 issues:=20

- uint32_t seg_len =3D RTE_MIN(len, (uint32_t)(pkt-&gt;buf_len -
RTE_PKTMBUF_HEADROOM)) seems unnecessary as to hit this code, len has to be
greater than (uint32_t)(pkt-&gt;buf_len - RTE_PKTMBUF_HEADROOM) due to the =
if
condition

- If the allocation struct rte_mbuf *next =3D rte_pktmbuf_alloc(rxq-&gt;mp)=
 fails
and packet has more than 2 segs, the segs that were allocated previously do=
 not
get freed=20

    mprq_buf_to_pkt(...) {
        ...=20=20=20=20=20=20=20=20
        } else if (rxq-&gt;strd_scatter_en) {
            struct rte_mbuf *prev =3D pkt;
            uint32_t seg_len =3D RTE_MIN(len, (uint32_t)
            (pkt-&gt;buf_len - RTE_PKTMBUF_HEADROOM));
            uint32_t rem_len =3D len - seg_len;

            rte_memcpy(rte_pktmbuf_mtod(pkt, void *), addr, seg_len);
            DATA_LEN(pkt) =3D seg_len;
            while (rem_len) {
                struct rte_mbuf *next =3D rte_pktmbuf_alloc(rxq-&gt;mp);

                if (unlikely(next =3D=3D NULL))
                    return MLX5_RXQ_CODE_NOMBUF;
                ...
            }
            ...
        }
        ...
    }

Should rte_pktmbuf_free() be used instead?
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
?id=3D1779">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17557458970.c3DfF50.1832711--

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F76CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 02:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25EB240292;
	Thu, 21 Aug 2025 04:31:47 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1AECA4026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 04:31:46 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EF36546D80; Thu, 21 Aug 2025 04:31:45 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1776] Segmentation fault encountered in MPRQ
 vectorized mode
Date: Thu, 21 Aug 2025 02:31:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
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
Message-ID: <bug-1776-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17557435050.4b746179.1811489
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


--17557435050.4b746179.1811489
Date: Thu, 21 Aug 2025 04:31:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1776

            Bug ID: 1776
           Summary: Segmentation fault encountered in MPRQ vectorized mode
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: canary.overflow@gmail.com
  Target Milestone: ---

I have been encountering segmentation fault when running DPDK in MPRQ
vectorized mode. To reproduce the issue on testpmd, run with the following
parameters:

dpdk-testpmd -l 1-5 -n 4 -a
0000:1f:00.0,rxq_comp_en=3D1,rxq_pkt_pad_en=3D1,rxqs_min_mprq=3D1,mprq_en=
=3D1,mprq_log_stride_num=3D6,mprq_log_stride_size=3D9,mprq_max_memcpy_len=
=3D64,rx_vec_en=3D1
-- -i --rxd=3D8192 --max-pkt-len=3D9000 --rxq=3D1 --total-num-mbufs=3D16384
--mbuf-size=3D3000 --enable-drop-en =E2=80=93-enable-scatter

This segmentation fault goes away when I disable vectorization (rx_vec_en=
=3D0).
(Note that the segmentation fault does not occur in forward-mode=3Drxonly).=
 The
segmentation fault also seems to happen with higher chances when there is a
rxnombuf.

The backtrace of the segmentation fault was:
#0  0x0000000001c34912 in __rte_pktmbuf_free_extbuf ()
#1  0x0000000001c36a10 in rte_pktmbuf_detach ()
#2  0x0000000001c4a9ec in rxq_copy_mprq_mbuf_v ()
#3  0x0000000001c4d63b in rxq_burst_mprq_v ()
#4  0x0000000001c4d7a7 in mlx5_rx_burst_mprq_vec ()
#5  0x000000000050be66 in rte_eth_rx_burst ()
#6  0x000000000050c53d in pkt_burst_io_forward ()
#7  0x00000000005427b4 in run_pkt_fwd_on_lcore ()
#8  0x000000000054289b in start_pkt_forward_on_core ()
#9  0x0000000000a473c9 in eal_thread_loop ()
#10 0x00007ffff60061ca in start_thread () from /lib64/libpthread.so.0
#11 0x00007ffff5c72e73 in clone () from /lib64/libc.so.6

*Note that the addresses may not be exact as I've added some log statements=
 and
attempted fixes previously (they were commented out when I obtained this
backtrace).

Upon some investigation, I noticed that in DPDK=E2=80=99s source codes
drivers/net/mlx5/mlx5_rxtx_vec.c (function rxq_copy_mprq_mbuf_v()), there i=
s a
possibility where the consumed stride exceeds the stride number (64 in this
case) which should not be happening. I'm suspecting that there's some CQE
misalignment here upon encountering rxnombuf.

rxq_copy_mprq_mbuf_v(...) {
    ...
    if(rxq->consumed_strd =3D=3D strd_n) {=20=20=20
        // replenish WQE
    }
    ...
    strd_cnt =3D (elts[i]->pkt_len / strd_sz) +=20
               ((elts[i]->pkt_len % strd_sz) ? 1 : 0);

    rxq_code =3D mprq_buf_to_pkt(rxq, elts[i], elts[i]->pkt_len, buf,
rxq->consumed_strd, strd_cnt);
    rxq->consumed_strd +=3D strd_cnt;       // encountering cases where
rxq->consumed_strd > strd_n
    ...
}

In addition, there were also cases in mprq_buf_to_pkt() where the allocated=
 seg
address is exactly the same as the pkt (elts[i]) address passed in which sh=
ould
not happen.

mprq_buf_to_pkt(...) {
    ...
    if(hdrm_overlap > 0) {=20=20=20
        MLX5_ASSERT(rxq->strd_scatter_en);
        struct rte_mbuf *seg =3D rte_pktmbuf_alloc(rxq->mp);
        if (unlikely(seg =3D=3D NULL)) return MLX5_RXQ_CODE_NOMBUF;
        SET_DATA_OFF(seg, 0);

        // added debug statement
        // saw instances where pkt =3D seg
        DRV_LOG(DEBUG, "pkt %p seg %p", (void *)pkt, (void *)seg);
        rte_memcpy(rte_pktmbuf_mtod(seg, void *), RTE_PTR_ADD(addr, len -
hdrm_overlap), hdrm_overlap);
        ...
    }
}

I have tried upgrading my DPDK version to 24.11 but the segmentation fault
still persists.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17557435050.4b746179.1811489
Date: Thu, 21 Aug 2025 04:31:45 +0200
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
   title=3D"UNCONFIRMED - Segmentation fault encountered in MPRQ vectorized=
 mode"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1776">1776</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Segmentation fault encountered in MPRQ vectorized mode
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
          <pre class=3D"bz_comment_text">I have been encountering segmentat=
ion fault when running DPDK in MPRQ
vectorized mode. To reproduce the issue on testpmd, run with the following
parameters:

dpdk-testpmd -l 1-5 -n 4 -a
0000:1f:00.0,rxq_comp_en=3D1,rxq_pkt_pad_en=3D1,rxqs_min_mprq=3D1,mprq_en=
=3D1,mprq_log_stride_num=3D6,mprq_log_stride_size=3D9,mprq_max_memcpy_len=
=3D64,rx_vec_en=3D1
-- -i --rxd=3D8192 --max-pkt-len=3D9000 --rxq=3D1 --total-num-mbufs=3D16384
--mbuf-size=3D3000 --enable-drop-en =E2=80=93-enable-scatter

This segmentation fault goes away when I disable vectorization (rx_vec_en=
=3D0).
(Note that the segmentation fault does not occur in forward-mode=3Drxonly).=
 The
segmentation fault also seems to happen with higher chances when there is a
rxnombuf.

The backtrace of the segmentation fault was:
#0  0x0000000001c34912 in __rte_pktmbuf_free_extbuf ()
#1  0x0000000001c36a10 in rte_pktmbuf_detach ()
#2  0x0000000001c4a9ec in rxq_copy_mprq_mbuf_v ()
#3  0x0000000001c4d63b in rxq_burst_mprq_v ()
#4  0x0000000001c4d7a7 in mlx5_rx_burst_mprq_vec ()
#5  0x000000000050be66 in rte_eth_rx_burst ()
#6  0x000000000050c53d in pkt_burst_io_forward ()
#7  0x00000000005427b4 in run_pkt_fwd_on_lcore ()
#8  0x000000000054289b in start_pkt_forward_on_core ()
#9  0x0000000000a473c9 in eal_thread_loop ()
#10 0x00007ffff60061ca in start_thread () from /lib64/libpthread.so.0
#11 0x00007ffff5c72e73 in clone () from /lib64/libc.so.6

*Note that the addresses may not be exact as I've added some log statements=
 and
attempted fixes previously (they were commented out when I obtained this
backtrace).

Upon some investigation, I noticed that in DPDK=E2=80=99s source codes
drivers/net/mlx5/mlx5_rxtx_vec.c (function rxq_copy_mprq_mbuf_v()), there i=
s a
possibility where the consumed stride exceeds the stride number (64 in this
case) which should not be happening. I'm suspecting that there's some CQE
misalignment here upon encountering rxnombuf.

rxq_copy_mprq_mbuf_v(...) {
    ...
    if(rxq-&gt;consumed_strd =3D=3D strd_n) {=20=20=20
        // replenish WQE
    }
    ...
    strd_cnt =3D (elts[i]-&gt;pkt_len / strd_sz) +=20
               ((elts[i]-&gt;pkt_len % strd_sz) ? 1 : 0);

    rxq_code =3D mprq_buf_to_pkt(rxq, elts[i], elts[i]-&gt;pkt_len, buf,
rxq-&gt;consumed_strd, strd_cnt);
    rxq-&gt;consumed_strd +=3D strd_cnt;       // encountering cases where
rxq-&gt;consumed_strd &gt; strd_n
    ...
}

In addition, there were also cases in mprq_buf_to_pkt() where the allocated=
 seg
address is exactly the same as the pkt (elts[i]) address passed in which sh=
ould
not happen.

mprq_buf_to_pkt(...) {
    ...
    if(hdrm_overlap &gt; 0) {=20=20=20
        MLX5_ASSERT(rxq-&gt;strd_scatter_en);
        struct rte_mbuf *seg =3D rte_pktmbuf_alloc(rxq-&gt;mp);
        if (unlikely(seg =3D=3D NULL)) return MLX5_RXQ_CODE_NOMBUF;
        SET_DATA_OFF(seg, 0);

        // added debug statement
        // saw instances where pkt =3D seg
        DRV_LOG(DEBUG, &quot;pkt %p seg %p&quot;, (void *)pkt, (void *)seg);
        rte_memcpy(rte_pktmbuf_mtod(seg, void *), RTE_PTR_ADD(addr, len -
hdrm_overlap), hdrm_overlap);
        ...
    }
}

I have tried upgrading my DPDK version to 24.11 but the segmentation fault
still persists.
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
?id=3D1776">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17557435050.4b746179.1811489--

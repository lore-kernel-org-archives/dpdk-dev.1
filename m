Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11FEFDEE48
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB76A40272;
	Thu, 23 Apr 2026 21:24:05 +0200 (CEST)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45]) by mails.dpdk.org (Postfix) with ESMTP id 2DD2540270
 for <dev@dpdk.org>; Thu, 23 Apr 2026 21:24:04 +0200 (CEST)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6948ed7139eso2167504eaf.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776972243;
 x=1777577043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5FHViG8lPuiAJTKAq/dzBQnM4Nv3auSWAcnUuD9CnI=;
 b=PPE0D+r0RipfvDWH0DEUAhCM1SZWcQWJOcFxULLjs56zbjRHgdcpC5K7D4qoryZj0J
 ZQIIoltFPoz4ptPcD55SAOSn5Lw18nxrkJ0FqB2qLytvQmoggA7eC9KkEnX4m7+ZcFPj
 YNF306crE1SS1qNmHZBGP8MSoxG569hnz88UkplI9z6gX9sbjGmwsO0WasXGBebKoOC7
 C35PjfwQaE32SJFtKv03h1ZjUhocsWHnsAz5F7vZw1vk9m/tJdtweDrkPs+d6dGWDXBv
 2v2CyQqahD/YaK51BEu/l7j9f5XDXyhYPiBM6rUyxHxNJ/ib/Udd1fzehJ3fG5DhU/Dz
 i7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776972243; x=1777577043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5FHViG8lPuiAJTKAq/dzBQnM4Nv3auSWAcnUuD9CnI=;
 b=MIhtE8cb42CLjfQpIFw3jk9FfVxxU+avicFm9EHRJjvXZnmzoz75m7AN3a1d8gupnV
 4Ju/66H6QgT8L9jqz8I39lj9vfxZkENd8EMACZx+t6kxoXMZlGo28De0EXZLF2eEb2HM
 HSBgUCO293rFj6PMe6QWH3V8d/wZxef6IToC47hacuWVDzfdXiE9w1Yvb09dgGE9xV7k
 IJy0dhISU/qA+eAEfdw3kX1d2G8CJGQoyTJ+Jorfd5DoTUxx0qFwZCGw5tXcRe0e+SbE
 KCHybcYBOTml6XHc6WNU1c5WcAJrgW8JdkIUyMsR5IzDPCpq/hg/adTtYe9yReYPNYKi
 0GaA==
X-Gm-Message-State: AOJu0Yxm2p2a2Im77g9na+syXsFO9NMZ5akGjsT1tBiyLhvTErHfflme
 rYUrjOK0BWpXuuvJAuZ4edhZxm3psNh/DnVK9Y/JPeKizAzEMR32QoSn1Chfm1HQozKKBscWjwi
 EzmJF
X-Gm-Gg: AeBDiet7vO2cZM2t+sF3xrywuYNmO0xYxmS8A9cdkqfMpAgduRGIU3dmg2966Z//Lh+
 HDvlYmL4EMSBEAmwZdnOU4PKsAlHXXDuqGXAc7tC+dN4Bg4VX6f0KRufSJ/Hs/PwZKiH7GRXCIr
 dQLfNqkU6keJbErgGmT1kOMrRIzXUXMH2HsbSsr5ZsCQiwAnhg/DiRUhG5uae+7+HOEIXj2q12X
 AjtH9JZg+qo4rpS8tJ+dc1wL/tIo4/BHjASNgc2zanYAiHiUj7i+0lJSxjN46YQSr3aXoH3XlbP
 /xFvoeW7nsEgpq4dTsLcMyEDt7k9Xu0Fi8+p/uljt0Lgx9czlVWTJxLP7ZCquPr6BwxgQputsqL
 Yfs1Xq4Tb7wxlfea/iyuumBWhAAJF61zMoU40PUNvBd/PxaEDjFLclSe0VJDnSLMBWc2trfHYBa
 2bCR1zVASsys0bx4zZisZXEyOiMrlGq9tUcQrCq/KsMbqifA==
X-Received: by 2002:a05:6820:2d04:b0:694:8cb0:4efe with SMTP id
 006d021491bc7-6948cb0515emr10522228eaf.17.1776972243131; 
 Thu, 23 Apr 2026 12:24:03 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696148cd37dsm2464525eaf.8.2026.04.23.12.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:24:02 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:23:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/3] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260423122357.3a91bccf@phoenix.local>
In-Reply-To: <20260423011820.2426203-1-wang.junlong1@zte.com.cn>
References: <20260326022828.998541-1-wang.junlong1@zte.com.cn>
 <20260423011820.2426203-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 23 Apr 2026 09:18:15 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v2:
>   - zxdh_rxtx.c, pkt_padding(): modifyed the return value of pkt_padding(=
);
>   - zxdh_rxtx.c, zxdh_recv_single_pkts(): modifyed When zxdh_init_mbuf() =
fails
>     the loop does "continue" and free mbufs;
>   - zxdh_rxtx.c, refill_desc_unwrap(): Add rte_io_wmb() before writing fl=
ags
>     in the refill_que_descs();
>   - zxdh_queue.h, zxdh_queue_enable_intr(): Remove unnecessary function o=
f zxdh_queue_enable_intr;
>   - zxdh_ethdev.c, zxdh_init_queue(): changed the hdr_mz NULL check logic;
>=20
>   - zxdh_rxtx.c, zxdh_xmit_pkts_simple()=E3=80=81zxdh_recv_single_pkts():=
 add stats.bytes count;
>   - zxdh_rxtx.c, zxdh_init_mbuf():remove  rte_pktmbuf_dump(stdout, rxm, 4=
0);
>   - zxdh_ethdev.c, zxdh_dev_free_mbufs(): using rte_pktmbuf_free() to fre=
e mbufs;
>   - Splitting into separate patches, structure reorganization and sw_ring=
 removal=E3=80=81
>     RX recv optimize=E3=80=81Tx xmit optimize=E3=80=81Tx;
>=20
> v1:
>   This patch optimizes the ZXDH PMD's receive and transmit path for better
>   performance through several improvements:
>=20
> - Add simple TX/RX burst functions (zxdh_xmit_pkts_simple and
>   zxdh_recv_single_pkts) for single-segment packet scenarios.
> - Remove RX software ring (sw_ring) to reduce memory allocation and
>   copy.
> - Optimize descriptor management with prefetching and simplified
>   cleanup.
> - Reorganize structure fields for better cache locality.
>=20
>   These changes reduce CPU cycles and memory bandwidth consumption,
>   resulting in improved packet processing throughput.
>=20
> Junlong Wang (3):
>   net/zxdh: optimize queue structure to improve performance
>   net/zxdh: optimize Rx recv pkts performance
>   net/zxdh: optimize Tx xmit pkts performance
>=20
>  drivers/net/zxdh/zxdh_ethdev.c     |  88 ++---
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  24 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   4 +
>  drivers/net/zxdh/zxdh_pci.c        |   2 +-
>  drivers/net/zxdh/zxdh_queue.c      |  31 +-
>  drivers/net/zxdh/zxdh_queue.h      | 125 +++----
>  drivers/net/zxdh/zxdh_rxtx.c       | 520 +++++++++++++++++++++--------
>  drivers/net/zxdh/zxdh_rxtx.h       |  27 +-
>  8 files changed, 527 insertions(+), 294 deletions(-)
>=20

Here is the full AI review of this patchset
```
Review of v2 series: net/zxdh queue/Rx/Tx optimization

Overall: needs a v3. Findings below, organized by patch.


Patch 1/3 (optimize queue structure)
------------------------------------

Warning: zxdh_queue_notify() in zxdh_queue.h now hardcodes the bit-31
avail-wrap into notify_data unconditionally, removing the
zxdh_pci_with_feature(hw, ZXDH_F_RING_PACKED) gate that the previous
out-of-line version in zxdh_pci.c had.  The series also adds a
vq_split member to the virtqueue union, which suggests split-ring
support is planned.  Once that exists, this helper will corrupt notify
data for split rings.  Either reinstate the feature gate or keep the
dispatch going through VTPCI_OPS()->notify_queue().

Warning: rx_queue_intr_enable/rx_queue_intr_disable dev_ops and the
zxdh_queue_enable_intr() helper are removed.  The commit log talks
about cache locality and sw_ring removal but not this.  Please split
it into its own patch with a justification, or at minimum call it out
in the commit message.

Minor: fail_q_alloc now does "if (hdr_mz) rte_memzone_free(hdr_mz);".
rte_memzone_free() accepts NULL; the guard is unnecessary.

Minor: The new "if (hdr_mz =3D=3D NULL)" check inside the VTNET_TQ branch
of zxdh_init_queue() is unreachable.  hdr_mz was already validated
earlier in the function.

Minor: Doxygen close "**/" used in several places where "*/" is the
correct terminator.


Patch 2/3 (optimize Rx recv pkts performance)
---------------------------------------------

Error: Double-free in zxdh_recv_single_pkts().  Both error paths
inside zxdh_init_mbuf() already call rte_pktmbuf_free(rxm), but the
caller also frees rxm on return < 0:

        if (unlikely(zxdh_init_mbuf(rxm, len, hw, &vq->rxq) < 0)) {
                rte_pktmbuf_free(rxm);   /* already freed inside */
                continue;
        }

Drop either the caller's free or the callees' frees, not both.

Warning: zxdh_set_rxtx_funcs() silently drops the
ZXDH_NET_F_MRG_RXBUF negotiation check.  The previous version
returned -1 if MRG_RXBUF was not advertised; the new version selects a
burst function unconditionally.  The multi-seg path
zxdh_recv_pkts_packed() reads header->type_hdr.num_buffers, which is
only meaningful when MRG_RXBUF is negotiated with the peer.

Warning: xstats "full", "norefill", "multicast_packets",
"broadcast_packets" (rx) and "norefill", "multicast_packets",
"broadcast_packets" (tx) are removed from the name tables.  If these
counters were never being updated, say so in the commit log.  If they
were, multicast_packets/broadcast_packets in particular are
operator-facing counters and this is a user-visible regression.

Warning: zxdh_scattered_rx() reads eth_dev->data->min_rx_buf_size,
which is populated during rx_queue_setup().  Depending on when
zxdh_set_rxtx_funcs() runs, "min_rx_buf_size - RTE_PKTMBUF_HEADROOM"
can underflow (uint16_t wraps) if min_rx_buf_size is 0 at that point.

Minor: Open-coded rte_pktmbuf_mtod().  Both the new zxdh_init_mbuf()
and the modified zxdh_recv_pkts_packed() use

        (char *)rxm->buf_addr + RTE_PKTMBUF_HEADROOM

where rte_pktmbuf_mtod(rxm, struct zxdh_net_hdr_ul *) expresses the
same intent.  data_off equals RTE_PKTMBUF_HEADROOM here because the
refill path aligns the hardware write target to
buf_iova + RTE_PKTMBUF_HEADROOM.

Minor: zxdh_init_mbuf() zeroes rxm->ol_flags, rxm->vlan_tci, and
rxm->vlan_tci_outer.  All three are already cleared by
rte_pktmbuf_reset() on alloc from the pool.

Minor: rxq_get_vq(q) is a trivial one-line macro aliasing "q->vq"
with no functional benefit.  Either drop it or apply it consistently.


Patch 3/3 (optimize Tx xmit pkts performance)
---------------------------------------------

Error: zxdh_xmit_pkts_simple() does not write txdp->id.  tx_bunch()
and tx1() write addr, len, and flags but leave id untouched.  The new
zxdh_xmit_fast_flush() reads "id =3D desc[used_idx].id" as the
chain-terminator for its inner do-while loop
("while (curr_id !=3D id)").

Descriptors submitted by the simple path therefore carry stale ids:
either 0 at cold start from memzone init, or the self-index written
by a previous flush pass.  Because the flush rewrites
desc[used_idx].id =3D used_idx during processing, after one full warmup
cycle every desc[i].id =3D=3D i and the inner do-while happens to exit
after one iteration.  But on a cold ring, or any ring whose
descriptors were left with non-self ids by a preceding append-path
burst, the inner loop keeps iterating, freeing cookies and advancing
used_idx across descriptors the backend has not marked used, until
used_idx wraps back to 0.  That corrupts vq_free_cnt and
vq_used_cons_idx accounting.

Fix: set txdp->id =3D avail_idx + i in tx_bunch/tx1 so the invariant is
explicit rather than relying on the flush's self-rewrite side effect.

Warning: zxdh_xmit_pkts_prepare() drops the
rte_net_intel_cksum_prepare() call.  If the driver still advertises
L4 checksum offload, pseudo-header checksum preparation becomes the
application's responsibility.  That's a user-visible contract change
and needs justification in the commit log, or should be paired with a
matching capability change.

Warning: zxdh_xmit_enqueue_append() now sets dxp->cookie =3D NULL for
the head slot and stores cookies per descriptor via dep[idx].cookie.
This works with the new per-descriptor free in
zxdh_xmit_fast_flush() (rte_pktmbuf_free_seg), but any residual code
path still reading vq_descx[head_id].cookie will see NULL.  Worth a
comment documenting the new invariant.

Minor: Extra initialization.  In pkt_padding(),

        struct zxdh_net_hdr_dl *hdr =3D NULL;

is immediately overwritten by the rte_pktmbuf_prepend() return.  In
submit_to_backend_simple(),

        struct rte_mbuf *m =3D NULL;

is overwritten on first use inside the loop.  Drop both initializers.

Minor: "mainpart =3D (nb_pkts & ((uint32_t)~N_PER_LOOP_MASK));" =E2=80=94 t=
he
uint32_t cast is pointless.  nb_pkts is uint16_t and N_PER_LOOP_MASK
is a small integer constant.

Minor: submit_to_backend_simple() uses "*(tx_pkts + i + j)" where
"tx_pkts[i + j]" reads more naturally and matches style elsewhere.

Minor: tx_bunch() is named to imply a variable batch but is hardcoded
to N_PER_LOOP iterations for single-segment packets only.  A one-line
comment noting that the simple path handles single-segment only
(selected when TX_OFFLOAD_MULTI_SEGS is off) would help.
```

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D8C531C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 16:39:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6099340269;
	Sun, 26 Jul 2026 18:39:50 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id F294140150
 for <dev@dpdk.org>; Sun, 26 Jul 2026 18:39:40 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so1458620b3a.2
 for <dev@dpdk.org>; Sun, 26 Jul 2026 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785083980;
 x=1785688780; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bqZKdrmPVfoRRyBhoqjq4IXiVcnnpKSNWnf4ygz8npc=;
 b=TN47bNx4Z6hwnAFnSVpr1R1up7YMqVKoGXY+hlNnHZuQrGn2q6UV7qPAi6UkPmYVja
 aklGK9zYODLb6TO9kkQ9jSZSo+G6Vj6eL77kpenoOyxzwnT1PL+fzlCrPkfBpm9WmdLY
 Y72S2ukLuAeUIMfuDiDF323hY326E2vKKQ9QjGLaQ7rkwtsKxejNYZ+zaQa7YlBDcL99
 X4l6HPQjapCOCj17TDrU5aaYyvmf+HdYFMfuhMsKbiCCST4Bul0hlkNjQGN2HB1ski34
 11WfHnqk3Ng8/1/aGmMhFO9gwapLhdEHIjh3C2FNS9aKnr4BY9VpWRdRQHoYyMR4oeKl
 6hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785083980; x=1785688780;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bqZKdrmPVfoRRyBhoqjq4IXiVcnnpKSNWnf4ygz8npc=;
 b=XgrY2303Jax7jLdNFZXiU5KfFNntbB+NcyaGpP7iRzp7cTLUXpgC2OjZ//n/vqGDMv
 Yi/l6ZY8u05Sb00nHLJWXuV8kOzzv+U7nzEIjy0eILruIPvTSr9929NGUw0PdDPD3kAy
 4MGhUkqh/1K34F0WIOaZjRjfVGDbiq0vw/Ye9/t7b9/c54W2hu2ElQoaRZjvvy4p6bX1
 jS3zifxh05/MGDr4yd7WZb9zFk4yX7LOeSN5A0br/C6lG+o+0spw9QO8TYT5zZZOneY5
 RUO6TnXTr7q/LwFAkEW4jcMV/yTb+pQRexRy7e4FCJu761Xv9EohDuR1pWFjTY8IjbOy
 tRdA==
X-Gm-Message-State: AOJu0YyXUUWsCyimo+kN6utLzfLZggQyXObx5C3yip7NLpRLCh3givzM
 /D8moUqf0opRLsjGyS76Wc8CDFRCIVKVjZBoY99dHlrVNFuDm1x/xInJd7AR7G0jR1I=
X-Gm-Gg: AR+sD139qM50zYpbxtFAFkupkkAnnIcQyXy2BCeQRoZUmW0sH3rnnk/ProLSSZ94ZRp
 AMgQXZCxjhWvdvMbh56a9cnfFm2X0l318ps7kcWFWcEWTj3LN9HnMpF+jMGe7+/MiLeLcoOlnCN
 +2ddeBJtRNagtBPbgtlEwThmHhjYXlUcyWRvzfYkbhNz3CGkXCJ1L2zi9aKXbOCy2Lb8JYCF1D4
 z8um8H1OqtRRKztmYff+AVpv9Esue7hvF5PoKldECj8YVg/qd4BReWWkCBmd+fF/e0aGiy9ny7A
 YSKfMBK/c3AIRkp44VT5AkfWH8k0+b509NOenF6RAwqo2aYNf3BHW5PYJ6EOdaUnGDnhwUH91tN
 D3s9QpJrkVUX9i8IMikwpCf4uFH5fpuMaev8XhzbXPmBefSQdf/w3AbTMSiO9u2kTEl81gHD51/
 yYmWa2R0GN5PQMNmCvpu4HrLMnagD/7Ps0cfM5amMt20s=
X-Received: by 2002:a05:6a21:790:b0:3bf:6c08:2b27 with SMTP id
 adf61e73a8af0-3c67df10ceemr5173141637.47.1785083979774; 
 Sun, 26 Jul 2026 09:39:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130a8421sm42091762c88.10.2026.07.26.09.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 09:39:39 -0700 (PDT)
Date: Sun, 26 Jul 2026 09:39:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260726093937.58066d50@phoenix.local>
In-Reply-To: <20260709104637.924861-1-wang.junlong1@zte.com.cn>
References: <20260625120317.211780-1-wang.junlong1@zte.com.cn>
 <20260709104637.924861-1-wang.junlong1@zte.com.cn>
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

On Thu,  9 Jul 2026 18:46:32 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v9:
>   - Remove add simple Tx xmit functions (zxdh_xmit_pkts_simple) in the la=
st patch.
>=20
> v8:
>   - Add checked the size of ZXDH_DL_NET_HDR_SIZE and RTE_PKTMBUF_HEADROOM=
 in
>     zxdh_xmit_pkts_simple() before submitting. Add static_assert to rejec=
t builds with insufficient
>     default headroom at compile time.
>=20
> v7:
>   - Add a new xmit prepare func for xmit_pkts_simple, which will checked =
the size of
>     ZXDH_DL_NET_HDR_SIZE and RTE_PKTMBUF_HEADROOM.
>=20
> v6:
>   - Remove unnecessary error checking code in submit_to_backend_simple() =
and
>     pkt_padding(). Since as the max dl_net_hdr_len is always less than
>     RTE_PKTMBUF_HEADROOM, rte_pktmbuf_prepend() cannot fail in the
>     simple path (single-segment mbufs).
> v5:
>   - Reorganize patch series, placing interrupt fix as the first patch
>     and fix condition check to properly enable interrupts.
>   - Fix zxdh_recv_single_pkts() not compacting rcv_pkts[] on failure,
>     which could cause use-after-free and mbuf leak.
>   - Fix tx_bunch() and tx1() missing store barrier before setting AVAIL f=
lag,
>     preventing data race on weakly-ordered architectures.
>   - Fix submit_to_backend_simple() writing descriptors for packets that
>     failed pkt_padding(), causing mbuf leak.
> v4:
>   - fix some AI review issues.
>   - fix queue enable intr bug.
> v3:
>   - remove unnecessary NULL check in zxdh_init_queue.
>   - Split Ring: Bit[31] is unused and reserved, zxdh_queue_notify(): remo=
ving the
>     zxdh_pci_with_feature(hw, ZXDH_F_RING_PACKED) check;
>   - remove unnecessary double-free in in zxdh_recv_single_pkts();
>   - used rte_pktmbuf_mtod();
>   - remove rxq_get_vq(q) macro, use q->vq and apply it consistently;
>   - Refactoring scatter and mtu check logic in zxdh_dev_mtu_set();
>   - set txdp->id =3D avail_idx + i in tx_bunch/tx1.
>   - add comment documenting zxdh_xmit_enqueue_append() now sets dxp->cook=
ie =3D NULL for
>     the head slot and stores cookies per descriptor via dep[idx].cookie.
>   - add one-line comment noting tx_bunch() is the simple path handles sin=
gle-segment.
>   - remove unnecessary Extra initialization and the uint32_t cast.
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
>   - zxdh_rxtx.c, zxdh_xmit_pkts_simple()=E3=80=81zxdh_recv_single_pkts():=
 add stats.bytes count;
>   - zxdh_rxtx.c, zxdh_init_mbuf():remove  rte_pktmbuf_dump(stdout, rxm, 4=
0);
>   - zxdh_ethdev.c, zxdh_dev_free_mbufs(): using rte_pktmbuf_free() to fre=
e mbufs;
>   - Splitting into separate patches, structure reorganization and sw_ring=
 removal=E3=80=81
>     RX recv optimize=E3=80=81Tx xmit optimize=E3=80=81Tx;
> v1:
>   This patch optimizes the ZXDH PMD's receive and transmit path for better
>   performance through several improvements:
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
> Junlong Wang (4):
>   net/zxdh: fix queue enable intr issues
>   net/zxdh: optimize queue structure to improve performance
>   net/zxdh: optimize Rx recv pkts performance
>   net/zxdh: optimize Tx xmit pkts performance
>=20
>  drivers/net/zxdh/zxdh_ethdev.c     |  76 ++++---
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  23 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   4 +
>  drivers/net/zxdh/zxdh_pci.c        |   2 +-
>  drivers/net/zxdh/zxdh_queue.c      |  11 +-
>  drivers/net/zxdh/zxdh_queue.h      | 122 ++++++-----
>  drivers/net/zxdh/zxdh_rxtx.c       | 324 ++++++++++++++++++-----------
>  drivers/net/zxdh/zxdh_rxtx.h       |  27 +--
>  8 files changed, 329 insertions(+), 260 deletions(-)
>=20

There are some findings in AI review that need addressing.
Thee overly wordy AI review is :



Patch 2/4: net/zxdh: optimize queue structure to improve performance

Error: zxdh_queue_notify() drops the ZXDH_F_NOTIFICATION_DATA gate, not
just the packed check.  The commit message says "remove unnecessary
feature check", but two checks were removed and they are not
equivalent.  The old zxdh_notify_queue() had:

	if (!zxdh_pci_with_feature(hw, ZXDH_F_NOTIFICATION_DATA)) {
		rte_write16(vq->vq_queue_index, vq->notify_addr);
		return;
	}

That is a different doorbell format, not an optimization.
ZXDH_F_NOTIFICATION_DATA is negotiated, not mandatory:
zxdh_get_pci_dev_config() calls zxdh_pci_get_features(hw) when
hw->switchoffload is set, so host_features comes from the device.
zxdh_alloc_queues() explicitly handles the
"switchoffload && !(host_features & RING_PACKED)" case, so a
non-packed, non-notification-data device is a configuration this
driver still claims to support.  On such a device the new inline
writes a 32-bit notify_data with bit 31 derived from cached_flags,
which is meaningless for a split ring.

Either keep the feature gate, or make both features mandatory and fail
probe when they are not negotiated -- and then remove the unreachable
split-ring queue init path.

Error: dead code left behind by the same change.  After this patch
nothing calls ->notify_queue.  zxdh_notify_queue() in zxdh_pci.c and
the .notify_queue member of struct zxdh_pci_ops are unreachable, yet
this patch edits zxdh_notify_queue() for the cached_flags rename.
Remove the function and the ops member instead of maintaining them.

Same pattern with zxdh_queue_kick_prepare_packed(): this patch changes
zxdh_mb(1) to rte_mb() inside it, and patch 3 then removes its only
caller.  Drop the function in 3/4 or leave it alone in 2/4.  Note that
zxdh_mb(1) was rte_atomic_thread_fence(rte_memory_order_seq_cst);
rte_mb() is a heavier full hardware fence on non-x86.

Error: Tx indirect descriptor init removed but the region is not.
Deleting the zxdh_vring_desc_init_indirect_packed() loop leaves that
function with zero callers, and tx_indir[]/tx_packed_indir[] in
struct zxdh_tx_region with zero users.  ZXDH_MAX_TX_INDIRECT is 8, so
that is 128 bytes of hugepage memory per descriptor in the header
memzone, allocated and never used.  In a performance series this
should be removed, not just left uninitialized.

Warning: dead struct members added.  struct zxdh_vring and the
vq_split union arm have no user anywhere in drivers/net/zxdh.  Same
for next_qidx and rsv_8B.  If this is groundwork for split-ring
support, add it with the code that uses it.

Info: __rte_packed_begin on the vq_packed union arm.  struct
zxdh_vring_packed is three pointers with no padding, so packing
changes nothing except telling the compiler the members may be
unaligned.  It is a hot-path pointer load.  Drop the attribute.

Info: rsv_8B is declared uint32_t.  The name says 8 bytes.

Info: the patch removes the prefixed zxdh_desc_used() and keeps the
unprefixed desc_is_used().  Everything else in the file is zxdh_*.


Patch 3/4: net/zxdh: optimize Rx recv pkts performance

Error: ZXDH_ETH_OVERHEAD does not account for the uplink net header,
so scatter is not enabled when it is needed.

	#define ZXDH_ETH_OVERHEAD \
		(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + ZXDH_VLAN_TAG_LEN * 2)

The Rx descriptor is programmed as len =3D buf_len - RTE_PKTMBUF_HEADROOM
and the device writes its own header into that same buffer ahead of the
payload -- zxdh_init_mbuf() recovers the payload with
data_len =3D len - hdr_size.  struct zxdh_net_hdr_ul is 4 + up to 56
bytes, so up to 60 bytes of the buffer are consumed before any packet
data.  ZXDH_ETH_OVERHEAD accounts for none of it.

With the default 2176-byte data room (buf_size 2048) and MTU 2000,
2000 + 26 <=3D 2048, so zxdh_scattered_rx() returns 0 and
zxdh_recv_single_pkts is installed.  The real requirement is
2000 + 14 + hdr_size, which exceeds 2048, so the device splits the
frame and zxdh_init_mbuf() drops it on num_buffers !=3D 1.  Silent packet
loss across a band of otherwise valid MTUs.

Error: zxdh_dev_mtu_set() rejects valid MTUs when scatter is already
enabled.

	uint8_t need_scatter =3D
		(uint32_t)ZXDH_MTU_TO_PKTLEN(new_mtu) > buf_size;
	if (need_scatter !=3D dev->data->scattered_rx)
		return -EINVAL;

need_scatter is computed purely from size, but scattered_rx was set by
zxdh_scattered_rx(), which also returns 1 for RX_OFFLOAD_SCATTER and
RX_OFFLOAD_TCP_LRO regardless of size.  A port configured with
RX_OFFLOAD_SCATTER and then set to MTU 1500 gets need_scatter =3D=3D 0 and
scattered_rx =3D=3D 1, and the call fails on a perfectly valid MTU.  The
comparison has to mirror the offload checks, not just the size check.

Warning: three different Ethernet overhead definitions now coexist.
dev_info->max_mtu uses RTE_ETHER_HDR_LEN + RTE_VLAN_HLEN +
ZXDH_DL_NET_HDR_SIZE; ZXDH_ETH_OVERHEAD uses HDR_LEN + CRC_LEN +
2 * VLAN; and the actual Rx buffer requirement is
HDR_LEN + ZXDH_UL_NET_HDR_SIZE.  Derive one per-device overhead helper
and use it in dev_infos_get, zxdh_scattered_rx() and
zxdh_dev_mtu_set().

Warning: zxdh_init_mbuf() drops the header-length validation the
mergeable path still has.  zxdh_recv_pkts_packed() checks
"hdr_size > lens[i] || hdr_size < ZXDH_TYPE_HDR_SIZE" before using it.
zxdh_init_mbuf() checks only num_buffers !=3D 1, then computes
data_len =3D len - hdr_size (uint16_t underflow on a bad pd_len) and sets
data_off =3D RTE_PKTMBUF_HEADROOM + hdr_size from an unvalidated
device-supplied value.  The later data_len !=3D pkt_len test usually
catches it, but only after zxdh_rx_update_mbuf() has run and data_off
is already set.  Add the same bounds check.

Warning: no_free_tx_desc_err is added to zxdh_virtnet_stats and to the
txq xstats table but never incremented anywhere, so the xstat always
reads zero.  The Tx path in 4/4 that would justify it just breaks
without counting.

Warning: the refill path notifies unconditionally.

	refill:
		if (vq->vq_free_cnt > 0) {
			refill_que_descs(vq, dev);
			zxdh_queue_notify(vq);
		}

This replaces "if (unlikely(zxdh_queue_kick_prepare_packed(vq)))".  The
doorbell write now happens on every burst call where the ring is not
full, including the num =3D=3D 0 idle path and the case where
rte_pktmbuf_alloc_bulk() failed and nothing was refilled.  That is an
MMIO write per empty poll, in a series about throughput.

Warning: new functions do not follow the DPDK function-definition
style.  zxdh_scattered_rx, refill_desc_unwrap, refill_que_descs,
zxdh_init_mbuf and zxdh_recv_single_pkts all put the return type on the
same line as the name.  Every pre-existing function in these files
splits them.

Info: refill_desc_unwrap and refill_que_descs are unprefixed.

Info: zxdh_scattered_rx() sets eth_dev->data->lro =3D 1 as a side effect
of a predicate and never clears it on the other paths.  It also returns
int for a pure true/false result assigned to a 1-bit bitfield; bool
would be clearer.

Info: the trailing rte_io_wmb() in refill_que_descs() is redundant,
since zxdh_queue_store_flags_packed() already issues one before each
flag store.

Info: column alignment is broken for the "idle" entry in
zxdh_txq_stat_strings[].

Info: removing the full, norefill, multicast and broadcast xstats is a
user-visible change to per-queue xstats output with no release note.


Patch 4/4: net/zxdh: optimize Tx xmit pkts performance

Error: zxdh_recv_single_pkts() no longer compacts the output array;
use-after-free plus mbuf leak.  This patch removes
"rcv_pkts[nb_rx] =3D rxm;" from the loop, leaving:

	for (i =3D 0; i < num; i++) {
		struct rte_mbuf *rxm =3D rcv_pkts[i];
		...
		if (unlikely(zxdh_init_mbuf(rxm, len, hw, &vq->rxq) < 0))
			continue;
		zxdh_update_packet_stats(&rxvq->stats, rxm);
		nb_rx++;
	}

rcv_pkts is the application's rx_pkts array.  zxdh_init_mbuf() calls
rte_pktmbuf_free(rxm) on its failure paths, but the freed pointer is
left in rcv_pkts[i] and the good mbufs are never moved down.  If packet
0 fails and 1..3 succeed, the function returns 3 and the application
reads rcv_pkts[0..2]: index 0 is a dangling pointer that will be freed
again, and the mbuf at index 3 is leaked -- neither returned to the
caller nor left in the ring.  Patch 3/4 had this right; restore the
assignment.

Warning: zxdh_xmit_fast_flush() walks the completion chain unbounded.

	id =3D desc[used_idx].id;
	do {
		...
		used_idx +=3D 1;
		free_cnt +=3D 1;
		if (unlikely(used_idx =3D=3D size)) {
			used_idx =3D 0;
			vq->used_wrap_counter ^=3D 1;
		}
	} while (curr_id !=3D id);

id comes from device-written memory.  The removed
zxdh_xmit_cleanup_inorder_packed() bounded the walk with num, and the
old zxdh_xmit_flush() advanced by the driver-owned dxp->ndescs.  Now a
corrupt or unexpected id walks the whole ring, freeing cookies and
inflating vq_free_cnt past vq_nentries.  Cap the inner loop at
vq_nentries.

Warning: the descriptor id semantics changed.  The old path set
start_dp[idx].id =3D id (the head index) on every descriptor in a chain
and used dxp->ndescs to advance.  zxdh_xmit_enqueue_append() now sets
start_dp[idx].id =3D idx per descriptor, and the flush loop terminates on
curr_id =3D=3D id, which only works if the device reports the last
descriptor's buffer id.  That is what the packed spec says, but the
flush loop also does "desc[used_idx].id =3D used_idx;" on every
descriptor -- a redundant write, since both enqueue paths already set
.id on everything they touch.  Please state in the commit message which
behaviour the device implements, and drop the reset if it is not
load-bearing.

Warning: dead macros added.  rxq_get_vq, txq_get_vq, N_PER_LOOP,
N_PER_LOOP_MASK and NEXT_CACHELINE_OFF_8B have zero users.  Only
NEXT_CACHELINE_OFF_16B is referenced.

Warning: offloads fields added to struct zxdh_virtnet_rx and struct
zxdh_virtnet_tx (in 3/4 and 4/4) are never written or read.  In
structures being reordered for cache locality, 8 unused bytes in each
is counterproductive.

Info: the "IMPORTANT:" comment in zxdh_xmit_enqueue_append() documents
a fragile invariant -- "any code path that attempts to read
vq_descx[head_id].cookie will see NULL and must handle this case
appropriately" -- without naming the paths.  zxdh_queue_detach_unused()
and zxdh_queue_rxvq_flush() both skip NULL cookies, so it holds today,
but this reads like an invariant that wants an assertion.

Info: zxdh_queue_store_flags_packed() gains a volatile qualifier on its
parameter while the descriptor ring is non-volatile everywhere else it
is touched.  Either qualify the ring consistently or leave it alone.

Info: "struct zxdh_vq_desc_extra *dep =3D &vq->vq_descx[0];" followed by
dep[idx] is just vq->vq_descx[idx] written indirectly.

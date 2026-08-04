Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF553C55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 16:33:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3370440685;
	Tue,  4 Aug 2026 18:33:45 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0BBB740616
 for <dev@dpdk.org>; Tue,  4 Aug 2026 18:33:43 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cace91f112so904045ad.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785861222;
 x=1786466022; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2hUXjRrVTx93CKY6rQiykDu40109ZTSSwt7/g6gMa+0=;
 b=jYPK6Shm+VayvjAbFZfRXlrPenEgDCUM9/YclJXD19pRHeXbYXGm375Dqe7FD5vX7l
 ykhe/LQXoLs7bUmdbUesSeH6Y6YieYsQKR5CP3VIL0cZYFTcfzodeJIzCFAl4PH0EvI0
 s+KclkYqR7fmoAp2mewyO7UpGPDUQfTPAKGF27NehentNC8VWBGqiE/OhtgcwRDv++fj
 vWNiYVCUMEt7G6gaB9sjaJIZFEeTTg2yAMQofo4/u/P/7d75rtC82oXjilWYSwJ+KLjv
 LDMlATMXyVuwjooRpG5D8Mxr6inSA6Qbh6wT7ynnPpsu7v2gWQVLEQhHR726DBWwowJw
 c/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785861222; x=1786466022;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2hUXjRrVTx93CKY6rQiykDu40109ZTSSwt7/g6gMa+0=;
 b=c8HTcipGFqZrvD5HE6xXz8qThjI0WCcKuOQmTNaA74tK4PIl7m/ZBcYFOOuX6KaHDt
 OheMoX7B6EwMeX3fTO2MnLSbXMI22rg9GHnGKSgal2iusKrRF3wKPMJEvGvCVJMICURe
 kZapNu+UfnPkQnRvKAdlsdEDhXZnG1ZbN1yC+OR2aA5Q6K3eRrcEQ/qqZioQCkfXR1rb
 v4a3GOuhhyhC9oPGryxmm58wygMiP9x4eysrbFs6gK9aRdhZixYqSvP55bMexDJJSvQD
 AjtkLceN/7dwZ9uNdZ862KRogCFvzPOFRlB62iyKG7TxiKzwNPyjhLSKvop73T26Lse1
 qfeA==
X-Gm-Message-State: AOJu0YxjpHbOfEHZ7d0wkpj9V3zbdfps1DHyrBV5n+7Ob/f8WsrJKS3x
 ynXEf4bnegTpXAd9wkIAnIboOAhV26dZUbkuTvRuLL9GwtlB2sPpw/C54dwS/ApFxzBiiEuw0Pr
 R2llA
X-Gm-Gg: AR+sD11NN9ZCU3/GG3Doqu49EjeZK+UCgmtDOVrMXJGAvdA/n8erxunQh8ESBrcCeYF
 Kbl3VkVOlz8FtVKBSED2w3hg9KtbHVBbqgtHQfWpcab0ymDOx7YiykOG0dHfUntGrdPB9hCRt9A
 vs5pltD5PStT0/lm+Nt0d24B6wbR2EhxKfY0CeA0zj+19VgaWg5HNE0ANPHbooSCVveNXmkgUmV
 5JB1c5QzBRR1bGc7wKFAY/319USbDwB23qcjK8ncu6uvI04julihXg1gM7KmfqkPqTNZJCHMJbq
 KnkVrOeku3vRB43S0TY1p24h/1Nk8DAvOhuk+i46i2XViq5fWscJgEwp+3B3IBwORuX6Zk6cZiW
 NuWkplVz2F+0EnQNlzPbsS2wTEAKGj/ZvJpeJP/hlFYfmUo3lX8JM0zv203SMH9m6Sd6tYVJ2/S
 k0s/feuucUmNjuPGYV7H/xmYIo8TrTGNMl3vTziVx6qWWre34JHDMhODDgrA99KzpWTI7DbXdwJ
 e1oJURjP+eEs6qJBJBbPtgrFKhFsA==
X-Received: by 2002:a17:902:ccca:b0:2ca:e3f:6a4a with SMTP id
 d9443c01a7336-2d0ca962f22mr227195ad.21.1785861221908; 
 Tue, 04 Aug 2026 09:33:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b761asm10452056eec.1.2026.08.04.09.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 09:33:41 -0700 (PDT)
Date: Tue, 4 Aug 2026 09:33:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260804093339.23efb551@phoenix.local>
In-Reply-To: <20260803112419.2202150-1-wang.junlong1@zte.com.cn>
References: <20260709104637.924861-1-wang.junlong1@zte.com.cn>
 <20260803112419.2202150-1-wang.junlong1@zte.com.cn>
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

On Mon,  3 Aug 2026 19:24:14 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v10:
>   - Based on the issues raised in the AI review, Patch 2/4 Patch 3/4 Patc=
h 4/4 have been modified.
>=20
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
>  doc/guides/rel_notes/release_26_07.rst |  11 +
>  drivers/net/zxdh/zxdh_ethdev.c         |  77 +++---
>  drivers/net/zxdh/zxdh_ethdev_ops.c     |  23 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h     |   7 +
>  drivers/net/zxdh/zxdh_pci.c            |  21 --
>  drivers/net/zxdh/zxdh_pci.h            |   1 -
>  drivers/net/zxdh/zxdh_queue.c          |  11 +-
>  drivers/net/zxdh/zxdh_queue.h          | 132 ++++------
>  drivers/net/zxdh/zxdh_rxtx.c           | 317 +++++++++++++++----------
>  drivers/net/zxdh/zxdh_rxtx.h           |  14 +-
>  10 files changed, 316 insertions(+), 298 deletions(-)
>=20

Detailed AI review still finds several issues.

Applied on top of c1a46b9 and built each commit separately with
-Dwerror=3Dtrue. All four commits compile clean with no warnings, so
the series is bisect safe. The v9 issues with F_NOTIFICATION_DATA,
the missing uplink header in ZXDH_ETH_OVERHEAD, the data_off double
count, and the recv_single compaction are all fixed. A few things
still need work.

Patch 2/4: optimize queue structure

Warning: the inlined zxdh_queue_notify() drops the
ZXDH_F_RING_PACKED gate that zxdh_notify_queue() had on bit 31.
The old code only set it when packed was negotiated; the new one
sets it from cached_flags unconditionally. The commit log says the
F_NOTIFICATION_DATA gate was kept but says nothing about removing
the packed gate. Either restore it, or state in the log that packed
is now assumed.

Info: the new next_qidx member of struct zxdh_virtqueue has no
readers and no writers anywhere in the tree. Dead field in a patch
whose purpose is removing dead fields.

Info: rsv_8B is a uint32_t, so four bytes not eight.

Info: zxdh_vq_desc_extra::ndescs has no readers or writers left
after 4/4 removes the last two. It should be removed with the rest.

Patch 3/4: optimize Rx recv pkts

Error: zxdh_dev_mtu_set() and zxdh_scattered_rx() use different
predicates. mtu_set includes LRO:

	uint8_t need_scatter =3D
		(dev->data->dev_conf.rxmode.offloads &
		 (RTE_ETH_RX_OFFLOAD_TCP_LRO |
		  RTE_ETH_RX_OFFLOAD_SCATTER)) || ...

but zxdh_scattered_rx() has no LRO term, and set_rxtx_funcs() keeps
LRO in a separate dev->data->lro flag. So scattered_rx never
reflects LRO. With LRO on, scatter off, and an MTU that fits the
buffer, need_scatter is 1 while scattered_rx is 0 and every
rte_eth_dev_set_mtu() on a started port fails with "Stop port
first." Both sites need the same predicate.

Warning: the same check also rejects MTU decreases. If scattered_rx
is already 1 and the new MTU fits in one buffer, need_scatter is 0
and the call is refused, even though the scattered Rx function
handles single segment packets fine. Only the 0 to 1 transition
needs rejecting.

Warning: set_rxtx_funcs() silently drops the ZXDH_NET_F_MRG_RXBUF
check that used to fail the port. zxdh_recv_pkts_packed() still
walks header->type_hdr.num_buffers to build chains, which is
mergeable rxbuf semantics. If dropping the requirement is
deliberate, say so in the log.

Warning: zxdh_queue_kick_prepare_packed() is removed and both Rx
paths now call zxdh_queue_notify() unconditionally on every burst
that refills. That ignores the device's RING_EVENT_FLAGS_DISABLE
suppression and adds an MMIO write per burst. That is a
pessimization in a patch titled "optimize" and it is not mentioned
in the log.

Info: the two Rx paths address the header differently.
recv_pkts_packed uses buf_addr + RTE_PKTMBUF_HEADROOM,
zxdh_init_mbuf uses rte_pktmbuf_mtod(). Both work today because
refill always allocates fresh mbufs, but pick one; mtod is the
idiom.

Info: zxdh_scattered_rx() returns bool but its comment says it
returns 1 or 0. And zxdh_set_rxtx_funcs() now has no failure path
and its return value is ignored by the only caller, so make it
void.

Info: this patch adds ZXDH_MTU_TO_PKTLEN() but zxdh_scattered_rx()
open codes mtu + ZXDH_ETH_OVERHEAD + ZXDH_UL_NET_HDR_SIZE instead
of using it.

Patch 4/4: optimize Tx xmit pkts

Error: the walk in zxdh_xmit_fast_flush() is still unbounded and
driven by device written memory:

	id =3D desc[used_idx].id;
	do {
		...
		used_idx +=3D 1;
		if (unlikely(used_idx =3D=3D size)) {
			used_idx =3D 0;
			vq->used_wrap_counter ^=3D 1;
		}
	} while (curr_id !=3D id);

id comes out of the descriptor ring. If the device writes
id >=3D vq_nentries, curr_id never equals id and the loop spins
forever, freeing cookies around the whole ring and flipping
used_wrap_counter each lap. An in range but wrong id inflates
free_cnt past vq_nentries and corrupts ring accounting. Validate
id < size before entering the loop, or cap the iteration count at
vq_nentries. This was raised on v9 and the rewrite did not address
it.

Error: the prefetch indexes past the end of the descriptor array:

	rte_prefetch0(&desc[used_idx + NEXT_CACHELINE_OFF_16B]);

used_idx reaches size - 1, so this reads up to desc[size + 7].
vq_nentries is validated power of two in zxdh_queue.c, so mask it:

	rte_prefetch0(&desc[(used_idx + NEXT_CACHELINE_OFF_16B) &
			(size - 1)]);

Warning: point 2 of the commit log says "no reset of the id field
is performed in the flush loop", but the loop body starts with

	desc[used_idx].id =3D used_idx;

The store is also redundant, since both enqueue paths write .id on
every enqueue. It is dirtying a device shared cache line in the hot
path for nothing. Drop it and fix the log, or explain why it is
needed.

Warning: the release notes go in the wrong file. The tree is at
26.11.0-rc0; the hunk adds to doc/guides/rel_notes/release_26_07.rst
which is already released. It belongs in release_26_11.rst.

Warning: the xstats counters are removed in 3/4 but documented in
4/4. Code and docs should land in the same commit.

Info: the NEXT_CACHELINE_OFF_16B conditional is dead.
RTE_CACHE_LINE_SIZE / 16 already gives 8 and 4 for the 128 and 64
cases, so only the #else branch is needed.

Info: leftover comment in zxdh_xmit_pkts_packed(), "Positive value
indicates it need free vring descriptors", now sits above the
free_cnt test with nothing to refer to since need was removed. Also
a double space after > on that line.

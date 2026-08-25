Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E8C61DBD
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 19:58:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED8B8400D7;
	Tue, 25 Aug 2026 21:58:21 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 20E63400D5
 for <dev@dpdk.org>; Tue, 25 Aug 2026 21:58:20 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d6f624c323so3411375ad.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787687899;
 x=1788292699; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XwCotfY6M+K5xUpDAd8OswlkLBm5g051YjvZUs4bj4c=;
 b=jYGujPUEBLFe73xjKuZgJ/ioVOwM5qtorDqKny2eXAtChrbY5g61PVBpLwHPbXLtte
 ync1SrqTiJHkMB8V5mwGK/EatririgRsuTaQn7fpUSpDHraJc830KRnHamgVk5/9LGew
 tyTl8KCSEj48lQk5DSLXfLrUktW9FIcsVyKaEklDsmES48EG0S1fAQ0ViKj7EFzH5n7m
 wU/yj/V5aGDfnJfpXFlEbtk1qs6nV9XHNqPcu72MWpTvBB01ckvW5bG8BJGEkzJGEJ37
 x0fhHS9fy5WuryvANYq5umZpFRaJcGbdrd5LYJRt1OEL1aZBquwEYMVtJEg5BS1VV6Tk
 sFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787687899; x=1788292699;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XwCotfY6M+K5xUpDAd8OswlkLBm5g051YjvZUs4bj4c=;
 b=lt4z+oSxoeiDbluzoVHykW+1Cbn6IHaTsOgHts7mOWgvMdlHw0upeDqvCVmL20/ch2
 4JuM+MSGQeLZU6oCcOF40TSMRBJmEkH6cpTMCUmZhR/oAy8OddqvRuO9rRj7FbUIp9hT
 3GVsPDIEPLW+U0hji0Mwc6MI3ampIWrTA06l6kRX3pwT3N4Jr2C59P98spnaI6v0MEbd
 Co5SLpp/+cC+qBYnX5Oqnp7KuAtSqBkRmGOQe11hvS9zu7a6TS8QpO4XqZ83viekxKvn
 lK7sFEAve2lDgFxS6zRYwt3MBCLNa7pcW18nuitEy+E2h25+kcm1O7+1E6kKrECzjb9M
 GLwQ==
X-Gm-Message-State: AFuF++mXJlIwzK2kf6p4geLkcJ/wPw7Mvi8Fv/dp9nW8Q59i4UU03k4U
 aRyzTHd7gDbFD1/w4DohLjOWDrxrJqRvIPv6y4pFVQwtFAqI88gt0OnbjNOVQrAvyp4=
X-Gm-Gg: AR+sD13CXrDqb5YT6BSkaehrLQEf1fEdzCH0U74/CmnpazbhM7dui3LIYlpwHd0CeTx
 K+QPMIqe6EWu1BRijufuzGbV8t6GzrgHuFHY7R+IDpVnWhreQIzLb2zfvScLUb3nGacGClCVgBh
 G03w7FwM9huqxw4kEMSSlUZjLpTjS9sQq6h1UeuKmzIYWRGeFGXHkW6H/xqaCpD+/VKvkM+hI1w
 3qEsOzCD3FgBfmhkY/6qKQ1lXcJFTbM08WkHmQ3y2FGHsMHfPF4cl+o2PfJJfdqD0k7cCr/qDZ5
 UHeftHfxwci9wYC7jLDvQ2kznH9SczoZ9JYzXcjhEZ8BBUQ/l+pNCQX1RVGEiQmJGmVCKTztjvY
 WkuKHdq4k+ZSxmzzpziQ/Su4UEh9uGCP9VfZQSGXeYqZsatjssZydXmZJlP6CzXo8WnkZ/exUGD
 UU11qfeb+3d9z9TdSPz7gzOOBab1yhHCHzkVBPe8xNKTkI/Pd0RbCboURI/b6mk3QHs7nzw7DET
 lbX
X-Received: by 2002:a17:90b:4c8e:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-3966d44daf1mr2488498a91.14.1787687898902; 
 Tue, 25 Aug 2026 12:58:18 -0700 (PDT)
Received: from stephen-xps.local ([209.23.204.18])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm2769850a91.2.2026.08.25.12.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 12:58:18 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:58:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260825125816.3f69defe@stephen-xps.local>
In-Reply-To: <20260825120007.3328990-1-wang.junlong1@zte.com.cn>
References: <20260819095304.3016940-1-wang.junlong1@zte.com.cn>
 <20260825120007.3328990-1-wang.junlong1@zte.com.cn>
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

On Tue, 25 Aug 2026 20:00:02 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v12:
>   - Patch 3/4 no longer introduces the unused `uint64_t offloads` field
>     in `struct zxdh_virtnet_rx`, and patch 4/4's commit log drops the
>     stale "drop offloads" claim so the message matches the actual diff.
>=20
> v11:
>   - Restructure queue types for cache locality and dead-code removal (pat=
ch 2/4),
>     optimize the packed-ring Rx path with a single-segment fast path,
>     MTU/scatter refactor, and xstats cleanup (patch 3/4), and rework the
>     packed-ring Tx flush with per-descriptor mbuf free, walk budget, and
>     masked prefetch index (patch 4/4).
>=20
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
>=20
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
>=20
> v4:
>   - fix some AI review issues.
>   - fix queue enable intr bug.
>=20
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
>=20
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
>=20
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
>  doc/guides/rel_notes/release_26_11.rst |  10 +
>  drivers/net/zxdh/zxdh_ethdev.c         |  85 ++++---
>  drivers/net/zxdh/zxdh_ethdev_ops.c     |  22 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h     |   7 +
>  drivers/net/zxdh/zxdh_pci.c            |  21 --
>  drivers/net/zxdh/zxdh_pci.h            |   1 -
>  drivers/net/zxdh/zxdh_queue.c          |  11 +-
>  drivers/net/zxdh/zxdh_queue.h          | 134 ++++------
>  drivers/net/zxdh/zxdh_rxtx.c           | 323 +++++++++++++++----------
>  drivers/net/zxdh/zxdh_rxtx.h           |  14 +-
>  10 files changed, 326 insertions(+), 302 deletions(-)
>=20

Still get some detailed AI issues..
You don't need to fix every detail and AI does tend to "bikeshed"

Review of [PATCH v12 0/4] net/zxdh: optimize queue/Rx/Tx paths

Resolved since v11
------------------

- Patch 4: the unused "uint64_t offloads" field left behind in
  struct zxdh_virtnet_rx is gone; zxdh_rxtx.h is now updated in the
  same patch that stops using the removed members.
- Patch 4: the descriptor walk in the Tx flush is bounded (budget
  initialised to vq_nentries, break on id >=3D size) and the prefetch
  index is masked with (size - 1).
- Patch 3: zxdh_dev_mtu_set() and zxdh_scattered_rx() now use the
  same predicate (ZXDH_MTU_TO_PKTLEN vs min_rx_buf_size minus
  headroom), so the two no longer diverge.
- Patch 1: Fixes: 7677f3871ef3 resolves to a real commit whose
  subject matches, and the tag uses a 12-character hash.


Warnings
--------

Patch 3/4 (net/zxdh: optimize Rx recv pkts performance)

1. drivers/net/zxdh/zxdh_ethdev.c, zxdh_set_rxtx_funcs()

   The ZXDH_NET_F_MRG_RXBUF runtime check is removed and replaced
   with a comment stating the feature "is always negotiated (set in
   both ZXDH_PMD_DEFAULT_GUEST_FEATURES and
   ZXDH_PMD_DEFAULT_HOST_FEATURES)".  That premise does not hold on
   every path.  In zxdh_get_pci_dev_config():

       hw->host_features =3D ZXDH_PMD_DEFAULT_HOST_FEATURES;
       if (hw->switchoffload)
               hw->host_features =3D zxdh_pci_get_features(hw);
       nego_features =3D guest_features & hw->host_features;

   When switchoffload is set, host_features comes from the device,
   so ZXDH_NET_F_MRG_RXBUF can be absent from the negotiated set.
   Both zxdh_recv_pkts_packed() and zxdh_init_mbuf() then read
   header->type_hdr.num_buffers for a device that never agreed to
   populate it.

   Note the old check was already ineffective in a different way:
   the caller in dev_start ignores the int32_t return, so the -1
   only left rx_pkt_burst/tx_pkt_burst unassigned.  Either keep the
   check and make dev_start actually fail on it, or narrow the
   comment to the non-switchoffload case.

2. doc/guides/rel_notes/release_26_11.rst

   The release note enumerates the individual counters removed
   ("full", "norefill", "multicast_packets", "broadcast_packets").
   That level of detail does not belong in the release notes and
   dates badly as the counter set keeps changing.  A single bullet
   along the lines of

     * Changed the set of per-queue xstats counters.

   covers it.  The "New Features" bullets for the fast Rx path and
   the packed-ring optimisation are fine as they are.

Patch 4/4 (net/zxdh: optimize Tx xmit pkts performance)

3. drivers/net/zxdh/zxdh_rxtx.c, zxdh_xmit_fast_flush()

   The chain-walk scaffolding is now dead code.  Both enqueue paths
   write the descriptor's own index into the id field
   (zxdh_xmit_enqueue_push: dp->id =3D id where id =3D=3D vq_avail_idx;
   zxdh_xmit_enqueue_append: start_dp[idx].id =3D idx), and the commit
   message states the flush relies on desc[k].id =3D=3D k being
   preserved.  Given that invariant, "id" always equals "used_idx",
   so "curr_id !=3D id" is false on the first pass and the do/while
   body executes exactly once per outer iteration.

   The result is a loop that simultaneously assumes id =3D=3D index and
   retains the machinery for the case where it is not, which makes
   the bound reasoning harder to follow than it needs to be.
   Suggest dropping id, curr_id and the inner do/while and walking a
   single descriptor per outer iteration, keeping the budget counter
   and the id >=3D size guard as the corruption backstop:

       while (budget-- > 0 && desc_is_used(&desc[used_idx], vq)) {
               rte_prefetch0(&desc[(used_idx +
                       NEXT_CACHELINE_OFF_16B) & (size - 1)]);
               if (unlikely(desc[used_idx].id >=3D size))
                       break;
               dxp =3D &vq->vq_descx[used_idx];
               ...
       }


Info
----

Patch 3/4

4. drivers/net/zxdh/zxdh_rxtx.c, zxdh_update_packet_stats()

   The patch removes stats.multicast and stats.broadcast from
   struct zxdh_virtnet_stats, but the QUEUE_XSTAT block still
   references them (and an undeclared "ea").  The block was already
   uncompilable before this series, so nothing regresses, but since
   the series is cleaning out unused counters this is a good moment
   to delete the whole #ifdef QUEUE_XSTAT body.  The size_bins[]
   entries left in zxdh_rxq_stat_strings[]/zxdh_txq_stat_strings[]
   are always zero for the same reason and are candidates for the
   same cleanup.

5. drivers/net/zxdh/zxdh_rxtx.c, refill path

   zxdh_queue_notify() is called whenever vq_free_cnt > 0, including
   when rte_pktmbuf_alloc_bulk() inside zxdh_refill_que_descs()
   failed and no descriptor was made available.  Harmless, but it
   costs an MMIO write on the mempool-exhausted path.  Having
   zxdh_refill_que_descs() return the number refilled and notifying
   only on a non-zero result would avoid it.

Patch 4/4

6. drivers/net/zxdh/zxdh_rxtx.c

   NEXT_CACHELINE_OFF_16B is the only macro in the file without the
   ZXDH_ prefix used everywhere else in the driver.  There are also
   two consecutive blank lines before it.

7. drivers/net/zxdh/zxdh_rxtx.c, zxdh_xmit_enqueue_append()

   The comment naming the expected readers of head cookies lists
   zxdh_queue_rxvq_flush(), which only ever walks Rx virtqueues and
   never sees a Tx head descriptor.  zxdh_queue_detach_unused() is
   the relevant one.

8. drivers/net/zxdh/zxdh_queue.h

   struct zxdh_vq_desc_extra's "ndescs" is renamed to "rsv" rather
   than removed.  Nothing reads it after this patch, and "next" is
   only written by zxdh_vring_desc_init_packed() and never read, so
   the struct could be reduced to just the cookie pointer if you
   want the whole array to shrink.

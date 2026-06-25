Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ACACDE00C
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 22:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 961D840278;
	Fri, 26 Jun 2026 00:42:10 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 0FDF140272
 for <dev@dpdk.org>; Fri, 26 Jun 2026 00:42:08 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30c713f37c2so1317885eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782427328;
 x=1783032128; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyZhPCLaJ1ibm/OqCC4Sss4TusNQJoM/B/hDQRZpW+U=;
 b=zBvAJq5/qLPv5Vpd3g+Cu7AbWZpgNfgtPUzDwm9drJnRnnwhQ8vucsvvN1+3t2EpKX
 hr++DUJ55u+veVtyRvpFlt0CKFUhcUZFb/AdOORW56KqGXMU4WfstmYyvMEoZ9ytdwap
 6DAm6CW7d1PTUMPztbG7HCDMYpHUGSmXpEWyFUIvadEOIT3Ey7TU0q7iD3KQKDF4FuLC
 PhhWwkRNYctnCyq0Ix/5AQh78or7pfh96lFPr1CA9jZz42gHV7hJCPQb3QKHXhMGoeVm
 4tFAc4hvOXolDK4qxWKkqtzsjM8JXsQIddb/2p8gS65XaN/pG5eW0xEdcjnvmS9IeBHt
 s1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782427328; x=1783032128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RyZhPCLaJ1ibm/OqCC4Sss4TusNQJoM/B/hDQRZpW+U=;
 b=adC031An6IA5cN/04rYkfJMHkAl9tQa3wKqN9AhgZazIC+1Dnm9UVvjWt7o0flnyyQ
 ABKbF9oQ/sy5bLOtm7yd95P+FhX+zHsj4//PAODel1GkxDuWQaC2OMP8KtitqrpbRWg3
 5hqj4fvs408o/4AcD3jod/5/wUN5BrfGbOiW5zaHPaLrgGqV8lKJZiJG0ONBnaF2xdp2
 1PsKDCLp/EqPkwOJgHS+mItP/7TyBbL1v8lE828lxdsj0Qx/Cwj7InP2Ad9CttfA+TFx
 cXiHIF9FAiGRutOAwcdQoI/HabPX0eXHQLnD4wuUc/nwy5oIZcCBY9RvIeTdsfhiyh3k
 u5nw==
X-Gm-Message-State: AOJu0YwRPGj4WtKsT+o+pBS1bQr8CNDAWmQbBkGe/fEg5lSiimwvSFkV
 /+izA9ijNQwRp0Pk9ma/wUi6206QdhzmHnMVdn78PkUeDiqIVxEirx51WYjVNewrE2c=
X-Gm-Gg: AfdE7clS14D6RTKiwg0SuNB0NrbgygliUD8Lhdfamq2yclQQOgYiuBCyAf5jXP7Gv20
 ZfMjCeEHp2zv9DsGE+7/mC1HaHv1mHPvEb7Zv0UywSXCsCfitfuVslJLMODga7Z9gJRSTvEZVDR
 Cdo7AutF9u4yCdTI5AYU724eo/HL//2v74457wN2k5gLVneAgWxaDRx8scltGyO6ryTFJCaMAFA
 Vdq6mSOU3RdBSO7U3mVnE9KaSaXEOhD4qwqWpZSA59p9Z8v7bmf7hvrGJLVU4BTnnVANDv5mhB/
 S/5GfxgKYBYVYUcCCJ8pNWlWkRD8kc7nDGc7JrQtBUenbg+XGqyXZyqkDIJP2GoBcLdMX0OfGOT
 zJA5z7JwUNtb3L9gHvUlnHJnujixYf3dSTrfpPPGOSD5Brl9xzmo9Oqjtn5jVI3z8Bc42ppGr0a
 WAQq21vsXSXVurJZPoy2id4LUcRrgsESul8nfIbT0CGPbx1PE1aGh8uw==
X-Received: by 2002:a05:7300:8191:b0:304:ddc3:2c35 with SMTP id
 5a478bee46e88-30c85a603a0mr4175783eec.10.1782427327749; 
 Thu, 25 Jun 2026 15:42:07 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm11391345eec.19.2026.06.25.15.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:42:07 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:42:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260625154203.1d16769b@phoenix.local>
In-Reply-To: <20260625120317.211780-1-wang.junlong1@zte.com.cn>
References: <20260623060909.97023-1-wang.junlong1@zte.com.cn>
 <20260625120317.211780-1-wang.junlong1@zte.com.cn>
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

On Thu, 25 Jun 2026 20:03:12 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

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
>  drivers/net/zxdh/zxdh_ethdev.c     |  83 ++--
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  23 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   4 +
>  drivers/net/zxdh/zxdh_pci.c        |   2 +-
>  drivers/net/zxdh/zxdh_queue.c      |  11 +-
>  drivers/net/zxdh/zxdh_queue.h      | 122 +++---
>  drivers/net/zxdh/zxdh_rxtx.c       | 591 +++++++++++++++++++++++------
>  drivers/net/zxdh/zxdh_rxtx.h       |  29 +-
>  8 files changed, 604 insertions(+), 261 deletions(-)
>=20

AI spotted one bug but it under valued how serious the issue is.
AI also gave bad advice about this earlier. Here is my analysis
followed by buggy AI review, then what it said after I pointed out
its mistake. Sorry, I need to not trust AI; its good until it isn't

The semantics of how DPDK drivers are supposed to handle bad packets
in transmit is not well documented. The correct way to handle a packet
that can not be sent is for the driver to consume (free in tx_burst)
and increment an error counter, and keep going. Suppose application
gave a single buggy mbuf (index 3) in a burst of 16 packets (assuming
there was space in the transmit ring).
The driver should return with 16 (all packets consumed) but the
statistics should reflect what happened: 15 packets transmitted, 1 tx error.

The problem with should return is that the application can not tell
the difference between backpressure (transmit ring full) and a bad packet.
An application may think it see back pressure and retransmit the bad packet.

--- AI review (buggy) ---

Series review: net/zxdh Rx/Tx optimization (v8)

The v7 issue is resolved. The simple Tx burst no longer depends on the
optional tx_prepare for memory safety: zxdh_xmit_pkts_simple() now
filters mbufs with data_off < hw->dl_net_hdr_len before any packet
reaches pkt_padding(), stopping at the first short-headroom packet and
returning the count enqueued so far, so the caller keeps ownership of
the rest. The threshold matches exactly what pkt_padding() prepends,
and submit_to_backend_simple()/pkt_padding() are only reachable through
that filter, so the open-coded prepend can no longer underflow data_off
or write before buf_addr. The build-time backstop

	static_assert(RTE_PKTMBUF_HEADROOM >=3D ZXDH_DL_NET_HDR_SIZE, ...)

is also in place (static_assert resolves via rte_common.h).

Patches 1-3 are unchanged from v7 and remain correct: the enable_intr
fix is first in the series against the original field name so it
backports cleanly; the Tx AVAIL flag is published through
zxdh_queue_store_flags_packed() (rte_io_wmb); multi-segment Tx frees
each segment once via free_seg with the head descriptor's NULL cookie
holding the hardware header; and zxdh_recv_single_pkts() compacts
surviving mbufs.


Info (non-blocking, no need to respin):

In the new headroom filter, the whole returned tail is counted as
errors:

	if (unlikely(tx_pkts[i]->data_off < hdr_len)) {
		txvq->stats.errors +=3D nb_pkts - i;
		nb_pkts =3D i;
		break;
	}

Only tx_pkts[i] is known to be short; the packets after it are not
examined, just deferred, and the application will resubmit them on the
next burst. Counting the entire tail as errors inflates the error stat
(and a packet that is eventually sent fine can be counted as an error
on an earlier burst where it sat behind a short-headroom packet).
Counting only the rejected packet, or tracking the deferred tail
separately from errors, would be more accurate. Not worth a respin on
its own.


-- AI review (corrected) ---

Series review: net/zxdh Rx/Tx optimization (v8)

The v6/v7 out-of-bounds write is fixed: zxdh_xmit_pkts_simple() now
checks data_off < hw->dl_net_hdr_len before any packet reaches the
open-coded prepend in pkt_padding(), and the static_assert backstop is
in place. Memory safety is no longer the issue. How the unsendable
packet is handled is.

Patches 1-3 are unchanged from v7 and remain correct.


[PATCH v8 4/4] net/zxdh: optimize Tx xmit pkts performance

Error: the simple Tx burst signals a bad packet with a short return,
which the application cannot distinguish from backpressure.

	for (i =3D 0; i < nb_pkts; i++) {
		rte_prefetch0(tx_pkts[i]);
		if (unlikely(tx_pkts[i]->data_off < hdr_len)) {
			txvq->stats.errors +=3D nb_pkts - i;
			nb_pkts =3D i;
			break;
		}
	}

A short return from tx_burst is the backpressure signal (transmit ring
full, retry later). Here it is also used to mean "packet i is bad",
and the bad mbuf is left owned by the caller. The application has no
way to tell the two apart: the usual

	for (sent =3D 0; sent < n; )
		sent +=3D rte_eth_tx_burst(port, q, &pkts[sent], n - sent);

loop treats the short return as backpressure and resubmits pkts[i],
which fails again every time -- head-of-line blocking, and the good
packets after i (which had ring space) never go out.

A packet that cannot be sent must be consumed by the driver, not
handed back. Free it in tx_burst, increment the tx error counter, and
continue with the rest of the burst. For a burst of 16 where only
index 3 is bad and the ring has room, tx_burst should return 16, with
stats showing 15 transmitted and 1 tx error. A short return is then
reserved for the one case the application is entitled to retry: ring
full.

Concretely for the simple path: walk the burst, and for a packet with
data_off < hdr_len free it and bump the error counter rather than
breaking; compact the survivors (as zxdh_recv_single_pkts() already
does on Rx) and submit the compacted run. Reserve the short return for
the vq_free_cnt limit.

Better still, avoid dropping the packet at all: route a short-headroom
mbuf through the append path the packed burst already uses
(zxdh_xmit_enqueue_append copies the header into the reserved txr
region) instead of prepending in place. Then nothing is lost and the
simple path matches the packed path's handling.

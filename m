Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E8BCDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:54:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A3574029D;
	Tue, 23 Jun 2026 17:54:29 +0200 (CEST)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49]) by mails.dpdk.org (Postfix) with ESMTP id 0833740150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 17:54:28 +0200 (CEST)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-662dc387b7aso6786387d50.3
 for <dev@dpdk.org>; Tue, 23 Jun 2026 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782230067;
 x=1782834867; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5nO1HsJoJoHRRp6pXsWMd7sicqSZVw0TlpsjC3kxrE=;
 b=Y201J5j6yd0+e85iLXfAcZj3Q2N8Rgqo3RT3gZkFYferjaY9dM0nSTjXSmXbwq0RrV
 a5zf057oiUBaBnnQlLonXafeTS6sseLXCra05cGfJVY95UnIcKJxnAkJk3WHNAkIhM5l
 ueqfiDtXbkmzY1Z8jGIRMgzcLjBHdfWr23MzzlWS1MFv6EbwPsfMQMu/oHPSgJz8exQD
 uG42QKwse2/LNb3fE0A+w8J98uPZvbRYkULjbXFgv03Arlnik2A+r9UHGslM8rx7+7VU
 qUqgdIv+3zXhV49b/k66XC0gP5JdEcf7AOwNLURlhSfuM4e8tZm2aePglTga0ImHILd5
 APFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782230067; x=1782834867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C5nO1HsJoJoHRRp6pXsWMd7sicqSZVw0TlpsjC3kxrE=;
 b=FuQMgfhIFba5C0riPc9u0n2FhFj2dx1hi2QsehU5QAFGrmVd9PTZbIHITyMOyDtXCt
 KgSRkjBSfB+aHloJVN3oJIO9h1Wh3OwT8tELwze1DLZpB0My4AQsjhHt4lYsPSaQ0Luh
 5TQb4Ma9KnA5mD+5LPluw9aLrrUzwosNdyNencG13V0/b/uW1TULexiivObK6DD5mXog
 i12DQ42uc/2wujWEJOJznOzCJxX0kZLMyJkzPUiyL/hrjwCUytJQ+P9GuLbmM62qEQgz
 qcUIyzvewiUdhhhCuGTl9+8+VcKXwlvErJZm4fUyvkgrwrlHDiIRLWwX5kdh4EMtC+iz
 wKNw==
X-Gm-Message-State: AOJu0YxxqgpDHPmGuPRzuyYxh0cO9YTiNG/Mg4Q8rtFPW2yOV2f2if1F
 0BYH3P7842zviVi7UysTZL3XKM2XhzuZu0rHm7hdtbb+CWGcUASTCNY8XJ6p+a0KFT3IbF/YNsi
 OZKhI
X-Gm-Gg: AfdE7clRAWAtp7EZHnvoWCvz2h9VNZzQtDX0IsHSIE9P4rZiQuCnjkvZKzr0cgSw29t
 0WDTxMkHE5yCjrFXZKCOM52mgfNOnL93L7d2folOR87L47a9R8vFj4XVcm236/jApELID9ttY/+
 VCveB3z7ODfRdG3B4zvZYYK1kqnVjsJJ+Qc0vipd9MWwldqj2QMVRTfTME1o5oxgeYoSuhjl3ai
 1GL5o8PWj4Qe18iiexf6QmxcIVwzLwcFDWPu2Y1VAxsZkrvPoR9KAuT0OY4OBF6VXkeVO/UOr3v
 68bgtxCLK9L3vz5GvzMq9QXsXtjmzEUTHtEoEoSMrpjAnqvEhHex6io5TA1naiU26db1QXkO5mb
 2BzaJHr97isfeB+dKjMBz6yZWsF0msEgBJ/aE8iUwsIKh+BJdiRFTPkjKDY9YTt3HrmWlGhsEPJ
 qwg4VBKencFsZPm699/d1QiXkrZUsQIvrM1cK0d6uIqzueyaP1DDBrcAYkj0A9KFEB
X-Received: by 2002:a05:690e:1909:b0:660:56ee:ebf1 with SMTP id
 956f58d0204a3-6635d86ff69mr2539050d50.22.1782230067029; 
 Tue, 23 Jun 2026 08:54:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314b36d20sm5390568d50.5.2026.06.23.08.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:54:26 -0700 (PDT)
Date: Tue, 23 Jun 2026 08:54:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260623085423.7c9d0ade@phoenix.local>
In-Reply-To: <20260623060909.97023-1-wang.junlong1@zte.com.cn>
References: <20260617082828.1058127-1-wang.junlong1@zte.com.cn>
 <20260623060909.97023-1-wang.junlong1@zte.com.cn>
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

On Tue, 23 Jun 2026 14:09:04 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

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
>   These changes reduce CPU cycles and memory bandwidth consumption,
>   resulting in improved packet processing throughput.
>=20
> Junlong Wang (4):
>   net/zxdh: fix queue enable intr issues
>   net/zxdh: optimize queue structure to improve performance
>   net/zxdh: optimize Rx recv pkts performance
>   net/zxdh: optimize Tx xmit pkts performance
>=20
>  drivers/net/zxdh/zxdh_ethdev.c     |  83 +++--
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  23 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   4 +
>  drivers/net/zxdh/zxdh_pci.c        |   2 +-
>  drivers/net/zxdh/zxdh_queue.c      |  11 +-
>  drivers/net/zxdh/zxdh_queue.h      | 122 +++---
>  drivers/net/zxdh/zxdh_rxtx.c       | 571 ++++++++++++++++++++++-------
>  drivers/net/zxdh/zxdh_rxtx.h       |  29 +-
>  8 files changed, 584 insertions(+), 261 deletions(-)
>=20

Better but AI review still found some issues.

Series review: net/zxdh Rx/Tx optimization (v7)

Patches 1-3 are unchanged from v6 except for the Tx prepare split
below; patch 4 still carries the unguarded in-place prepend. The v6
out-of-bounds write is narrowed but not closed.

The improvement: tx_pkt_prepare is now split, and the simple-path
variant zxdh_xmit_pkts_simple_prepare() rejects a packet whose
headroom is too small (data_off < ZXDH_DL_NET_HDR_SIZE) with a clean
error and an invalid_hdr_len_err counter. For applications that call
rte_eth_tx_prepare() this turns the corruption into a reported error.


[PATCH v7 4/4] net/zxdh: optimize Tx xmit pkts performance

Error: the headroom check lives only in tx_pkt_prepare, which is
optional, so the simple Tx burst can still reach the unchecked prepend
in pkt_padding() and write out of bounds.

rte_eth_tx_burst() does not call rte_eth_tx_prepare(); the application
invokes prepare itself, and is allowed to skip it. When MULTI_SEGS is
disabled the burst is zxdh_xmit_pkts_simple() -> submit_to_backend_simple()
-> pkt_padding(), and pkt_padding() still does:

	hdr =3D rte_pktmbuf_mtod_offset(cookie, struct zxdh_net_hdr_dl *, -hdr_len=
);
	rte_memcpy(hdr, net_hdr_dl, hdr_len);
	cookie->data_off -=3D hdr_len;

with no data_off >=3D hdr_len guard. An application that disables
MULTI_SEGS, consumes most of the mbuf headroom before Tx (tunnel/MPLS
encap, etc.), and calls tx_burst without tx_prepare will underflow
data_off and scribble in front of buf_addr. That is a supported calling
sequence, so the memory-safety precondition cannot rest on the optional
prepare step.

The driver's own packed burst does not depend on prepare for this: in
zxdh_xmit_pkts_packed() the can_push test gates the in-place prepend on

	txm->data_off >=3D ZXDH_DL_NET_HDR_SIZE

inline, and falls back to zxdh_xmit_enqueue_append() (header copied into
the reserved txr region) otherwise. The simple burst should be equally
self-contained.

Make the simple burst safe on its own: check data_off in the datapath
and stop at the first packet that does not fit, returning the count
already enqueued (the same break-and-return the prepare function uses),
so the caller retains ownership of the rejected packet. The
zxdh_xmit_pkts_simple_prepare() check can stay as an early, friendlier
diagnostic, but it cannot be the only guard.

Also still missing: the build-time backstop discussed earlier,

	static_assert(RTE_PKTMBUF_HEADROOM >=3D ZXDH_DL_NET_HDR_SIZE,
		"RTE_PKTMBUF_HEADROOM too small for zxdh Tx downlink header");

It does not replace the runtime check (per-packet headroom can be short
on a correctly configured build) but it cheaply rejects a build whose
default headroom cannot hold the header.

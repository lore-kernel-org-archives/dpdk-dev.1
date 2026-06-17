Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB8CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2AE840276;
	Wed, 17 Jun 2026 17:21:54 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 5569C40276
 for <dev@dpdk.org>; Wed, 17 Jun 2026 17:21:53 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-13809223fd4so6440149c88.1
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781709712;
 x=1782314512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQjNMiXk09Nen+Nvba3qrt2/oy/AiII4Hf8KxXFkGlk=;
 b=cOzz2/1mj0K1piaQfsE63bHfLNShhEr8kf0/mDOW5mBY8TgPQOkKp6IiLQwkn+U9HZ
 KgJJq2tDmXgpzE3hPmOA/CHcFP3OqG696xxfN94Cs9CddHXPexiOLYEFg+MajU1cA0WV
 jbyY/2m9Wtg3uuWRY7Upx2PTbyz3ynEb9F7jxemmol5RhKiqM4kzI69L3KOgxMPjY+QA
 pbTFy3fzrNYfuJIsb0fI8tOD3L06ypqsKYD7Gs5BoycMBLopIq8XhUmcekOh+rlyBEJO
 YwHpN0QLd+EbAsXrqsAiaWTbu7Joge8lb02plSUjB3sY4I2quR4TEmaaWm9NT0wV4rlR
 o+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709712; x=1782314512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oQjNMiXk09Nen+Nvba3qrt2/oy/AiII4Hf8KxXFkGlk=;
 b=K0slixOU4iVkfhNuQMOqlWDkulc+oTMKFCIjRgSrfbw8d6HcCYY/FRlAcBCuK0j297
 MiBeizr3bwyGLdeHEMdZFhaRCVCXsVsEYNeb1w984paNudAT2Z68AlPS9XTIAWHfQkww
 hVNsM7jyVBk/VKgvKCAjwFkGL2c3HBpk/9aD10Bb5UDX4+qfxGddvs6xK/DJbk3ZqvJM
 qBstonEfpLDBRnI58rpnU63dNefFGoVNbcgKvTzyllyrPb/i6+jWYPR3eqWqZbV2HKjD
 1HbbTtty47VlwbnYLF2JW/WxV7ZOMYpTYjHbHtEVS0ggEYkL27M516ceQVPMDbYQwJsq
 FrFw==
X-Gm-Message-State: AOJu0YxRzvrgVNGTlvcHEIPTBfY5/5WNtJlRAly/F+hw3zYjkH/O/mLx
 ymcDNdfyJaptQSk8vMHehq8SbzYPyYdorIJP0WuRiMaSnokroxbte1ZgpGfPHc8nxvI=
X-Gm-Gg: Acq92OE1SsLhTZsDue4DrhctSFQ1H6StHfZUAepc4fgMXSTpVQ/R4CIlx5kj3vyY1cO
 dhexCReXekCJqSkPF6Ohim0hgtjPWWtYpVOKBpiGvZttWfxeX98pzfcRLIk+/hMlw8dLlB03up7
 cXLV9OMJUKSAnCLUnfV51PumC9Sgb5sxnd4DZG0G93bfA5ZeDswTiAERXDWbitSGoRruyMsf621
 5NooVc/FsAKI1tmhXAwpwdH/eHmawhO79WVJxCviXzBbzusouChZDrcK9StKBNKFJDpzX5msh2S
 3Njh43Nyz0ty94miCoMFsDBC0S5hJ36X9QKryUlRNaVK7F0efksibQ6BOyffTAM1ksuymrs6LKT
 BMu4MJyB3hSfAc7BnDLYWO1mjHzYdkJsYaDDztKPYrLCmDU2wJszPLDdFzBvVonl0PsUOsdgnMw
 uYvLugLP8lWoSC31VRZVGW4DT4jZqulyQ81qq0Fi4LDRskYS5WTac4SA==
X-Received: by 2002:a05:7022:6b85:b0:136:959a:abf2 with SMTP id
 a92af1059eb24-1398f66b4d2mr1836851c88.2.1781709711604; 
 Wed, 17 Jun 2026 08:21:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b916b2bsm16168870c88.6.2026.06.17.08.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:21:51 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:21:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260617082148.0030de4c@phoenix.local>
In-Reply-To: <20260617082828.1058127-1-wang.junlong1@zte.com.cn>
References: <20260606063226.491848-1-wang.junlong1@zte.com.cn>
 <20260617082828.1058127-1-wang.junlong1@zte.com.cn>
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

On Wed, 17 Jun 2026 16:28:23 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

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
> Junlong Wang (4):
>   net/zxdh: fix queue enable intr issues
>   net/zxdh: optimize queue structure to improve performance
>   net/zxdh: optimize Rx recv pkts performance
>   net/zxdh: optimize Tx xmit pkts performance
>=20
>  drivers/net/zxdh/zxdh_ethdev.c     |  81 ++---
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  23 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   4 +
>  drivers/net/zxdh/zxdh_pci.c        |   2 +-
>  drivers/net/zxdh/zxdh_queue.c      |  11 +-
>  drivers/net/zxdh/zxdh_queue.h      | 122 ++++---
>  drivers/net/zxdh/zxdh_rxtx.c       | 529 ++++++++++++++++++++++-------
>  drivers/net/zxdh/zxdh_rxtx.h       |  27 +-
>  8 files changed, 539 insertions(+), 260 deletions(-)
>=20

I thought this was better, but AI found one new bug.
Also, if the driver wants headroom in mbuf and headroom typically
is set from rte_pktmbuf_alloc, a good defensive in depth.

Something like:
static_assert(RTE_PKTMBUF_HEADROOM >=3D ZXDH_DL_NET_HDR_SIZE,
	"RTE_PKTMBUF_HEADROOM too small for zxdh Tx downlink header");

You still need the check in transmit, but this would protect
against user misconfiguration.

Not sure why you needed to open code rte_pktmbuf_prepend() which
has the check that AI wants you to have


Series review: net/zxdh Rx/Tx optimization (v6)

Patches 1-3 are unchanged from v5 and remain good. The v5 issue in the
simple Tx path (leaked mbuf and unpublished descriptor on the
pkt_padding failure branch) is resolved: pkt_padding() no longer
returns a failure, so there is no skip/continue and no ring gap. The
way it was made infallible introduces a new problem.


[PATCH v6 4/4] net/zxdh: optimize Tx xmit pkts performance

Error: pkt_padding() writes the downlink header in place without
checking that the mbuf has hdr_len bytes of headroom, so a packet with
short headroom causes an out-of-bounds write and a data_off underflow.

	hdr =3D rte_pktmbuf_mtod_offset(cookie, struct zxdh_net_hdr_dl *, -hdr_len=
);
	memcpy(hdr, net_hdr_dl, hdr_len);

	/* Update mbuf to reflect the prepended header */
	cookie->data_off -=3D hdr_len;
	cookie->data_len +=3D hdr_len;
	cookie->pkt_len  +=3D hdr_len;

This open-codes rte_pktmbuf_prepend() but drops its headroom check. If
cookie->data_off < hdr_len, the mtod_offset pointer lands before
buf_addr and the rte_memcpy scribbles over the mbuf's private area or
the preceding memory; cookie->data_off (uint16_t) then underflows to a
large value. v4/v5 used rte_pktmbuf_prepend() here, which returns NULL
when headroom is short, so this is a regression: a checked-but-mishandled
case became an unchecked memory corruption.

Nothing upstream of the simple path guarantees the headroom. The simple
Tx burst is selected solely on RTE_ETH_TX_OFFLOAD_MULTI_SEGS being
disabled, which is independent of headroom, and tx_prepare()'s
dl_net_hdr_check() only validates offload capability, not headroom. The
driver itself shows the headroom cannot be assumed: the packed path
gates the in-place prepend on

	txm->data_off >=3D ZXDH_DL_NET_HDR_SIZE

(zxdh_xmit_pkts_packed, the can_push test) and falls back to
zxdh_xmit_enqueue_append(), which copies the header into the reserved
txr region instead of prepending. The simple path has no equivalent
guard.

Restore a headroom check before the in-place prepend. For a
short-headroom packet, fall back to the append path that copies the
header into the reserved region (as the packed path does) rather than
writing before the buffer.

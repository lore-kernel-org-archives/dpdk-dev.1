Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE08CCD8C8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Jun 2026 18:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D975E402AD;
	Sun,  7 Jun 2026 20:00:05 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 0641F40278
 for <dev@dpdk.org>; Sun,  7 Jun 2026 20:00:05 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304df7ff4c2so2822319eec.0
 for <dev@dpdk.org>; Sun, 07 Jun 2026 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780855204;
 x=1781460004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDRbVVBv8my4EsHhkG9L3DtmhulC+DblvI350dfyRkw=;
 b=uuzzbWUJX9pDHGsPYUwl1ibAvoFEtlWk/k69JI58yXYlRFj2BfvAdewFAtdse3SPkp
 MPRwnLb6BwOyjggtLOci+9qQb3aynQqN6DnEmeuzczOTn1E5B2CS+cd9NC/TmFzTnP8W
 c5soBiG2P6E85nGD6C5TGj1Sbc1jHy9/CjCtEAGwwhhLsg63pMJqKNSly7GXaTmID8QN
 f2nPNGcuZpoTt1Py4jSbvdbGyArhV3rQlk9flXqG+vl/S7rvl2nBbfHkK5ImHepQqpRG
 Juw23n2R8fdsZFt8B5/BEGStdPfsjjrTmzBXB1I7uI6kM21FqCO9G9mFmTqIqllv8q/6
 w7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780855204; x=1781460004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KDRbVVBv8my4EsHhkG9L3DtmhulC+DblvI350dfyRkw=;
 b=D9BpUnNE+OlkNvEMfu0v6NMINc2tXnsu6lpOazgVHB/3Pzl8K6/Y5gufGrVG2ASyb3
 fXMEb/JVLbUUN2xieKTYXLtwyuAHaJzMmcN3orQSAk5eToHpGyMEWyMECVO6z+F1dL0M
 h1fNV6thtvluL+2PuQhGLIKyTRgNOZygVHQLZmi0Vf2KpjvRojAwrCTbaTBjsHJlJw/3
 vUwiifK8xQMRRa44twJMRJDw7AvELuypXhHER6G4pqLQRSX7klRGOzHpIpYDD93pPTw4
 jKoOmWQKUz2L3VrZKlmn+ng8N/COYnIJUELoHhKOiHCfveQ33RHFOux8j56NgOTeqDte
 bazA==
X-Gm-Message-State: AOJu0YzA+rf3/BtL3DP4czxBmKWVrxeo+o6P1u9mor+q1XlpMa+ABWRD
 81kSBPUZ2GJinnMM9hTF2vufJjh2s7qVzDBXY6PFZVlot2hPGs745FkjI5y0CE2aEm1hgcmq244
 8dlXP
X-Gm-Gg: Acq92OFkU1cQ3LWcvIFUrFv/mgkQlQTO5Tk6+ThUYzFtY0b2QvCsGBqqLik0Ap2n/wz
 0rH4i82ZsSpywtpM8wmKHkYqKYqxpxe5DoOe3nli/iv9gBNL0xDV0wNwedwgOF23eGA/TR7zXEp
 vIk8egS/IGR57+UyoOgDO99jNWUb+Bb/Ndwmtaa4QPL3kqyi6FzUAsgiRLHZPUf/+87y/bV0/Gc
 AQ2W7P0yRUJ96ywPYOdXaGHielc8hsgGqutMVRNpDgNWaPJLf7PJ2v6mc/6zxcelwjSpS8pc9ln
 Igc6sY/y8eBwGnG015WSwV1tDAA307f9Vb05JBdYgppy4x8yq15o1ij3Iq4zhW/5GbP29RIFMEm
 CkImlNaGsvrEFhHXkg7YUt9AI5ZXnAVRfnCuSfF0g/c1YTEYLtsfIlQrvvaIdcIZPW0U7Ch9Ecc
 HDazVVd5Wcs2VYy7MvWtaOtjJf3g0XRtyeM22AtCY0DUCXXLgQJkYM0xTc0QluYk66M1W6UHKfx
 tg1TUHo9xeFFQ==
X-Received: by 2002:a05:7300:dd48:b0:304:56fc:775 with SMTP id
 5a478bee46e88-3078016a29bmr3677302eec.21.1780855203702; 
 Sun, 07 Jun 2026 11:00:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30777ecf9e9sm9098093eec.28.2026.06.07.11.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 11:00:03 -0700 (PDT)
Date: Sun, 7 Jun 2026 11:00:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260607110001.170d66f9@phoenix.local>
In-Reply-To: <20260606063226.491848-1-wang.junlong1@zte.com.cn>
References: <20260509062930.3254766-1-wang.junlong1@zte.com.cn>
 <20260606063226.491848-1-wang.junlong1@zte.com.cn>
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

On Sat,  6 Jun 2026 14:32:21 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

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
>   net/zxdh: optimize queue structure to improve performance
>   net/zxdh: optimize Rx recv pkts performance
>   net/zxdh: optimize Tx xmit pkts performance
>   net/zxdh: fix queue enable intr issues
>=20
>  drivers/net/zxdh/zxdh_ethdev.c     |  81 ++---
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  23 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   4 +
>  drivers/net/zxdh/zxdh_pci.c        |   2 +-
>  drivers/net/zxdh/zxdh_queue.c      |  11 +-
>  drivers/net/zxdh/zxdh_queue.h      | 120 +++----
>  drivers/net/zxdh/zxdh_rxtx.c       | 534 ++++++++++++++++++++++-------
>  drivers/net/zxdh/zxdh_rxtx.h       |  27 +-
>  8 files changed, 543 insertions(+), 259 deletions(-)
>=20

Multiple issues reported by AI review. I ran in Claude to get better summar=
y.
That way it can look at progress across revisions in the series.

Series review: net/zxdh Rx/Tx optimization (v4)

The v3 issues are addressed: pkt_padding() now checks the
rte_pktmbuf_prepend() return for NULL, the simple-path statistics no
longer read past the end of tx_pkts on a ring wrap, and the
zxdh_queue_enable_intr() fix has been split into its own patch 4/4
with a Fixes: tag and Cc: stable. Remaining issues below.


[PATCH v4 2/4] net/zxdh: optimize Rx recv pkts performance

Error: zxdh_recv_single_pkts() does not compact rcv_pkts[] on a
mid-burst failure, so a freed mbuf can be returned to the application
and a valid mbuf can be leaked.

	for (i =3D 0; i < num; i++) {
		struct rte_mbuf *rxm =3D rcv_pkts[i];
		uint16_t len =3D lens[i];

		if (unlikely(zxdh_init_mbuf(rxm, len, hw, &vq->rxq) < 0))
			continue;
		zxdh_update_packet_stats(&rxvq->stats, rxm);
		nb_rx++;
	}

zxdh_init_mbuf() frees rxm on failure (num_buffers !=3D 1, or
data_len !=3D pkt_len). The loop then skips it via continue but never
writes the surviving mbufs down to rcv_pkts[nb_rx]. If packet i fails
and a later packet j > i succeeds, the valid mbuf stays at rcv_pkts[j]
while the caller is told only nb_rx packets are valid. The caller reads
rcv_pkts[0..nb_rx-1], which now includes the freed slot at index i
(use-after-free) and never sees the valid mbuf at index j (leak).

The companion zxdh_recv_pkts_packed() in this same file does it
correctly with rcv_pkts[nb_rx] =3D rxm. Mirror that here:

	if (unlikely(zxdh_init_mbuf(rxm, len, hw, &vq->rxq) < 0))
		continue;
	rcv_pkts[nb_rx] =3D rxm;
	zxdh_update_packet_stats(&rxvq->stats, rxm);
	nb_rx++;


[PATCH v4 3/4] net/zxdh: optimize Tx xmit pkts performance

Error: tx_bunch() and tx1() publish the descriptor AVAIL flag with no
store barrier, so the device may observe the AVAIL bit before addr/len
are visible and DMA from a stale address.

	for (i =3D 0; i < N_PER_LOOP; ++i, ++txdp, ++pkts) {
		txdp->addr =3D rte_mbuf_data_iova(*pkts);
		txdp->len =3D (*pkts)->data_len;
		txdp->id =3D start_id + i;
		txdp->flags =3D flags;		/* AVAIL bit, no rte_io_wmb */
	}

The packed ring requires the addr/len/id stores to be globally visible
before the flags store that sets the AVAIL bit. The rest of the driver
does this through zxdh_queue_store_flags_packed(), which issues
rte_io_wmb() before writing flags (used by the original
zxdh_enqueue_xmit_packed_fast() that this path replaces, and by
refill_que_descs() in patch 2/4). The direct txdp->flags =3D flags writes
here drop that barrier. volatile prevents only compiler reordering, not
hardware reordering on weakly-ordered architectures (arm, ppc), so this
is a real data race against the device.

Write addr/len/id for the batch, then a single rte_io_wmb(), then the
flags; or publish each flag through zxdh_queue_store_flags_packed().

Error: in submit_to_backend_simple(), a packet that fails pkt_padding()
is skipped for cookie tracking but its descriptor is still written and
published, and the mbuf leaks.

	for (j =3D 0; j < N_PER_LOOP; ++j) {
		m  =3D *(tx_pkts + i + j);
		if (unlikely(pkt_padding(m, hw) < 0)) {
			vq->txq.stats.errors++;
			continue;	/* cookie not set, m not freed */
		}
		(dxp + i + j)->cookie =3D (void *)m;
		zxdh_update_packet_stats(&vq->txq.stats, m);
	}
	/* writes ALL N_PER_LOOP descriptors, including the failed one */
	tx_bunch(vq, txdp + i, tx_pkts + i, id + i);

When pkt_padding() returns < 0 the mbuf has no prepended downlink
header, but tx_bunch() still writes its iova/len into the descriptor and
sets the AVAIL bit, so a header-less packet is handed to the device.
The matching vq_descx[].cookie is left unset, so the mbuf is never
freed (leak) and, if the slot holds a stale cookie from a prior use,
the next flush double-frees it. vq_avail_idx and the returned count are
also advanced by the full nb_pkts, counting the dropped packet as sent.

The leftover loop handles this correctly (it calls tx1() per packet,
inside the padding check). The main loop needs the same structure:
either build the descriptor per packet after a successful pkt_padding(),
or track which slots succeeded and only publish those.


[PATCH v4 4/4] net/zxdh: fix queue enable intr issues

Error: the fix does not enable interrupts; the condition is inverted
relative to the commit message.

	-	if (vq->event_flags_shadow =3D=3D ZXDH_RING_EVENT_FLAGS_DISABLE) {
	-		vq->event_flags_shadow =3D ZXDH_RING_EVENT_FLAGS_DISABLE;
	+	if (vq->event_flags_shadow =3D=3D ZXDH_RING_EVENT_FLAGS_ENABLE) {
	+		vq->event_flags_shadow =3D ZXDH_RING_EVENT_FLAGS_ENABLE;
			vq->vq_packed.ring.driver->desc_event_flags =3D vq->event_flags_shadow;
		}

ENABLE is 0x0 and DISABLE is 0x1. After a disable the shadow holds
DISABLE, which is the state from which the application re-arms the
interrupt via zxdh_dev_rx_queue_intr_enable(). With "=3D=3D ENABLE" the
body runs only when interrupts are already enabled; when the shadow is
DISABLE the test is false and nothing happens, so interrupts are still
never enabled. The body now writes ENABLE, but the guard prevents it
from ever running in the case that matters.

The commit message says "Change =3D=3D to !=3D", which is the correct fix,
but the diff changed the constant and kept =3D=3D. Mirror
zxdh_queue_disable_intr() (which uses !=3D DISABLE):

	if (vq->event_flags_shadow !=3D ZXDH_RING_EVENT_FLAGS_ENABLE) {
		vq->event_flags_shadow =3D ZXDH_RING_EVENT_FLAGS_ENABLE;
		vq->vq_packed.ring.driver->desc_event_flags =3D vq->event_flags_shadow;
	}

(Keeping the original "=3D=3D DISABLE" guard and only changing the body
assignment to ENABLE is also correct and is the minimal fix for the
original bug.)

Warning: this Cc: stable fix depends on patch 1/4, which moved
event_flags_shadow out of vq_packed. The diff context here is
vq->event_flags_shadow, but the stable branches still have
vq->vq_packed.event_flags_shadow, so this patch will not cherry-pick
cleanly. Consider making the fix standalone against the current field
name and placing it first in the series so it backports without the
reorganization.


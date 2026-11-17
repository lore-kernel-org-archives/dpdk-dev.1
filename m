Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E70606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=q6rFnMdW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F08E402CE;
	Tue, 17 Nov 2026 19:42:21 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 11DEC402C9
 for <dev@dpdk.org>; Tue, 17 Nov 2026 19:42:19 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2efe8f50697so428055ad.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794940938;
 x=1795545738; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vvl5tqGSnK/U+1bstU3W/tX70jCgIUl1N80Vojpeg7c=;
 b=q6rFnMdWcu0nmRrDOCGEyXAvkuLQL5Pp9HDt+oo2m347dPdpJ2i9Dc9aA+IaewdLqo
 2L06BgF3T0j2gZI67Aqmh8mPgNwjTJnKRfCPFfKe3v/RmG6h2I7vL/H/wGt6JBgPeh62
 e5YBhJ28YuoQkI8/aBmCYjmb5SUn73s5A2IaWKupNnPIGtdC5ONVJhniT9TMtu8viFYI
 eQyS2z5iJe7PkdeKxwMAKuNc/jLf4kosQaeV65Hjs12pJbLvzJ/mDSybbxZMxc7xT67P
 gQpp58w2sc2XZ0aB/DXBkC5nqzPTCucgFgDdlhhwpUheTSClUgPERl/POk4BiUuMhA/x
 TD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940938; x=1795545738;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vvl5tqGSnK/U+1bstU3W/tX70jCgIUl1N80Vojpeg7c=;
 b=0whVn1gTBqf+mPeHn3PGgGz+mynLJWzUiRcLVci7zA7MdY1NRhHS/jIpFEq4afIP4n
 yt9WvmFZhSyN8N7OIQtZsT+5CqRr8e1VdJBoaOdrTL7sLaMB26lsOM45AMUplh+wH4RC
 vdRBrhYRvM7OdTAZQokclloeEoJdQK1TWdD9pMleAZBS0BurCHoyNtppxBFxnwVlEjtj
 0DZKmdpTTfGQxc75mKEM8Yp0kgTkBDux1PcRIuEQpDpAlL8kpeNwLVLVI5/2JanzjpjZ
 fxfICIgEqVOQ5yDVuMBo+Y1AhL8BLEAnYbHpI0xYmpUNrXBBsDCjvc2EG1rXniqYePxY
 +PRg==
X-Gm-Message-State: APuU4Z+o9Y6ZxSb4k6vZqzvXShz/XX1yyvE7QjCt1+Ib6oV07pKOUED+
 st232d1eUfCNd8QbM3rgrC45JOwiR0UxAGCDfw5HDTGzMfR/tm/NNDNxyyHBauu9jwo=
X-Gm-Gg: AZFdTZekf8m5shqYia8Keqyp3/Ra4ifOuyt7jd4Yq7Jp1bftJDO5xMVNUtKGRbQ37dn
 S22o0rHyb9IEI38ggi6Zy+Q5yVLHgvhoCXsgUn9CSRDH5k7qdXwOzMidkFUuBldT+dbA/nTBgRP
 aav0ai7IZwREH6SdFd0YGKX8elygUDDr8x4Nl+KKTYH5QU/nAlcoWWCdmvgd9zNjfu/wGSOiia7
 xJ7wMOaX+NQwPsgXElcJvE5T8qMrL16QFk3tYqq4oszsL3lHAiW5ZanAQqSvyNXqFp98cbHYfE2
 +IYRu1bnArsOmsrN3nKcaJ3MSGKQDreI84nOGnEqSCQosNo69zh93Jeiappvo4KGKMfp8QgpqaE
 hngt9PmdV3YrCUOYSAUbtW70XjUHkzxrDDs+5nwbop2UjOKoCSaN971VmdqDtqLYBymdfTDIJMB
 oaeFhEJHoCzapBYnuF2hYMp2gvSe08Gs17ijbj+FPtlTM2Z0mWHxw/gkqLv3kt9ByXFGAg+/T4s
 PSHedX2LH2PH0VXMARZKW1310JgBlwGDoykteESmzMBIoJZ2XsIwmEU3dADZz7HD4YoQZOwJaYU
 g20/SYL8MhDL9rIB1qm8qkelxCSClo9XNI+YNGFF4otnAqKHrBFBdtURuqC0A3XsE1xoxNQSeA=
 =
X-Received: by 2002:a17:902:cecb:b0:2e9:660a:7946 with SMTP id
 d9443c01a7336-2eff7403ba9mr1709025ad.28.1794940938235; 
 Tue, 17 Nov 2026 10:42:18 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6236191sm1472115ad.53.2026.11.17.10.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:42:18 -0800 (PST)
Date: Tue, 17 Nov 2026 10:42:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kiran Patchala <kiran.patchala@oss.qualcomm.com>
Cc: dev@dpdk.org, Mohan Degalwade <mohan.degalwade@oss.qualcomm.com>
Subject: Re: [PATCH] net/stmmac: add PMD for Synopsys DWC EQoS (GMAC4)
Message-ID: <20261117104214.6b633507@phoenix.local>
In-Reply-To: <20261114145539.2470711-1-pkiran@qti.qualcomm.com>
References: <20261114145539.2470711-1-pkiran@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 20:25:39 +0530
Kiran Patchala <kiran.patchala@oss.qualcomm.com> wrote:

> From: Kiran Patchala <kiran.patchala@oss.qualcomm.com>
> 
> Add a new poll-mode driver for the Synopsys DesignWare Cores Enhanced
> Quality-of-Service (DWC EQoS / GMAC4, "stmmac") Ethernet MAC present.
> 
> The device is enumerated by the platform bus and bound to vfio-platform.
> The kernel recovery driver handles clock and PHY reset before the PMD
> takes over.
> 
> Driver features:
>  - One TX queue and one RX queue on DMA channel 0; single-segment mbufs
>    only; no TSO, PTP, or secondary process support.
>  - Non-coherent DMA: DC CVAC/CIVAC cache maintenance on arm64 for
>    descriptor and payload lines; no-op stubs on other architectures.
>  - Ethernet ops: configure, start, stop, close, link_update,
>    promiscuous enable/disable, mac_addr_set, stats_get, stats_reset,
>    dev_infos_get, rx/tx_queue_setup, rxq/txq_info_get.
> 
> Limitations:
>  - Single DMA channel (queue 0 only); no multi-queue support.
>  - Single-segment mbufs; scatter-gather, TSO and jumbo frames are not
>    supported.
>  - Tested on arm64 only.


Lots of things still need fixing before this is ready.
See AI review.

It is also generally preferable to split new driver across multiple patches
to allow for easier human review. AI doesn't seem to get overloaded.


Subject: Re: [PATCH] net/stmmac: add PMD for Synopsys DWC EQoS (GMAC4)

Thanks for the driver. Several correctness problems need fixing before
this can go in; most are in the non-coherent DMA handling and the
start/stop/close lifecycle.

Series-level:

The driver is named after the generic Synopsys IP but hardcodes the
Qualcomm RGMII IO macro, the TI DP83867 PHY, and 1G rgmii-id timing.
Either name it for what it supports (qcom ethqos) or split the board
specifics out so another dwmac4 integration can use it. The
has_emac_ge_3 devarg defaulting to 1 is a symptom of this; the layout
should come from the device (compatible string / HW version register),
not from the user.

The docs say a "Qualcomm stmmac recovery kernel driver" must be loaded
and stay loaded, but the device is bound to vfio-platform. Explain how
both coexist, and point to where that kernel module lives. A PMD that
depends on an out-of-tree kernel module is a hard sell.

Missing: doc/guides/nics/features/stmmac.ini, release notes entry,
MAINTAINERS entry.


Error
-----

1. Build breaks on every non-arm64 target.

stmmac_regs.h uses "dc cvac" / "dc civac" / "dsb sy" inline asm
unconditionally, and meson.build only checks is_linux. The commit
message and docs claim "no-op stubs on other architectures"; there are
none. No-op stubs would be wrong anyway for a non-coherent device.
Restrict the build:

  if not is_linux or arch_subdir != 'arm' or not dpdk_conf.get('RTE_ARCH_64')
      build = false
      reason = 'only supported on Linux arm64'
      subdir_done()
  endif

and fix the commit message and doc text.

2. Descriptor cache maintenance races with DMA write-back.

Descriptors are 16 bytes, four per 64-byte line. Ownership is per
descriptor but cache maintenance is per line. On RX, refill writes and
cleans (dc cvac) a line whose other descriptors may be DMA-owned and
being written back by the DMA at the same time. The clean writes the
CPU's stale copy of those neighbours (OWN=1, no length) over the DMA
write-back, losing received frames. TX has the same problem:
stmmac_tx_pkt_burst_nc() invalidates/cleans the line containing
'first', which can hold descriptors the DMA is still completing.

The kernel avoids this by putting rings in coherent (uncached) memory.
In DPDK the simplest fix is to make each descriptor occupy its own
cache line with the DSL (descriptor skip length) field in
DMA_CHAN_CONTROL bits 20:18, e.g. DSL=6 on a 64-bit bus gives a
64-byte stride, and index the ring in 64-byte steps. Alternatively,
only refill/post whole lines, but that does not help the TX side.

Also, stmmac_dcache_inval_line() follows dc civac with rte_io_rmb()
(dmb). The kernel's dcache_inval_poc uses dsb sy; use dsb here too.

3. TX ring can be filled completely, then the queue deadlocks.

The only full check is sw_ring[tail] != NULL, so the burst can post all
nb_desc slots. Then tail == tx_free and the doorbell value equals the
DMA's current descriptor, which the DMA treats as an empty ring.
stmmac_clean_tx_ring() stops at i == hwci, so nothing is ever
reclaimed. Keep one slot free:

	uint16_t avail = (txq->tx_free + txq->nb_desc - txq->tx_tail - 1)
			 % txq->nb_desc;
	nb_pkts = RTE_MIN(nb_pkts, avail);

4. Stop/start leaks mbufs and desyncs ring indices.

stmmac_rx_ring_setup() allocates nb_desc new mbufs on every dev_start
without freeing the ones from the previous start, and does not reset
rx_tail/rx_refill. stmmac_tx_ring_setup() does not free mbufs left in
sw_ring or reset tx_tail/tx_free, while the DMA soft reset puts the
hardware back at slot 0. "port stop 0; port start 0" in testpmd leaks
a ring's worth of mbufs and leaves TX/RX pointing at the wrong slots.
Free outstanding mbufs in dev_stop (after stopping the DMA), and reset
the indices in the ring setup functions. On allocation failure partway
through stmmac_rx_ring_setup() the mbufs already allocated also leak.

5. Double free of dev_private.

rte_eth_dev_release_port() frees dev->data->dev_private (and
mac_addrs) in the primary process. stmmac_platform_remove() and the
mac_addrs failure path in probe both rte_free(priv) first and then call
rte_eth_dev_release_port() with dev_private still set. Drop the
explicit rte_free(), or allocate with rte_eth_dev_create() which
handles this.

6. tx_burst returns short on a multi-segment mbuf.

A short return means "ring full, retry"; the application will resubmit
the same mbuf forever. Free it, count it in tx_errors, and continue.
Better, advertise no MULTI_SEGS offload and provide tx_pkt_prepare to
reject it there.

7. doc/guides/nics/index.rst uses a tab where the other entries use
spaces.


Warning
-------

8. RX checksum flags use the wrong bits.

In dwmac4 RDES1, bit 3 is the IP header error and bit 7 is the IP
payload (L4) checksum error. The driver ignores bit 3, reports bit 7 as
RTE_MBUF_F_RX_IP_CKSUM_BAD, and sets IP_CKSUM_GOOD for IPv6 which has
no header checksum. Suggested:

	uint32_t des1 = desc->des[1];

	if (des1 & RDES1_IPV4_HEADER)
		rxm->ol_flags |= (des1 & RDES1_IP_HDR_ERROR) ?
			RTE_MBUF_F_RX_IP_CKSUM_BAD :
			RTE_MBUF_F_RX_IP_CKSUM_GOOD;
	if ((des1 & (RDES1_IPV4_HEADER | RDES1_IPV6_HEADER)) &&
	    !(des1 & RDES1_IP_CSUM_BYPASSED))
		rxm->ol_flags |= (des1 & RDES1_IP_CSUM_ERROR) ?
			RTE_MBUF_F_RX_L4_CKSUM_BAD :
			RTE_MBUF_F_RX_L4_CKSUM_GOOD;

and advertise the L4 RX offloads if you report them. Also add
rte_io_rmb() after the OWN check so des[1] is not read ahead of des[3].

9. No check that a frame fits in one RX buffer.

If data_room - headroom is less than the max frame, the DMA splits the
frame across descriptors and each piece is delivered as a separate
packet; FD/LD are never checked. Reject such mempools in
rx_queue_setup, and drop anything without both FD and LD set.

10. MAC duplex and speed are never programmed.

The DMA soft reset clears GMAC_CONFIG, and nothing sets GMAC_CONFIG_DM
(full duplex) or PS/FES. The MAC runs half duplex on a full duplex
link. Set them from PHYSTS. The RGMII IO macro is likewise programmed
for 1G only; either handle 10/100 or document that only 1G works.

11. Link down reports 1G full duplex.

Use RTE_ETH_SPEED_NUM_NONE and leave duplex at half when link is down.

12. Every port gets MAC 02:02:02:02:02:02.

Read the address left in GMAC_ADDR_HIGH/LOW(0) by firmware, and fall
back to rte_eth_random_addr() if it is invalid.

13. No queue release ops; memzones never freed.

Without rx_queue_release/tx_queue_release, a second queue_setup (port
reconfigure) leaks the previous queue, its sw_ring and its mbufs. The
error paths in queue_setup leak the memzone, and close never frees
either memzone. Add the release ops and rte_memzone_free().

14. DMA addressing limit is not checked.

The descriptor and EAME setup assume 36-bit IOVAs, but with
vfio-platform in IOVA-as-VA mode addresses can be wider. Call
rte_mem_check_dma_mask() with the width from HW_FEATURE1 (ADDR64) at
probe.

15. Bad devargs are silently ignored.

If rte_kvargs_parse() or a handler fails, probe continues with
defaults. Fail the probe instead. mdio_addr > 31 is masked to a
different PHY address without warning.

16. RX tail register DMA_CHAN_OFF_RX_END_ADDR_HI (0x24) is not in the
dwmac4 register map; the kernel never writes it, and the TX path does
not use an equivalent. Drop it unless the databook documents it for
this core.

17. Secondary process: probe will fail in rte_eth_dev_allocate() with
a misleading -ENOMEM. Check rte_eal_process_type() and return a clear
-ENOTSUP.


Info
----

18. Leftovers: priv->stats (always zero), priv->link_speed,
txq/rxq->queue_id, tx_ring_full (counted, never reported),
STMMAC_ACTIVE_QUEUES, DMA_CONTROL_PBL_SHIFT/MASK (duplicated by
STMMAC_DMA_PBL_*), MTL_OP_MODE_TXQEN_MASK, DMA_CHAN_STATUS_TI/RI,
TDES2_INTERRUPT_ON_COMPLETION, TDES3_CONTEXT_TYPE,
RDES3_OVERFLOW_ERROR, RDES3_CRC_ERROR, DP83867_PHYCTRL, and the NULL
branches of stmmac_dma_chan_base()/stmmac_mtl_chan_base().

19. Redundant with ethdev: nb_desc == 0 defaulting and the TX % 4 check
(nb_align already enforced for both RX and TX), and setting
dev_started in start/stop.

20. default_rxportconf/default_txportconf use STMMAC_MAX_RING_SIZE
while STMMAC_DEFAULT_RING_SIZE (256) exists and the docs imply 256.

21. Count allocation failures in dev->data->rx_mbuf_alloc_failed (per
mbuf) rather than a private per-burst counter.

22. Reading CURTXD on every TX burst is an MMIO round trip; with
per-line descriptors (item 2) you can reclaim on the OWN bit instead.

23. GMAC_RXQ_CTRL0 uses magic 0x3/0x2; add defines. dev_rx/tx_offloads_sup
should be const.

24. Commit message: "Ethernet MAC present." is missing its object.
Docs: drop the "Contents summary" boilerplate, the em-dash in
Supported Platforms, and the --vdev="" in the testpmd example.

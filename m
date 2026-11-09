Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BE606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ae2b7xwU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 249D64028F;
	Mon,  9 Nov 2026 18:25:20 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 09AFC40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 18:25:17 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso10120245ad.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 09:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794245116;
 x=1794849916; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZZ+IVczwUlFNpxwTdRosRRlDJoCaRUmRq7R17RDMupo=;
 b=ae2b7xwU9feHyWPnfSIPFRDdm4pfYItnuVgFWRIi2DPjPCX3eAby3MXRgiBE//yqk+
 EGxvcgdZbMLC8soO5ZPO1SN/4BOuktW7v7DFp2l3eEd5JFrcHh+jl+/eH5v+W503q7pS
 Pcg/2NRkxeAA1gIDy8Nl8GWxx8RXK5AQwO7UqhZiM2qm0049w8OdlNaVTae0OeN0t1P8
 5rgHDsrxFfOK90nYAdl7t0TmDh7liqWtj+BecHcXv+vNSgvOWPmzbW1FH5u5/neOryh5
 Kgz1LarobQ01Qno/YZvAjDo8WRtOARh5jEoIV40e4Ly+KWaLZDdRx0RnIvnGq3DyJTZW
 Pdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245116; x=1794849916;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZZ+IVczwUlFNpxwTdRosRRlDJoCaRUmRq7R17RDMupo=;
 b=A8jzPPytU9+S1xatwAxiDBqp60z09HfKqhJCjnpIZUiKc49NnEiV1Y6gfx5qSFuZNX
 sRmWWVLQtj7WykFSp9K5UlMh8SeYRXWNfYCuv7dq23dVFwLlulD+IStuh93K1K7VljMI
 eaQlOMTQE0ZimXVpTHq4QJatj0JPS4nspiXgdx2hLljpB+Ve9f3/+GIwEknilhrA+Y8E
 t+YJdgabpaBAIsARaTp/DslYeMVwh6Ro/aZiHPADoM0VKaPACrGnQxLPNDwPpymUyxx3
 /3OkphfeHKFx7Nh/c+P+iwPkWlswAfsyVAQIMgvncPErQrRZ8Y5MI6xMzXwOmmepUCS5
 ZQQg==
X-Gm-Message-State: APuU4Z9VQ2j3wgJcy9hvej05Tfo2FN1lehKNCVlznn/wtHcnQ3fzt7wQ
 0Hye/QReASaJJmuDCdq7UvDXPqw45H/f6jLsL9pv7pW2bmdFh4A79FzIvxfEiW8F51E=
X-Gm-Gg: AYBFou1QmqazXvTlSlxotM37LRLPKBGTqlpWWsAGIwQ+1gIDfVI2p3niGXXFis/44p6
 DC8wljCxqG6dNegi96/n8ZxZKhCF9EoeYcVRyt0lk2/CYNOaAJhohBVssSCqUzgHh7auci6JOPm
 Mt5J21/6t1QbLPSaUm1Z4E50J+KJCD0rilL4i53WiFm4dZ5ZTPsYoexkHSZ09IwOVFsOlpGW669
 21vCOdatdeB15L/FbdfxvEwrWDoUUAwgWOFrEWaGib5NpICqIUk3xdblLbIuTeSxDNtzHZZzwGg
 4A2g6wINl9rcqjny1cCbq4KoU76+ZhZg/lutUydIMr71K6K7UOuyzRqHwn/hVIJDL9dR4zfZoKg
 +0+9q+8z/4UIQMyQRGrekF2OZWtWwKQ+5pYIMK7PLEriSYQLWkGfkrPtdMRZjeb2vxhyLcWm4r+
 lOXyzA30SLbSOkvIq0XphWfMX8edpCNgJ9gu19OKAtz7leD5c67bJOvsyoiPg59svKn5rEPLLw5
 gd/XDf6WU9+8ImMaKokiQHVIpJrV758utOQvX2FEbsnsixxs2nBH/2gtj5Dze6qmC+V6Yt8XxKd
 BYjFFepRChVHjTc2cqA96J6a0lKsiPzelzXuf1W7RwuKKWfdjjyR/QoqhsX/M98rDONVXkEn
X-Received: by 2002:a17:903:228e:b0:2ed:472:b9d6 with SMTP id
 d9443c01a7336-2ed833ee6d6mr53746755ad.2.1794245116057; 
 Mon, 09 Nov 2026 09:25:16 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6e1006asm532325ad.72.2026.11.09.09.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:25:15 -0800 (PST)
Date: Mon, 9 Nov 2026 09:25:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
Cc: dev@dpdk.org, ferruh.yigit@intel.com, rtice@cisco.com,
 cheryl.bansal@altera.com, nanditha.jayarajan@altera.com
Subject: Re: [RFC 0/4] net/mcdma: add Altera MCDMA poll mode driver
Message-ID: <20261109092513.59d8b647@phoenix.local>
In-Reply-To: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
References: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
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

On Tue, 10 Nov 2026 00:09:22 +0800
"Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com> wrote:

> This RFC series introduces a poll mode driver for Altera Multi-Channel
> Direct Memory Access (MCDMA) PCI devices. The driver exposes
> host-to-device and device-to-host descriptor queues as standard DPDK
> Ethernet ports for custom FPGA datapaths.
> 
> While the MCDMA IP supports multiple PFs and VFs per PF, this RFC
> implements single PF with multiple VFs; each function exposes multiple
> Rx/Tx queue pairs backed by H2D/D2H descriptor rings and per-queue
> QCSR.
> 
> User guide reference:
> https://docs.altera.com/r/docs/683821/25.3.1/multi-channel-dma-ip-for-pci-express-user-guide/before-you-begin
> 
> The series is split for review as follows:
>  1. Core driver skeleton, queue management, documentation, and features
>     matrix, excluding datapath bursts, debug dumps, and PIO APIs.
>  2. Rx and Tx packet burst handlers.
>  3. Experimental PIO BAR access APIs.
>  4. Experimental QCSR inspection and dump APIs.
> 
> Functional testing was performed on Linux with vfio-pci, using DPDK
> pktgen on a single PF and VF configuration. The attached user logic
> was adapted as needed for validation.
> 
> We would appreciate feedback on the ethdev design, the experimental
> PIO APIs, and PF/VF devargs.

Lots of feedback from AI review. Mostly it needs to be tested with testpmd
before review consideration. And you are too late for 26.11

Review: [RFC 0/4] net/mcdma: add Altera MCDMA poll mode driver

Applied on 26.11-rc2, builds clean with -Dwerror at each commit.
Post-apply sources read, not just diffs.

Series-level
------------

Target release. 26.11 is at rc2; a new driver lands in 27.03.
RTE_EXPORT_EXPERIMENTAL_SYMBOL(..., 26.11) in patches 3/4 should say
27.03, and the series needs a release notes entry in the 27.03 file.

PCI ID and PF/VF model (you asked about devargs). The ID table is
vendor 0x1172, device 0x0000, i.e. the Altera default IDs. Any
Altera design left at default IDs will probe as MCDMA. Whether a
function is PF or VF is decided by the presence of pf_index=, and a
VF needs parent_pf_idx= to find its channel count. The usual way to
do this in DPDK is distinct device IDs for PF and VF (and a real
device ID for the MCDMA IP); then is_pf comes from the match entry
and both devargs go away. A VF probed with no devargs at all
currently fails (see patch 1).

PMD-specific API (you asked about it). Patch 4 reimplements what
ethdev already has: eth_dev_ops.get_reg / rte_eth_dev_get_reg_info_ext()
gives named register dumps that testpmd and dpdk-proc-info already
consume. Implement .get_reg and drop rte_pmd_mcdma_qcsr_read/dump.
Patch 3 (PIO) has no generic equivalent, see notes there.

testpmd. mcdma.rst says the driver has not been tested with testpmd.
It should be before a non-RFC submission; it will exercise close,
stop, mtu set and secondary process paths that pktgen does not.


Patch 1/4: net/mcdma: add Altera MCDMA poll mode driver skeleton
----------------------------------------------------------------

Errors

1. No .dev_close in mcdma_ethdev_ops. rte_eth_dev_close() returns
   -ENOTSUP, so queues are never released; on remove,
   mcdma_eth_dev_uninit() only frees mac_addrs:

	static int mcdma_eth_dev_uninit(struct rte_eth_dev *dev)
	{
		rte_free(dev->data->mac_addrs);

   Every queue's memzone, sw_ring and struct mcdma_queue leak, and
   the HW queues stay enabled. Add:

	static int mcdma_dev_close(struct rte_eth_dev *dev)
	{
		uint16_t i;

		if (rte_eal_process_type() != RTE_PROC_PRIMARY)
			return 0;
		for (i = 0; i < dev->data->nb_rx_queues; i++)
			mcdma_dev_rx_queue_release(dev, i);
		for (i = 0; i < dev->data->nb_tx_queues; i++)
			mcdma_dev_tx_queue_release(dev, i);
		return 0;
	}

   and have uninit call it. rte_eth_dev_release_port() already frees
   mac_addrs, so uninit need not.

2. MTU read from dev_conf after configure:

	static uint16_t
	mcdma_dev_mtu_get(const struct rte_eth_dev *dev)
	{
		if (dev->data->dev_conf.rxmode.mtu != 0)
			return dev->data->dev_conf.rxmode.mtu;

   rxmode.mtu is the request consumed by configure; after that
   dev->data->mtu is authoritative and rte_eth_dev_set_mtu() only
   updates dev->data->mtu. mtu_set() works around this by writing
   dev->data->dev_conf.rxmode.mtu = mtu itself (line 744), which a
   PMD must not do. Delete mcdma_dev_mtu_get() and the rxmode.mtu
   store; use dev->data->mtu everywhere (ethdev initialises it to
   RTE_ETHER_MTU, so no fallback is needed).

3. Rx queue stop cannot succeed on an idle queue, and the release
   path frees buffers the HW still owns.

	static int mcdma_wait_queue_drain(struct mcdma_queue *q)
	{
		for (retry = 0; retry < MCDMA_CNT_HEAD_MOVE; retry++) {
			rte_rmb();
			if (q->cons_didx == q->prod_didx)
				return 0;

   For D2H, cons_didx only advances when packets arrive, so with
   buffers posted and no traffic this spins 1 s and returns
   -ETIMEDOUT. mcdma_quiesce_queue() returns before disabling or
   resetting the queue, rx_queue_stop() returns the error with the
   queue still STARTED, and dev_stop() fails. In
   mcdma_dev_queue_release_common() the failure is only logged and
   execution continues:

			mcdma_sw_ring_free_inflight(q);
		...
		mcdma_dev_descq_disable(q);

   so mbufs are freed while the queue is still enabled, then the
   queue is disabled. Fix: disable (Q_CTRL=0) and reset the queue
   first, then reclaim freed..prod unconditionally; only H2D needs
   a bounded drain wait before that, and it should fall through to
   disable+reset on timeout rather than return.

4. No secondary-process handling while mcdma.ini claims
   "Multiprocess aware = Y". mcdma_eth_dev_init() runs the same
   code in every process:

	priv->dev = dev;
	...
	ret = mcmda_parse_args(priv, pci_dev);
	...
	dev->data->mac_addrs = rte_zmalloc("mcdma", ...);

   A secondary overwrites the shared priv->dev with its own local
   rte_eth_dev pointer (dereferenced later by the primary in
   descq_free/queue_init), reprograms the VF weight CSRs, and
   replaces the shared mac_addrs pointer (leaking the primary's).
   Either add the standard early return for RTE_PROC_SECONDARY
   after setting burst pointers, or change the .ini to N. Also
   drop the dead `dev->data->dev_private = priv;`.

5. dpdk-devbind.py entry does not match the device the driver
   binds:

	+  {'Class': '06', 'Vendor': '8086', 'Device': '1172'},  # Altera FPGA

   The driver matches vendor 0x1172 device 0x0000; here 0x1172 is in
   the Device field with Intel's vendor ID, and class 06 is a bridge.
   Should be {'Class': <device class>, 'Vendor': '1172', 'Device':
   '0000'} (or the real device ID, see cover).

Warnings

6. BAR 0 is used before it is checked:

	priv->bar_base = pci_dev->mem_resource[MCDMA_CONFIG_BAR].addr;
	ret = mcmda_parse_args(priv, pci_dev);   /* writes VF weight CSRs */
	...
	PMD_DRV_LOG(INFO, "MCDMA RTL VERSION : 0x%x",
		    mcdma_dmacsr_reg_readl(priv->bar_base, MCDMA_CSR_VER_NUM));

   Return -ENODEV if mem_resource[0].addr == NULL (as is done for the
   PIO BAR).

7. Devargs handling is inverted:

	if (!devargs)
		return -EINVAL;
	kvlist = rte_kvargs_parse(devargs->args, mcdma_kvargs_keys);
	if (!kvlist)
		return 0;

   A device probed without -a (no devargs) fails probe; a device with
   a malformed or unknown key (rte_kvargs_parse() returns NULL) is
   accepted silently. Swap: no devargs is the VF default, NULL kvlist
   is -EINVAL.

8. ip_num_chan is taken from a 16-bit register field and never
   bounded, but drives the QCSR address:

	uint32_t qcsr_offset = (dir == MCDMA_DIR_H2D) ?
			       (MCDMA_QCSR_H2D_OFFSET + (q_id * MCDMA_QCSR_SIZE)) :
			       (q_id * MCDMA_QCSR_SIZE);

   For q_id >= 2048 a D2H queue's QCSR lands in the H2D region.
   MCDMA_MAX_CHAN_PER_FUNC (512) and MCDMA_QCSR_NUM_MAX_PER_DIR
   (2048) exist but are unused; clamp ip_num_chan to
   MCDMA_MAX_CHAN_PER_FUNC in dev_init.

9. Writeback target is a 16-bit field in the middle of the hot
   software state:

		volatile uint16_t freed_cons_didx;
		uint16_t prod_didx;
		volatile uint16_t cons_didx;
		uint16_t submitted_didx;
	...
	cons_idx = rte_mem_virt2iova((const void *)(uintptr_t)&q->cons_didx);

   Q_HEAD_POINTER / Q_COMPLETED_POINTER are 32-bit registers (error
   flag in bit 24). If the IP writes back the 32-bit register image,
   submitted_didx is clobbered on every completion. Independent of
   width, DMA writes into the same cache line as prod_didx and the
   stats cause ping-pong with the lcore polling the queue. Give the
   writeback its own cache-line-aligned uint32_t (or a slot in the
   descriptor memzone) and read the 16-bit index from it. The
   volatile on freed_cons_didx (SW-only) is noise.

10. Whole-IP reset from dev_configure():

	if (mcdma_dev->is_pf && !mcdma_dev->pf_idx) {
		mcdma_dmacsr_reg_writel(mcdma_dev->bar_base,
					MCDMA_CSR_SW_RESET, 0x1);
		rte_delay_ms(MCDMA_SW_RESET_DELAY_MS);

   dev_configure can be called repeatedly (every reconfigure), it
   blocks 1 s, and MCDMA_CSR_SW_RESET resets every function's queues,
   including VFs owned by other processes or VMs. Do this once at
   probe, or not at all; configure is not the place.

11. MMIO accessors reinvent rte_io.h and then pay for full fences:

	static inline uint32_t mcdma_reg_readl(volatile void *addr)
	{
		return *(volatile uint32_t *)addr;
	}
	...
	rte_wmb();
	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_TAIL_POINTER, hw_tail);

   Use rte_read32()/rte_write32()/rte_read64()/rte_write64(); they
   carry the required rte_io_*mb() (a compiler barrier on x86) and
   the explicit rte_wmb()/rte_rmb() (sfence/lfence on x86, in every
   burst) go away. Same for mcdma_pio_reg_read64/write64.

12. Const and namespace:

	size_t config_csr_offsets[MCDMA_MAX_CONFIGS] = {
	static struct rte_pci_id mcdma_pci_id_tbl[] = {
	static struct eth_dev_ops mcdma_ethdev_ops = {

   config_csr_offsets is an unprefixed exported global (static
   linking clash); make all three `static const`.

13. Debug output at ERR level in rx_queue_setup:

	if (mb_pool)
		PMD_DRV_LOG_DBG(ERR,
				"qid: %u, mbuf_avail_count = %u, mbuf_in_use_count = %u",

   MCDMA_LOG_ENABLE is hard-wired to 1 so this prints at ERR on every
   queue setup. Drop it, or use DEBUG level with plain PMD_DRV_LOG
   and remove the PMD_DRV_LOG_DBG/MCDMA_LOG_ENABLE pair.

14. mtu_set on a started queue updates rxq->rx_seg_len but
    Q_PAYLOAD_COUNT is only written from mcdma_dev_queue_init():

	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_PAYLOAD_COUNT, payload);

    If that register bounds the D2H transfer, a larger MTU set at
    runtime is not applied until the queue is restarted. Either
    reprogram it in mtu_set or return -EBUSY when any Rx queue is
    started.

15. didx numbering is inconsistent with its own comments:

	/* 16 bits - Monotonic index and IP requires it to start from 1 */
	uint16_t didx;
	...
	#define MCDMA_DIDX_NEXT(cur, num_descs) \
		((uint16_t)((((uint16_t)(cur) + 1) % (num_descs))))

    MCDMA_DIDX_NEXT yields 0..num_descs-1, so after num_descs
    descriptors the didx (and the tail pointer written to HW) is 0,
    which the comments and mcdma_hw_didx_to_ring() treat as "none".
    The unused mcdma_hw_didx_nudge() and MCDMA_RING_TO_HW_DIDX()
    implement 1..num_descs. One of the two schemes is wrong; pick
    one, document it, delete the other.

16. dev_info inconsistency:

	dev_info->max_rx_pktlen = MCDMA_MAX_RX_FRAME_LEN;   /* 0x1FFFFF */
	dev_info->max_mtu = MCDMA_MAX_MTU;                  /* 65535 */

    max_rx_pktlen should be max_mtu + MCDMA_RX_ETH_OVERHEAD.

17. Documentation does not match code:
    - mcdma.ini: "Runtime Rx queue setup" / "Runtime Tx queue setup"
      are not feature keys; default.ini has "Runtime queue setup".
      "Extended stats" is missing although xstats_get is implemented.
      "Multiprocess aware = Y" (see 4).
    - mcdma.rst: build option is -Denable_drivers=net/altera/mcdma,
      not net/mcdma; says xstats are not implemented (they are);
      says SOF/EOF are tracked in an mbuf dynamic field (nothing in
      the code does; MCDMA_DESC_SOF/EOF are unused).
    - index.rst: mcdma inserted after memif; alphabetical is before.

Info

18. (uint32_t)log2(q->num_descs) uses libm on an integer power of
    two; rte_log2_u32(q->num_descs).

19. mac_addrs is left all-zero. Use rte_eth_random_addr() as the
    other DMA/virtual PMDs do; RTE_ETH_DEV_NOLIVE_MAC_ADDR does
    nothing without a mac_addr_set op.

20. mcdma_qcsr_read_ptr_errors() returns the state of two sticky
    bits (0..2) and stats_get adds it to ierrors/oerrors on each
    call, so the "counter" is a gauge that never clears.

21. vf_weight_parse_handler(): uint8_t weight_val = atoi(token)
    truncates (257 -> 1 passes the range check); use strtoul.
    Function name mcmda_parse_args() is a typo.

22. mcdma_dev_descq_free() looks the memzone up by name; keep the
    memzone pointer in struct mcdma_queue instead. q->qbuf_dma can
    be qzone->iova.

23. Leftovers, all unused: MCDMA_QCSR_Q(), MCDMA_MAX_PYLD_CNT,
    MCDMA_MAX_VF_PER_PF, MCDMA_IFC_DATA_WIDTH, MCDMA_MAX_CHAN,
    MCDMA_PREV_IDX, MCDMA_RING_AVAIL_COUNT, mcdma_queue_cons_ring(),
    mcdma_qcsr_reg_updatel(), mcdma_pio_reg_readl/writel(),
    priv->bam (assigned, never read), RTE_PCI_DEV_ID_DECL_XNIC
    macro defined inside the initialiser.


Patch 2/4: net/mcdma: add Rx and Tx packet burst paths
------------------------------------------------------

Errors

1. Heap allocation on every rx_burst:

	repl = rte_malloc_socket(NULL, q->burst_size * sizeof(*repl), 0,
				 q->socket_id);
	...
	rte_free(repl);

   rte_malloc takes the heap lock and this runs on every poll that
   refills. burst_size is fixed at MCDMA_MAX_BURST (32):

	struct rte_mbuf *repl[MCDMA_MAX_BURST];

Warnings

2. rte_mempool_avail_count() per poll:

	mb_avail = rte_mempool_avail_count(q->mb_pool);

   It walks every lcore cache (O(RTE_MAX_LCORE)) and is documented
   as not for the datapath. Just call rte_pktmbuf_alloc_bulk() (which
   also replaces the get_bulk + per-mbuf rte_pktmbuf_reset loop) and
   handle failure.

3. ERR log in the Rx hot path on mbuf exhaustion:

		q->rx_nombuf += batch;
		PMD_DRV_LOG(ERR, "No MBUFS, queue id = %u, nb_avail = %u, batch: %u, "

   Pool exhaustion is a steady state under load; this is a log
   storm. The counter is enough; if a message is wanted use
   RTE_LOG_DP_LINE.

4. Rx mbufs never get m->port:

	mb->pkt_len = d->rx_pyld_cnt;
	rte_pktmbuf_data_len(mb) = d->rx_pyld_cnt;

   Add mb->port = q->ethdev->data->port_id (cache port_id in the
   queue rather than chasing ethdev).

Info

5. The "nudge" branch in mcdma_descq_queue_submit() is unreachable:
   both callers only submit when prod_didx != submitted_didx, and
   ring_avail() reserves a slot so a full wrap cannot make them
   equal. Remove it (and the `volatile uint16_t qhead` local, and
   the 100000-iteration busy loop without delay).

6. mcdma_desc_slots_for_segs()/mcdma_desc_segs_for_slots() read
   d->link from the descriptor ring to locate link slots. Link slots
   are at (idx & 127) == 127 by construction; compute instead of
   touching DMA memory.

7. Write-only fields: q->processed_cur, q->ring_avail,
   q->ring_to_submit, q->complete. Remove.

8. In mcdma_descq_queue_prepare(): the seg_len > MCDMA_IP_MAX_FRAME_LEN
   clamp is dead (data_len is uint16_t); `if (mb->nb_segs == 0) break;`
   returns short on a corrupt mbuf, which the caller will resend
   forever. Drop both.


Patch 3/4: net/mcdma: add experimental PIO access APIs
------------------------------------------------------

Info

1. Each 64-bit access does rte_eth_dev_is_valid_port() + strcmp on
   the driver name + bounds check. An application polling user-logic
   registers will not want that per access. Consider instead a
   one-time rte_pmd_mcdma_pio_bar_get(port_id, void **addr, size_t
   *len) and let the caller use rte_read64/rte_write64, or at least
   add 32-bit variants; most AVMM user logic is 32-bit.

2. MCDMA_PIO_BAR is hard-wired to BAR 2 while the BAM BAR is a
   devarg. Either both configurable or both fixed.

3. Symbol version 26.11 -> 27.03 (see cover).


Patch 4/4: net/mcdma: add experimental QCSR dump APIs
-----------------------------------------------------

Warnings

1. Replace rte_pmd_mcdma_qcsr_read()/dump() with eth_dev_ops.get_reg.
   rte_eth_dev_get_reg_info_ext() supports a filter string and
   register names, so "show port <n> regs" in testpmd and
   dpdk-proc-info give the same dump with no PMD-specific header.
   The SW indices (prod/cons/freed/submitted) can be exposed as
   pseudo-registers or dropped; exposing struct mcdma_queue internals
   through an installed header (struct rte_pmd_mcdma_qcsr) ties ABI
   to driver internals.

Info

2. mcdma_qcsr_regs_read() reads the SW indices unsynchronised with
   the polling lcore; fine for a debug dump, but the rte_rmb() there
   buys nothing.

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB91FCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 03:58:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FB234065A;
	Wed, 14 Oct 2026 05:57:57 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0D974402F0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 05:57:52 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E4691200136;
 Wed, 14 Oct 2026 05:57:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 86F9B20012F;
 Wed, 14 Oct 2026 05:57:51 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F26131800068;
 Wed, 14 Oct 2026 11:57:50 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	fengchengwen@huawei.com
Cc: hemant.agrawal@nxp.com, Gagandeep Singh <g.singh@nxp.com>,
 Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v6 4/5] dma/imx_edma5: add data path
Date: Wed, 14 Oct 2026 09:27:45 +0530
Message-Id: <20261014035746.509685-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261014035746.509685-1-g.singh@nxp.com>
References: <20261013065127.102157-1-g.singh@nxp.com>
 <20261014035746.509685-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add the memory-to-memory data path for the eDMA5 dmadev.

The eDMA5 exposes a single transfer control descriptor and a single
completion flag per hardware channel, so jobs are serialised in software.
Each enqueued job is played out synchronously as one or more single-block
transfers: the per-channel TCD is programmed, the transfer is
software-started and the driver busy-waits for the DONE flag with a
wall-clock bounded timeout. Scatter-gather copies walk the source and
destination segment lists as two cursors, emitting one single-block
sub-transfer per iteration that fits both current segments.

As the eDMA5 is a non-coherent bus master, source and destination buffers
are cleaned from the CPU cache before a transfer and the destination is
invalidated after completion so the application observes the DMA result.

This adds copy, copy_sg, submit, completed, completed_status and
burst_capacity, wired through the device fast-path object.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 doc/guides/dmadevs/imx_edma5.rst         |   9 +
 drivers/dma/imx_edma5/imx_edma5_dmadev.c | 602 +++++++++++++++++++++++
 drivers/dma/imx_edma5/imx_edma5_dmadev.h |  15 +
 drivers/dma/imx_edma5/imx_edma5_logs.h   |   6 +
 4 files changed, 632 insertions(+)

diff --git a/doc/guides/dmadevs/imx_edma5.rst b/doc/guides/dmadevs/imx_edma5.rst
index f57881816e..de7c49101e 100644
--- a/doc/guides/dmadevs/imx_edma5.rst
+++ b/doc/guides/dmadevs/imx_edma5.rst
@@ -58,3 +58,12 @@ Limitations
   independently and programs one hardware transfer per consumed segment;
   full TCD scatter-gather linking is not yet implemented.
 - The driver operates in poll mode only; completion interrupts are not used.
+- Each operation executes synchronously: the driver programs the TCD,
+  starts the channel and busy-waits for completion inside the enqueue or
+  submit call. No transfer-offload benefit over memcpy is provided by this
+  first revision; the synchronous model is documented rather than implied.
+- Cache maintenance (source clean, destination clean+invalidate) is skipped
+  for any address that cannot be resolved to a CPU virtual address via
+  ``rte_mem_iova2virt()``. This affects externally-allocated memory not
+  registered with DPDK. Applications using such memory must ensure cache
+  coherency independently or register the memory with DPDK.
diff --git a/drivers/dma/imx_edma5/imx_edma5_dmadev.c b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
index ac8c694332..1e3c410c24 100644
--- a/drivers/dma/imx_edma5/imx_edma5_dmadev.c
+++ b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
@@ -22,6 +22,7 @@
 #include "imx_edma5_logs.h"
 
 RTE_LOG_REGISTER_DEFAULT(imx_edma5_logtype, INFO);
+RTE_LOG_REGISTER_SUFFIX(imx_edma5_dp_logtype, dp, INFO);
 
 /* Compatible string for i.MX95 eDMA5 device tree nodes. */
 #define IMX_EDMA5_COMPAT		"fsl,imx95-edma5"
@@ -204,6 +205,7 @@ imx_edma5_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	vc->tcd_regs = vc->ch_regs + IMX_EDMA5_CH_TCD_OFF;
 	vc->nb_desc = conf->nb_desc;
 	vc->desc_mask = conf->nb_desc - 1;
+	vc->iova_is_va = (rte_eal_iova_mode() == RTE_IOVA_VA);
 
 	vc->jobs = rte_zmalloc_socket("imx_edma5_jobs",
 			vc->nb_desc * sizeof(struct imx_edma5_job),
@@ -305,6 +307,599 @@ imx_edma5_close(struct rte_dma_dev *dev)
 	return 0;
 }
 
+/*
+ * Encode the largest natural transfer size (SSIZE/DSIZE) usable for a given
+ * source, destination and length. The address must be aligned to the transfer
+ * size and the byte count must be a multiple of it.
+ */
+static uint16_t
+imx_edma5_calc_attr(uint64_t src, uint64_t dst, uint32_t len)
+{
+	uint32_t sz = IMX_EDMA5_TCD_SIZE_1B;
+
+	if (((src | dst | len) & 0x1F) == 0)
+		sz = IMX_EDMA5_TCD_SIZE_32B;
+	else if (((src | dst | len) & 0xF) == 0)
+		sz = IMX_EDMA5_TCD_SIZE_16B;
+	else if (((src | dst | len) & 0x7) == 0)
+		sz = IMX_EDMA5_TCD_SIZE_8B;
+	else if (((src | dst | len) & 0x3) == 0)
+		sz = IMX_EDMA5_TCD_SIZE_4B;
+	else if (((src | dst | len) & 0x1) == 0)
+		sz = IMX_EDMA5_TCD_SIZE_2B;
+
+	return IMX_EDMA5_TCD_ATTR_SSIZE(sz) | IMX_EDMA5_TCD_ATTR_DSIZE(sz);
+}
+
+/*
+ * Program the channel TCD for a single-block copy: one minor loop of "len"
+ * bytes with a major count of 1. Completion is polled via CH_CSR.DONE.
+ */
+static inline void
+imx_edma5_program_copy(struct imx_edma5_vchan *vc, uint64_t src, uint64_t dst,
+		       uint32_t len)
+{
+	uint8_t *tcd = vc->tcd_regs;
+	uint16_t attr = imx_edma5_calc_attr(src, dst, len);
+
+	imx_edma5_write64(tcd, IMX_EDMA5_TCD_SADDR, src);
+	imx_edma5_write64(tcd, IMX_EDMA5_TCD_DADDR, dst);
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_ATTR, attr);
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_SOFF,
+			  (uint16_t)(1u << IMX_EDMA5_TCD_ATTR_GET_SSIZE(attr)));
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_DOFF,
+			  (uint16_t)(1u << IMX_EDMA5_TCD_ATTR_GET_DSIZE(attr)));
+	imx_edma5_write32(tcd, IMX_EDMA5_TCD_NBYTES, len);
+	imx_edma5_write64(tcd, IMX_EDMA5_TCD_SLAST, 0);
+	imx_edma5_write64(tcd, IMX_EDMA5_TCD_DLAST_SGA, 0);
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_CITER, 1);
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_BITER, 1);
+	/* Clear CSR so no scatter-gather link is followed. */
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_CSR, 0);
+}
+
+/* Fill an in-memory hardware TCD64 descriptor for one copy segment. */
+static inline void
+imx_edma5_fill_tcd(struct imx_edma5_hw_tcd64 *t, uint64_t src, uint64_t dst,
+		   uint32_t len)
+{
+	uint16_t attr = imx_edma5_calc_attr(src, dst, len);
+	uint16_t soff = (uint16_t)(1u << IMX_EDMA5_TCD_ATTR_GET_SSIZE(attr));
+	uint16_t doff = (uint16_t)(1u << IMX_EDMA5_TCD_ATTR_GET_DSIZE(attr));
+
+	t->saddr = rte_cpu_to_le_64(src);
+	t->soff = rte_cpu_to_le_16(soff);
+	t->attr = rte_cpu_to_le_16(attr);
+	t->nbytes = rte_cpu_to_le_32(len);
+	t->slast = 0;
+	t->daddr = rte_cpu_to_le_64(dst);
+	t->dlast_sga = 0;
+	t->doff = rte_cpu_to_le_16(doff);
+	t->citer = rte_cpu_to_le_16(1);
+	t->csr = 0;
+	t->biter = rte_cpu_to_le_16(1);
+}
+
+static inline void
+imx_edma5_hw_start(struct imx_edma5_vchan *vc)
+{
+	uint16_t csr = imx_edma5_read16(vc->tcd_regs, IMX_EDMA5_TCD_CSR);
+
+	csr |= IMX_EDMA5_TCD_CSR_START;
+	imx_edma5_write16(vc->tcd_regs, IMX_EDMA5_TCD_CSR, csr);
+}
+
+/*
+ * Invalidate the CPU cache lines covering a completed job's destination(s) so
+ * the application reads the DMA result rather than stale cache. The lines were
+ * cleaned at enqueue time, so this clean+invalidate behaves as a pure
+ * invalidate.
+ */
+static inline void
+imx_edma5_job_invalidate_dst(struct imx_edma5_vchan *vc,
+			      struct imx_edma5_job *job)
+{
+	if (job->nb_sg > 0) {
+		uint16_t s;
+
+		for (s = 0; s < job->nb_sg; s++) {
+			rte_iova_t da = rte_le_to_cpu_64(job->sg_tcd[s].daddr);
+			uint32_t len = rte_le_to_cpu_32(job->sg_tcd[s].nbytes);
+			void *va = imx_edma5_iova_to_virt(da, vc->iova_is_va);
+
+			if (va != NULL)
+				imx_edma5_cache_inval(va, len);
+		}
+	} else if (job->dst_va != NULL) {
+		imx_edma5_cache_inval(job->dst_va, job->len);
+	}
+}
+
+/*
+ * Upper bound on how long to poll for an entire job to complete.
+ * A wall-clock deadline is computed once per job in imx_edma5_run_job()
+ * and passed to every sub-transfer wait, so the bound covers the whole job
+ * rather than each sub-transfer individually.
+ * Each single-block transfer is capped at IMX_EDMA5_MAX_NBYTES (1 GiB - 1);
+ * at an AXI bus rate of 2 GB/s that is 512 ms in the worst case, so
+ * 1000 ms is a safe ceiling while still bounding a wedged channel.
+ */
+#define IMX_EDMA5_WAIT_TIMEOUT_MS	1000
+
+/*
+ * Wait for the single register TCD transfer to finish and clear its latched
+ * status. Returns true on success, false on a logged channel error (CH_ES.ERR)
+ * or timeout. The per-transfer completion flag CH_CSR.DONE and the CH_ES error
+ * bit are both write-1-to-clear.
+ */
+static inline bool
+imx_edma5_wait_done(struct imx_edma5_vchan *vc, uint64_t deadline)
+{
+	do {
+		uint32_t ch_es = imx_edma5_read32(vc->ch_regs, IMX_EDMA5_CH_ES);
+		uint32_t ch_csr;
+
+		if (ch_es & IMX_EDMA5_CH_ES_ERR) {
+			imx_edma5_write32(vc->ch_regs, IMX_EDMA5_CH_ES,
+					  IMX_EDMA5_CH_ES_ERR);
+			/* Reset the errored channel before the next job reuses it. */
+			imx_edma5_reset_hw_chan(vc);
+			return false;
+		}
+
+		ch_csr = imx_edma5_read32(vc->ch_regs, IMX_EDMA5_CH_CSR);
+		if (ch_csr & IMX_EDMA5_CH_CSR_DONE) {
+			imx_edma5_write32(vc->ch_regs, IMX_EDMA5_CH_CSR,
+					  IMX_EDMA5_CH_CSR_DONE);
+			return true;
+		}
+	} while (rte_get_timer_cycles() < deadline);
+
+	IMX_EDMA5_DP_LOG(ERR,
+		      "channel %u timed out waiting for DONE (CH_CSR=0x%08x "
+		      "CH_ES=0x%08x)",
+		      vc->hw_chan,
+		      imx_edma5_read32(vc->ch_regs, IMX_EDMA5_CH_CSR),
+		      imx_edma5_read32(vc->ch_regs, IMX_EDMA5_CH_ES));
+
+	/*
+	 * Reset the channel registers to a known idle state. Note that this does
+	 * not cancel an in-flight DMA transfer: the eDMA5 has no software-
+	 * accessible abort/cancel bit (MP_CSR.CX does not exist on this
+	 * variant). A channel that is genuinely stuck continues its bus
+	 * transaction; reprogramming it here races with the active transfer.
+	 */
+	imx_edma5_reset_hw_chan(vc);
+	return false;
+}
+
+/*
+ * Execute one job to completion on the channel's single register TCD.
+ *
+ * The eDMA5 exposes a single TCD and a single completion flag per channel, so
+ * jobs are serialised in software: a job is run synchronously here (program the
+ * TCD, software-start, busy-wait for DONE) and its completion recorded in
+ * job->done for the completion API to reap. Scatter-gather segments are played
+ * out one at a time as single-block transfers, since the eDMA5 does not
+ * auto-advance a hardware TCD chain for software-started mem-to-mem transfers.
+ * On success the destination cache lines are invalidated (non-coherent master).
+ */
+static inline void
+imx_edma5_run_job(struct imx_edma5_vchan *vc, struct imx_edma5_job *job)
+{
+	bool ok = true;
+	/*
+	 * Compute a single deadline for the entire job before entering the
+	 * sub-transfer loop. Passing it to every imx_edma5_wait_done() call
+	 * means the timeout budget is shared across all sub-transfers rather
+	 * than reset to a fresh 1000 ms per sub-transfer.
+	 */
+	uint64_t deadline = rte_get_timer_cycles() +
+		(rte_get_timer_hz() * IMX_EDMA5_WAIT_TIMEOUT_MS) / 1000;
+
+	if (job->nb_sg > 0) {
+		uint16_t s;
+
+		for (s = 0; s < job->nb_sg; s++) {
+			uint64_t src = rte_le_to_cpu_64(job->sg_tcd[s].saddr);
+			uint64_t dst = rte_le_to_cpu_64(job->sg_tcd[s].daddr);
+			uint32_t len = rte_le_to_cpu_32(job->sg_tcd[s].nbytes);
+
+			imx_edma5_program_copy(vc, src, dst, len);
+			imx_edma5_hw_start(vc);
+			if (!imx_edma5_wait_done(vc, deadline)) {
+				ok = false;
+				break;
+			}
+		}
+	} else {
+		imx_edma5_program_copy(vc, job->src_iova, job->dst_iova,
+				       job->len);
+		imx_edma5_hw_start(vc);
+		ok = imx_edma5_wait_done(vc, deadline);
+	}
+
+	if (ok)
+		imx_edma5_job_invalidate_dst(vc, job);
+
+	job->error = ok ? 0 : 1;
+	job->done = 1;
+	vc->submitted_count++;
+}
+
+static int
+imx_edma5_copy(void *dev_private, uint16_t vchan, rte_iova_t src,
+	       rte_iova_t dst, uint32_t length, uint64_t flags)
+{
+	struct imx_edma5_dev *ed = dev_private;
+	struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+	struct imx_edma5_job *job;
+	uint16_t slot;
+
+	/* NBYTES = 0 is undefined on the eDMA5 and can wedge the channel. */
+	if (length == 0)
+		return -EINVAL;
+	/*
+	 * TCD_NBYTES bits 31:30 are SMLOE/DMLOE when minor-loop offsets are
+	 * enabled; writing a count larger than the 30-bit max would corrupt
+	 * those control bits. Reject oversized requests.
+	 */
+	if (length > IMX_EDMA5_MAX_NBYTES)
+		return -EINVAL;
+
+	/* Ring full? one slot is kept free to distinguish full from empty. */
+	if (vc->nb_enqueued >= (uint16_t)(vc->nb_desc - 1))
+		return -ENOSPC;
+
+	slot = vc->head;
+	job = &vc->jobs[slot];
+	job->ridx = vc->ridx;
+	job->submitted = 0;
+	job->done = 0;
+	job->error = 0;
+	job->nb_sg = 0;
+	job->len = length;
+	job->src_iova = src;
+	job->dst_iova = dst;
+	/*
+	 * rte_mem_iova2virt() returns NULL when the IOVA is not in the
+	 * memzone table (e.g. externally-allocated IOVA-contiguous memory not
+	 * registered with DPDK). Cache maintenance is silently skipped for such
+	 * addresses; callers are responsible for ensuring coherency in that case
+	 * or for registering the memory so a VA mapping is available.
+	 */
+	job->dst_va = imx_edma5_iova_to_virt(dst, vc->iova_is_va);
+
+	/*
+	 * Non-cache-coherent master: clean the source so the device reads the
+	 * CPU's latest writes, and clean the destination so a prior dirty line
+	 * cannot be written back over the DMA result (the destination is
+	 * invalidated after completion).
+	 */
+	{
+		void *src_va = imx_edma5_iova_to_virt(src, vc->iova_is_va);
+
+		if (src_va != NULL)
+			imx_edma5_cache_clean(src_va, length);
+		if (job->dst_va != NULL)
+			imx_edma5_cache_clean(job->dst_va, length);
+	}
+
+	/*
+	 * RTE_DMA_OP_FLAG_SUBMIT is equivalent to calling rte_dma_submit()
+	 * after this enqueue: advance the head to include the new job and then
+	 * run all pending (unsubmitted) jobs from tail to the new head in FIFO
+	 * order, matching the behaviour of imx_edma5_submit().
+	 */
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
+		uint16_t idx;
+
+		vc->head = (vc->head + 1) & vc->desc_mask;
+		vc->nb_enqueued++;
+
+		idx = vc->tail;
+		while (idx != vc->head) {
+			struct imx_edma5_job *j = &vc->jobs[idx];
+
+			if (!j->submitted) {
+				imx_edma5_run_job(vc, j);
+				j->submitted = 1;
+			}
+			idx = (idx + 1) & vc->desc_mask;
+		}
+
+		return vc->ridx++;
+	}
+
+	vc->head = (vc->head + 1) & vc->desc_mask;
+	vc->nb_enqueued++;
+
+	return vc->ridx++;
+}
+
+static int
+imx_edma5_copy_sg(void *dev_private, uint16_t vchan,
+		  const struct rte_dma_sge *src, const struct rte_dma_sge *dst,
+		  uint16_t nb_src, uint16_t nb_dst, uint64_t flags)
+{
+	struct imx_edma5_dev *ed = dev_private;
+	struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+	struct imx_edma5_hw_tcd64 *tcd;
+	struct imx_edma5_job *job;
+	uint16_t slot;
+	uint16_t s;
+	uint16_t si = 0, di = 0;	/* current source/destination seg index */
+	uint32_t s_off = 0, d_off = 0;	/* byte offset within current segment */
+	uint16_t nsg = 0;		/* sub-transfers produced so far */
+	uint64_t src_total = 0, dst_total = 0;
+
+	/*
+	 * The scatter-gather contract is a byte stream: the source and
+	 * destination lists may be segmented independently but their
+	 * concatenations are equal. The lists are walked as two cursors,
+	 * emitting one single-block sub-transfer per run that fits in both the
+	 * current source and destination segments. This yields at most
+	 * nb_src + nb_dst - 1 sub-transfers, which fit in IMX_EDMA5_SG_TCD_PER_JOB.
+	 */
+	if (nb_src == 0 || nb_dst == 0 ||
+	    nb_src > IMX_EDMA5_MAX_SGES || nb_dst > IMX_EDMA5_MAX_SGES) {
+		IMX_EDMA5_DP_LOG(ERR, "Unsupported SG shape src=%u dst=%u",
+			      nb_src, nb_dst);
+		return -EINVAL;
+	}
+
+	/* Ring full? one slot is kept free to distinguish full from empty. */
+	if (vc->nb_enqueued >= (uint16_t)(vc->nb_desc - 1))
+		return -ENOSPC;
+
+	slot = vc->head;
+	job = &vc->jobs[slot];
+	job->ridx = vc->ridx;
+	job->submitted = 0;
+	job->done = 0;
+	job->error = 0;
+
+	/* This job's dedicated slice of the in-memory TCD pool. */
+	job->sg_tcd = &vc->sg_tcd_pool[(size_t)slot * IMX_EDMA5_SG_TCD_PER_JOB];
+	tcd = job->sg_tcd;
+
+	/*
+	 * Clean every source and destination segment up front (non-coherent
+	 * master): the device must read current source data, and dirty
+	 * destination lines must be flushed before the transfer.
+	 */
+	for (s = 0; s < nb_src; s++) {
+		void *va = imx_edma5_iova_to_virt(src[s].addr, vc->iova_is_va);
+
+		src_total += src[s].length;
+		if (va != NULL)
+			imx_edma5_cache_clean(va, src[s].length);
+	}
+	for (s = 0; s < nb_dst; s++) {
+		void *va = imx_edma5_iova_to_virt(dst[s].addr, vc->iova_is_va);
+
+		dst_total += dst[s].length;
+		if (va != NULL)
+			imx_edma5_cache_clean(va, dst[s].length);
+	}
+
+	/* copy_sg requires equal total bytes on both lists; reject misuse. */
+	if (src_total != dst_total) {
+		IMX_EDMA5_DP_LOG(ERR,
+			      "SG byte count mismatch src=%" PRIu64
+			      " dst=%" PRIu64, src_total, dst_total);
+		return -EINVAL;
+	}
+
+	while (si < nb_src && di < nb_dst) {
+		uint32_t s_rem = src[si].length - s_off;
+		uint32_t d_rem = dst[di].length - d_off;
+		uint32_t len = RTE_MIN(s_rem, d_rem);
+
+		/*
+		 * TCD_NBYTES bits 31:30 are SMLOE/DMLOE; a sub-transfer that
+		 * spans more than IMX_EDMA5_MAX_NBYTES would corrupt those bits.
+		 * Individual segment lengths up to UINT32_MAX are permitted by
+		 * the dmadev API, so validate here rather than assume the caller
+		 * has split them.
+		 */
+		if (len > IMX_EDMA5_MAX_NBYTES) {
+			IMX_EDMA5_DP_LOG(ERR,
+				      "SG sub-transfer length %u exceeds "
+				      "TCD_NBYTES max %u",
+				      len, IMX_EDMA5_MAX_NBYTES);
+			job->nb_sg = 0;
+			return -EINVAL;
+		}
+
+		/* Skip zero-length segments without emitting a descriptor. */
+		if (len == 0) {
+			if (s_rem == 0) {
+				si++;
+				s_off = 0;
+			}
+			if (d_rem == 0) {
+				di++;
+				d_off = 0;
+			}
+			continue;
+		}
+
+		if (nsg >= IMX_EDMA5_SG_TCD_PER_JOB) {
+			IMX_EDMA5_DP_LOG(ERR,
+				      "SG produced too many sub-transfers "
+				      "(src=%u dst=%u)", nb_src, nb_dst);
+			/* Defensive: clear nb_sg so the abandoned slot is not reused. */
+			job->nb_sg = 0;
+			return -EINVAL;
+		}
+
+		imx_edma5_fill_tcd(&tcd[nsg], src[si].addr + s_off,
+				   dst[di].addr + d_off, len);
+		nsg++;
+
+		s_off += len;
+		d_off += len;
+		if (s_off == src[si].length) {
+			si++;
+			s_off = 0;
+		}
+		if (d_off == dst[di].length) {
+			di++;
+			d_off = 0;
+		}
+	}
+
+	/* No sub-transfer (all segments zero-length): NBYTES = 0 wedges eDMA5. */
+	if (nsg == 0) {
+		IMX_EDMA5_DP_LOG(ERR, "SG produced zero sub-transfers");
+		return -EINVAL;
+	}
+
+	job->nb_sg = nsg;
+
+	/*
+	 * RTE_DMA_OP_FLAG_SUBMIT is equivalent to calling rte_dma_submit()
+	 * after this enqueue: advance the head to include the new job and then
+	 * run all pending (unsubmitted) jobs from tail to the new head in FIFO
+	 * order, matching the behaviour of imx_edma5_submit().
+	 */
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT) {
+		uint16_t idx;
+
+		vc->head = (vc->head + 1) & vc->desc_mask;
+		vc->nb_enqueued++;
+
+		idx = vc->tail;
+		while (idx != vc->head) {
+			struct imx_edma5_job *j = &vc->jobs[idx];
+
+			if (!j->submitted) {
+				imx_edma5_run_job(vc, j);
+				j->submitted = 1;
+			}
+			idx = (idx + 1) & vc->desc_mask;
+		}
+
+		return vc->ridx++;
+	}
+
+	vc->head = (vc->head + 1) & vc->desc_mask;
+	vc->nb_enqueued++;
+
+	return vc->ridx++;
+}
+
+static int
+imx_edma5_submit(void *dev_private, uint16_t vchan)
+{
+	struct imx_edma5_dev *ed = dev_private;
+	struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+	uint16_t idx = vc->tail;
+
+	/* Run every enqueued-but-not-yet-submitted job to completion (FIFO). */
+	while (idx != vc->head) {
+		struct imx_edma5_job *job = &vc->jobs[idx];
+
+		if (!job->submitted) {
+			imx_edma5_run_job(vc, job);
+			job->submitted = 1;
+		}
+		idx = (idx + 1) & vc->desc_mask;
+	}
+
+	return 0;
+}
+
+/*
+ * Reap completed jobs from the software ring in FIFO order. Jobs run
+ * synchronously, so a submitted job's result is already in job->done/error.
+ * An unsubmitted job stops the walk.
+ */
+static uint16_t
+imx_edma5_completed(void *dev_private, uint16_t vchan, const uint16_t nb_cpls,
+		    uint16_t *last_idx, bool *has_error)
+{
+	struct imx_edma5_dev *ed = dev_private;
+	struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+	uint16_t count = 0;
+
+	*has_error = false;
+
+	while (count < nb_cpls && vc->tail != vc->head) {
+		struct imx_edma5_job *job = &vc->jobs[vc->tail];
+
+		if (!job->submitted || !job->done)
+			break;
+
+		/*
+		 * Stop before an errored job: it is left in the ring for
+		 * rte_dma_completed_status(), and last_idx stays at the last
+		 * successful transfer.
+		 */
+		if (job->error) {
+			*has_error = true;
+			break;
+		}
+
+		vc->last_idx = job->ridx;
+		vc->completed_count++;
+
+		vc->tail = (vc->tail + 1) & vc->desc_mask;
+		vc->nb_enqueued--;
+		count++;
+	}
+
+	*last_idx = vc->last_idx;
+
+	return count;
+}
+
+static uint16_t
+imx_edma5_completed_status(void *dev_private, uint16_t vchan,
+			   const uint16_t nb_cpls, uint16_t *last_idx,
+			   enum rte_dma_status_code *status)
+{
+	struct imx_edma5_dev *ed = dev_private;
+	struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+	uint16_t count = 0;
+
+	while (count < nb_cpls && vc->tail != vc->head) {
+		struct imx_edma5_job *job = &vc->jobs[vc->tail];
+
+		if (!job->submitted || !job->done)
+			break;
+
+		if (job->error) {
+			status[count] = RTE_DMA_STATUS_BUS_ERROR;
+			vc->errors_count++;
+		} else {
+			status[count] = RTE_DMA_STATUS_SUCCESSFUL;
+		}
+
+		vc->last_idx = job->ridx;
+		vc->completed_count++;
+
+		vc->tail = (vc->tail + 1) & vc->desc_mask;
+		vc->nb_enqueued--;
+		count++;
+	}
+
+	*last_idx = vc->last_idx;
+
+	return count;
+}
+
+static uint16_t
+imx_edma5_burst_capacity(const void *dev_private, uint16_t vchan)
+{
+	const struct imx_edma5_dev *ed = dev_private;
+	const struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+
+	/* One slot is reserved to distinguish full from empty. */
+	return vc->nb_desc - 1 - vc->nb_enqueued;
+}
+
 static const struct rte_dma_dev_ops imx_edma5_ops = {
 	.dev_info_get	= imx_edma5_info_get,
 	.dev_configure	= imx_edma5_configure,
@@ -352,6 +947,13 @@ imx_edma5_probe(struct rte_platform_device *pdev)
 
 	dev->device = &pdev->device;
 	dev->dev_ops = &imx_edma5_ops;
+	dev->fp_obj->dev_private = dev->data->dev_private;
+	dev->fp_obj->copy = imx_edma5_copy;
+	dev->fp_obj->copy_sg = imx_edma5_copy_sg;
+	dev->fp_obj->submit = imx_edma5_submit;
+	dev->fp_obj->completed = imx_edma5_completed;
+	dev->fp_obj->completed_status = imx_edma5_completed_status;
+	dev->fp_obj->burst_capacity = imx_edma5_burst_capacity;
 
 	ed = dev->data->dev_private;
 	ed->reg_base = res->mem.addr;
diff --git a/drivers/dma/imx_edma5/imx_edma5_dmadev.h b/drivers/dma/imx_edma5/imx_edma5_dmadev.h
index 3da7957457..13296f4f60 100644
--- a/drivers/dma/imx_edma5/imx_edma5_dmadev.h
+++ b/drivers/dma/imx_edma5/imx_edma5_dmadev.h
@@ -12,6 +12,7 @@
 #include <rte_byteorder.h>
 #include <rte_common.h>
 #include <rte_dmadev.h>
+#include <rte_eal.h>
 #include <rte_io.h>
 #include <rte_memory.h>
 
@@ -158,6 +159,7 @@ struct imx_edma5_vchan {
 	uint64_t completed_count;
 	uint64_t errors_count;
 
+	bool iova_is_va;
 	bool configured;
 };
 
@@ -217,4 +219,17 @@ imx_edma5_write64(uint8_t *base, uint32_t off, uint64_t val)
 	imx_edma5_write32(base, off + 4, (uint32_t)(val >> 32));
 }
 
+/*
+ * Resolve an IOVA to a CPU virtual address for cache maintenance.
+ * In IOVA=VA mode the IOVA is the VA directly; otherwise walk the memseg
+ * table. Avoids the memseg list walk on the common IOVA=VA fast path.
+ */
+static inline void *
+imx_edma5_iova_to_virt(rte_iova_t iova, bool iova_is_va)
+{
+	if (iova_is_va)
+		return (void *)(uintptr_t)iova;
+	return rte_mem_iova2virt(iova);
+}
+
 #endif /* IMX_EDMA5_DMADEV_H */
diff --git a/drivers/dma/imx_edma5/imx_edma5_logs.h b/drivers/dma/imx_edma5/imx_edma5_logs.h
index e73e496bb4..2a47d25945 100644
--- a/drivers/dma/imx_edma5/imx_edma5_logs.h
+++ b/drivers/dma/imx_edma5/imx_edma5_logs.h
@@ -13,4 +13,10 @@ extern int imx_edma5_logtype;
 #define IMX_EDMA5_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, IMX_EDMA5, "%s(): ", __func__, __VA_ARGS__)
 
+extern int imx_edma5_dp_logtype;
+#define RTE_LOGTYPE_IMX_EDMA5_DP imx_edma5_dp_logtype
+
+#define IMX_EDMA5_DP_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, IMX_EDMA5_DP, "%s(): ", __func__, __VA_ARGS__)
+
 #endif /* IMX_EDMA5_LOGS_H */
-- 
2.25.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C2C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 10:50:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9302F410E4;
	Tue, 11 Aug 2026 12:49:42 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A458140288
 for <dev@dpdk.org>; Tue, 11 Aug 2026 12:49:38 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 851C21A0187;
 Tue, 11 Aug 2026 12:49:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E2811A0182;
 Tue, 11 Aug 2026 12:49:38 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C3E1B18000B7;
 Tue, 11 Aug 2026 18:49:37 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, Gagandeep Singh <g.singh@nxp.com>,
 Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v3 3/5] dma/imx_edma5: add device configuration
Date: Tue, 11 Aug 2026 16:19:31 +0530
Message-Id: <20260811104933.3843522-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811104933.3843522-1-g.singh@nxp.com>
References: <20260807064853.1138187-1-g.singh@nxp.com>
 <20260811104933.3843522-1-g.singh@nxp.com>
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

Add the configuration and lifecycle operations for the i.MX95 eDMA5
dmadev: device configure, virtual channel setup, start, stop and close.

Each virtual channel maps 1:1 onto a usable hardware channel and owns a
software job ring plus a pool of in-memory TCD64 descriptors for
scatter-gather. Channel setup validates the requested direction and ring
size, allocates these rings, and resets the hardware channel to a known
idle state. Start re-arms global clock and arbitration and clears the
per-channel bookkeeping; stop resets every configured channel; close
frees the per-channel resources.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/dma/imx_edma5/imx_edma5_dmadev.c | 246 +++++++++++++++++++++++
 1 file changed, 246 insertions(+)

diff --git a/drivers/dma/imx_edma5/imx_edma5_dmadev.c b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
index f1c65a474a..fe5539b612 100644
--- a/drivers/dma/imx_edma5/imx_edma5_dmadev.c
+++ b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
@@ -78,6 +78,14 @@ imx_edma5_read_channel_mask(const char *dev_name)
 	return mask;
 }
 
+/* Return the register base of hardware channel n. */
+static inline uint8_t *
+imx_edma5_chan_base(struct imx_edma5_dev *ed, uint32_t chan)
+{
+	return ed->reg_base + IMX_EDMA5_CHAN_BASE_OFF +
+	       (size_t)chan * IMX_EDMA5_CHAN_STRIDE;
+}
+
 static int
 imx_edma5_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_info,
 		   uint32_t info_sz)
@@ -97,8 +105,246 @@ imx_edma5_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_info,
 	return 0;
 }
 
+static void imx_edma5_reset_hw_chan(struct imx_edma5_vchan *vc);
+
+static int
+imx_edma5_configure(struct rte_dma_dev *dev, const struct rte_dma_conf *conf,
+		    uint32_t conf_sz)
+{
+	struct imx_edma5_dev *ed = dev->data->dev_private;
+
+	RTE_SET_USED(conf_sz);
+
+	if (conf->nb_vchans == 0 || conf->nb_vchans > ed->max_vchans) {
+		IMX_EDMA5_LOG(ERR, "Invalid nb_vchans %u (max %u)",
+			      conf->nb_vchans, ed->max_vchans);
+		return -EINVAL;
+	}
+
+	if (ed->vchans == NULL) {
+		ed->vchans = rte_zmalloc_socket("imx_edma5_vchans",
+				ed->max_vchans * sizeof(struct imx_edma5_vchan),
+				RTE_CACHE_LINE_SIZE, dev->data->numa_node);
+		if (ed->vchans == NULL) {
+			IMX_EDMA5_LOG(ERR, "Failed to alloc vchan array");
+			return -ENOMEM;
+		}
+	} else {
+		/* Reconfigure: reset and free every previously configured channel. */
+		uint16_t i;
+
+		for (i = 0; i < ed->nb_vchans; i++) {
+			struct imx_edma5_vchan *vc = &ed->vchans[i];
+
+			if (!vc->configured)
+				continue;
+			imx_edma5_reset_hw_chan(vc);
+			rte_free(vc->jobs);
+			rte_free(vc->sg_tcd_pool);
+			memset(vc, 0, sizeof(*vc));
+		}
+	}
+
+	ed->nb_vchans = conf->nb_vchans;
+
+	return 0;
+}
+
+/* Reset a hardware channel to a known idle state. */
+static void
+imx_edma5_reset_hw_chan(struct imx_edma5_vchan *vc)
+{
+	uint8_t *ch = vc->ch_regs;
+	uint8_t *tcd = vc->tcd_regs;
+	uint32_t sbr;
+
+	/*
+	 * Disable hardware request and clear latched completion state.
+	 * CH_CSR.DONE is write-1-to-clear, so write the DONE bit to clear any
+	 * stale completion (e.g. left by the bootloader/kernel driver) while
+	 * leaving all other control bits disabled.
+	 */
+	imx_edma5_write32(ch, IMX_EDMA5_CH_CSR, IMX_EDMA5_CH_CSR_DONE);
+	imx_edma5_write32(ch, IMX_EDMA5_CH_ES, IMX_EDMA5_CH_ES_ERR);
+	imx_edma5_write32(ch, IMX_EDMA5_CH_INT, IMX_EDMA5_CH_INT_INT);
+
+	/*
+	 * Enable the read/write attribute bits in the System Bus Register with a
+	 * read-modify-write. The security/privilege attribute bits carried here
+	 * come up with a valid reset default that the bus fabric (XRDC) checks
+	 * and that must be preserved; a blind write of just RD|WR would clear
+	 * them and make the fabric reject the eDMA master transaction.
+	 */
+	sbr = imx_edma5_read32(ch, IMX_EDMA5_CH_SBR);
+	sbr |= IMX_EDMA5_CH_SBR_RD | IMX_EDMA5_CH_SBR_WR;
+	imx_edma5_write32(ch, IMX_EDMA5_CH_SBR, sbr);
+
+	/*
+	 * Leave CH_MATTR at its power-on reset value. The eDMA5 is a
+	 * non-coherent bus master; cache coherency is maintained by the driver
+	 * via explicit DC CVAC/CIVAC cache maintenance, not by AXI snooping.
+	 */
+
+	/* Clear the TCD control/status so the channel is idle. */
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_CSR, 0);
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_CITER, 0);
+	imx_edma5_write16(tcd, IMX_EDMA5_TCD_BITER, 0);
+}
+
+static int
+imx_edma5_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
+		      const struct rte_dma_vchan_conf *conf,
+		      uint32_t conf_sz)
+{
+	struct imx_edma5_dev *ed = dev->data->dev_private;
+	struct imx_edma5_vchan *vc;
+
+	RTE_SET_USED(conf_sz);
+
+	if (vchan >= ed->nb_vchans) {
+		IMX_EDMA5_LOG(ERR, "vchan %u out of range", vchan);
+		return -EINVAL;
+	}
+
+	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
+		IMX_EDMA5_LOG(ERR, "Only mem-to-mem direction supported");
+		return -EINVAL;
+	}
+
+	if (!rte_is_power_of_2(conf->nb_desc) ||
+	    conf->nb_desc < IMX_EDMA5_MIN_DESC ||
+	    conf->nb_desc > IMX_EDMA5_MAX_DESC) {
+		IMX_EDMA5_LOG(ERR, "nb_desc must be power of 2 in [%u..%u]",
+			      IMX_EDMA5_MIN_DESC, IMX_EDMA5_MAX_DESC);
+		return -EINVAL;
+	}
+
+	vc = &ed->vchans[vchan];
+
+	/* Free previous rings if this vchan is being reconfigured. */
+	rte_free(vc->jobs);
+	rte_free(vc->sg_tcd_pool);
+	memset(vc, 0, sizeof(*vc));
+
+	/*
+	 * Map this vchan onto a usable hardware channel. chan_map[] skips
+	 * channels reserved by "dma-channel-mask" (channels 0 and 1 on i.MX95).
+	 */
+	vc->hw_chan = ed->chan_map[vchan];
+	vc->ch_regs = imx_edma5_chan_base(ed, vc->hw_chan);
+	vc->tcd_regs = vc->ch_regs + IMX_EDMA5_CH_TCD_OFF;
+	vc->nb_desc = conf->nb_desc;
+	vc->desc_mask = conf->nb_desc - 1;
+
+	vc->jobs = rte_zmalloc_socket("imx_edma5_jobs",
+			vc->nb_desc * sizeof(struct imx_edma5_job),
+			RTE_CACHE_LINE_SIZE, dev->data->numa_node);
+	if (vc->jobs == NULL) {
+		IMX_EDMA5_LOG(ERR, "Failed to alloc job ring for vchan %u",
+			      vchan);
+		return -ENOMEM;
+	}
+
+	/* One IMX_EDMA5_SG_TCD_PER_JOB descriptor slice per job ring slot. */
+	vc->sg_tcd_pool = rte_zmalloc_socket("imx_edma5_sgtcd",
+			(size_t)vc->nb_desc * IMX_EDMA5_SG_TCD_PER_JOB *
+				sizeof(struct imx_edma5_hw_tcd64),
+			RTE_CACHE_LINE_SIZE, dev->data->numa_node);
+	if (vc->sg_tcd_pool == NULL) {
+		IMX_EDMA5_LOG(ERR, "Failed to alloc SG TCD pool for vchan %u",
+			      vchan);
+		rte_free(vc->jobs);
+		vc->jobs = NULL;
+		return -ENOMEM;
+	}
+	vc->sg_tcd_iova = rte_malloc_virt2iova(vc->sg_tcd_pool);
+
+	imx_edma5_reset_hw_chan(vc);
+	vc->configured = true;
+
+	return 0;
+}
+
+static int
+imx_edma5_start(struct rte_dma_dev *dev)
+{
+	struct imx_edma5_dev *ed = dev->data->dev_private;
+	uint32_t mp_csr;
+	uint16_t i;
+
+	/*
+	 * Enable round-robin arbitration with a read-modify-write so GCLC (set
+	 * in probe) is preserved; clearing GCLC would re-gate the per-channel
+	 * clocks and external-abort any subsequent channel access.
+	 */
+	mp_csr = imx_edma5_read32(ed->reg_base, IMX_EDMA5_MP_CSR);
+	mp_csr |= IMX_EDMA5_MP_CSR_GCLC | IMX_EDMA5_MP_CSR_ERCA;
+	imx_edma5_write32(ed->reg_base, IMX_EDMA5_MP_CSR, mp_csr);
+
+	for (i = 0; i < ed->nb_vchans; i++) {
+		struct imx_edma5_vchan *vc = &ed->vchans[i];
+
+		if (!vc->configured)
+			continue;
+		imx_edma5_reset_hw_chan(vc);
+		vc->head = 0;
+		vc->tail = 0;
+		vc->nb_enqueued = 0;
+		vc->ridx = 0;
+		/* Seed last_idx one step before the first cookie (0). */
+		vc->last_idx = UINT16_MAX;
+		vc->submitted_count = 0;
+		vc->completed_count = 0;
+		vc->errors_count = 0;
+	}
+
+	return 0;
+}
+
+static int
+imx_edma5_stop(struct rte_dma_dev *dev)
+{
+	struct imx_edma5_dev *ed = dev->data->dev_private;
+	uint16_t i;
+
+	for (i = 0; i < ed->nb_vchans; i++) {
+		struct imx_edma5_vchan *vc = &ed->vchans[i];
+
+		if (vc->configured)
+			imx_edma5_reset_hw_chan(vc);
+	}
+
+	return 0;
+}
+
+static int
+imx_edma5_close(struct rte_dma_dev *dev)
+{
+	struct imx_edma5_dev *ed = dev->data->dev_private;
+	uint16_t i;
+
+	if (ed->vchans != NULL) {
+		for (i = 0; i < ed->max_vchans; i++) {
+			rte_free(ed->vchans[i].jobs);
+			rte_free(ed->vchans[i].sg_tcd_pool);
+		}
+		rte_free(ed->vchans);
+		ed->vchans = NULL;
+	}
+
+	ed->nb_vchans = 0;
+
+	return 0;
+}
+
 static const struct rte_dma_dev_ops imx_edma5_ops = {
 	.dev_info_get	= imx_edma5_info_get,
+	.dev_configure	= imx_edma5_configure,
+	.dev_start	= imx_edma5_start,
+	.dev_stop	= imx_edma5_stop,
+	.dev_close	= imx_edma5_close,
+
+	.vchan_setup	= imx_edma5_vchan_setup,
 };
 
 static int
-- 
2.25.1


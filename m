Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706F0C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:43:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2961040A67;
	Thu,  6 Aug 2026 10:42:55 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8B81A402BB
 for <dev@dpdk.org>; Thu,  6 Aug 2026 10:42:51 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E5911A000D;
 Thu,  6 Aug 2026 10:42:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 36A271A0009;
 Thu,  6 Aug 2026 10:42:51 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B7D2D18000B0;
 Thu,  6 Aug 2026 16:42:50 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 4/4] dma/imx_edma5: add statistics and dump
Date: Thu,  6 Aug 2026 14:12:45 +0530
Message-Id: <20260806084245.561305-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806084245.561305-1-g.singh@nxp.com>
References: <20260806084245.561305-1-g.singh@nxp.com>
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

Add per-vchan statistics, virtual channel status reporting and a device
dump callback to the eDMA5 dmadev.

stats_get and stats_reset expose the submitted, completed and error
counters maintained by the data path, supporting both a single vchan and
the RTE_DMA_ALL_VCHAN aggregate. vchan_status reports whether a channel is
idle, active or halted on an unreaped error by inspecting the outstanding
jobs in the software ring. dev_dump prints the device and per-vchan
software state to aid debugging.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/dma/imx_edma5/imx_edma5_dmadev.c | 121 +++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/dma/imx_edma5/imx_edma5_dmadev.c b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
index 0b6a56112e..f309bd9f08 100644
--- a/drivers/dma/imx_edma5/imx_edma5_dmadev.c
+++ b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
@@ -848,6 +848,121 @@ imx_edma5_burst_capacity(const void *dev_private, uint16_t vchan)
 	return vc->nb_desc - 1 - vc->nb_enqueued;
 }
 
+static int
+imx_edma5_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan,
+		       enum rte_dma_vchan_status *status)
+{
+	const struct imx_edma5_dev *ed = dev->data->dev_private;
+	const struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+	uint16_t idx;
+
+	/*
+	 * HALTED_ERROR if an errored job is still unreaped, ACTIVE while any job
+	 * is outstanding (not done, or enqueued but not submitted), else IDLE.
+	 */
+	*status = RTE_DMA_VCHAN_IDLE;
+
+	for (idx = vc->tail; idx != vc->head; idx = (idx + 1) & vc->desc_mask) {
+		const struct imx_edma5_job *job = &vc->jobs[idx];
+
+		if (job->submitted && job->done && job->error) {
+			*status = RTE_DMA_VCHAN_HALTED_ERROR;
+			break;
+		}
+
+		if (!job->submitted || !job->done) {
+			*status = RTE_DMA_VCHAN_ACTIVE;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int
+imx_edma5_stats_get(const struct rte_dma_dev *dev, uint16_t vchan,
+		    struct rte_dma_stats *stats, uint32_t stats_sz)
+{
+	const struct imx_edma5_dev *ed = dev->data->dev_private;
+
+	RTE_SET_USED(stats_sz);
+
+	stats->submitted = 0;
+	stats->completed = 0;
+	stats->errors = 0;
+
+	/* RTE_DMA_ALL_VCHAN requests the aggregate across every vchan. */
+	if (vchan == RTE_DMA_ALL_VCHAN) {
+		uint16_t i;
+
+		for (i = 0; i < ed->nb_vchans; i++) {
+			const struct imx_edma5_vchan *vc = &ed->vchans[i];
+
+			stats->submitted += vc->submitted_count;
+			stats->completed += vc->completed_count;
+			stats->errors += vc->errors_count;
+		}
+	} else if (vchan < ed->nb_vchans) {
+		const struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+
+		stats->submitted = vc->submitted_count;
+		stats->completed = vc->completed_count;
+		stats->errors = vc->errors_count;
+	}
+
+	return 0;
+}
+
+static int
+imx_edma5_stats_reset(struct rte_dma_dev *dev, uint16_t vchan)
+{
+	struct imx_edma5_dev *ed = dev->data->dev_private;
+
+	/* RTE_DMA_ALL_VCHAN requests a reset of every vchan. */
+	if (vchan == RTE_DMA_ALL_VCHAN) {
+		uint16_t i;
+
+		for (i = 0; i < ed->nb_vchans; i++) {
+			struct imx_edma5_vchan *vc = &ed->vchans[i];
+
+			vc->submitted_count = 0;
+			vc->completed_count = 0;
+			vc->errors_count = 0;
+		}
+	} else if (vchan < ed->nb_vchans) {
+		struct imx_edma5_vchan *vc = &ed->vchans[vchan];
+
+		vc->submitted_count = 0;
+		vc->completed_count = 0;
+		vc->errors_count = 0;
+	}
+
+	return 0;
+}
+
+static int
+imx_edma5_dump(const struct rte_dma_dev *dev, FILE *f)
+{
+	const struct imx_edma5_dev *ed = dev->data->dev_private;
+	uint16_t i;
+
+	(void)fprintf(f, "  imx_edma5 nb_channels=%u nb_vchans=%u\n",
+		      ed->nb_channels, ed->nb_vchans);
+	for (i = 0; i < ed->nb_vchans; i++) {
+		const struct imx_edma5_vchan *vc = &ed->vchans[i];
+
+		(void)fprintf(f,
+			"    vchan %u: hw_chan=%u nb_desc=%u enqueued=%u "
+			"submitted=%" PRIu64 " completed=%" PRIu64
+			" errors=%" PRIu64 "\n",
+			i, vc->hw_chan, vc->nb_desc, vc->nb_enqueued,
+			vc->submitted_count, vc->completed_count,
+			vc->errors_count);
+	}
+
+	return 0;
+}
+
 static const struct rte_dma_dev_ops imx_edma5_ops = {
 	.dev_info_get	= imx_edma5_info_get,
 	.dev_configure	= imx_edma5_configure,
@@ -856,6 +971,12 @@ static const struct rte_dma_dev_ops imx_edma5_ops = {
 	.dev_close	= imx_edma5_close,
 
 	.vchan_setup	= imx_edma5_vchan_setup,
+	.vchan_status	= imx_edma5_vchan_status,
+
+	.stats_get	= imx_edma5_stats_get,
+	.stats_reset	= imx_edma5_stats_reset,
+
+	.dev_dump	= imx_edma5_dump,
 };
 
 static int
-- 
2.25.1


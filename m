Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2365FC5CFC0
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:48:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F267741149;
	Tue, 11 Aug 2026 09:47:57 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3DA6E40ED3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 09:47:49 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 266C420018B;
 Tue, 11 Aug 2026 09:47:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E4C52200185;
 Tue, 11 Aug 2026 09:47:48 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 719BC18000B5;
 Tue, 11 Aug 2026 15:47:48 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v7 09/14] net/enetc: support stats reset for VF
Date: Tue, 11 Aug 2026 13:17:40 +0530
Message-Id: <20260811074745.3655334-10-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811074745.3655334-1-g.singh@nxp.com>
References: <20260811074032.3646324-1-g.singh@nxp.com>
 <20260811074745.3655334-1-g.singh@nxp.com>
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

The NETC SI-level hardware counters (SIROCT0, SIRFRM0, SITOCT0,
SITFRM0, SITDFCR) are read-only for a VF and cannot be directly
zeroed. No VSI-PSI command class exists for stats reset, and using
FLR/soft-reset to clear counters is not reliable due to a known
hardware erratum on some NETC platforms.

Implement stats_reset for the enetc4 VF PMD using a software
snapshot/delta approach: on stats_reset, the current HW counter
values are captured as a baseline in a new per-device
enetc4_vf_stats_saved struct. stats_get then reports the delta
(current_hw_value - saved_baseline), so counters appear to start
from zero after each reset call. Per-ring software Rx error
accumulators (ierrors) are zeroed directly on reset.

Register the stats_reset callback in both VF ops tables
(enetc4_vf_ops and enetc4_vf_ops_no_vsi_m) so the feature is
available regardless of whether the VSI messaging path is enabled.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/enetc.h              | 17 +++++++
 drivers/net/enetc/enetc4_vf.c          | 61 +++++++++++++++++++++++---
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 1765adc1bc..a42577c681 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -70,6 +70,7 @@ New Features
   * Added register dump support for ENETC4 PF and VF.
   * Added ring parameters support for the ENETC4 VF (rxq_info_get / txq_info_get).
   * Refreshed VF link speed on the link-up interrupt in the ENETC4 VF driver.
+  * Added stats reset for the ENETC4 VF using a software snapshot/delta approach.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 185fd8c4ee..96e18028a6 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -105,6 +105,21 @@ struct enetc_bdr {
 	uint8_t rsc_enable;
 };
 
+/*
+ * Saved SI counter baseline for VF stats reset. Since the SI-level
+ * hardware counters (SIROCT0, SIRFRM0, SITOCT0, SITFRM0, SITDFCR)
+ * are read-only for a VF and cannot be directly zeroed, stats_reset
+ * captures the current counter values as a baseline. stats_get then
+ * reports the delta: current_hw_value - baseline.
+ */
+struct enetc4_vf_stats_saved {
+	uint64_t ipackets;
+	uint64_t opackets;
+	uint64_t ibytes;
+	uint64_t obytes;
+	uint64_t oerrors;
+};
+
 struct enetc_eth_hw {
 	struct rte_eth_dev *ndev;
 	struct enetc_hw hw;
@@ -125,6 +140,8 @@ struct enetc_eth_hw {
 	 */
 	uint8_t vf_link_legacy;
 	pthread_mutex_t vsi_lock; /* serializes all VSI-PSI mailbox transactions */
+	/* Baseline snapshot for VF stats reset (software delta approach). */
+	struct enetc4_vf_stats_saved vf_stats_saved;
 };
 
 /*
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index da41b999cb..fb777bbeac 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -224,15 +224,64 @@ enetc4_vf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	uint8_t i;
 
 	PMD_INIT_FUNC_TRACE();
-	stats->ipackets = enetc4_rd(enetc_hw, ENETC4_SIRFRM0);
-	stats->opackets = enetc4_rd(enetc_hw, ENETC4_SITFRM0);
-	stats->ibytes = enetc4_rd(enetc_hw, ENETC4_SIROCT0);
-	stats->obytes = enetc4_rd(enetc_hw, ENETC4_SITOCT0);
-	stats->oerrors = enetc4_rd(enetc_hw, ENETC4_SITDFCR);
+
+	/*
+	 * The SI-level counters are read-only for a VF; they cannot be
+	 * zeroed directly. Instead, stats_reset captures a baseline
+	 * snapshot, and stats_get reports the delta so that the reported
+	 * values appear to start from zero after each reset call.
+	 */
+	stats->ipackets = enetc4_rd(enetc_hw, ENETC4_SIRFRM0) -
+			  hw->vf_stats_saved.ipackets;
+	stats->opackets = enetc4_rd(enetc_hw, ENETC4_SITFRM0) -
+			  hw->vf_stats_saved.opackets;
+	stats->ibytes   = enetc4_rd(enetc_hw, ENETC4_SIROCT0) -
+			  hw->vf_stats_saved.ibytes;
+	stats->obytes   = enetc4_rd(enetc_hw, ENETC4_SITOCT0) -
+			  hw->vf_stats_saved.obytes;
+	stats->oerrors  = enetc4_rd(enetc_hw, ENETC4_SITDFCR) -
+			  hw->vf_stats_saved.oerrors;
+
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		rx_ring = dev->data->rx_queues[i];
 		stats->ierrors += rx_ring->ierrors;
 	}
+
+	return 0;
+}
+
+/*
+ * Reset VF statistics by capturing a new baseline snapshot of the
+ * SI-level hardware counters. Because those counters are read-only
+ * for a VF (hardware erratum prevents reliable clear via FLR/soft
+ * reset too), the driver uses a software delta approach: every
+ * stats_get call reports current_hw_value - saved_baseline.
+ */
+static int
+enetc4_vf_stats_reset(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_bdr *rx_ring;
+	uint8_t i;
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Snapshot current HW SI counter values as the new zero baseline. */
+	hw->vf_stats_saved.ipackets = enetc4_rd(enetc_hw, ENETC4_SIRFRM0);
+	hw->vf_stats_saved.opackets = enetc4_rd(enetc_hw, ENETC4_SITFRM0);
+	hw->vf_stats_saved.ibytes   = enetc4_rd(enetc_hw, ENETC4_SIROCT0);
+	hw->vf_stats_saved.obytes   = enetc4_rd(enetc_hw, ENETC4_SITOCT0);
+	hw->vf_stats_saved.oerrors  = enetc4_rd(enetc_hw, ENETC4_SITDFCR);
+
+	/* Reset the per-ring software Rx error accumulators. */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rx_ring = dev->data->rx_queues[i];
+		if (rx_ring)
+			rx_ring->ierrors = 0;
+	}
+
 	return 0;
 }
 
@@ -1547,6 +1596,7 @@ static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
 	.dev_stop             = enetc4_vf_dev_stop,
 	.dev_close            = enetc4_dev_close,
 	.stats_get            = enetc4_vf_stats_get,
+	.stats_reset          = enetc4_vf_stats_reset,
 	.dev_infos_get        = enetc4_vf_dev_infos_get,
 	.get_reg              = enetc4_vf_get_regs,
 	.mtu_set              = enetc4_vf_mtu_set,
@@ -1570,6 +1620,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_stop             = enetc4_vf_dev_stop,
 	.dev_close            = enetc4_dev_close,
 	.stats_get            = enetc4_vf_stats_get,
+	.stats_reset          = enetc4_vf_stats_reset,
 	.dev_infos_get        = enetc4_vf_dev_infos_get,
 	.fw_version_get       = enetc4_vf_fw_version_get,
 	.get_reg              = enetc4_vf_get_regs,
-- 
2.25.1


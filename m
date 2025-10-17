Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43755CCD1A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:20:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5C642D99;
	Fri, 17 Oct 2025 11:19:42 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0E3BB427E3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:34 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E3D37200EE7;
 Fri, 17 Oct 2025 11:19:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ADCB9200E78;
 Fri, 17 Oct 2025 11:19:33 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2614F180007B;
 Fri, 17 Oct 2025 17:19:33 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [v2 05/12] net/enetc: Add basic statistics
Date: Fri, 17 Oct 2025 14:49:22 +0530
Message-Id: <20251017091929.2723044-6-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017091929.2723044-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251017091929.2723044-1-vanshika.shukla@nxp.com>
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Introduces basic statistics collection for ENETC4 PMD, including:

- Packet transmit/receive counts
- Byte transmit/receive counts
- Error counters (TX/RX drops, errors)

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |  1 +
 drivers/net/enetc/base/enetc4_hw.h  |  7 +++++
 drivers/net/enetc/base/enetc_hw.h   |  5 +++-
 drivers/net/enetc/enetc4_ethdev.c   | 42 +++++++++++++++++++++++++++++
 drivers/net/enetc/enetc4_vf.c       | 24 +++++++++++++++++
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 55b3b95953..e814852d2d 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,7 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Basic stats          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Queue start/stop     = Y
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index 87458c47e5..af3d4fa256 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -105,6 +105,13 @@
 #define IFMODE_SGMII			5
 #define PM_IF_MODE_ENA			BIT(15)
 
+/* Station interface statistics */
+#define ENETC4_SIROCT0           0x300
+#define ENETC4_SIRFRM0           0x308
+#define ENETC4_SITOCT0           0x320
+#define ENETC4_SITFRM0           0x328
+#define ENETC4_SITDFCR           0x340
+
 /* general register accessors */
 #define enetc4_rd_reg(reg)	rte_read32((void *)(reg))
 #define enetc4_wr_reg(reg, val)  rte_write32((val), (void *)(reg))
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index b53bd0c1e8..290eaf577c 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -278,7 +278,10 @@ union enetc_rx_bd {
 		union {
 			struct {
 				uint16_t flags;
-				uint16_t error;
+				uint8_t error;
+				uint8_t resv:6;
+				uint8_t r:1;
+				uint8_t f:1;
 			};
 			uint32_t lstatus;
 		};
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index a2b5b8c408..5c34102ddd 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -439,6 +439,46 @@ enetc4_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	rte_free(rx_ring);
 }
 
+static
+int enetc4_stats_get(struct rte_eth_dev *dev,
+		    struct rte_eth_stats *stats)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+
+	/*
+	 * Total received packets, bad + good, if we want to get counters
+	 * of only good received packets then use ENETC4_PM_RFRM,
+	 * ENETC4_PM_TFRM registers.
+	 */
+	stats->ipackets = enetc4_port_rd(enetc_hw, ENETC4_PM_RPKT(0));
+	stats->opackets = enetc4_port_rd(enetc_hw, ENETC4_PM_TPKT(0));
+	stats->ibytes =  enetc4_port_rd(enetc_hw, ENETC4_PM_REOCT(0));
+	stats->obytes = enetc4_port_rd(enetc_hw, ENETC4_PM_TEOCT(0));
+	/*
+	 * Dropped + Truncated packets, use ENETC4_PM_RDRNTP(0) for without
+	 * truncated packets
+	 */
+	stats->imissed = enetc4_port_rd(enetc_hw, ENETC4_PM_RDRP(0));
+	stats->ierrors = enetc4_port_rd(enetc_hw, ENETC4_PM_RERR(0));
+	stats->oerrors = enetc4_port_rd(enetc_hw, ENETC4_PM_TERR(0));
+
+	return 0;
+}
+
+static int
+enetc4_stats_reset(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+
+	enetc4_port_wr(enetc_hw, ENETC4_PM0_STAT_CONFIG, ENETC4_CLEAR_STATS);
+
+	return 0;
+}
+
 int
 enetc4_dev_close(struct rte_eth_dev *dev)
 {
@@ -623,6 +663,8 @@ static const struct eth_dev_ops enetc4_ops = {
 	.dev_stop             = enetc4_dev_stop,
 	.dev_close            = enetc4_dev_close,
 	.dev_infos_get        = enetc4_dev_infos_get,
+	.stats_get            = enetc4_stats_get,
+	.stats_reset          = enetc4_stats_reset,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 2e3e22bfcb..534cf4b45c 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -26,6 +26,29 @@ enetc4_vf_dev_start(struct rte_eth_dev *dev __rte_unused)
 	return 0;
 }
 
+static int
+enetc4_vf_stats_get(struct rte_eth_dev *dev,
+		    struct rte_eth_stats *stats)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_bdr *rx_ring;
+	uint8_t i;
+
+	PMD_INIT_FUNC_TRACE();
+	stats->ipackets = enetc4_rd(enetc_hw, ENETC4_SIRFRM0);
+	stats->opackets = enetc4_rd(enetc_hw, ENETC4_SITFRM0);
+	stats->ibytes = enetc4_rd(enetc_hw, ENETC4_SIROCT0);
+	stats->obytes = enetc4_rd(enetc_hw, ENETC4_SITOCT0);
+	stats->oerrors = enetc4_rd(enetc_hw, ENETC4_SITDFCR);
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rx_ring = dev->data->rx_queues[i];
+		stats->ierrors += rx_ring->ierrors;
+	}
+	return 0;
+}
+
 /*
  * The set of PCI devices this driver supports
  */
@@ -41,6 +64,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_stop             = enetc4_vf_dev_stop,
 	.dev_close            = enetc4_dev_close,
 	.dev_infos_get        = enetc4_dev_infos_get,
+	.stats_get            = enetc4_vf_stats_get,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
-- 
2.25.1


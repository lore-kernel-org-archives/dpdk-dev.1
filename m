Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F9CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:23:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B333740E25;
	Tue, 14 Oct 2025 09:20:43 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8531F40288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 08:40:43 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D6D11A1C30;
 Tue, 14 Oct 2025 08:40:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 398761A1C22;
 Tue, 14 Oct 2025 08:40:43 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B3AEE18000A4;
 Tue, 14 Oct 2025 14:40:42 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Subject: [PATCH 15/15] net/dpaa2: add Policer stats for each TC
Date: Tue, 14 Oct 2025 12:10:35 +0530
Message-ID: <20251014064035.1312896-16-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:20:04 +0200
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

Add support of Policer stats for each TC.
Also dpmac stats are supported for MC version > 10.39.0

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 117 ++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 5b72243346..be86fcb853 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -104,6 +104,46 @@ static const struct rte_dpaa2_xstats_name_off dpaa2_xstats_strings[] = {
 	{"egress_confirmed_frames", 2, 4},
 	{"cgr_reject_frames", 4, 0},
 	{"cgr_reject_bytes", 4, 1},
+	{"TC_0_policer_cnt_red", 5, 0},
+	{"TC_0_policer_cnt_yellow", 5, 1},
+	{"TC_0_policer_cnt_green", 5, 2},
+	{"TC_0_policer_cnt_re_red", 5, 3},
+	{"TC_0_policer_cnt_re_yellow", 5, 4},
+	{"TC_1_policer_cnt_red", 6, 0},
+	{"TC_1_policer_cnt_yellow", 6, 1},
+	{"TC_1_policer_cnt_green", 6, 2},
+	{"TC_1_policer_cnt_re_red", 6, 3},
+	{"TC_1_policer_cnt_re_yellow", 6, 4},
+	{"TC_2_policer_cnt_red", 7, 0},
+	{"TC_2_policer_cnt_yellow", 7, 1},
+	{"TC_2_policer_cnt_green", 7, 2},
+	{"TC_2_policer_cnt_re_red", 7, 3},
+	{"TC_2_policer_cnt_re_yellow", 7, 4},
+	{"TC_3_policer_cnt_red", 8, 0},
+	{"TC_3_policer_cnt_yellow", 8, 1},
+	{"TC_3_policer_cnt_green", 8, 2},
+	{"TC_3_policer_cnt_re_red", 8, 3},
+	{"TC_3_policer_cnt_re_yellow", 8, 4},
+	{"TC_4_policer_cnt_red", 9, 0},
+	{"TC_4_policer_cnt_yellow", 9, 1},
+	{"TC_4_policer_cnt_green", 9, 2},
+	{"TC_4_policer_cnt_re_red", 9, 3},
+	{"TC_4_policer_cnt_re_yellow", 9, 4},
+	{"TC_5_policer_cnt_red", 10, 0},
+	{"TC_5_policer_cnt_yellow", 10, 1},
+	{"TC_5_policer_cnt_green", 10, 2},
+	{"TC_5_policer_cnt_re_red", 10, 3},
+	{"TC_5_policer_cnt_re_yellow", 10, 4},
+	{"TC_6_policer_cnt_red", 11, 0},
+	{"TC_6_policer_cnt_yellow", 11, 1},
+	{"TC_6_policer_cnt_green", 11, 2},
+	{"TC_6_policer_cnt_re_red", 11, 3},
+	{"TC_6_policer_cnt_re_yellow", 11, 4},
+	{"TC_7_policer_cnt_red", 12, 0},
+	{"TC_7_policer_cnt_yellow", 12, 1},
+	{"TC_7_policer_cnt_green", 12, 2},
+	{"TC_7_policer_cnt_re_red", 12, 3},
+	{"TC_7_policer_cnt_re_yellow", 12, 4},
 	{"mac_rx_64 bytes", 0, 0},
 	{"mac_rx_65-127 bytes", 0, 0},
 	{"mac_rx_128-255 bytes", 0, 0},
@@ -1841,6 +1881,11 @@ dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
 	priv->cnt_values_dma_mem = NULL;
 }
 
+/*
+ * dpaa2_dev_xstats_get(): Get counters of dpni and dpmac.
+ * MAC (mac_*) counters are supported on MC version > 10.39.0
+ * TC_x_policer_* counters are supported only when Policer is enable.
+ */
 static int
 dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	struct rte_eth_xstat *xstats, unsigned int n)
@@ -1848,10 +1893,13 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
 	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	union dpni_statistics value[5] = {};
+	union dpni_statistics value[13] = {};
+	struct mc_version mc_ver_info = {0};
+	struct dpni_rx_tc_policing_cfg cfg;
 	uint8_t page_id, stats_id;
 	uint64_t *cnt_values;
 	int32_t retcode;
+	int16_t tc;
 
 	if (n < num)
 		return num;
@@ -1888,6 +1936,27 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 			break;
 		}
 	}
+
+	for (tc = 0; tc < priv->num_rx_tc; tc++) {
+		retcode = dpni_get_rx_tc_policing(dpni, CMD_PRI_LOW,
+						  priv->token, tc,
+						  &cfg);
+		if (retcode) {
+			DPAA2_PMD_ERR("Error to get the policer rule: %d", retcode);
+			goto err;
+		}
+
+		/* get policer stats if policer is enabled */
+		if (cfg.mode != 0) {
+			/* Get Counters from page_5*/
+			retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
+						      priv->token, 5, tc,
+						      &value[(tc + 5)]);
+			if (retcode)
+				goto err;
+		}
+	}
+
 	while (i < (num - DPAA2_MAC_NUM_STATS)) {
 		xstats[i].id = i;
 		page_id = dpaa2_xstats_strings[i].page_id;
@@ -1896,29 +1965,45 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 		i++;
 	}
 
-	dpaa2_dev_mac_setup_stats(dev);
-	retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
-					  priv->cnt_idx_iova, priv->cnt_values_iova,
-					  DPAA2_MAC_NUM_STATS);
-	if (retcode) {
-		DPAA2_PMD_WARN("MAC (mac_*) counters are not supported!!");
+	if (mc_get_version(dpni, CMD_PRI_LOW, &mc_ver_info))
+		DPAA2_PMD_WARN("Unable to obtain MC version");
+
+	/* mac_statistics supported on MC version > 10.39.0 */
+	if (mc_ver_info.major >= MC_VER_MAJOR &&
+	    mc_ver_info.minor >= MC_VER_MINOR &&
+	    mc_ver_info.revision > 0) {
+		dpaa2_dev_mac_setup_stats(dev);
+		retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
+						  priv->cnt_idx_iova,
+						  priv->cnt_values_iova,
+						  DPAA2_MAC_NUM_STATS);
+		if (retcode) {
+			while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+				xstats[i].id = i;
+				xstats[i].value = 0;
+				i++;
+			}
+		}
+		if (!retcode) {
+			cnt_values = priv->cnt_values_dma_mem;
+			while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+				/* mac counters value */
+				xstats[i].id = i;
+				xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
+				i++;
+			}
+		}
 		rte_free(priv->cnt_values_dma_mem);
 		rte_free(priv->cnt_idx_dma_mem);
+		priv->cnt_idx_dma_mem = NULL;
+		priv->cnt_values_dma_mem = NULL;
+	} else {
 		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
 			xstats[i].id = i;
 			xstats[i].value = 0;
 			i++;
 		}
 	}
-	if (!retcode) {
-		cnt_values = priv->cnt_values_dma_mem;
-		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
-			/* mac counters value */
-			xstats[i].id = i;
-			xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
-			i++;
-		}
-	}
 
 	return i;
 err:
-- 
2.43.0


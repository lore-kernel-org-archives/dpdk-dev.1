Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE8C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DFAF42DC3;
	Thu,  3 Sep 2026 15:54:20 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D3B5C42D9F
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:15 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B48F020004C;
 Thu,  3 Sep 2026 15:54:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80B70200029;
 Thu,  3 Sep 2026 15:54:15 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 56E4F18000B1;
 Thu,  3 Sep 2026 21:54:14 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 15/45] net/dpaa2: set Tx confirmation on device init
Date: Thu,  3 Sep 2026 19:23:23 +0530
Message-ID: <20260903135353.3358303-16-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Move TX confirmation mode setting from TXQ setup to device
initialization because TXQ0 is not always set up by the user.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 40 ++++++++++++--------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f211357919..c95704d4ca 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1153,7 +1153,6 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	struct dpni_queue tx_conf_cfg;
 	struct dpni_queue tx_flow_cfg;
 	uint8_t options = 0, flow_id;
-	uint8_t ceetm_ch_idx;
 	uint16_t channel_id;
 	struct dpni_queue_id qid;
 	uint32_t tc_id;
@@ -1174,30 +1173,6 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	memset(&tx_conf_cfg, 0, sizeof(struct dpni_queue));
 	memset(&tx_flow_cfg, 0, sizeof(struct dpni_queue));
 
-	if (!tx_queue_id) {
-		for (ceetm_ch_idx = 0;
-			ceetm_ch_idx <= (priv->num_channels - 1);
-			ceetm_ch_idx++) {
-			/*Set tx-conf and error configuration*/
-			if (priv->flags & DPAA2_TX_CONF_ENABLE) {
-				ret = dpni_set_tx_confirmation_mode(dpni,
-						CMD_PRI_LOW, priv->token,
-						ceetm_ch_idx,
-						DPNI_CONF_AFFINE);
-			} else {
-				ret = dpni_set_tx_confirmation_mode(dpni,
-						CMD_PRI_LOW, priv->token,
-						ceetm_ch_idx,
-						DPNI_CONF_DISABLE);
-			}
-			if (ret) {
-				DPAA2_PMD_ERR("Error(%d) in tx conf setting",
-					ret);
-				return ret;
-			}
-		}
-	}
-
 	tc_id = tx_queue_id % priv->num_tx_tc;
 	channel_id = (uint8_t)(tx_queue_id / priv->num_tx_tc) % priv->num_channels;
 	flow_id = 0;
@@ -3624,6 +3599,21 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	for (i = 0; i < priv->num_channels; i++) {
+		/*Set tx-conf and error configuration*/
+		if (priv->flags & DPAA2_TX_CONF_ENABLE) {
+			ret = dpni_set_tx_confirmation_mode(dpni_dev,
+				CMD_PRI_LOW, priv->token, i, DPNI_CONF_AFFINE);
+		} else {
+			ret = dpni_set_tx_confirmation_mode(dpni_dev,
+				CMD_PRI_LOW, priv->token, i, DPNI_CONF_DISABLE);
+		}
+		if (ret) {
+			DPAA2_PMD_ERR("Error(%d) in tx conf setting", ret);
+			goto init_err;
+		}
+	}
+
 	/* Allocate memory for storing MAC addresses.
 	 * Table of mac_filter_entries size is allocated so that RTE ether lib
 	 * can add MAC entries when rte_eth_dev_mac_addr_add is called.
-- 
2.43.0


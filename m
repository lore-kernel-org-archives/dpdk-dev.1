Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274BE606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55BBD40698;
	Tue, 20 Oct 2026 16:48:52 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 799B440679
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:48:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 59C1B1A008D;
 Tue, 20 Oct 2026 16:48:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 23A451A00AB;
 Tue, 20 Oct 2026 16:48:48 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ED4EF18000B5;
 Tue, 20 Oct 2026 22:48:46 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v14-S2 02/10] net/dpaa2: set Tx confirmation on device init
Date: Tue, 20 Oct 2026 20:18:33 +0530
Message-ID: <20261020144841.506038-3-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
 <20261020144841.506038-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gagandeep Singh <g.singh@nxp.com>

Move TX confirmation mode setting from TXQ setup to device
initialization because TXQ0 is not always set up by the user.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 40 ++++++++++++--------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 8ae4fd89c5..f88ecb88aa 100644
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
@@ -3621,6 +3596,21 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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


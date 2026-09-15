Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F205DC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E18F7427B8;
	Tue, 15 Sep 2026 13:35:13 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 47CAB427A5
 for <dev@dpdk.org>; Tue, 15 Sep 2026 13:35:08 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BF8C200032;
 Tue, 15 Sep 2026 13:35:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E9232200004;
 Tue, 15 Sep 2026 13:35:07 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DF59B1800068;
 Tue, 15 Sep 2026 19:35:06 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3-S2 06/13] net/dpaa2: support flow drop action
Date: Tue, 15 Sep 2026 17:04:52 +0530
Message-ID: <20260915113459.4166621-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
References: <20260910135158.2181141-48-prashant.gupta_3@nxp.com>
 <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
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

Add support for the RTE_FLOW_ACTION_TYPE_DROP action in the dpaa2 flow
engine. A flow rule with a drop action is programmed into the flow
steering (FS) table with the DPNI_FS_OPT_DISCARD option so that matching
frames are discarded by hardware.

The drop action is added to the supported action list, accepted during
action verification, configured in the FS action path, handled in the
generic flow-set action loop, and cleaned up in the flow destroy path.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 90e0b66258..b2f1778de3 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -97,7 +97,8 @@ enum rte_flow_action_type dpaa2_supported_action_type[] = {
 	RTE_FLOW_ACTION_TYPE_QUEUE,
 	RTE_FLOW_ACTION_TYPE_PORT_ID,
 	RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT,
-	RTE_FLOW_ACTION_TYPE_RSS
+	RTE_FLOW_ACTION_TYPE_RSS,
+	RTE_FLOW_ACTION_TYPE_DROP
 };
 
 #ifndef __cplusplus
@@ -4421,6 +4422,7 @@ dpaa2_flow_verify_action(struct dpaa2_dev_priv *priv,
 			break;
 		case RTE_FLOW_ACTION_TYPE_PF:
 			/* Skip this action, have to add for vxlan */
+		case RTE_FLOW_ACTION_TYPE_DROP:
 			break;
 		case RTE_FLOW_ACTION_TYPE_END:
 			end_of_list = 1;
@@ -4468,6 +4470,8 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 		flow->fs_action_cfg.redirect_obj_token =
 			dest_priv->token;
 		flow->fs_action_cfg.flow_id = dest_q->flow_id;
+	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
+		flow->fs_action_cfg.options = DPNI_FS_OPT_DISCARD;
 	}
 
 	return 0;
@@ -4945,6 +4949,7 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 		case RTE_FLOW_ACTION_TYPE_QUEUE:
 		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
 		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+		case RTE_FLOW_ACTION_TYPE_DROP:
 			ret = dpaa2_configure_flow_fs_action(priv, flow,
 							     &actions[j]);
 			if (ret)
@@ -5346,6 +5351,7 @@ dpaa2_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *_flow,
 	case RTE_FLOW_ACTION_TYPE_QUEUE:
 	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
 	case RTE_FLOW_ACTION_TYPE_PORT_ID:
+	case RTE_FLOW_ACTION_TYPE_DROP:
 		if (priv->num_rx_tc > 1) {
 			/* Remove entry from QoS table first */
 			ret = dpni_remove_qos_entry(dpni, CMD_PRI_LOW,
-- 
2.43.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17230CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64C864278F;
	Tue,  6 Oct 2026 17:10:23 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1F4EE42708
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:10:19 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F2F681A01AF;
 Tue,  6 Oct 2026 17:10:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BCA881A0005;
 Tue,  6 Oct 2026 17:10:18 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6670D1800226;
 Tue,  6 Oct 2026 23:10:17 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v6-S2 06/13] net/dpaa2: support flow drop action
Date: Tue,  6 Oct 2026 20:40:02 +0530
Message-ID: <20261006151009.3593348-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
References: <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
 <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
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
index 1446b14bf2..f0748081b3 100644
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


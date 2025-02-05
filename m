Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81072C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 05:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F2BA402DB;
	Wed,  5 Feb 2025 06:43:05 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 30380402DA
 for <dev@dpdk.org>; Wed,  5 Feb 2025 06:43:03 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5155Rrao016305
 for <dev@dpdk.org>; Tue, 4 Feb 2025 21:43:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 kUci8PONByB0iLM5skl3YZbNcBU/rfWXloli4Wq614=; b=ZajwhHWjDFmHEXV5C
 +uWYlidY34C5ZGXED2I7LwVtshJVMl15WwqskFv2CZ9K/sENLCfofQud9o1r6DUI
 Z/59vs1cY6JghHH47E24XuI9V5KJCX4V6zLVf7CCrLBS+C+MQBSvk11Egpr04bMk
 hLlpQJy4KY7JZqKxuGi7KJqrkQ17fmt79CShnnzMn2Z/GyzaMfTxv0+F+ZhjR9s7
 YmfVAADiI3IFgzFC3+m36HrvrSiVU/CTzAB99TPQCS6dKA1vbNGiF3sBemBmoqFm
 raVFYp530fb0EfSIR2VqihliaV7wHGwtNniS6Btur83nK+Hl92ckemoHdg5wyRHk
 3GNwg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44m1uvg0mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Feb 2025 21:43:02 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 4 Feb 2025 21:43:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 4 Feb 2025 21:43:00 -0800
Received: from cavium-OptiPlex-3070-BM17.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id 41F183F7078;
 Tue,  4 Feb 2025 21:42:58 -0800 (PST)
From: <psatheesh@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>
Subject: [dpdk-dev] [PATCH v5 2/2] net/cnxk: support rte flow on cn20k
Date: Wed, 5 Feb 2025 11:12:47 +0530
Message-ID: <20250205054247.1214565-2-psatheesh@marvell.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250205054247.1214565-1-psatheesh@marvell.com>
References: <20241021040144.974453-1-psatheesh@marvell.com>
 <20250205054247.1214565-1-psatheesh@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YqR_V5aqmHZjoW951JVIfvAL0pBW5tvA
X-Proofpoint-GUID: YqR_V5aqmHZjoW951JVIfvAL0pBW5tvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_02,2025-02-05_01,2024-11-22_01
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

From: Satheesh Paul <psatheesh@marvell.com>

Support for rte flow in cn20k.

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>
---
 doc/guides/rel_notes/release_25_03.rst |   4 +
 drivers/net/cnxk/cn10k_flow.c          | 227 ++-----------------------
 drivers/net/cnxk/cn10k_flow.h          |  10 +-
 drivers/net/cnxk/cn20k_ethdev.c        |   4 +
 drivers/net/cnxk/cn20k_flow.c          | 101 +++++++++++
 drivers/net/cnxk/cn20k_flow.h          |  21 +++
 drivers/net/cnxk/cn9k_flow.c           |   2 +-
 drivers/net/cnxk/cnxk_ethdev_devargs.c |  10 +-
 drivers/net/cnxk/cnxk_flow.c           |  18 +-
 drivers/net/cnxk/cnxk_flow.h           |   5 +-
 drivers/net/cnxk/cnxk_flow_common.c    | 213 +++++++++++++++++++++++
 drivers/net/cnxk/cnxk_flow_common.h    |  19 +++
 drivers/net/cnxk/meson.build           |   2 +
 13 files changed, 399 insertions(+), 237 deletions(-)
 create mode 100644 drivers/net/cnxk/cn20k_flow.c
 create mode 100644 drivers/net/cnxk/cn20k_flow.h
 create mode 100644 drivers/net/cnxk/cnxk_flow_common.c
 create mode 100644 drivers/net/cnxk/cnxk_flow_common.h

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 85986ffa61..18a675a6ef 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -63,6 +63,10 @@ New Features
   and even substantial part of its code.
   It can be viewed as an extension of rte_ring functionality.
 
+* **Updated Marvell cnxk net driver.**
+
+  * Added rte_flow support for CN20K SoC.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/cnxk/cn10k_flow.c b/drivers/net/cnxk/cn10k_flow.c
index db5e427362..b95fb83f08 100644
--- a/drivers/net/cnxk/cn10k_flow.c
+++ b/drivers/net/cnxk/cn10k_flow.c
@@ -1,215 +1,29 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2020 Marvell.
  */
-#include "cn10k_flow.h"
+
 #include "cn10k_ethdev.h"
 #include "cn10k_rx.h"
 #include "cnxk_ethdev_mcs.h"
+#include "cnxk_flow_common.h"
+#include <cn10k_flow.h>
 #include <cnxk_flow.h>
 
-static int
-cn10k_mtr_connect(struct rte_eth_dev *eth_dev, uint32_t mtr_id)
-{
-	return nix_mtr_connect(eth_dev, mtr_id);
-}
-
-static int
-cn10k_mtr_destroy(struct rte_eth_dev *eth_dev, uint32_t mtr_id)
-{
-	struct rte_mtr_error mtr_error;
-
-	return nix_mtr_destroy(eth_dev, mtr_id, &mtr_error);
-}
-
-static int
-cn10k_mtr_configure(struct rte_eth_dev *eth_dev,
-		    const struct rte_flow_action actions[])
-{
-	uint32_t mtr_id = 0xffff, prev_mtr_id = 0xffff, next_mtr_id = 0xffff;
-	const struct rte_flow_action_meter *mtr_conf;
-	const struct rte_flow_action_queue *q_conf;
-	const struct rte_flow_action_rss *rss_conf;
-	struct cnxk_mtr_policy_node *policy;
-	bool is_mtr_act = false;
-	int tree_level = 0;
-	int rc = -EINVAL, i;
-
-	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
-		if (actions[i].type == RTE_FLOW_ACTION_TYPE_METER) {
-			mtr_conf = (const struct rte_flow_action_meter
-					    *)(actions[i].conf);
-			mtr_id = mtr_conf->mtr_id;
-			is_mtr_act = true;
-		}
-		if (actions[i].type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-			q_conf = (const struct rte_flow_action_queue
-					  *)(actions[i].conf);
-			if (is_mtr_act)
-				nix_mtr_rq_update(eth_dev, mtr_id, 1,
-						  &q_conf->index);
-		}
-		if (actions[i].type == RTE_FLOW_ACTION_TYPE_RSS) {
-			rss_conf = (const struct rte_flow_action_rss
-					    *)(actions[i].conf);
-			if (is_mtr_act)
-				nix_mtr_rq_update(eth_dev, mtr_id,
-						  rss_conf->queue_num,
-						  rss_conf->queue);
-		}
-	}
-
-	if (!is_mtr_act)
-		return rc;
-
-	prev_mtr_id = mtr_id;
-	next_mtr_id = mtr_id;
-	while (next_mtr_id != 0xffff) {
-		rc = nix_mtr_validate(eth_dev, next_mtr_id);
-		if (rc)
-			return rc;
-
-		rc = nix_mtr_policy_act_get(eth_dev, next_mtr_id, &policy);
-		if (rc)
-			return rc;
-
-		rc = nix_mtr_color_action_validate(eth_dev, mtr_id,
-						   &prev_mtr_id, &next_mtr_id,
-						   policy, &tree_level);
-		if (rc)
-			return rc;
-	}
-
-	return nix_mtr_configure(eth_dev, mtr_id);
-}
-
-static int
-cn10k_rss_action_validate(struct rte_eth_dev *eth_dev,
-			  const struct rte_flow_attr *attr,
-			  const struct rte_flow_action *act)
-{
-	const struct rte_flow_action_rss *rss;
-
-	if (act == NULL)
-		return -EINVAL;
-
-	rss = (const struct rte_flow_action_rss *)act->conf;
-
-	if (attr->egress) {
-		plt_err("No support of RSS in egress");
-		return -EINVAL;
-	}
-
-	if (eth_dev->data->dev_conf.rxmode.mq_mode != RTE_ETH_MQ_RX_RSS) {
-		plt_err("multi-queue mode is disabled");
-		return -ENOTSUP;
-	}
-
-	if (!rss || !rss->queue_num) {
-		plt_err("no valid queues");
-		return -EINVAL;
-	}
-
-	if (rss->func != RTE_ETH_HASH_FUNCTION_DEFAULT) {
-		plt_err("non-default RSS hash functions are not supported");
-		return -ENOTSUP;
-	}
-
-	if (rss->key_len && rss->key_len > ROC_NIX_RSS_KEY_LEN) {
-		plt_err("RSS hash key too large");
-		return -ENOTSUP;
-	}
-
-	return 0;
-}
-
 struct rte_flow *
 cn10k_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
-		  const struct rte_flow_item pattern[],
-		  const struct rte_flow_action actions[],
+		  const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
 		  struct rte_flow_error *error)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
-	const struct rte_flow_action *action_rss = NULL;
-	const struct rte_flow_action_meter *mtr = NULL;
-	const struct rte_flow_action *act_q = NULL;
 	struct roc_npc *npc = &dev->npc;
 	struct roc_npc_flow *flow;
-	void *mcs_flow = NULL;
 	int vtag_actions = 0;
-	uint32_t req_act = 0;
 	int mark_actions;
-	int i, rc;
-
-	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
-		if (actions[i].type == RTE_FLOW_ACTION_TYPE_METER)
-			req_act |= ROC_NPC_ACTION_TYPE_METER;
-
-		if (actions[i].type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-			req_act |= ROC_NPC_ACTION_TYPE_QUEUE;
-			act_q = &actions[i];
-		}
-		if (actions[i].type == RTE_FLOW_ACTION_TYPE_RSS) {
-			req_act |= ROC_NPC_ACTION_TYPE_RSS;
-			action_rss = &actions[i];
-		}
-	}
-
-	if (req_act & ROC_NPC_ACTION_TYPE_METER) {
-		if ((req_act & ROC_NPC_ACTION_TYPE_RSS) &&
-		    ((req_act & ROC_NPC_ACTION_TYPE_QUEUE))) {
-			return NULL;
-		}
-		if (req_act & ROC_NPC_ACTION_TYPE_RSS) {
-			rc = cn10k_rss_action_validate(eth_dev, attr,
-						       action_rss);
-			if (rc)
-				return NULL;
-		} else if (req_act & ROC_NPC_ACTION_TYPE_QUEUE) {
-			const struct rte_flow_action_queue *act_queue;
-			act_queue = (const struct rte_flow_action_queue *)
-					    act_q->conf;
-			if (act_queue->index > eth_dev->data->nb_rx_queues)
-				return NULL;
-		} else {
-			return NULL;
-		}
-	}
-	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
-		if (actions[i].type == RTE_FLOW_ACTION_TYPE_METER) {
-			mtr = (const struct rte_flow_action_meter *)actions[i]
-				      .conf;
-			rc = cn10k_mtr_configure(eth_dev, actions);
-			if (rc) {
-				rte_flow_error_set(error, rc,
-					RTE_FLOW_ERROR_TYPE_ACTION, NULL,
-					"Failed to configure mtr ");
-				return NULL;
-			}
-			break;
-		}
-	}
-
-	if (actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY &&
-	    cnxk_eth_macsec_sess_get_by_sess(dev, actions[0].conf) != NULL) {
-		rc = cnxk_mcs_flow_configure(eth_dev, attr, pattern, actions, error, &mcs_flow);
-		if (rc) {
-			rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
-					   "Failed to configure mcs flow");
-			return NULL;
-		}
-		return (struct rte_flow *)mcs_flow;
-	}
 
 	flow = cnxk_flow_create(eth_dev, attr, pattern, actions, error);
-	if (!flow) {
-		if (mtr)
-			nix_mtr_chain_reset(eth_dev, mtr->mtr_id);
 
+	if (!flow)
 		return NULL;
-	} else {
-		if (mtr)
-			cn10k_mtr_connect(eth_dev, mtr->mtr_id);
-	}
 
 	mark_actions = roc_npc_mark_actions_get(npc);
 	if (mark_actions) {
@@ -231,16 +45,7 @@ int
 cn10k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
 		    struct rte_flow_queue_info *queue_info, struct rte_flow_error *err)
 {
-	RTE_SET_USED(dev);
-	RTE_SET_USED(err);
-
-	memset(port_info, 0, sizeof(*port_info));
-	memset(queue_info, 0, sizeof(*queue_info));
-
-	port_info->max_nb_counters = CN10K_NPC_COUNTERS_MAX;
-	port_info->max_nb_meters = CNXK_NIX_MTR_COUNT_MAX;
-
-	return 0;
+	return cnxk_flow_info_get_common(dev, port_info, queue_info, err);
 }
 
 int
@@ -250,14 +55,12 @@ cn10k_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *rte_flow,
 	struct roc_npc_flow *flow = (struct roc_npc_flow *)rte_flow;
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_npc *npc = &dev->npc;
-	int vtag_actions = 0;
+	int vtag_actions = 0, rc = 0;
 	int mark_actions;
 	uint16_t match_id;
 	uint32_t mtr_id;
-	int rc;
 
-	match_id = (flow->npc_action >> NPC_RX_ACT_MATCH_OFFSET) &
-		   NPC_RX_ACT_MATCH_MASK;
+	match_id = (flow->npc_action >> NPC_RX_ACT_MATCH_OFFSET) & NPC_RX_ACT_MATCH_MASK;
 	if (match_id) {
 		mark_actions = roc_npc_mark_actions_sub_return(npc, 1);
 		if (mark_actions == 0) {
@@ -271,8 +74,7 @@ cn10k_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *rte_flow,
 		if (flow->nix_intf == ROC_NPC_INTF_RX) {
 			vtag_actions = roc_npc_vtag_actions_sub_return(npc, 1);
 			if (vtag_actions == 0) {
-				dev->rx_offload_flags &=
-					~NIX_RX_OFFLOAD_VLAN_STRIP_F;
+				dev->rx_offload_flags &= ~NIX_RX_OFFLOAD_VLAN_STRIP_F;
 				cn10k_eth_set_rx_function(eth_dev);
 			}
 		}
@@ -281,19 +83,18 @@ cn10k_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *rte_flow,
 	if (cnxk_eth_macsec_sess_get_by_sess(dev, (void *)flow) != NULL) {
 		rc = cnxk_mcs_flow_destroy(dev, (void *)flow);
 		if (rc < 0)
-			rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-					NULL, "Failed to free mcs flow");
+			rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					   "Failed to free mcs flow");
 		return rc;
 	}
 
 	mtr_id = flow->mtr_id;
 	rc = cnxk_flow_destroy(eth_dev, flow, error);
 	if (!rc && mtr_id != ROC_NIX_MTR_ID_INVALID) {
-		rc = cn10k_mtr_destroy(eth_dev, mtr_id);
+		rc = cnxk_mtr_destroy(eth_dev, mtr_id);
 		if (rc) {
-			rte_flow_error_set(error, ENXIO,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-				"Meter attached to this flow does not exist");
+			rte_flow_error_set(error, ENXIO, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					   "Meter attached to this flow does not exist");
 		}
 	}
 	return rc;
diff --git a/drivers/net/cnxk/cn10k_flow.h b/drivers/net/cnxk/cn10k_flow.h
index 316b74e6a6..c9e8c86e96 100644
--- a/drivers/net/cnxk/cn10k_flow.h
+++ b/drivers/net/cnxk/cn10k_flow.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(C) 2020 Marvell.
+ * Copyright(C) 2024 Marvell.
  */
-#ifndef __CN10K_RTE_FLOW_H__
-#define __CN10K_RTE_FLOW_H__
+#ifndef __CN10K_FLOW_H__
+#define __CN10K_FLOW_H__
 
 #include <rte_flow_driver.h>
 
@@ -16,6 +16,6 @@ int cn10k_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
 int cn10k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
 			struct rte_flow_queue_info *queue_info, struct rte_flow_error *err);
 
-#define CN10K_NPC_COUNTERS_MAX 512
+#define CNXK_NPC_COUNTERS_MAX 512
 
-#endif /* __CN10K_RTE_FLOW_H__ */
+#endif /* __CN10K_FLOW_H__ */
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 37c372d80f..4e4337a6e5 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2024 Marvell.
  */
 #include "cn20k_ethdev.h"
+#include "cn20k_flow.h"
 #include "cn20k_rx.h"
 #include "cn20k_tx.h"
 
@@ -867,6 +868,9 @@ npc_flow_ops_override(void)
 	init_once = 1;
 
 	/* Update platform specific ops */
+	cnxk_flow_ops.create = cn20k_flow_create;
+	cnxk_flow_ops.destroy = cn20k_flow_destroy;
+	cnxk_flow_ops.info_get = cn20k_flow_info_get;
 }
 
 static int
diff --git a/drivers/net/cnxk/cn20k_flow.c b/drivers/net/cnxk/cn20k_flow.c
new file mode 100644
index 0000000000..fd50f516ee
--- /dev/null
+++ b/drivers/net/cnxk/cn20k_flow.c
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2024 Marvell.
+ */
+
+#include "cn20k_ethdev.h"
+#include "cn20k_rx.h"
+#include "cnxk_ethdev_mcs.h"
+#include "cnxk_flow_common.h"
+#include <cn20k_flow.h>
+#include <cnxk_flow.h>
+
+struct rte_flow *
+cn20k_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
+		  const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
+		  struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	struct roc_npc_flow *flow;
+	int vtag_actions = 0;
+	int mark_actions;
+
+	flow = cnxk_flow_create(eth_dev, attr, pattern, actions, error);
+
+	if (!flow)
+		return NULL;
+
+	mark_actions = roc_npc_mark_actions_get(npc);
+	if (mark_actions) {
+		dev->rx_offload_flags |= NIX_RX_OFFLOAD_MARK_UPDATE_F;
+		cn20k_eth_set_rx_function(eth_dev);
+	}
+
+	vtag_actions = roc_npc_vtag_actions_get(npc);
+
+	if (vtag_actions) {
+		dev->rx_offload_flags |= NIX_RX_OFFLOAD_VLAN_STRIP_F;
+		cn20k_eth_set_rx_function(eth_dev);
+	}
+
+	return (struct rte_flow *)flow;
+}
+
+int
+cn20k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
+		    struct rte_flow_queue_info *queue_info, struct rte_flow_error *err)
+{
+	return cnxk_flow_info_get_common(dev, port_info, queue_info, err);
+}
+
+int
+cn20k_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *rte_flow,
+		   struct rte_flow_error *error)
+{
+	struct roc_npc_flow *flow = (struct roc_npc_flow *)rte_flow;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	int vtag_actions = 0, rc = 0;
+	int mark_actions;
+	uint16_t match_id;
+	uint32_t mtr_id;
+
+	match_id = (flow->npc_action >> NPC_RX_ACT_MATCH_OFFSET) & NPC_RX_ACT_MATCH_MASK;
+	if (match_id) {
+		mark_actions = roc_npc_mark_actions_sub_return(npc, 1);
+		if (mark_actions == 0) {
+			dev->rx_offload_flags &= ~NIX_RX_OFFLOAD_MARK_UPDATE_F;
+			cn20k_eth_set_rx_function(eth_dev);
+		}
+	}
+
+	vtag_actions = roc_npc_vtag_actions_get(npc);
+	if (vtag_actions) {
+		if (flow->nix_intf == ROC_NPC_INTF_RX) {
+			vtag_actions = roc_npc_vtag_actions_sub_return(npc, 1);
+			if (vtag_actions == 0) {
+				dev->rx_offload_flags &= ~NIX_RX_OFFLOAD_VLAN_STRIP_F;
+				cn20k_eth_set_rx_function(eth_dev);
+			}
+		}
+	}
+
+	if (cnxk_eth_macsec_sess_get_by_sess(dev, (void *)flow) != NULL) {
+		rc = cnxk_mcs_flow_destroy(dev, (void *)flow);
+		if (rc < 0)
+			rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					   "Failed to free mcs flow");
+		return rc;
+	}
+
+	mtr_id = flow->mtr_id;
+	rc = cnxk_flow_destroy(eth_dev, flow, error);
+	if (!rc && mtr_id != ROC_NIX_MTR_ID_INVALID) {
+		rc = cnxk_mtr_destroy(eth_dev, mtr_id);
+		if (rc) {
+			rte_flow_error_set(error, ENXIO, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					   "Meter attached to this flow does not exist");
+		}
+	}
+	return rc;
+}
diff --git a/drivers/net/cnxk/cn20k_flow.h b/drivers/net/cnxk/cn20k_flow.h
new file mode 100644
index 0000000000..1e4bd6214a
--- /dev/null
+++ b/drivers/net/cnxk/cn20k_flow.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2024 Marvell.
+ */
+#ifndef __CN20K_FLOW_H__
+#define __CN20K_FLOW_H__
+
+#include <rte_flow_driver.h>
+
+struct rte_flow *cn20k_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+				   const struct rte_flow_item pattern[],
+				   const struct rte_flow_action actions[],
+				   struct rte_flow_error *error);
+int cn20k_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
+		       struct rte_flow_error *error);
+
+int cn20k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
+			struct rte_flow_queue_info *queue_info, struct rte_flow_error *err);
+
+#define CNXK_NPC_COUNTERS_MAX 512
+
+#endif /* __CN20K_FLOW_H__ */
diff --git a/drivers/net/cnxk/cn9k_flow.c b/drivers/net/cnxk/cn9k_flow.c
index dc5476a189..ae4629ea69 100644
--- a/drivers/net/cnxk/cn9k_flow.c
+++ b/drivers/net/cnxk/cn9k_flow.c
@@ -18,7 +18,7 @@ cn9k_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 	int vtag_actions = 0;
 	int mark_actions;
 
-	flow = cnxk_flow_create(eth_dev, attr, pattern, actions, error);
+	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, false);
 	if (!flow)
 		return NULL;
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index ecc2ea8b77..aa2fe7dfe1 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -88,8 +88,7 @@ parse_flow_max_priority(const char *key, const char *value, void *extra_args)
 
 	val = atoi(value);
 
-	/* Limit the max priority to 32 */
-	if (val < 1 || val > 32)
+	if (val < 1 || val > ROC_NPC_MAX_MCAM_PRIORITY)
 		return -EINVAL;
 
 	*(uint16_t *)extra_args = val;
@@ -390,7 +389,12 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 		dev->nix.meta_buf_sz = meta_buf_sz;
 
 	dev->npc.flow_prealloc_size = flow_prealloc_size;
-	dev->npc.flow_max_priority = flow_max_priority;
+
+	if (roc_model_is_cn20k())
+		dev->npc.flow_max_priority = ROC_NPC_MAX_MCAM_PRIORITY;
+	else
+		dev->npc.flow_max_priority = flow_max_priority;
+
 	dev->npc.switch_header_type = switch_header_type;
 	dev->npc.sdp_channel = sdp_chan.channel;
 	dev->npc.sdp_channel_mask = sdp_chan.mask;
diff --git a/drivers/net/cnxk/cnxk_flow.c b/drivers/net/cnxk/cnxk_flow.c
index e42e2f8deb..fcc60cd4f0 100644
--- a/drivers/net/cnxk/cnxk_flow.c
+++ b/drivers/net/cnxk/cnxk_flow.c
@@ -977,14 +977,6 @@ cnxk_flow_create_common(struct rte_eth_dev *eth_dev, const struct rte_flow_attr
 	return flow;
 }
 
-struct roc_npc_flow *
-cnxk_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
-		 const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
-		 struct rte_flow_error *error)
-{
-	return cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, false);
-}
-
 int
 cnxk_flow_destroy_common(struct rte_eth_dev *eth_dev, struct roc_npc_flow *flow,
 			 struct rte_flow_error *error, bool is_rep)
@@ -1083,10 +1075,14 @@ cnxk_flow_query_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow,
 		npc = &rep_dev->parent_dev->npc;
 	}
 
-	if (in_flow->use_pre_alloc)
+	if (in_flow->use_pre_alloc) {
 		rc = roc_npc_inl_mcam_read_counter(in_flow->ctr_id, &query->hits);
-	else
-		rc = roc_npc_mcam_read_counter(npc, in_flow->ctr_id, &query->hits);
+	} else {
+		if (roc_model_is_cn20k())
+			rc = roc_npc_mcam_get_stats(npc, in_flow, &query->hits);
+		else
+			rc = roc_npc_mcam_read_counter(npc, in_flow->ctr_id, &query->hits);
+	}
 	if (rc != 0) {
 		errcode = EIO;
 		errmsg = "Error reading flow counter";
diff --git a/drivers/net/cnxk/cnxk_flow.h b/drivers/net/cnxk/cnxk_flow.h
index e51d04b2c9..80b8d2c36a 100644
--- a/drivers/net/cnxk/cnxk_flow.h
+++ b/drivers/net/cnxk/cnxk_flow.h
@@ -22,10 +22,6 @@ struct cnxk_rte_flow_action_info {
 
 extern const struct cnxk_rte_flow_term_info term[];
 
-struct roc_npc_flow *cnxk_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-				      const struct rte_flow_item pattern[],
-				      const struct rte_flow_action actions[],
-				      struct rte_flow_error *error);
 int cnxk_flow_destroy(struct rte_eth_dev *dev, struct roc_npc_flow *flow,
 		      struct rte_flow_error *error);
 
@@ -46,5 +42,6 @@ int cnxk_flow_query_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow,
 			   struct rte_flow_error *error, bool is_rep);
 int cnxk_flow_dev_dump_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow, FILE *file,
 			      struct rte_flow_error *error, bool is_rep);
+int cnxk_mtr_destroy(struct rte_eth_dev *eth_dev, uint32_t mtr_id);
 
 #endif /* __CNXK_RTE_FLOW_H__ */
diff --git a/drivers/net/cnxk/cnxk_flow_common.c b/drivers/net/cnxk/cnxk_flow_common.c
new file mode 100644
index 0000000000..59aa920d91
--- /dev/null
+++ b/drivers/net/cnxk/cnxk_flow_common.c
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2024 Marvell.
+ */
+
+#include "cnxk_flow_common.h"
+#include "cnxk_ethdev_mcs.h"
+#include <cnxk_flow.h>
+
+static int
+cnxk_mtr_connect(struct rte_eth_dev *eth_dev, uint32_t mtr_id)
+{
+	return nix_mtr_connect(eth_dev, mtr_id);
+}
+
+int
+cnxk_mtr_destroy(struct rte_eth_dev *eth_dev, uint32_t mtr_id)
+{
+	struct rte_mtr_error mtr_error;
+
+	return nix_mtr_destroy(eth_dev, mtr_id, &mtr_error);
+}
+
+static int
+cnxk_mtr_configure(struct rte_eth_dev *eth_dev, const struct rte_flow_action actions[])
+{
+	uint32_t mtr_id = 0xffff, prev_mtr_id = 0xffff, next_mtr_id = 0xffff;
+	const struct rte_flow_action_meter *mtr_conf;
+	const struct rte_flow_action_queue *q_conf;
+	const struct rte_flow_action_rss *rss_conf;
+	struct cnxk_mtr_policy_node *policy;
+	bool is_mtr_act = false;
+	int tree_level = 0;
+	int rc = -EINVAL, i;
+
+	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_METER) {
+			mtr_conf = (const struct rte_flow_action_meter *)(actions[i].conf);
+			mtr_id = mtr_conf->mtr_id;
+			is_mtr_act = true;
+		}
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+			q_conf = (const struct rte_flow_action_queue *)(actions[i].conf);
+			if (is_mtr_act)
+				nix_mtr_rq_update(eth_dev, mtr_id, 1, &q_conf->index);
+		}
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_RSS) {
+			rss_conf = (const struct rte_flow_action_rss *)(actions[i].conf);
+			if (is_mtr_act)
+				nix_mtr_rq_update(eth_dev, mtr_id, rss_conf->queue_num,
+						  rss_conf->queue);
+		}
+	}
+
+	if (!is_mtr_act)
+		return rc;
+
+	prev_mtr_id = mtr_id;
+	next_mtr_id = mtr_id;
+	while (next_mtr_id != 0xffff) {
+		rc = nix_mtr_validate(eth_dev, next_mtr_id);
+		if (rc)
+			return rc;
+
+		rc = nix_mtr_policy_act_get(eth_dev, next_mtr_id, &policy);
+		if (rc)
+			return rc;
+
+		rc = nix_mtr_color_action_validate(eth_dev, mtr_id, &prev_mtr_id, &next_mtr_id,
+						   policy, &tree_level);
+		if (rc)
+			return rc;
+	}
+
+	return nix_mtr_configure(eth_dev, mtr_id);
+}
+
+static int
+cnxk_rss_action_validate(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
+			 const struct rte_flow_action *act)
+{
+	const struct rte_flow_action_rss *rss;
+
+	if (act == NULL)
+		return -EINVAL;
+
+	rss = (const struct rte_flow_action_rss *)act->conf;
+
+	if (attr->egress) {
+		plt_err("No support of RSS in egress");
+		return -EINVAL;
+	}
+
+	if (eth_dev->data->dev_conf.rxmode.mq_mode != RTE_ETH_MQ_RX_RSS) {
+		plt_err("multi-queue mode is disabled");
+		return -ENOTSUP;
+	}
+
+	if (!rss || !rss->queue_num) {
+		plt_err("no valid queues");
+		return -EINVAL;
+	}
+
+	if (rss->func != RTE_ETH_HASH_FUNCTION_DEFAULT) {
+		plt_err("non-default RSS hash functions are not supported");
+		return -ENOTSUP;
+	}
+
+	if (rss->key_len && rss->key_len > ROC_NIX_RSS_KEY_LEN) {
+		plt_err("RSS hash key too large");
+		return -ENOTSUP;
+	}
+
+	return 0;
+}
+
+struct roc_npc_flow *
+cnxk_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
+		 const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
+		 struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	const struct rte_flow_action *action_rss = NULL;
+	const struct rte_flow_action_meter *mtr = NULL;
+	const struct rte_flow_action *act_q = NULL;
+	struct roc_npc_flow *flow;
+	void *mcs_flow = NULL;
+	uint32_t req_act = 0;
+	int i, rc;
+
+	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_METER)
+			req_act |= ROC_NPC_ACTION_TYPE_METER;
+
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+			req_act |= ROC_NPC_ACTION_TYPE_QUEUE;
+			act_q = &actions[i];
+		}
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_RSS) {
+			req_act |= ROC_NPC_ACTION_TYPE_RSS;
+			action_rss = &actions[i];
+		}
+	}
+
+	if (req_act & ROC_NPC_ACTION_TYPE_METER) {
+		if ((req_act & ROC_NPC_ACTION_TYPE_RSS) &&
+		    ((req_act & ROC_NPC_ACTION_TYPE_QUEUE))) {
+			return NULL;
+		}
+		if (req_act & ROC_NPC_ACTION_TYPE_RSS) {
+			rc = cnxk_rss_action_validate(eth_dev, attr, action_rss);
+			if (rc)
+				return NULL;
+		} else if (req_act & ROC_NPC_ACTION_TYPE_QUEUE) {
+			const struct rte_flow_action_queue *act_queue;
+			act_queue = (const struct rte_flow_action_queue *)act_q->conf;
+			if (act_queue->index > eth_dev->data->nb_rx_queues)
+				return NULL;
+		} else {
+			return NULL;
+		}
+	}
+	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
+		if (actions[i].type == RTE_FLOW_ACTION_TYPE_METER) {
+			mtr = (const struct rte_flow_action_meter *)actions[i].conf;
+			rc = cnxk_mtr_configure(eth_dev, actions);
+			if (rc) {
+				rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+						   "Failed to configure mtr ");
+				return NULL;
+			}
+			break;
+		}
+	}
+
+	if (actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY &&
+	    cnxk_eth_macsec_sess_get_by_sess(dev, actions[0].conf) != NULL) {
+		rc = cnxk_mcs_flow_configure(eth_dev, attr, pattern, actions, error, &mcs_flow);
+		if (rc) {
+			rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+					   "Failed to configure mcs flow");
+			return NULL;
+		}
+		return mcs_flow;
+	}
+
+	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, false);
+	if (!flow) {
+		if (mtr)
+			nix_mtr_chain_reset(eth_dev, mtr->mtr_id);
+
+	} else {
+		if (mtr)
+			cnxk_mtr_connect(eth_dev, mtr->mtr_id);
+	}
+
+	return flow;
+}
+
+int
+cnxk_flow_info_get_common(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
+			  struct rte_flow_queue_info *queue_info, struct rte_flow_error *err)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(err);
+
+	memset(port_info, 0, sizeof(*port_info));
+	memset(queue_info, 0, sizeof(*queue_info));
+
+	port_info->max_nb_counters = CNXK_NPC_COUNTERS_MAX;
+	port_info->max_nb_meters = CNXK_NIX_MTR_COUNT_MAX;
+
+	return 0;
+}
diff --git a/drivers/net/cnxk/cnxk_flow_common.h b/drivers/net/cnxk/cnxk_flow_common.h
new file mode 100644
index 0000000000..21289d9daf
--- /dev/null
+++ b/drivers/net/cnxk/cnxk_flow_common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2024 Marvell.
+ */
+#ifndef __CNXK_FLOW_COMMON_H__
+#define __CNXK_FLOW_COMMON_H__
+
+#include <rte_flow_driver.h>
+
+struct roc_npc_flow *cnxk_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+				      const struct rte_flow_item pattern[],
+				      const struct rte_flow_action actions[],
+				      struct rte_flow_error *error);
+
+int cnxk_flow_info_get_common(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
+			      struct rte_flow_queue_info *queue_info, struct rte_flow_error *err);
+
+#define CNXK_NPC_COUNTERS_MAX 512
+
+#endif /* __CNXK_FLOW_COMMON_H__ */
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index 32ff8aadc0..733ee61c0a 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -32,6 +32,7 @@ sources = files(
         'cnxk_eswitch_devargs.c',
         'cnxk_eswitch_flow.c',
         'cnxk_eswitch_rxtx.c',
+        'cnxk_flow_common.c',
         'cnxk_link.c',
         'cnxk_lookup.c',
         'cnxk_ptp.c',
@@ -236,6 +237,7 @@ if soc_type == 'cn20k' or soc_type == 'all'
 # CN20K
 sources += files(
         'cn20k_ethdev.c',
+        'cn20k_flow.c',
         'cn20k_rx_select.c',
         'cn20k_tx_select.c',
 )
-- 
2.39.2


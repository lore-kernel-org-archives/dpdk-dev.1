Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F770FCE078
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:18:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EF4C4065C;
	Thu, 26 Feb 2026 14:18:47 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AAC6040676
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:18:45 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61Q6u4vf1363432 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 47PDgcgMoUZ9DF96CxNNnGzRPdBaXCvo8oPd6yKkH0=; b=Dev8yVNnONwMc5V3T
 AzeZbE8xHn58OMgWBvj8nnmEy05bp5iCGTArBIxXXNxg1Fqog//N3JTy/95VnmhW
 6rWBAbjEB57M4wpiMzj+XHsDHktL7//Rkp+85RptAReooEmy+nZwNFBUDAlJpE7d
 xV8kHMW3Dji/8NOYbHslQfPkqfVBRZfrjZJamN5BloUXnJ3uvUw+YfOFBzoh7iru
 RTcns4+qAObUBofh21V9PPoZxbSNoLRuvhXQ5iGDR5ErO81ekgfrfe9CjLz8wg24
 mCNohDOxVvAVQPino2e4eqT9GQXuuZKacK3bMFrwj7hxjiLdNse8OwWlI1ftodpl
 dTHKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcyveuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 05:18:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 05:18:43 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 751513F70D4;
 Thu, 26 Feb 2026 05:18:41 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 7/8] net/cnxk: flow rule update for non-in-place IPsec
Date: Thu, 26 Feb 2026 18:47:14 +0530
Message-ID: <20260226131715.2851091-7-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226131715.2851091-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260226131715.2851091-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N3t_a-QH6hBzfpX8ff0P2ScQGKe7iiud
X-Proofpoint-ORIG-GUID: N3t_a-QH6hBzfpX8ff0P2ScQGKe7iiud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyMCBTYWx0ZWRfX/UusgnbT6jup
 HH1xF11Jy33i+ivJnAL0w4M7TVbhL5Kk2Jt4JcFR+WLNZ0gjIkGU7wp696xDuSAcnwU3BuJdyEx
 7mAkqWc6nE/BGG55cfXnj125CTMj/QeJ7McqFLAPfw6xH/YNL+p9dCuD181cpBTvYc2v2EijWiQ
 uMkmSvKFp7fEAHfXcm5UW2KT7VX84tQqLX7e+6IBELXYn/e7+u4UjFiUeaG/uXh9+wT0oJ59P7s
 8t/ki8shMwc49/uDsZMH8KATHUoFRTqGh/r4M3Y4LH0fDuxT5DjuNi+1I7nP9iqFW1XqDIAReWc
 2mvMa2a+Xf37CICXWd+hcLkawdyyT2vGWLQTuOQDrMP/FvPfTHtouE8tFGxhhNziDg42POyxPMq
 uK6PbTHGwFwtyWwd9ZpYtL/9TQlasN5bZqOZZeCWmAPZtcLgSdDUl8Tth5G0IOu2Dvbj4MBQi0i
 NTrARgZC+yfEEVJQegw==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=69a04834 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=EDlb0x0Qip4Iq_TPoc0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
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

Updates flow rule based of inbound non-inplace (Out-Of-Place)
config of IPsec session.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No changes.

 drivers/net/cnxk/cn9k_flow.c        |  2 +-
 drivers/net/cnxk/cnxk_ethdev.h      |  6 +++---
 drivers/net/cnxk/cnxk_ethdev_sec.c  |  3 +--
 drivers/net/cnxk/cnxk_flow.c        | 31 +++++++++++++++++++++--------
 drivers/net/cnxk/cnxk_flow.h        |  8 ++++++--
 drivers/net/cnxk/cnxk_flow_common.c | 12 ++++++++++-
 drivers/net/cnxk/cnxk_rep_flow.c    |  4 ++--
 drivers/net/cnxk/rte_pmd_cnxk.h     |  1 +
 8 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/net/cnxk/cn9k_flow.c b/drivers/net/cnxk/cn9k_flow.c
index ae4629ea69..c39564201d 100644
--- a/drivers/net/cnxk/cn9k_flow.c
+++ b/drivers/net/cnxk/cn9k_flow.c
@@ -18,7 +18,7 @@ cn9k_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 	int vtag_actions = 0;
 	int mark_actions;

-	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, false);
+	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, false, 0);
 	if (!flow)
 		return NULL;

diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 1b63b02ad8..e3edf39a5c 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -747,9 +747,9 @@ int cnxk_nix_inline_inbound_mode_setup(struct cnxk_eth_dev *dev);

 struct cnxk_eth_sec_sess *cnxk_eth_sec_sess_get_by_sa_idx(struct cnxk_eth_dev *dev,
 							  uint32_t sa_idx, bool inb);
-struct cnxk_eth_sec_sess *
-cnxk_eth_sec_sess_get_by_sess(struct cnxk_eth_dev *dev,
-			      struct rte_security_session *sess);
+struct cnxk_eth_sec_sess *cnxk_eth_sec_sess_get_by_sess(struct cnxk_eth_dev *dev,
+							const struct rte_security_session *sess);
+
 int cnxk_nix_inl_meta_pool_cb(uint64_t *aura_handle, uintptr_t *mpool, uint32_t buf_sz,
 			      uint32_t nb_bufs, bool destroy, const char *mempool_name);
 int cnxk_nix_inl_custom_meta_pool_cb(uintptr_t pmpool, uintptr_t *mpool, const char *mempool_name,
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index 59a00408ad..abb50d32de 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -287,8 +287,7 @@ cnxk_eth_sec_sess_get_by_sa_idx(struct cnxk_eth_dev *dev, uint32_t sa_idx, bool
 }

 struct cnxk_eth_sec_sess *
-cnxk_eth_sec_sess_get_by_sess(struct cnxk_eth_dev *dev,
-			      struct rte_security_session *sess)
+cnxk_eth_sec_sess_get_by_sess(struct cnxk_eth_dev *dev, const struct rte_security_session *sess)
 {
 	struct cnxk_eth_sec_sess *eth_sec = NULL;

diff --git a/drivers/net/cnxk/cnxk_flow.c b/drivers/net/cnxk/cnxk_flow.c
index 33501310e0..c1c48eb7ab 100644
--- a/drivers/net/cnxk/cnxk_flow.c
+++ b/drivers/net/cnxk/cnxk_flow.c
@@ -465,7 +465,7 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 		 const struct rte_flow_action actions[], struct roc_npc_action in_actions[],
 		 struct roc_npc_action_sample *in_sample_actions, uint32_t *flowkey_cfg,
 		 uint16_t *dst_pf_func, uint64_t *npc_default_action, uint8_t has_tunnel_pattern,
-		 bool is_rep, uint8_t rep_pattern, uint64_t *free_allocs)
+		 bool is_rep, uint8_t rep_pattern, uint64_t *free_allocs, uint32_t flow_flags)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	const struct rte_flow_action_queue *act_q = NULL;
@@ -614,6 +614,8 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 		case RTE_FLOW_ACTION_TYPE_SECURITY:
 			in_actions[i].type = ROC_NPC_ACTION_TYPE_SEC;
 			in_actions[i].conf = actions->conf;
+			in_actions[i].is_non_inp = flow_flags & CNXK_FLOW_NON_INPLACE;
+			in_actions[i].no_sec_action = flow_flags & CNXK_FLOW_NO_SEC_ACTION;
 			break;
 		case RTE_FLOW_ACTION_TYPE_OF_POP_VLAN:
 			in_actions[i].type = ROC_NPC_ACTION_TYPE_VLAN_STRIP;
@@ -803,7 +805,8 @@ cnxk_map_flow_data(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr
 		   struct roc_npc_attr *in_attr, struct roc_npc_item_info in_pattern[],
 		   struct roc_npc_action in_actions[],
 		   struct roc_npc_action_sample *in_sample_actions, uint32_t *flowkey_cfg,
-		   uint16_t *dst_pf_func, uint64_t *def_action, bool is_rep, uint64_t *free_allocs)
+		   uint16_t *dst_pf_func, uint64_t *def_action, bool is_rep, uint64_t *free_allocs,
+		   uint32_t flow_flags)
 {
 	uint8_t has_tunnel_pattern = 0, rep_pattern = 0;
 	int rc;
@@ -842,14 +845,14 @@ cnxk_map_flow_data(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr

 	return cnxk_map_actions(eth_dev, attr, actions, in_actions, in_sample_actions, flowkey_cfg,
 				dst_pf_func, def_action, has_tunnel_pattern, is_rep, rep_pattern,
-				free_allocs);
+				free_allocs, flow_flags);
 }

 int
 cnxk_flow_validate_common(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 			  const struct rte_flow_item pattern[],
 			  const struct rte_flow_action actions[], struct rte_flow_error *error,
-			  bool is_rep)
+			  bool is_rep, uint32_t flow_flags)
 {
 	struct roc_npc_item_info in_pattern[ROC_NPC_ITEM_TYPE_END + 1];
 	struct roc_npc_action in_actions[ROC_NPC_MAX_ACTION_COUNT];
@@ -891,7 +894,7 @@ cnxk_flow_validate_common(struct rte_eth_dev *eth_dev, const struct rte_flow_att
 	}
 	rc = cnxk_map_flow_data(eth_dev, attr, pattern, actions, &in_attr, in_pattern, in_actions,
 				&in_sample_action, &flowkey_cfg, &dst_pf_func, &npc_default_action,
-				is_rep, free_allocs);
+				is_rep, free_allocs, flow_flags);
 	if (rc) {
 		rte_flow_error_set(error, 0, RTE_FLOW_ERROR_TYPE_ACTION_NUM, NULL,
 				   "Failed to map flow data");
@@ -919,14 +922,26 @@ cnxk_flow_validate(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr
 		   const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
 		   struct rte_flow_error *error)
 {
-	return cnxk_flow_validate_common(eth_dev, attr, pattern, actions, error, false);
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct cnxk_eth_sec_sess *eth_sec = NULL;
+	uint32_t flow_flags = 0;
+
+	if (actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY) {
+		eth_sec = cnxk_eth_sec_sess_get_by_sess(dev, actions[0].conf);
+		if (eth_sec != NULL) {
+			flow_flags = eth_sec->inb_oop ? CNXK_FLOW_NON_INPLACE : 0;
+			flow_flags |= CNXK_FLOW_NO_SEC_ACTION;
+		}
+	}
+
+	return cnxk_flow_validate_common(eth_dev, attr, pattern, actions, error, false, flow_flags);
 }

 struct roc_npc_flow *
 cnxk_flow_create_common(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[], struct rte_flow_error *error,
-			bool is_rep)
+			bool is_rep, uint32_t flow_flags)
 {
 	struct roc_npc_item_info in_pattern[ROC_NPC_ITEM_TYPE_END + 1] = {0};
 	struct roc_npc_action in_actions[ROC_NPC_MAX_ACTION_COUNT] = {0};
@@ -962,7 +977,7 @@ cnxk_flow_create_common(struct rte_eth_dev *eth_dev, const struct rte_flow_attr
 	memset(&in_attr, 0, sizeof(struct roc_npc_attr));
 	rc = cnxk_map_flow_data(eth_dev, attr, pattern, actions, &in_attr, in_pattern, in_actions,
 				&in_sample_action, &npc->flowkey_cfg_state, &dst_pf_func,
-				&npc_default_action, is_rep, free_allocs);
+				&npc_default_action, is_rep, free_allocs, flow_flags);
 	if (rc) {
 		rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_ACTION_NUM, NULL,
 				   "Failed to map flow data");
diff --git a/drivers/net/cnxk/cnxk_flow.h b/drivers/net/cnxk/cnxk_flow.h
index 80b8d2c36a..2986ea81d1 100644
--- a/drivers/net/cnxk/cnxk_flow.h
+++ b/drivers/net/cnxk/cnxk_flow.h
@@ -20,6 +20,9 @@ struct cnxk_rte_flow_action_info {
 	uint16_t conf_size;
 };

+#define CNXK_FLOW_NO_SEC_ACTION BIT(0)
+#define CNXK_FLOW_NON_INPLACE	BIT(1)
+
 extern const struct cnxk_rte_flow_term_info term[];

 int cnxk_flow_destroy(struct rte_eth_dev *dev, struct roc_npc_flow *flow,
@@ -29,11 +32,12 @@ struct roc_npc_flow *cnxk_flow_create_common(struct rte_eth_dev *eth_dev,
 					     const struct rte_flow_attr *attr,
 					     const struct rte_flow_item pattern[],
 					     const struct rte_flow_action actions[],
-					     struct rte_flow_error *error, bool is_rep);
+					     struct rte_flow_error *error, bool is_rep,
+					     uint32_t flow_flags);
 int cnxk_flow_validate_common(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 			      const struct rte_flow_item pattern[],
 			      const struct rte_flow_action actions[], struct rte_flow_error *error,
-			      bool is_rep);
+			      bool is_rep, uint32_t flow_flags);
 int cnxk_flow_destroy_common(struct rte_eth_dev *eth_dev, struct roc_npc_flow *flow,
 			     struct rte_flow_error *error, bool is_rep);
 int cnxk_flow_flush_common(struct rte_eth_dev *eth_dev, struct rte_flow_error *error, bool is_rep);
diff --git a/drivers/net/cnxk/cnxk_flow_common.c b/drivers/net/cnxk/cnxk_flow_common.c
index 59aa920d91..14ac3b5b65 100644
--- a/drivers/net/cnxk/cnxk_flow_common.c
+++ b/drivers/net/cnxk/cnxk_flow_common.c
@@ -122,7 +122,9 @@ cnxk_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 	const struct rte_flow_action *action_rss = NULL;
 	const struct rte_flow_action_meter *mtr = NULL;
 	const struct rte_flow_action *act_q = NULL;
+	struct cnxk_eth_sec_sess *eth_sec = NULL;
 	struct roc_npc_flow *flow;
+	uint32_t flow_flags = 0;
 	void *mcs_flow = NULL;
 	uint32_t req_act = 0;
 	int i, rc;
@@ -183,7 +185,15 @@ cnxk_flow_create(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 		return mcs_flow;
 	}

-	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, false);
+	if (actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY) {
+		eth_sec = cnxk_eth_sec_sess_get_by_sess(dev, actions[0].conf);
+		if (eth_sec != NULL) {
+			flow_flags = eth_sec->inb_oop ? CNXK_FLOW_NON_INPLACE : 0;
+			flow_flags |= CNXK_FLOW_NO_SEC_ACTION;
+		}
+	}
+
+	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, false, flow_flags);
 	if (!flow) {
 		if (mtr)
 			nix_mtr_chain_reset(eth_dev, mtr->mtr_id);
diff --git a/drivers/net/cnxk/cnxk_rep_flow.c b/drivers/net/cnxk/cnxk_rep_flow.c
index f1cf81a90c..1b013ce598 100644
--- a/drivers/net/cnxk/cnxk_rep_flow.c
+++ b/drivers/net/cnxk/cnxk_rep_flow.c
@@ -547,7 +547,7 @@ cnxk_rep_flow_create_native(struct rte_eth_dev *eth_dev, const struct rte_flow_a
 	uint16_t new_entry;
 	int rc;

-	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, true);
+	flow = cnxk_flow_create_common(eth_dev, attr, pattern, actions, error, true, 0);
 	if (!flow) {
 		plt_err("Fail to create flow");
 		goto fail;
@@ -632,7 +632,7 @@ cnxk_rep_flow_validate(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *
 	}

 	if (rep_dev->native_repte)
-		return cnxk_flow_validate_common(eth_dev, attr, pattern, actions, error, true);
+		return cnxk_flow_validate_common(eth_dev, attr, pattern, actions, error, true, 0);

 	rc = process_flow_rule(rep_dev, attr, pattern, actions, &adata, CNXK_REP_MSG_FLOW_VALIDATE);
 	if (!rc || adata.u.sval < 0) {
diff --git a/drivers/net/cnxk/rte_pmd_cnxk.h b/drivers/net/cnxk/rte_pmd_cnxk.h
index b186b529fa..d344137dd5 100644
--- a/drivers/net/cnxk/rte_pmd_cnxk.h
+++ b/drivers/net/cnxk/rte_pmd_cnxk.h
@@ -82,6 +82,7 @@ struct rte_pmd_cnxk_sec_action {
 	 * XOR.
 	 */
 	enum rte_pmd_cnxk_sec_action_alg alg;
+	bool is_non_inp;
 };

 #define RTE_PMD_CNXK_CTX_MAX_CKEY_LEN	   32
--
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ECDCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 03:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06B79402D4;
	Thu, 30 Oct 2025 04:44:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 833DA4027A;
 Thu, 30 Oct 2025 04:44:50 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59U07BXY4123357; Wed, 29 Oct 2025 20:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=x+Kwa3/vtBDOUsoB/cjuxHb
 p0YfLtIbBJhoFr9tKCUs=; b=GZ8CDyw7zp9OFPhVa/UYqBd5itHDRF7RpEiK+OF
 CtDdVPLbpdqV55dcjWN2hV25LbZJGw42XztX7/JZ5sgdwnXOmqQHGF2tfH0qDblz
 rR1Qz5NmZeO+vGfQW/scSGQ7tbqllJ/dVd5VJf1LDqIx0Xv0H2Dt1z8p8n4xQu2T
 s5FVQ9VsUKGtuznbR7QU8EO2RqBCn7HSlm0RV3vH8Ll3FlUPE0vyC2ZCiyqhrQVS
 LVcySmyGMpVjdciVa+NwNj42V39MrFW4m34FXBwmTsCXk0d8jB9oHNW2mxKRMjDv
 Cml4OCj7JxE6EMDpejhLMHqPPw6ybVbtGIb7YaH+R4zUh4A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a3nru2r2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 20:44:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Oct 2025 20:44:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Oct 2025 20:44:17 -0700
Received: from cavium-OptiPlex-3070-BM17 (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id 034CD5E6875;
 Wed, 29 Oct 2025 20:44:14 -0700 (PDT)
From: <psatheesh@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Satheesh Paul <psatheesh@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH] net/cnxk: fix port ID default action
Date: Thu, 30 Oct 2025 09:14:03 +0530
Message-ID: <20251030034404.4187369-1-psatheesh@marvell.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XuH3+FF9 c=1 sm=1 tr=0 ts=6902df31 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=Av1WDxsbD0CUJSKLJuEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAyOCBTYWx0ZWRfX3Mli7iyhocK0
 VZE4y4+NA5F8Jcz472z8pE78+98WIrCrcCR15f3m2uyfwdbcsFklOndo2ghlSHhsgxrU6Kgz1cu
 g6GQzmCO92HQOidGfuCj+Csvfeud/Oowv0aCP0lQpJKwORMO6NlzYONGa9J1B1R8HNrTFW9y+dd
 nCmjTK74UsgKE2ASoZ+ETrt5SUk/Aw3FR5WPcWCbEAThSO1IAu2ZRbwLX6/QOcGdTEj4dHuz0zw
 K4FKhGFsgwHPd7COM2QK4Kp1dvzN86XFagKV0P3mxG+n6S+J7HlBDeUA5haPKSMltTmsOOS3H8z
 AHNoaI918GLPmR6jNlMpD4SkfbCToB9Lw3HhfI7CDKazgy62Lny3M9XrdJTDeM3/EBqB7PlJ9k7
 sEmP46RlTUS3AYP9kR/jGsljHbblwQ==
X-Proofpoint-GUID: jgmRBr_yHmI3VeAQSUNGO2oORLVBIUwF
X-Proofpoint-ORIG-GUID: jgmRBr_yHmI3VeAQSUNGO2oORLVBIUwF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
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

The default action for port_id is set incorrectly.
Fixing this by introducing a new kernel mbox to read
the action set for the port's default rule and using
the same action for the rule being created.

Fixes: 15f0b8a5b9e1 ("common/cnxk: support port ID action")
Cc: stable@dpdk.org

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>
---
 drivers/common/cnxk/roc_mbox.h                |  2 +
 drivers/common/cnxk/roc_npc.c                 | 52 ++++++++++++++-----
 drivers/common/cnxk/roc_npc.h                 |  4 +-
 drivers/common/cnxk/roc_npc_priv.h            |  1 +
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 drivers/net/cnxk/cnxk_flow.c                  | 36 ++++++++-----
 6 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index cbafa9555d..e1bed7858f 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -268,6 +268,8 @@ struct mbox_msghdr {
 	M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601c,                               \
 	  npc_cn20k_read_base_steer_rule, msg_req,                             \
 	  npc_cn20k_mcam_read_base_rule_rsp)                                   \
+	M(NPC_MCAM_READ_DEFAULT_RULE, 0x6023, npc_read_default_rule,           \
+	  msg_req, npc_mcam_read_base_rule_rsp)                                \
 	/* NIX mbox IDs (range 0x8000 - 0xFFFF) */                             \
 	M(NIX_LF_ALLOC, 0x8000, nix_lf_alloc, nix_lf_alloc_req,                \
 	  nix_lf_alloc_rsp)                                                    \
diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 50106b8773..56e0e05b63 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -599,8 +599,9 @@ roc_npc_process_sample_action(struct roc_npc *roc_npc,
 static int
 npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 		  const struct roc_npc_action actions[], struct roc_npc_flow *flow,
-		  uint16_t dst_pf_func)
+		  uint16_t dst_pf_func, uint64_t npc_default_action)
 {
+	bool vlan_insert_action = false, npc_action_set = false;
 	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
 	const struct roc_npc_action *sec_action = NULL;
 	const struct roc_npc_action_sample *act_sample;
@@ -609,7 +610,6 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	const struct roc_npc_action_meter *act_mtr;
 	const struct roc_npc_action_queue *act_q;
 	const struct roc_npc_action_vf *vf_act;
-	bool vlan_insert_action = false;
 	uint8_t has_spi_to_sa_act = 0;
 	int sel_act, req_act = 0;
 	uint16_t pf_func, vf_id;
@@ -907,7 +907,8 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	} else if (req_act & (ROC_NPC_ACTION_TYPE_PF | ROC_NPC_ACTION_TYPE_VF)) {
 		/* Check if any other action is set */
 		if ((req_act == ROC_NPC_ACTION_TYPE_PF) || (req_act == ROC_NPC_ACTION_TYPE_VF)) {
-			flow->npc_action = NIX_RX_ACTIONOP_DEFAULT;
+			flow->npc_action = npc_default_action;
+			npc_action_set = true;
 		} else {
 			flow->npc_action = NIX_RX_ACTIONOP_UCAST;
 			if (req_act & ROC_NPC_ACTION_TYPE_QUEUE)
@@ -944,15 +945,16 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 		goto err_exit;
 	}
 
-	if (req_act & ROC_NPC_ACTION_TYPE_SAMPLE)
-		flow->npc_action = NIX_RX_ACTIONOP_MCAST;
+	if (!npc_action_set) {
+		if (req_act & ROC_NPC_ACTION_TYPE_SAMPLE)
+			flow->npc_action = NIX_RX_ACTIONOP_MCAST;
 
-	if (mark)
-		flow->npc_action |= (uint64_t)mark << 40;
-
-	/* Ideally AF must ensure that correct pf_func is set */
-	flow->npc_action |= (uint64_t)pf_func << 4;
+		if (mark)
+			flow->npc_action |= (uint64_t)mark << 40;
 
+		/* Ideally AF must ensure that correct pf_func is set */
+		flow->npc_action |= (uint64_t)pf_func << 4;
+	}
 done:
 	return 0;
 
@@ -1072,7 +1074,8 @@ npc_parse_rule(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 		return err;
 
 	/* Check action */
-	err = npc_parse_actions(roc_npc, attr, actions, flow, pst->dst_pf_func);
+	err = npc_parse_actions(roc_npc, attr, actions, flow, pst->dst_pf_func,
+				pst->npc_default_action);
 	if (err)
 		return err;
 	return 0;
@@ -1643,7 +1646,7 @@ roc_npc_sdp_channel_get(struct roc_npc *roc_npc, uint16_t *chan_base, uint16_t *
 struct roc_npc_flow *
 roc_npc_flow_create(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 		    const struct roc_npc_item_info pattern[], const struct roc_npc_action actions[],
-		    uint16_t dst_pf_func, int *errcode)
+		    uint16_t dst_pf_func, uint64_t npc_default_action, int *errcode)
 {
 	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
 	uint16_t sdp_chan_base = 0, sdp_chan_mask = 0;
@@ -1693,6 +1696,7 @@ roc_npc_flow_create(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	}
 
 	parse_state.dst_pf_func = dst_pf_func;
+	parse_state.npc_default_action = npc_default_action;
 
 	rc = npc_parse_rule(roc_npc, attr, pattern, actions, flow, &parse_state);
 	if (rc != 0) {
@@ -1959,3 +1963,27 @@ roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc, struct roc_npc_fl
 	mbox_put(mbox);
 	return rc;
 }
+
+int
+roc_npc_mcam_default_rule_action_get(struct roc_npc *roc_npc, uint64_t *action)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct mbox *mbox = mbox_get(npc->mbox);
+	int rc;
+
+	struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
+	struct mcam_entry *base_entry;
+
+	(void)mbox_alloc_msg_npc_read_default_rule(mbox);
+	rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
+	if (rc) {
+		plt_err("Failed to fetch default MCAM entry");
+		goto exit;
+	}
+	base_entry = &base_rule_rsp->entry_data;
+
+	*action = base_entry->action;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index 91c84d7d97..b7565806c0 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -449,7 +449,8 @@ struct roc_npc_flow *__roc_api roc_npc_flow_create(struct roc_npc *roc_npc,
 						   const struct roc_npc_attr *attr,
 						   const struct roc_npc_item_info pattern[],
 						   const struct roc_npc_action actions[],
-						   uint16_t dst_pf_func, int *errcode);
+						   uint16_t dst_pf_funct,
+						   uint64_t npc_default_action, int *errcode);
 int __roc_api roc_npc_flow_destroy(struct roc_npc *roc_npc, struct roc_npc_flow *flow);
 int __roc_api roc_npc_mcam_free(struct roc_npc *roc_npc, struct roc_npc_flow *mcam);
 int __roc_api roc_npc_mcam_free_entry(struct roc_npc *roc_npc, uint32_t entry);
@@ -486,6 +487,7 @@ int __roc_api roc_npc_vtag_actions_get(struct roc_npc *roc_npc);
 int __roc_api roc_npc_vtag_actions_sub_return(struct roc_npc *roc_npc, uint32_t count);
 int __roc_api roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc,
 						    struct roc_npc_flow *flow);
+int __roc_api roc_npc_mcam_default_rule_action_get(struct roc_npc *roc_npc, uint64_t *action);
 int __roc_api roc_npc_validate_portid_action(struct roc_npc *roc_npc_src,
 					     struct roc_npc *roc_npc_dst);
 int __roc_api roc_npc_mcam_init(struct roc_npc *roc_npc, struct roc_npc_flow *flow, int mcam_id);
diff --git a/drivers/common/cnxk/roc_npc_priv.h b/drivers/common/cnxk/roc_npc_priv.h
index 5812cf0f8d..f8f4489f06 100644
--- a/drivers/common/cnxk/roc_npc_priv.h
+++ b/drivers/common/cnxk/roc_npc_priv.h
@@ -219,6 +219,7 @@ struct npc_parse_state {
 	uint8_t *mcam_mask; /* point to flow->mcam_mask + key_len */
 	bool is_vf;
 	uint16_t dst_pf_func;
+	uint64_t npc_default_action;
 	uint16_t nb_tx_queues;
 };
 
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 7f0fe601ad..14f0b3ad5e 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -450,6 +450,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_inl_mcam_clear_counter)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_counter)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_free_mcam_entry)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_read_counter)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_default_rule_action_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_get_stats)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_clear_counter)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_entry)
diff --git a/drivers/net/cnxk/cnxk_flow.c b/drivers/net/cnxk/cnxk_flow.c
index fcc60cd4f0..33501310e0 100644
--- a/drivers/net/cnxk/cnxk_flow.c
+++ b/drivers/net/cnxk/cnxk_flow.c
@@ -464,8 +464,8 @@ static int
 cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 		 const struct rte_flow_action actions[], struct roc_npc_action in_actions[],
 		 struct roc_npc_action_sample *in_sample_actions, uint32_t *flowkey_cfg,
-		 uint16_t *dst_pf_func, uint8_t has_tunnel_pattern, bool is_rep,
-		 uint8_t rep_pattern, uint64_t *free_allocs)
+		 uint16_t *dst_pf_func, uint64_t *npc_default_action, uint8_t has_tunnel_pattern,
+		 bool is_rep, uint8_t rep_pattern, uint64_t *free_allocs)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	const struct rte_flow_action_queue *act_q = NULL;
@@ -531,9 +531,10 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 				    eth_dev->data->port_id, if_name, act_ethdev->port_id);
 			if (cnxk_ethdev_is_representor(if_name)) {
 				if (representor_rep_portid_action(in_actions, eth_dev,
-					    portid_eth_dev, actions->type, rep_pattern,
-					    dst_pf_func, is_rep, has_tunnel_pattern,
-					    free_allocs, &i, flowkey_cfg)) {
+								  portid_eth_dev, actions->type,
+								  rep_pattern, dst_pf_func,
+								  is_rep, has_tunnel_pattern,
+								  free_allocs, &i, flowkey_cfg)) {
 					plt_err("Representor port action set failed");
 					goto err_exit;
 				}
@@ -583,6 +584,8 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 				}
 
 				hw_dst = portid_eth_dev->data->dev_private;
+				roc_npc_mcam_default_rule_action_get(&hw_dst->npc,
+								     npc_default_action);
 				roc_npc_dst = &hw_dst->npc;
 				*dst_pf_func = roc_npc_dst->pf_func;
 			}
@@ -800,7 +803,7 @@ cnxk_map_flow_data(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr
 		   struct roc_npc_attr *in_attr, struct roc_npc_item_info in_pattern[],
 		   struct roc_npc_action in_actions[],
 		   struct roc_npc_action_sample *in_sample_actions, uint32_t *flowkey_cfg,
-		   uint16_t *dst_pf_func, bool is_rep, uint64_t *free_allocs)
+		   uint16_t *dst_pf_func, uint64_t *def_action, bool is_rep, uint64_t *free_allocs)
 {
 	uint8_t has_tunnel_pattern = 0, rep_pattern = 0;
 	int rc;
@@ -838,7 +841,8 @@ cnxk_map_flow_data(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr
 	}
 
 	return cnxk_map_actions(eth_dev, attr, actions, in_actions, in_sample_actions, flowkey_cfg,
-				dst_pf_func, has_tunnel_pattern, is_rep, rep_pattern, free_allocs);
+				dst_pf_func, def_action, has_tunnel_pattern, is_rep, rep_pattern,
+				free_allocs);
 }
 
 int
@@ -850,14 +854,15 @@ cnxk_flow_validate_common(struct rte_eth_dev *eth_dev, const struct rte_flow_att
 	struct roc_npc_item_info in_pattern[ROC_NPC_ITEM_TYPE_END + 1];
 	struct roc_npc_action in_actions[ROC_NPC_MAX_ACTION_COUNT];
 	struct roc_npc_action_sample in_sample_action;
+	uint64_t npc_default_action = 0;
 	struct cnxk_rep_dev *rep_dev;
 	struct roc_npc_attr in_attr;
 	uint64_t *free_allocs, sz;
 	struct cnxk_eth_dev *dev;
 	struct roc_npc_flow flow;
-	uint32_t flowkey_cfg = 0;
 	uint16_t dst_pf_func = 0;
-	struct roc_npc *npc;
+	uint32_t flowkey_cfg = 0;
+	struct roc_npc *npc = 0;
 	int rc, j;
 
 	/* is_rep set for operation performed via representor ports */
@@ -885,7 +890,8 @@ cnxk_flow_validate_common(struct rte_eth_dev *eth_dev, const struct rte_flow_att
 		return -ENOMEM;
 	}
 	rc = cnxk_map_flow_data(eth_dev, attr, pattern, actions, &in_attr, in_pattern, in_actions,
-				&in_sample_action, &flowkey_cfg, &dst_pf_func, is_rep, free_allocs);
+				&in_sample_action, &flowkey_cfg, &dst_pf_func, &npc_default_action,
+				is_rep, free_allocs);
 	if (rc) {
 		rte_flow_error_set(error, 0, RTE_FLOW_ERROR_TYPE_ACTION_NUM, NULL,
 				   "Failed to map flow data");
@@ -928,10 +934,11 @@ cnxk_flow_create_common(struct rte_eth_dev *eth_dev, const struct rte_flow_attr
 	struct cnxk_rep_dev *rep_dev = NULL;
 	struct roc_npc_flow *flow = NULL;
 	struct cnxk_eth_dev *dev = NULL;
+	uint64_t npc_default_action = 0;
 	struct roc_npc_attr in_attr;
+	struct roc_npc *npc = NULL;
 	uint64_t *free_allocs, sz;
 	uint16_t dst_pf_func = 0;
-	struct roc_npc *npc;
 	int errcode = 0;
 	int rc, j;
 
@@ -954,15 +961,16 @@ cnxk_flow_create_common(struct rte_eth_dev *eth_dev, const struct rte_flow_attr
 	memset(&in_sample_action, 0, sizeof(in_sample_action));
 	memset(&in_attr, 0, sizeof(struct roc_npc_attr));
 	rc = cnxk_map_flow_data(eth_dev, attr, pattern, actions, &in_attr, in_pattern, in_actions,
-				&in_sample_action, &npc->flowkey_cfg_state, &dst_pf_func, is_rep,
-				free_allocs);
+				&in_sample_action, &npc->flowkey_cfg_state, &dst_pf_func,
+				&npc_default_action, is_rep, free_allocs);
 	if (rc) {
 		rte_flow_error_set(error, rc, RTE_FLOW_ERROR_TYPE_ACTION_NUM, NULL,
 				   "Failed to map flow data");
 		goto clean;
 	}
 
-	flow = roc_npc_flow_create(npc, &in_attr, in_pattern, in_actions, dst_pf_func, &errcode);
+	flow = roc_npc_flow_create(npc, &in_attr, in_pattern, in_actions, dst_pf_func,
+				   npc_default_action, &errcode);
 	if (errcode != 0) {
 		rte_flow_error_set(error, errcode, errcode, NULL, roc_error_msg_get(errcode));
 		goto clean;
-- 
2.51.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF55CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82AAF40264;
	Fri,  7 Nov 2025 11:48:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 69FB64021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:47:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A73WQYs1340011 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:47:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 APH6lOi7RIeuW9XhZJajDmkS7yNRp8DKSDf5alQXSA=; b=K8WkMO+tT/+dMhp90
 QCAOLdWQNIoI/os4uhtZBZSXW7FsHH11YgHEdEUwD5x7C/sAPe16jSETUjVLx0B4
 043b/yWxI+GH4ywwNnDA3Xo9mt4KSGx56wLCvm6Y/gVMAmr4yljV0YoHLdNjRi1J
 yWIrgoHySw+RlybGX4DwD8sLrafMsIB1v0zLuZPHljUcF7PfM6jeVkQeoqjVoj9C
 Vaid6uXyXVr0Ml8u4B4+B4qD9oSH8XvnS234J0KVYhuPmHc7hXZ22X+m24tE8w6g
 Vf/ONi5Ywp6i0TMcEobJyBh6oTi7o/cFvpU41j5HlEKH2Z+X7QFSW6FR4riK7y2c
 H284Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a98wkh9ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:47:57 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:07 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id A35B13F70CC;
 Fri,  7 Nov 2025 02:47:53 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 01/23] common/cnxk: add new TM tree for SDP interface
Date: Fri, 7 Nov 2025 16:17:25 +0530
Message-ID: <20251107104747.1131008-1-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1GYeGlsBNevEaOQsQaz-HKEUiFYfbelc
X-Proofpoint-GUID: 1GYeGlsBNevEaOQsQaz-HKEUiFYfbelc
X-Authority-Analysis: v=2.4 cv=WY8BqkhX c=1 sm=1 tr=0 ts=690dce5d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=N1rwnyxQk5nB-LrYttQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX2PmiQ6+rCNVh
 +4xuWxRdUL/MNT39YK6xwRWigX289hUf8kQVZDknKLU1px+1Xue1D5WaELbr/FgX2TVG7DW5wiz
 JMFchPKJgW1iSSwBmIIE8T+3ZYksi4IUfFG/VH+yXno2KW6AoeF1p91m3/tMyh8VB0ZK5I6XNqz
 WfciKxXhjckDFnBGSEG8IHWN8lvtNP6LhiUadOj0jc0yOL/TUflNG/guQW8jml9RqmwUFXlqg/i
 DDQ5pRuB7G6bmwXJxXkFhn6ghZukO3CfQeP9oxqJtwYnCusg3rdnPABJ+1FMGcwBpbDQUT0CdnN
 Fx3N1TvABJ35rsBJU46YIF9JVNzCjBE2eF9vl3cNydeEex6TO8UW48J7wsIaRdyiGHfmOGPtuvE
 Qdx/km7jJZwE1hDjiagROA6m8lDBqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

From: Satha Rao <skoteshwar@marvell.com>

Create a new default tree for the SDP interface if more than one TX
queue is requested. This helps to backpressure each queue independently
when they are created with separate channels.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---

v4:
- Further split patch 19/19 to 5 patches.

v3:
- Fixed usage of rte_atomic in common/cnxk folder.

v2:
- Handled comments related to commit messages
- Fixed typo

 drivers/common/cnxk/roc_nix.h                 |   2 +
 drivers/common/cnxk/roc_nix_priv.h            |   2 +
 drivers/common/cnxk/roc_nix_tm.c              | 158 ++++++++++++++++++
 drivers/common/cnxk/roc_nix_tm_ops.c          |   5 +-
 drivers/common/cnxk/roc_nix_tm_utils.c        |   2 +-
 .../common/cnxk/roc_platform_base_symbols.c   |   1 +
 6 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index a9cdc42617..a156d83200 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -596,6 +596,7 @@ enum roc_nix_tm_tree {
 	ROC_NIX_TM_DEFAULT = 0,
 	ROC_NIX_TM_RLIMIT,
 	ROC_NIX_TM_PFC,
+	ROC_NIX_TM_SDP,
 	ROC_NIX_TM_USER,
 	ROC_NIX_TM_TREE_MAX,
 };
@@ -768,6 +769,7 @@ int __roc_api roc_nix_tm_lvl_cnt_get(struct roc_nix *roc_nix);
 int __roc_api roc_nix_tm_lvl_have_link_access(struct roc_nix *roc_nix, int lvl);
 int __roc_api roc_nix_tm_prepare_rate_limited_tree(struct roc_nix *roc_nix);
 int __roc_api roc_nix_tm_pfc_prepare_tree(struct roc_nix *roc_nix);
+int __roc_api roc_nix_tm_sdp_prepare_tree(struct roc_nix *roc_nix);
 bool __roc_api roc_nix_tm_is_user_hierarchy_enabled(struct roc_nix *nix);
 int __roc_api roc_nix_tm_tree_type_get(struct roc_nix *nix);
 int __roc_api roc_nix_tm_mark_config(struct roc_nix *roc_nix,
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index dc3450a3d4..d7ea3c6be2 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -387,6 +387,8 @@ nix_tm_tree2str(enum roc_nix_tm_tree tree)
 		return "Rate Limit Tree";
 	else if (tree == ROC_NIX_TM_PFC)
 		return "PFC Tree";
+	else if (tree == ROC_NIX_TM_SDP)
+		return "SDP Tree";
 	else if (tree == ROC_NIX_TM_USER)
 		return "User Tree";
 	return "???";
diff --git a/drivers/common/cnxk/roc_nix_tm.c b/drivers/common/cnxk/roc_nix_tm.c
index abfe80978b..2771fd8fc4 100644
--- a/drivers/common/cnxk/roc_nix_tm.c
+++ b/drivers/common/cnxk/roc_nix_tm.c
@@ -1890,6 +1890,164 @@ roc_nix_tm_pfc_prepare_tree(struct roc_nix *roc_nix)
 	return rc;
 }
 
+int
+roc_nix_tm_sdp_prepare_tree(struct roc_nix *roc_nix)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	uint32_t nonleaf_id = nix->nb_tx_queues;
+	uint32_t tl2_node_id, tl3_node_id;
+	uint8_t leaf_lvl, lvl, lvl_start;
+	struct nix_tm_node *node = NULL;
+	uint32_t parent, i;
+	int rc = -ENOMEM;
+
+	parent = ROC_NIX_TM_NODE_ID_INVALID;
+	leaf_lvl = (nix_tm_have_tl1_access(nix) ? ROC_TM_LVL_QUEUE : ROC_TM_LVL_SCH4);
+
+	/* TL1 node */
+	node = nix_tm_node_alloc();
+	if (!node)
+		goto error;
+
+	node->id = nonleaf_id;
+	node->parent_id = parent;
+	node->priority = 0;
+	node->weight = NIX_TM_DFLT_RR_WT;
+	node->shaper_profile_id = ROC_NIX_TM_SHAPER_PROFILE_NONE;
+	node->lvl = ROC_TM_LVL_ROOT;
+	node->tree = ROC_NIX_TM_SDP;
+	node->rel_chan = NIX_TM_CHAN_INVALID;
+
+	rc = nix_tm_node_add(roc_nix, node);
+	if (rc)
+		goto error;
+
+	parent = nonleaf_id;
+	nonleaf_id++;
+
+	lvl_start = ROC_TM_LVL_SCH1;
+	if (roc_nix_is_pf(roc_nix)) {
+		/* TL2 node */
+		rc = -ENOMEM;
+		node = nix_tm_node_alloc();
+		if (!node)
+			goto error;
+
+		node->id = nonleaf_id;
+		node->parent_id = parent;
+		node->priority = 0;
+		node->weight = NIX_TM_DFLT_RR_WT;
+		node->shaper_profile_id = ROC_NIX_TM_SHAPER_PROFILE_NONE;
+		node->lvl = ROC_TM_LVL_SCH1;
+		node->tree = ROC_NIX_TM_SDP;
+		node->rel_chan = NIX_TM_CHAN_INVALID;
+
+		rc = nix_tm_node_add(roc_nix, node);
+		if (rc)
+			goto error;
+
+		lvl_start = ROC_TM_LVL_SCH2;
+		tl2_node_id = nonleaf_id;
+		nonleaf_id++;
+	} else {
+		tl2_node_id = parent;
+	}
+
+	/* Allocate TL3 node */
+	rc = -ENOMEM;
+	node = nix_tm_node_alloc();
+	if (!node)
+		goto error;
+
+	node->id = nonleaf_id;
+	node->parent_id = tl2_node_id;
+	node->priority = 0;
+	node->weight = NIX_TM_DFLT_RR_WT;
+	node->shaper_profile_id = ROC_NIX_TM_SHAPER_PROFILE_NONE;
+	node->lvl = lvl_start;
+	node->tree = ROC_NIX_TM_SDP;
+	node->rel_chan = NIX_TM_CHAN_INVALID;
+
+	rc = nix_tm_node_add(roc_nix, node);
+	if (rc)
+		goto error;
+
+	tl3_node_id = nonleaf_id;
+	nonleaf_id++;
+	lvl_start++;
+
+	for (i = 0; i < nix->nb_tx_queues; i++) {
+		parent = tl3_node_id;
+		rc = -ENOMEM;
+		node = nix_tm_node_alloc();
+		if (!node)
+			goto error;
+
+		node->id = nonleaf_id;
+		node->parent_id = parent;
+		node->priority = 0;
+		node->weight = NIX_TM_DFLT_RR_WT;
+		node->shaper_profile_id = ROC_NIX_TM_SHAPER_PROFILE_NONE;
+		node->lvl = lvl_start;
+		node->tree = ROC_NIX_TM_SDP;
+		/* For SDP, if BP enabled use channel to PAUSE the corresponding queue */
+		node->rel_chan = (i % nix->tx_chan_cnt);
+
+		rc = nix_tm_node_add(roc_nix, node);
+		if (rc)
+			goto error;
+
+		parent = nonleaf_id;
+		nonleaf_id++;
+
+		lvl = (nix_tm_have_tl1_access(nix) ? ROC_TM_LVL_SCH4 : ROC_TM_LVL_SCH3);
+
+		rc = -ENOMEM;
+		node = nix_tm_node_alloc();
+		if (!node)
+			goto error;
+
+		node->id = nonleaf_id;
+		node->parent_id = parent;
+		node->priority = 0;
+		node->weight = NIX_TM_DFLT_RR_WT;
+		node->shaper_profile_id = ROC_NIX_TM_SHAPER_PROFILE_NONE;
+		node->lvl = lvl;
+		node->tree = ROC_NIX_TM_SDP;
+		node->rel_chan = NIX_TM_CHAN_INVALID;
+
+		rc = nix_tm_node_add(roc_nix, node);
+		if (rc)
+			goto error;
+
+		parent = nonleaf_id;
+		nonleaf_id++;
+
+		rc = -ENOMEM;
+		node = nix_tm_node_alloc();
+		if (!node)
+			goto error;
+
+		node->id = i;
+		node->parent_id = parent;
+		node->priority = 0;
+		node->weight = NIX_TM_DFLT_RR_WT;
+		node->shaper_profile_id = ROC_NIX_TM_SHAPER_PROFILE_NONE;
+		node->lvl = leaf_lvl;
+		node->tree = ROC_NIX_TM_SDP;
+		node->rel_chan = NIX_TM_CHAN_INVALID;
+
+		rc = nix_tm_node_add(roc_nix, node);
+		if (rc)
+			goto error;
+	}
+
+	return 0;
+error:
+	nix_tm_node_free(node);
+	return rc;
+}
+
 int
 nix_tm_free_resources(struct roc_nix *roc_nix, uint32_t tree_mask, bool hw_only)
 {
diff --git a/drivers/common/cnxk/roc_nix_tm_ops.c b/drivers/common/cnxk/roc_nix_tm_ops.c
index b89f08ac66..951c310a56 100644
--- a/drivers/common/cnxk/roc_nix_tm_ops.c
+++ b/drivers/common/cnxk/roc_nix_tm_ops.c
@@ -1035,7 +1035,10 @@ roc_nix_tm_init(struct roc_nix *roc_nix)
 	}
 
 	/* Prepare default tree */
-	rc = nix_tm_prepare_default_tree(roc_nix);
+	if (roc_nix_is_sdp(roc_nix) && (nix->nb_tx_queues > 1))
+		rc = roc_nix_tm_sdp_prepare_tree(roc_nix);
+	else
+		rc = nix_tm_prepare_default_tree(roc_nix);
 	if (rc) {
 		plt_err("failed to prepare default tm tree, rc=%d", rc);
 		return rc;
diff --git a/drivers/common/cnxk/roc_nix_tm_utils.c b/drivers/common/cnxk/roc_nix_tm_utils.c
index 4a09cc2aae..eaf6f9e4c7 100644
--- a/drivers/common/cnxk/roc_nix_tm_utils.c
+++ b/drivers/common/cnxk/roc_nix_tm_utils.c
@@ -582,7 +582,7 @@ nix_tm_topology_reg_prep(struct nix *nix, struct nix_tm_node *node,
 
 		/* Configure TL4 to send to SDP channel instead of CGX/LBK */
 		if (nix->sdp_link) {
-			relchan = nix->tx_chan_base & 0xff;
+			relchan = (nix->tx_chan_base & 0xff) + node->rel_chan;
 			plt_tm_dbg("relchan=%u schq=%u tx_chan_cnt=%u", relchan, schq,
 				   nix->tx_chan_cnt);
 			reg[k] = NIX_AF_TL4X_SDP_LINK_CFG(schq);
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index a557bfe5eb..a811d4931b 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -223,6 +223,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sdp_prepare_tree)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_cpt_lfs_dump)
-- 
2.34.1


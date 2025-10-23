Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFFACCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:27:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9B4A4026A;
	Thu, 23 Oct 2025 19:27:37 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D9FFF40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:27:36 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8OlHs031543
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 hS2u9v5SxwZgOr0HjVFr12cnY8iodY+GwyJiYldXss=; b=a6UUT+MvzV4iFbDEC
 KqasAIwyKsi7BDhvvt/O+HlhE+PAh+qx6o7WnjAc0yszGDiYE+6+XbEP/LrZIvZg
 i3st7NXGDQ8WSuAfs9cb6c/ty5Xbt3/swmQt8d026WTujNnuogxkKswjhSZKpw6W
 yPPKIjfelrQfVFnqmk0atsAArlbIM5XQCTu/TzfNFGulEVZ9n5eGRPk7HnSR8qzA
 YiwSGtsv7CoqRjBFYDVa2mz7WPDBqrxqUXNxP78pjfzgcc0aLhQ7HPF8vaoKO8FC
 ZZP8ZsPuom6vvQFuB6lU7jGwxW5FAoNfjSFn3d2jTn4dxCRijy9THwLjHYdrQq+5
 9DE9g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycq49v5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:27:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:27:33 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 041573F7068;
 Thu, 23 Oct 2025 10:27:31 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 01/19] common/cnxk: add new TM tree for SDP interface
Date: Thu, 23 Oct 2025 22:57:09 +0530
Message-ID: <20251023172728.770661-1-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMSBTYWx0ZWRfX3LP74Hw48rUf
 FfBwX4HpTx3gePvcyn0dBebeYJ4I4BQgiu1BMMR86MUt/VznGyfhc5cz8MS6rTzUtJGERxXHiRF
 9piUBoCMVBg4zw0U6+hOx4wQeUR3UbSuIDQZUrFNTI+lXp3AUgD0HmZGv5yp/egTWgWrwsDqy4t
 HpMfWEIBDzYM060MnwBmJEh4cOFxQ1O0e3X0z8Jmt9QPWDJEecxJqENzKAaUqEz0WlidtK9z2HZ
 +gkvDnSWU5NNxIwxMngtK3Xg0J6CbF67K1H2mnLuwOgUT/bDCnIDSZMpXv2u9Z4zrT9pZHdoe5I
 HC3UIfFZk/US1l8bfAG7Bf7rvgAqc8+7KBk3zBFxiEfMlGZi6MRkfU+1J2Ww3ldQakWKkGTKhIm
 woxOJu82wkNO6hVFTO4WdjQpT+7mlQ==
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=68fa6587 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=N1rwnyxQk5nB-LrYttQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 4PuFaihU5ps4-0Nip3B0VFLRn1WhLlJK
X-Proofpoint-ORIG-GUID: 4PuFaihU5ps4-0Nip3B0VFLRn1WhLlJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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
index 7f0fe601ad..cc35c46456 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -221,6 +221,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sdp_prepare_tree)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_cpt_lfs_dump)
-- 
2.34.1


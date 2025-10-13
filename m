Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C473CCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:00:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A8404021E;
	Mon, 13 Oct 2025 09:00:01 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 142254013F
 for <dev@dpdk.org>; Mon, 13 Oct 2025 08:59:59 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNgmBk023055
 for <dev@dpdk.org>; Sun, 12 Oct 2025 23:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
 DuJ7lxYVJk/n4ry0ozguR99CyHLzaiMh88B2eCQJFs=; b=eyPXEDPT6LYUFRmAp
 QCXFCCWVF871X+6hQD0nN2FyClTGzxjB5WisbLPAOjnb+SaoYQN1QxeuxD7tk5hq
 0TmbM5zlZIhenIL561PR3GBHxoeO24gNFZI+BzekoxX0c3OyEcvjiuejzshCg8bN
 7z/InwDryvCSyPd9/w7PLjxmdn0Sbk6u4pX5fadW7kHqsQAViEIqJ+SonCiysAyS
 SM6zdpcLQb97AlC30gFzNiXqmSpRNmFH4+Fh7kN+x2cvqlZOHSCXdNLN5QaCEFpV
 GxMVqMU5B293vQqXHhWAfii/k2j42D04Tv6+65qICCPyzj5zfVXfArD/KahOagaL
 19rYQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1jrmd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 12 Oct 2025 23:59:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:07 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 018733F7072;
 Sun, 12 Oct 2025 23:59:54 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 01/19] common/cnxk: add new TM tree for SDP interface
Date: Mon, 13 Oct 2025 12:29:31 +0530
Message-ID: <20251013065949.200414-1-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: akGsUWW-a1o9Fzq8RbjSgHsPntet173e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfX20Z7hvrA+BPC
 Ug/yY74+qVnBXvuhvfOVAZVgKC3XX6/dLAtV853rzbMeSdGm3kuh4qd2kAO5mi6HHU7I51GcnWI
 K8blCRBQmU8eXt2E/QBG5S7TWaNkduB1VFa3zRRPBkb+kIS8QtxeNHEmwrJGojZx+iRIGVsx2SM
 x4i8PPYONWtnPJHS2TPQV5+MfcKn46D6i84e0GEeIom4FhxnxabOugnnfANphX3j1jkYc/7sBYq
 xIrdEjjaZd3IETyWNWCYKPcWp7Kr2mrjIKyanrcC1mtb2UtdJqwvk3YRDtyTAvR2euoF9J6CeVT
 3HCwwPoFBA5M9mEduS/LypW7lWUXj8tzHgkvVTTXvax3asFDaRsiD5L4qH0V5tITJl7afBo9iUP
 L+2elMr5qXCKgoNgfIxDaZcret9MsQ==
X-Authority-Analysis: v=2.4 cv=Utdu9uwB c=1 sm=1 tr=0 ts=68eca36e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=N1rwnyxQk5nB-LrYttQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: akGsUWW-a1o9Fzq8RbjSgHsPntet173e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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


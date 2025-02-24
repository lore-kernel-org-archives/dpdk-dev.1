Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4527C021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:41:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DAA140DCB;
	Mon, 24 Feb 2025 10:40:30 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3FCEE40BA5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:40:28 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51J4g001436
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 XQl4YrTONS9QXkq+fuAbxmRIFTOYmS/PTJXgl7Ha3E=; b=M/4w+e411KtZgOSJk
 ZtNxvgyBRLorDEI7VFBBkysMMinGUFok0IJYGfCTMSK6F+IGlyBrA0ZML3Id948r
 GumwP5Pi05nimmsXSJi4qhl6DGt8V1UMMzpJTlXSDAo2fCfBd2USbKNg8YC/htjW
 b3GGkeyQgxgsqz+8+SPiW5F2EI5qDx2HvJGgVn6bqOJPU/gqzGwLzlJgOloQNtp/
 dLGB9KWEvC3pgA3I71qHQ5Gf9ZCeUaqY6s1/LOrt5b8yzLg+7yCeCV2QyBphJ1kw
 JfSUg+DgFJN8aehGn1dnQBKrpAGvrk5OSmw3j5/MZvKF3F8t/FA3ju9rI96qNMbC
 g6FGw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jg5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:27 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:26 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 454C73F705D;
 Mon, 24 Feb 2025 01:40:23 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 21/33] common/cnxk: add NPC action2 support
Date: Mon, 24 Feb 2025 15:09:03 +0530
Message-ID: <20250224093915.1253215-21-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Z7xCBo7a4AhvSuDfnSw1YnhJDWm0QWy8
X-Proofpoint-ORIG-GUID: Z7xCBo7a4AhvSuDfnSw1YnhJDWm0QWy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

Add action2 config for IPsec rule.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/hw/nix.h       | 13 +++++++++++--
 drivers/common/cnxk/roc_mbox.h     |  1 +
 drivers/common/cnxk/roc_npc.h      |  1 +
 drivers/common/cnxk/roc_npc_mcam.c |  1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index dd629a2080..e4d8d285d5 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -1678,6 +1678,15 @@ struct nix_rx_action_s {
 	uint64_t rsvd_63_61 : 3;
 };
 
+/* NIX receive action structure */
+struct nix_rx_action2_s {
+	uint64_t ipsec_qsel                  :  3;
+	uint64_t ipsec_qidx                  :  4;
+	uint64_t reserved_7_7                :  1;
+	uint64_t inline_profile_id           :  4;
+	uint64_t reserved_12_63              : 52;
+
+};
 /* NIX receive immediate sub descriptor structure */
 struct nix_rx_imm_s {
 	uint64_t size : 16;
@@ -2666,9 +2675,9 @@ struct nix_lso_format {
 #define NIX_SENDSTAT_IOFFSET_MASK 0xFFF
 #define NIX_SENDSTAT_OOFFSET_MASK 0xFFF
 
-/* The mask is to extract lower 10-bits of channel number
+/* The mask is to extract lower 11-bits of channel number
  * which CPT will pass to X2P.
  */
-#define NIX_CHAN_CPT_X2P_MASK (0x3ffull)
+#define NIX_CHAN_CPT_X2P_MASK (0x7ffull)
 
 #endif /* __NIX_HW_H__ */
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index fbea15690b..22a7258074 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -2694,6 +2694,7 @@ struct cn20k_mcam_entry {
 	uint64_t __io kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
 	uint64_t __io action;
 	uint64_t __io vtag_action;
+	uint64_t __io action2;
 };
 
 struct npc_cn20k_mcam_write_entry_req {
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index 4da21a8eb3..2a409cce99 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -328,6 +328,7 @@ struct roc_npc_flow {
 	uint64_t mcam_data[ROC_NPC_MAX_MCAM_WIDTH_DWORDS];
 	uint64_t mcam_mask[ROC_NPC_MAX_MCAM_WIDTH_DWORDS];
 	uint64_t npc_action;
+	uint64_t npc_action2;
 	uint64_t vtag_action;
 	bool vtag_insert_enabled;
 	int8_t vtag_insert_count;
diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index 412b2611b7..5db72c22ae 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -511,6 +511,7 @@ npc_mcam_write_entry(struct mbox *mbox, struct roc_npc_flow *mcam)
 		cn20k_req->intf = mcam->nix_intf;
 		cn20k_req->enable_entry = mcam->enable;
 		cn20k_req->entry_data.action = mcam->npc_action;
+		cn20k_req->entry_data.action2 = mcam->npc_action2;
 		cn20k_req->entry_data.vtag_action = mcam->vtag_action;
 		cn20k_req->hw_prio = mcam->priority;
 		if (mcam->use_ctr)
-- 
2.34.1


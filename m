Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E32EC36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 09:48:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B260B40A6B;
	Fri, 21 Mar 2025 10:48:34 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B3A5040276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 10:48:32 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7kEnc017897
 for <dev@dpdk.org>; Fri, 21 Mar 2025 02:48:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 moVXGTL8k6otVn67UrhsY/EokoPOV8c2h9X/8od0l8=; b=SnuxB7bKKHdbxoPc9
 nUFH4RIoXsx9RTTJmHWo+Wyhz63P0LJFXoaU1CNZ/Z4k2AawFOZmpUhE70cqdpFT
 r9ajZIL9cObApTuY1knyEcAt3acAoEUXLF1o6bu8SI0TYpbP2A87xdv4JWo/RxvV
 SpHivY4j+wjVhHhqb/5/u8DKZE0DOnoZWwtCWAQWWWFeiY7Nj8fmXnSgGpDhUIse
 vBNAE6j03RJmL9h7FdUeLWKzy44BkLX1tFQa0rbHJV822NhDHZ/OzJebWjh11DLl
 kqwh6O0nRwcSckLk0eg4GkDz0xj63Uz7U4jxYE+3rbFYFhXXo3X5POIy8kG7Rqsr
 jEXNw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45h40xr6hx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 21 Mar 2025 02:48:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Mar 2025 02:48:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Mar 2025 02:48:30 -0700
Received: from cavium-OptiPlex-3070-BM17.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id 6D8455E6871;
 Fri, 21 Mar 2025 02:48:28 -0700 (PDT)
From: <psatheesh@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>
Subject: [dpdk-dev] [PATCH 2/2] common/cnxk: defragment MCAM bank during
 allocation
Date: Fri, 21 Mar 2025 15:18:20 +0530
Message-ID: <20250321094820.3311252-2-psatheesh@marvell.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250321094820.3311252-1-psatheesh@marvell.com>
References: <20250321094820.3311252-1-psatheesh@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I+9lRMgg c=1 sm=1 tr=0 ts=67dd35ef cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=zXlsiKfBimB7fwkUvC0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: oRp6ySzym8WSi30TLEELEUpDg0tlX8I1
X-Proofpoint-ORIG-GUID: oRp6ySzym8WSi30TLEELEUpDg0tlX8I1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
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

If MCAM allocation fails, invoke MCAM bank defragmentation
and retry MCAM allocation for CN20K.

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>
---
 drivers/common/cnxk/roc_npc.c           | 40 +++++++++++++++++++++++--
 drivers/common/cnxk/roc_npc.h           |  3 ++
 drivers/common/cnxk/roc_npc_mcam.c      | 24 +++++++++++++--
 drivers/common/cnxk/roc_npc_mcam_dump.c |  6 +++-
 drivers/common/cnxk/roc_npc_priv.h      | 16 +++++++---
 drivers/common/cnxk/roc_npc_utils.c     |  8 -----
 drivers/common/cnxk/version.map         |  3 ++
 7 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 94d5cc84f8..3fd59667d8 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -5,6 +5,22 @@
 #include "roc_api.h"
 #include "roc_priv.h"
 
+uint8_t
+roc_npc_get_key_type(struct roc_npc *roc_npc, struct roc_npc_flow *flow)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+
+	return npc_get_key_type(npc, flow);
+}
+
+uint8_t
+roc_npc_kex_key_type_config_get(struct roc_npc *roc_npc)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+
+	return npc_kex_key_type_config_get(npc);
+}
+
 int
 roc_npc_mark_actions_get(struct roc_npc *roc_npc)
 {
@@ -197,10 +213,30 @@ roc_npc_mcam_enable_all_entries(struct roc_npc *roc_npc, bool enable)
 	return npc_flow_enable_all_entries(npc, enable);
 }
 
+void
+roc_npc_defrag_mcam_banks(struct roc_npc *roc_npc)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct mbox *mbox = mbox_get(npc->mbox);
+	struct npc_mcam_defrag_req *req;
+	struct npc_mcam_defrag_rsp *rsp;
+	int rc = 0;
+
+	req = (struct npc_mcam_defrag_req *)mbox_alloc_msg_npc_defrag(mbox);
+	if (req == NULL)
+		goto exit;
+
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc)
+		plt_err("Error when defragmenting MCAM banks.");
+
+exit:
+	mbox_put(mbox);
+}
+
 int
 roc_npc_mcam_alloc_entry(struct roc_npc *roc_npc, struct roc_npc_flow *mcam,
-			 struct roc_npc_flow *ref_mcam, int prio,
-			 int *resp_count)
+			 struct roc_npc_flow *ref_mcam, int prio, int *resp_count)
 {
 	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
 
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index 2a409cce99..91c84d7d97 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -462,6 +462,9 @@ int __roc_api roc_npc_mcam_alloc_entries(struct roc_npc *roc_npc, int ref_entry,
 int __roc_api roc_npc_mcam_ena_dis_entry(struct roc_npc *roc_npc, struct roc_npc_flow *mcam,
 					 bool enable);
 int __roc_api roc_npc_mcam_write_entry(struct roc_npc *roc_npc, struct roc_npc_flow *mcam);
+void __roc_api roc_npc_defrag_mcam_banks(struct roc_npc *roc_npc);
+uint8_t __roc_api roc_npc_get_key_type(struct roc_npc *roc_npc, struct roc_npc_flow *flow);
+uint8_t __roc_api roc_npc_kex_key_type_config_get(struct roc_npc *roc_npc);
 int __roc_api roc_npc_flow_parse(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 				 const struct roc_npc_item_info pattern[],
 				 const struct roc_npc_action actions[], struct roc_npc_flow *flow);
diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index 3aa7ff56a9..a9b923d31c 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -425,6 +425,21 @@ npc_mcam_alloc_entries(struct mbox *mbox, int ref_mcam, int *alloc_entry, int re
 	return rc;
 }
 
+uint8_t
+npc_kex_key_type_config_get(struct npc *npc)
+{
+	/* KEX is configured just for X2 */
+	if (npc->keyw[ROC_NPC_INTF_RX] == 1)
+		return NPC_CN20K_MCAM_KEY_X2;
+
+	/* KEX is configured just for X4 */
+	if (npc->keyw[ROC_NPC_INTF_RX] == 2)
+		return NPC_CN20K_MCAM_KEY_X4;
+
+	/* KEX is configured for both X2 and X4 */
+	return NPC_CN20K_MCAM_KEY_DYN;
+}
+
 int
 npc_mcam_alloc_entry(struct npc *npc, struct roc_npc_flow *mcam, struct roc_npc_flow *ref_mcam,
 		     uint8_t prio, int *resp_count)
@@ -437,15 +452,20 @@ npc_mcam_alloc_entry(struct npc *npc, struct roc_npc_flow *mcam, struct roc_npc_
 	req = mbox_alloc_msg_npc_mcam_alloc_entry(mbox);
 	if (req == NULL)
 		goto exit;
-	req->contig = 1;
+
 	req->count = 1;
 	req->ref_priority = prio;
 	req->ref_entry = ref_mcam ? ref_mcam->mcam_id : 0;
 	req->kw_type = mcam->key_type;
+
+	if (npc_kex_key_type_config_get(npc) == NPC_CN20K_MCAM_KEY_DYN)
+		req->virt = 1;
+
 	rc = mbox_process_msg(mbox, (void *)&rsp);
 	if (rc)
 		goto exit;
-	mcam->mcam_id = rsp->entry;
+
+	mcam->mcam_id = rsp->entry_list[0];
 	mcam->nix_intf = ref_mcam ? ref_mcam->nix_intf : 0;
 	*resp_count = rsp->count;
 
diff --git a/drivers/common/cnxk/roc_npc_mcam_dump.c b/drivers/common/cnxk/roc_npc_mcam_dump.c
index 29221a2169..d6ee0b982a 100644
--- a/drivers/common/cnxk/roc_npc_mcam_dump.c
+++ b/drivers/common/cnxk/roc_npc_mcam_dump.c
@@ -830,7 +830,11 @@ npc_flow_hw_mcam_entry_dump(FILE *file, struct npc *npc, struct roc_npc_flow *fl
 	else
 		mbox = npc->mbox;
 
-	mcam_read_req = mbox_alloc_msg_npc_mcam_read_entry(mbox_get(mbox));
+	if (roc_model_is_cn20k())
+		mcam_read_req = mbox_alloc_msg_npc_cn20k_mcam_read_entry(mbox_get(mbox));
+	else
+		mcam_read_req = mbox_alloc_msg_npc_mcam_read_entry(mbox_get(mbox));
+
 	if (mcam_read_req == NULL) {
 		plt_err("Failed to alloc msg");
 		mbox_put(mbox);
diff --git a/drivers/common/cnxk/roc_npc_priv.h b/drivers/common/cnxk/roc_npc_priv.h
index 56471a6ca9..5812cf0f8d 100644
--- a/drivers/common/cnxk/roc_npc_priv.h
+++ b/drivers/common/cnxk/roc_npc_priv.h
@@ -332,10 +332,17 @@ enum npc_kpu_parser_flag {
 	NPC_F_LAST /* has to be the last item */
 };
 
-#define NPC_ACTION_TERM                                                        \
-	(ROC_NPC_ACTION_TYPE_DROP | ROC_NPC_ACTION_TYPE_QUEUE |                \
-	 ROC_NPC_ACTION_TYPE_RSS | ROC_NPC_ACTION_TYPE_DUP |                   \
-	 ROC_NPC_ACTION_TYPE_SEC)
+enum npc_mcam_cn20k_key_width {
+	NPC_CN20K_MCAM_KEY_X1 = 0,
+	NPC_CN20K_MCAM_KEY_DYN = NPC_CN20K_MCAM_KEY_X1,
+	NPC_CN20K_MCAM_KEY_X2,
+	NPC_CN20K_MCAM_KEY_X4,
+	NPC_CN20K_MCAM_KEY_MAX,
+};
+
+#define NPC_ACTION_TERM                                                                            \
+	(ROC_NPC_ACTION_TYPE_DROP | ROC_NPC_ACTION_TYPE_QUEUE | ROC_NPC_ACTION_TYPE_RSS |          \
+	 ROC_NPC_ACTION_TYPE_DUP | ROC_NPC_ACTION_TYPE_SEC)
 
 struct npc_xtract_info {
 	/* Length in bytes of pkt data extracted. len = 0
@@ -498,6 +505,7 @@ int npc_update_parse_state(struct npc_parse_state *pst, struct npc_parse_item_in
 void npc_get_hw_supp_mask(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid,
 			  int lt);
 uint8_t npc_get_key_type(struct npc *npc, struct roc_npc_flow *flow);
+uint8_t npc_kex_key_type_config_get(struct npc *npc);
 int npc_mask_is_supported(const char *mask, const char *hw_mask, int len);
 int npc_parse_item_basic(const struct roc_npc_item_info *item, struct npc_parse_item_info *info);
 int npc_parse_meta_items(struct npc_parse_state *pst);
diff --git a/drivers/common/cnxk/roc_npc_utils.c b/drivers/common/cnxk/roc_npc_utils.c
index 75d3b0702c..d95dc0996c 100644
--- a/drivers/common/cnxk/roc_npc_utils.c
+++ b/drivers/common/cnxk/roc_npc_utils.c
@@ -4,14 +4,6 @@
 #include "roc_api.h"
 #include "roc_priv.h"
 
-enum npc_mcam_cn20k_key_width {
-	NPC_CN20K_MCAM_KEY_X1 = 0,
-	NPC_CN20K_MCAM_KEY_DYN = NPC_CN20K_MCAM_KEY_X1,
-	NPC_CN20K_MCAM_KEY_X2,
-	NPC_CN20K_MCAM_KEY_X4,
-	NPC_CN20K_MCAM_KEY_MAX,
-};
-
 uint8_t
 npc_get_key_type(struct npc *npc, struct roc_npc_flow *flow)
 {
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index cdbfc1d39a..bc2d7c2336 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -465,6 +465,8 @@ INTERNAL {
 	roc_npa_pool_range_update_check;
 	roc_npa_zero_aura_handle;
 	roc_npc_aged_flow_ctx_get;
+	roc_npc_defrag_mcam_banks;
+	roc_npc_get_key_type;
 	roc_npc_fini;
 	roc_npc_flow_create;
 	roc_npc_flow_destroy;
@@ -475,6 +477,7 @@ INTERNAL {
 	roc_npc_get_low_priority_mcam;
 	roc_npc_init;
 	roc_npc_kex_capa_get;
+	roc_npc_kex_key_type_config_get;
 	roc_npc_mark_actions_get;
 	roc_npc_mark_actions_sub_return;
 	roc_npc_vtag_actions_get;
-- 
2.42.0


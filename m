Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC3C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:07:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EAA3427E2;
	Fri, 31 Jan 2025 09:06:47 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6BA91427DE
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:45 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7naF6024137
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 EqRTHRtTPwJiaZTbX1Unx/58oRyXf1Bh5c24mHBJwc=; b=PSEUuFun2HA5uBlS0
 Fng/GK9YsFpgXCK8FeoxTwwrVsjT9NIrROJczlEsFDOUGsnYWWmp8WJj27Q+VTTi
 xtxopKucW42oDW8U6JNNmm/EVcURAGxfwOBOn4y9Mv9pT4Cy4a5ACPh3bfRB3lZl
 UUM3sXkfwKmgaWsdf/AjDTNmp3TPDWdiahM/+bd+4+NeOiNs3ej8j9NpfDWaf0wZ
 XXXN6EdyUiMPFPFW5WcmiWeXnXu0IYLVNIJAvBc83wjSGe3mKwUTj1PHJETOb+2u
 GiEMTTs6HcgqMCcR/MfTCoa6toRrnFgWpkLIrM0ME/m1O9ZEEZBJhEagNLka6hWG
 Q4W6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44gtenr0ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:44 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:43 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id B3D8E3F7045;
 Fri, 31 Jan 2025 00:06:40 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 22/34] common/cnxk: support for NPC inline rule for cn20k
Date: Fri, 31 Jan 2025 13:35:17 +0530
Message-ID: <20250131080530.3224977-22-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SqRAVi3qUyn6k6QsaiqRzK3f6NEWbf6V
X-Proofpoint-ORIG-GUID: SqRAVi3qUyn6k6QsaiqRzK3f6NEWbf6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

Use UCAST_CPT in cn20k as opposed to UCAST_IPSEC in cn10k
for inline IPsec rule.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/hw/nix.h            |  1 +
 drivers/common/cnxk/roc_npc.c           | 15 +++++++++++----
 drivers/common/cnxk/roc_npc_mcam.c      |  7 ++++---
 drivers/common/cnxk/roc_npc_mcam_dump.c |  5 +++++
 drivers/common/cnxk/roc_npc_priv.h      |  8 ++++++++
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index e4d8d285d5..d16fa3b3ec 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -645,6 +645,7 @@
 #define NIX_RX_ACTIONOP_RSS	     (0x4ull)
 #define NIX_RX_ACTIONOP_PF_FUNC_DROP (0x5ull)
 #define NIX_RX_ACTIONOP_MIRROR	     (0x6ull)
+#define NIX_RX_ACTIONOP_UCAST_CPT    (0x7ull)
 #define NIX_RX_ACTIONOP_DEFAULT	     (0xfull)
 
 #define NIX_RX_VTAGACTION_VTAG0_RELPTR (0x0ull)
diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 138f12f6d8..94d5cc84f8 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -568,6 +568,7 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
 	const struct roc_npc_action *sec_action = NULL;
 	const struct roc_npc_action_sample *act_sample;
+	struct roc_nix *roc_nix = roc_npc->roc_nix;
 	const struct roc_npc_action_mark *act_mark;
 	const struct roc_npc_action_meter *act_mtr;
 	const struct roc_npc_action_queue *act_q;
@@ -576,7 +577,6 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	uint8_t has_spi_to_sa_act = 0;
 	int sel_act, req_act = 0;
 	uint16_t pf_func, vf_id;
-	struct roc_nix *roc_nix;
 	int errcode = 0;
 	int mark = 0;
 	int rq = 0;
@@ -885,8 +885,15 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	} else if (req_act & ROC_NPC_ACTION_TYPE_RSS) {
 		flow->npc_action = NIX_RX_ACTIONOP_UCAST;
 	} else if (req_act & ROC_NPC_ACTION_TYPE_SEC) {
-		flow->npc_action = NIX_RX_ACTIONOP_UCAST_IPSEC;
-		flow->npc_action |= (uint64_t)rq << 20;
+		if (roc_model_is_cn20k()) {
+			flow->npc_action = NIX_RX_ACTIONOP_UCAST_CPT;
+			flow->npc_action |= (uint64_t)rq << 20;
+			flow->npc_action2 =
+				roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true) << 8;
+		} else {
+			flow->npc_action = NIX_RX_ACTIONOP_UCAST_IPSEC;
+			flow->npc_action |= (uint64_t)rq << 20;
+		}
 	} else if (req_act & (ROC_NPC_ACTION_TYPE_FLAG | ROC_NPC_ACTION_TYPE_MARK)) {
 		flow->npc_action = NIX_RX_ACTIONOP_UCAST;
 	} else if (req_act & ROC_NPC_ACTION_TYPE_COUNT) {
@@ -1550,7 +1557,7 @@ npc_inline_dev_ipsec_action_free(struct npc *npc, struct roc_npc_flow *flow)
 	inl_dev = idev->nix_inl_dev;
 
 	if (flow->nix_intf == NIX_INTF_RX && inl_dev && inl_dev->ipsec_index &&
-	    ((flow->npc_action & 0xF) == NIX_RX_ACTIONOP_UCAST_IPSEC)) {
+	    roc_npc_action_is_rx_inline(flow->npc_action)) {
 		inl_dev->curr_ipsec_idx--;
 		inl_dev->ipsec_index[inl_dev->curr_ipsec_idx] = flow->mcam_id;
 		flow->enable = 0;
diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index 5db72c22ae..3aa7ff56a9 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -747,7 +747,7 @@ npc_mcam_set_channel(struct roc_npc_flow *flow, struct npc_cn20k_mcam_write_entr
 			chan = (channel | NIX_CHAN_CPT_CH_START);
 			mask = (chan_mask | NIX_CHAN_CPT_CH_START);
 		} else {
-			if (!(flow->npc_action & NIX_RX_ACTIONOP_UCAST_IPSEC)) {
+			if (!roc_npc_action_is_rx_inline(flow->npc_action)) {
 				/*
 				 * Clear bits 10 & 11 corresponding to CPT
 				 * channel. By default, rules should match
@@ -951,6 +951,7 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 	if (flow->nix_intf == NIX_INTF_RX)
 		flow->npc_action |= (uint64_t)flow->recv_queue << 20;
 	req.entry_data.action = flow->npc_action;
+	req.entry_data.action2 = flow->npc_action2;
 
 	/*
 	 * Driver sets vtag action on per interface basis, not
@@ -973,7 +974,7 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 
 	if (flow->nix_intf == NIX_INTF_RX) {
 		if (inl_dev && inl_dev->is_multi_channel &&
-		    (flow->npc_action & NIX_RX_ACTIONOP_UCAST_IPSEC)) {
+		    roc_npc_action_is_rx_inline(flow->npc_action)) {
 			pf_func = nix_inl_dev_pffunc_get();
 			req.entry_data.action &= ~(GENMASK(19, 4));
 			req.entry_data.action |= (uint64_t)pf_func << 4;
@@ -1284,7 +1285,7 @@ npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 	if (idev)
 		inl_dev = idev->nix_inl_dev;
 	if (inl_dev && inl_dev->is_multi_channel &&
-	    (pst->flow->npc_action & NIX_RX_ACTIONOP_UCAST_IPSEC))
+	    roc_npc_action_is_rx_inline(pst->flow->npc_action))
 		skip_base_rule = true;
 
 	if ((pst->is_vf || pst->flow->is_rep_vf) && pst->flow->nix_intf == NIX_INTF_RX &&
diff --git a/drivers/common/cnxk/roc_npc_mcam_dump.c b/drivers/common/cnxk/roc_npc_mcam_dump.c
index fa2fd0d344..29221a2169 100644
--- a/drivers/common/cnxk/roc_npc_mcam_dump.c
+++ b/drivers/common/cnxk/roc_npc_mcam_dump.c
@@ -639,6 +639,11 @@ npc_flow_dump_rx_action(FILE *file, uint64_t npc_action)
 			(uint64_t)NIX_RX_ACTIONOP_UCAST_IPSEC);
 		plt_strlcpy(index_name, "RQ Index:", NPC_MAX_FIELD_NAME_SIZE);
 		break;
+	case NIX_RX_ACTIONOP_UCAST_CPT:
+		fprintf(file, "NIX_RX_ACTIONOP_UCAST_CPT (%" PRIu64 ")\n",
+			(uint64_t)NIX_RX_ACTIONOP_UCAST_CPT);
+		plt_strlcpy(index_name, "RQ Index:", NPC_MAX_FIELD_NAME_SIZE);
+		break;
 	case NIX_RX_ACTIONOP_MCAST:
 		fprintf(file, "NIX_RX_ACTIONOP_MCAST (%" PRIu64 ")\n",
 			(uint64_t)NIX_RX_ACTIONOP_MCAST);
diff --git a/drivers/common/cnxk/roc_npc_priv.h b/drivers/common/cnxk/roc_npc_priv.h
index b7d726caa1..56471a6ca9 100644
--- a/drivers/common/cnxk/roc_npc_priv.h
+++ b/drivers/common/cnxk/roc_npc_priv.h
@@ -466,6 +466,14 @@ roc_npc_to_npc_priv(struct roc_npc *npc)
 	return (struct npc *)npc->reserved;
 }
 
+static inline bool
+roc_npc_action_is_rx_inline(uint64_t npc_action)
+{
+	uint64_t op = npc_action & 0xFULL;
+
+	return (op == NIX_RX_ACTIONOP_UCAST_IPSEC || op == NIX_RX_ACTIONOP_UCAST_CPT);
+}
+
 int npc_mcam_get_stats(struct mbox *mbox, struct roc_npc_flow *flow, uint64_t *count);
 int npc_mcam_alloc_counter(struct mbox *mbox, uint16_t *ctr);
 int npc_mcam_free_counter(struct mbox *mbox, uint16_t ctr_id);
-- 
2.34.1


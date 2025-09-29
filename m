Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0B1CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:45:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A130406B7;
	Mon, 29 Sep 2025 11:44:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9D18140A76
 for <dev@dpdk.org>; Mon, 29 Sep 2025 11:44:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T4LBpe018976
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:44:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 8YXxzwBCznYArPoz1enbUA2kUDU1O012ktYj1zi4DY=; b=RKlEQY/Pi0Yh2HP0+
 Oh11T+ykQ2tk4/70U6rQYt84QosiKqIV+K/5qDoUMZ1g5NIRSGnSBLUjNuknoie4
 jyb9Sa82ZYc3ZroLp/ZTm4pnNJGO5vpuQkQd03jN1MuQvdJ0KibHD7jiZAlKmdi/
 /U3EtajnpA3klSm/ZTaXvpJQhCYFfPBUM6/fLMStT8DG8QKpo+BCv8r8aXloq4Y9
 ui9e0yIFTVlL+/8EbWRj5l3gcc4QYIK3CQk6lQ4nVXs5N3LFUp7yxHxI4U30KiYE
 rfb0zj+qjxwEvVztQ1k2apzWytyVqQC+VH/DhUNtZu8zYRWT651RGQnREmWsTYpC
 ovOrA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49f0p51w3m-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:44:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 02:44:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 02:44:38 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id AF1953F7059;
 Mon, 29 Sep 2025 02:44:26 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 09/10] common/cnxk: optimize ROC layer
Date: Mon, 29 Sep 2025 15:13:52 +0530
Message-ID: <20250929094353.1027744-10-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929094353.1027744-1-ktejasree@marvell.com>
References: <20250929094353.1027744-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rLWDSomi_n-0QX1YyzOAYqw99GT0dgdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDA2OSBTYWx0ZWRfX1Sz8BuKdPi7s
 qP0h7nQcGSLodW2OoOHy27aI59yAuKin7kW1ky113LdHe43RgvkEblCd7Hgaj/Rdy0Z+g96kKot
 WG5EfhFh0l3AQ22Rb70ecY3qYXQVtsuDnc/1Tq5fYmFKfcPfXSXynmGsU8fKq35Q/1tNX2Finup
 R/efbHRzWc8JSSU71z54pQVHMqWSlktMQGohiHghtoSlPcg7udVRDKSPKSlo2C1vgnUOlDGmdxg
 Qn320WIUaZILntQQhhMf9EE55XFo58pV1S2egt1Br2SSK0ck77aucEh8Hxs68QmN4eT7WfBbhk2
 lE1nRtQpOVynPywMQjCq8uhnDG3Y1rEBaVc67ZxUHvir5dO+mqOuNy1N0NaMfoEkEAxEm8+Bf5O
 rHefhFW7UfVT8qbIPxzPSnNaJntOtw==
X-Authority-Analysis: v=2.4 cv=StCdKfO0 c=1 sm=1 tr=0 ts=68da5504 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=NQFgeBY9bn75emLcLYwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: rLWDSomi_n-0QX1YyzOAYqw99GT0dgdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
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

Adding ROC layer optimizations.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c    |  4 ++--
 drivers/common/cnxk/roc_cpt_sg.h |  1 +
 drivers/common/cnxk/roc_se.c     | 10 +++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index c310d6432b..c467b55139 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -1173,10 +1173,10 @@ roc_cpt_lmtline_init(struct roc_cpt *roc_cpt, struct roc_cpt_lmtline *lmtline, i
 	lmtline->io_addr = lf->io_addr;
 	lmtline->fc_thresh = lf->nb_desc - CPT_LF_FC_MIN_THRESHOLD;
 
-	if (roc_model_is_cn10k()) {
+	if (roc_model_is_cn10k() || roc_model_is_cn20k()) {
 		if (is_dual) {
 			lmtline->io_addr |= ROC_CN10K_TWO_CPT_INST_DW_M1 << 4;
-			lmtline->fc_thresh = lf->nb_desc -  2 * CPT_LF_FC_MIN_THRESHOLD;
+			lmtline->fc_thresh = lf->nb_desc - 2 * CPT_LF_FC_MIN_THRESHOLD;
 		} else {
 			lmtline->io_addr |= ROC_CN10K_CPT_INST_DW_M1 << 4;
 		}
diff --git a/drivers/common/cnxk/roc_cpt_sg.h b/drivers/common/cnxk/roc_cpt_sg.h
index 7c3caf94d7..d513bd7b7b 100644
--- a/drivers/common/cnxk/roc_cpt_sg.h
+++ b/drivers/common/cnxk/roc_cpt_sg.h
@@ -14,6 +14,7 @@
 #define ROC_SG_ENTRY_SIZE    sizeof(struct roc_sglist_comp)
 #define ROC_SG_MAX_COMP	     25
 #define ROC_SG_MAX_DLEN_SIZE (ROC_SG_LIST_HDR_SIZE + (ROC_SG_MAX_COMP * ROC_SG_ENTRY_SIZE))
+
 #define ROC_SG2_MAX_PTRS 48
 #define ROC_SG1_MAX_PTRS 32
 
diff --git a/drivers/common/cnxk/roc_se.c b/drivers/common/cnxk/roc_se.c
index 5a3ed0b647..f71832ff3a 100644
--- a/drivers/common/cnxk/roc_se.c
+++ b/drivers/common/cnxk/roc_se.c
@@ -268,10 +268,10 @@ int
 roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint8_t *key,
 		    uint16_t key_len, uint16_t mac_len)
 {
+	uint8_t opcode_minor, opcode_major = 0;
 	struct roc_se_kasumi_ctx *k_ctx;
 	struct roc_se_pdcp_ctx *pctx;
 	struct roc_se_context *fctx;
-	uint8_t opcode_minor;
 	bool chained_op;
 
 	if (se_ctx == NULL)
@@ -310,6 +310,7 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 				se_ctx->fc_type = ROC_SE_PDCP;
 			se_ctx->pdcp_auth_alg = ROC_SE_PDCP_ALG_TYPE_SNOW3G;
 			se_ctx->zsk_flags = 0x1;
+			opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
 			break;
 		case ROC_SE_ZUC_EIA3:
 			if (unlikely(key_len != 16)) {
@@ -339,6 +340,7 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 				se_ctx->fc_type = ROC_SE_PDCP;
 			se_ctx->pdcp_auth_alg = ROC_SE_PDCP_ALG_TYPE_ZUC;
 			se_ctx->zsk_flags = 0x1;
+			opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
 			break;
 		case ROC_SE_AES_CMAC_EIA2:
 			key_type = cpt_pdcp_chain_key_type_get(key_len);
@@ -356,6 +358,7 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 			se_ctx->pdcp_auth_alg = ROC_SE_PDCP_ALG_TYPE_AES_CMAC;
 			se_ctx->eia2 = 1;
 			se_ctx->zsk_flags = 0x1;
+			opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
 			break;
 		case ROC_SE_KASUMI_F9_ECB:
 			/* Kasumi ECB mode */
@@ -363,11 +366,13 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 			memcpy(k_ctx->ci_key, key, key_len);
 			se_ctx->fc_type = ROC_SE_KASUMI;
 			se_ctx->zsk_flags = 0x1;
+			opcode_major = ROC_SE_MAJOR_OP_KASUMI | ROC_DMA_MODE_SG;
 			break;
 		case ROC_SE_KASUMI_F9_CBC:
 			memcpy(k_ctx->ci_key, key, key_len);
 			se_ctx->fc_type = ROC_SE_KASUMI;
 			se_ctx->zsk_flags = 0x1;
+			opcode_major = ROC_SE_MAJOR_OP_KASUMI | ROC_DMA_MODE_SG;
 			break;
 		default:
 			return -1;
@@ -385,6 +390,7 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 		else
 			opcode_minor = ((1 << 4) | 1);
 
+		se_ctx->template_w4.s.opcode_major = opcode_major;
 		se_ctx->template_w4.s.opcode_minor = opcode_minor;
 		return 0;
 	}
@@ -587,6 +593,7 @@ roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type, const ui
 success:
 	se_ctx->enc_cipher = type;
 	if (se_ctx->fc_type == ROC_SE_PDCP_CHAIN) {
+		se_ctx->template_w4.s.opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
 		se_ctx->template_w4.s.opcode_minor = se_ctx->ciph_then_auth ? 2 : 3;
 	} else if (se_ctx->fc_type == ROC_SE_PDCP) {
 		if (roc_model_is_cn9k())
@@ -594,6 +601,7 @@ roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type, const ui
 				((1 << 7) | (se_ctx->pdcp_ci_alg << 5) | (se_ctx->zsk_flags & 0x7));
 		else
 			opcode_minor = ((1 << 4));
+		se_ctx->template_w4.s.opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
 		se_ctx->template_w4.s.opcode_minor = opcode_minor;
 	}
 	return 0;
-- 
2.25.1


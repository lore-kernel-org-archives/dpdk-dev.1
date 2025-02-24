Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B77C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:41:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8482A40A67;
	Mon, 24 Feb 2025 10:40:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D1A0D40DD3
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:40:21 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9ZIZJ016264
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 1hrNOv/Z4LoCLCOQ0vB7XFslqQursYgManPtmDfTXg=; b=ScxdVfVBQv/9gIfKY
 esC8qYfIAfPPRwsPPtxPP3vVs4iTYjZ9Ovaxrt8NTeg3nbPcHITWsP0X32vm/68G
 2iMFAwA2RpIfpi5FHeTCG3i8txd53nzRczR2ewKA5YmEVa3uBuIzgu+9qAIUJsFA
 NXBfzxUv4Bf8Iw14XRFFEEyMZ4Oq/7M0SGIglfA42XmitSwEE65guUlFzzbPw3Vf
 K7ksu/urJbW6ky+BGrA4Vy+GaMRmueseawmtSXO+iIpbgAft74O6gSC3hnKWxYjr
 frB3vuUFWcbIs1LM0R1N/xmB+j1AFn/3szqkvVJoNAeZasEX0LG7h5KYVZ8kHlh6
 TVQ4g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450p9300cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:20 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:19 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id C54613F706A;
 Mon, 24 Feb 2025 01:40:16 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 19/33] common/cnxk: add NIX inline reassembly profile config
Date: Mon, 24 Feb 2025 15:09:01 +0530
Message-ID: <20250224093915.1253215-19-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CwJeyyhMxZtZO1n0D7ZvVFS6OyMQuFQ6
X-Proofpoint-GUID: CwJeyyhMxZtZO1n0D7ZvVFS6OyMQuFQ6
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

Reassembly profile configuration for nix inline path.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_features.h     |   6 +
 drivers/common/cnxk/roc_ie_ow.c        |  22 +++
 drivers/common/cnxk/roc_ie_ow.h        |   2 +
 drivers/common/cnxk/roc_nix.h          |   3 +-
 drivers/common/cnxk/roc_nix_debug.c    |   8 +-
 drivers/common/cnxk/roc_nix_inl.c      | 202 ++++++++++++++++++++----
 drivers/common/cnxk/roc_nix_inl.h      |  10 +-
 drivers/common/cnxk/roc_nix_inl_dev.c  | 205 +++++++++++++++++++++++--
 drivers/common/cnxk/roc_nix_inl_priv.h |  19 ++-
 drivers/common/cnxk/roc_nix_priv.h     |   9 +-
 drivers/common/cnxk/version.map        |   1 +
 11 files changed, 425 insertions(+), 62 deletions(-)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 49a563ef95..48ba2fade7 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -114,4 +114,10 @@ roc_feature_nix_has_inl_profile(void)
 	return roc_model_is_cn20k();
 }
 
+static inline bool
+roc_feature_nix_has_plain_pkt_reassembly(void)
+{
+	return roc_model_is_cn20k();
+}
+
 #endif
diff --git a/drivers/common/cnxk/roc_ie_ow.c b/drivers/common/cnxk/roc_ie_ow.c
index dd83578b62..9537e48389 100644
--- a/drivers/common/cnxk/roc_ie_ow.c
+++ b/drivers/common/cnxk/roc_ie_ow.c
@@ -27,6 +27,28 @@ roc_ow_ipsec_inb_sa_init(struct roc_ow_ipsec_inb_sa *sa)
 	sa->w0.s.aop_valid = 1;
 }
 
+void
+roc_ow_reass_inb_sa_init(struct roc_ow_ipsec_inb_sa *sa)
+{
+	size_t offset;
+
+	memset(sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));
+
+	sa->w0.s.pkt_output = ROC_IE_OW_SA_PKT_OUTPUT_HW_BASED_DEFRAG;
+	sa->w0.s.pkt_format = ROC_IE_OW_SA_PKT_FMT_META;
+	sa->w0.s.pkind = ROC_IE_OW_CPT_PKIND;
+	sa->w2.s.l3hdr_on_err = 1;
+	sa->w2.s.valid = 1;
+	sa->w2.s.dir = ROC_IE_SA_DIR_INBOUND;
+
+	offset = offsetof(struct roc_ow_ipsec_inb_sa, ctx);
+	sa->w0.s.hw_ctx_off = offset / ROC_CTX_UNIT_8B;
+	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off + 1;
+	sa->w0.s.ctx_size = ROC_IE_OW_CTX_ILEN;
+	sa->w0.s.ctx_hdr_size = ROC_IE_OW_SA_CTX_HDR_SIZE;
+	sa->w0.s.aop_valid = 1;
+}
+
 void
 roc_ow_ipsec_outb_sa_init(struct roc_ow_ipsec_outb_sa *sa)
 {
diff --git a/drivers/common/cnxk/roc_ie_ow.h b/drivers/common/cnxk/roc_ie_ow.h
index 56ca1e7f75..4a3291d458 100644
--- a/drivers/common/cnxk/roc_ie_ow.h
+++ b/drivers/common/cnxk/roc_ie_ow.h
@@ -12,6 +12,7 @@
 /* CN20K IPsec opcodes */
 #define ROC_IE_OW_MAJOR_OP_PROCESS_OUTBOUND_IPSEC 0x28UL
 #define ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_IPSEC  0x29UL
+#define ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_REASS  0x2BUL
 
 #define ROC_IE_OW_MAJOR_OP_WRITE_SA 0x01UL
 #define ROC_IE_OW_MINOR_OP_WRITE_SA 0x09UL
@@ -532,6 +533,7 @@ PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, ctx) == 31 * sizeof(uint
 	(PLT_MAX(sizeof(struct roc_ow_ipsec_inb_sa), sizeof(struct roc_ow_ipsec_outb_sa)))
 
 void __roc_api roc_ow_ipsec_inb_sa_init(struct roc_ow_ipsec_inb_sa *sa);
+void __roc_api roc_ow_reass_inb_sa_init(struct roc_ow_ipsec_inb_sa *sa);
 void __roc_api roc_ow_ipsec_outb_sa_init(struct roc_ow_ipsec_outb_sa *sa);
 
 #endif /* __ROC_IE_OW_H__ */
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index a66391449f..a1bd14ffc4 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -490,9 +490,10 @@ struct roc_nix {
 	uintptr_t meta_mempool;
 	uint16_t rep_cnt;
 	uint16_t rep_pfvf_map[MAX_PFVF_REP];
+	bool reass_ena;
 	TAILQ_ENTRY(roc_nix) next;
 
-#define ROC_NIX_MEM_SZ (6 * 1070)
+#define ROC_NIX_MEM_SZ (6 * 1112)
 	uint8_t reserved[ROC_NIX_MEM_SZ] __plt_cache_aligned;
 } __plt_cache_aligned;
 
diff --git a/drivers/common/cnxk/roc_nix_debug.c b/drivers/common/cnxk/roc_nix_debug.c
index 0cc8d7cc1e..f9294e693b 100644
--- a/drivers/common/cnxk/roc_nix_debug.c
+++ b/drivers/common/cnxk/roc_nix_debug.c
@@ -1510,8 +1510,8 @@ roc_nix_dump(struct roc_nix *roc_nix, FILE *file)
 	nix_dump(file, "  \ttx_pause = %d", nix->tx_pause);
 	nix_dump(file, "  \tinl_inb_ena = %d", nix->inl_inb_ena);
 	nix_dump(file, "  \tinl_outb_ena = %d", nix->inl_outb_ena);
-	nix_dump(file, "  \tinb_sa_base = 0x%p", nix->inb_sa_base);
-	nix_dump(file, "  \tinb_sa_sz = %" PRIu64, nix->inb_sa_sz);
+	nix_dump(file, "  \tinb_sa_base = 0x%p", nix->inb_sa_base[nix->ipsec_prof_id]);
+	nix_dump(file, "  \tinb_sa_sz = %" PRIu64, nix->inb_sa_sz[nix->ipsec_prof_id]);
 	nix_dump(file, "  \toutb_sa_base = 0x%p", nix->outb_sa_base);
 	nix_dump(file, "  \toutb_sa_sz = %" PRIu64, nix->outb_sa_sz);
 	nix_dump(file, "  \toutb_err_sso_pffunc = 0x%x", nix->outb_err_sso_pffunc);
@@ -1554,8 +1554,8 @@ roc_nix_inl_dev_dump(struct roc_nix_inl_dev *roc_inl_dev, FILE *file)
 	nix_dump(file, "  \tssow_msixoff = %d", inl_dev->ssow_msixoff);
 	nix_dump(file, "  \tnix_cints = %d", inl_dev->cints);
 	nix_dump(file, "  \tnix_qints = %d", inl_dev->qints);
-	nix_dump(file, "  \tinb_sa_base = 0x%p", inl_dev->inb_sa_base);
-	nix_dump(file, "  \tinb_sa_sz = %d", inl_dev->inb_sa_sz);
+	nix_dump(file, "  \tinb_sa_base = 0x%p", inl_dev->inb_sa_base[inl_dev->ipsec_prof_id]);
+	nix_dump(file, "  \tinb_sa_sz = %d", inl_dev->inb_sa_sz[inl_dev->ipsec_prof_id]);
 	nix_dump(file, "  \txaq_buf_size = %u", inl_dev->xaq_buf_size);
 	nix_dump(file, "  \txae_waes = %u", inl_dev->xae_waes);
 	nix_dump(file, "  \tiue = %u", inl_dev->iue);
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 127f834ee5..652698d13b 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -399,6 +399,7 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 	struct nix_inl_dev *inl_dev = NULL;
 	uint64_t max_sa, i, sa_pow2_sz;
 	uint64_t sa_idx_w, lenm1_max;
+	uint8_t profile_id = 0;
 	struct mbox *mbox;
 	size_t inb_sa_sz;
 	void *sa;
@@ -409,7 +410,9 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 		rc = nix_inl_setup_dflt_ipsec_profile(&nix->dev, &nix->ipsec_prof_id);
 		if (rc)
 			return rc;
+		profile_id = nix->ipsec_prof_id;
 	}
+
 	mbox = mbox_get(nix->dev.mbox);
 
 	max_sa = plt_align32pow2(ipsec_in_max_spi - ipsec_in_min_spi + 1);
@@ -425,11 +428,11 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 		inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
 
 	/* Alloc contiguous memory for Inbound SA's */
-	nix->inb_sa_sz = inb_sa_sz;
+	nix->inb_sa_sz[profile_id] = inb_sa_sz;
+	nix->inb_sa_max[profile_id] = max_sa;
 	nix->inb_spi_mask = max_sa - 1;
-	nix->inb_sa_base = plt_zmalloc(inb_sa_sz * max_sa,
-				       ROC_NIX_INL_SA_BASE_ALIGN);
-	if (!nix->inb_sa_base) {
+	nix->inb_sa_base[profile_id] = plt_zmalloc(inb_sa_sz * max_sa, ROC_NIX_INL_SA_BASE_ALIGN);
+	if (!nix->inb_sa_base[profile_id]) {
 		rc = -ENOMEM;
 		plt_err("Failed to allocate memory for Inbound SA");
 		goto exit;
@@ -441,7 +444,7 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 
 	if (!roc_model_is_cn9k()) {
 		for (i = 0; i < max_sa; i++) {
-			sa = ((uint8_t *)nix->inb_sa_base) + (i * inb_sa_sz);
+			sa = ((uint8_t *)nix->inb_sa_base[profile_id]) + (i * inb_sa_sz);
 			if (roc_model_is_cn10k())
 				roc_ot_ipsec_inb_sa_init(sa);
 			else
@@ -461,7 +464,7 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 		}
 
 		lf_cfg->enable = 1;
-		lf_cfg->sa_base_addr = (uintptr_t)nix->inb_sa_base;
+		lf_cfg->sa_base_addr = (uintptr_t)nix->inb_sa_base[profile_id];
 		lf_cfg->ipsec_cfg1.sa_idx_w = sa_idx_w;
 		lf_cfg->ipsec_cfg0.lenm1_max = lenm1_max;
 		lf_cfg->ipsec_cfg1.sa_idx_max = max_sa - 1;
@@ -490,8 +493,8 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 		}
 
 		lf_cfg->enable = 1;
-		lf_cfg->profile_id = nix->ipsec_prof_id; /* IPsec profile is 0th one */
-		lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base;
+		lf_cfg->profile_id = profile_id; /* IPsec profile is 0th one */
+		lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
 		lf_cfg->rx_inline_cfg0 = ((def_cptq << 57) | ((uint64_t)SSO_TT_ORDERED << 44) |
 					  (sa_pow2_sz << 16) | lenm1_max);
 		lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_idx_w << 32);
@@ -506,8 +509,8 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 	mbox_put(mbox);
 	return 0;
 free_mem:
-	plt_free(nix->inb_sa_base);
-	nix->inb_sa_base = NULL;
+	plt_free(nix->inb_sa_base[profile_id]);
+	nix->inb_sa_base[profile_id] = NULL;
 exit:
 	mbox_put(mbox);
 	return rc;
@@ -518,6 +521,7 @@ nix_inl_ipsec_sa_tbl_release(struct roc_nix *roc_nix)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	uint8_t profile_id = 0;
 	int rc;
 
 	if (roc_model_is_cn9k() || roc_model_is_cn10k()) {
@@ -533,6 +537,7 @@ nix_inl_ipsec_sa_tbl_release(struct roc_nix *roc_nix)
 	} else {
 		struct nix_rx_inl_lf_cfg_req *lf_cfg;
 
+		profile_id = nix->ipsec_prof_id;
 		lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
 		if (!lf_cfg) {
 			rc = -ENOSPC;
@@ -540,6 +545,7 @@ nix_inl_ipsec_sa_tbl_release(struct roc_nix *roc_nix)
 		}
 
 		lf_cfg->enable = 0;
+		lf_cfg->profile_id = profile_id; /* IPsec profile is 0th one */
 	}
 
 	rc = mbox_process(mbox);
@@ -548,8 +554,112 @@ nix_inl_ipsec_sa_tbl_release(struct roc_nix *roc_nix)
 		goto exit;
 	}
 
-	plt_free(nix->inb_sa_base);
-	nix->inb_sa_base = NULL;
+	plt_free(nix->inb_sa_base[profile_id]);
+	nix->inb_sa_base[profile_id] = NULL;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+static int
+nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	uint64_t max_sa = 1, sa_pow2_sz;
+	uint64_t sa_idx_w, lenm1_max;
+	size_t inb_sa_sz = 1;
+	uint8_t profile_id;
+	struct mbox *mbox;
+	void *sa;
+	int rc;
+
+	if (!roc_nix->reass_ena)
+		return 0;
+
+	rc = nix_inl_setup_reass_profile(&nix->dev, &nix->reass_prof_id);
+	if (rc)
+		return rc;
+
+	profile_id = nix->reass_prof_id;
+	nix->inb_sa_sz[profile_id] = inb_sa_sz;
+	nix->inb_sa_max[profile_id] = max_sa;
+	nix->inb_spi_mask = 1;
+	nix->inb_sa_base[profile_id] = plt_zmalloc(inb_sa_sz * max_sa, ROC_NIX_INL_SA_BASE_ALIGN);
+	if (!nix->inb_sa_base[profile_id]) {
+		plt_err("Failed to allocate memory for reassembly Inbound SA");
+		return -ENOMEM;
+	}
+
+	sa = ((uint8_t *)nix->inb_sa_base[profile_id]);
+	roc_ow_reass_inb_sa_init(sa);
+
+	mbox = mbox_get(nix->dev.mbox);
+	/* Setup device specific inb SA table */
+	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+	if (lf_cfg == NULL) {
+		rc = -ENOSPC;
+		plt_err("Failed to alloc nix inline reassembly lf cfg mbox msg");
+		goto free_mem;
+	}
+
+	sa_pow2_sz = plt_log2_u32(inb_sa_sz);
+	sa_idx_w = plt_log2_u32(max_sa);
+	lenm1_max = roc_nix_max_pkt_len(roc_nix) - 1;
+
+	lf_cfg->enable = 1;
+	lf_cfg->profile_id = profile_id;
+	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base[profile_id];
+	lf_cfg->rx_inline_cfg0 =
+		(((uint64_t)SSO_TT_ORDERED << 44) | (sa_pow2_sz << 16) | lenm1_max);
+	lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_idx_w << 32);
+
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to setup NIX Inbound reassembly SA conf, rc=%d", rc);
+		goto free_mem;
+	}
+
+	mbox_put(mbox);
+	return 0;
+
+free_mem:
+	plt_free(nix->inb_sa_base[profile_id]);
+	nix->inb_sa_base[profile_id] = NULL;
+	mbox_put(mbox);
+	return rc;
+}
+
+static int
+nix_inl_reass_sa_tbl_release(struct roc_nix *roc_nix)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	uint8_t profile_id;
+	int rc;
+
+	if (!roc_nix->reass_ena)
+		return 0;
+
+	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+	if (!lf_cfg) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	profile_id = nix->reass_prof_id;
+
+	lf_cfg->enable = 0;
+	lf_cfg->profile_id = profile_id;
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to cleanup NIX Inbound Reassembly SA conf, rc=%d", rc);
+		goto exit;
+	}
+
+	plt_free(nix->inb_sa_base[profile_id]);
+	nix->inb_sa_base[profile_id] = NULL;
 exit:
 	mbox_put(mbox);
 	return rc;
@@ -626,11 +736,11 @@ roc_nix_inl_inb_sa_base_get(struct roc_nix *roc_nix, bool inb_inl_dev)
 		inl_dev = idev->nix_inl_dev;
 		/* Return inline dev sa base */
 		if (inl_dev)
-			return (uintptr_t)inl_dev->inb_sa_base;
+			return (uintptr_t)inl_dev->inb_sa_base[inl_dev->ipsec_prof_id];
 		return 0;
 	}
 
-	return (uintptr_t)nix->inb_sa_base;
+	return (uintptr_t)nix->inb_sa_base[nix->ipsec_prof_id];
 }
 
 bool
@@ -716,13 +826,13 @@ roc_nix_inl_inb_sa_sz(struct roc_nix *roc_nix, bool inl_dev_sa)
 	if (roc_nix) {
 		nix = roc_nix_to_nix_priv(roc_nix);
 		if (!inl_dev_sa)
-			return nix->inb_sa_sz;
+			return nix->inb_sa_sz[nix->ipsec_prof_id];
 	}
 
 	if (inl_dev_sa) {
 		inl_dev = idev->nix_inl_dev;
 		if (inl_dev)
-			return inl_dev->inb_sa_sz;
+			return inl_dev->inb_sa_sz[inl_dev->ipsec_prof_id];
 	}
 
 	return 0;
@@ -1100,6 +1210,7 @@ nix_inl_legacy_inb_init(struct roc_nix *roc_nix)
 		return -ENOTSUP;
 	}
 
+	nix->ipsec_prof_id = 0;
 	memset(&cfg, 0, sizeof(cfg));
 	if (roc_model_is_cn9k()) {
 		cfg.param1 = (ROC_ONF_IPSEC_INB_MAX_L2_SZ >> 3) & 0xf;
@@ -1181,6 +1292,12 @@ nix_inl_inb_init(struct roc_nix *roc_nix)
 	if (rc)
 		return rc;
 
+	if (roc_nix->reass_ena) {
+		rc = nix_inl_reass_inb_sa_tbl_setup(roc_nix);
+		if (rc)
+			return rc;
+	}
+
 	if (roc_nix->local_meta_aura_ena || roc_nix->custom_meta_aura_ena) {
 		nix->need_meta_aura = true;
 
@@ -1238,6 +1355,9 @@ roc_nix_inl_inb_fini(struct roc_nix *roc_nix)
 	/* Flush Inbound CTX cache entries */
 	roc_nix_cpt_ctx_cache_sync(roc_nix);
 
+	if (roc_nix->reass_ena)
+		nix_inl_reass_sa_tbl_release(roc_nix);
+
 	/* Disable Inbound SA */
 	return nix_inl_ipsec_sa_tbl_release(roc_nix);
 }
@@ -1935,8 +2055,8 @@ roc_nix_inl_inb_tag_update(struct roc_nix *roc_nix, uint32_t tag_const,
 		return 0;
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.sa_size = nix->inb_sa_sz;
-	cfg.iova = (uintptr_t)nix->inb_sa_base;
+	cfg.sa_size = nix->inb_sa_sz[nix->ipsec_prof_id];
+	cfg.iova = (uintptr_t)nix->inb_sa_base[nix->ipsec_prof_id];
 	cfg.max_sa = nix->inb_spi_mask + 1;
 	cfg.tt = tt;
 	cfg.tag_const = tag_const;
@@ -2186,15 +2306,15 @@ roc_nix_inl_cpt_lf_stats_get(struct roc_nix *roc_nix, enum roc_nix_cpt_lf_stats_
 	}
 }
 
-int
-roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev)
+static int
+nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev, uint8_t profile_id)
 {
 	struct idev_cfg *idev = idev_get_cfg();
 	struct nix_inl_dev *inl_dev = NULL;
 	void *sa, *sa_base = NULL;
 	struct nix *nix = NULL;
-	uint16_t max_spi = 0;
 	uint32_t rq_refs = 0;
+	uint16_t max_sa = 0;
 	uint8_t pkind = 0;
 	size_t inb_sa_sz;
 	int i;
@@ -2202,7 +2322,7 @@ roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev)
 	if (roc_model_is_cn9k())
 		return 0;
 
-	if (!inb_inl_dev && (roc_nix == NULL))
+	if (!inb_inl_dev && (roc_nix == NULL) && profile_id >= ROC_NIX_INL_PROFILE_CNT)
 		return -EINVAL;
 
 	if (inb_inl_dev) {
@@ -2213,9 +2333,12 @@ roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev)
 		nix = roc_nix_to_nix_priv(roc_nix);
 		if (!nix->inl_inb_ena)
 			return 0;
-		sa_base = nix->inb_sa_base;
-		inb_sa_sz = nix->inb_sa_sz;
-		max_spi = roc_nix->ipsec_in_max_spi;
+
+		sa_base = nix->inb_sa_base[profile_id];
+		if (sa_base == NULL)
+			return 0;
+		inb_sa_sz = nix->inb_sa_sz[profile_id];
+		max_sa = nix->inb_sa_max[profile_id];
 	}
 
 	if (inl_dev) {
@@ -2223,10 +2346,12 @@ roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev)
 			rq_refs += inl_dev->rqs[i].inl_dev_refs;
 
 		if (rq_refs == 0) {
+			sa_base = inl_dev->inb_sa_base[profile_id];
+			if (sa_base == NULL)
+				return 0;
 			inl_dev->ts_ena = ts_ena;
-			max_spi = inl_dev->ipsec_in_max_spi;
-			sa_base = inl_dev->inb_sa_base;
-			inb_sa_sz = inl_dev->inb_sa_sz;
+			max_sa = inl_dev->inb_sa_max[profile_id];
+			inb_sa_sz = inl_dev->inb_sa_sz[profile_id];
 		} else if (inl_dev->ts_ena != ts_ena) {
 			if (inl_dev->ts_ena)
 				plt_err("Inline device is already configured with TS enable");
@@ -2244,13 +2369,32 @@ roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev)
 	if (pkind == ((struct roc_ot_ipsec_inb_sa *)sa)->w0.s.pkind)
 		return 0;
 
-	for (i = 0; i < max_spi; i++) {
+	for (i = 0; i < max_sa; i++) {
 		sa = ((uint8_t *)sa_base) + (i * inb_sa_sz);
 		((struct roc_ot_ipsec_inb_sa *)sa)->w0.s.pkind = pkind;
 	}
 	return 0;
 }
 
+int
+roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev, uint8_t profile_id)
+{
+	int cnt = 0;
+
+	if (profile_id < ROC_NIX_INL_PROFILE_CNT) {
+		return nix_inl_ts_pkind_set(roc_nix, ts_ena, inb_inl_dev, profile_id);
+	} else if (profile_id == 0xFF) {
+		/* Configure for all valid profiles */
+		for (cnt = 0; cnt < ROC_NIX_INL_PROFILE_CNT; cnt++)
+			if (nix_inl_ts_pkind_set(roc_nix, ts_ena, inb_inl_dev, cnt))
+				return -EINVAL;
+		return 0;
+	}
+
+	plt_err("Invalid NIX inline profile_id: %u", profile_id);
+	return -EINVAL;
+}
+
 void
 roc_nix_inl_dev_lock(void)
 {
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 37f156e7d8..12f36187cf 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -154,12 +154,10 @@ int __roc_api roc_nix_inl_dev_rq_get(struct roc_nix_rq *rq, bool ena);
 int __roc_api roc_nix_inl_dev_rq_put(struct roc_nix_rq *rq);
 bool __roc_api roc_nix_inb_is_with_inl_dev(struct roc_nix *roc_nix);
 struct roc_nix_rq *__roc_api roc_nix_inl_dev_rq(struct roc_nix *roc_nix);
-int __roc_api roc_nix_inl_inb_tag_update(struct roc_nix *roc_nix,
-					 uint32_t tag_const, uint8_t tt);
-int __roc_api roc_nix_reassembly_configure(uint32_t max_wait_time,
-					   uint16_t max_frags);
-int __roc_api roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena,
-				       bool inb_inl_dev);
+int __roc_api roc_nix_inl_inb_tag_update(struct roc_nix *roc_nix, uint32_t tag_const, uint8_t tt);
+int __roc_api roc_nix_reassembly_configure(uint32_t max_wait_time, uint16_t max_frags);
+int __roc_api roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev,
+				       uint8_t profile_id);
 int __roc_api roc_nix_inl_rq_ena_dis(struct roc_nix *roc_nix, bool ena);
 int __roc_api roc_nix_inl_meta_aura_check(struct roc_nix *roc_nix, struct roc_nix_rq *rq);
 
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 6216305db9..041ccd9c13 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -137,6 +137,33 @@ nix_inl_setup_dflt_ipsec_profile(struct dev *dev, uint16_t *prof_id)
 	return rc;
 }
 
+int
+nix_inl_setup_reass_profile(struct dev *dev, uint8_t *prof_id)
+{
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct nix_rx_inl_profile_cfg_req *req;
+	struct nix_rx_inl_profile_cfg_rsp *rsp;
+	int rc;
+
+	req = mbox_alloc_msg_nix_rx_inl_profile_cfg(mbox);
+	if (req == NULL) {
+		mbox_put(mbox);
+		return -ENOSPC;
+	}
+
+	req->def_cfg = NIX_INL_REASS_DEF_CFG;
+	req->gen_cfg = NIX_INL_REASS_GEN_CFG;
+
+	rc = mbox_process_msg(mbox, (void **)&rsp);
+	if (rc)
+		goto exit;
+
+	*prof_id = rsp->profile_id;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 static int
 nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
 {
@@ -307,11 +334,12 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 {
 	struct mbox *mbox = mbox_get((&inl_dev->dev)->mbox);
 	uint64_t max_sa, sa_w, sa_pow2_sz, lenm1_max;
+	uint8_t profile_id = inl_dev->ipsec_prof_id;
 	int rc;
 
 	max_sa = inl_dev->inb_spi_mask + 1;
 	sa_w = plt_log2_u32(max_sa);
-	sa_pow2_sz = plt_log2_u32(inl_dev->inb_sa_sz);
+	sa_pow2_sz = plt_log2_u32(inl_dev->inb_sa_sz[profile_id]);
 	/* CN9K SA size is different */
 	if (roc_model_is_cn9k())
 		lenm1_max = NIX_CN9K_MAX_HW_FRS - 1;
@@ -329,7 +357,7 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 
 		if (ena) {
 			lf_cfg->enable = 1;
-			lf_cfg->sa_base_addr = (uintptr_t)inl_dev->inb_sa_base;
+			lf_cfg->sa_base_addr = (uintptr_t)inl_dev->inb_sa_base[profile_id];
 			lf_cfg->ipsec_cfg1.sa_idx_w = sa_w;
 			lf_cfg->ipsec_cfg0.lenm1_max = lenm1_max;
 			lf_cfg->ipsec_cfg1.sa_idx_max = max_sa - 1;
@@ -356,17 +384,16 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 		else
 			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
 
+		lf_cfg->profile_id = inl_dev->ipsec_prof_id;
 		if (ena) {
 			lf_cfg->enable = 1;
-			lf_cfg->profile_id = inl_dev->ipsec_prof_id;
-			lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base;
-			lf_cfg->rx_inline_cfg0 = ((def_cptq << 57) |
-						  ((uint64_t)SSO_TT_ORDERED << 44) |
-						  (sa_pow2_sz << 16) | lenm1_max);
+			lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base[profile_id];
+			lf_cfg->rx_inline_cfg0 =
+				((def_cptq << 57) | ((uint64_t)SSO_TT_ORDERED << 44) |
+				 (sa_pow2_sz << 16) | lenm1_max);
 			lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_w << 32);
 		} else {
 			lf_cfg->enable = 0;
-			lf_cfg->profile_id = inl_dev->ipsec_prof_id;
 		}
 	}
 
@@ -572,6 +599,134 @@ nix_inl_sso_release(struct nix_inl_dev *inl_dev)
 	return 0;
 }
 
+static int
+nix_inl_nix_profile_config(struct nix_inl_dev *inl_dev, uint8_t profile_id)
+{
+	struct mbox *mbox = mbox_get((&inl_dev->dev)->mbox);
+	uint64_t max_sa, sa_w, sa_pow2_sz, lenm1_max;
+	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	uint64_t def_cptq;
+	size_t inb_sa_sz;
+	void *sa;
+	int rc;
+
+	/* Alloc contiguous memory for Inbound SA's */
+	inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
+	max_sa = inl_dev->inb_sa_max[profile_id];
+	inl_dev->inb_sa_sz[profile_id] = inb_sa_sz;
+	inl_dev->inb_sa_base[profile_id] =
+		plt_zmalloc(inb_sa_sz * max_sa, ROC_NIX_INL_SA_BASE_ALIGN);
+	if (!inl_dev->inb_sa_base[profile_id]) {
+		plt_err("Failed to allocate memory for Inbound SA for profile %u", profile_id);
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	sa = ((uint8_t *)inl_dev->inb_sa_base[profile_id]);
+	roc_ow_reass_inb_sa_init(sa);
+	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+	if (lf_cfg == NULL) {
+		rc = -ENOSPC;
+		goto free_mem;
+	}
+
+	lenm1_max = NIX_RPM_MAX_HW_FRS - 1;
+	sa_w = plt_log2_u32(max_sa);
+	sa_pow2_sz = plt_log2_u32(inb_sa_sz);
+
+	/*TODO default cptq, Assuming Reassembly cpt lf ID at inl_dev->inb_cpt_lf_id + 1 */
+	if (!inl_dev->nb_inb_cptlfs)
+		def_cptq = 0;
+	else
+		def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id + 1];
+
+	lf_cfg->enable = 1;
+	lf_cfg->profile_id = profile_id;
+	lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base[profile_id];
+	lf_cfg->rx_inline_cfg0 = ((def_cptq << 57) | ((uint64_t)SSO_TT_ORDERED << 44) |
+				  (sa_pow2_sz << 16) | lenm1_max);
+	lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_w << 32);
+
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to setup NIX Inbound SA conf of profile=%u, rc=%d", profile_id, rc);
+		goto free_mem;
+	}
+
+	mbox_put(mbox);
+	return 0;
+
+free_mem:
+	plt_free(inl_dev->inb_sa_base[profile_id]);
+	inl_dev->inb_sa_base[profile_id] = NULL;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+static int
+nix_inl_nix_profile_release(struct nix_inl_dev *inl_dev, uint8_t profile_id)
+{
+	struct mbox *mbox = mbox_get((&inl_dev->dev)->mbox);
+	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	int rc;
+
+	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+	if (!lf_cfg) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	lf_cfg->enable = 0;
+	lf_cfg->profile_id = profile_id;
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to cleanup NIX Inbound profile=%u SA conf, rc=%d", profile_id, rc);
+		goto exit;
+	}
+
+	plt_free(inl_dev->inb_sa_base[profile_id]);
+	inl_dev->inb_sa_base[profile_id] = NULL;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+static int
+nix_inl_nix_reass_setup(struct nix_inl_dev *inl_dev)
+{
+	int rc;
+
+	if (!inl_dev->reass_ena)
+		return 0;
+
+	rc = nix_inl_setup_reass_profile(&inl_dev->dev, &inl_dev->reass_prof_id);
+	if (rc) {
+		plt_err("Failed to setup reassembly profile, rc=%d", rc);
+		return rc;
+	}
+
+	inl_dev->inb_sa_max[inl_dev->reass_prof_id] = 1;
+	return nix_inl_nix_profile_config(inl_dev, inl_dev->reass_prof_id);
+}
+
+static int
+nix_inl_nix_reass_cleanup(struct nix_inl_dev *inl_dev)
+{
+	int rc;
+
+	if (!inl_dev->reass_ena)
+		return 0;
+
+	rc = nix_inl_nix_profile_release(inl_dev, inl_dev->reass_prof_id);
+	if (rc) {
+		plt_err("Failed to cleanup reassembly profile, rc=%d", rc);
+		return rc;
+	}
+
+	return rc;
+}
+
 static int
 nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 {
@@ -584,6 +739,7 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 	struct nix_hw_info *hw_info;
 	struct roc_nix_rq *rqs;
 	uint64_t max_sa, i;
+	uint8_t profile_id;
 	size_t inb_sa_sz;
 	int rc = -ENOSPC;
 	void *sa;
@@ -595,6 +751,7 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 			return rc;
 	}
 
+	profile_id = inl_dev->ipsec_prof_id;
 	max_sa = plt_align32pow2(ipsec_in_max_spi - ipsec_in_min_spi + 1);
 
 	/* Alloc NIX LF needed for single RQ */
@@ -664,11 +821,12 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 		inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
 
 	/* Alloc contiguous memory for Inbound SA's */
-	inl_dev->inb_sa_sz = inb_sa_sz;
+	inl_dev->inb_sa_sz[profile_id] = inb_sa_sz;
+	inl_dev->inb_sa_max[profile_id] = max_sa;
 	inl_dev->inb_spi_mask = max_sa - 1;
-	inl_dev->inb_sa_base = plt_zmalloc(inb_sa_sz * max_sa,
-					   ROC_NIX_INL_SA_BASE_ALIGN);
-	if (!inl_dev->inb_sa_base) {
+	inl_dev->inb_sa_base[profile_id] =
+		plt_zmalloc(inb_sa_sz * max_sa, ROC_NIX_INL_SA_BASE_ALIGN);
+	if (!inl_dev->inb_sa_base[profile_id]) {
 		plt_err("Failed to allocate memory for Inbound SA");
 		rc = -ENOMEM;
 		goto unregister_irqs;
@@ -676,7 +834,7 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 
 	if (!roc_model_is_cn9k()) {
 		for (i = 0; i < max_sa; i++) {
-			sa = ((uint8_t *)inl_dev->inb_sa_base) + (i * inb_sa_sz);
+			sa = ((uint8_t *)inl_dev->inb_sa_base[profile_id]) + (i * inb_sa_sz);
 			if (roc_model_is_cn10k())
 				roc_ot_ipsec_inb_sa_init(sa);
 			else
@@ -694,8 +852,8 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 
 	return 0;
 free_mem:
-	plt_free(inl_dev->inb_sa_base);
-	inl_dev->inb_sa_base = NULL;
+	plt_free(inl_dev->inb_sa_base[profile_id]);
+	inl_dev->inb_sa_base[profile_id] = NULL;
 unregister_irqs:
 	nix_inl_nix_unregister_irqs(inl_dev);
 lf_free:
@@ -719,6 +877,9 @@ nix_inl_nix_release(struct nix_inl_dev *inl_dev)
 	if (rc)
 		plt_err("Failed to disable Inbound IPSec, rc=%d", rc);
 
+	/* Cleanup reassembly profile */
+	rc = nix_inl_nix_reass_cleanup(inl_dev);
+
 	/* Sync NDC-NIX for LF */
 	ndc_req = mbox_alloc_msg_ndc_sync_op(mbox_get(mbox));
 	if (ndc_req == NULL) {
@@ -749,9 +910,9 @@ nix_inl_nix_release(struct nix_inl_dev *inl_dev)
 	mbox_put(mbox);
 
 	plt_free(inl_dev->rqs);
-	plt_free(inl_dev->inb_sa_base);
+	plt_free(inl_dev->inb_sa_base[inl_dev->ipsec_prof_id]);
 	inl_dev->rqs = NULL;
-	inl_dev->inb_sa_base = NULL;
+	inl_dev->inb_sa_base[inl_dev->ipsec_prof_id] = NULL;
 	return 0;
 }
 
@@ -1181,6 +1342,7 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	inl_dev->custom_inb_sa = roc_inl_dev->custom_inb_sa;
 	inl_dev->nix_inb_q_bpid = -1;
 	inl_dev->nb_cptlf = 1;
+	inl_dev->ipsec_prof_id = 0;
 
 	if (roc_model_is_cn9k() || roc_model_is_cn10k())
 		inl_dev->eng_grpmask = (1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE |
@@ -1245,6 +1407,15 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 		goto cpt_release;
 	}
 
+	/* Setup Reassembly */
+	if (roc_feature_nix_has_plain_pkt_reassembly()) {
+		inl_dev->reass_ena = 1;
+
+		rc = nix_inl_nix_reass_setup(inl_dev);
+		if (rc)
+			goto cpt_release;
+	}
+
 	if (inl_dev->set_soft_exp_poll) {
 		rc = nix_inl_outb_poll_thread_setup(inl_dev);
 		if (rc)
diff --git a/drivers/common/cnxk/roc_nix_inl_priv.h b/drivers/common/cnxk/roc_nix_inl_priv.h
index b1830f2449..8b3bd43547 100644
--- a/drivers/common/cnxk/roc_nix_inl_priv.h
+++ b/drivers/common/cnxk/roc_nix_inl_priv.h
@@ -6,8 +6,9 @@
 #include <pthread.h>
 #include <sys/types.h>
 
-#define NIX_INL_META_SIZE 384u
+#define NIX_INL_META_SIZE      384u
 #define MAX_NIX_INL_DEV_CPT_LF 18
+#define NIX_INL_PROFILE_CNT    8
 
 struct nix_inl_dev;
 struct nix_inl_qint {
@@ -58,11 +59,13 @@ struct nix_inl_dev {
 	bool is_nix1;
 	uint8_t spb_drop_pc;
 	uint8_t lpb_drop_pc;
+	uint8_t reass_ena; /* Plain packet reassembly enable */
 	uint64_t sso_work_cnt;
 
 	/* NIX/CPT data */
-	void *inb_sa_base;
-	uint16_t inb_sa_sz;
+	void *inb_sa_base[NIX_INL_PROFILE_CNT];
+	uint16_t inb_sa_sz[NIX_INL_PROFILE_CNT];
+	uint32_t inb_sa_max[NIX_INL_PROFILE_CNT];
 	uint8_t nb_cptlf;
 
 	/* CPT data */
@@ -111,6 +114,7 @@ struct nix_inl_dev {
 	uint16_t nb_inb_cptlfs;
 	int nix_inb_q_bpid;
 	uint16_t ipsec_prof_id;
+	uint8_t reass_prof_id;
 };
 
 #define NIX_INL_DFLT_IPSEC_DEF_CFG                                                                 \
@@ -123,6 +127,14 @@ struct nix_inl_dev {
 	 ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_IPSEC << 32 | ROC_IE_OW_INPLACE_BIT << 32 |            \
 	 BIT_ULL(18))
 
+#define NIX_INL_REASS_DEF_CFG                                                                      \
+	(BIT_ULL(30) | BIT_ULL(29) | BIT_ULL(28) | NPC_LID_LC << 8 |                               \
+	 (NPC_LT_LC_IP | NPC_LT_LC_IP6) << 4 | 0xFul)
+
+#define NIX_INL_REASS_GEN_CFG                                                                      \
+	(BIT_ULL(51) | (ROC_CPT_DFLT_ENG_GRP_SE << 48) |                                           \
+	 (ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_REASS << 32))
+
 int nix_inl_sso_register_irqs(struct nix_inl_dev *inl_dev);
 void nix_inl_sso_unregister_irqs(struct nix_inl_dev *inl_dev);
 
@@ -132,5 +144,6 @@ void nix_inl_nix_unregister_irqs(struct nix_inl_dev *inl_dev);
 uint16_t nix_inl_dev_pffunc_get(void);
 
 int nix_inl_setup_dflt_ipsec_profile(struct dev *dev, uint16_t *prof_id);
+int nix_inl_setup_reass_profile(struct dev *dev, uint8_t *prof_id);
 
 #endif /* _ROC_NIX_INL_PRIV_H_ */
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index d0a53ca998..09a55e43ce 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -55,6 +55,8 @@ struct nix_qint {
 #define NIX_TM_MARK_IPV4_ECN_SHIFT  32
 #define NIX_TM_MARK_IPV6_ECN_SHIFT  40
 
+#define ROC_NIX_INL_PROFILE_CNT 8
+
 struct nix_tm_tb {
 	/** Token bucket rate (bytes per second) */
 	uint64_t rate;
@@ -200,9 +202,12 @@ struct nix {
 	uint16_t cpt_msixoff[MAX_RVU_BLKLF_CNT];
 	bool inl_inb_ena;
 	bool inl_outb_ena;
-	void *inb_sa_base;
-	size_t inb_sa_sz;
+	void *inb_sa_base[ROC_NIX_INL_PROFILE_CNT];
+	size_t inb_sa_sz[ROC_NIX_INL_PROFILE_CNT];
+	uint32_t inb_sa_max[ROC_NIX_INL_PROFILE_CNT];
+	uint32_t ipsec_in_max_spi;
 	uint16_t ipsec_prof_id;
+	uint8_t reass_prof_id;
 	uint64_t rx_inline_cfg0;
 	uint64_t rx_inline_cfg1;
 	uint32_t inb_spi_mask;
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index 6a3c28e8a9..36eb46e3a1 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -503,6 +503,7 @@ INTERNAL {
 	roc_ot_ipsec_outb_sa_init;
 	roc_ow_ipsec_inb_sa_init;
 	roc_ow_ipsec_outb_sa_init;
+	roc_ow_reass_inb_sa_init;
 	roc_plt_control_lmt_id_get;
 	roc_plt_init;
 	roc_plt_init_cb_register;
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC5FC021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:41:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97D0F40BA6;
	Mon, 24 Feb 2025 10:40:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C719940BA5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:40:14 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51gA6002354
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
 vFX6nM3sd0y/WwxrgpxYjuN/4FeVt8wEsacc3rKSGo=; b=L5jwmlbMa9iyqR845
 sYkRhorxwe9e+MEWCfUZetk2vyskWU2OTyc1C6bUqQvgTtZw1NDjLfo4ym712PlN
 fZZZJawZ3L/uyx0XLrXH0osY5ENLNPzEDvyZ3YFWXXyvuAE7pRxcSrjTgh2JbRoE
 3mxw8c7XTE4pVQaxIsUijLM0hPRmyoL+36wH3FMQjdLa3rQCSPFkvGm3GIFB+e/o
 lR17ML3YoBpK15o3DYvQzBnhpro0lwvsjnR8oE1eG/EGwt1A+9t0HdqrXQW9TclF
 XbHXmvLM0Ly8ycRL1ZuNU5fIkUT+RVKmd4rLjuMFoXVagO9qStY+cNIyUnmnPyoH
 UczMw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jg5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:13 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:13 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id AC61F3F7068;
 Mon, 24 Feb 2025 01:40:10 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 17/33] common/cnxk: add mbox define for inline profile
 support
Date: Mon, 24 Feb 2025 15:08:59 +0530
Message-ID: <20250224093915.1253215-17-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OBDyAQjshOD8NKl-orpsaM6jAb4yEufH
X-Proofpoint-ORIG-GUID: OBDyAQjshOD8NKl-orpsaM6jAb4yEufH
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

Add mbox support for global inline profile allocation.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_mbox.h    | 45 ++++++++++++++++++++++++++
 drivers/common/cnxk/roc_nix_inl.c | 53 +++++++++++++++++++++++--------
 2 files changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index f3024057b5..beb7fb6e62 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -336,6 +336,13 @@ struct mbox_msghdr {
 	  nix_mcast_grp_update_rsp)                                                                \
 	M(NIX_GET_LF_STATS,    0x802e, nix_get_lf_stats, nix_get_lf_stats_req, nix_lf_stats_rsp)   \
 	M(NIX_CN20K_AQ_ENQ, 0x802f, nix_cn20k_aq_enq, nix_cn20k_aq_enq_req, nix_cn20k_aq_enq_rsp)  \
+	M(NIX_LSO_ALT_FLAGS_CFG, 0x8030, nix_lso_alt_flags_cfg, nix_lso_alt_flags_cfg_req, \
+				nix_lso_alt_flags_cfg_rsp)			\
+	M(NIX_RX_INLINE_PROFILE_CFG, 0x8031, nix_rx_inl_profile_cfg,			\
+				nix_rx_inl_profile_cfg_req,			\
+				nix_rx_inl_profile_cfg_rsp)			\
+	M(NIX_RX_INLINE_LF_CFG, 0x8032, nix_rx_inl_lf_cfg, nix_rx_inl_lf_cfg_req,	\
+				msg_rsp)					\
 	/* MCS mbox IDs (range 0xa000 - 0xbFFF) */                                                 \
 	M(MCS_ALLOC_RESOURCES, 0xa000, mcs_alloc_resources, mcs_alloc_rsrc_req,                    \
 	  mcs_alloc_rsrc_rsp)                                                                      \
@@ -2008,6 +2015,32 @@ struct nix_inline_ipsec_cfg {
 	uint32_t __io credit_th;
 };
 
+#define NIX_RX_INL_PROFILE_PROTO_CNT 9
+struct nix_rx_inl_profile_cfg_req {
+	struct mbox_msghdr hdr;
+	uint64_t __io def_cfg;
+	uint64_t __io extract_cfg;
+	uint64_t __io gen_cfg;
+	uint64_t __io prot_field_cfg[NIX_RX_INL_PROFILE_PROTO_CNT];
+	uint64_t __io rsvd[32];		/* reserved fields for future expansion */
+};
+
+struct nix_rx_inl_profile_cfg_rsp {
+	struct mbox_msghdr hdr;
+	uint8_t __io profile_id;
+	uint8_t __io rsvd[32];		/* reserved fields for future expansion */
+};
+
+struct nix_rx_inl_lf_cfg_req {
+	struct mbox_msghdr hdr;
+	uint64_t __io rx_inline_cfg0;
+	uint64_t __io rx_inline_cfg1;
+	uint64_t __io rx_inline_sa_base;
+	uint8_t __io enable;
+	uint8_t __io profile_id;
+	uint8_t __io rsvd[32];		/* reserved fields for future expansion */
+};
+
 /* Per NIX LF inline IPSec configuration */
 struct nix_inline_ipsec_lf_cfg {
 	struct mbox_msghdr hdr;
@@ -2064,6 +2097,17 @@ struct nix_bandprof_get_hwinfo_rsp {
 	uint32_t __io policer_timeunit;
 };
 
+struct nix_lso_alt_flags_cfg_req {
+	struct mbox_msghdr hdr;
+	uint64_t __io cfg;
+	uint64_t __io cfg1;
+};
+
+struct nix_lso_alt_flags_cfg_rsp {
+	struct mbox_msghdr hdr;
+	uint8_t __io lso_alt_flags_idx;
+};
+
 /* SSO mailbox error codes
  * Range 501 - 600.
  */
@@ -3090,6 +3134,7 @@ struct nix_spi_to_sa_add_req {
 	uint32_t __io spi_index;
 	uint16_t __io match_id;
 	bool __io valid;
+	uint8_t __io inline_profile_id;
 };
 
 struct nix_spi_to_sa_add_rsp {
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 991a81b50d..37e1bfc0ed 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -395,7 +395,8 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	uint32_t ipsec_in_min_spi = roc_nix->ipsec_in_min_spi;
 	uint32_t ipsec_in_max_spi = roc_nix->ipsec_in_max_spi;
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
-	struct roc_nix_ipsec_cfg cfg;
+	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	struct nix_inline_ipsec_lf_cfg *lf_cfg;
 	uint64_t max_sa, i;
 	size_t inb_sa_sz;
 	void *sa;
@@ -419,8 +420,9 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	nix->inb_sa_base = plt_zmalloc(inb_sa_sz * max_sa,
 				       ROC_NIX_INL_SA_BASE_ALIGN);
 	if (!nix->inb_sa_base) {
+		rc = -ENOMEM;
 		plt_err("Failed to allocate memory for Inbound SA");
-		return -ENOMEM;
+		goto exit;
 	}
 
 	if (!roc_model_is_cn9k()) {
@@ -433,23 +435,36 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		}
 	}
 
-	memset(&cfg, 0, sizeof(cfg));
-	cfg.sa_size = inb_sa_sz;
-	cfg.iova = (uintptr_t)nix->inb_sa_base;
-	cfg.max_sa = max_sa;
-	cfg.tt = SSO_TT_ORDERED;
-
 	/* Setup device specific inb SA table */
-	rc = roc_nix_lf_inl_ipsec_cfg(roc_nix, &cfg, true);
+	lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
+	if (lf_cfg == NULL) {
+		rc = -ENOSPC;
+		plt_err("Failed to alloc nix inline ipsec lf cfg mbox msg");
+		goto free_mem;
+	}
+
+	lf_cfg->enable = 1;
+	lf_cfg->sa_base_addr = (uintptr_t)nix->inb_sa_base;
+	lf_cfg->ipsec_cfg1.sa_idx_w = plt_log2_u32(max_sa);
+	lf_cfg->ipsec_cfg0.lenm1_max = roc_nix_max_pkt_len(roc_nix) - 1;
+	lf_cfg->ipsec_cfg1.sa_idx_max = max_sa - 1;
+	lf_cfg->ipsec_cfg0.sa_pow2_size = plt_log2_u32(inb_sa_sz);
+	lf_cfg->ipsec_cfg0.tag_const = 0;
+	lf_cfg->ipsec_cfg0.tt = SSO_TT_ORDERED;
+
+	rc = mbox_process(mbox);
 	if (rc) {
 		plt_err("Failed to setup NIX Inbound SA conf, rc=%d", rc);
 		goto free_mem;
 	}
 
+	mbox_put(mbox);
 	return 0;
 free_mem:
 	plt_free(nix->inb_sa_base);
 	nix->inb_sa_base = NULL;
+exit:
+	mbox_put(mbox);
 	return rc;
 }
 
@@ -457,17 +472,29 @@ static int
 nix_inl_sa_tbl_release(struct roc_nix *roc_nix)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	struct nix_inline_ipsec_lf_cfg *lf_cfg;
 	int rc;
 
-	rc = roc_nix_lf_inl_ipsec_cfg(roc_nix, NULL, false);
+	lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
+	if (lf_cfg == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	lf_cfg->enable = 0;
+
+	rc = mbox_process(mbox);
 	if (rc) {
-		plt_err("Failed to disable Inbound inline ipsec, rc=%d", rc);
-		return rc;
+		plt_err("Failed to cleanup NIX Inbound SA conf, rc=%d", rc);
+		goto exit;
 	}
 
 	plt_free(nix->inb_sa_base);
 	nix->inb_sa_base = NULL;
-	return 0;
+exit:
+	mbox_put(mbox);
+	return rc;
 }
 
 struct roc_cpt_lf *
-- 
2.34.1


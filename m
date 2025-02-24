Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E52C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:56:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DC9A40E22;
	Mon, 24 Feb 2025 10:55:10 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4E8FB40E35
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:54:54 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKd001315
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 cnM27uB+UdXzFQK60X8jDuHVQJw4nkYbpffaUA32u8=; b=Ta7b1DmK/m2y2bPo1
 bxdrQWqs0pktbwfjM1lpYf6fkanCQU+L5gZhKVjr/2QASsmMXwNQTanMwkYJTSdc
 ur8PQ4ro1PLGMqCBJPqcq3kSXnXf0mx6Qko1utZBuu6gUterpSVElEjavJgEakTB
 Dwx/8ZqolsfYeN1vsSYnHVxcvCQs7MQNUDR2nSo5Ew1m1tSR6yOvq8T4frhs1dX0
 ejT0hi9Vh/vN5lvAdyCqCuK1NrrGFHd6JkH8nnaeoRYdRnJDv1gMVDctAJWGz5Bo
 fqmb1hvc7V7sLUNL6I693h5TFK7UT+MREsHxXcTH/Zy1kcvunxanAxC/aOgkYSwm
 QTC8A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh3c-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:53 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:54:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:54:00 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id ED9BB3F706D;
 Mon, 24 Feb 2025 01:53:57 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3 18/33] common/cnxk: support for inline inbound queue
Date: Mon, 24 Feb 2025 15:22:26 +0530
Message-ID: <20250224095241.1263700-18-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Xp66yx40wNOrOnW8oIF_mOJ-TVsQ7CfF
X-Proofpoint-ORIG-GUID: Xp66yx40wNOrOnW8oIF_mOJ-TVsQ7CfF
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

In CN20k, since we have 16 Inline inbound queues possible, add
support to attach inline inbound queue directly to the application
instead of getting it attached to CPT PF.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_features.h     |  12 +
 drivers/common/cnxk/roc_mbox.h         |  82 ++++++
 drivers/common/cnxk/roc_nix.h          |   1 +
 drivers/common/cnxk/roc_nix_fc.c       |  24 +-
 drivers/common/cnxk/roc_nix_inl.c      | 281 ++++++++++++++++----
 drivers/common/cnxk/roc_nix_inl.h      |   6 +-
 drivers/common/cnxk/roc_nix_inl_dev.c  | 347 +++++++++++++++++++++----
 drivers/common/cnxk/roc_nix_inl_priv.h |  28 +-
 drivers/common/cnxk/roc_nix_priv.h     |   6 +
 drivers/common/cnxk/roc_platform.h     |   1 +
 drivers/net/cnxk/cnxk_ethdev.h         |   2 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c     |   9 +-
 12 files changed, 686 insertions(+), 113 deletions(-)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 59c09fbc85..49a563ef95 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -102,4 +102,16 @@ roc_feature_dpi_has_priority(void)
 	return roc_model_is_cn10k();
 }
 
+static inline bool
+roc_feature_nix_has_inl_multi_queue(void)
+{
+	return roc_model_is_cn20k();
+}
+
+static inline bool
+roc_feature_nix_has_inl_profile(void)
+{
+	return roc_model_is_cn20k();
+}
+
 #endif
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index beb7fb6e62..fbea15690b 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -183,11 +183,19 @@ struct mbox_msghdr {
 	  msg_rsp)                                                             \
 	M(CPT_CTX_CACHE_SYNC, 0xA07, cpt_ctx_cache_sync, msg_req, msg_rsp)     \
 	M(CPT_LF_RESET, 0xA08, cpt_lf_reset, cpt_lf_rst_req, msg_rsp)          \
+	M(CPT_FLT_ENG_INFO, 0xA09, cpt_flt_eng_info, cpt_flt_eng_info_req,	\
+				   cpt_flt_eng_info_rsp)			\
+	M(CPT_RX_INLINE_QALLOC, 0xA0A, cpt_rx_inline_qalloc, msg_req,		\
+				       cpt_rx_inline_qalloc_rsp)		\
+	M(CPT_RX_INL_QUEUE_CFG, 0xA0B, cpt_rx_inl_queue_cfg,			\
+				       cpt_rx_inline_qcfg_req, msg_rsp)        \
 	M(CPT_RX_INLINE_LF_CFG, 0xBFE, cpt_rx_inline_lf_cfg,                   \
 	  cpt_rx_inline_lf_cfg_msg, msg_rsp)                                   \
 	M(CPT_GET_CAPS, 0xBFD, cpt_caps_get, msg_req, cpt_caps_rsp_msg)        \
 	M(CPT_GET_ENG_GRP, 0xBFF, cpt_eng_grp_get, cpt_eng_grp_req,            \
 	  cpt_eng_grp_rsp)                                                     \
+	M(CPT_SET_QUEUE_PRI, 0xBFB, cpt_set_que_pri, cpt_queue_pri_req_msg,	\
+			       msg_rsp)					\
 	/* REE mbox IDs (range 0xE00 - 0xFFF) */                               \
 	M(REE_CONFIG_LF, 0xE01, ree_config_lf, ree_lf_req_msg, msg_rsp)        \
 	M(REE_RD_WR_REGISTER, 0xE02, ree_rd_wr_register, ree_rd_wr_reg_msg,    \
@@ -343,6 +351,8 @@ struct mbox_msghdr {
 				nix_rx_inl_profile_cfg_rsp)			\
 	M(NIX_RX_INLINE_LF_CFG, 0x8032, nix_rx_inl_lf_cfg, nix_rx_inl_lf_cfg_req,	\
 				msg_rsp)					\
+	M(NIX_RX_INL_QUEUE_CFG,	0x8033, nix_rx_inl_queue_cfg,				\
+			      nix_rx_inline_qcfg_req, msg_rsp)		\
 	/* MCS mbox IDs (range 0xa000 - 0xbFFF) */                                                 \
 	M(MCS_ALLOC_RESOURCES, 0xa000, mcs_alloc_resources, mcs_alloc_rsrc_req,                    \
 	  mcs_alloc_rsrc_rsp)                                                                      \
@@ -1966,6 +1976,34 @@ struct nix_mcast_grp_update_rsp {
 	uint32_t __io mce_start_index;
 };
 
+#define IPSEC_GEN_CFG_EGRP   GENMASK_ULL(50, 48)
+#define IPSEC_GEN_CFG_OPCODE GENMASK_ULL(47, 32)
+#define IPSEC_GEN_CFG_PARAM1 GENMASK_ULL(31, 16)
+#define IPSEC_GEN_CFG_PARAM2 GENMASK_ULL(15, 0)
+
+#define CPT_INST_QSEL_BLOCK   GENMASK_ULL(28, 24)
+#define CPT_INST_QSEL_PF_FUNC GENMASK_ULL(23, 8)
+#define CPT_INST_QSEL_SLOT    GENMASK_ULL(7, 0)
+
+#define CPT_INST_CREDIT_HYST GENMASK_ULL(61, 56)
+#define CPT_INST_CREDIT_TH   GENMASK_ULL(53, 32)
+#define CPT_INST_CREDIT_BPID GENMASK_ULL(30, 22)
+#define CPT_INST_CREDIT_CNT  GENMASK_ULL(21, 0)
+
+/* Per queue NIX inline IPSec configuration */
+struct nix_rx_inline_qcfg_req {
+	struct mbox_msghdr hdr;
+	uint32_t __io cpt_credit;
+	uint32_t __io credit_th;
+	uint16_t __io cpt_pf_func;
+	uint16_t __io bpid;
+	uint8_t __io cpt_slot;
+	uint8_t __io rx_queue_id;
+	uint8_t __io enable;
+	uint8_t __io hysteresis;
+	uint8_t __io rsvd[32];
+};
+
 struct nix_get_lf_stats_req {
 	struct mbox_msghdr hdr;
 	uint16_t __io pcifunc;
@@ -2335,6 +2373,34 @@ struct cpt_lf_alloc_req_msg {
 	uint8_t __io rxc_ena_lf_id : 7;
 };
 
+struct cpt_rx_inline_qalloc_rsp {
+	struct mbox_msghdr hdr;
+	uint8_t __io rx_queue_id;
+	uint64_t __io rsvd[8]; /* For future extensions */
+};
+
+struct cpt_queue_pri_req_msg {
+	struct mbox_msghdr hdr;
+	uint32_t __io slot;
+	uint8_t __io queue_pri;
+};
+
+struct cpt_rx_inline_qcfg_req {
+	struct mbox_msghdr hdr;
+	uint16_t __io sso_pf_func; /* inbound path SSO_PF_FUNC */
+	uint16_t __io nix_pf_func; /* outbound path NIX_PF_FUNC */
+	uint16_t __io ctx_pf_func;
+	uint8_t __io eng_grpmsk;
+	uint8_t __io enable;
+	uint8_t __io slot;
+	uint8_t __io rx_queue_id;
+	uint8_t __io ctx_ilen;
+	uint8_t __io pf_func_ctx;
+	uint8_t __io inflight_limit;
+	uint8_t __io queue_pri;
+	uint8_t __io rsvd[32]; /* For future extensions */
+};
+
 #define CPT_INLINE_INBOUND  0
 #define CPT_INLINE_OUTBOUND 1
 
@@ -2404,6 +2470,22 @@ struct cpt_rxc_time_cfg_req {
 	uint16_t __io active_limit;
 };
 
+/* Mailbox message format to request for CPT faulted engines */
+struct cpt_flt_eng_info_req {
+	struct mbox_msghdr hdr;
+	int __io blkaddr;
+	bool __io reset;
+	uint32_t __io rsvd;
+};
+
+struct cpt_flt_eng_info_rsp {
+	struct mbox_msghdr hdr;
+#define CPT_AF_MAX_FLT_INT_VECS 3
+	uint64_t __io flt_eng_map[CPT_AF_MAX_FLT_INT_VECS];
+	uint64_t __io rcvrd_eng_map[CPT_AF_MAX_FLT_INT_VECS];
+	uint64_t __io rsvd;
+};
+
 struct cpt_rx_inline_lf_cfg_msg {
 	struct mbox_msghdr hdr;
 	uint16_t __io sso_pf_func;
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 2597b8d56b..a66391449f 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -243,6 +243,7 @@ struct roc_nix_eeprom_info {
 #define ROC_NIX_LF_RX_CFG_LEN_IL3     BIT_ULL(39)
 #define ROC_NIX_LF_RX_CFG_LEN_OL4     BIT_ULL(40)
 #define ROC_NIX_LF_RX_CFG_LEN_OL3     BIT_ULL(41)
+#define ROC_NIX_LF_RX_CFG_APAD_MODE   BIT_ULL(42)
 
 #define ROC_NIX_LF_RX_CFG_RX_ERROR_MASK 0xFFFFFFFFFFF80000
 #define ROC_NIX_RE_PARTIAL		BIT_ULL(1)
diff --git a/drivers/common/cnxk/roc_nix_fc.c b/drivers/common/cnxk/roc_nix_fc.c
index 0676363c58..3e162ede8e 100644
--- a/drivers/common/cnxk/roc_nix_fc.c
+++ b/drivers/common/cnxk/roc_nix_fc.c
@@ -702,10 +702,9 @@ roc_nix_chan_count_get(struct roc_nix *roc_nix)
  *	-ve value on error
  */
 int
-roc_nix_bpids_alloc(struct roc_nix *roc_nix, uint8_t type, uint8_t bp_cnt, uint16_t *bpids)
+nix_bpids_alloc(struct dev *dev, uint8_t type, uint8_t bp_cnt, uint16_t *bpids)
 {
-	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
-	struct mbox *mbox = mbox_get(nix->dev.mbox);
+	struct mbox *mbox = mbox_get(dev->mbox);
 	struct nix_alloc_bpid_req *req;
 	struct nix_bpids *rsp;
 	int rc = -EINVAL;
@@ -733,10 +732,9 @@ roc_nix_bpids_alloc(struct roc_nix *roc_nix, uint8_t type, uint8_t bp_cnt, uint1
 }
 
 int
-roc_nix_bpids_free(struct roc_nix *roc_nix, uint8_t bp_cnt, uint16_t *bpids)
+nix_bpids_free(struct dev *dev, uint8_t bp_cnt, uint16_t *bpids)
 {
-	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
-	struct mbox *mbox = mbox_get(nix->dev.mbox);
+	struct mbox *mbox = mbox_get(dev->mbox);
 	struct nix_bpids *req;
 	int rc = -EINVAL;
 
@@ -758,6 +756,20 @@ roc_nix_bpids_free(struct roc_nix *roc_nix, uint8_t bp_cnt, uint16_t *bpids)
 	return rc;
 }
 
+int
+roc_nix_bpids_alloc(struct roc_nix *roc_nix, uint8_t type, uint8_t bp_cnt, uint16_t *bpids)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	return nix_bpids_alloc(&nix->dev, type, bp_cnt, bpids);
+}
+
+int
+roc_nix_bpids_free(struct roc_nix *roc_nix, uint8_t bp_cnt, uint16_t *bpids)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	return nix_bpids_free(&nix->dev, bp_cnt, bpids);
+}
+
 int
 roc_nix_rx_chan_cfg_get(struct roc_nix *roc_nix, uint16_t chan, bool is_cpt, uint64_t *cfg)
 {
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 37e1bfc0ed..127f834ee5 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -390,18 +390,28 @@ roc_nix_inl_meta_aura_check(struct roc_nix *roc_nix, struct roc_nix_rq *rq)
 }
 
 static int
-nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
+nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_nix)
 {
 	uint32_t ipsec_in_min_spi = roc_nix->ipsec_in_min_spi;
 	uint32_t ipsec_in_max_spi = roc_nix->ipsec_in_max_spi;
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
-	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
-	struct nix_inline_ipsec_lf_cfg *lf_cfg;
-	uint64_t max_sa, i;
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev = NULL;
+	uint64_t max_sa, i, sa_pow2_sz;
+	uint64_t sa_idx_w, lenm1_max;
+	struct mbox *mbox;
 	size_t inb_sa_sz;
 	void *sa;
 	int rc;
 
+	/* Setup default IPsec profile */
+	if (roc_feature_nix_has_inl_profile()) {
+		rc = nix_inl_setup_dflt_ipsec_profile(&nix->dev, &nix->ipsec_prof_id);
+		if (rc)
+			return rc;
+	}
+	mbox = mbox_get(nix->dev.mbox);
+
 	max_sa = plt_align32pow2(ipsec_in_max_spi - ipsec_in_min_spi + 1);
 
 	/* CN9K SA size is different */
@@ -425,6 +435,10 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		goto exit;
 	}
 
+	sa_pow2_sz = plt_log2_u32(inb_sa_sz);
+	sa_idx_w = plt_log2_u32(max_sa);
+	lenm1_max = roc_nix_max_pkt_len(roc_nix) - 1;
+
 	if (!roc_model_is_cn9k()) {
 		for (i = 0; i < max_sa; i++) {
 			sa = ((uint8_t *)nix->inb_sa_base) + (i * inb_sa_sz);
@@ -435,23 +449,54 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		}
 	}
 
-	/* Setup device specific inb SA table */
-	lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
-	if (lf_cfg == NULL) {
-		rc = -ENOSPC;
-		plt_err("Failed to alloc nix inline ipsec lf cfg mbox msg");
-		goto free_mem;
+	if (roc_model_is_cn9k() || roc_model_is_cn10k()) {
+		struct nix_inline_ipsec_lf_cfg *lf_cfg;
+
+		/* Setup device specific inb SA table */
+		lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
+		if (lf_cfg == NULL) {
+			rc = -ENOSPC;
+			plt_err("Failed to alloc nix inline ipsec lf cfg mbox msg");
+			goto free_mem;
+		}
+
+		lf_cfg->enable = 1;
+		lf_cfg->sa_base_addr = (uintptr_t)nix->inb_sa_base;
+		lf_cfg->ipsec_cfg1.sa_idx_w = sa_idx_w;
+		lf_cfg->ipsec_cfg0.lenm1_max = lenm1_max;
+		lf_cfg->ipsec_cfg1.sa_idx_max = max_sa - 1;
+		lf_cfg->ipsec_cfg0.sa_pow2_size = sa_pow2_sz;
+		lf_cfg->ipsec_cfg0.tag_const = 0;
+		lf_cfg->ipsec_cfg0.tt = SSO_TT_ORDERED;
+	} else {
+		struct nix_rx_inl_lf_cfg_req *lf_cfg;
+		uint64_t def_cptq = 0;
+
+		/* Setup device specific inb SA table */
+		lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+		if (lf_cfg == NULL) {
+			rc = -ENOSPC;
+			plt_err("Failed to alloc nix inline ipsec lf cfg mbox msg");
+			goto free_mem;
+		}
+
+		/*TODO default cptq */
+		if (idev && idev->nix_inl_dev) {
+			inl_dev = idev->nix_inl_dev;
+			if (!inl_dev->nb_inb_cptlfs)
+				def_cptq = 0;
+			else
+				def_cptq = inl_dev->nix_inb_qids[0];
+		}
+
+		lf_cfg->enable = 1;
+		lf_cfg->profile_id = nix->ipsec_prof_id; /* IPsec profile is 0th one */
+		lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base;
+		lf_cfg->rx_inline_cfg0 = ((def_cptq << 57) | ((uint64_t)SSO_TT_ORDERED << 44) |
+					  (sa_pow2_sz << 16) | lenm1_max);
+		lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_idx_w << 32);
 	}
 
-	lf_cfg->enable = 1;
-	lf_cfg->sa_base_addr = (uintptr_t)nix->inb_sa_base;
-	lf_cfg->ipsec_cfg1.sa_idx_w = plt_log2_u32(max_sa);
-	lf_cfg->ipsec_cfg0.lenm1_max = roc_nix_max_pkt_len(roc_nix) - 1;
-	lf_cfg->ipsec_cfg1.sa_idx_max = max_sa - 1;
-	lf_cfg->ipsec_cfg0.sa_pow2_size = plt_log2_u32(inb_sa_sz);
-	lf_cfg->ipsec_cfg0.tag_const = 0;
-	lf_cfg->ipsec_cfg0.tt = SSO_TT_ORDERED;
-
 	rc = mbox_process(mbox);
 	if (rc) {
 		plt_err("Failed to setup NIX Inbound SA conf, rc=%d", rc);
@@ -469,21 +514,34 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 }
 
 static int
-nix_inl_sa_tbl_release(struct roc_nix *roc_nix)
+nix_inl_ipsec_sa_tbl_release(struct roc_nix *roc_nix)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
-	struct nix_inline_ipsec_lf_cfg *lf_cfg;
 	int rc;
 
-	lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
-	if (lf_cfg == NULL) {
-		rc = -ENOSPC;
-		goto exit;
+	if (roc_model_is_cn9k() || roc_model_is_cn10k()) {
+		struct nix_inline_ipsec_lf_cfg *lf_cfg;
+
+		lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
+		if (lf_cfg == NULL) {
+			rc = -ENOSPC;
+			goto exit;
+		}
+
+		lf_cfg->enable = 0;
+	} else {
+		struct nix_rx_inl_lf_cfg_req *lf_cfg;
+
+		lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+		if (!lf_cfg) {
+			rc = -ENOSPC;
+			goto exit;
+		}
+
+		lf_cfg->enable = 0;
 	}
 
-	lf_cfg->enable = 0;
-
 	rc = mbox_process(mbox);
 	if (rc) {
 		plt_err("Failed to cleanup NIX Inbound SA conf, rc=%d", rc);
@@ -728,27 +786,11 @@ roc_nix_reassembly_configure(uint32_t max_wait_time, uint16_t max_frags)
 	return roc_cpt_rxc_time_cfg(roc_cpt, &cfg);
 }
 
-static int
-nix_inl_rq_mask_cfg(struct roc_nix *roc_nix, bool enable)
+static void
+nix_inl_rq_mask_init(struct nix_rq_cpt_field_mask_cfg_req *msk_req)
 {
-	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
-	struct nix_rq_cpt_field_mask_cfg_req *msk_req;
-	struct idev_cfg *idev = idev_get_cfg();
-	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
-	struct idev_nix_inl_cfg *inl_cfg;
-	uint64_t aura_handle;
-	int rc = -ENOSPC;
-	uint32_t buf_sz;
 	int i;
 
-	if (!idev)
-		goto exit;
-
-	inl_cfg = &idev->inl_cfg;
-	msk_req = mbox_alloc_msg_nix_lf_inline_rq_cfg(mbox);
-	if (msk_req == NULL)
-		goto exit;
-
 	for (i = 0; i < RQ_CTX_MASK_MAX; i++)
 		msk_req->rq_ctx_word_mask[i] = 0xFFFFFFFFFFFFFFFF;
 
@@ -792,7 +834,29 @@ nix_inl_rq_mask_cfg(struct roc_nix *roc_nix, bool enable)
 	msk_req->rq_mask.spb_drop_ena = 0;
 	msk_req->rq_mask.xqe_drop_ena = 0;
 	msk_req->rq_mask.spb_ena = 0;
+}
 
+static int
+nix_inl_legacy_rq_mask_setup(struct roc_nix *roc_nix, bool enable)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct nix_rq_cpt_field_mask_cfg_req *msk_req;
+	struct idev_cfg *idev = idev_get_cfg();
+	struct mbox *mbox = mbox_get((&nix->dev)->mbox);
+	struct idev_nix_inl_cfg *inl_cfg;
+	uint64_t aura_handle;
+	int rc = -ENOSPC;
+	uint32_t buf_sz;
+
+	if (!idev)
+		goto exit;
+
+	inl_cfg = &idev->inl_cfg;
+	msk_req = mbox_alloc_msg_nix_lf_inline_rq_cfg(mbox);
+	if (msk_req == NULL)
+		goto exit;
+
+	nix_inl_rq_mask_init(msk_req);
 	if (roc_nix->local_meta_aura_ena) {
 		aura_handle = roc_nix->meta_aura_handle;
 		buf_sz = roc_nix->buf_sz;
@@ -816,6 +880,79 @@ nix_inl_rq_mask_cfg(struct roc_nix *roc_nix, bool enable)
 	return rc;
 }
 
+static int
+nix_inl_rq_mask_cfg(struct roc_nix *roc_nix, bool enable)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct nix_rq_cpt_field_mask_cfg_req *msk_req;
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_rx_inl_lf_cfg_req *lf_cfg;
+	struct idev_nix_inl_cfg *inl_cfg;
+	uint64_t aura_handle;
+	struct mbox *mbox;
+	int rc = -ENOSPC;
+	uint64_t buf_sz;
+
+	if (roc_model_is_cn9k() | roc_model_is_cn10k())
+		return nix_inl_legacy_rq_mask_setup(roc_nix, enable);
+
+	mbox = mbox_get((&nix->dev)->mbox);
+	/* RQ mask alloc and setup */
+	msk_req = mbox_alloc_msg_nix_lf_inline_rq_cfg(mbox);
+	if (msk_req == NULL)
+		goto exit;
+
+	nix_inl_rq_mask_init(msk_req);
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to setup NIX Inline RQ mask, rc=%d", rc);
+		goto exit;
+	}
+
+	/* SPB setup */
+	if (!roc_nix->local_meta_aura_ena && !roc_nix->custom_meta_aura_ena)
+		goto exit;
+
+	if (!idev)
+		return -ENOENT;
+
+	inl_cfg = &idev->inl_cfg;
+
+	if (roc_nix->local_meta_aura_ena) {
+		aura_handle = roc_nix->meta_aura_handle;
+		buf_sz = roc_nix->buf_sz;
+		if (!aura_handle && enable) {
+			plt_err("NULL meta aura handle");
+			rc = -EINVAL;
+			goto exit;
+		}
+	} else {
+		aura_handle = roc_npa_zero_aura_handle();
+		buf_sz = inl_cfg->buf_sz;
+	}
+
+	/* SPB setup */
+	lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+	if (lf_cfg == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	lf_cfg->rx_inline_sa_base = (uintptr_t)nix->inb_sa_base;
+	lf_cfg->rx_inline_cfg0 = nix->rx_inline_cfg0;
+	lf_cfg->profile_id = nix->ipsec_prof_id;
+	if (enable)
+		lf_cfg->rx_inline_cfg1 =
+			(nix->rx_inline_cfg1 | BIT_ULL(37) | ((buf_sz >> 7) - 1) << 38 |
+			 roc_npa_aura_handle_to_aura(aura_handle) << 44);
+	else
+		lf_cfg->rx_inline_cfg1 = nix->rx_inline_cfg1;
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 static void
 nix_inl_eng_caps_get(struct nix *nix)
 {
@@ -940,8 +1077,8 @@ nix_inl_eng_caps_get(struct nix *nix)
 	plt_free(hw_res);
 }
 
-int
-roc_nix_inl_inb_init(struct roc_nix *roc_nix)
+static int
+nix_inl_legacy_inb_init(struct roc_nix *roc_nix)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct roc_cpt_inline_ipsec_inb_cfg cfg;
@@ -963,6 +1100,7 @@ roc_nix_inl_inb_init(struct roc_nix *roc_nix)
 		return -ENOTSUP;
 	}
 
+	memset(&cfg, 0, sizeof(cfg));
 	if (roc_model_is_cn9k()) {
 		cfg.param1 = (ROC_ONF_IPSEC_INB_MAX_L2_SZ >> 3) & 0xf;
 		cfg.param2 = ROC_IE_ON_INB_IKEV2_SINGLE_SA_SUPPORT;
@@ -1003,7 +1141,7 @@ roc_nix_inl_inb_init(struct roc_nix *roc_nix)
 	nix->cpt_eng_caps = roc_cpt->hw_caps[CPT_ENG_TYPE_SE].u;
 
 	/* Setup Inbound SA table */
-	rc = nix_inl_inb_sa_tbl_setup(roc_nix);
+	rc = nix_inl_inb_ipsec_sa_tbl_setup(roc_nix);
 	if (rc)
 		return rc;
 
@@ -1017,6 +1155,51 @@ roc_nix_inl_inb_init(struct roc_nix *roc_nix)
 	return 0;
 }
 
+static int
+nix_inl_inb_init(struct roc_nix *roc_nix)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev;
+	int rc;
+
+	if (idev == NULL)
+		return -ENOTSUP;
+
+	inl_dev = idev->nix_inl_dev;
+
+	if (!inl_dev || !inl_dev->nb_inb_cptlfs) {
+		plt_err("Cannot support inline inbound without inline dev");
+		return -ENOTSUP;
+	}
+
+	/* FIXME get engine caps from inline device */
+	nix->cpt_eng_caps = 0;
+
+	/* Setup Inbound SA table */
+	rc = nix_inl_inb_ipsec_sa_tbl_setup(roc_nix);
+	if (rc)
+		return rc;
+
+	if (roc_nix->local_meta_aura_ena || roc_nix->custom_meta_aura_ena) {
+		nix->need_meta_aura = true;
+
+		if (roc_nix->custom_meta_aura_ena)
+			idev->inl_cfg.refs++;
+	}
+
+	nix->inl_inb_ena = true;
+	return 0;
+}
+
+int
+roc_nix_inl_inb_init(struct roc_nix *roc_nix)
+{
+	if (roc_model_is_cn9k() || roc_model_is_cn10k())
+		return nix_inl_legacy_inb_init(roc_nix);
+
+	return nix_inl_inb_init(roc_nix);
+}
 int
 roc_nix_inl_inb_fini(struct roc_nix *roc_nix)
 {
@@ -1056,7 +1239,7 @@ roc_nix_inl_inb_fini(struct roc_nix *roc_nix)
 	roc_nix_cpt_ctx_cache_sync(roc_nix);
 
 	/* Disable Inbound SA */
-	return nix_inl_sa_tbl_release(roc_nix);
+	return nix_inl_ipsec_sa_tbl_release(roc_nix);
 }
 
 int
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index e26e3fe38c..37f156e7d8 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -89,7 +89,6 @@ struct roc_nix_inl_dev {
 	bool is_multi_channel;
 	uint16_t channel;
 	uint16_t chan_mask;
-	bool attach_cptlf;
 	uint16_t wqe_skip;
 	uint8_t spb_drop_pc;
 	uint8_t lpb_drop_pc;
@@ -99,9 +98,10 @@ struct roc_nix_inl_dev {
 	uint32_t max_ipsec_rules;
 	uint8_t rx_inj_ena; /* Rx Inject Enable */
 	uint8_t custom_inb_sa;
+	uint8_t nb_inb_cptlfs;
 	/* End of input parameters */
 
-#define ROC_NIX_INL_MEM_SZ (2048)
+#define ROC_NIX_INL_MEM_SZ (6144)
 	uint8_t reserved[ROC_NIX_INL_MEM_SZ] __plt_cache_aligned;
 } __plt_cache_aligned;
 
@@ -109,7 +109,7 @@ struct roc_nix_inl_dev_q {
 	uint32_t nb_desc;
 	uintptr_t rbase;
 	uintptr_t lmt_base;
-	uint64_t *fc_addr;
+	uint64_t __plt_atomic *fc_addr;
 	uint64_t io_addr;
 	int32_t fc_addr_sw;
 } __plt_cache_aligned;
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index b66c71bc29..6216305db9 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -7,6 +7,8 @@
 
 #include <unistd.h>
 
+#define NIX_INL_DEV_CPT_LF_QSZ 8192
+
 #define NIX_AURA_DROP_PC_DFLT 40
 
 /* Default Rx Config for Inline NIX LF */
@@ -102,6 +104,185 @@ nix_inl_selftest(void)
 	return rc;
 }
 
+int
+nix_inl_setup_dflt_ipsec_profile(struct dev *dev, uint16_t *prof_id)
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
+	/* Prepare NIXX_AF_RX_DEF_INLINE to match ESP, IPv4/IPv6 and extract l2_len */
+	req->def_cfg = NIX_INL_DFLT_IPSEC_DEF_CFG;
+
+	/* Extract 32 bit from bit pos 0 */
+	req->extract_cfg = NIX_INL_DFLT_IPSEC_EXTRACT_CFG;
+
+	/* Gen config */
+	req->gen_cfg = NIX_INL_DFLT_IPSEC_GEN_CFG;
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
+static int
+nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
+{
+	struct roc_cpt_lf *lf = &inl_dev->cpt_lf[slot_id];
+	struct nix_rx_inline_qcfg_req *nix_req;
+	struct cpt_rx_inline_qcfg_req *cpt_req;
+	struct cpt_rx_inline_qalloc_rsp *rsp;
+	struct msg_req *req;
+	struct mbox *mbox;
+	uint16_t bpid, qid;
+	int rc;
+
+	/* Allocate BPID if not allocated */
+	if (inl_dev->nix_inb_q_bpid < 0) {
+		rc = nix_bpids_alloc(&inl_dev->dev, ROC_NIX_INTF_TYPE_CPT_NIX, 1, &bpid);
+		if (rc <= 0)
+			plt_warn("Failed to allocate BPID for inbound queue, rc=%d", rc);
+		else
+			inl_dev->nix_inb_q_bpid = bpid;
+	}
+
+	mbox = mbox_get((&inl_dev->dev)->mbox);
+	/* Allocate inline queue */
+	rc = -ENOSPC;
+	req = mbox_alloc_msg_cpt_rx_inline_qalloc(mbox);
+	if (!req)
+		goto exit;
+
+	rc = mbox_process_msg(mbox, (void **)&rsp);
+	if (rc) {
+		plt_err("Failed to alloc inline q, rc=%d", rc);
+		goto exit;
+	}
+
+	qid = rsp->rx_queue_id;
+
+	/* Configure CPT LF dedicated for inline processing */
+	cpt_req = mbox_alloc_msg_cpt_rx_inl_queue_cfg(mbox);
+	if (!cpt_req)
+		goto cpt_cfg_fail;
+
+	cpt_req->enable = 1;
+	cpt_req->slot = slot_id;
+	cpt_req->rx_queue_id = qid;
+	cpt_req->eng_grpmsk = inl_dev->eng_grpmask;
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to configure CPT LF for inline processing, rc=%d", rc);
+		goto cpt_cfg_fail;
+	}
+
+	/* Setup NIX AF to CPT LF mapping for inline queue */
+	rc = -ENOSPC;
+	nix_req = mbox_alloc_msg_nix_rx_inl_queue_cfg(mbox);
+	if (!nix_req)
+		goto nix_cfg_fail;
+	nix_req->cpt_pf_func = inl_dev->dev.pf_func;
+	nix_req->cpt_slot = slot_id;
+	nix_req->cpt_credit = lf->nb_desc;
+	nix_req->rx_queue_id = qid;
+	nix_req->enable = 1;
+	if (inl_dev->nix_inb_q_bpid >= 0) {
+		nix_req->bpid = inl_dev->nix_inb_q_bpid;
+		nix_req->credit_th = nix_req->cpt_credit - 1;
+	}
+
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Failed to enable inbound queue on slot %u, rc=%d", slot_id, rc);
+		goto nix_cfg_fail;
+	}
+
+	inl_dev->nix_inb_qids[slot_id] = qid;
+	mbox_put(mbox);
+	return 0;
+nix_cfg_fail:
+	cpt_req = mbox_alloc_msg_cpt_rx_inl_queue_cfg(mbox);
+	if (!cpt_req) {
+		rc |= -ENOSPC;
+	} else {
+		nix_req->enable = false;
+		rc |= mbox_process(mbox);
+	}
+cpt_cfg_fail:
+	/* TODO: Free QID */
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+static int
+nix_inl_inb_queue_release(struct nix_inl_dev *inl_dev, uint8_t slot_id)
+{
+	struct nix_rx_inline_qcfg_req *nix_req;
+	struct cpt_rx_inline_qcfg_req *cpt_req;
+	struct mbox *mbox;
+	int rc, ret = 0;
+	int qid;
+
+	qid = inl_dev->nix_inb_qids[slot_id];
+	if (qid < 0)
+		return 0;
+
+	mbox = mbox_get((&inl_dev->dev)->mbox);
+
+	/* Cleanup NIX AF to CPT LF mapping for inline queue */
+	rc = -ENOSPC;
+	nix_req = mbox_alloc_msg_nix_rx_inl_queue_cfg(mbox);
+	if (!nix_req) {
+		ret |= rc;
+		goto exit;
+	}
+	nix_req->rx_queue_id = qid;
+	nix_req->enable = 0;
+
+	rc = mbox_process(mbox);
+	if (rc)
+		plt_err("Failed to cleanup inbound queue %u, rc=%d", qid, rc);
+	ret |= rc;
+
+	/* Configure CPT LF dedicated for inline processing */
+	cpt_req = mbox_alloc_msg_cpt_rx_inl_queue_cfg(mbox);
+	if (!cpt_req) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	cpt_req->enable = 0;
+	cpt_req->rx_queue_id = qid;
+	cpt_req->slot = slot_id;
+
+	rc = mbox_process(mbox);
+	if (rc)
+		plt_err("Failed to disable CPT LF for inline processing, rc=%d", rc);
+	ret |= rc;
+
+	/* TODO: Free inline queue */
+
+	inl_dev->nix_inb_qids[slot_id] = -1;
+	mbox_put(mbox);
+	return 0;
+exit:
+	mbox_put(mbox);
+	return ret;
+}
+
 static int
 nix_inl_cpt_ctx_cache_sync(struct nix_inl_dev *inl_dev)
 {
@@ -124,39 +305,69 @@ nix_inl_cpt_ctx_cache_sync(struct nix_inl_dev *inl_dev)
 static int
 nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 {
-	struct nix_inline_ipsec_lf_cfg *lf_cfg;
 	struct mbox *mbox = mbox_get((&inl_dev->dev)->mbox);
-	uint64_t max_sa;
-	uint32_t sa_w;
+	uint64_t max_sa, sa_w, sa_pow2_sz, lenm1_max;
 	int rc;
 
-	lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
-	if (lf_cfg == NULL) {
-		rc = -ENOSPC;
-		goto exit;
-	}
+	max_sa = inl_dev->inb_spi_mask + 1;
+	sa_w = plt_log2_u32(max_sa);
+	sa_pow2_sz = plt_log2_u32(inl_dev->inb_sa_sz);
+	/* CN9K SA size is different */
+	if (roc_model_is_cn9k())
+		lenm1_max = NIX_CN9K_MAX_HW_FRS - 1;
+	else
+		lenm1_max = NIX_RPM_MAX_HW_FRS - 1;
 
-	if (ena) {
+	if (!roc_model_is_cn20k()) {
+		struct nix_inline_ipsec_lf_cfg *lf_cfg;
 
-		max_sa = inl_dev->inb_spi_mask + 1;
-		sa_w = plt_log2_u32(max_sa);
+		lf_cfg = mbox_alloc_msg_nix_inline_ipsec_lf_cfg(mbox);
+		if (lf_cfg == NULL) {
+			rc = -ENOSPC;
+			goto exit;
+		}
 
-		lf_cfg->enable = 1;
-		lf_cfg->sa_base_addr = (uintptr_t)inl_dev->inb_sa_base;
-		lf_cfg->ipsec_cfg1.sa_idx_w = sa_w;
-		/* CN9K SA size is different */
-		if (roc_model_is_cn9k())
-			lf_cfg->ipsec_cfg0.lenm1_max = NIX_CN9K_MAX_HW_FRS - 1;
-		else
-			lf_cfg->ipsec_cfg0.lenm1_max = NIX_RPM_MAX_HW_FRS - 1;
-		lf_cfg->ipsec_cfg1.sa_idx_max = max_sa - 1;
-		lf_cfg->ipsec_cfg0.sa_pow2_size =
-			plt_log2_u32(inl_dev->inb_sa_sz);
+		if (ena) {
+			lf_cfg->enable = 1;
+			lf_cfg->sa_base_addr = (uintptr_t)inl_dev->inb_sa_base;
+			lf_cfg->ipsec_cfg1.sa_idx_w = sa_w;
+			lf_cfg->ipsec_cfg0.lenm1_max = lenm1_max;
+			lf_cfg->ipsec_cfg1.sa_idx_max = max_sa - 1;
+			lf_cfg->ipsec_cfg0.sa_pow2_size = sa_pow2_sz;
 
-		lf_cfg->ipsec_cfg0.tag_const = 0;
-		lf_cfg->ipsec_cfg0.tt = SSO_TT_ORDERED;
+			lf_cfg->ipsec_cfg0.tag_const = 0;
+			lf_cfg->ipsec_cfg0.tt = SSO_TT_ORDERED;
+		} else {
+			lf_cfg->enable = 0;
+		}
 	} else {
-		lf_cfg->enable = 0;
+		struct nix_rx_inl_lf_cfg_req *lf_cfg;
+		uint64_t def_cptq;
+
+		lf_cfg = mbox_alloc_msg_nix_rx_inl_lf_cfg(mbox);
+		if (lf_cfg == NULL) {
+			rc = -ENOSPC;
+			goto exit;
+		}
+
+		/*TODO default cptq */
+		if (!inl_dev->nb_inb_cptlfs)
+			def_cptq = 0;
+		else
+			def_cptq = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+
+		if (ena) {
+			lf_cfg->enable = 1;
+			lf_cfg->profile_id = inl_dev->ipsec_prof_id;
+			lf_cfg->rx_inline_sa_base = (uintptr_t)inl_dev->inb_sa_base;
+			lf_cfg->rx_inline_cfg0 = ((def_cptq << 57) |
+						  ((uint64_t)SSO_TT_ORDERED << 44) |
+						  (sa_pow2_sz << 16) | lenm1_max);
+			lf_cfg->rx_inline_cfg1 = (max_sa - 1) | (sa_w << 32);
+		} else {
+			lf_cfg->enable = 0;
+			lf_cfg->profile_id = inl_dev->ipsec_prof_id;
+		}
 	}
 
 	rc = mbox_process(mbox);
@@ -174,17 +385,12 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 	struct roc_cpt_lf *lf;
 	uint8_t eng_grpmask;
 	uint8_t ctx_ilen = 0;
-	int rc;
+	int rc, i;
 
 	if (!inl_dev->attach_cptlf)
 		return 0;
 
-	if (roc_model_is_cn9k() || roc_model_is_cn10k())
-		eng_grpmask = (1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE |
-			       1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE |
-			       1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_AE);
-	else
-		eng_grpmask = (1ULL << ROC_CPT_DFLT_ENG_GRP_SE | 1ULL << ROC_CPT_DFLT_ENG_GRP_AE);
+	eng_grpmask = inl_dev->eng_grpmask;
 
 	if (roc_errata_cpt_has_ctx_fetch_issue()) {
 		ctx_ilen = (ROC_NIX_INL_OT_IPSEC_INB_HW_SZ / 128) - 1;
@@ -193,17 +399,17 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 
 	/* Alloc CPT LF */
 	rc = cpt_lfs_alloc(dev, eng_grpmask, RVU_BLOCK_ADDR_CPT0, inl_dev_sso, ctx_ilen_valid,
-			   ctx_ilen, inl_dev->rx_inj_ena, inl_dev->nb_cptlf - 1);
+			   ctx_ilen, inl_dev->rx_inj_ena, 1);
 	if (rc) {
 		plt_err("Failed to alloc CPT LF resources, rc=%d", rc);
 		return rc;
 	}
 
-	for (int i = 0; i < inl_dev->nb_cptlf; i++) {
+	for (i = 0; i < inl_dev->nb_cptlf; i++) {
 		/* Setup CPT LF for submitting control opcode */
 		lf = &inl_dev->cpt_lf[i];
 		lf->lf_id = i;
-		lf->nb_desc = 0; /* Set to default */
+		lf->nb_desc = NIX_INL_DEV_CPT_LF_QSZ; /* Set to default */
 		lf->dev = &inl_dev->dev;
 		lf->msixoff = inl_dev->cpt_msixoff[i];
 		lf->pci_dev = inl_dev->pci_dev;
@@ -216,14 +422,25 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 
 		q_info = &inl_dev->q_info[i];
 		q_info->nb_desc = lf->nb_desc;
-		q_info->fc_addr = lf->fc_addr;
+		q_info->fc_addr = (uint64_t __plt_atomic *)lf->fc_addr;
 		q_info->io_addr = lf->io_addr;
 		q_info->lmt_base = lf->lmt_base;
 		q_info->rbase = lf->rbase;
 
 		roc_cpt_iq_enable(lf);
 	}
+
+	/* Configure NIX inline inbound queue resource */
+	for (i = 0; i < inl_dev->nb_inb_cptlfs; i++) {
+		rc = nix_inl_inb_queue_setup(inl_dev, inl_dev->inb_cpt_lf_id + i);
+		if (rc)
+			goto lf_fini;
+	}
+
 	return 0;
+lf_fini:
+	for (i = 0; i < inl_dev->nb_cptlf; i++)
+		cpt_lf_fini(&inl_dev->cpt_lf[i]);
 lf_free:
 	rc |= cpt_lfs_free(dev);
 	return rc;
@@ -233,11 +450,18 @@ static int
 nix_inl_cpt_release(struct nix_inl_dev *inl_dev)
 {
 	struct dev *dev = &inl_dev->dev;
-	int rc, i;
+	int rc = 0, i, ret;
 
 	if (!inl_dev->attach_cptlf)
 		return 0;
 
+	/* Release NIX inline inbound queue resource */
+	for (i = 0; i < inl_dev->nb_inb_cptlfs; i++)
+		rc |= nix_inl_inb_queue_release(inl_dev, inl_dev->inb_cpt_lf_id + i);
+	ret = rc;
+
+	/* TODO: Wait for CPT/RXC queue to drain */
+
 	/* Cleanup CPT LF queue */
 	for (i = 0; i < inl_dev->nb_cptlf; i++)
 		cpt_lf_fini(&inl_dev->cpt_lf[i]);
@@ -249,7 +473,8 @@ nix_inl_cpt_release(struct nix_inl_dev *inl_dev)
 			inl_dev->cpt_lf[i].dev = NULL;
 	} else
 		plt_err("Failed to free CPT LF resources, rc=%d", rc);
-	return rc;
+	ret |= rc;
+	return ret;
 }
 
 static int
@@ -363,6 +588,13 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 	int rc = -ENOSPC;
 	void *sa;
 
+	/* Setup default IPsec profile */
+	if (roc_feature_nix_has_inl_profile()) {
+		rc = nix_inl_setup_dflt_ipsec_profile(&inl_dev->dev, &inl_dev->ipsec_prof_id);
+		if (rc)
+			return rc;
+	}
+
 	max_sa = plt_align32pow2(ipsec_in_max_spi - ipsec_in_min_spi + 1);
 
 	/* Alloc NIX LF needed for single RQ */
@@ -451,12 +683,6 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 				roc_ow_ipsec_inb_sa_init(sa);
 		}
 	}
-	/* Setup device specific inb SA table */
-	rc = nix_inl_nix_ipsec_cfg(inl_dev, true);
-	if (rc) {
-		plt_err("Failed to setup NIX Inbound SA conf, rc=%d", rc);
-		goto free_mem;
-	}
 
 	/* Allocate memory for RQ's */
 	rqs = plt_zmalloc(sizeof(struct roc_nix_rq) * PLT_MAX_ETHPORTS, 0);
@@ -943,7 +1169,7 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	inl_dev->is_multi_channel = roc_inl_dev->is_multi_channel;
 	inl_dev->channel = roc_inl_dev->channel;
 	inl_dev->chan_mask = roc_inl_dev->chan_mask;
-	inl_dev->attach_cptlf = roc_inl_dev->attach_cptlf;
+	inl_dev->attach_cptlf = true;
 	inl_dev->wqe_skip = roc_inl_dev->wqe_skip;
 	inl_dev->spb_drop_pc = NIX_AURA_DROP_PC_DFLT;
 	inl_dev->lpb_drop_pc = NIX_AURA_DROP_PC_DFLT;
@@ -953,12 +1179,30 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	inl_dev->meta_buf_sz = roc_inl_dev->meta_buf_sz;
 	inl_dev->soft_exp_poll_freq = roc_inl_dev->soft_exp_poll_freq;
 	inl_dev->custom_inb_sa = roc_inl_dev->custom_inb_sa;
+	inl_dev->nix_inb_q_bpid = -1;
+	inl_dev->nb_cptlf = 1;
 
+	if (roc_model_is_cn9k() || roc_model_is_cn10k())
+		inl_dev->eng_grpmask = (1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE |
+					1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE |
+					1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_AE);
+	else
+		inl_dev->eng_grpmask =
+			(1ULL << ROC_CPT_DFLT_ENG_GRP_SE | 1ULL << ROC_CPT_DFLT_ENG_GRP_AE);
+
+	/* RXC inject uses extra CPT LF */
 	if (roc_inl_dev->rx_inj_ena) {
 		inl_dev->rx_inj_ena = 1;
-		inl_dev->nb_cptlf = NIX_INL_CPT_LF;
-	} else
-		inl_dev->nb_cptlf = 1;
+		inl_dev->nb_cptlf++;
+	}
+
+	/* Attach inline inbound CPT LF to NIX has multi queue support */
+	if (roc_feature_nix_has_inl_multi_queue() && roc_inl_dev->nb_inb_cptlfs) {
+		inl_dev->nb_inb_cptlfs = roc_inl_dev->nb_inb_cptlfs;
+
+		inl_dev->inb_cpt_lf_id = inl_dev->nb_cptlf;
+		inl_dev->nb_cptlf += inl_dev->nb_inb_cptlfs;
+	}
 
 	if (roc_inl_dev->spb_drop_pc)
 		inl_dev->spb_drop_pc = roc_inl_dev->spb_drop_pc;
@@ -994,6 +1238,13 @@ roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 	if (rc)
 		goto sso_release;
 
+	/* Setup device specific inb SA table */
+	rc = nix_inl_nix_ipsec_cfg(inl_dev, true);
+	if (rc) {
+		plt_err("Failed to setup NIX Inbound SA conf, rc=%d", rc);
+		goto cpt_release;
+	}
+
 	if (inl_dev->set_soft_exp_poll) {
 		rc = nix_inl_outb_poll_thread_setup(inl_dev);
 		if (rc)
diff --git a/drivers/common/cnxk/roc_nix_inl_priv.h b/drivers/common/cnxk/roc_nix_inl_priv.h
index e5494fd71a..b1830f2449 100644
--- a/drivers/common/cnxk/roc_nix_inl_priv.h
+++ b/drivers/common/cnxk/roc_nix_inl_priv.h
@@ -7,7 +7,7 @@
 #include <sys/types.h>
 
 #define NIX_INL_META_SIZE 384u
-#define NIX_INL_CPT_LF	2
+#define MAX_NIX_INL_DEV_CPT_LF 18
 
 struct nix_inl_dev;
 struct nix_inl_qint {
@@ -32,7 +32,7 @@ struct nix_inl_dev {
 	uint16_t nix_msixoff;
 	uint16_t ssow_msixoff;
 	uint16_t sso_msixoff;
-	uint16_t cpt_msixoff[NIX_INL_CPT_LF];
+	uint16_t cpt_msixoff[MAX_NIX_INL_DEV_CPT_LF];
 
 	/* SSO data */
 	uint32_t xaq_buf_size;
@@ -66,7 +66,8 @@ struct nix_inl_dev {
 	uint8_t nb_cptlf;
 
 	/* CPT data */
-	struct roc_cpt_lf cpt_lf[NIX_INL_CPT_LF];
+	struct roc_cpt_lf cpt_lf[MAX_NIX_INL_DEV_CPT_LF];
+	uint16_t eng_grpmask;
 
 	/* OUTB soft expiry poll thread */
 	plt_thread_t soft_exp_poll_thread;
@@ -102,9 +103,26 @@ struct nix_inl_dev {
 	uint32_t max_ipsec_rules;
 	uint32_t alloc_ipsec_rules;
 
-	struct roc_nix_inl_dev_q q_info[NIX_INL_CPT_LF];
+	struct roc_nix_inl_dev_q q_info[MAX_NIX_INL_DEV_CPT_LF];
+
+	/* Inbound CPT LF info */
+	uint16_t inb_cpt_lf_id;
+	uint16_t nix_inb_qids[MAX_NIX_INL_DEV_CPT_LF];
+	uint16_t nb_inb_cptlfs;
+	int nix_inb_q_bpid;
+	uint16_t ipsec_prof_id;
 };
 
+#define NIX_INL_DFLT_IPSEC_DEF_CFG                                                                 \
+	(BIT_ULL(30) | BIT_ULL(29) | BIT_ULL(28) | NPC_LID_LE << 8 | NPC_LT_LE_ESP << 4 | 0xFul)
+
+#define NIX_INL_DFLT_IPSEC_EXTRACT_CFG (32UL << 8 | 32UL)
+
+#define NIX_INL_DFLT_IPSEC_GEN_CFG                                                                 \
+	(BIT_ULL(51) | ROC_CPT_DFLT_ENG_GRP_SE << 48 |                                             \
+	 ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_IPSEC << 32 | ROC_IE_OW_INPLACE_BIT << 32 |            \
+	 BIT_ULL(18))
+
 int nix_inl_sso_register_irqs(struct nix_inl_dev *inl_dev);
 void nix_inl_sso_unregister_irqs(struct nix_inl_dev *inl_dev);
 
@@ -113,4 +131,6 @@ void nix_inl_nix_unregister_irqs(struct nix_inl_dev *inl_dev);
 
 uint16_t nix_inl_dev_pffunc_get(void);
 
+int nix_inl_setup_dflt_ipsec_profile(struct dev *dev, uint16_t *prof_id);
+
 #endif /* _ROC_NIX_INL_PRIV_H_ */
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index eb64608885..d0a53ca998 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -202,6 +202,9 @@ struct nix {
 	bool inl_outb_ena;
 	void *inb_sa_base;
 	size_t inb_sa_sz;
+	uint16_t ipsec_prof_id;
+	uint64_t rx_inline_cfg0;
+	uint64_t rx_inline_cfg1;
 	uint32_t inb_spi_mask;
 	void *outb_sa_base;
 	size_t outb_sa_sz;
@@ -496,4 +499,7 @@ int nix_rss_reta_pffunc_set(struct roc_nix *roc_nix, uint8_t group,
 int nix_rss_flowkey_pffunc_set(struct roc_nix *roc_nix, uint8_t *alg_idx, uint32_t flowkey,
 			       uint8_t group, int mcam_index, uint16_t pf_func);
 
+int nix_bpids_alloc(struct dev *dev, uint8_t type, uint8_t bp_cnt, uint16_t *bpids);
+int nix_bpids_free(struct dev *dev, uint8_t bp_cnt, uint16_t *bpids);
+
 #endif /* _ROC_NIX_PRIV_H_ */
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index 1eb54446a8..b5da615af6 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -260,6 +260,7 @@ plt_thread_is_valid(plt_thread_t thr)
 #define plt_tel_data_add_dict_string rte_tel_data_add_dict_string
 #define plt_tel_data_add_dict_u64    rte_tel_data_add_dict_uint
 #define plt_telemetry_register_cmd   rte_telemetry_register_cmd
+#define __plt_atomic __rte_atomic
 
 /* Log */
 extern int cnxk_logtype_base;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index eae5336a9b..c7c034fa98 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -503,7 +503,7 @@ cnxk_nix_tx_queue_sec_count(uint64_t *mem, uint16_t sqes_per_sqb_log2, uint64_t
 }
 
 static inline int
-cnxk_nix_inl_fc_check(uint64_t *fc, int32_t *fc_sw, uint32_t nb_desc, uint16_t nb_inst)
+cnxk_nix_inl_fc_check(uint64_t __rte_atomic *fc, int32_t *fc_sw, uint32_t nb_desc, uint16_t nb_inst)
 {
 	uint8_t retry_count = 32;
 	int32_t val, newval;
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index 2c649c985a..6f0340ec0f 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -20,6 +20,7 @@
 #define CNXK_MAX_IPSEC_RULES	"max_ipsec_rules"
 #define CNXK_NIX_INL_RX_INJ_ENABLE	"rx_inj_ena"
 #define CNXK_NIX_CUSTOM_INB_SA	      "custom_inb_sa"
+#define CNXK_NIX_NB_INL_INB_QS        "nb_inl_inb_qs"
 
 /* Default soft expiry poll freq in usec */
 #define CNXK_NIX_SOFT_EXP_POLL_FREQ_DFLT 100
@@ -497,6 +498,7 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	uint32_t max_ipsec_rules = 0;
 	struct rte_kvargs *kvlist;
 	uint8_t custom_inb_sa = 0;
+	uint8_t nb_inl_inb_qs = 1;
 	uint32_t nb_meta_bufs = 0;
 	uint32_t meta_buf_sz = 0;
 	uint8_t rx_inj_ena = 0;
@@ -528,6 +530,7 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	rte_kvargs_process(kvlist, CNXK_MAX_IPSEC_RULES, &parse_max_ipsec_rules, &max_ipsec_rules);
 	rte_kvargs_process(kvlist, CNXK_NIX_INL_RX_INJ_ENABLE, &parse_val_u8, &rx_inj_ena);
 	rte_kvargs_process(kvlist, CNXK_NIX_CUSTOM_INB_SA, &parse_val_u8, &custom_inb_sa);
+	rte_kvargs_process(kvlist, CNXK_NIX_NB_INL_INB_QS, &parse_val_u8, &nb_inl_inb_qs);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
@@ -543,6 +546,8 @@ nix_inl_parse_devargs(struct rte_devargs *devargs,
 	inl_dev->max_ipsec_rules = max_ipsec_rules;
 	if (roc_feature_nix_has_rx_inject())
 		inl_dev->rx_inj_ena = rx_inj_ena;
+	if (roc_feature_nix_has_inl_multi_queue())
+		inl_dev->nb_inb_cptlfs = nb_inl_inb_qs;
 	inl_dev->custom_inb_sa = custom_inb_sa;
 	return 0;
 exit:
@@ -626,7 +631,6 @@ cnxk_nix_inl_dev_probe(struct rte_pci_driver *pci_drv,
 		goto free_mem;
 	}
 
-	inl_dev->attach_cptlf = true;
 	/* WQE skip is one for DPDK */
 	wqe_skip = RTE_ALIGN_CEIL(sizeof(struct rte_mbuf), ROC_CACHE_LINE_SZ);
 	wqe_skip = wqe_skip / ROC_CACHE_LINE_SZ;
@@ -673,4 +677,5 @@ RTE_PMD_REGISTER_PARAM_STRING(cnxk_nix_inl,
 			      CNXK_NIX_SOFT_EXP_POLL_FREQ "=<0-U32_MAX>"
 			      CNXK_MAX_IPSEC_RULES "=<1-4095>"
 			      CNXK_NIX_INL_RX_INJ_ENABLE "=1"
-			      CNXK_NIX_CUSTOM_INB_SA "=1");
+			      CNXK_NIX_CUSTOM_INB_SA "=1"
+			      CNXK_NIX_NB_INL_INB_QS "=[0-16]");
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD72C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:40:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4511340A72;
	Mon, 24 Feb 2025 10:40:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E312E40A7F
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:39:55 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9adFn017495
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 +EcxBUxtJKVtaBSN/gYM4SKqo5fwXpB7yS+qZv+Tdw=; b=O3h7lb4CNRkvaSGUa
 LIWpNniqSUkwCNyKFbDocl7DlGkWH6wh3pR6ZDemPCBQqgZHZzKDR4tsOZSUN5g5
 ZOB0zNaQhoxcMux9H6EzuG/0KovJoGd6ZVAGKoXtoxoTCripF6F2Tl7+ZpfgA8sC
 0hionqbkF/f8wxxOFx6LWxfy5L9KyADtTw+8eH1mYY7yiMXhCofzclp3y8CL7gdx
 wSAQIaSOYZSTebmm/QuBtpJBaDq3qG8osrPEwK2+om5Z6rxuYjPtdopt0vgebmjX
 OB5JHjk9LIYqRLvJA2KzrOdWyifmljlVJO1GBX0KkVaB+Y5L2BGvfCUvvpmmKz/R
 XT0Vw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450p9300bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:55 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:39:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:39:53 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 031193F705D;
 Mon, 24 Feb 2025 01:39:50 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Pavan Nikhilesh" <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 11/33] common/cnxk: update default eng group for cn20k
Date: Mon, 24 Feb 2025 15:08:53 +0530
Message-ID: <20250224093915.1253215-11-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Bo-coQ-ltFKSUbiXbIgrQ5oN1PQnEk-x
X-Proofpoint-GUID: Bo-coQ-ltFKSUbiXbIgrQ5oN1PQnEk-x
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

CN20K does not have IE engines, hence change the default eng group
for cn20k and use legacy for cn10k or older version.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c         |  6 +++---
 drivers/common/cnxk/roc_cpt.h         | 10 +++++++---
 drivers/common/cnxk/roc_nix_inl.c     | 15 +++++++++++----
 drivers/common/cnxk/roc_nix_inl_dev.c | 12 ++++++++----
 drivers/event/cnxk/cn9k_worker.h      |  2 +-
 drivers/net/cnxk/cn10k_rx.h           |  2 +-
 drivers/net/cnxk/cn10k_tx.h           |  4 ++--
 drivers/net/cnxk/cn20k_tx.h           |  4 ++--
 8 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index a6d2d83f76..b4bf0ccd64 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -931,9 +931,9 @@ roc_cpt_iq_reset(struct roc_cpt_lf *lf)
 		plt_write64(lf_ctl.u, lf->rbase + CPT_LF_CTL);
 
 		if (roc_model_is_cn9k())
-			cpt_9k_lf_rst_lmtst(lf, ROC_CPT_DFLT_ENG_GRP_SE);
+			cpt_9k_lf_rst_lmtst(lf, ROC_LEGACY_CPT_DFLT_ENG_GRP_SE);
 		else
-			cpt_10k_lf_rst_lmtst(lf, ROC_CPT_DFLT_ENG_GRP_SE);
+			cpt_10k_lf_rst_lmtst(lf, ROC_LEGACY_CPT_DFLT_ENG_GRP_SE);
 
 		plt_read64(lf->rbase + CPT_LF_INPROG);
 		plt_delay_us(2);
@@ -1205,7 +1205,7 @@ roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 
 	if (lf->roc_cpt == NULL) {
 		if (roc_cpt_has_ie_engines())
-			egrp = ROC_CPT_DFLT_ENG_GRP_SE_IE;
+			egrp = ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE;
 		else
 			egrp = ROC_CPT_DFLT_ENG_GRP_SE;
 	} else {
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index ac27479371..30bd2a094d 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -15,10 +15,14 @@
 #define ROC_LOADFVC_MAJOR_OP 0x01UL
 #define ROC_LOADFVC_MINOR_OP 0x08UL
 
+/* Default engine groups for CN9K, CN10K */
+#define ROC_LEGACY_CPT_DFLT_ENG_GRP_SE	  0UL
+#define ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE 1UL
+#define ROC_LEGACY_CPT_DFLT_ENG_GRP_AE	  2UL
+
 /* Default engine groups */
-#define ROC_CPT_DFLT_ENG_GRP_SE	   0UL
-#define ROC_CPT_DFLT_ENG_GRP_SE_IE 1UL
-#define ROC_CPT_DFLT_ENG_GRP_AE	   2UL
+#define ROC_CPT_DFLT_ENG_GRP_SE 0UL
+#define ROC_CPT_DFLT_ENG_GRP_AE 1UL
 
 #define ROC_CPT_MAX_LFS 64
 #define ROC_CPT_MAX_BLKS 2
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 88d5a678b1..6b7532b1f0 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -811,7 +811,10 @@ nix_inl_eng_caps_get(struct nix *nix)
 	inst.rptr = (uint64_t)rptr;
 	inst.w4.s.opcode_major = ROC_LOADFVC_MAJOR_OP;
 	inst.w4.s.opcode_minor = ROC_LOADFVC_MINOR_OP;
-	inst.w7.s.egrp = ROC_CPT_DFLT_ENG_GRP_SE;
+	if (roc_model_is_cn9k() || roc_model_is_cn10k())
+		inst.w7.s.egrp = ROC_LEGACY_CPT_DFLT_ENG_GRP_SE;
+	else
+		inst.w7.s.egrp = ROC_CPT_DFLT_ENG_GRP_SE;
 
 	/* Use 1 min timeout for the poll */
 	const uint64_t timeout = plt_tsc_cycles() + 60 * plt_tsc_hz();
@@ -1053,10 +1056,14 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 		ctx_ilen_valid = true;
 	}
 
+	if (roc_model_is_cn9k() || roc_model_is_cn10k())
+		eng_grpmask = (1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE |
+			       1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE |
+			       1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_AE);
+	else
+		eng_grpmask = (1ULL << ROC_CPT_DFLT_ENG_GRP_SE | 1ULL << ROC_CPT_DFLT_ENG_GRP_AE);
+
 	/* Alloc CPT LF */
-	eng_grpmask = (1ULL << ROC_CPT_DFLT_ENG_GRP_SE |
-		       1ULL << ROC_CPT_DFLT_ENG_GRP_SE_IE |
-		       1ULL << ROC_CPT_DFLT_ENG_GRP_AE);
 	rc = cpt_lfs_alloc(dev, eng_grpmask, blkaddr,
 			   !roc_nix->ipsec_out_sso_pffunc, ctx_ilen_valid, ctx_ilen,
 			   rx_inj, nb_lf - 1);
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index d26cbee0cc..da28b22bcc 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -179,15 +179,19 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 	if (!inl_dev->attach_cptlf)
 		return 0;
 
-	/* Alloc CPT LF */
-	eng_grpmask = (1ULL << ROC_CPT_DFLT_ENG_GRP_SE |
-		       1ULL << ROC_CPT_DFLT_ENG_GRP_SE_IE |
-		       1ULL << ROC_CPT_DFLT_ENG_GRP_AE);
+	if (roc_model_is_cn9k() || roc_model_is_cn10k())
+		eng_grpmask = (1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE |
+			       1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE |
+			       1ULL << ROC_LEGACY_CPT_DFLT_ENG_GRP_AE);
+	else
+		eng_grpmask = (1ULL << ROC_CPT_DFLT_ENG_GRP_SE | 1ULL << ROC_CPT_DFLT_ENG_GRP_AE);
+
 	if (roc_errata_cpt_has_ctx_fetch_issue()) {
 		ctx_ilen = (ROC_NIX_INL_OT_IPSEC_INB_HW_SZ / 128) - 1;
 		ctx_ilen_valid = true;
 	}
 
+	/* Alloc CPT LF */
 	rc = cpt_lfs_alloc(dev, eng_grpmask, RVU_BLOCK_ADDR_CPT0, inl_dev_sso, ctx_ilen_valid,
 			   ctx_ilen, inl_dev->rx_inj_ena, inl_dev->nb_cptlf - 1);
 	if (rc) {
diff --git a/drivers/event/cnxk/cn9k_worker.h b/drivers/event/cnxk/cn9k_worker.h
index 10abbdfbb5..513d397991 100644
--- a/drivers/event/cnxk/cn9k_worker.h
+++ b/drivers/event/cnxk/cn9k_worker.h
@@ -652,7 +652,7 @@ cn9k_sso_hws_xmit_sec_one(const struct cn9k_eth_txq *txq, uint64_t base,
 	sa_base &= ~(ROC_NIX_INL_SA_BASE_ALIGN - 1);
 
 	sa = (uintptr_t)roc_nix_inl_on_ipsec_outb_sa(sa_base, mdata.sa_idx);
-	ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE_IE << 61 | sa);
+	ucode_cmd[3] = (ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE << 61 | sa);
 	ucode_cmd[0] = (((ROC_IE_ON_OUTB_MAX_CTX_LEN << 8) |
 			 ROC_IE_ON_MAJOR_OP_PROCESS_OUTBOUND_IPSEC)
 				<< 48 |
diff --git a/drivers/net/cnxk/cn10k_rx.h b/drivers/net/cnxk/cn10k_rx.h
index 990dfbee3e..3430318193 100644
--- a/drivers/net/cnxk/cn10k_rx.h
+++ b/drivers/net/cnxk/cn10k_rx.h
@@ -1363,7 +1363,7 @@ cn10k_nix_inj_pkts(struct rte_security_session **sess, struct cnxk_ethdev_inj_cf
 				((uint64_t)sess_priv.dec_ttl) << 34 | m->pkt_len);
 
 		ucode_cmd[2] = 0;
-		ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
+		ucode_cmd[3] = (ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
 
 		/* Move to our line */
 		laddr = LMT_OFF(c_lbase, lnum, loff ? 64 : 0);
diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index 77f4e54cd8..809fafb2f7 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -547,7 +547,7 @@ cn10k_nix_prep_sec_vec(struct rte_mbuf *m, uint64x2_t *cmd0, uint64x2_t *cmd1,
 	tag = sa_base & 0xFFFFUL;
 	sa_base &= ~0xFFFFUL;
 	sa = (uintptr_t)roc_nix_inl_ot_ipsec_outb_sa(sa_base, sess_priv.sa_idx);
-	ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
+	ucode_cmd[3] = (ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
 	ucode_cmd[0] = (ROC_IE_OT_MAJOR_OP_PROCESS_OUTBOUND_IPSEC << 48 | 1UL << 54 |
 			((uint64_t)sess_priv.chksum) << 32 | ((uint64_t)sess_priv.dec_ttl) << 34 |
 			pkt_len);
@@ -687,7 +687,7 @@ cn10k_nix_prep_sec(struct rte_mbuf *m, uint64_t *cmd, uintptr_t *nixtx_addr,
 	tag = sa_base & 0xFFFFUL;
 	sa_base &= ~0xFFFFUL;
 	sa = (uintptr_t)roc_nix_inl_ot_ipsec_outb_sa(sa_base, sess_priv.sa_idx);
-	ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
+	ucode_cmd[3] = (ROC_LEGACY_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
 	ucode_cmd[0] = (ROC_IE_OT_MAJOR_OP_PROCESS_OUTBOUND_IPSEC << 48 | 1UL << 54 |
 			((uint64_t)sess_priv.chksum) << 32 | ((uint64_t)sess_priv.dec_ttl) << 34 |
 			pkt_len);
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index 8c3ba8326d..c419778970 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -533,7 +533,7 @@ cn20k_nix_prep_sec_vec(struct rte_mbuf *m, uint64x2_t *cmd0, uint64x2_t *cmd1,
 	tag = sa_base & 0xFFFFUL;
 	sa_base &= ~0xFFFFUL;
 	sa = (uintptr_t)roc_nix_inl_ot_ipsec_outb_sa(sa_base, sess_priv.sa_idx);
-	ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
+	ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE << 61 | 1UL << 60 | sa);
 	ucode_cmd[0] = (ROC_IE_OT_MAJOR_OP_PROCESS_OUTBOUND_IPSEC << 48 | 1UL << 54 |
 			((uint64_t)sess_priv.chksum) << 32 | ((uint64_t)sess_priv.dec_ttl) << 34 |
 			pkt_len);
@@ -671,7 +671,7 @@ cn20k_nix_prep_sec(struct rte_mbuf *m, uint64_t *cmd, uintptr_t *nixtx_addr, uin
 	tag = sa_base & 0xFFFFUL;
 	sa_base &= ~0xFFFFUL;
 	sa = (uintptr_t)roc_nix_inl_ot_ipsec_outb_sa(sa_base, sess_priv.sa_idx);
-	ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE_IE << 61 | 1UL << 60 | sa);
+	ucode_cmd[3] = (ROC_CPT_DFLT_ENG_GRP_SE << 61 | 1UL << 60 | sa);
 	ucode_cmd[0] = (ROC_IE_OT_MAJOR_OP_PROCESS_OUTBOUND_IPSEC << 48 | 1UL << 54 |
 			((uint64_t)sess_priv.chksum) << 32 | ((uint64_t)sess_priv.dec_ttl) << 34 |
 			pkt_len);
-- 
2.34.1


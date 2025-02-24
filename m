Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24934C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:41:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8BB54066E;
	Mon, 24 Feb 2025 10:40:09 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7D2BA40B95
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:40:08 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O5D0HQ020119
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 eTcLq4TNZv42D8NNRBitdCcjbWZH8U7xVUIKnSAhbs=; b=VsAvUy1VI4VBCuAn6
 uGtJKnKF16PEcPs3RzeVmS1RRgPpJqBnJTuDv2pAbmAmZgtGEA0qHpEMCAOHmjvY
 7zc7g5D3U6fLjjMw+zJfdcAvEcvofBKvB23JO1/b8yP85hxugwz+gTypmajCwyAC
 WKVqDMfXbYxJf+y6wEolKvqc1I0hQdPuL378KfxPJ7Fd3bp7saP+IMLdQxO7b1RL
 ck1vxxZHX2aiyhZXOgkCYKFFj/S9pHX7e4gX9H0JTLDYx9wYQMaiih61WnEwHddH
 CPNgBrDN04F3hniiafjoHNitCS3BAy6uZ3a02Pi1RLrB3M8eCdwOUBmCk9PJs999
 JmGkA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jg43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:07 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:06 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 3AC3D3F705D;
 Mon, 24 Feb 2025 01:40:03 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 15/33] common/cnxk: support inline SA context invalidate
Date: Mon, 24 Feb 2025 15:08:57 +0530
Message-ID: <20250224093915.1253215-15-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AwFRcJGqhkyE_IWKqTOjmBAarxQKwhyo
X-Proofpoint-ORIG-GUID: AwFRcJGqhkyE_IWKqTOjmBAarxQKwhyo
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

Add SA context invalidate support for cn20k.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/hw/cpt.h      | 11 ++++++++-
 drivers/common/cnxk/roc_nix.h     |  1 +
 drivers/common/cnxk/roc_nix_inl.c | 37 ++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index f2c222a920..40987abbb9 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -44,7 +44,8 @@
 #define CPT_LF_CTX_ENC_PKT_CNT	(0x540ull)
 #define CPT_LF_CTX_DEC_BYTE_CNT (0x550ull)
 #define CPT_LF_CTX_DEC_PKT_CNT	(0x560ull)
-#define CPT_LF_CTX_RELOAD	(0x570ull)
+#define CPT_LF_CTX_RELOAD	(0x570ull) /* [CN10k] */
+#define CPT_LF_CTX_INVAL	(0x570ull) /* [CN20k] */
 
 #define CPT_AF_LFX_CTL(a)  (0x27000ull | (uint64_t)(a) << 3)
 #define CPT_AF_LFX_CTL2(a) (0x29000ull | (uint64_t)(a) << 3)
@@ -126,6 +127,14 @@ union cpt_lf_ctx_reload {
 	} s;
 };
 
+union cpt_lf_ctx_inval {
+	uint64_t u;
+	struct {
+		uint64_t cptr : 46;
+		uint64_t reserved_46_63 : 18;
+	} s;
+};
+
 union cpt_lf_inprog {
 	uint64_t u;
 	struct cpt_lf_inprog_s {
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 15823ab16c..2597b8d56b 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -474,6 +474,7 @@ struct roc_nix {
 	bool custom_meta_aura_ena;
 	bool rx_inj_ena;
 	bool custom_inb_sa;
+	bool use_write_sa;
 	uint32_t root_sched_weight;
 	uint16_t inb_cfg_param1;
 	uint16_t inb_cfg_param2;
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index db1969038a..991a81b50d 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1744,6 +1744,7 @@ roc_nix_inl_sa_sync(struct roc_nix *roc_nix, void *sa, bool inb,
 	union cpt_lf_ctx_reload reload;
 	union cpt_lf_ctx_flush flush;
 	union cpt_lf_ctx_err err;
+	union cpt_lf_ctx_inval inval;
 	bool get_inl_lf = true;
 	uintptr_t rbase;
 	struct nix *nix;
@@ -1778,8 +1779,15 @@ roc_nix_inl_sa_sync(struct roc_nix *roc_nix, void *sa, bool inb,
 
 		flush.u = 0;
 		reload.u = 0;
+		inval.u = 0;
 		switch (op) {
 		case ROC_NIX_INL_SA_OP_FLUSH_INVAL:
+			if (!roc_model_is_cn10k()) {
+				inval.s.cptr = ((uintptr_t)sa) >> 7;
+				plt_write64(inval.u, rbase + CPT_LF_CTX_INVAL);
+				break;
+			}
+
 			flush.s.inval = 1;
 			/* fall through */
 		case ROC_NIX_INL_SA_OP_FLUSH:
@@ -1815,10 +1823,12 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 	struct nix_inl_dev *inl_dev = NULL;
 	struct roc_cpt_lf *outb_lf = NULL;
 	union cpt_lf_ctx_flush flush;
+	union cpt_lf_ctx_inval inval;
 	union cpt_lf_ctx_err err;
 	bool get_inl_lf = true;
 	uintptr_t rbase;
 	struct nix *nix;
+	uint64_t *sa;
 	int rc;
 
 	/* Nothing much to do on cn9k */
@@ -1850,7 +1860,10 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 			outb_lf = &inl_dev->cpt_lf[0];
 	}
 
-	if (outb_lf) {
+	if (outb_lf == NULL)
+		goto exit;
+
+	if (roc_model_is_cn10k() || roc_nix->use_write_sa) {
 		rbase = outb_lf->rbase;
 		flush.u = 0;
 
@@ -1869,7 +1882,29 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 		if (err.s.flush_st_flt)
 			plt_warn("CTX flush could not complete");
 		return 0;
+	} else {
+		sa = sa_dptr;
+
+		/* Clear bit 58 aop_valid */
+		sa[0] &= ~(1ULL << 58);
+		memcpy(sa_cptr, sa_dptr, sa_len);
+		plt_io_wmb();
+
+		/* Trigger CTX invalidate */
+		rbase = outb_lf->rbase;
+		inval.u = 0;
+		inval.s.cptr = ((uintptr_t)sa_cptr) >> 7;
+		plt_write64(inval.u, rbase + CPT_LF_CTX_INVAL);
+
+		/* Set bit 58 aop_valid */
+		sa = sa_cptr;
+		sa[0] |= (1ULL << 58);
+		plt_io_wmb();
+
+		return 0;
 	}
+
+exit:
 	plt_nix_dbg("Could not get CPT LF for CTX write");
 	return -ENOTSUP;
 }
-- 
2.34.1


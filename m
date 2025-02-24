Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F8C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:40:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE4FD40B9F;
	Mon, 24 Feb 2025 10:40:07 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 108C440669
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:40:05 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O514It009504
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 GSSe9inBdn78nXhoyfhi3RK48Li+r4KRfPdjoknlx4=; b=OWrvjPg2m2r9bK0/D
 Gh8iITApskJELRvalhF9WNejhkZPtAKkcPP8/xZGN/H5J8D3ez2D7D6HH32ui3Rf
 JmjorZ/5UlUI21Dotf/sX3bmW9jCe72zUWWRGtbJlC7qvAK7okDsTvzUQif/at5m
 5ShDZKEZzx5+YII6FpGNvHZ9YwIohFgTqAdVqx13fTyejBmlZ7osRwnI/lTSU5SR
 x1dByoVcCfossA0sUHKuy51fYNYWf9oa+35G7MwFyti1TL4/7EfGerPeuMZsPzR0
 j7hC6HXgysSgSHiKiR4R2WyXZRXDDQwTf/CE45NfTbeI0oTy9/xUoBnQt1WpCcmO
 JtQYQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbspsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:40:04 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:03 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 0388D3F705D;
 Mon, 24 Feb 2025 01:40:00 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 14/33] common/cnxk: support for inline IPsec for cn20k
Date: Mon, 24 Feb 2025 15:08:56 +0530
Message-ID: <20250224093915.1253215-14-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qMTI0GMhKxFJttZZDOeJtTnBjD_LGNC3
X-Proofpoint-ORIG-GUID: qMTI0GMhKxFJttZZDOeJtTnBjD_LGNC3
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

Support in NIX inline device for inbound and outbound SA init.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_cpt.h         |  1 +
 drivers/common/cnxk/roc_nix_inl.c     | 62 ++++++++++++++++++++++-----
 drivers/common/cnxk/roc_nix_inl_dev.c | 22 ++++++----
 drivers/common/cnxk/roc_nix_inl_dp.h  | 46 ++++++++++++++++++++
 drivers/net/cnxk/cn10k_rxtx.h         |  2 +
 drivers/net/cnxk/cn20k_rxtx.h         |  2 +
 6 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 238f55eff4..37634793d4 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -66,6 +66,7 @@
 
 #define ROC_CN20K_CPT_LMT_ARG	   ROC_CN10K_CPT_LMT_ARG
 #define ROC_CN20K_DUAL_CPT_LMT_ARG ROC_CN10K_DUAL_CPT_LMT_ARG
+#define ROC_CN20K_CPT_INST_DW_M1   ROC_CN10K_CPT_INST_DW_M1
 
 /* CPT helper macros */
 #define ROC_CPT_AH_HDR_LEN	12
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 6b7532b1f0..db1969038a 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -404,12 +404,14 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	max_sa = plt_align32pow2(ipsec_in_max_spi - ipsec_in_min_spi + 1);
 
 	/* CN9K SA size is different */
-	if (roc_model_is_cn9k())
-		inb_sa_sz = ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
-	else if (roc_nix->custom_inb_sa)
+	if (roc_nix->custom_inb_sa)
 		inb_sa_sz = ROC_NIX_INL_INB_CUSTOM_SA_SZ;
-	else
+	else if (roc_model_is_cn9k())
+		inb_sa_sz = ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
+	else if (roc_model_is_cn10k())
 		inb_sa_sz = ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
+	else
+		inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
 
 	/* Alloc contiguous memory for Inbound SA's */
 	nix->inb_sa_sz = inb_sa_sz;
@@ -420,10 +422,14 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 		plt_err("Failed to allocate memory for Inbound SA");
 		return -ENOMEM;
 	}
-	if (roc_model_is_cn10k()) {
+
+	if (!roc_model_is_cn9k()) {
 		for (i = 0; i < max_sa; i++) {
 			sa = ((uint8_t *)nix->inb_sa_base) + (i * inb_sa_sz);
-			roc_ot_ipsec_inb_sa_init(sa);
+			if (roc_model_is_cn10k())
+				roc_ot_ipsec_inb_sa_init(sa);
+			else
+				roc_ow_ipsec_inb_sa_init(sa);
 		}
 	}
 
@@ -841,7 +847,7 @@ nix_inl_eng_caps_get(struct nix *nix)
 			plt_err("LOAD FVC operation timed out");
 			return;
 		}
-	} else {
+	} else if (roc_model_is_cn10k()) {
 		uint64_t lmt_arg, io_addr;
 		uint16_t lmt_id;
 
@@ -870,6 +876,35 @@ nix_inl_eng_caps_get(struct nix *nix)
 			plt_err("LOAD FVC operation timed out");
 			goto exit;
 		}
+	} else {
+		uint64_t lmt_arg, io_addr;
+		uint16_t lmt_id;
+
+		hw_res->cn20k.compcode = CPT_COMP_NOT_DONE;
+
+		/* Use this reserved LMT line as no one else is using it */
+		lmt_id = roc_plt_control_lmt_id_get();
+		lmt_base += ((uint64_t)lmt_id << ROC_LMT_LINE_SIZE_LOG2);
+
+		memcpy((void *)lmt_base, &inst, sizeof(inst));
+
+		lmt_arg = ROC_CN20K_CPT_LMT_ARG | (uint64_t)lmt_id;
+		io_addr = lf->io_addr | ROC_CN20K_CPT_INST_DW_M1 << 4;
+
+		roc_lmt_submit_steorl(lmt_arg, io_addr);
+		plt_io_wmb();
+
+		/* Wait until CPT instruction completes */
+		do {
+			res.u64[0] = __atomic_load_n(&hw_res->u64[0], __ATOMIC_RELAXED);
+			if (unlikely(plt_tsc_cycles() > timeout))
+				break;
+		} while (res.cn20k.compcode == CPT_COMP_NOT_DONE);
+
+		if (res.cn20k.compcode != CPT_COMP_GOOD || res.cn20k.uc_compcode) {
+			plt_err("LOAD FVC operation timed out");
+			goto exit;
+		}
 	}
 
 	nix->cpt_eng_caps = plt_be_to_cpu_64(*rptr);
@@ -1127,8 +1162,11 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 	/* CN9K SA size is different */
 	if (roc_model_is_cn9k())
 		sa_sz = ROC_NIX_INL_ON_IPSEC_OUTB_SA_SZ;
-	else
+	else if (roc_model_is_cn10k())
 		sa_sz = ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ;
+	else
+		sa_sz = ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ;
+
 	/* Alloc contiguous memory of outbound SA */
 	sa_base = plt_zmalloc(sa_sz * roc_nix->ipsec_out_max_sa,
 			      ROC_NIX_INL_SA_BASE_ALIGN);
@@ -1136,10 +1174,14 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
 		plt_err("Outbound SA base alloc failed");
 		goto lf_fini;
 	}
-	if (roc_model_is_cn10k()) {
+
+	if (!roc_model_is_cn9k()) {
 		for (i = 0; i < roc_nix->ipsec_out_max_sa; i++) {
 			sa = ((uint8_t *)sa_base) + (i * sa_sz);
-			roc_ot_ipsec_outb_sa_init(sa);
+			if (roc_model_is_cn10k())
+				roc_ot_ipsec_outb_sa_init(sa);
+			else
+				roc_ow_ipsec_outb_sa_init(sa);
 		}
 	}
 	nix->outb_sa_base = sa_base;
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index da28b22bcc..b66c71bc29 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -402,7 +402,7 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 	mbox_put(mbox);
 
 	/* Get VWQE info if supported */
-	if (roc_model_is_cn10k()) {
+	if (!roc_model_is_cn9k()) {
 		mbox_alloc_msg_nix_get_hw_info(mbox_get(mbox));
 		rc = mbox_process_msg(mbox, (void *)&hw_info);
 		if (rc) {
@@ -422,12 +422,14 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 	}
 
 	/* CN9K SA is different */
-	if (roc_model_is_cn9k())
-		inb_sa_sz = ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
-	else if (inl_dev->custom_inb_sa)
+	if (inl_dev->custom_inb_sa)
 		inb_sa_sz = ROC_NIX_INL_INB_CUSTOM_SA_SZ;
-	else
+	else if (roc_model_is_cn9k())
+		inb_sa_sz = ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
+	else if (roc_model_is_cn10k())
 		inb_sa_sz = ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
+	else
+		inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
 
 	/* Alloc contiguous memory for Inbound SA's */
 	inl_dev->inb_sa_sz = inb_sa_sz;
@@ -440,11 +442,13 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 		goto unregister_irqs;
 	}
 
-	if (roc_model_is_cn10k()) {
+	if (!roc_model_is_cn9k()) {
 		for (i = 0; i < max_sa; i++) {
-			sa = ((uint8_t *)inl_dev->inb_sa_base) +
-			     (i * inb_sa_sz);
-			roc_ot_ipsec_inb_sa_init(sa);
+			sa = ((uint8_t *)inl_dev->inb_sa_base) + (i * inb_sa_sz);
+			if (roc_model_is_cn10k())
+				roc_ot_ipsec_inb_sa_init(sa);
+			else
+				roc_ow_ipsec_inb_sa_init(sa);
 		}
 	}
 	/* Setup device specific inb SA table */
diff --git a/drivers/common/cnxk/roc_nix_inl_dp.h b/drivers/common/cnxk/roc_nix_inl_dp.h
index a9d8e0a705..eb101db179 100644
--- a/drivers/common/cnxk/roc_nix_inl_dp.h
+++ b/drivers/common/cnxk/roc_nix_inl_dp.h
@@ -23,6 +23,24 @@
 	(ROC_NIX_INL_OT_IPSEC_OUTB_HW_SZ + ROC_NIX_INL_OT_IPSEC_OUTB_SW_RSVD)
 #define ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ_LOG2 9
 
+/* OW INB HW area */
+#define ROC_NIX_INL_OW_IPSEC_INB_HW_SZ PLT_ALIGN(sizeof(struct roc_ow_ipsec_inb_sa), ROC_ALIGN)
+
+/* OW INB SW reserved area */
+#define ROC_NIX_INL_OW_IPSEC_INB_SW_RSVD 128
+#define ROC_NIX_INL_OW_IPSEC_INB_SA_SZ                                                             \
+	(ROC_NIX_INL_OW_IPSEC_INB_HW_SZ + ROC_NIX_INL_OW_IPSEC_INB_SW_RSVD)
+#define ROC_NIX_INL_OW_IPSEC_INB_SA_SZ_LOG2 10
+
+/* OW OUTB HW area */
+#define ROC_NIX_INL_OW_IPSEC_OUTB_HW_SZ PLT_ALIGN(sizeof(struct roc_ow_ipsec_outb_sa), ROC_ALIGN)
+
+/* OW OUTB SW reserved area */
+#define ROC_NIX_INL_OW_IPSEC_OUTB_SW_RSVD 128
+#define ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ                                                            \
+	(ROC_NIX_INL_OW_IPSEC_OUTB_HW_SZ + ROC_NIX_INL_OW_IPSEC_OUTB_SW_RSVD)
+#define ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ_LOG2 9
+
 /* Alignment of SA Base */
 #define ROC_NIX_INL_SA_BASE_ALIGN BIT_ULL(16)
 
@@ -54,4 +72,32 @@ roc_nix_inl_ot_ipsec_outb_sa_sw_rsvd(void *sa)
 	return PLT_PTR_ADD(sa, ROC_NIX_INL_OT_IPSEC_OUTB_HW_SZ);
 }
 
+static inline struct roc_ow_ipsec_inb_sa *
+roc_nix_inl_ow_ipsec_inb_sa(uintptr_t base, uint64_t idx)
+{
+	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_INB_SA_SZ_LOG2;
+
+	return PLT_PTR_ADD(base, off);
+}
+
+static inline struct roc_ow_ipsec_outb_sa *
+roc_nix_inl_ow_ipsec_outb_sa(uintptr_t base, uint64_t idx)
+{
+	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ_LOG2;
+
+	return PLT_PTR_ADD(base, off);
+}
+
+static inline void *
+roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(void *sa)
+{
+	return PLT_PTR_ADD(sa, ROC_NIX_INL_OW_IPSEC_INB_HW_SZ);
+}
+
+static inline void *
+roc_nix_inl_ow_ipsec_outb_sa_sw_rsvd(void *sa)
+{
+	return PLT_PTR_ADD(sa, ROC_NIX_INL_OW_IPSEC_OUTB_HW_SZ);
+}
+
 #endif /* _ROC_NIX_INL_DP_H_ */
diff --git a/drivers/net/cnxk/cn10k_rxtx.h b/drivers/net/cnxk/cn10k_rxtx.h
index 98f9e2efa3..53a6fbd60d 100644
--- a/drivers/net/cnxk/cn10k_rxtx.h
+++ b/drivers/net/cnxk/cn10k_rxtx.h
@@ -38,6 +38,8 @@
 
 #include "roc_ie_ot.h"
 
+#include "roc_ie_ow.h"
+
 /* NIX Inline dev */
 #include "roc_nix_inl_dp.h"
 
diff --git a/drivers/net/cnxk/cn20k_rxtx.h b/drivers/net/cnxk/cn20k_rxtx.h
index 7aa06444e2..e40edba69d 100644
--- a/drivers/net/cnxk/cn20k_rxtx.h
+++ b/drivers/net/cnxk/cn20k_rxtx.h
@@ -38,6 +38,8 @@
 
 #include "roc_ie_ot.h"
 
+#include "roc_ie_ow.h"
+
 /* NIX Inline dev */
 #include "roc_nix_inl_dp.h"
 
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFDFC54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:52:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D869040B8C;
	Fri, 23 May 2025 15:52:16 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id ADDF240B8C
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9kvh030039
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 XD+H08OP7LhSep2nfLukNueYQgUNqVYoFM+3aLYVvA=; b=hcnEKr5hGKngWL2pl
 wvN1NwTJqS/ctuKTKlV8x9K1F3Ys9Oq7tPKitKgfrGCF/iYYHBE7qPfJ1OGEt8fM
 5e8I4jyogVz2jr5mZEAqWw5AC9lq4l60LRP0PmfgugmZtqYGKolIizLeFHQm+dOH
 DYyuRBJABZB3CK/9sbrdhVQHCYEbTKSxcQU2jJk/hDDpxZDyBTF9VYBTxzVfrgJz
 9rSuEjy+imWuhY+KJzgfou6XpduSs5kR940dKlHurZ4R08bLKZm7lR6rXkRZNeYt
 WmHw0hHweRxfA++fkc/KDBBtt+t+xOqNdmczRvB7AxyIBLEw8G9CG/V1wIHxUpW+
 t4xVg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:13 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id B18B13F704F;
 Fri, 23 May 2025 06:52:10 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 18/40] crypto/cnxk: move code to common
Date: Fri, 23 May 2025 19:20:49 +0530
Message-ID: <20250523135111.2178408-19-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307d8e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=bt4o1ddrjQzu6LX-iL8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXxKN8FhS1Jued
 EoOL0dJjAFOfXIACP8G8+U7TKqY2JP/dgXF9yHu/mV0VBY/+HZBlG3o/l2mdd8QheGBNhCMwsJt
 mGKx7X2KyS9ufvScH+WDcbYTaQi4rTFaXWL5sFmPUUSPJARUIAySHUEN3puMlBK13fLoA4QG4kG
 TpCN+qq4azUxzpO7kmydmBtmchS2zfnqT6QfoXwZFxw9abl1ruznbRkRNO2fIHt+E+PKmPr5NPA
 /9cnDCVmoGAS4pMuEbrvSKJQyivOBjQrWuw2JWuDS6oDb/LEd4pvUn6ynze2TyFAP+OJBFLI1hC
 tiJiQi3TR+LpnhZZxuCbtRDgUqClKhkhVO7QhgoVkp3bB0cwwXas6EG1ZcYPP+gDvVs8uTIEWqC
 BNFecm9ZsWCEBu8L7mExdxeKEsk6OeZWJyiwA2FJ6V32h3302HlTUG14xMnqOYoHSM135rTR
X-Proofpoint-GUID: VqaSg1Ds4RRhXbRQS_-RPK8dPNHAVs12
X-Proofpoint-ORIG-GUID: VqaSg1Ds4RRhXbRQS_-RPK8dPNHAVs12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Move common code between cn10k and cn20k to common

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_sec.h | 14 --------------
 drivers/crypto/cnxk/cn10k_ipsec.c         |  4 ++--
 drivers/crypto/cnxk/cn10k_tls.c           |  4 ++--
 drivers/crypto/cnxk/cn20k_ipsec.c         |  4 ++--
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h  | 17 +++++++++++++++++
 drivers/crypto/cnxk/cnxk_ipsec.h          |  1 +
 6 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_sec.h b/drivers/crypto/cnxk/cn10k_cryptodev_sec.h
index 77faaa0fe6..b07fbaf5ee 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_sec.h
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_sec.h
@@ -59,20 +59,6 @@ struct __rte_aligned(ROC_ALIGN) cn10k_sec_session {
 	};
 };
 
-static inline uint64_t
-cpt_inst_w7_get(struct roc_cpt *roc_cpt, void *cptr)
-{
-	union cpt_inst_w7 w7;
-
-	w7.u64 = 0;
-	w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_IE];
-	w7.s.ctx_val = 1;
-	w7.s.cptr = (uint64_t)cptr;
-	rte_mb();
-
-	return w7.u64;
-}
-
 void cn10k_sec_ops_override(void);
 
 #endif /* __CN10K_CRYPTODEV_SEC_H__ */
diff --git a/drivers/crypto/cnxk/cn10k_ipsec.c b/drivers/crypto/cnxk/cn10k_ipsec.c
index ae0482d0fe..5cd4f5257a 100644
--- a/drivers/crypto/cnxk/cn10k_ipsec.c
+++ b/drivers/crypto/cnxk/cn10k_ipsec.c
@@ -51,7 +51,7 @@ cn10k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 		goto sa_dptr_free;
 	}
 
-	sec_sess->inst.w7 = cpt_inst_w7_get(roc_cpt, out_sa);
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, out_sa);
 
 #ifdef LA_IPSEC_DEBUG
 	/* Use IV from application in debug mode */
@@ -183,7 +183,7 @@ cn10k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	sec_sess->ipsec.is_outbound = 0;
-	sec_sess->inst.w7 = cpt_inst_w7_get(roc_cpt, in_sa);
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, in_sa);
 
 	/* Save index/SPI in cookie, specific required for Rx Inject */
 	sa_dptr->w1.s.cookie = 0xFFFFFFFF;
diff --git a/drivers/crypto/cnxk/cn10k_tls.c b/drivers/crypto/cnxk/cn10k_tls.c
index 4bd2654499..49edac8cd6 100644
--- a/drivers/crypto/cnxk/cn10k_tls.c
+++ b/drivers/crypto/cnxk/cn10k_tls.c
@@ -690,7 +690,7 @@ cn10k_tls_read_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 	sec_sess->tls_opt.tls_ver = tls_ver;
 	sec_sess->inst.w4 = inst_w4.u64;
-	sec_sess->inst.w7 = cpt_inst_w7_get(roc_cpt, read_sa);
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, read_sa);
 
 	memset(read_sa, 0, sizeof(struct roc_ie_ot_tls_read_sa));
 
@@ -783,7 +783,7 @@ cn10k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 			ROC_IE_OT_TLS13_MAJOR_OP_RECORD_ENC | ROC_IE_OT_INPLACE_BIT;
 	}
 	sec_sess->inst.w4 = inst_w4.u64;
-	sec_sess->inst.w7 = cpt_inst_w7_get(roc_cpt, write_sa);
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, write_sa);
 
 	memset(write_sa, 0, sizeof(struct roc_ie_ot_tls_write_sa));
 
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index f898461523..049007803d 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -51,7 +51,7 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 		goto sa_dptr_free;
 	}
 
-	RTE_SET_USED(roc_cpt);
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, out_sa);
 
 #ifdef LA_IPSEC_DEBUG
 	/* Use IV from application in debug mode */
@@ -178,7 +178,7 @@ cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	sec_sess->ipsec.is_outbound = 0;
-	RTE_SET_USED(roc_cpt);
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, in_sa);
 
 	/* Save index/SPI in cookie, requirement for Rx Inject */
 	sa_dptr->w1.s.cookie = 0xFFFFFFFF;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 417b869828..df8d08b7c5 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -218,4 +218,21 @@ hw_ctx_cache_enable(void)
 	return roc_errata_cpt_hang_on_mixed_ctx_val() || roc_model_is_cn10ka_b0() ||
 	       roc_model_is_cn10kb_a0();
 }
+
+static inline uint64_t
+cnxk_cpt_sec_inst_w7_get(struct roc_cpt *roc_cpt, void *cptr)
+{
+	union cpt_inst_w7 w7;
+
+	w7.u64 = 0;
+	if (roc_model_is_cn20k())
+		w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_SE];
+	else
+		w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_IE];
+	w7.s.ctx_val = 1;
+	w7.s.cptr = (uint64_t)cptr;
+	rte_mb();
+
+	return w7.u64;
+}
 #endif /* _CNXK_CRYPTODEV_OPS_H_ */
diff --git a/drivers/crypto/cnxk/cnxk_ipsec.h b/drivers/crypto/cnxk/cnxk_ipsec.h
index 4d3ee23f61..42f8e64009 100644
--- a/drivers/crypto/cnxk/cnxk_ipsec.h
+++ b/drivers/crypto/cnxk/cnxk_ipsec.h
@@ -10,6 +10,7 @@
 #include "roc_cpt.h"
 #include "roc_ie_on.h"
 #include "roc_ie_ot.h"
+#include "roc_model.h"
 
 extern struct rte_security_ops cnxk_sec_ops;
 
-- 
2.25.1


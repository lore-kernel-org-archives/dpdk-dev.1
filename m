Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D6C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC7E840DC9;
	Tue, 27 May 2025 13:02:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 66E3E40A79
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:39 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6sniC019257
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 XB1doNGQgdYqKmQpOMKF7zNm+PukXMpzc1fQdxLYvY=; b=Kae2YGfDEimA6RQ0b
 mLxShZii+BlpoRRvDq5bzfBTP2Deksl8RDHtjN+sSURs8upaNYOvD+47NSKnEvaW
 aWzJYfEvsy1UC+MCn9D7uyrQBGGKKagS1SLwqkiHVk29JpwGINy2oH04aA5IUjWl
 fw1P4+f/8k/qQM9cFCvOZbT2GRLC+bBrXeqSfEZ6H6cg/F5mWSNQHLVVlMGxyb3O
 J3aRNsjess03ynRpoKIJvkxe4IWsOx+Xi+s46W3eARwUlLiNfa6wFZIG9S8Eaz+1
 QflyXz1/zMUn9C7FOyD7mNgsF1s0pDXq/zsAtz5KJuOOwRrr3q8zuPH+HiWoViEX
 JeVGg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w8hq8dpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:36 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C4FE93F7061;
 Tue, 27 May 2025 04:02:34 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 12/25] crypto/cnxk: move code to common
Date: Tue, 27 May 2025 16:31:52 +0530
Message-ID: <20250527110205.2300800-13-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX1bbnI0TOEG3V
 8Rpt5fxB8j9R/KsgNTJ1gnyySqkrvJwB287pOux2pIXHY+B3jTNHCfBcVcC7mKaoo3vrfcEqgns
 y7JAvC5izv4EvpLmJm9qVmHVjqHZGGecPfRGegjZdcItQLn9L9c7Dwmqv842f4y6P4UhF+Cs8Lt
 zAG4z/+hMkoG8wkqdiO7YZVXDDn5ghMMcQIxdalN7FEKxed77q7qCsPezrTewyWtuRop6wJEVRC
 Vh2ljw+j5Dq5h9fMNVmtkY0pJLg5zImfyI71y7DJiYNGAD0ThyeHqh0CzfM5C/wNFG/C3MZXC3M
 zJ+mFY/81CFOy2D1MZlvhzT1utDqs+ckMg6pFisgnqafa3LFOEyssaTOilqGmTpAfkLhI5iLhDD
 SWdcn6Sr8ZrpGu8zELo61uzfZNTL5HCTGoncGJH1pAXmtYdKKLEycS4tC+crIwnT/dMskKR2
X-Authority-Analysis: v=2.4 cv=D89HKuRj c=1 sm=1 tr=0 ts=68359bce cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=bt4o1ddrjQzu6LX-iL8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Zgilx0Li4Y0DA8xCgdBvKAoyf3VYjfvY
X-Proofpoint-ORIG-GUID: Zgilx0Li4Y0DA8xCgdBvKAoyf3VYjfvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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
index e19e080600..edb3462630 100644
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


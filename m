Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37CAC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2057B40689;
	Mon, 26 May 2025 18:59:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B778E40671
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:23 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QEwguu006948
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 XB1doNGQgdYqKmQpOMKF7zNm+PukXMpzc1fQdxLYvY=; b=JD+C9pKtpv79K2rGQ
 BVIsQ84Y/TNXL2QAZOCHUWDMxtnzyJubMcRQAFzwJg8/j46PUFtw/NwRwFEXU2A/
 xC4I4HWU+FHX/49zN/dx4RPL/HPyMoZ98AU0QByHFrVm01HamF7XKPVkoPB8pcYB
 JRUR+plswOYCMsykx71nD//QditPTbf7YKBN/RDLCYbQQPAP/bLRkdWnK6lZzkhE
 xXiWNyDDwB2kmmpXxmtghsS9AvJEdw4BX32osqSdkssEVirCBjB/y7zzGZKbaovk
 qbfBejsX/ar7uXwAenVlPdlNcZ8H2nq3bdfMXG1Zw7rBdCDi4Qrb+fjy2RQBSVVi
 OwVRw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vthfr6ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:21 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 487253F7048;
 Mon, 26 May 2025 09:59:19 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 18/40] crypto/cnxk: move code to common
Date: Mon, 26 May 2025 22:27:57 +0530
Message-ID: <20250526165819.2197892-19-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfX1W6OG76JEe9D
 9IEoHyUS9C5E1ag8hYbZjmDkt9urFN1wLyG4ttCTvcVnA1+ciLs+dk06U/HNAJRkHadFPb6jrWp
 MW54n1vXG9dfN+NsWfnmz10cX1cXy116LZEM0hiK8U/jJCO9TmzJBHD78AJgwWk2r8aKzlSkUql
 tNer+dSKqPC1WmO23GZWyIffjNdBaWNVlsiSHXx5OffW1o7pO3SOJEmy3Xc2w69v4LmmQDFhwCr
 bsYqd9bSozd4tDCIvIqBkOaU8QWZvignqLKYT+ugZBMxXatbtLUvnpN0r96dLzZRuTBeJxrxMtH
 E3cJnGTsUxhBBLP+Gq5E8RhF+MJEOGKRasotScAl2kAIvNiZdpkLeT3iQZnfC8J/USVex3YlQvZ
 oBTNs8Xz4Rao8m2AaeByGoNudpC4Eg3TtbRMWZbEYl9K6MqXR++9qBXDc8tfWAt1gNzNmQrS
X-Proofpoint-ORIG-GUID: GdqbFnrjvI3XzbUHsJjdItBEK6VlAMzi
X-Proofpoint-GUID: GdqbFnrjvI3XzbUHsJjdItBEK6VlAMzi
X-Authority-Analysis: v=2.4 cv=FfA3xI+6 c=1 sm=1 tr=0 ts=68349dea cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=bt4o1ddrjQzu6LX-iL8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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


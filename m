Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC953C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:55:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AC6D40E2A;
	Fri, 23 May 2025 15:53:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 78F1740EE5
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NDijsT016517
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 O7ZpH37342PJ1hUc9Is94ybaToxC+fJVvYuNiLsXfM=; b=Qq3wv4hdFw5dq3k10
 Hv/ocKt5ZlykDa7bDKbpVU+TOT75u9wbMBYSPwN8ZJgX4FVN5Z5XwBjoXJDvGQtw
 LfEtOKtF8guQdptcED3m7oOPc8v7QteGHfAgqEcFOxkc5RnMS8PDlYN8jesflfEa
 txqGOO2LITRsaag3HDOX2jvXBcB1eNgM7VzsfreFLwtJHXJAze+0PCtfRhEKEdu4
 ZhDl/wpHmvSBkI4S+kATiOGgI6L8iTbIOf84MnBTzZwxZHMrM8fyBMeFefU7bqtq
 Lilw39x1xYFdxJHaq3BwIO4SxffOD7/hia0rplrkNq+MEFc1Dao1if6MKw5RAgId
 W4atA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tmgp8suk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:56 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 7A3BC3F7041;
 Fri, 23 May 2025 06:52:53 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 31/40] crypto/cnxk: add model check for cn20k
Date: Fri, 23 May 2025 19:21:02 +0530
Message-ID: <20250523135111.2178408-32-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DsfduTxN1wm3yN5zHXz9F3StSJpAwFQM
X-Proofpoint-ORIG-GUID: DsfduTxN1wm3yN5zHXz9F3StSJpAwFQM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXz5+ClP+uFppX
 zPt1Ly4UCJ6eHFjRQ4zagEROZSucRkJK4OqMATdoYjKnb9Xb292g4zP8fmoOMApMxHIcIlWtI6g
 DMAjiG5wOab5fVSIzdgZX7XbLUiIcQarIXBTMabz3ZKjn2O5ngapnjVng3jmEcaF1x3Y8ygBg0z
 bT5CCcG6tr1x6Y0IQYmreQmrNDwAnATCieYDwqlEmCIOGDk1Ecj9vhM6A03BQu0CWDJg6u0YPQY
 XfxUP+zNPBbJBQvxTXw0qe0Qck14NYcbiJ7sJsHzAe+4NKHh803Th3/aENSdkFeUznBG/ZjLIrk
 MLtL/FU2YcRyGpioX5rt0A6Zr4YuPUQ/ma/e3CZp5xR0AfhWSQMiULlVKb8Q/wUrousHmtmCk/h
 SbLgHMnuBPs7ebpKCPGxYU/hkt9iq8aubOOWvscTYPd+EY8etzWC5e+1bWa4umbJVf4IWB6m
X-Authority-Analysis: v=2.4 cv=KYPSsRYD c=1 sm=1 tr=0 ts=68307db9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=zATx9W9L8u6M64y1SlQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Add model checks for cn20k.
Enable crypto and security capabilities for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev.c             | 14 ++++++++------
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c    | 10 +++++-----
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c         | 16 ++++++++++++----
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev.c b/drivers/crypto/cnxk/cnxk_cryptodev.c
index 1eede2e59c..96b5121097 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev.c
@@ -21,10 +21,10 @@ cnxk_cpt_default_ff_get(void)
 		      RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT | RTE_CRYPTODEV_FF_SYM_SESSIONLESS |
 		      RTE_CRYPTODEV_FF_DIGEST_ENCRYPTED | RTE_CRYPTODEV_FF_SECURITY;
 
-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		ff |= RTE_CRYPTODEV_FF_SECURITY_INNER_CSUM | RTE_CRYPTODEV_FF_SYM_RAW_DP;
 
-	if (roc_model_is_cn10ka_b0() || roc_model_is_cn10kb())
+	if (roc_model_is_cn10ka_b0() || roc_model_is_cn10kb() || roc_model_is_cn20k())
 		ff |= RTE_CRYPTODEV_FF_SECURITY_RX_INJECT;
 
 	return ff;
@@ -41,10 +41,12 @@ cnxk_cpt_eng_grp_add(struct roc_cpt *roc_cpt)
 		return -ENOTSUP;
 	}
 
-	ret = roc_cpt_eng_grp_add(roc_cpt, CPT_ENG_TYPE_IE);
-	if (ret < 0) {
-		plt_err("Could not add CPT IE engines");
-		return -ENOTSUP;
+	if (!roc_model_is_cn20k()) {
+		ret = roc_cpt_eng_grp_add(roc_cpt, CPT_ENG_TYPE_IE);
+		if (ret < 0) {
+			plt_err("Could not add CPT IE engines");
+			return -ENOTSUP;
+		}
 	}
 
 	ret = roc_cpt_eng_grp_add(roc_cpt, CPT_ENG_TYPE_AE);
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index 63d2eef349..d2747878d3 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -1976,16 +1976,16 @@ crypto_caps_populate(struct rte_cryptodev_capabilities cnxk_caps[],
 	CPT_CAPS_ADD(cnxk_caps, &cur_pos, hw_caps, kasumi);
 	CPT_CAPS_ADD(cnxk_caps, &cur_pos, hw_caps, des);
 
-	if (!roc_model_is_cn10k())
+	if (roc_model_is_cn9k())
 		cn9k_crypto_caps_add(cnxk_caps, &cur_pos);
 
-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		cn10k_crypto_caps_add(cnxk_caps, hw_caps, &cur_pos);
 
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_null, RTE_DIM(caps_null));
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_end, RTE_DIM(caps_end));
 
-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		cn10k_crypto_caps_update(cnxk_caps);
 }
 
@@ -2060,7 +2060,7 @@ sec_ipsec_crypto_caps_populate(struct rte_cryptodev_capabilities cnxk_caps[],
 	SEC_IPSEC_CAPS_ADD(cnxk_caps, &cur_pos, hw_caps, des);
 	SEC_IPSEC_CAPS_ADD(cnxk_caps, &cur_pos, hw_caps, sha1_sha2);
 
-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		cn10k_sec_ipsec_crypto_caps_update(cnxk_caps, &cur_pos);
 	else
 		cn9k_sec_ipsec_crypto_caps_update(cnxk_caps);
@@ -2189,7 +2189,7 @@ cnxk_cpt_caps_populate(struct cnxk_cpt_vf *vf)
 
 			cnxk_sec_ipsec_caps_update(&vf->sec_caps[i]);
 
-			if (roc_model_is_cn10k())
+			if (roc_model_is_cn10k() || roc_model_is_cn20k())
 				cn10k_sec_ipsec_caps_update(&vf->sec_caps[i]);
 
 			if (roc_model_is_cn9k())
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 982fbe991f..e5ca082e10 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -741,8 +741,10 @@ cnxk_cpt_inst_w7_get(struct cnxk_se_sess *sess, struct roc_cpt *roc_cpt)
 		inst_w7.s.cptr += 8;
 
 	/* Set the engine group */
-	if (sess->zsk_flag || sess->aes_ctr_eea2 || sess->is_sha3 || sess->is_sm3 ||
-	    sess->passthrough || sess->is_sm4)
+	if (roc_model_is_cn20k())
+		inst_w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_SE];
+	else if (sess->zsk_flag || sess->aes_ctr_eea2 || sess->is_sha3 || sess->is_sm3 ||
+		 sess->passthrough || sess->is_sm4)
 		inst_w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_SE];
 	else
 		inst_w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_IE];
@@ -1043,7 +1045,7 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_submit, 24.03)
 void
 rte_pmd_cnxk_crypto_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, uint16_t nb_inst)
 {
-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		return cnxk_crypto_cn10k_submit(qptr, inst, nb_inst);
 	else if (roc_model_is_cn9k())
 		return cnxk_crypto_cn9k_submit(qptr, inst, nb_inst);
@@ -1068,7 +1070,7 @@ rte_pmd_cnxk_crypto_cptr_flush(struct rte_pmd_cnxk_crypto_qptr *qptr,
 		return -EINVAL;
 	}
 
-	if (unlikely(!roc_model_is_cn10k())) {
+	if (unlikely(roc_model_is_cn9k())) {
 		plt_err("Invalid cnxk model");
 		return -EINVAL;
 	}
@@ -1106,6 +1108,12 @@ rte_pmd_cnxk_crypto_cptr_get(struct rte_pmd_cnxk_crypto_sess *rte_sess)
 	}
 
 	if (rte_sess->sess_type == RTE_CRYPTO_OP_SECURITY_SESSION) {
+		if (roc_model_is_cn20k()) {
+			struct cn20k_sec_session *sec_sess = PLT_PTR_CAST(rte_sess->sec_sess);
+
+			return PLT_PTR_CAST(&sec_sess->sa);
+		}
+
 		if (roc_model_is_cn10k()) {
 			struct cn10k_sec_session *sec_sess = PLT_PTR_CAST(rte_sess->sec_sess);
 			return PLT_PTR_CAST(&sec_sess->sa);
-- 
2.25.1


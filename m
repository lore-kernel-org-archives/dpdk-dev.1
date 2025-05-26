Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A32FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:03:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B5A840E44;
	Mon, 26 May 2025 19:00:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5838E40A71
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:35 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q9dLIm000432
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 g2MKDFY6GlCRp7vm4qlbM6VtWmtPMi3qZ/7B6O7Cnc=; b=ge2dIJzfwp+Sd+0U7
 B2jXLuJYNHU3Vz+ctqa7vUFICmxmJ2ywqJPhTHelwP7HahkyBua4sD8Y7WvbUKJL
 8B7C9lSMzb3p9uBY2LG97LmRBVBNgOTDY/qFhMpRvC00qpJiFJfKrAlvTzMocozw
 Z35XG9g+WnVXxZ4Wu/oshtGQaKTlt+ZYB9Txg0I5fP9c4qYWaxmBe81bngef65a9
 /tLfZlZb5az4VR8PvBVJdtsNIIId1mezRGWC1cbQlMiE+TXM3Z4bjhGYGzWu1uTm
 7d36OKUFgtS9C/HRjimeli0O6aj7O8T3ENVRICEESyAcNlwRP2M4dPHvr/v4+d44
 fHvHA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46vnv1gsvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:33 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id B03BD3F7064;
 Mon, 26 May 2025 10:00:30 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 40/40] crypto/cnxk: copy 8B iv into sess in aes ctr
Date: Mon, 26 May 2025 22:28:19 +0530
Message-ID: <20250526165819.2197892-41-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dvTk4chHfZNkOXTfefTwuO7JP51MRzK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX6wFL9LQ7H/Sk
 vhABvdSCNh4bg0w84kgtUbnidDt9FVkA14Qb28gAHhNPlcqBhiE81JGH9aEKo126pFuhjs3QVxb
 3GwmO9zUCuMr2k3E2OGqoQRZMMChxdeQHfnNNr6sGQuQ/yvnCITZe9SQxbn8e2Nskr1v+hzsrHP
 2xt6M+ydKOSnKAioTp6taCRJ3ar7G5VeIE5NORdCD9/8kXz/8IXQvMFfbXoKoDfqC45ZpF9hxNn
 ofHxhyxaSABs2S25BX5ScKj+2df8VBl5i43UTTYJ7Or0VLtScAydNDte5+oMu8P3BujrSKb59H0
 jW//oxCuA/EeTaw+60stKLSiU9EmVSeJXZW6dJkDW7DjQylPe7T9qQQtsIzZbgV1+Dwe582aoUE
 Bb8xmLjtpA/ZQIu21g71j9EixiQLB0Gt42vjytBaHIbVOJ2ybRA12Efm+QZH4qONm/qRAn56
X-Proofpoint-ORIG-GUID: dvTk4chHfZNkOXTfefTwuO7JP51MRzK_
X-Authority-Analysis: v=2.4 cv=PPgP+eqC c=1 sm=1 tr=0 ts=68349e32 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=qN3dD7gEgtA7HWq_RrcA:9
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Copy 8 bytes of the IV into the iv field within the
session for the AES CTR algorithm.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/crypto/cnxk/cn10k_ipsec_la_ops.h | 7 ++++---
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
index 0cc6283c7e..b9122a509a 100644
--- a/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
@@ -32,7 +32,7 @@ ipsec_po_sa_iv_set(struct cn10k_sec_session *sess, struct rte_crypto_op *cop)
 }
 
 static inline void
-ipsec_po_sa_aes_gcm_iv_set(struct cn10k_sec_session *sess, struct rte_crypto_op *cop)
+ipsec_po_sa_aes_8b_iv_set(struct cn10k_sec_session *sess, struct rte_crypto_op *cop)
 {
 	uint8_t *iv = &sess->sa.out_sa.iv.s.iv_dbg1[0];
 	uint32_t *tmp_iv;
@@ -63,8 +63,9 @@ process_outb_sa(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k_s
 	if (sess->sa.out_sa.w2.s.iv_src == ROC_IE_OT_SA_IV_SRC_FROM_SA) {
 		if (sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
 		    sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
-		    sess->sa.out_sa.w2.s.auth_type == ROC_IE_SA_AUTH_AES_GMAC)
-			ipsec_po_sa_aes_gcm_iv_set(sess, cop);
+		    sess->sa.out_sa.w2.s.auth_type == ROC_IE_SA_AUTH_AES_GMAC ||
+		    sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_CTR)
+			ipsec_po_sa_aes_8b_iv_set(sess, cop);
 		else
 			ipsec_po_sa_iv_set(sess, cop);
 	}
diff --git a/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
index 505fddb517..2f860c1855 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
@@ -31,7 +31,7 @@ ipsec_po_sa_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
 }
 
 static inline void
-ipsec_po_sa_aes_gcm_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
+ipsec_po_sa_aes_8b_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
 {
 	uint8_t *iv = &sess->sa.out_sa.iv.s.iv_dbg1[0];
 	uint32_t *tmp_iv;
@@ -62,8 +62,9 @@ process_outb_sa(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn20k_s
 	if (sess->sa.out_sa.w2.s.iv_src == ROC_IE_OW_SA_IV_SRC_FROM_SA) {
 		if (sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
 		    sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
-		    sess->sa.out_sa.w2.s.auth_type == ROC_IE_SA_AUTH_AES_GMAC)
-			ipsec_po_sa_aes_gcm_iv_set(sess, cop);
+		    sess->sa.out_sa.w2.s.auth_type == ROC_IE_SA_AUTH_AES_GMAC ||
+		    sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_CTR)
+			ipsec_po_sa_aes_8b_iv_set(sess, cop);
 		else
 			ipsec_po_sa_iv_set(sess, cop);
 	}
-- 
2.25.1


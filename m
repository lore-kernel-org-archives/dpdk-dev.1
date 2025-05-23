Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD6AC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF4B440ECF;
	Fri, 23 May 2025 15:53:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1A042410F1
 for <dev@dpdk.org>; Fri, 23 May 2025 15:53:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NDijsi016517
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 g2MKDFY6GlCRp7vm4qlbM6VtWmtPMi3qZ/7B6O7Cnc=; b=T0yS/WcpmWPNIWe2y
 tIAoevmPMFTqZipQ+IaHiQILAB9UCRDBtLDhpYbwtf1MHfycTnbCh/1qDSxYeuwE
 0MfVLS0CxObPwNNWzHJLpN06LTNX6F5Ck3CB0L77T1KR80LQrwvWMblIKTllV5XK
 0snStwcqnr+ttqilbWhcnZEAJovBzDWNKWb0YRkDIDBHyg4thYC4AVUgaEUfaOaK
 Vgkfz5uVrMImMYsFVZLawA01RmRlLElO8ai/gUcVwsB9cShED8GKyziR1MukvWa9
 6Y4puW+/jsurGDDoI+ol5N+4sDajj22an9oc4L7eTNahjF0r5j/IwOjq5JnDLmIl
 iDHWA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tmgp8sye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:53:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:53:25 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 689883F7041;
 Fri, 23 May 2025 06:53:22 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 40/40] crypto/cnxk: copy 8B iv into sess in aes ctr
Date: Fri, 23 May 2025 19:21:11 +0530
Message-ID: <20250523135111.2178408-41-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3jmy_fQMA1j_ziPz2dRnFjjfcxyWigQn
X-Proofpoint-ORIG-GUID: 3jmy_fQMA1j_ziPz2dRnFjjfcxyWigQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX/J7p8Z7wDe7B
 1CN3OMmwdl4HrkjuuhJAO2usJ1yanWQ79T9E5uKhavePsvE7OH8wsJj4y6MR4rtXJccnPdbeG7L
 RRKljAMjrFxXBSeTARJsLd8NCY568vmGX0BOMTkYu7OP4qKGLTW6hkGQXw/ORn0ydSZoSBWWjra
 IqIrNSjHYbZFIWgZg8128XN95glOjAdVH5nshYUnM9735jWWH6gI/aFAKv3uob+JbAnqX7nR5ae
 n/6aF6A8Bv0fgMBq0Injl+zXZTy2/HE2ILfmlvVce1SpdYiSJOz9AvTijaMyhC7Jr7s3QnjHms0
 i5aHe770z0aZqIhMZ9QDwJ1M8x0Uj8/lqZ+aqJgFM6H0vObA5P2b9kSLszA+GDM22ufnP+jovoB
 oIWxjQLO1ZzUypXUvyrwweOFMn0F2j90eoKyv6ehRUug4fiNKqEqSDEpxMDxPqcU1HptVGOB
X-Authority-Analysis: v=2.4 cv=KYPSsRYD c=1 sm=1 tr=0 ts=68307dd6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=qN3dD7gEgtA7HWq_RrcA:9
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


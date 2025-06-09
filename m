Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C7C61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:41:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7472540EA5;
	Mon,  9 Jun 2025 12:41:06 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 18C4A40E54
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:41:04 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597oNtR022069
 for <dev@dpdk.org>; Mon, 9 Jun 2025 03:41:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 g2MKDFY6GlCRp7vm4qlbM6VtWmtPMi3qZ/7B6O7Cnc=; b=GvAcY65M2wRZN9dVT
 l8l3dYsasdEHki7Q0rVOnzS4roVQh3YSJojmbjgyPu2cfXmo27uMwCAPyPos+O4v
 hSEM6fPPutfw+xc1TdL7p7kkzuks11sIN3t9bCj49AtHJ60Bbi76Xxeoo2eo9oyH
 eQZZ4PRFSk2sgBtWNNtyiQpqnEfB9HQIWRufo8hpRc56igLlrJcOQ128j38Uc/JB
 ZXnpLmToS9miHYS2v4+uIFMd5jyUGQDrnOQWLiSLQMKF+hT9d1bZnEEkPhNeTlco
 1JWm1YQhLB40dFxmD/Vw+ukPu23WzR+NfF8Ptu+gBHeyavJgDJw8rh4FZ2EV2Paq
 0ulHw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475ujxr99k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 09 Jun 2025 03:41:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 03:41:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 03:41:03 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 8C8B53F707D;
 Mon,  9 Jun 2025 03:41:00 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 7/7] crypto/cnxk: copy 8B iv into sess in aes ctr
Date: Mon, 9 Jun 2025 16:10:38 +0530
Message-ID: <20250609104038.3102767-8-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609104038.3102767-1-ktejasree@marvell.com>
References: <20250609104038.3102767-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ngy_ZUJcisVzcMcJWyBZkRyI_1qQzRHc
X-Proofpoint-ORIG-GUID: ngy_ZUJcisVzcMcJWyBZkRyI_1qQzRHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MSBTYWx0ZWRfX213PswtBbB0P
 P0G0y3i37UL5PzHPqAnVDEdjyEW7Sx+vshWcVqf4Cfh2oQnYR4rvqgHWc+9/PPgDUUt0LNlm+h5
 1hWCoA3sdsca2pL352hH2TZstRmpHQqQMtjDddc69NV4iSloEoAziNfOV/7peGbzrjYUc+XrWin
 BwIt5j8Hu0sXaU9xO0IIn1auDrtWb5+Gky6zx5LQ7JmYiGSEgLlexrCjWaaz8sk9RNtUGadkJ5G
 lSxV4xwR4svqwwtTXsJQWrptDHvGUVIh2covL/bcYDx7tXLlwFxvICD0dq8T9zzoZ0qzrpBD6Jp
 hEQl8FxhoysAQQ95iZ6S8r7yLHtUftDv4g5sRvjCUPL0K0OtNAYkCQygN4C/14+cYBJ+9en58MB
 bdaVHE/vjUBHVgt5qu2Wc6Nh+vRkIvaZiqVzp1/61Lu+n+VWOAm/CjUvCGICgpUICPUVsHFv
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=6846ba40 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=qN3dD7gEgtA7HWq_RrcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
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


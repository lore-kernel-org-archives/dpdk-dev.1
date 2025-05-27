Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DCAC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:02:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C05D140B94;
	Tue, 27 May 2025 15:02:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4C51A406BB
 for <dev@dpdk.org>; Tue, 27 May 2025 15:02:07 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsgS001051
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 g2MKDFY6GlCRp7vm4qlbM6VtWmtPMi3qZ/7B6O7Cnc=; b=S3JZl1bIkWPUmgxZO
 bz3PQC4zX4C4zNRxxPwuMoAV8/v8FwzlodJxG9FPoxfwXUgHKtTJsqBoJTMKMi9w
 UpcxNdu3OB9SE9nw5ZUjvrmGOPqD46Ajz+62OvNX/SIywfjsH/+SSAu9RkyuxGvC
 cayyj+JndXIgc4E7ZG/DAGQcoNU3RYbtDexSSbM4t7jPzJzkJpuqtEuYDKS4AcQv
 Jika7LDPBTHWplU5T/T7/J1VU6VqP9JyaXuun4IbHoQ7SZlJe6NeN1IKNKp79VpZ
 yAH2d1eHThM13juxabXqPTWXc3lSSgFG5y9tfuMhGYjk3e8qOtOLQaFkryB9cK2S
 7pYxw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21299pu-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:02:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:02:04 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 0F9793F705D;
 Tue, 27 May 2025 06:02:01 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 9/9] crypto/cnxk: copy 8B iv into sess in aes ctr
Date: Tue, 27 May 2025 18:31:35 +0530
Message-ID: <20250527130135.2301726-10-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527130135.2301726-1-ktejasree@marvell.com>
References: <20250527130135.2301726-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=6835b7ce cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=qN3dD7gEgtA7HWq_RrcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: dAewT9ifKdvfkJGoW2r_BzPivm-Ysw6S
X-Proofpoint-ORIG-GUID: dAewT9ifKdvfkJGoW2r_BzPivm-Ysw6S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfX2kkVBTm7brqP
 CtKZFiTUJHBOVDPeg/5ljtyyV5tuH6iI6KCEd/msX+uMFympaLPPGEf4ZrnxmuoDXyKJ9FslesX
 bfA3HDkO9WU5hwcbrJ3IGhf0a+Ig31BTAezgSRqOZ8FFNvOwpQmzQ2D/WqVXvnfNu5nPfTN+nKK
 B4B4P6+heqtMDcheKrtHkIbhzbejh9YtoX0cMz4l34bgDE0jvW5cQd5uX9vLufeQmvHYsJZKsjp
 YfdupLiyxTi8Rg20Q2ZcrbB2vXka2pu3U5NS18CgxiVyPWdyTF6ap7LcHFzDetRX+v4CdnvS3Xq
 FsQnFRFzEZ/eg7iK9kDvVZT5915A57COZFd0fiQkRs/5I7NFMUDW7yoew9iJnziGzJlmtq1QH75
 UwG5JGVPe6PQHLEY6cg9F8BJffdUL7rL7+HO9YAujeLZrav2gRL2pVjPJS66wmZaKvX84OGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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


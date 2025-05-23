Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D286EC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96DE540DD2;
	Fri, 23 May 2025 15:52:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 18087406B8
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:25 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8S8006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 zQ9a0Bgsislq3LpLz8mCRaAgOJkm/lRRe7BjOntwBE=; b=XiUhS//Kwet7J1P+B
 QhRqe9a14e1TzcaV1WVIUpd76SCflzrW5CslVcDhcnhcSU4oXvYjpgVhQtbf92Ln
 bOljbPynM3AsI2n+KwKTEMpF4rleQzO6cHZSlAcG/jtEcK57k2Wl5JfJLJny1tNJ
 gTN4eNEqhfaGiH2G5kHTnb9lKzIgUUrsb/QzcZFCXwdoBVeAAzWdzUJ5YmSB7gsR
 gfGZH7mfDW+YXKXS/W578u7dzi5UXeTltSoIOKezlp2/R5S5Rza/T0jHRJ5DymnM
 u9bVOu/VnNodTzJTduZNzwG9SK29FQDb2/MX6tHQClbkp0+7eeTY0BV5HE7wQ0RO
 Hzlig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:34 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id E15E53F704F;
 Fri, 23 May 2025 06:51:31 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 06/40] crypto/cnxk: enable IV from application support
Date: Fri, 23 May 2025 19:20:37 +0530
Message-ID: <20250523135111.2178408-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXwAYSSFOmIrXA
 AGZCO6z9iYFPtvWr3AcQM7iF3du3Egbm8mDnwCl1H9szDIBTFRJpPqTKLC43Jrh3RLW/bBobtmi
 WyMWp/0bbmhazUzofVa3IhzsandsVNGnFZotnkve+Slq7ng9DSoA44CRiWTW5oGiom59ppJNPj9
 SYmmY2nf9YIgzBrEAVRaYC1F44pFgqHiFbWpOGcElvxWlj6LFMOT1IxGpvvZBFG/JoKRyOtDg0q
 Nf5u1Jjs0BKH6scZ3ZjSy1XrJLQvlR9D6d6F0x0R18TQrg8cDxpEfTia/cGMVk4VPrcgicWqzi/
 kKiJ3MBDzQu+/tlN6zGsEwlGB3byf2JzqPkylcfqcVG8+FWnyYOvvTCaN95SuiGkCw+/joehOGH
 Okqlnqrq13/+Jz2Rk/YXJ7npWepITBnuIGqigg9PFBFRqKYhH2hr5JgwChQFAoehlUzA6rFG
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d98 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=wYxiG_oPtXBE3MfwHpYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Vd78ZV9qZld9Nr7sUy5UqjguB0esOhoz
X-Proofpoint-ORIG-GUID: Vd78ZV9qZld9Nr7sUy5UqjguB0esOhoz
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

Enabling IV from application as the default option.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cn9k_ipsec.c              | 19 +------------------
 drivers/crypto/cnxk/cn9k_ipsec_la_ops.h       |  5 +----
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |  6 ++----
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/cnxk/cn9k_ipsec.c b/drivers/crypto/cnxk/cn9k_ipsec.c
index fa00c428e6..62478d2340 100644
--- a/drivers/crypto/cnxk/cn9k_ipsec.c
+++ b/drivers/crypto/cnxk/cn9k_ipsec.c
@@ -48,11 +48,8 @@ cn9k_ipsec_outb_sa_create(struct cnxk_cpt_qp *qp,
 	if (ret)
 		return ret;
 
-	sess->custom_hdr_len =
-		sizeof(struct roc_ie_on_outb_hdr) - ROC_IE_ON_MAX_IV_LEN;
+	sess->custom_hdr_len = sizeof(struct roc_ie_on_outb_hdr) - ROC_IE_ON_MAX_IV_LEN;
 
-#ifdef LA_IPSEC_DEBUG
-	/* Use IV from application in debug mode */
 	if (ipsec->options.iv_gen_disable == 1) {
 		sess->custom_hdr_len = sizeof(struct roc_ie_on_outb_hdr);
 
@@ -67,12 +64,6 @@ cn9k_ipsec_outb_sa_create(struct cnxk_cpt_qp *qp,
 			sess->cipher_iv_len = crypto_xform->auth.iv.length;
 		}
 	}
-#else
-	if (ipsec->options.iv_gen_disable != 0) {
-		plt_err("Application provided IV is not supported");
-		return -ENOTSUP;
-	}
-#endif
 
 	ret = cnxk_on_ipsec_outb_sa_create(ipsec, crypto_xform, &sa->out_sa);
 
@@ -89,16 +80,8 @@ cn9k_ipsec_outb_sa_create(struct cnxk_cpt_qp *qp,
 	param1.u16 = 0;
 	param1.s.ikev2 = 1;
 
-#ifdef LA_IPSEC_DEBUG
-	/* Use IV from application in debug mode */
 	if (ipsec->options.iv_gen_disable == 1)
 		param1.s.per_pkt_iv = ROC_IE_ON_IV_SRC_FROM_DPTR;
-#else
-	if (ipsec->options.iv_gen_disable != 0) {
-		plt_err("Application provided IV is not supported");
-		return -ENOTSUP;
-	}
-#endif
 
 	w4.s.param1 = param1.u16;
 
diff --git a/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h
index 3e9f1e7efb..befd5b0c05 100644
--- a/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h
@@ -159,13 +159,10 @@ process_outb_sa(struct cpt_qp_meta_info *m_info, struct rte_crypto_op *cop,
 		inst->w4.s.opcode_major |= (uint64_t)ROC_DMA_MODE_SG;
 	}
 
-#ifdef LA_IPSEC_DEBUG
 	if (sess->inst.w4 & ROC_IE_ON_PER_PKT_IV) {
-		memcpy(&hdr->iv[0],
-		       rte_crypto_op_ctod_offset(cop, uint8_t *, sess->cipher_iv_off),
+		memcpy(&hdr->iv[0], rte_crypto_op_ctod_offset(cop, uint8_t *, sess->cipher_iv_off),
 		       sess->cipher_iv_len);
 	}
-#endif
 
 	m_src->pkt_len = pkt_len;
 	esn = ++sess->esn;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index e78bc37c37..63d2eef349 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -2102,11 +2102,9 @@ cn10k_sec_ipsec_caps_update(struct rte_security_capability *sec_cap)
 static void
 cn9k_sec_ipsec_caps_update(struct rte_security_capability *sec_cap)
 {
-	if (sec_cap->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS) {
-#ifdef LA_IPSEC_DEBUG
+	if (sec_cap->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS)
 		sec_cap->ipsec.options.iv_gen_disable = 1;
-#endif
-	}
+
 	sec_cap->ipsec.replay_win_sz_max = CNXK_ON_AR_WIN_SIZE_MAX;
 	sec_cap->ipsec.options.esn = 1;
 }
-- 
2.25.1


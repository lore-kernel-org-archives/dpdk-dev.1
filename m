Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1213DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 16:59:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7062B4068E;
	Mon, 26 May 2025 18:58:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DE04540689
 for <dev@dpdk.org>; Mon, 26 May 2025 18:58:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QGv80m007027
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 zQ9a0Bgsislq3LpLz8mCRaAgOJkm/lRRe7BjOntwBE=; b=I3oqyzK4paxAivr7q
 mEBJryALQA+r1OBWS33orbm2x3M0Tz+LQh/Xh6EAyL4UF1YrHWj9N+if8NUY0tVk
 +gWSufK5syod0IMPAVTx8rVrJZk/7bQquus91eg+zSfiAzKYAuCLS2oV6K9h/xsR
 UaK0m0JE7eOvH4HTvFQvGOMyfwS1+0nmxB7UrmbZdc4ZdD3TWeo/8w98g+0abx+y
 5zy8UBuQZbbfJr5+zlqMlKfrkOduC5OrrVfO0gWeYMabG/FxZBdTCCMX3qWZ8mSY
 cwmYKJ+ptvN8jnVmmAMS9ABeAkj+9kDocQdnAElQ0mw2qesOqaaoTFlNAnrtpJFb
 u7Z5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46vnv1gsn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:58:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:58:43 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 940F13F7063;
 Mon, 26 May 2025 09:58:40 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 06/40] crypto/cnxk: enable IV from application support
Date: Mon, 26 May 2025 22:27:45 +0530
Message-ID: <20250526165819.2197892-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MgFysW5wRSGOL6Etx7Y6EgXzTt5i1Jww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfX6s49Hpj/iiJ6
 Tjulqm1o4W8+Jlki1FboQW4IRHMH5JUrGsueHgiSGo0qOVDCJ0wiGG434taPRIexmYGD53YV8Tr
 7dwQb2zq6ozgqMRKaKKVNf/73BvXNbW1HNKTEGjHm+KzI5LoiawIskZbF+6f/4LVfLvH4wpqHma
 LiMa/faBaT90ZLMxQqdDcXMV8rZjYQncqAmtEGrODBbQEmeurs/Blh689azGAzYmC/P6DynIsyS
 K1Dkk5Wg4HRyeEamPR103HS1dBWN9U1ZNC3jhT1Ciku1MTVi8zuWn6dFIwAjjJhZv35/WeX5KPc
 u0zdi6erB/gGQAWD7e3FNVWtO1XKViYC6+lpSHLjrBYydRC6YJL6Jt7M6FO0cJkFDmT0NDKc6YW
 3PnPXbQrnD0Fb0kAsf/KNtxczRRBt7gPkOoZttekz5Rnwdj/MSsC6GpHBrXoQrQAZwcdxvAF
X-Proofpoint-ORIG-GUID: MgFysW5wRSGOL6Etx7Y6EgXzTt5i1Jww
X-Authority-Analysis: v=2.4 cv=PPgP+eqC c=1 sm=1 tr=0 ts=68349dc4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=wYxiG_oPtXBE3MfwHpYA:9
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


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F212C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:39:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE0CB4066E;
	Mon, 24 Feb 2025 10:39:28 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 065B540669
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:39:26 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O515Gj009516
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
 6kMpuymLhoegBpDs5VCCCN8Iw+2wAvgGyeMxabaBww=; b=e0X917FZjVVFVzkMZ
 L+v4Jauf0zyT1jy49FnUDvmfeNNeNsQCYLNhHJc18U0A7+ywINOJGNIYAZB0tM3b
 h5oBkPsOJF+Dei5zP76dEBONMxdHla+j5EAt9N+AH7f1jogtJLh+4Jp6LFfb4QQW
 3Vf+6xSXeZM6lSkv+B2pNF3yry4HfKrNIVpme0PJ3AKRqJg4oCSQshWoAbrE+yjE
 NwAYl17mXtkBFlaLK7hlkjRgSDNUYgtb70BabYXBMPbqsSHnr3Isdc8KqYLt1gM4
 mv80YO3ytIyQWhsIXQ8Ux24MwmpbQmIkZatb+yIQ9Xhd6YB3psGTTudZ3K4fi3v8
 sfnIg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbspqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:26 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:39:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:39:24 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 679103F705D;
 Mon, 24 Feb 2025 01:39:21 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Ankur Dwivedi" <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 "Tejasree Kondoj" <ktejasree@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 02/33] common/cnxk: remove unused param in SA init
Date: Mon, 24 Feb 2025 15:08:44 +0530
Message-ID: <20250224093915.1253215-2-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6FwODcnJOCpcXqfyE9p7ZUvrUAxwoz_i
X-Proofpoint-ORIG-GUID: 6FwODcnJOCpcXqfyE9p7ZUvrUAxwoz_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Anoob Joseph <anoobj@marvell.com>

Remove unused param in SA init.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c   | 5 ++---
 drivers/common/cnxk/cnxk_security.h   | 3 +--
 drivers/common/cnxk/roc_ie_ot.c       | 4 +---
 drivers/common/cnxk/roc_ie_ot.h       | 3 +--
 drivers/common/cnxk/roc_nix_inl.c     | 2 +-
 drivers/common/cnxk/roc_nix_inl_dev.c | 2 +-
 drivers/crypto/cnxk/cn10k_ipsec.c     | 5 ++---
 drivers/net/cnxk/cn10k_ethdev_sec.c   | 8 +++-----
 8 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 9446c14ac8..8953e901a1 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -304,8 +304,7 @@ ot_ipsec_inb_tunnel_hdr_fill(struct roc_ot_ipsec_inb_sa *sa,
 int
 cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
-			  struct rte_crypto_sym_xform *crypto_xfrm,
-			  bool is_inline)
+			  struct rte_crypto_sym_xform *crypto_xfrm)
 {
 	uint16_t sport = 4500, dport = 4500;
 	union roc_ot_ipsec_sa_word2 w2;
@@ -314,7 +313,7 @@ cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 	int rc;
 
 	/* Initialize the SA */
-	roc_ot_ipsec_inb_sa_init(sa, is_inline);
+	roc_ot_ipsec_inb_sa_init(sa);
 
 	w2.u64 = 0;
 	rc = ot_ipsec_sa_common_param_fill(&w2, sa->cipher_key, sa->w8.s.salt,
diff --git a/drivers/common/cnxk/cnxk_security.h b/drivers/common/cnxk/cnxk_security.h
index 19eb9bb03d..cd78b283f0 100644
--- a/drivers/common/cnxk/cnxk_security.h
+++ b/drivers/common/cnxk/cnxk_security.h
@@ -39,8 +39,7 @@ cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
 int __roc_api
 cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
-			  struct rte_crypto_sym_xform *crypto_xfrm,
-			  bool is_inline);
+			  struct rte_crypto_sym_xform *crypto_xfrm);
 int __roc_api
 cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
diff --git a/drivers/common/cnxk/roc_ie_ot.c b/drivers/common/cnxk/roc_ie_ot.c
index 1b436dba72..b906834672 100644
--- a/drivers/common/cnxk/roc_ie_ot.c
+++ b/drivers/common/cnxk/roc_ie_ot.c
@@ -6,7 +6,7 @@
 #include "roc_priv.h"
 
 void
-roc_ot_ipsec_inb_sa_init(struct roc_ot_ipsec_inb_sa *sa, bool is_inline)
+roc_ot_ipsec_inb_sa_init(struct roc_ot_ipsec_inb_sa *sa)
 {
 	size_t offset;
 
@@ -18,8 +18,6 @@ roc_ot_ipsec_inb_sa_init(struct roc_ot_ipsec_inb_sa *sa, bool is_inline)
 	sa->w0.s.et_ovrwr = 1;
 	sa->w2.s.l3hdr_on_err = 1;
 
-	PLT_SET_USED(is_inline);
-
 	offset = offsetof(struct roc_ot_ipsec_inb_sa, ctx);
 	sa->w0.s.hw_ctx_off = offset / ROC_CTX_UNIT_8B;
 	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off + 1;
diff --git a/drivers/common/cnxk/roc_ie_ot.h b/drivers/common/cnxk/roc_ie_ot.h
index 1420e3d586..26616be901 100644
--- a/drivers/common/cnxk/roc_ie_ot.h
+++ b/drivers/common/cnxk/roc_ie_ot.h
@@ -554,7 +554,6 @@ PLT_STATIC_ASSERT(offsetof(struct roc_ot_ipsec_outb_sa, ctx) ==
 #define ROC_OT_IPSEC_SA_SZ_MAX \
 	(PLT_MAX(sizeof(struct roc_ot_ipsec_inb_sa), sizeof(struct roc_ot_ipsec_outb_sa)))
 
-void __roc_api roc_ot_ipsec_inb_sa_init(struct roc_ot_ipsec_inb_sa *sa,
-					bool is_inline);
+void __roc_api roc_ot_ipsec_inb_sa_init(struct roc_ot_ipsec_inb_sa *sa);
 void __roc_api roc_ot_ipsec_outb_sa_init(struct roc_ot_ipsec_outb_sa *sa);
 #endif /* __ROC_IE_OT_H__ */
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 5b79bc2266..88d5a678b1 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -423,7 +423,7 @@ nix_inl_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	if (roc_model_is_cn10k()) {
 		for (i = 0; i < max_sa; i++) {
 			sa = ((uint8_t *)nix->inb_sa_base) + (i * inb_sa_sz);
-			roc_ot_ipsec_inb_sa_init(sa, true);
+			roc_ot_ipsec_inb_sa_init(sa);
 		}
 	}
 
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index ffe6eef81f..d26cbee0cc 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -440,7 +440,7 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
 		for (i = 0; i < max_sa; i++) {
 			sa = ((uint8_t *)inl_dev->inb_sa_base) +
 			     (i * inb_sa_sz);
-			roc_ot_ipsec_inb_sa_init(sa, true);
+			roc_ot_ipsec_inb_sa_init(sa);
 		}
 	}
 	/* Setup device specific inb SA table */
diff --git a/drivers/crypto/cnxk/cn10k_ipsec.c b/drivers/crypto/cnxk/cn10k_ipsec.c
index 8123a5f97b..33ffda0a4c 100644
--- a/drivers/crypto/cnxk/cn10k_ipsec.c
+++ b/drivers/crypto/cnxk/cn10k_ipsec.c
@@ -174,8 +174,7 @@ cn10k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	/* Translate security parameters to SA */
-	ret = cnxk_ot_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm,
-					false);
+	ret = cnxk_ot_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm);
 	if (ret) {
 		plt_err("Could not fill inbound session parameters");
 		goto sa_dptr_free;
@@ -308,7 +307,7 @@ cn10k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn10k_sec_session
 	} else {
 		sa_dptr = plt_zmalloc(sizeof(struct roc_ot_ipsec_inb_sa), 8);
 		if (sa_dptr != NULL) {
-			roc_ot_ipsec_inb_sa_init(sa_dptr, false);
+			roc_ot_ipsec_inb_sa_init(sa_dptr);
 
 			ret = roc_cpt_ctx_write(
 				lf, sa_dptr, &sa->in_sa,
diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 41dfba36d3..3f81913d41 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -851,8 +851,7 @@ cn10k_eth_sec_session_create(void *device,
 		memset(inb_sa_dptr, 0, sizeof(struct roc_ot_ipsec_inb_sa));
 
 		/* Fill inbound sa params */
-		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto,
-					       true);
+		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto);
 		if (rc) {
 			snprintf(tbuf, sizeof(tbuf),
 				 "Failed to init inbound sa, rc=%d", rc);
@@ -1063,7 +1062,7 @@ cn10k_eth_sec_session_destroy(void *device, struct rte_security_session *sess)
 	if (eth_sec->inb) {
 		/* Disable SA */
 		sa_dptr = dev->inb.sa_dptr;
-		roc_ot_ipsec_inb_sa_init(sa_dptr, true);
+		roc_ot_ipsec_inb_sa_init(sa_dptr);
 
 		roc_nix_inl_ctx_write(&dev->nix, sa_dptr, eth_sec->sa,
 				      eth_sec->inb,
@@ -1146,8 +1145,7 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		inb_sa_dptr = (struct roc_ot_ipsec_inb_sa *)dev->inb.sa_dptr;
 		memset(inb_sa_dptr, 0, sizeof(struct roc_ot_ipsec_inb_sa));
 
-		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto,
-					       true);
+		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto);
 		if (rc)
 			return -EINVAL;
 		/* Use cookie for original data */
-- 
2.34.1


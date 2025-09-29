Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D7CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:44:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CD5F40685;
	Mon, 29 Sep 2025 11:44:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A53FA4026D
 for <dev@dpdk.org>; Mon, 29 Sep 2025 11:44:03 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T6oMvo029160
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 xDGsuhxBL3Uhr++nTHe8n3pI0WQZkazaJvUniFVA7k=; b=Shy0oia2kC+rjuGo4
 mXkQfQqwIsAHIb6V4Xo427dvFTF/KB8OWauAv5R9/1mQFEKSC63QHSsjCxZy3k2y
 ZaDpzlzWQPQUQmZGUkhhOnBdP/P1MEUkgI9u80mK0Q1tjY5bbhMF2g3boJncHOKk
 /CSHiOE4v6rWmQx1dr85S/fD6LpVYSm/LY26HKvYozQu1ZI48zw22azRnu21bwL5
 /nE12CE09GkjPHDITdlv2GI1hDT0Xc1K6Pw/oOVGQkE6JvaiVda1TFetjujTP5o4
 f/9Y1JDXsX9gmigfki4bq4I1J+lsmFQ9C9va97fU8vlb4iMlutz/Q8ar3TVOq6+Z
 eA+FA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ed9hkk0j-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:44:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 02:44:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 02:44:10 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 765C83F7059;
 Mon, 29 Sep 2025 02:43:58 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 01/10] common/cnxk: get context ilen as devarg
Date: Mon, 29 Sep 2025 15:13:44 +0530
Message-ID: <20250929094353.1027744-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929094353.1027744-1-ktejasree@marvell.com>
References: <20250929094353.1027744-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b7W/I9Gx c=1 sm=1 tr=0 ts=68da54e2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=soCjh_8mzOhwY7XKNqIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: KvuOCtr4cCKjFCTz5RPKSP23Mq6ou8DH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4OSBTYWx0ZWRfX0JcggdV4NdiD
 BHKzG/jn5D1bW567ibYGDhqVp57vWMWWwVgokSoe03r4m0tc2SI3R8ATlm+F0yhWtdsw/w+/gIo
 2zO4mJjMZRwHgwr5E/QChYUqnHToM3kwXp9DzA67RPgFX1xXxj2sL6idsTH5h4ir/s9Obk5XxoS
 /VORoBBuAKvgI8Q6wJAtHvqC1Qbo1i3O8sFO3XdqfDTv79V0TcfRF8erNUuVqGiyMnEoV23xJTz
 DhPRxfWNQvLflhKiq0rVIdsFyDX5+CWuI1Y9mur/WQd3y3vMVY2frmX6gybjbUMeiwdd/TbEOE0
 E4KGLYDlUblZmLpTSD2nkwf74v4Of3wUPUz7h0uH4/BvjKfEal6afm1HHHf4z0jrSHfdC3hm9zm
 a/PYpvoPnnbfxVPIGe1+8gWP8zQAaA==
X-Proofpoint-ORIG-GUID: KvuOCtr4cCKjFCTz5RPKSP23Mq6ou8DH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
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

Receive cpt context ilen as devarg parameter
and configure lf.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 doc/guides/cryptodevs/cnxk.rst               | 11 +++++
 drivers/common/cnxk/cnxk_security.c          | 20 ++++++--
 drivers/common/cnxk/cnxk_security.h          | 25 +++++-----
 drivers/common/cnxk/roc_cpt.c                |  8 +++-
 drivers/common/cnxk/roc_cpt.h                |  1 +
 drivers/crypto/cnxk/cn10k_ipsec.c            |  4 +-
 drivers/crypto/cnxk/cn10k_tls.c              | 16 +++++--
 drivers/crypto/cnxk/cn20k_ipsec.c            |  4 +-
 drivers/crypto/cnxk/cnxk_cryptodev.h         |  1 +
 drivers/crypto/cnxk/cnxk_cryptodev_devargs.c | 49 ++++++++++++++++++++
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c     |  3 ++
 drivers/net/cnxk/cn10k_ethdev_sec.c          | 14 +++---
 drivers/net/cnxk/cn20k_ethdev_sec.c          |  8 ++--
 13 files changed, 126 insertions(+), 38 deletions(-)

diff --git a/doc/guides/cryptodevs/cnxk.rst b/doc/guides/cryptodevs/cnxk.rst
index 77e6a8e68d..c29a2cbb92 100644
--- a/doc/guides/cryptodevs/cnxk.rst
+++ b/doc/guides/cryptodevs/cnxk.rst
@@ -200,6 +200,17 @@ Runtime Config Options
    With the above configuration, QP 20 will be used by the device for Rx injection
    in security in fallback mechanism scenario.
 
+- ``Context ilen value`` (default ``0``)
+
+  Initial context fetch length value for CPT context.
+
+  For example::
+
+      -a 0002:20:00.1,ctx_ilen=4
+
+  With the above configuration, CPT initial context fetch size will be set to
+  4+1 128 bytes blocks.
+
 Debugging Options
 -----------------
 
diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 0e6777e6ca..600098ae1c 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -309,7 +309,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_inb_sa_fill)
 int
 cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
-			  struct rte_crypto_sym_xform *crypto_xfrm)
+			  struct rte_crypto_sym_xform *crypto_xfrm, uint8_t ctx_ilen)
 {
 	uint16_t sport = 4500, dport = 4500;
 	union roc_ot_ipsec_sa_word2 w2;
@@ -383,6 +383,9 @@ cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 		 ROC_CTX_UNIT_128B) -
 		1;
 
+	if (sa->w0.s.ctx_size < ctx_ilen)
+		sa->w0.s.ctx_size = ctx_ilen;
+
 	/**
 	 * CPT MC triggers expiry when counter value changes from 2 to 1. To
 	 * mitigate this behaviour add 1 to the life counter values provided.
@@ -419,7 +422,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_outb_sa_fill)
 int
 cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
-			   struct rte_crypto_sym_xform *crypto_xfrm)
+			   struct rte_crypto_sym_xform *crypto_xfrm, uint8_t ctx_ilen)
 {
 	struct rte_security_ipsec_tunnel_param *tunnel = &ipsec_xfrm->tunnel;
 	uint16_t sport = 4500, dport = 4500;
@@ -541,6 +544,9 @@ cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
 			     ROC_CTX_UNIT_128B) -
 			    1;
 
+	if (sa->w0.s.ctx_size < ctx_ilen)
+		sa->w0.s.ctx_size = ctx_ilen;
+
 	/* IPID gen */
 	sa->w2.s.ipid_gen = 1;
 
@@ -1488,7 +1494,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_inb_sa_fill)
 int
 cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
-			  struct rte_crypto_sym_xform *crypto_xfrm)
+			  struct rte_crypto_sym_xform *crypto_xfrm, uint8_t ctx_ilen)
 {
 	uint16_t sport = 4500, dport = 4500;
 	union roc_ow_ipsec_sa_word2 w2;
@@ -1559,6 +1565,9 @@ cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
 		(PLT_ALIGN_CEIL(ow_ipsec_inb_ctx_size(sa), ROC_CTX_UNIT_128B) / ROC_CTX_UNIT_128B) -
 		1;
 
+	if (sa->w0.s.ctx_size < ctx_ilen)
+		sa->w0.s.ctx_size = ctx_ilen;
+
 	/**
 	 * CPT MC triggers expiry when counter value changes from 2 to 1. To
 	 * mitigate this behaviour add 1 to the life counter values provided.
@@ -1595,7 +1604,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_outb_sa_fill)
 int
 cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
-			   struct rte_crypto_sym_xform *crypto_xfrm)
+			   struct rte_crypto_sym_xform *crypto_xfrm, uint8_t ctx_ilen)
 {
 	struct rte_security_ipsec_tunnel_param *tunnel = &ipsec_xfrm->tunnel;
 	uint16_t sport = 4500, dport = 4500;
@@ -1711,6 +1720,9 @@ cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
 	/* IPID gen */
 	sa->w2.s.ipid_gen = 1;
 
+	if (sa->w0.s.ctx_size < ctx_ilen)
+		sa->w0.s.ctx_size = ctx_ilen;
+
 	/**
 	 * CPT MC triggers expiry when counter value changes from 2 to 1. To
 	 * mitigate this behaviour add 1 to the life counter values provided.
diff --git a/drivers/common/cnxk/cnxk_security.h b/drivers/common/cnxk/cnxk_security.h
index e324fa2cb9..3912c8d376 100644
--- a/drivers/common/cnxk/cnxk_security.h
+++ b/drivers/common/cnxk/cnxk_security.h
@@ -33,19 +33,17 @@ cnxk_ipsec_icvlen_get(enum rte_crypto_cipher_algorithm c_algo,
 		      enum rte_crypto_auth_algorithm a_algo,
 		      enum rte_crypto_aead_algorithm aead_algo);
 
-uint8_t __roc_api
-cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
-			     enum rte_crypto_aead_algorithm aead_algo);
+uint8_t __roc_api cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
+					       enum rte_crypto_aead_algorithm aead_algo);
 
 /* [CN10K] */
-int __roc_api
-cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
-			  struct rte_security_ipsec_xform *ipsec_xfrm,
-			  struct rte_crypto_sym_xform *crypto_xfrm);
-int __roc_api
-cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
-			   struct rte_security_ipsec_xform *ipsec_xfrm,
-			   struct rte_crypto_sym_xform *crypto_xfrm);
+int __roc_api cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
+					struct rte_security_ipsec_xform *ipsec_xfrm,
+					struct rte_crypto_sym_xform *crypto_xfrm, uint8_t ctx_ilen);
+int __roc_api cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
+					 struct rte_security_ipsec_xform *ipsec_xfrm,
+					 struct rte_crypto_sym_xform *crypto_xfrm,
+					 uint8_t ctx_ilen);
 bool __roc_api cnxk_ot_ipsec_inb_sa_valid(struct roc_ot_ipsec_inb_sa *sa);
 bool __roc_api cnxk_ot_ipsec_outb_sa_valid(struct roc_ot_ipsec_outb_sa *sa);
 
@@ -60,10 +58,11 @@ int __roc_api cnxk_on_ipsec_outb_sa_create(struct rte_security_ipsec_xform *ipse
 /* [CN20K, .) */
 int __roc_api cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
 					struct rte_security_ipsec_xform *ipsec_xfrm,
-					struct rte_crypto_sym_xform *crypto_xfrm);
+					struct rte_crypto_sym_xform *crypto_xfrm, uint8_t ctx_ilen);
 int __roc_api cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
 					 struct rte_security_ipsec_xform *ipsec_xfrm,
-					 struct rte_crypto_sym_xform *crypto_xfrm);
+					 struct rte_crypto_sym_xform *crypto_xfrm,
+					 uint8_t ctx_ilen);
 bool __roc_api cnxk_ow_ipsec_inb_sa_valid(struct roc_ow_ipsec_inb_sa *sa);
 bool __roc_api cnxk_ow_ipsec_outb_sa_valid(struct roc_ow_ipsec_outb_sa *sa);
 #endif /* _CNXK_SECURITY_H__ */
diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index d1ba2b8858..fa040b5f4f 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -632,10 +632,16 @@ roc_cpt_dev_configure(struct roc_cpt *roc_cpt, int nb_lf, bool rxc_ena, uint16_t
 		eng_grpmsk = (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_AE]) |
 			     (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_SE]);
 
-	if (roc_errata_cpt_has_ctx_fetch_issue()) {
+	if (roc_cpt->ctx_ilen != 0) {
+		ctx_ilen = roc_cpt->ctx_ilen;
+		ctx_ilen_valid = true;
+	} else if (roc_errata_cpt_has_ctx_fetch_issue()) {
 		ctx_ilen_valid = true;
 		/* Inbound SA size is max context size */
 		ctx_ilen = (PLT_ALIGN(ROC_OT_IPSEC_SA_SZ_MAX, ROC_ALIGN) / 128) - 1;
+	} else if (roc_cpt->ctx_ilen != 0) {
+		ctx_ilen = roc_cpt->ctx_ilen;
+		ctx_ilen_valid = true;
 	}
 
 	rc = cpt_lfs_alloc(&cpt->dev, eng_grpmsk, blkaddr[blknum], false, ctx_ilen_valid, ctx_ilen,
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 02f49c06b7..aa30f46f04 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -169,6 +169,7 @@ struct roc_cpt {
 	uint16_t nb_lf;
 	uint16_t nb_lf_avail;
 	uintptr_t lmt_base;
+	uint8_t ctx_ilen;
 	/**< CPT device capabilities */
 	union cpt_eng_caps hw_caps[CPT_MAX_ENG_TYPES];
 	uint8_t eng_grp[CPT_MAX_ENG_TYPES];
diff --git a/drivers/crypto/cnxk/cn10k_ipsec.c b/drivers/crypto/cnxk/cn10k_ipsec.c
index 5cd4f5257a..a1207aa7c4 100644
--- a/drivers/crypto/cnxk/cn10k_ipsec.c
+++ b/drivers/crypto/cnxk/cn10k_ipsec.c
@@ -45,7 +45,7 @@ cn10k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	/* Translate security parameters to SA */
-	ret = cnxk_ot_ipsec_outb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm);
+	ret = cnxk_ot_ipsec_outb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm, roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill outbound session parameters");
 		goto sa_dptr_free;
@@ -176,7 +176,7 @@ cn10k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	/* Translate security parameters to SA */
-	ret = cnxk_ot_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm);
+	ret = cnxk_ot_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm, roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill inbound session parameters");
 		goto sa_dptr_free;
diff --git a/drivers/crypto/cnxk/cn10k_tls.c b/drivers/crypto/cnxk/cn10k_tls.c
index 49edac8cd6..1a7b87e400 100644
--- a/drivers/crypto/cnxk/cn10k_tls.c
+++ b/drivers/crypto/cnxk/cn10k_tls.c
@@ -327,7 +327,8 @@ tls_read_ctx_size(struct roc_ie_ot_tls_read_sa *sa, enum rte_security_tls_versio
 static int
 tls_read_sa_fill(struct roc_ie_ot_tls_read_sa *read_sa,
 		 struct rte_security_tls_record_xform *tls_xfrm,
-		 struct rte_crypto_sym_xform *crypto_xfrm, struct cn10k_tls_opt *tls_opt)
+		 struct rte_crypto_sym_xform *crypto_xfrm, struct cn10k_tls_opt *tls_opt,
+		 uint8_t ctx_ilen)
 {
 	enum rte_security_tls_version tls_ver = tls_xfrm->ver;
 	struct rte_crypto_sym_xform *auth_xfrm, *cipher_xfrm;
@@ -470,6 +471,9 @@ tls_read_sa_fill(struct roc_ie_ot_tls_read_sa *read_sa,
 		 ROC_CTX_UNIT_128B) -
 		1;
 
+	if (read_sa->w0.s.ctx_size < ctx_ilen)
+		read_sa->w0.s.ctx_size = ctx_ilen;
+
 	/* Word offset for HW managed CTX field */
 	read_sa->w0.s.hw_ctx_off = offset / 8;
 	read_sa->w0.s.ctx_push_size = read_sa->w0.s.hw_ctx_off;
@@ -482,7 +486,7 @@ tls_read_sa_fill(struct roc_ie_ot_tls_read_sa *read_sa,
 static int
 tls_write_sa_fill(struct roc_ie_ot_tls_write_sa *write_sa,
 		  struct rte_security_tls_record_xform *tls_xfrm,
-		  struct rte_crypto_sym_xform *crypto_xfrm)
+		  struct rte_crypto_sym_xform *crypto_xfrm, uint8_t ctx_ilen)
 {
 	enum rte_security_tls_version tls_ver = tls_xfrm->ver;
 	struct rte_crypto_sym_xform *auth_xfrm, *cipher_xfrm;
@@ -606,6 +610,9 @@ tls_write_sa_fill(struct roc_ie_ot_tls_write_sa *write_sa,
 		write_sa->w0.s.ctx_size -= 1;
 	}
 
+	if (write_sa->w0.s.ctx_size < ctx_ilen)
+		write_sa->w0.s.ctx_size = ctx_ilen;
+
 	/* Word offset for HW managed CTX field */
 	write_sa->w0.s.hw_ctx_off = offset / 8;
 	write_sa->w0.s.ctx_push_size = write_sa->w0.s.hw_ctx_off;
@@ -655,7 +662,8 @@ cn10k_tls_read_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	/* Translate security parameters to SA */
-	ret = tls_read_sa_fill(sa_dptr, tls_xfrm, crypto_xfrm, &sec_sess->tls_opt);
+	ret = tls_read_sa_fill(sa_dptr, tls_xfrm, crypto_xfrm, &sec_sess->tls_opt,
+			       roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill read session parameters");
 		goto sa_dptr_free;
@@ -745,7 +753,7 @@ cn10k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	/* Translate security parameters to SA */
-	ret = tls_write_sa_fill(sa_dptr, tls_xfrm, crypto_xfrm);
+	ret = tls_write_sa_fill(sa_dptr, tls_xfrm, crypto_xfrm, roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill write session parameters");
 		goto sa_dptr_free;
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index 1a65438646..8f79033ccc 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -45,7 +45,7 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	/* Translate security parameters to SA */
-	ret = cnxk_ow_ipsec_outb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm);
+	ret = cnxk_ow_ipsec_outb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm, roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill outbound session parameters");
 		goto sa_dptr_free;
@@ -171,7 +171,7 @@ cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	}
 
 	/* Translate security parameters to SA */
-	ret = cnxk_ow_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm);
+	ret = cnxk_ow_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm, roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill inbound session parameters");
 		goto sa_dptr_free;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev.h b/drivers/crypto/cnxk/cnxk_cryptodev.h
index 5cec64c2e1..088149badb 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev.h
@@ -36,6 +36,7 @@ struct cnxk_cpt_vf {
 	struct roc_ae_ec_group *ec_grp[ROC_AE_EC_ID_PMAX];
 	uint16_t max_qps_limit;
 	uint16_t rx_inject_qp;
+	uint8_t ctx_ilen;
 };
 
 uint64_t cnxk_cpt_default_ff_get(void);
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c b/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c
index adf1ba0543..3623e5aa76 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c
@@ -4,12 +4,16 @@
 
 #include <rte_devargs.h>
 
+#include "cn10k_tls.h"
 #include "cnxk_cryptodev.h"
+#include "cnxk_security.h"
 
 #define CNXK_MAX_QPS_LIMIT     "max_qps_limit"
 #define CNXK_MAX_QPS_LIMIT_MIN 1
 #define CNXK_MAX_QPS_LIMIT_MAX (ROC_CPT_MAX_LFS - 1)
 #define CNXK_RX_INJECT_QP      "rx_inject_qp"
+#define CNXK_CPT_CTX_ILEN      "ctx_ilen"
+#define CNXK_MAX_CPT_CTX_ILEN  7
 
 static int
 parse_rx_inject_qp(const char *key, const char *value, void *extra_args)
@@ -43,12 +47,48 @@ parse_max_qps_limit(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
+static uint32_t
+find_max_ctx_value(void)
+{
+	uint32_t val;
+
+	val = RTE_MAX(offsetof(struct roc_ot_ipsec_inb_sa, ctx),
+		      offsetof(struct roc_ot_ipsec_outb_sa, ctx));
+
+	val = RTE_MAX(val, offsetof(struct roc_ie_ot_tls_read_sa, tls_12.ctx));
+	val = RTE_MAX(val, offsetof(struct roc_ie_ot_tls_read_sa, tls_13.ctx));
+	val = RTE_MAX(val, offsetof(struct roc_ie_ot_tls_write_sa, tls_12.w26_rsvd7));
+	val = RTE_MAX(val, offsetof(struct roc_ie_ot_tls_write_sa, tls_13.w10_rsvd7));
+
+	return val / 128 + 1;
+}
+
+static int
+parse_cpt_ctx_ilen(const char *key, const char *value, void *extra_args)
+{
+	RTE_SET_USED(key);
+	uint32_t val, min_val;
+
+	val = atoi(value);
+	if (val > CNXK_MAX_CPT_CTX_ILEN)
+		return -EINVAL;
+
+	min_val = find_max_ctx_value();
+	if (val < min_val)
+		return -EINVAL;
+
+	*(uint16_t *)extra_args = val;
+
+	return 0;
+}
+
 int
 cnxk_cpt_parse_devargs(struct rte_devargs *devargs, struct cnxk_cpt_vf *vf)
 {
 	uint16_t max_qps_limit = CNXK_MAX_QPS_LIMIT_MAX;
 	struct rte_kvargs *kvlist;
 	uint16_t rx_inject_qp;
+	uint16_t ctx_ilen = 0;
 	int rc;
 
 	/* Set to max value as default so that the feature is disabled by default. */
@@ -78,11 +118,20 @@ cnxk_cpt_parse_devargs(struct rte_devargs *devargs, struct cnxk_cpt_vf *vf)
 		goto exit;
 	}
 
+	rc = rte_kvargs_process(kvlist, CNXK_CPT_CTX_ILEN, parse_cpt_ctx_ilen, &ctx_ilen);
+	if (rc < 0) {
+		plt_err("ctx_ilen should in the range <%d-%d>", find_max_ctx_value(),
+			CNXK_MAX_CPT_CTX_ILEN);
+		rte_kvargs_free(kvlist);
+		goto exit;
+	}
+
 	rte_kvargs_free(kvlist);
 
 null_devargs:
 	vf->max_qps_limit = max_qps_limit;
 	vf->rx_inject_qp = rx_inject_qp;
+	vf->cpt.ctx_ilen = ctx_ilen;
 	return 0;
 
 exit:
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 261e14b418..2bf156bddb 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -819,6 +819,9 @@ sym_session_configure(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xfor
 	if (hw_ctx_cache_enable())
 		roc_se_ctx_init(&sess_priv->roc_se_ctx);
 
+	if (sess_priv->roc_se_ctx.se_ctx.w0.s.ctx_size < roc_cpt->ctx_ilen)
+		sess_priv->roc_se_ctx.se_ctx.w0.s.ctx_size = roc_cpt->ctx_ilen;
+
 	return 0;
 
 priv_put:
diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 110630596e..c477b12a30 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -845,10 +845,9 @@ cn10k_eth_sec_session_create(void *device,
 		memset(inb_sa_dptr, 0, sizeof(struct roc_ot_ipsec_inb_sa));
 
 		/* Fill inbound sa params */
-		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto, 0);
 		if (rc) {
-			snprintf(tbuf, sizeof(tbuf),
-				 "Failed to init inbound sa, rc=%d", rc);
+			snprintf(tbuf, sizeof(tbuf), "Failed to init inbound sa, rc=%d", rc);
 			goto err;
 		}
 
@@ -936,10 +935,9 @@ cn10k_eth_sec_session_create(void *device,
 		memset(outb_sa_dptr, 0, sizeof(struct roc_ot_ipsec_outb_sa));
 
 		/* Fill outbound sa params */
-		rc = cnxk_ot_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ot_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
 		if (rc) {
-			snprintf(tbuf, sizeof(tbuf),
-				 "Failed to init outbound sa, rc=%d", rc);
+			snprintf(tbuf, sizeof(tbuf), "Failed to init outbound sa, rc=%d", rc);
 			rc |= cnxk_eth_outb_sa_idx_put(dev, sa_idx);
 			goto err;
 		}
@@ -1148,7 +1146,7 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		inb_sa_dptr = (struct roc_ot_ipsec_inb_sa *)dev->inb.sa_dptr;
 		memset(inb_sa_dptr, 0, sizeof(struct roc_ot_ipsec_inb_sa));
 
-		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto, 0);
 		if (rc)
 			goto err;
 		/* Use cookie for original data */
@@ -1183,7 +1181,7 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		outb_sa_dptr = (struct roc_ot_ipsec_outb_sa *)dev->outb.sa_dptr;
 		memset(outb_sa_dptr, 0, sizeof(struct roc_ot_ipsec_outb_sa));
 
-		rc = cnxk_ot_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ot_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
 		if (rc)
 			goto err;
 
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 4284b726ee..5bf7917345 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -736,7 +736,7 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 		memset(inb_sa_dptr, 0, sizeof(struct roc_ow_ipsec_inb_sa));
 
 		/* Fill inbound sa params */
-		rc = cnxk_ow_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ow_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto, 0);
 		if (rc) {
 			snprintf(tbuf, sizeof(tbuf), "Failed to init inbound sa, rc=%d", rc);
 			goto err;
@@ -814,7 +814,7 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 		memset(outb_sa_dptr, 0, sizeof(struct roc_ow_ipsec_outb_sa));
 
 		/* Fill outbound sa params */
-		rc = cnxk_ow_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ow_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
 		if (rc) {
 			snprintf(tbuf, sizeof(tbuf), "Failed to init outbound sa, rc=%d", rc);
 			rc |= cnxk_eth_outb_sa_idx_put(dev, sa_idx);
@@ -1000,7 +1000,7 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		inb_sa_dptr = (struct roc_ow_ipsec_inb_sa *)dev->inb.sa_dptr;
 		memset(inb_sa_dptr, 0, sizeof(struct roc_ow_ipsec_inb_sa));
 
-		rc = cnxk_ow_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ow_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto, 0);
 		if (rc)
 			return -EINVAL;
 		/* Use cookie for original data */
@@ -1034,7 +1034,7 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		outb_sa_dptr = (struct roc_ow_ipsec_outb_sa *)dev->outb.sa_dptr;
 		memset(outb_sa_dptr, 0, sizeof(struct roc_ow_ipsec_outb_sa));
 
-		rc = cnxk_ow_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto);
+		rc = cnxk_ow_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
 		if (rc)
 			return -EINVAL;
 
-- 
2.25.1


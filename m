Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF67CD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 07:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384BE4028A;
	Sun, 21 Jun 2026 09:57:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 99AAB4027F
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:57:21 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L5vUaO3470957; Sun, 21 Jun 2026 00:57:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 Bi76dEa620YvETRoP442cW0uF3VYlul7sx60Y7aBIY=; b=Wpkfsuo6aNcu3Wp5n
 3jFHubR8AF0hzr8dpBmpo5dzxfH4t/u1Qu9deox19ehQ3D6vbwi5i+8HQ3+cUx9x
 Psle1l1CYnjCbLedqg2sG1lIDZyWK5tiTil9Zt/0XvPZV2MX0HJcpDtZQ8SI7XgE
 AxsipDnA4w39LH1dP/EDInCDG6MRS5HfB1sQJpRj1XoinzWozjmOsRqLZvT/9slb
 WegtHHUJeHPK3NuqM7T0FZiY6xt5D6ZhGoqk7wYely28A87d0fB/lpZZaOdWPYPc
 nSEkQWn5B2g4lxtsL78mfrHhD6RvOdtaLzWA53Fsh/TkSeUtE3rMKtwnAD7KRNCu
 UNg1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ewtchhwt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 21 Jun 2026 00:57:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 21 Jun 2026 00:57:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 21 Jun 2026 00:57:18 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.167.66])
 by maili.marvell.com (Postfix) with ESMTP id B7A263F7058;
 Sun, 21 Jun 2026 00:57:13 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 "Anoob Joseph" <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: [v2] crypto/cnxk: add ML crypto support
Date: Sun, 21 Jun 2026 13:26:57 +0530
Message-ID: <20260621075706.23184-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260529091330.6308-1-gmuthukrishn@marvell.com>
References: <20260529091330.6308-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA3OSBTYWx0ZWRfX74w29JBUhHVP
 yjbzRgZgUnfHuDwt/k/Ag7fphiR8pxGiqIhZcsL8G2AkoM7PIpyxvYEHrVDFnOw41ufH+8n3S6D
 gjw87kfUPNbd4XZB7BoFMnRA+H9Gz2A+YpIaRkWFxcC+vs/dLmwjKZsgbNIppLPkQu3tE5MgvAt
 uP6x1DMYw67asjGc+1vs7+qZ9lL5XjvT2nWzCinjpezqsn0z0zX5Y3TUdy7UEz/z5G5Mm2BsHIB
 xPO2BrW1jvg4zh3GHCN9ZoIoLvB3V2jLrm1nMkg/htHZM3brkF6hdVmOjICSGpJ/jvedZExtJ2I
 Uawtceb4K4ZOvvJt16eq80QTRDG8XLbN7VoKyIen2/ESyZM+F/26rAKGgesuW8jituyr4HPYLFs
 VCkoh5oZ6lcxyZx9aMUegdAra6mPse2M4OVC+ec3kfSrM9Ob9V3yoHaOAEvKY2vFzISe6rRJotD
 gE/E8ubZ7JZNWmf79Mg==
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a379960 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ehtJoBd4Qk2_Yw7eb20A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SAwX3WABf0kizbsW-oQuyKkKfmpBS2au
X-Proofpoint-GUID: SAwX3WABf0kizbsW-oQuyKkKfmpBS2au
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA3OSBTYWx0ZWRfX6aSe72nvCIuE
 e4nLkuPIOSTVgqmjLtSQ+ST1zm+r3hR0GjTv0B1YHB9xrRaUnLffq1LyGmYb7gOu2pHxd3L+H2d
 lafUqXmM3WbsGJPFQyHnQP/SFG53yl0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
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

Add ML-KEM and ML-DSA support.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v2:
 - Addressed comments from v1.
---
 doc/guides/cryptodevs/features/cn20k.ini      |   3 +
 doc/guides/cryptodevs/features/default.ini    |   1 +
 doc/guides/rel_notes/release_26_07.rst        |   3 +
 drivers/common/cnxk/hw/cpt.h                  |   1 +
 drivers/common/cnxk/meson.build               |   1 +
 drivers/common/cnxk/roc_cpt.c                 |   4 +
 drivers/common/cnxk/roc_platform.h            |   5 +
 .../common/cnxk/roc_platform_base_symbols.c   |   2 +
 drivers/common/cnxk/roc_re.h                  |  31 ++
 drivers/common/cnxk/roc_re_ml_tables.c        | 248 +++++++++++
 drivers/common/cnxk/roc_re_ml_tables.h        |  19 +
 drivers/crypto/cnxk/cnxk_ae.h                 | 399 +++++++++++++++++-
 drivers/crypto/cnxk/cnxk_cryptodev.c          |  11 +
 drivers/crypto/cnxk/cnxk_cryptodev.h          |   4 +-
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |  62 ++-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  45 +-
 16 files changed, 817 insertions(+), 22 deletions(-)
 create mode 100644 drivers/common/cnxk/roc_re.h
 create mode 100644 drivers/common/cnxk/roc_re_ml_tables.c
 create mode 100644 drivers/common/cnxk/roc_re_ml_tables.h

diff --git a/doc/guides/cryptodevs/features/cn20k.ini b/doc/guides/cryptodevs/features/cn20k.ini
index d4c52082c6..8180128744 100644
--- a/doc/guides/cryptodevs/features/cn20k.ini
+++ b/doc/guides/cryptodevs/features/cn20k.ini
@@ -21,6 +21,7 @@ Asymmetric sessionless = Y
 Sym raw data path API  = Y
 Inner checksum         = Y
 Rx inject              = Y
+ML-DSA sign prehash    = Y
 
 ;
 ; Supported crypto algorithms of 'cn20k' crypto driver.
@@ -110,6 +111,8 @@ ECDSA                   = Y
 ECPM                    = Y
 SM2                     = Y
 EdDSA                   = Y
+ML-DSA                  = Y
+ML-KEM                  = Y
 
 ;
 ; Supported Operating systems of the 'cn20k' crypto driver.
diff --git a/doc/guides/cryptodevs/features/default.ini b/doc/guides/cryptodevs/features/default.ini
index d8026c3750..be4ee777fb 100644
--- a/doc/guides/cryptodevs/features/default.ini
+++ b/doc/guides/cryptodevs/features/default.ini
@@ -35,6 +35,7 @@ Cipher multiple data units =
 Cipher wrapped key     =
 Inner checksum         =
 Rx inject              =
+ML-DSA sign prehash    =
 
 ;
 ; Supported crypto algorithms of a default crypto driver.
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..13ffc487b1 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -155,6 +155,9 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Updated Marvell cnxk crypto driver.**
+
+  * Added support for ML-KEM and ML-DSA on CN20K platform.
 
 Removed Items
 -------------
diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index eb795f61ac..12aeb4d054 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -58,6 +58,7 @@ enum cpt_eng_type {
 	CPT_ENG_TYPE_AE = 1,
 	CPT_ENG_TYPE_SE = 2,
 	CPT_ENG_TYPE_IE = 3,
+	CPT_ENG_TYPE_RE = 4,
 	CPT_MAX_ENG_TYPES,
 };
 
diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 9db77a9702..3303ad9354 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -65,6 +65,7 @@ sources = files(
         'roc_npc_utils.c',
         'roc_platform.c',
         'roc_platform_base_symbols.c',
+        'roc_re_ml_tables.c',
         'roc_se.c',
         'roc_sso.c',
         'roc_sso_debug.c',
diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 21d5e7f2ba..686c9eae7e 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -632,6 +632,9 @@ roc_cpt_dev_configure(struct roc_cpt *roc_cpt, int nb_lf, bool rxc_ena, uint16_t
 		eng_grpmsk = (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_AE]) |
 			     (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_SE]);
 
+	if (roc_model_is_cn20k())
+		eng_grpmsk |= (1 << roc_cpt->eng_grp[CPT_ENG_TYPE_RE]);
+
 	if (roc_errata_cpt_has_ctx_fetch_issue()) {
 		ctx_ilen_valid = true;
 		/* Inbound SA size is max context size */
@@ -1097,6 +1100,7 @@ roc_cpt_eng_grp_add(struct roc_cpt *roc_cpt, enum cpt_eng_type eng_type)
 	case CPT_ENG_TYPE_AE:
 	case CPT_ENG_TYPE_SE:
 	case CPT_ENG_TYPE_IE:
+	case CPT_ENG_TYPE_RE:
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index 73cc12e567..ac4f76473f 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -41,6 +41,7 @@
 	".arch_extension lse\n"
 #endif
 
+#define PLT_ATOMIC		 RTE_ATOMIC
 #define PLT_ASSERT		 RTE_ASSERT
 #define PLT_VERIFY		 RTE_VERIFY
 #define PLT_MEMZONE_NAMESIZE	 RTE_MEMZONE_NAMESIZE
@@ -218,6 +219,10 @@ plt_thread_is_valid(plt_thread_t thr)
 #define plt_memory_order_release  rte_memory_order_release
 #define plt_memory_order_acquire  rte_memory_order_acquire
 #define plt_memory_order_relaxed  rte_memory_order_relaxed
+#define plt_memory_order_seq_cst  rte_memory_order_seq_cst
+
+#define plt_atomic_fetch_add_explicit rte_atomic_fetch_add_explicit
+#define plt_atomic_fetch_sub_explicit rte_atomic_fetch_sub_explicit
 
 #define plt_bit_relaxed_get32   rte_bit_relaxed_get32
 #define plt_bit_relaxed_set32   rte_bit_relaxed_set32
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index ed34d4b05b..ece28d3885 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -500,6 +500,8 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_aged_flow_ctx_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_defrag_mcam_banks)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_key_type)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_mcam_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_re_ml_zeta_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_re_ml_zeta_put)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_attach)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_detach)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_msix_offsets_get)
diff --git a/drivers/common/cnxk/roc_re.h b/drivers/common/cnxk/roc_re.h
new file mode 100644
index 0000000000..a8cbda41c0
--- /dev/null
+++ b/drivers/common/cnxk/roc_re.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2026 Marvell.
+ */
+
+#ifndef __ROC_RE_H__
+#define __ROC_RE_H__
+
+/* RE ML opcodes */
+#define ROC_RE_MAJOR_OP_MLKEM        0x1A
+#define ROC_RE_MAJOR_OP_MLDSA        0x1B
+#define ROC_RE_MINOR_OP_MLKEM_KEYGEN 0x00
+#define ROC_RE_MINOR_OP_MLKEM_ENCAP  0x01
+#define ROC_RE_MINOR_OP_MLKEM_DECAP  0x02
+#define ROC_RE_MINOR_OP_MLDSA_KEYGEN 0x00
+#define ROC_RE_MINOR_OP_MLDSA_SIGN   0x01
+#define ROC_RE_MINOR_OP_MLDSA_VERIFY 0x02
+
+/* ML-KEM param2 fields */
+#define ROC_RE_ML_KEM_PARAM2_INMSG_BIT  4
+#define ROC_RE_ML_KEM_PARAM2_INSEED_BIT 5
+
+/* ML-DSA param2 fields */
+#define ROC_RE_ML_DSA_PARAM2_SIGN_BIT   4
+#define ROC_RE_ML_DSA_PARAM2_SEED_BIT   5
+#define ROC_RE_ML_DSA_PARAM2_CTXN_BIT   8
+
+/* ML-DSA minor op fields */
+#define ROC_RE_ML_DSA_MINOR_SIGN_TYPE_BIT 2
+#define ROC_RE_ML_DSA_MINOR_MSG_TYPE_BIT  4
+
+#endif /* __ROC_RE_H__ */
diff --git a/drivers/common/cnxk/roc_re_ml_tables.c b/drivers/common/cnxk/roc_re_ml_tables.c
new file mode 100644
index 0000000000..621807a555
--- /dev/null
+++ b/drivers/common/cnxk/roc_re_ml_tables.c
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2026 Marvell.
+ */
+
+#include "roc_re_ml_tables.h"
+
+#define RE_ML_TBL_NAME "re_ml_tbl"
+#define RE_MLKEM_ZETA_LEN 256
+#define RE_MLDSA_ZETA_LEN 1024
+
+/* ML table address and length */
+struct re_ml_entry {
+	const uint8_t *data;
+	size_t len;
+};
+
+struct re_ml_tbl {
+	PLT_ATOMIC(uint64_t) refcount;
+	uint8_t ml_tbl[];
+};
+
+static const uint8_t re_mlkem_zeta_tbl[RE_MLKEM_ZETA_LEN] = {
+	0x01, 0x00, 0xc1, 0x06, 0x14, 0x0a, 0xd9, 0x0c,
+	0x52, 0x0a, 0x76, 0x02, 0x69, 0x07, 0x50, 0x03,
+	0x26, 0x04, 0x7f, 0x07, 0xc1, 0x00, 0x1d, 0x03,
+	0xe2, 0x0a, 0xbc, 0x0c, 0x39, 0x02, 0xd2, 0x06,
+	0x28, 0x01, 0x8f, 0x09, 0x3b, 0x05, 0xc4, 0x05,
+	0xe6, 0x0b, 0x38, 0x00, 0xc0, 0x08, 0x35, 0x05,
+	0x92, 0x05, 0x2e, 0x08, 0x17, 0x02, 0x42, 0x0b,
+	0x59, 0x09, 0x3f, 0x0b, 0xb6, 0x07, 0x35, 0x03,
+	0x21, 0x01, 0x4b, 0x01, 0xb5, 0x0c, 0xdc, 0x06,
+	0xad, 0x04, 0x00, 0x09, 0xe5, 0x08, 0x07, 0x08,
+	0x8a, 0x02, 0xb9, 0x07, 0xd1, 0x09, 0x78, 0x02,
+	0x31, 0x0b, 0x21, 0x00, 0x28, 0x05, 0x7b, 0x07,
+	0x0f, 0x09, 0x9b, 0x05, 0x27, 0x03, 0xc4, 0x01,
+	0x9e, 0x05, 0x34, 0x0b, 0xfe, 0x05, 0x62, 0x09,
+	0x57, 0x0a, 0x39, 0x0a, 0xc9, 0x05, 0x88, 0x02,
+	0xaa, 0x09, 0x26, 0x0c, 0xcb, 0x04, 0x8e, 0x03,
+	0x11, 0x00, 0xc9, 0x0a, 0x47, 0x02, 0x59, 0x0a,
+	0x65, 0x06, 0xd3, 0x02, 0xf0, 0x08, 0x4c, 0x04,
+	0x81, 0x05, 0x66, 0x0a, 0xd1, 0x0c, 0xe9, 0x00,
+	0xf4, 0x02, 0x6c, 0x08, 0xc7, 0x0b, 0xea, 0x0b,
+	0xa7, 0x06, 0x73, 0x06, 0xe5, 0x0a, 0xfd, 0x06,
+	0x37, 0x07, 0xb8, 0x03, 0xb5, 0x05, 0x7f, 0x0a,
+	0xab, 0x03, 0x04, 0x09, 0x85, 0x09, 0x54, 0x09,
+	0xdd, 0x02, 0x21, 0x09, 0x0c, 0x01, 0x81, 0x02,
+	0x30, 0x06, 0xfa, 0x08, 0xf5, 0x07, 0x94, 0x0c,
+	0x77, 0x01, 0xf5, 0x09, 0x2a, 0x08, 0x6d, 0x06,
+	0x27, 0x04, 0x3f, 0x01, 0xd5, 0x0a, 0xf5, 0x02,
+	0x33, 0x08, 0x31, 0x02, 0xa2, 0x09, 0x22, 0x0a,
+	0xf4, 0x0a, 0x44, 0x04, 0x93, 0x01, 0x02, 0x04,
+	0x77, 0x04, 0x66, 0x08, 0xd7, 0x0a, 0x76, 0x03,
+	0xba, 0x06, 0xbc, 0x04, 0x52, 0x07, 0x05, 0x04,
+	0x3e, 0x08, 0x77, 0x0b, 0x75, 0x03, 0x6a, 0x08,
+};
+
+static const uint8_t re_mldsa_zeta_tbl[RE_MLDSA_ZETA_LEN] = {
+	0x01, 0x00, 0x00, 0x00, 0x02, 0x5e, 0x49, 0x00,
+	0x67, 0x75, 0x39, 0x00, 0x69, 0x65, 0x39, 0x00,
+	0x2b, 0x06, 0x4f, 0x00, 0x73, 0xdf, 0x53, 0x00,
+	0x33, 0xe0, 0x4f, 0x00, 0x6b, 0x06, 0x4f, 0x00,
+	0xae, 0xb1, 0x76, 0x00, 0xd5, 0x0d, 0x36, 0x00,
+	0xb0, 0xed, 0x28, 0x00, 0xe4, 0x7f, 0x20, 0x00,
+	0x83, 0x72, 0x39, 0x00, 0x4a, 0x89, 0x70, 0x00,
+	0x92, 0x81, 0x08, 0x00, 0xc8, 0x3d, 0x6d, 0x00,
+	0x94, 0x72, 0x4c, 0x00, 0xb4, 0xe0, 0x41, 0x00,
+	0xd2, 0xa3, 0x28, 0x00, 0x8a, 0x52, 0x66, 0x00,
+	0xa7, 0x18, 0x4a, 0x00, 0x34, 0x40, 0x79, 0x00,
+	0xee, 0x52, 0x0a, 0x00, 0x81, 0x7d, 0x6b, 0x00,
+	0x1d, 0x9f, 0x4e, 0x00, 0x77, 0x28, 0x1a, 0x00,
+	0xdf, 0x71, 0x25, 0x00, 0xee, 0x49, 0x16, 0x00,
+	0xbd, 0x11, 0x76, 0x00, 0xb7, 0x2b, 0x49, 0x00,
+	0x97, 0xf6, 0x2a, 0x00, 0xd5, 0xd8, 0x22, 0x00,
+	0x2a, 0xf7, 0x36, 0x00, 0x1e, 0x91, 0x30, 0x00,
+	0x3f, 0xd1, 0x29, 0x00, 0x73, 0x26, 0x49, 0x00,
+	0x5f, 0x68, 0x50, 0x00, 0xa2, 0x10, 0x20, 0x00,
+	0xf7, 0x87, 0x38, 0x00, 0xc3, 0xb2, 0x11, 0x00,
+	0xa4, 0x03, 0x06, 0x00, 0xed, 0x2b, 0x0e, 0x00,
+	0x2c, 0xb7, 0x10, 0x00, 0x35, 0x5f, 0x4a, 0x00,
+	0x15, 0x9d, 0x1f, 0x00, 0xd4, 0x8c, 0x42, 0x00,
+	0xf4, 0x77, 0x31, 0x00, 0x12, 0xe6, 0x20, 0x00,
+	0x1d, 0x1c, 0x34, 0x00, 0x73, 0xd8, 0x1a, 0x00,
+	0x81, 0x66, 0x73, 0x00, 0x3f, 0x55, 0x49, 0x00,
+	0xf6, 0x52, 0x39, 0x00, 0x4a, 0x56, 0x62, 0x00,
+	0x05, 0xad, 0x65, 0x00, 0x1c, 0x9a, 0x43, 0x00,
+	0x5f, 0xaa, 0x53, 0x00, 0x22, 0xb6, 0x30, 0x00,
+	0x38, 0x7f, 0x08, 0x00, 0x6d, 0x0e, 0x3b, 0x00,
+	0xda, 0x83, 0x2c, 0x00, 0x6e, 0x49, 0x1c, 0x00,
+	0x2b, 0x0e, 0x33, 0x00, 0x70, 0x5b, 0x1c, 0x00,
+	0xf1, 0xe3, 0x2e, 0x00, 0xb9, 0x7e, 0x13, 0x00,
+	0x30, 0xa9, 0x57, 0x00, 0xef, 0xc6, 0x3a, 0x00,
+	0x4c, 0xd5, 0x3f, 0x00, 0xea, 0xb2, 0x4e, 0x00,
+	0xe1, 0x3e, 0x50, 0x00, 0x75, 0xb1, 0x7b, 0x00,
+	0xb4, 0x48, 0x26, 0x00, 0x56, 0xf2, 0x1e, 0x00,
+	0xa2, 0x90, 0x1d, 0x00, 0xd4, 0xa6, 0x45, 0x00,
+	0x9b, 0xe5, 0x2a, 0x00, 0x9c, 0x58, 0x52, 0x00,
+	0xf5, 0xf1, 0x6e, 0x00, 0x88, 0x72, 0x3f, 0x00,
+	0x02, 0x51, 0x17, 0x00, 0x59, 0x5d, 0x07, 0x00,
+	0xba, 0x87, 0x11, 0x00, 0xa9, 0xac, 0x52, 0x00,
+	0x9e, 0x3e, 0x77, 0x00, 0xd8, 0x96, 0x02, 0x00,
+	0xec, 0x92, 0x25, 0x00, 0x12, 0xff, 0x4c, 0x00,
+	0xe8, 0x4c, 0x40, 0x00, 0x82, 0xa5, 0x4a, 0x00,
+	0xe6, 0x54, 0x1e, 0x00, 0xc1, 0x16, 0x4f, 0x00,
+	0x79, 0x7e, 0x1a, 0x00, 0x8f, 0x97, 0x03, 0x00,
+	0x17, 0x48, 0x4e, 0x00, 0x59, 0xb8, 0x31, 0x00,
+	0xcc, 0x84, 0x58, 0x00, 0x27, 0x48, 0x1b, 0x00,
+	0xd0, 0x63, 0x5b, 0x00, 0x7a, 0x78, 0x5d, 0x00,
+	0x5e, 0x22, 0x35, 0x00, 0x7e, 0x0c, 0x40, 0x00,
+	0xd1, 0x09, 0x6c, 0x00, 0x32, 0xd5, 0x5b, 0x00,
+	0xd3, 0xc4, 0x6b, 0x00, 0xcb, 0x8e, 0x25, 0x00,
+	0x4c, 0x53, 0x2e, 0x00, 0x6c, 0x7a, 0x09, 0x00,
+	0x20, 0x88, 0x3b, 0x00, 0x5c, 0x28, 0x6d, 0x00,
+	0xf8, 0xa4, 0x2c, 0x00, 0xaa, 0x7c, 0x33, 0x00,
+	0xa0, 0xb2, 0x14, 0x00, 0x36, 0x85, 0x55, 0x00,
+	0x86, 0xf1, 0x28, 0x00, 0x5d, 0x79, 0x55, 0x00,
+	0x70, 0xf6, 0x4a, 0x00, 0x86, 0x4a, 0x23, 0x00,
+	0x26, 0xe8, 0x75, 0x00, 0x66, 0xde, 0x78, 0x00,
+	0x8c, 0x52, 0x05, 0x00, 0x59, 0xdf, 0x7a, 0x00,
+	0x17, 0x6e, 0x0f, 0x00, 0xda, 0xf3, 0x5b, 0x00,
+	0x7e, 0x9b, 0x45, 0x00, 0x34, 0x8b, 0x62, 0x00,
+	0xcb, 0xbe, 0x5d, 0x00, 0x7b, 0x9e, 0x1a, 0x00,
+	0xd9, 0x06, 0x00, 0x00, 0xc5, 0x57, 0x62, 0x00,
+	0x3c, 0x4b, 0x57, 0x00, 0xef, 0xa8, 0x69, 0x00,
+	0x38, 0x98, 0x28, 0x00, 0xfe, 0xb5, 0x64, 0x00,
+	0xf5, 0xf8, 0x7e, 0x00, 0x78, 0x4e, 0x2a, 0x00,
+	0x23, 0x0a, 0x12, 0x00, 0xa8, 0x54, 0x01, 0x00,
+	0xff, 0xb7, 0x09, 0x00, 0x87, 0x5e, 0x43, 0x00,
+	0xf8, 0x7f, 0x43, 0x00, 0xb4, 0xd5, 0x5c, 0x00,
+	0x4e, 0xc0, 0x4d, 0x00, 0xaf, 0x28, 0x47, 0x00,
+	0x5d, 0x73, 0x7f, 0x00, 0x0d, 0x8d, 0x0c, 0x00,
+	0xd5, 0x66, 0x0f, 0x00, 0x80, 0x6d, 0x5a, 0x00,
+	0x98, 0xab, 0x61, 0x00, 0x96, 0x5d, 0x18, 0x00,
+	0x31, 0x7f, 0x43, 0x00, 0x98, 0x82, 0x46, 0x00,
+	0x60, 0x29, 0x66, 0x00, 0x79, 0xd5, 0x4b, 0x00,
+	0x06, 0xde, 0x28, 0x00, 0x8d, 0x5d, 0x46, 0x00,
+	0xe3, 0xb0, 0x49, 0x00, 0x34, 0xb4, 0x09, 0x00,
+	0xb3, 0x0d, 0x7c, 0x00, 0xb0, 0x68, 0x5a, 0x00,
+	0xa9, 0x9b, 0x40, 0x00, 0xd5, 0xd3, 0x64, 0x00,
+	0x2a, 0x76, 0x21, 0x00, 0x91, 0x85, 0x65, 0x00,
+	0x39, 0x6e, 0x24, 0x00, 0x9b, 0xc3, 0x48, 0x00,
+	0x59, 0xc7, 0x7b, 0x00, 0x59, 0x58, 0x4f, 0x00,
+	0xb2, 0x2d, 0x39, 0x00, 0x23, 0x09, 0x23, 0x00,
+	0x67, 0xeb, 0x12, 0x00, 0xf2, 0x4d, 0x45, 0x00,
+	0x1c, 0xc3, 0x30, 0x00, 0x24, 0x54, 0x28, 0x00,
+	0x2e, 0x23, 0x13, 0x00, 0x80, 0xaf, 0x7f, 0x00,
+	0xcb, 0xbf, 0x2d, 0x00, 0x0b, 0x2a, 0x02, 0x00,
+	0x2c, 0x83, 0x7e, 0x00, 0x7a, 0x58, 0x26, 0x00,
+	0x75, 0x33, 0x6b, 0x00, 0x76, 0x5b, 0x09, 0x00,
+	0xcc, 0xe1, 0x6b, 0x00, 0x1e, 0x06, 0x5e, 0x00,
+	0x0d, 0xe0, 0x78, 0x00, 0x37, 0x8c, 0x62, 0x00,
+	0x04, 0xa6, 0x3d, 0x00, 0x3c, 0xe5, 0x4a, 0x00,
+	0x68, 0x1d, 0x1f, 0x00, 0xbb, 0x30, 0x63, 0x00,
+	0xb8, 0x61, 0x73, 0x00, 0x6c, 0xa0, 0x5e, 0x00,
+	0xc7, 0x1a, 0x67, 0x00, 0xc6, 0x1f, 0x20, 0x00,
+	0xff, 0xa4, 0x5b, 0x00, 0x72, 0xd7, 0x60, 0x00,
+	0x01, 0xf2, 0x08, 0x00, 0x24, 0xe0, 0x6d, 0x00,
+	0x6d, 0x0e, 0x08, 0x00, 0x8e, 0x03, 0x56, 0x00,
+	0x88, 0x56, 0x69, 0x00, 0x3e, 0x6d, 0x1e, 0x00,
+	0xbd, 0x03, 0x26, 0x00, 0xfa, 0x9d, 0x6a, 0x00,
+	0x17, 0xc0, 0x07, 0x00, 0xd4, 0xbf, 0x6d, 0x00,
+	0xbd, 0xd0, 0x74, 0x00, 0xe3, 0xe1, 0x63, 0x00,
+	0x73, 0x95, 0x51, 0x00, 0x0d, 0xb6, 0x7a, 0x00,
+	0xba, 0x67, 0x28, 0x00, 0xd4, 0xec, 0x2d, 0x00,
+	0x8c, 0x01, 0x58, 0x00, 0xf5, 0x4c, 0x3f, 0x00,
+	0x09, 0x70, 0x0b, 0x00, 0x23, 0x7e, 0x42, 0x00,
+	0x37, 0xbd, 0x3c, 0x00, 0x33, 0x33, 0x27, 0x00,
+	0x57, 0x39, 0x67, 0x00, 0x5d, 0x4b, 0x1a, 0x00,
+	0x26, 0x69, 0x19, 0x00, 0x06, 0xf2, 0x1e, 0x00,
+	0x4e, 0xc1, 0x11, 0x00, 0xc8, 0x76, 0x4c, 0x00,
+	0x2f, 0xf4, 0x3c, 0x00, 0x9a, 0xb1, 0x7f, 0x00,
+	0x6c, 0xf6, 0x6a, 0x00, 0x69, 0x16, 0x2e, 0x00,
+	0xd6, 0x52, 0x33, 0x00, 0x60, 0x47, 0x03, 0x00,
+	0x60, 0x52, 0x08, 0x00, 0x78, 0x1e, 0x74, 0x00,
+	0x16, 0x63, 0x2f, 0x00, 0x11, 0x0a, 0x6f, 0x00,
+	0xf1, 0xc0, 0x07, 0x00, 0x0b, 0x6d, 0x77, 0x00,
+	0xf0, 0x1f, 0x0d, 0x00, 0x24, 0x58, 0x34, 0x00,
+	0xd4, 0x23, 0x02, 0x00, 0x59, 0xc5, 0x68, 0x00,
+	0x85, 0x88, 0x5e, 0x00, 0x32, 0xaa, 0x2f, 0x00,
+	0x65, 0xfc, 0x23, 0x00, 0x42, 0x69, 0x5e, 0x00,
+	0xed, 0xe0, 0x51, 0x00, 0xb3, 0xad, 0x65, 0x00,
+	0xe6, 0xa5, 0x2c, 0x00, 0xfe, 0xe1, 0x79, 0x00,
+	0x64, 0x40, 0x7b, 0x00, 0xdd, 0xe1, 0x35, 0x00,
+	0xac, 0x3a, 0x43, 0x00, 0xde, 0x4a, 0x46, 0x00,
+	0x14, 0xfe, 0x1c, 0x00, 0xce, 0xf1, 0x73, 0x00,
+	0x0e, 0x17, 0x10, 0x00, 0xd7, 0xb6, 0x74, 0x00,
+};
+
+static const struct re_ml_entry re_ml_zeta_tbl[2] = {
+	{
+		.data = re_mlkem_zeta_tbl,
+		.len = sizeof(re_mlkem_zeta_tbl)
+	},
+	{
+		.data = re_mldsa_zeta_tbl,
+		.len = sizeof(re_mldsa_zeta_tbl)
+	}
+};
+
+int
+roc_re_ml_zeta_get(uint64_t *tbl)
+{
+	int len = RE_MLKEM_ZETA_LEN + RE_MLDSA_ZETA_LEN;
+	const char name[] = RE_ML_TBL_NAME;
+	const struct plt_memzone *mz;
+	struct re_ml_tbl *ml;
+	uint8_t *data;
+
+	if (tbl == NULL)
+		return -EINVAL;
+
+	mz = plt_memzone_lookup(name);
+	if (mz == NULL) {
+		/* Create memzone first time */
+		mz = plt_memzone_reserve_cache_align(name, sizeof(struct re_ml_tbl) + len);
+		if (mz == NULL)
+			return -ENOMEM;
+	}
+
+	ml = mz->addr;
+	if (plt_atomic_fetch_add_explicit(&ml->refcount, 1, plt_memory_order_seq_cst) != 0)
+		return 0;
+
+	data = PLT_PTR_ADD(mz->addr, sizeof(uint64_t));
+	memcpy(data, re_ml_zeta_tbl[0].data, re_ml_zeta_tbl[0].len);
+	tbl[0] = plt_cpu_to_be_64((uintptr_t)data);
+
+	data = PLT_PTR_ADD(data, re_ml_zeta_tbl[0].len);
+	memcpy(data, re_ml_zeta_tbl[1].data, re_ml_zeta_tbl[1].len);
+	tbl[1] = plt_cpu_to_be_64((uintptr_t)data);
+
+	return 0;
+}
+
+void
+roc_re_ml_zeta_put(void)
+{
+	const char name[] = RE_ML_TBL_NAME;
+	const struct plt_memzone *mz;
+	struct re_ml_tbl *ml;
+
+	mz = plt_memzone_lookup(name);
+	if (mz == NULL)
+		return;
+
+	ml = mz->addr;
+	if (plt_atomic_fetch_sub_explicit(&ml->refcount, 1, plt_memory_order_seq_cst) == 1)
+		plt_memzone_free(mz);
+}
diff --git a/drivers/common/cnxk/roc_re_ml_tables.h b/drivers/common/cnxk/roc_re_ml_tables.h
new file mode 100644
index 0000000000..0a425f711d
--- /dev/null
+++ b/drivers/common/cnxk/roc_re_ml_tables.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2026 Marvell.
+ */
+
+#ifndef _ROC_RE_ML_TABLES_H_
+#define _ROC_RE_ML_TABLES_H_
+
+#include "roc_platform.h"
+
+enum roc_re_ml_zeta_idx {
+	ROC_RE_ML_ZETA_IDX_KEM = 0,
+	ROC_RE_ML_ZETA_IDX_DSA,
+	ROC_RE_ML_ZETA_IDX_MAX
+};
+
+int __roc_api roc_re_ml_zeta_get(uint64_t *tbl);
+void __roc_api roc_re_ml_zeta_put(void);
+
+#endif /* _ROC_RE_ML_TABLES_H_ */
diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index 21a0c8068a..691f9bfce5 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -10,6 +10,7 @@
 #include <rte_malloc.h>
 
 #include "roc_ae.h"
+#include "roc_re.h"
 
 #include "cnxk_cryptodev_ops.h"
 
@@ -24,8 +25,11 @@ struct cnxk_ae_sess {
 		struct rte_crypto_rsa_xform rsa_ctx;
 		struct rte_crypto_modex_xform mod_ctx;
 		struct roc_ae_ec_ctx ec_ctx;
+		struct rte_crypto_ml_kem_xform ml_kem_ctx;
+		struct rte_crypto_ml_dsa_xform ml_dsa_ctx;
 	};
 	uint64_t *cnxk_fpm_iova;
+	uint64_t *cnxk_ml_iova;
 	struct roc_ae_ec_group **ec_grp;
 	uint64_t cpt_inst_w4;
 	uint64_t cpt_inst_w7;
@@ -52,6 +56,15 @@ struct cnxk_ae_sess {
 	} hw_ctx __plt_aligned(ROC_ALIGN);
 };
 
+static const uint8_t mldsa_hash_algo[] = {
+	[RTE_CRYPTO_AUTH_SHA3_224] = 0xA,
+	[RTE_CRYPTO_AUTH_SHA3_256] = 0xB,
+	[RTE_CRYPTO_AUTH_SHA3_384] = 0xC,
+	[RTE_CRYPTO_AUTH_SHA3_512] = 0xD,
+	[RTE_CRYPTO_AUTH_SHAKE_128] = 0xE,
+	[RTE_CRYPTO_AUTH_SHAKE_256] = 0xF,
+};
+
 static __rte_always_inline void
 cnxk_ae_modex_param_normalize(uint8_t **data, size_t *len, size_t max)
 {
@@ -259,6 +272,32 @@ cnxk_ae_fill_ec_params(struct cnxk_ae_sess *sess, struct rte_crypto_asym_xform *
 	return 0;
 }
 
+static __rte_always_inline int
+cnxk_ae_fill_ml_kem_params(struct cnxk_ae_sess *sess,
+			   struct rte_crypto_asym_xform *xform)
+{
+	struct rte_crypto_ml_kem_xform *ml_kem = &sess->ml_kem_ctx;
+	if (xform->mlkem.type == RTE_CRYPTO_ML_KEM_NONE)
+		return -EINVAL;
+
+	ml_kem->type = xform->mlkem.type;
+	return 0;
+}
+
+static __rte_always_inline int
+cnxk_ae_fill_ml_dsa_params(struct cnxk_ae_sess *sess,
+			   struct rte_crypto_asym_xform *xform)
+{
+	struct rte_crypto_ml_dsa_xform *ml_dsa = &sess->ml_dsa_ctx;
+	if (xform->mldsa.type == RTE_CRYPTO_ML_DSA_NONE)
+		return -EINVAL;
+
+	ml_dsa->type = xform->mldsa.type;
+	ml_dsa->sign_deterministic = xform->mldsa.sign_deterministic;
+	ml_dsa->sign_prehash = xform->mldsa.sign_prehash;
+	return 0;
+}
+
 static __rte_always_inline int
 cnxk_ae_fill_session_parameters(struct cnxk_ae_sess *sess,
 				struct rte_crypto_asym_xform *xform)
@@ -284,6 +323,12 @@ cnxk_ae_fill_session_parameters(struct cnxk_ae_sess *sess,
 	case RTE_CRYPTO_ASYM_XFORM_EDDSA:
 		ret = cnxk_ae_fill_ec_params(sess, xform);
 		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+		ret = cnxk_ae_fill_ml_kem_params(sess, xform);
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+		ret = cnxk_ae_fill_ml_dsa_params(sess, xform);
+		break;
 	default:
 		return -ENOTSUP;
 	}
@@ -563,6 +608,280 @@ cnxk_ae_enqueue_rsa_op(struct rte_crypto_op *op, struct roc_ae_buf_ptr *meta_buf
 	return 0;
 }
 
+static __rte_always_inline int __rte_hot
+cnxk_ae_enqueue_ml_kem_op(struct rte_crypto_op *op, struct roc_ae_buf_ptr *meta_buf,
+		       struct cnxk_ae_sess *sess, struct cpt_inst_s *inst)
+{
+	size_t metabuf_len = cnxk_cpt_asym_get_mlen(), reqbuf_len;
+	struct rte_crypto_ml_kem_op *mlkem = &op->asym->mlkem;
+	union cpt_inst_w4 w4;
+	uint32_t dlen = 0;
+	uint16_t param2;
+	uint8_t *dptr;
+
+	/* Input buffer */
+	dptr = meta_buf->vaddr;
+	inst->dptr = (uintptr_t)dptr;
+
+	switch (mlkem->op) {
+	case RTE_CRYPTO_ML_KEM_OP_KEYGEN:
+		reqbuf_len = mlkem->keygen.d.length + mlkem->keygen.z.length;
+		if (reqbuf_len > (metabuf_len - dlen)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -ENOMEM;
+		}
+
+		memcpy(dptr, mlkem->keygen.d.data, mlkem->keygen.d.length);
+		dptr += mlkem->keygen.d.length;
+		memcpy(dptr, mlkem->keygen.z.data, mlkem->keygen.z.length);
+		dptr += mlkem->keygen.z.length;
+
+		dlen = mlkem->keygen.d.length + mlkem->keygen.z.length;
+		w4.s.opcode_major = ROC_RE_MAJOR_OP_MLKEM;
+		w4.s.opcode_minor = ROC_RE_MINOR_OP_MLKEM_KEYGEN;
+		param2 = sess->ml_kem_ctx.type;
+		param2 |= (!!dlen << ROC_RE_ML_KEM_PARAM2_INSEED_BIT);
+		break;
+	case RTE_CRYPTO_ML_KEM_OP_ENCAP:
+		reqbuf_len = mlkem->encap.message.length + mlkem->encap.ek.length;
+		if (reqbuf_len > (metabuf_len - dlen)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -ENOMEM;
+		}
+
+		memcpy(dptr, mlkem->encap.message.data, mlkem->encap.message.length);
+		dptr += mlkem->encap.message.length;
+		memcpy(dptr, mlkem->encap.ek.data, mlkem->encap.ek.length);
+		dptr += mlkem->encap.ek.length;
+
+		dlen = mlkem->encap.message.length + mlkem->encap.ek.length;
+		w4.s.opcode_major = ROC_RE_MAJOR_OP_MLKEM;
+		w4.s.opcode_minor = ROC_RE_MINOR_OP_MLKEM_ENCAP;
+		param2 = sess->ml_kem_ctx.type;
+		param2 |= (!!mlkem->encap.message.length << ROC_RE_ML_KEM_PARAM2_INMSG_BIT);
+		break;
+	case RTE_CRYPTO_ML_KEM_OP_DECAP:
+		reqbuf_len = mlkem->decap.dk.length + mlkem->decap.cipher.length;
+		if (reqbuf_len > (metabuf_len - dlen)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -ENOMEM;
+		}
+
+		memcpy(dptr, mlkem->decap.dk.data, mlkem->decap.dk.length);
+		dptr += mlkem->decap.dk.length;
+		memcpy(dptr, mlkem->decap.cipher.data, mlkem->decap.cipher.length);
+		dptr += mlkem->decap.cipher.length;
+
+		dlen = mlkem->decap.cipher.length + mlkem->decap.dk.length;
+		w4.s.opcode_major = ROC_RE_MAJOR_OP_MLKEM;
+		w4.s.opcode_minor = ROC_RE_MINOR_OP_MLKEM_DECAP;
+		param2 = sess->ml_kem_ctx.type;
+		break;
+	default:
+		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+		return -EINVAL;
+	}
+
+	w4.s.param1 = 0;
+	w4.s.param2 = param2;
+	w4.s.dlen = dlen;
+
+	inst->w4.u64 = w4.u64;
+
+	/* Reuse entire space of meta buffer as output is large in PQC */
+	inst->rptr = (uintptr_t)meta_buf->vaddr;
+
+	return 0;
+}
+
+static __rte_always_inline int __rte_hot
+cnxk_ae_enqueue_ml_dsa_op(struct rte_crypto_op *op, struct roc_ae_buf_ptr *meta_buf,
+		       struct cnxk_ae_sess *sess, struct cpt_inst_s *inst)
+{
+	size_t metabuf_len = cnxk_cpt_asym_get_mlen(), reqbuf_len;
+	struct rte_crypto_ml_dsa_op *mldsa = &op->asym->mldsa;
+	enum rte_crypto_auth_algorithm hash;
+	bool sign_deterministic;
+	union cpt_inst_w4 w4;
+	uint16_t param1 = 0;
+	uint32_t dlen = 0;
+	uint16_t param2;
+	uint8_t *dptr;
+	uint8_t minor;
+
+	/* Input buffer */
+	dptr = meta_buf->vaddr;
+	inst->dptr = (uintptr_t)dptr;
+
+	switch (mldsa->op) {
+	case RTE_CRYPTO_ML_DSA_OP_KEYGEN:
+		reqbuf_len = mldsa->keygen.seed.length;
+		if (reqbuf_len > (metabuf_len - dlen)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -ENOMEM;
+		}
+
+		param2 = sess->ml_dsa_ctx.type;
+
+		memcpy(dptr, mldsa->keygen.seed.data, mldsa->keygen.seed.length);
+		dptr += mldsa->keygen.seed.length;
+		param2 |= (!!mldsa->keygen.seed.length << ROC_RE_ML_DSA_PARAM2_SEED_BIT);
+
+		dlen += mldsa->keygen.seed.length;
+		w4.s.opcode_major = ROC_RE_MAJOR_OP_MLDSA;
+		w4.s.opcode_minor = ROC_RE_MINOR_OP_MLDSA_KEYGEN;
+		break;
+	case RTE_CRYPTO_ML_DSA_OP_SIGN:
+		reqbuf_len = mldsa->siggen.message.length + mldsa->siggen.privkey.length +
+			     mldsa->siggen.ctx.length + mldsa->siggen.mu.length +
+			     mldsa->siggen.seed.length;
+
+		if (reqbuf_len > (metabuf_len - dlen)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -ENOMEM;
+		}
+
+		sign_deterministic = sess->ml_dsa_ctx.sign_deterministic;
+		hash = op->asym->mldsa.siggen.hash;
+		minor = ROC_RE_MINOR_OP_MLDSA_SIGN;
+
+		param1 = mldsa->siggen.message.length;
+		param2 = sess->ml_dsa_ctx.type;
+		if (hash == 0) {
+			minor |= (0 << ROC_RE_ML_DSA_MINOR_MSG_TYPE_BIT);
+		} else if (mldsa->siggen.mu.length != 0) {
+			minor |= (3 << ROC_RE_ML_DSA_MINOR_MSG_TYPE_BIT);
+		} else {
+			if (!sess->ml_dsa_ctx.sign_prehash ||
+				hash >= RTE_DIM(mldsa_hash_algo) || mldsa_hash_algo[hash] == 0) {
+				op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+				return -EINVAL;
+			}
+
+			minor |= (1 << ROC_RE_ML_DSA_MINOR_MSG_TYPE_BIT);
+			param2 |= (mldsa_hash_algo[hash] << ROC_RE_ML_DSA_PARAM2_SIGN_BIT);
+		}
+
+		minor |= ((sign_deterministic ? 0 : 2) << ROC_RE_ML_DSA_MINOR_SIGN_TYPE_BIT);
+
+		if (!sign_deterministic) {
+			if (!mldsa->siggen.seed.length) {
+				op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+				return -EINVAL;
+			}
+
+			memcpy(dptr, mldsa->siggen.seed.data, mldsa->siggen.seed.length);
+			dptr += mldsa->siggen.seed.length;
+			dlen += mldsa->siggen.seed.length;
+		}
+
+		memcpy(dptr, mldsa->siggen.privkey.data, mldsa->siggen.privkey.length);
+		dptr += mldsa->siggen.privkey.length;
+		dlen += mldsa->siggen.privkey.length;
+
+		memcpy(dptr, mldsa->siggen.ctx.data, mldsa->siggen.ctx.length);
+		dptr += mldsa->siggen.ctx.length;
+		dlen += mldsa->siggen.ctx.length;
+		if (mldsa->siggen.ctx.length > (UINT16_MAX >> ROC_RE_ML_DSA_PARAM2_CTXN_BIT)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -EINVAL;
+		}
+		param2 |= ((uint16_t)mldsa->siggen.ctx.length
+				<< ROC_RE_ML_DSA_PARAM2_CTXN_BIT);
+
+		if (mldsa->siggen.mu.length != 0) {
+			memcpy(dptr, mldsa->siggen.mu.data, mldsa->siggen.mu.length);
+			dptr += mldsa->siggen.mu.length;
+			dlen += mldsa->siggen.mu.length;
+			param1 = mldsa->siggen.mu.length;
+		} else if (mldsa->siggen.message.length != 0) {
+			memcpy(dptr, mldsa->siggen.message.data, mldsa->siggen.message.length);
+			dptr += mldsa->siggen.message.length;
+			dlen += mldsa->siggen.message.length;
+		}
+
+		w4.s.opcode_major = ROC_RE_MAJOR_OP_MLDSA;
+		w4.s.opcode_minor = minor;
+		break;
+	case RTE_CRYPTO_ML_DSA_OP_VERIFY:
+		reqbuf_len = mldsa->sigver.message.length + mldsa->sigver.pubkey.length +
+			     mldsa->sigver.ctx.length + mldsa->sigver.mu.length +
+			     mldsa->sigver.sign.length;
+
+		if (reqbuf_len > (metabuf_len - dlen)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -ENOMEM;
+		}
+
+		hash = op->asym->mldsa.sigver.hash;
+		minor = ROC_RE_MINOR_OP_MLDSA_VERIFY;
+
+		param1 = mldsa->sigver.message.length;
+		param2 = sess->ml_dsa_ctx.type;
+		if (hash == 0) {
+			minor |= (0 << ROC_RE_ML_DSA_MINOR_MSG_TYPE_BIT);
+		} else if (mldsa->sigver.mu.length != 0) {
+			minor |= (3 << ROC_RE_ML_DSA_MINOR_MSG_TYPE_BIT);
+		} else {
+			if (!sess->ml_dsa_ctx.sign_prehash ||
+				hash >= RTE_DIM(mldsa_hash_algo) || mldsa_hash_algo[hash] == 0) {
+				op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+				return -EINVAL;
+			}
+
+			minor |= (1 << ROC_RE_ML_DSA_MINOR_MSG_TYPE_BIT);
+			param2 |= (mldsa_hash_algo[hash] << ROC_RE_ML_DSA_PARAM2_SIGN_BIT);
+		}
+
+		memcpy(dptr, mldsa->sigver.pubkey.data, mldsa->sigver.pubkey.length);
+		dptr += mldsa->sigver.pubkey.length;
+		dlen += mldsa->sigver.pubkey.length;
+
+		memcpy(dptr, mldsa->sigver.ctx.data, mldsa->sigver.ctx.length);
+		dptr += mldsa->sigver.ctx.length;
+		dlen += mldsa->sigver.ctx.length;
+		if (mldsa->sigver.ctx.length > (UINT16_MAX >> ROC_RE_ML_DSA_PARAM2_CTXN_BIT)) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			return -EINVAL;
+		}
+		param2 |= ((uint16_t)mldsa->sigver.ctx.length
+				<< ROC_RE_ML_DSA_PARAM2_CTXN_BIT);
+
+		if (mldsa->sigver.mu.length != 0) {
+			memcpy(dptr, mldsa->sigver.mu.data, mldsa->sigver.mu.length);
+			dptr += mldsa->sigver.mu.length;
+			dlen += mldsa->sigver.mu.length;
+			param1 = mldsa->sigver.mu.length;
+		} else if (mldsa->sigver.message.length != 0) {
+			memcpy(dptr, mldsa->sigver.message.data, mldsa->sigver.message.length);
+			dptr += mldsa->sigver.message.length;
+			dlen += mldsa->sigver.message.length;
+		}
+
+		memcpy(dptr, mldsa->sigver.sign.data, mldsa->sigver.sign.length);
+		dptr += mldsa->sigver.sign.length;
+		dlen += mldsa->sigver.sign.length;
+
+		w4.s.opcode_major = ROC_RE_MAJOR_OP_MLDSA;
+		w4.s.opcode_minor = minor;
+		break;
+	default:
+		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+		return -EINVAL;
+	}
+
+	w4.s.param1 = param1;
+	w4.s.param2 = param2;
+	w4.s.dlen = dlen;
+
+	inst->w4.u64 = w4.u64;
+
+	/* Reuse entire space of meta buffer as output is large in PQC */
+	inst->rptr = (uintptr_t)meta_buf->vaddr;
+
+	return 0;
+}
+
 static __rte_always_inline void
 cnxk_ae_ecdsa_sign_prep(struct rte_crypto_ecdsa_op_param *ecdsa,
 			struct roc_ae_buf_ptr *meta_buf,
@@ -1712,6 +2031,55 @@ cnxk_ae_dequeue_ecdh_op(struct rte_crypto_ecdh_op_param *ecdh, uint8_t *rptr,
 	}
 }
 
+static __rte_always_inline void
+cnxk_ae_dequeue_mlkem_op(struct rte_crypto_ml_kem_op *mlkem, uint8_t *rptr,
+	enum rte_crypto_ml_kem_type type)
+{
+	switch (mlkem->op) {
+	case RTE_CRYPTO_ML_KEM_OP_KEYGEN:
+		mlkem->keygen.dk.length = rte_crypto_ml_kem_privkey_size[type];
+		memcpy(mlkem->keygen.dk.data, rptr, mlkem->keygen.dk.length);
+		mlkem->keygen.ek.length = rte_crypto_ml_kem_pubkey_size[type];
+		memcpy(mlkem->keygen.ek.data, rptr + 384 * (type + 1), mlkem->keygen.ek.length);
+		break;
+	case RTE_CRYPTO_ML_KEM_OP_ENCAP:
+		mlkem->encap.sk.length = 32;
+		memcpy(mlkem->encap.sk.data, rptr, mlkem->encap.sk.length);
+		mlkem->encap.cipher.length = rte_crypto_ml_kem_cipher_size[type];
+		memcpy(mlkem->encap.cipher.data, rptr + 32, mlkem->encap.cipher.length);
+		break;
+	case RTE_CRYPTO_ML_KEM_OP_DECAP:
+		mlkem->decap.sk.length = 32;
+		memcpy(mlkem->decap.sk.data, rptr, mlkem->decap.sk.length);
+		break;
+	default:
+		break;
+	}
+}
+
+static __rte_always_inline void
+cnxk_ae_dequeue_mldsa_op(struct rte_crypto_ml_dsa_op *mldsa, uint8_t *rptr,
+	enum rte_crypto_ml_dsa_type type)
+{
+	switch (mldsa->op) {
+	case RTE_CRYPTO_ML_DSA_OP_KEYGEN:
+		mldsa->keygen.pubkey.length = rte_crypto_ml_dsa_pubkey_size[type];
+		memcpy(mldsa->keygen.pubkey.data, rptr, mldsa->keygen.pubkey.length);
+		mldsa->keygen.privkey.length = rte_crypto_ml_dsa_privkey_size[type];
+		memcpy(mldsa->keygen.privkey.data, rptr + mldsa->keygen.pubkey.length,
+		       mldsa->keygen.privkey.length);
+		break;
+	case RTE_CRYPTO_ML_DSA_OP_SIGN:
+		mldsa->siggen.sign.length = rte_crypto_ml_dsa_sign_size[type];
+		memcpy(mldsa->siggen.sign.data, rptr, mldsa->siggen.sign.length);
+		break;
+	case RTE_CRYPTO_ML_DSA_OP_VERIFY:
+		break;
+	default:
+		break;
+	}
+}
+
 static __rte_always_inline void *
 cnxk_ae_alloc_meta(struct roc_ae_buf_ptr *buf,
 		   struct rte_mempool *cpt_meta_pool,
@@ -1752,56 +2120,46 @@ cnxk_ae_enqueue(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 	switch (sess->xfrm_type) {
 	case RTE_CRYPTO_ASYM_XFORM_MODEX:
 		ret = cnxk_ae_modex_prep(op, &meta_buf, &sess->mod_ctx, inst);
-		if (unlikely(ret))
-			goto req_fail;
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_RSA:
 		ret = cnxk_ae_enqueue_rsa_op(op, &meta_buf, sess, inst);
-		if (unlikely(ret))
-			goto req_fail;
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_ECDSA:
 		ret = cnxk_ae_enqueue_ecdsa_op(op, &meta_buf, sess,
 					       sess->cnxk_fpm_iova,
 					       sess->ec_grp, inst);
-		if (unlikely(ret))
-			goto req_fail;
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_EDDSA:
 		ret = cnxk_ae_enqueue_eddsa_op(op, &meta_buf, sess,
 					       sess->cnxk_fpm_iova,
 					       sess->ec_grp, inst);
-		if (unlikely(ret))
-			goto req_fail;
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_SM2:
 		ret = cnxk_ae_enqueue_sm2_op(op, &meta_buf, sess,
 					       sess->cnxk_fpm_iova,
 					       sess->ec_grp, inst);
-		if (unlikely(ret))
-			goto req_fail;
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_ECPM:
 		ret = cnxk_ae_ecpm_prep(&asym_op->ecpm.scalar, &asym_op->ecpm.p, &meta_buf,
 					sess->ec_grp[sess->ec_ctx.curveid],
 					sess->ec_ctx.curveid, inst);
-		if (unlikely(ret))
-			goto req_fail;
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_ECFPM:
 		ret = cnxk_ae_ecfpm_prep(&asym_op->ecpm.scalar, &meta_buf,
 					 sess->cnxk_fpm_iova,
 					 sess->ec_grp[sess->ec_ctx.curveid],
 					 sess->ec_ctx.curveid, inst);
-		if (unlikely(ret))
-			goto req_fail;
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_ECDH:
 		ret = cnxk_ae_enqueue_ecdh_op(op, &meta_buf, sess,
 					       sess->cnxk_fpm_iova,
 					       sess->ec_grp, inst);
-		if (unlikely(ret))
-			goto req_fail;
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+		ret = cnxk_ae_enqueue_ml_kem_op(op, &meta_buf, sess, inst);
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+		ret = cnxk_ae_enqueue_ml_dsa_op(op, &meta_buf, sess, inst);
 		break;
 	default:
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
@@ -1809,6 +2167,9 @@ cnxk_ae_enqueue(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 		goto req_fail;
 	}
 
+	if (unlikely(ret))
+		goto req_fail;
+
 	mop = mdata;
 	mop[0] = inst->rptr;
 	return 0;
@@ -1852,6 +2213,12 @@ cnxk_ae_post_process(struct rte_crypto_op *cop, struct cnxk_ae_sess *sess,
 		cnxk_ae_dequeue_ecdh_op(&op->ecdh, rptr, &sess->ec_ctx,
 					sess->ec_grp, op->flags);
 		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+		cnxk_ae_dequeue_mlkem_op(&op->mlkem, rptr, sess->ml_kem_ctx.type);
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+		cnxk_ae_dequeue_mldsa_op(&op->mldsa, rptr, sess->ml_dsa_ctx.type);
+		break;
 	default:
 		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		break;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev.c b/drivers/crypto/cnxk/cnxk_cryptodev.c
index 5828a502e4..de27c4a580 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev.c
@@ -28,6 +28,9 @@ cnxk_cpt_default_ff_get(void)
 	if (roc_model_is_cn10ka_b0() || roc_model_is_cn10kb() || roc_model_is_cn20k())
 		ff |= RTE_CRYPTODEV_FF_SECURITY_RX_INJECT;
 
+	if (roc_model_is_cn20k())
+		ff |= RTE_CRYPTODEV_FF_MLDSA_SIGN_PREHASH;
+
 	return ff;
 }
 
@@ -56,6 +59,14 @@ cnxk_cpt_eng_grp_add(struct roc_cpt *roc_cpt)
 		return -ENOTSUP;
 	}
 
+	if (roc_model_is_cn20k()) {
+		ret = roc_cpt_eng_grp_add(roc_cpt, CPT_ENG_TYPE_RE);
+		if (ret < 0) {
+			plt_err("Could not add CPT RE engines");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev.h b/drivers/crypto/cnxk/cnxk_cryptodev.h
index f88162ad3c..bdc5752905 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev.h
@@ -10,8 +10,9 @@
 
 #include "roc_ae.h"
 #include "roc_cpt.h"
+#include "roc_re_ml_tables.h"
 
-#define CNXK_CPT_MAX_CAPS		 60
+#define CNXK_CPT_MAX_CAPS		 62
 #define CNXK_SEC_IPSEC_CRYPTO_MAX_CAPS	 16
 #define CNXK_SEC_TLS_1_3_CRYPTO_MAX_CAPS 3
 #define CNXK_SEC_TLS_1_2_CRYPTO_MAX_CAPS 7
@@ -33,6 +34,7 @@ struct cnxk_cpt_vf {
 		sec_dtls_1_2_crypto_caps[CNXK_SEC_TLS_1_2_CRYPTO_MAX_CAPS];
 	struct rte_security_capability sec_caps[CNXK_SEC_MAX_CAPS];
 	uint64_t cnxk_fpm_iova[ROC_AE_EC_ID_PMAX];
+	uint64_t cnxk_ml_iova[ROC_RE_ML_ZETA_IDX_MAX];
 	struct roc_ae_ec_group *ec_grp[ROC_AE_EC_ID_PMAX];
 	uint16_t max_qps_limit;
 	uint16_t rx_inject_qp;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index be6d383717..736d588bde 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -129,6 +129,63 @@ static const struct rte_cryptodev_capabilities caps_mul[] = {
 	},
 };
 
+static const struct rte_cryptodev_capabilities caps_pqc[] = {
+	{
+		/* ML-KEM */
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
+		.asym = {
+			.xform_capa = {
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_KEM,
+				.op_types =
+				((1 << RTE_CRYPTO_ML_KEM_OP_KEYGEN) |
+				 (1 << RTE_CRYPTO_ML_KEM_OP_ENCAP) |
+				 (1 << RTE_CRYPTO_ML_KEM_OP_DECAP)),
+				.mlkem_capa = {
+					[RTE_CRYPTO_ML_KEM_OP_KEYGEN] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024),
+					[RTE_CRYPTO_ML_KEM_OP_ENCAP] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024),
+					[RTE_CRYPTO_ML_KEM_OP_DECAP] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024)
+				}
+			}
+		}
+	},
+	{
+		/* ML-DSA */
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
+		.asym = {
+			.xform_capa = {
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_DSA,
+				.op_types =
+				((1 << RTE_CRYPTO_ML_DSA_OP_SIGN) |
+				 (1 << RTE_CRYPTO_ML_DSA_OP_KEYGEN) |
+				 (1 << RTE_CRYPTO_ML_DSA_OP_VERIFY)),
+				.mldsa_capa = {
+					[RTE_CRYPTO_ML_DSA_OP_KEYGEN] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87),
+					[RTE_CRYPTO_ML_DSA_OP_SIGN] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87),
+					[RTE_CRYPTO_ML_DSA_OP_VERIFY] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87)
+				}
+			}
+		}
+	},
+};
+
 static const struct rte_cryptodev_capabilities caps_sha1_sha2[] = {
 	{	/* SHA1 */
 		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
@@ -2079,10 +2136,13 @@ crypto_caps_populate(struct rte_cryptodev_capabilities cnxk_caps[],
 	if (roc_model_is_cn10k() || roc_model_is_cn20k())
 		cn10k_20k_crypto_caps_add(cnxk_caps, hw_caps, &cur_pos);
 
-	if (roc_model_is_cn20k())
+	if (roc_model_is_cn20k()) {
 		CPT_CAPS_ADD(cnxk_caps, &cur_pos, hw_caps, zuc256_snow5g);
+		cpt_caps_add(cnxk_caps, &cur_pos, caps_pqc, RTE_DIM(caps_pqc));
+	}
 
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_null, RTE_DIM(caps_null));
+
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_end, RTE_DIM(caps_end));
 
 	if (roc_model_is_cn10k() || roc_model_is_cn20k())
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index d3cf1ddd57..ab4115d4dd 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -23,6 +23,7 @@
 #else
 #include "roc_io_generic.h"
 #endif
+#include "roc_re_ml_tables.h"
 
 #include "cnxk_ae.h"
 #include "cnxk_cryptodev.h"
@@ -41,6 +42,14 @@
 
 #define CNXK_CPT_MAX_ASYM_OP_NUM_PARAMS	 5
 #define CNXK_CPT_MAX_ASYM_OP_MOD_LEN	 1024
+
+/*
+ * PQC requests currently use a shared metabuf region for concatenated input
+ * and output. ML-DSA-87 SIGN requires at least 9523 bytes for private key
+ * input plus signature output, along with additional space for message and
+ * context parameters, so set it for the possible max.
+ */
+#define CNXK_CPT_MAX_ASYM_OP_PQC_LEN	 16384
 #define CNXK_CPT_META_BUF_MAX_CACHE_SIZE 128
 
 static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P192 == (uint16_t)ROC_AE_EC_ID_P192,
@@ -107,7 +116,10 @@ cnxk_cpt_asym_get_mlen(void)
 	len = sizeof(uint64_t);
 
 	/* Get meta len for asymmetric operations */
-	len += CNXK_CPT_MAX_ASYM_OP_NUM_PARAMS * CNXK_CPT_MAX_ASYM_OP_MOD_LEN;
+	if (roc_model_is_cn20k())
+		len += CNXK_CPT_MAX_ASYM_OP_PQC_LEN;
+	else
+		len += CNXK_CPT_MAX_ASYM_OP_NUM_PARAMS * CNXK_CPT_MAX_ASYM_OP_MOD_LEN;
 
 	return len;
 }
@@ -121,6 +133,8 @@ cnxk_cpt_dev_clear(struct rte_cryptodev *dev)
 	if (dev->feature_flags & RTE_CRYPTODEV_FF_ASYMMETRIC_CRYPTO) {
 		roc_ae_fpm_put();
 		roc_ae_ec_grp_put();
+		if (roc_model_is_cn20k())
+			roc_re_ml_zeta_put();
 	}
 
 	ret = roc_cpt_int_misc_cb_unregister(cnxk_cpt_int_misc_cb, NULL);
@@ -182,8 +196,15 @@ cnxk_cpt_dev_config(struct rte_cryptodev *dev, struct rte_cryptodev_config *conf
 		ret = roc_ae_ec_grp_get(vf->ec_grp);
 		if (ret) {
 			plt_err("Could not get EC grp table");
-			roc_ae_fpm_put();
-			return ret;
+			goto fpm_put;
+		}
+
+		if (roc_model_is_cn20k()) {
+			ret = roc_re_ml_zeta_get(vf->cnxk_ml_iova);
+			if (ret) {
+				plt_err("Could not initialize RE ML lookup table");
+				goto ec_grp_put;
+			}
 		}
 	}
 	roc_cpt->opaque = dev;
@@ -191,6 +212,12 @@ cnxk_cpt_dev_config(struct rte_cryptodev *dev, struct rte_cryptodev_config *conf
 	roc_cpt_int_misc_cb_register(cnxk_cpt_int_misc_cb, NULL);
 
 	return 0;
+
+ec_grp_put:
+	roc_ae_ec_grp_put();
+fpm_put:
+	roc_ae_fpm_put();
+	return ret;
 }
 
 int
@@ -992,7 +1019,16 @@ cnxk_ae_session_cfg(struct rte_cryptodev *dev, struct rte_crypto_asym_xform *xfo
 	priv->lf = roc_cpt->lf[0];
 
 	w7.u64 = 0;
-	w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_AE];
+	if (xform->xform_type == RTE_CRYPTO_ASYM_XFORM_ML_KEM) {
+		w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_RE];
+		w7.s.cptr = rte_cpu_to_be_64(vf->cnxk_ml_iova[ROC_RE_ML_ZETA_IDX_KEM]);
+	} else if (xform->xform_type == RTE_CRYPTO_ASYM_XFORM_ML_DSA) {
+		w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_RE];
+		w7.s.cptr = rte_cpu_to_be_64(vf->cnxk_ml_iova[ROC_RE_ML_ZETA_IDX_DSA]);
+	} else {
+		w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_AE];
+		w7.s.cptr = 0;
+	}
 
 	if (roc_errata_cpt_hang_on_mixed_ctx_val()) {
 		hwc = &priv->hw_ctx;
@@ -1007,6 +1043,7 @@ cnxk_ae_session_cfg(struct rte_cryptodev *dev, struct rte_crypto_asym_xform *xfo
 
 	priv->cpt_inst_w7 = w7.u64;
 	priv->cnxk_fpm_iova = vf->cnxk_fpm_iova;
+	priv->cnxk_ml_iova = vf->cnxk_ml_iova;
 	priv->ec_grp = vf->ec_grp;
 
 	return 0;
-- 
2.37.1


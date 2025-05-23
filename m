Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A4C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:53:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B20F40E18;
	Fri, 23 May 2025 15:52:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D906140DFB
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:29 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBkv4o010735
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 o1ORhVz5s8mVXPkPwtc+O7UH1xg75hWSNHpgBrfw8I=; b=ipcPcOe01gQhHBwQc
 2v+NJwcjtnXPbNTU6zrbr9QJ45qXdaBxukM21cweBwE5ypLc4XPk/ZBFxhnJynqz
 cnJwvRnkGa+dOm752IvwwmpVp391UrdUyy2gbE2nj9yY0DzlS3twKbT2Q5b9o4/1
 GRAWUv0qhSKY4QdUd4j1/F6xk0DT51tZATR6CddHh/TlPD0ExeGdMgbGDUh+NSkh
 4wW/zylRaLNEs0Vd4YT9OekJ2BxeSOR/XE7bMF85pODq6kUt6GxTJic7tFgFoqSa
 pU+04DSEZ5TZYh1RtPgkKQhI/eqKCF1Etr26LAC8xV7NDzce5Ou1SusqtKHZnTsy
 LCgKA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tmgp8ssf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:27 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 58C875B6927;
 Fri, 23 May 2025 06:52:24 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 22/40] crypto/cnxk: add skeleton for tls
Date: Fri, 23 May 2025 19:20:53 +0530
Message-ID: <20250523135111.2178408-23-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jnXkX_vbxL3Sm2x31f3K_YcMBrctfRrU
X-Proofpoint-ORIG-GUID: jnXkX_vbxL3Sm2x31f3K_YcMBrctfRrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX55LLCCTretm8
 779fhll0VFi05NOZ3/EzBP7KQd2G1HWRjKl9kb2Akirn7YZJibZhy++uvUi0+mk2hp1r9qS0sNS
 nQDGRoQ96p2HejnIySIlWsdGkoa/kbBXJwSwc/EtnOMsn0kAiIB2FfVcPzdlqgPyzv/7EgX4KQ+
 9fOS7y3VhaS4NXASJ/Z6oik4w/ZsJH0L4tN7Rbnf5mMIQKDxwU4pAWWmsYBqMl1sgJaF3yaUN89
 LhQzpGdeB0j7XV+UB6Wkic1dhP04ACSDfK7YTq6AcmYZaEURAMbXFnsrD0B/lklUiDoGyWlDt0a
 EIzAVHZQRw8s0J6rQdQ0zD/MnvAfdbx05r6Knlhza7ueSf2cwv8zl98Dh+xiAF3lOmuwHAXhZ+m
 pcIZlKU/3uVZgDsZSlKksIQnhuU7imPUBpSKbQyr8k7z19JrqhT0f0InMcz50SHYfQbFIt/3
X-Authority-Analysis: v=2.4 cv=KYPSsRYD c=1 sm=1 tr=0 ts=68307d9c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=_WyLJemfGRsr6S8wcwYA:9
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

Add skeleton for tls support for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/common/cnxk/roc_ie_ow_tls.h | 233 ++++++++++++++++++++++++++++
 drivers/crypto/cnxk/cn20k_tls.c     |  56 +++++++
 drivers/crypto/cnxk/cn20k_tls.h     |  40 +++++
 drivers/crypto/cnxk/meson.build     |   1 +
 4 files changed, 330 insertions(+)
 create mode 100644 drivers/common/cnxk/roc_ie_ow_tls.h
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.c
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.h

diff --git a/drivers/common/cnxk/roc_ie_ow_tls.h b/drivers/common/cnxk/roc_ie_ow_tls.h
new file mode 100644
index 0000000000..d2338926cc
--- /dev/null
+++ b/drivers/common/cnxk/roc_ie_ow_tls.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __ROC_IE_OW_TLS_H__
+#define __ROC_IE_OW_TLS_H__
+
+#include "roc_platform.h"
+
+#define ROC_IE_OW_TLS_CTX_ILEN		     1
+#define ROC_IE_OW_TLS_CTX_HDR_SIZE	     1
+#define ROC_IE_OW_TLS_AR_WIN_SIZE_MAX	     4096
+#define ROC_IE_OW_TLS_LOG_MIN_AR_WIN_SIZE_M1 5
+
+/* u64 array size to fit anti replay window bits */
+#define ROC_IE_OW_TLS_AR_WINBITS_SZ                                                                \
+	(PLT_ALIGN_CEIL(ROC_IE_OW_TLS_AR_WIN_SIZE_MAX, BITS_PER_LONG_LONG) / BITS_PER_LONG_LONG)
+
+/* CN20K TLS opcodes */
+#define ROC_IE_OW_TLS_MAJOR_OP_RECORD_ENC   0x16UL
+#define ROC_IE_OW_TLS_MAJOR_OP_RECORD_DEC   0x17UL
+#define ROC_IE_OW_TLS13_MAJOR_OP_RECORD_ENC 0x18UL
+#define ROC_IE_OW_TLS13_MAJOR_OP_RECORD_DEC 0x19UL
+
+#define ROC_IE_OW_TLS_CTX_MAX_OPAD_IPAD_LEN 128
+#define ROC_IE_OW_TLS_CTX_MAX_KEY_IV_LEN    48
+#define ROC_IE_OW_TLS_CTX_MAX_IV_LEN	    16
+
+enum roc_ie_ow_tls_mac_type {
+	ROC_IE_OW_TLS_MAC_MD5 = 1,
+	ROC_IE_OW_TLS_MAC_SHA1 = 2,
+	ROC_IE_OW_TLS_MAC_SHA2_256 = 4,
+	ROC_IE_OW_TLS_MAC_SHA2_384 = 5,
+	ROC_IE_OW_TLS_MAC_SHA2_512 = 6,
+};
+
+enum roc_ie_ow_tls_cipher_type {
+	ROC_IE_OW_TLS_CIPHER_3DES = 1,
+	ROC_IE_OW_TLS_CIPHER_AES_CBC = 3,
+	ROC_IE_OW_TLS_CIPHER_AES_GCM = 7,
+	ROC_IE_OW_TLS_CIPHER_AES_CCM = 10,
+	ROC_IE_OW_TLS_CIPHER_CHACHA_POLY = 9,
+};
+
+enum roc_ie_ow_tls_ver {
+	ROC_IE_OW_TLS_VERSION_TLS_12 = 1,
+	ROC_IE_OW_TLS_VERSION_DTLS_12 = 2,
+	ROC_IE_OW_TLS_VERSION_TLS_13 = 3,
+};
+
+enum roc_ie_ow_tls_aes_key_len {
+	ROC_IE_OW_TLS_AES_KEY_LEN_128 = 1,
+	ROC_IE_OW_TLS_AES_KEY_LEN_256 = 3,
+};
+
+enum {
+	ROC_IE_OW_TLS_IV_SRC_DEFAULT = 0,
+	ROC_IE_OW_TLS_IV_SRC_FROM_SA = 1,
+};
+
+struct roc_ie_ow_tls_read_ctx_update_reg {
+	uint64_t ar_base;
+	uint64_t ar_valid_mask;
+	uint64_t hard_life;
+	uint64_t soft_life;
+	uint64_t mib_octs;
+	uint64_t mib_pkts;
+	uint64_t ar_winbits[ROC_IE_OW_TLS_AR_WINBITS_SZ];
+};
+
+struct roc_ie_ow_tls_1_3_read_ctx_update_reg {
+	uint64_t rsvd0;
+	uint64_t ar_valid_mask;
+	uint64_t hard_life;
+	uint64_t soft_life;
+	uint64_t mib_octs;
+	uint64_t mib_pkts;
+	uint64_t rsvd1;
+};
+
+union roc_ie_ow_tls_param2 {
+	uint16_t u16;
+	struct {
+		uint8_t msg_type;
+		uint8_t rsvd;
+	} s;
+};
+
+struct roc_ie_ow_tls_read_sa {
+	/* Word0 */
+	union {
+		struct {
+			uint64_t ar_win : 3;
+			uint64_t hard_life_dec : 1;
+			uint64_t soft_life_dec : 1;
+			uint64_t count_glb_octets : 1;
+			uint64_t count_glb_pkts : 1;
+			uint64_t count_mib_bytes : 1;
+
+			uint64_t count_mib_pkts : 1;
+			uint64_t hw_ctx_off : 7;
+
+			uint64_t ctx_id : 16;
+
+			uint64_t orig_pkt_fabs : 1;
+			uint64_t orig_pkt_free : 1;
+			uint64_t pkind : 6;
+
+			uint64_t rsvd0 : 1;
+			uint64_t et_ovrwr : 1;
+			uint64_t pkt_output : 2;
+			uint64_t pkt_format : 1;
+			uint64_t defrag_opt : 2;
+			uint64_t x2p_dst : 1;
+
+			uint64_t ctx_push_size : 7;
+			uint64_t rsvd1 : 1;
+
+			uint64_t ctx_hdr_size : 2;
+			uint64_t aop_valid : 1;
+			uint64_t rsvd2 : 1;
+			uint64_t ctx_size : 4;
+		} s;
+		uint64_t u64;
+	} w0;
+
+	/* Word1 */
+	uint64_t w1_rsvd3;
+
+	/* Word2 */
+	union {
+		struct {
+			uint64_t version_select : 4;
+			uint64_t aes_key_len : 2;
+			uint64_t cipher_select : 4;
+			uint64_t mac_select : 4;
+			uint64_t rsvd4 : 50;
+		} s;
+		uint64_t u64;
+	} w2;
+
+	/* Word3 */
+	uint64_t w3_rsvd5;
+
+	/* Word4 - Word9 */
+	uint8_t cipher_key[ROC_IE_OW_TLS_CTX_MAX_KEY_IV_LEN];
+
+	union {
+		struct {
+			/* Word10 - Word16 */
+			struct roc_ie_ow_tls_1_3_read_ctx_update_reg ctx;
+		} tls_13;
+
+		struct {
+			/* Word10 - Word25 */
+			uint8_t opad_ipad[ROC_IE_OW_TLS_CTX_MAX_OPAD_IPAD_LEN];
+
+			/* Word26 - Word95 */
+			struct roc_ie_ow_tls_read_ctx_update_reg ctx;
+		} tls_12;
+	};
+};
+
+struct roc_ie_ow_tls_write_sa {
+	/* Word0 */
+	union {
+		struct {
+			uint64_t rsvd0 : 3;
+			uint64_t hard_life_dec : 1;
+			uint64_t soft_life_dec : 1;
+			uint64_t count_glb_octets : 1;
+			uint64_t count_glb_pkts : 1;
+			uint64_t count_mib_bytes : 1;
+
+			uint64_t count_mib_pkts : 1;
+			uint64_t hw_ctx_off : 7;
+
+			uint64_t rsvd1 : 32;
+
+			uint64_t ctx_push_size : 7;
+			uint64_t rsvd2 : 1;
+
+			uint64_t ctx_hdr_size : 2;
+			uint64_t aop_valid : 1;
+			uint64_t rsvd3 : 1;
+			uint64_t ctx_size : 4;
+		} s;
+		uint64_t u64;
+	} w0;
+
+	/* Word1 */
+	uint64_t w1_rsvd4;
+
+	/* Word2 */
+	union {
+		struct {
+			uint64_t version_select : 4;
+			uint64_t aes_key_len : 2;
+			uint64_t cipher_select : 4;
+			uint64_t mac_select : 4;
+			uint64_t iv_at_cptr : 1;
+			uint64_t rsvd5 : 49;
+		} s;
+		uint64_t u64;
+	} w2;
+
+	/* Word3 */
+	uint64_t w3_rsvd6;
+
+	/* Word4 - Word9 */
+	uint8_t cipher_key[ROC_IE_OW_TLS_CTX_MAX_KEY_IV_LEN];
+
+	union {
+		struct {
+			/* Word10 */
+			uint64_t w10_rsvd7;
+
+			uint64_t seq_num;
+		} tls_13;
+
+		struct {
+			/* Word10 - Word25 */
+			uint8_t opad_ipad[ROC_IE_OW_TLS_CTX_MAX_OPAD_IPAD_LEN];
+
+			/* Word26 */
+			uint64_t w26_rsvd7;
+
+			/* Word27 */
+			uint64_t seq_num;
+		} tls_12;
+	};
+};
+#endif /* __ROC_IE_OW_TLS_H__ */
diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
new file mode 100644
index 0000000000..cef13a68a4
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <rte_crypto_sym.h>
+#include <rte_cryptodev.h>
+#include <rte_security.h>
+
+#include <cryptodev_pmd.h>
+
+#include "roc_cpt.h"
+#include "roc_se.h"
+
+#include "cn20k_cryptodev_sec.h"
+#include "cn20k_tls.h"
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_ops.h"
+#include "cnxk_security.h"
+
+int
+cn20k_tls_record_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+				struct cn20k_sec_session *sess,
+				struct rte_security_session_conf *conf)
+{
+	RTE_SET_USED(vf);
+	RTE_SET_USED(qp);
+	RTE_SET_USED(sess);
+	RTE_SET_USED(conf);
+
+	return 0;
+}
+
+int
+cn20k_tls_record_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+				struct rte_security_tls_record_xform *tls_xfrm,
+				struct rte_crypto_sym_xform *crypto_xfrm,
+				struct rte_security_session *sess)
+{
+	RTE_SET_USED(vf);
+	RTE_SET_USED(qp);
+	RTE_SET_USED(tls_xfrm);
+	RTE_SET_USED(crypto_xfrm);
+	RTE_SET_USED(sess);
+
+	return 0;
+}
+
+int
+cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess)
+{
+
+	RTE_SET_USED(qp);
+	RTE_SET_USED(sess);
+
+	return 0;
+}
diff --git a/drivers/crypto/cnxk/cn20k_tls.h b/drivers/crypto/cnxk/cn20k_tls.h
new file mode 100644
index 0000000000..27124602a0
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_tls.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __CN20K_TLS_H__
+#define __CN20K_TLS_H__
+
+#include <rte_crypto_sym.h>
+#include <rte_security.h>
+
+#include "roc_ie_ow_tls.h"
+
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_ops.h"
+
+/* Forward declaration */
+struct cn20k_sec_session;
+
+struct __rte_aligned(ROC_ALIGN) cn20k_tls_record
+{
+	union {
+		/** Read SA */
+		struct roc_ie_ow_tls_read_sa read_sa;
+		/** Write SA */
+		struct roc_ie_ow_tls_write_sa write_sa;
+	};
+};
+
+int cn20k_tls_record_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+				    struct cn20k_sec_session *sess,
+				    struct rte_security_session_conf *conf);
+
+int cn20k_tls_record_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+				    struct rte_security_tls_record_xform *tls_xfrm,
+				    struct rte_crypto_sym_xform *crypto_xfrm,
+				    struct rte_security_session *sess);
+
+int cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess);
+
+#endif /* __CN20K_TLS_H__ */
diff --git a/drivers/crypto/cnxk/meson.build b/drivers/crypto/cnxk/meson.build
index f8077e4d4c..912c4a0851 100644
--- a/drivers/crypto/cnxk/meson.build
+++ b/drivers/crypto/cnxk/meson.build
@@ -21,6 +21,7 @@ sources = files(
         'cn20k_cryptodev_ops.c',
         'cn20k_cryptodev_sec.c',
         'cn20k_ipsec.c',
+        'cn20k_tls.c',
         'cnxk_cryptodev.c',
         'cnxk_cryptodev_capabilities.c',
         'cnxk_cryptodev_devargs.c',
-- 
2.25.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF6FC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 463AF40DDC;
	Tue, 27 May 2025 13:02:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C251940DDD
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:47 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNs0Gl007051
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 o1ORhVz5s8mVXPkPwtc+O7UH1xg75hWSNHpgBrfw8I=; b=U/pgV8ImzMYBgWwtk
 qgd820eKplBHTlhNloFLTGNt6yRjgahDWhA3cyOizeLf6ZO/5ThfHckBCyd7mebn
 jCQlh2j2h6tlo07cuR8R0FXpBS0kF42FLn9B6UROHynMbrMUmDKaI4BtGMtf7BRu
 1QGPZGmnz0VCBb0KvzJ/YUKUfTGsMJWw+7q4r6dBkqsxw/rgrvN/d7IwgeDzCF7s
 rmSiytnEa63zZ5z/m3r1WmxQP8/mDB4DhqTE2SRbaR6sQ3t7EXuzbBPPSbUlsdO7
 EBTicSmOQ4ILwBjAOwcu3rjy8vxYxldV26zxL3haUhtiyWVoWCaeapi4N+euDHwP
 Hko+w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21293r2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:46 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 375DC3F706A;
 Tue, 27 May 2025 04:02:43 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 16/25] crypto/cnxk: add skeleton for tls
Date: Tue, 27 May 2025 16:31:56 +0530
Message-ID: <20250527110205.2300800-17-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68359bd7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=_WyLJemfGRsr6S8wcwYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: _7DZi3laWYMszJuBOtT8D9BCDS2yExIp
X-Proofpoint-ORIG-GUID: _7DZi3laWYMszJuBOtT8D9BCDS2yExIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfXx7JSpd7R0nhe
 nfUPzt0xg9Kb+NjLENEx5Y0wnUPB9Gels3vi3oBQYR28mf4CKy6kCBcFomMzHeoqN3y0T8l65MO
 ayFhw+9RO2T+5muxoSWWeiWQhszaQcRLt/iSZIH4eLTkMVBhwIf8Z/oTM2ou1lycEzTffvM6xOB
 ky1+hQBlj3oB2qyoMA7Xhx1yJNjQgVFxZpXooX6Ll4WpkcsMIMUZnnNhvgd+Vsmo6yMJMdV+/r1
 wCL2MKg3pPKAKe4sInGpjDDcQkWjmSBBQtvB+ThId59ZWZphBWhkmWIT/0sN+AI4xrschOD3Ym6
 ApQReFwoOxY9wCaOzbgh3wBFWPPmOevnpaU38iGETqVuPyyP/McKGoMfUU+odK+HGED4lc+ujdK
 mrZsJNiVzAhJWff9rOOk1qWIRSypEKoFP88nh10T8kxY2JYWBIZnHFw8/7K7zoMv3t8nJR7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB5CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96E0540670;
	Thu, 21 Aug 2025 06:53:28 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E550B4066A
 for <dev@dpdk.org>; Thu, 21 Aug 2025 06:53:26 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L4eL0Q009330
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 g8cg5ZkM7PP9i/nwcmGRvSG7uRGGx2+hhxC8PXr4Ck=; b=kn14onyi3vGFPmHWx
 U/C4jDn1aZwZUoN+IOnAP83F5tYTgGBbAnvint1j9LA4w06GdeFRogJXIXSdS4Ie
 Lps5WSW4p8jllVt5tuEjuTgYzCyJP0c1yS1XE/BjQ0msvtfFRCu+w/iijfLNEUao
 GlGhkKZUifB9vt2pE9b39DNLwSXNVbJ3WbOc/2f16BJ9jvB0ouQJroJWD+eF3/x4
 khJSOujxNiKVcwYdnHBlCW0doEubhSyK1JeAfM2pKHzslTn7PYkDwqQzjhjReJUO
 L1O8BTWXzUxObJJtY4gbk2k4JIgX2jZg4M789UGIFT7k8ni16cfInlTfdBp5JImt
 Kn7JQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nvm5r0nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:29 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 52DA73F708F;
 Wed, 20 Aug 2025 21:53:21 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 4/8] crypto/cnxk: add new API to get EC grp tbl address
Date: Thu, 21 Aug 2025 10:22:56 +0530
Message-ID: <20250821045300.3787899-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821045300.3787899-1-ktejasree@marvell.com>
References: <20250821045300.3787899-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ui0DcRXF5C5Mp3IwAXgPkrk_CatNM3Ep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfXzhJAzvXcrICR
 67r6u5WP48lu9KksL0FAlM/qR741cgZypBvk1PbFvd894JD/XE5OpggC24HIykmhQiU3oXWoJRb
 6XBymhqoRKo2lcuC+1hu7GOeW4QCF8LQxbH3vV0uY5dyXrnLWhXCfGK4bs8TOiJR6BRbk69V2BM
 Ga8su557eMci8btc0aN07YrM/igHdv0EVZJ4hP8fZ1bI4vgwL8IprypPDz+mTs93+s3hzI6agsy
 EphmCCto7jTjFdgRcohtOCzu/mUmuVkIeN2keEQnvH+KyVD4o/aVe6P9cX1OCL4VpiZb1q3BxKG
 6lkyL3dMWy6EZLSIkK9vHbP90+7T89I4tNID0VexD4BmtTBIov9du2/yk6vHdKY3ytOsyuiqIbz
 nszk3ya7x63zfh1Jw+TiqfU/J9vKxASP2VjTaKB1hAsf3zi0E8Luhd/bR5Wlq7gGVfMHZOuv
X-Authority-Analysis: v=2.4 cv=UMCE3Cfy c=1 sm=1 tr=0 ts=68a6a645 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=ZPRfWecDwonW3wRivEwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ui0DcRXF5C5Mp3IwAXgPkrk_CatNM3Ep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
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

From: Sucharitha Sarananaga <ssarananaga@marvell.com>

This patch introduces a new API to get AE EC group table
address and added static_assert checks to ensure that each
enum value in roc_ae_ec_id matches its expected constant.
This helps catch accidental changes or reordering of enum
values at compile time.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  | 47 ++++++++++++++
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h | 77 +++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 97c12c6087..8bc7b2c345 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -43,6 +43,29 @@
 #define CNXK_CPT_MAX_ASYM_OP_MOD_LEN	 1024
 #define CNXK_CPT_META_BUF_MAX_CACHE_SIZE 128
 
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P192 == (uint16_t)ROC_AE_EC_ID_P192,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P224 == (uint16_t)ROC_AE_EC_ID_P224,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P256 == (uint16_t)ROC_AE_EC_ID_P256,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P384 == (uint16_t)ROC_AE_EC_ID_P384,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P521 == (uint16_t)ROC_AE_EC_ID_P521,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P160 == (uint16_t)ROC_AE_EC_ID_P160,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P320 == (uint16_t)ROC_AE_EC_ID_P320,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_P512 == (uint16_t)ROC_AE_EC_ID_P512,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_SM2 == (uint16_t)ROC_AE_EC_ID_SM2,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_ED25519 == (uint16_t)ROC_AE_EC_ID_ED25519,
+	      "Enum value mismatch");
+static_assert((uint16_t)RTE_PMD_CNXK_AE_EC_ID_ED448 == (uint16_t)ROC_AE_EC_ID_ED448,
+	      "Enum value mismatch");
+
 static int
 cnxk_cpt_get_mlen(void)
 {
@@ -1018,6 +1041,30 @@ rte_pmd_cnxk_ae_fpm_table_get(uint8_t dev_id)
 	return vf->cnxk_fpm_iova;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_ae_ec_grp_table_get, 25.07)
+const struct rte_pmd_cnxk_crypto_ae_ec_group_params **
+rte_pmd_cnxk_ae_ec_grp_table_get(uint8_t dev_id, uint16_t *nb_max_entries)
+{
+	struct rte_cryptodev *dev;
+	struct cnxk_cpt_vf *vf;
+
+	dev = rte_cryptodev_pmd_get_dev(dev_id);
+	if (dev == NULL) {
+		plt_err("Invalid dev_id %u", dev_id);
+		return NULL;
+	}
+
+	vf = dev->data->dev_private;
+	if (vf == NULL) {
+		plt_err("VF is not initialized");
+		return NULL;
+	}
+
+	*nb_max_entries = ROC_AE_EC_ID_PMAX;
+
+	return (const struct rte_pmd_cnxk_crypto_ae_ec_group_params **)(void *)vf->ec_grp;
+}
+
 static inline void
 cnxk_crypto_cn10k_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, uint16_t nb_inst)
 {
diff --git a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
index fbf0a2d75d..b9ee322241 100644
--- a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
+++ b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
@@ -16,6 +16,26 @@
 #include <rte_crypto.h>
 #include <rte_security.h>
 
+#define AE_EC_DATA_MAX 66
+
+/**
+ * Enumerates supported elliptic curves
+ */
+typedef enum {
+	RTE_PMD_CNXK_AE_EC_ID_P192 = 0,
+	RTE_PMD_CNXK_AE_EC_ID_P224 = 1,
+	RTE_PMD_CNXK_AE_EC_ID_P256 = 2,
+	RTE_PMD_CNXK_AE_EC_ID_P384 = 3,
+	RTE_PMD_CNXK_AE_EC_ID_P521 = 4,
+	RTE_PMD_CNXK_AE_EC_ID_P160 = 5,
+	RTE_PMD_CNXK_AE_EC_ID_P320 = 6,
+	RTE_PMD_CNXK_AE_EC_ID_P512 = 7,
+	RTE_PMD_CNXK_AE_EC_ID_SM2 = 8,
+	RTE_PMD_CNXK_AE_EC_ID_ED25519 = 9,
+	RTE_PMD_CNXK_AE_EC_ID_ED448 = 10,
+	RTE_PMD_CNXK_AE_EC_ID_PMAX
+} rte_pmd_cnxk_ae_ec_id;
+
 /* Forward declarations */
 
 /**
@@ -72,6 +92,41 @@ struct rte_pmd_cnxk_crypto_sess {
 	};
 };
 
+/**
+ * @brief AE EC (Elliptic Curve) group parameters structure.
+ *
+ * This structure holds the parameters for an elliptic curve group used in
+ * AE (Asymmetric Encryption) operations. It contains the prime, order,
+ * and curve constants (consta and constb), each represented as a byte array
+ * with an associated length. The maximum length is set to accommodate the
+ * largest supported curve (e.g., P521).
+ */
+struct rte_pmd_cnxk_crypto_ae_ec_group_params {
+	struct {
+		/* P521 maximum length */
+		uint8_t data[AE_EC_DATA_MAX];
+		unsigned int length;
+	} prime;
+
+	struct {
+		/* P521 maximum length */
+		uint8_t data[AE_EC_DATA_MAX];
+		unsigned int length;
+	} order;
+
+	struct {
+		/* P521 maximum length */
+		uint8_t data[AE_EC_DATA_MAX];
+		unsigned int length;
+	} consta;
+
+	struct {
+		/* P521 maximum length */
+		uint8_t data[AE_EC_DATA_MAX];
+		unsigned int length;
+	} constb;
+};
+
 /**
  * Get queue pointer of a specific queue in a cryptodev.
  *
@@ -230,4 +285,26 @@ int rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
  */
 __rte_experimental const uint64_t *rte_pmd_cnxk_ae_fpm_table_get(uint8_t dev_id);
 
+/**
+ * Retrieves the addresses of the AE EC group table.
+ *
+ * This API should be called only after the cryptodev device has been
+ * successfully configured. The returned pointer reference memory that is
+ * valid as long as the device remains configured and is not destroyed or
+ * reconfigured. If the device is reconfigured or destroyed, the memory
+ * referenced by the returned pointer becomes invalid and must not be used.
+ *
+ * @param dev_id
+ *   Device identifier of cryptodev device.
+ * @param nb_max_entries
+ *   Pointer to store the maximum number of entries in the EC group table.
+ *   This value is set by the function to indicate how many entries can be
+ *   retrieved from the table.
+ * @return
+ *   - On success, pointer to the AE EC group table structure address.
+ *   - NULL on error.
+ */
+__rte_experimental const struct rte_pmd_cnxk_crypto_ae_ec_group_params **
+rte_pmd_cnxk_ae_ec_grp_table_get(uint8_t dev_id, uint16_t *nb_max_entries);
+
 #endif /* _PMD_CNXK_CRYPTO_H_ */
-- 
2.25.1


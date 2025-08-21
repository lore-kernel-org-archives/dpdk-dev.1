Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6988DCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60DE2402DD;
	Thu, 21 Aug 2025 06:53:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 48B504026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 06:53:24 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0oWxo008641
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 uK3Y1P2BntJh2o7Fs5DGV6hWVX8tX0OucgWejsoqW8=; b=d0DwX4AmGTwGS6Ki0
 wSb4Gy92Rejj/4sxsp719VS5Qve8HXz6+i1NnWtZO6nd8NvU/0zxoBQ32tmUzX4X
 OmZMdeFinLZSJyNScUVXjnWf4M0TNGbkW5RLJiJQ3AzRXR3bGugWm82EobspBvj6
 ZqU+Gb8GrDC3lhOMWV2Z1Uh8mtPXolRmPP9vTJ9QdCgt0991Oug3S7QzvggPGxNt
 r4o5c2yq3E5kdGEJEnyQw2eyxYFR+IR8tCFjDytd7iO+0ogKAILD3eA8W7NhJWkg
 C7CLu12uDG2PYqFEPbT9ja7lDyHIMXIPnRvu62M0iMcY16cV7Hx4wHUohtoj/EdX
 h8B7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nhhr9q36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:25 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 259613F708F;
 Wed, 20 Aug 2025 21:53:16 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 3/8] crypto/cnxk: add new API to get fpm tbl address
Date: Thu, 21 Aug 2025 10:22:55 +0530
Message-ID: <20250821045300.3787899-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821045300.3787899-1-ktejasree@marvell.com>
References: <20250821045300.3787899-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfX4sZPux+SZTJ5
 TsCtc0Btwf4CMjpN/fdTgao0VALZ4AJJJyLw+4WJPOTjL221QiuXgeMrK3guLehLECO7cgkcBbC
 03MW7pu4v3097gi04DTMBO7douECSVHnNfQORSPoSR1nwh7aHCStzj9plMwcovaZZt/ZN6GL0nZ
 1k2WAZwmWSDlve/rgw2EUogCXOP9JMty3Rn57GIn2kJe9wz1gHQT9J1MBK6KjgRXuuIbVSuH7kc
 DBHPNslo/N6tDV5BVtlyG68pb9eWFU6FHdjBrQt/YvEyckh7zMNVwfq5ibiREFtboM6l9bZbF+3
 EvvGFX6wFTeoOmvSSc8CpS5EgaQiNV/uv5NaPiIQZxoEtAOjKsdquNDNdXRBazNNEyIj7WMvBd2
 fYD/S7EFYWMTJkruaTF4wjg/kiai99gUukJD/+HtFsSyPB8cSIFXhOUMj5cs+lzp3I4mOoHO
X-Proofpoint-ORIG-GUID: aEQ4aKI0m8ydN8Zl9pf9UN7I5SdRUWDZ
X-Authority-Analysis: v=2.4 cv=L/REg+T8 c=1 sm=1 tr=0 ts=68a6a642 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=ZjUrckzrv87nIEqIsz8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aEQ4aKI0m8ydN8Zl9pf9UN7I5SdRUWDZ
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

This patch introduces a new API to get FPM table host address.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  | 23 +++++++++++++++++++++++
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h | 17 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 2bf156bddb..97c12c6087 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -12,6 +12,7 @@
 #endif
 #include <rte_security_driver.h>
 
+#include "roc_ae.h"
 #include "roc_ae_fpm_tables.h"
 #include "roc_cpt.h"
 #include "roc_errata.h"
@@ -995,6 +996,28 @@ rte_pmd_cnxk_crypto_qptr_get(uint8_t dev_id, uint16_t qp_id)
 	return qptr;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_ae_fpm_table_get, 25.07)
+const uint64_t *
+rte_pmd_cnxk_ae_fpm_table_get(uint8_t dev_id)
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
+	return vf->cnxk_fpm_iova;
+}
+
 static inline void
 cnxk_crypto_cn10k_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, uint16_t nb_inst)
 {
diff --git a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
index 46861ab2cf..fbf0a2d75d 100644
--- a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
+++ b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
@@ -213,4 +213,21 @@ __rte_experimental
 int rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
 				     struct rte_pmd_cnxk_crypto_qp_stats *stats);
 
+/**
+ * Retrieves the addresses of the AE FPM (Finite Precision Math) tables.
+ *
+ * This API should be called only after the cryptodev device has been
+ * successfully configured. The returned pointer reference memory that is
+ * valid as long as the device remains configured and is not destroyed or
+ * reconfigured. If the device is reconfigured or destroyed, the memory
+ * referenced by the returned pointer becomes invalid and must not be used.
+ *
+ * @param dev_id
+ *   Device identifier of cryptodev device.
+ * @return
+ *   - On success pointer to the AE FPM table addresses.
+ *   - NULL on error.
+ */
+__rte_experimental const uint64_t *rte_pmd_cnxk_ae_fpm_table_get(uint8_t dev_id);
+
 #endif /* _PMD_CNXK_CRYPTO_H_ */
-- 
2.25.1


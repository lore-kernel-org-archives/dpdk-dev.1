Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E84BCAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:44:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85252406B7;
	Mon, 29 Sep 2025 11:44:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C4FA9406B7
 for <dev@dpdk.org>; Mon, 29 Sep 2025 11:44:10 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T80Tt1004093
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:44:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 BgEWdD5nrA0YknOrBz4pO+xGglrV9VE9OE5bZRCYhg=; b=d58B01p3kiLbPw8eK
 NtcMN/6A06vGiQFBf39KSGAR3wi8RHYvrzZep4h49UD5AaKPsa0ed4iRq6yLQOMU
 BAvzfzUY1Pk9YE5E10xBxi31p2JshU2kWA3RKuD5JdrR5NQWz6dvS8FQccMprVHk
 ApO5raEKNKFdwVvulWxY5ssZPJDRTDv1fPVM7x6+omuNbCOZQUSm8t5GW5FlSBad
 ngP1DigOma0Q4Ob8nc0KiLnHhkoWyN8NuA0hIevs0GlGo7fuqIh3DAN1GnMijArr
 Kvos+1v57Sk2G6Z7EpxNUfvqpm7607Rvl2mf7zTDgggc3CV7KQCTyPI7EiPGLZRS
 XZffA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49f0p51w0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:44:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 02:44:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 02:44:08 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id CFFC53F7059;
 Mon, 29 Sep 2025 02:44:05 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 03/10] crypto/cnxk: add new API to get fpm tbl address
Date: Mon, 29 Sep 2025 15:13:46 +0530
Message-ID: <20250929094353.1027744-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929094353.1027744-1-ktejasree@marvell.com>
References: <20250929094353.1027744-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IW5fx9LS-nMhkWbkj2g39NdvOBduOmtg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDA2OSBTYWx0ZWRfX4lBDK1TSHQHC
 VOd57hLLDSzGD44LouS1P12Z/A0uwqt0nPxzpJ3hcUHWNgm6ol9GPvu4LJmmxnOWsSKigm/SqO9
 MO50BJtHSG+db/7pFTaH2KtQNtCEaUQFPmZyBuPp4xQE3s8JR9xXbJnl4bWz1tAUw4W/YKzBS21
 H5uJhrmZJyaG6PMR4Olp4h3qAGnpAc7f9lEn+X0VoZ1n9ucknfCNvTilOVPUSGc7HS1swhmxcek
 jdWFIzBa1nCGrs3tqJVu53yjbm7TdlyPekMGTOc5MoMxtP9g/tudZfIrHgYJsXuDXvO1LRt0qDI
 +rGpGrThORWiJiE9qAj/gpZZO92pQJ1MgnYHt4eNY9LRH/NwX3JjWTPmIX3B5JegLI78YfFv1kZ
 J+lDHA+FhwH43j2zEnY6TKQiLZoN7w==
X-Authority-Analysis: v=2.4 cv=StCdKfO0 c=1 sm=1 tr=0 ts=68da54e9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=ZjUrckzrv87nIEqIsz8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: IW5fx9LS-nMhkWbkj2g39NdvOBduOmtg
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

From: Sucharitha Sarananaga <ssarananaga@marvell.com>

This patch introduces a new API to get FPM table host address.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  | 23 +++++++++++++++++++++++
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index 46861ab2cf..8db38e95f8 100644
--- a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
+++ b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
@@ -213,4 +213,22 @@ __rte_experimental
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
+__rte_experimental
+const uint64_t *rte_pmd_cnxk_ae_fpm_table_get(uint8_t dev_id);
+
 #endif /* _PMD_CNXK_CRYPTO_H_ */
-- 
2.25.1


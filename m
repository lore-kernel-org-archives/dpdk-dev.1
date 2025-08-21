Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD7CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 06:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE0F54067E;
	Thu, 21 Aug 2025 08:13:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C5F044066C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 08:13:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0pTUE009804
 for <dev@dpdk.org>; Wed, 20 Aug 2025 23:13:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 A1BgLADmZXbDbuMQOykZFxSg4Wb9Bb029Ey//6GkhM=; b=TFBZL3qzpTLm8nI2h
 9+0SelDn/A1E/952y0/Tqof9RTP+5QX+XGuAduuSo1AslVs1roKSG5PSKHkCV4My
 sKTwwVsJaP1KG5DZNFHKLR1ScPU9TTTFkw/gutF7d7zbQ0CPJrJP9M/ll3zF4KNm
 eqsNeBVoYY3TbR00coWEcrcfziie111fRVEU0b3ukorzxyH6wfvUpkaMx1RwiVpC
 9Ir1uOg0lyU3QeTMqylk1VMlN9hvRgut3naIC+pjnROqr4mq0qTr8ev5yerMDaMR
 1IZ2Uody93TnUNSKspiE4dMogR8Sy/KjF36EaJjtpim6PRQM2UBexalwpBeKDJZC
 6An7w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nhhr9ug8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 23:13:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 23:14:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 23:14:01 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 1F6AC3F7097;
 Wed, 20 Aug 2025 23:13:53 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 3/8] crypto/cnxk: add new API to get fpm tbl address
Date: Thu, 21 Aug 2025 11:43:36 +0530
Message-ID: <20250821061341.3790775-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821061341.3790775-1-ktejasree@marvell.com>
References: <20250821061341.3790775-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0NSBTYWx0ZWRfX3bI7MhCOhtB6
 fNuEnrI7UqWraykjq4gh8Wiy6cSgN4i63+GQjq5AwrLxWGbwPl1yeB/QzDctQY8fQcXHvy3ET6b
 /e90Aom4rZH6z4/L8bGEQWxJM8yoGZvDRXWUW2a2fxI88Eeo3I08oGz0EUNUjB11kIBb6wlO78k
 uBZLVQ8WhSrOgEZhzdu2e2CLwgS3FpPz8aytdU6mJiPEifNmoHsGx/KC0aUoZiKfKEDl/+X4iaz
 T6Ce5tNNcfP59fL2R2OyPfy4GXnV3KMXryyWEb1KoVmu6siSCJpog0Ass64BgLf1htxFxtHiM/s
 WwrgzBeRZ3wqMGqisNT0oCNxljCQSzHP+kCjXAIds+5rPbAlSnqBzgIfx+R0c23Xeso+RzvllOZ
 FDlYfVAICEBIrSE6C6pAJalOJkpsBguK4FSVnm8shbisImZMQS6bddzj2uSqH8PGiyQ94a9P
X-Proofpoint-ORIG-GUID: CuEWgUwVY-Uzo3W0HpeKv556rsq2PSPy
X-Authority-Analysis: v=2.4 cv=L/REg+T8 c=1 sm=1 tr=0 ts=68a6b925 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=ZjUrckzrv87nIEqIsz8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: CuEWgUwVY-Uzo3W0HpeKv556rsq2PSPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
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
index 46861ab2cf..cd3ddc9dd1 100644
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


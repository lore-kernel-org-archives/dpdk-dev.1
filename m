Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47BAD1D86F
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 06:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01A534064A;
	Thu,  4 Dec 2025 07:52:31 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7FCBF4064F
 for <dev@dpdk.org>; Thu,  4 Dec 2025 07:52:29 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3NSRcS4129898 for <dev@dpdk.org>; Wed, 3 Dec 2025 22:52:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 9bcUVbPK/aWcWNroEAilnN9jIw5XB0TbCsHZcjLYUk=; b=L1j0avOCx6VRgW/J+
 N1cle+p//NURPmqsTubcuXoXU2kCddm9YecRgzZzO0lk5eEo34OQejys4cXBpydp
 xmbs+MtZoQi6FJ0lnZ9exBndsKxN6UFFeskXgk6WIINMg7xHLzd9uOE/aL+w3I3F
 rrmq+Cpfrl5itJY3Ideg80EXRApoPwI+E9AS9nHgM0210bhHAQnAlhTxcGbnrRSW
 YIImEM9xfoSinOmjfZrPZSgvhnXkwr01NciIbMxXdibg6WdZgnG6KmP4utFL9tNU
 8iGjLIu9bFgAS3JZrEXdr0tmgzT57cbq2+Nv3WSz6kzh3+HhgCgyyZd1/vCbmBcs
 3/D4Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4atxwegsj1-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 03 Dec 2025 22:52:28 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Dec 2025 22:52:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Dec 2025 22:52:39 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id BD6503F705D;
 Wed,  3 Dec 2025 22:52:24 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Ashwin Sekhar T K <asekhar@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>
CC: <jerinj@marvell.com>, Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH 2/2] mempool/cnxk: add halo support in mempool
Date: Thu, 4 Dec 2025 12:21:33 +0530
Message-ID: <20251204065203.1866809-3-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251204065203.1866809-1-nkishor@marvell.com>
References: <20251204065203.1866809-1-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: luYedrKw_OxEzAjRdFteVuidYFbmZYHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA1NCBTYWx0ZWRfXx5F8gD6CK3S4
 1ttqxtj16gR3mY74pqENqXNlsHqZiKrhL43DCax8ATBQixMYNH7HoA8ursXQli+lXCc938aMuBs
 f31+vQZA15RKJTVvnhgSvmm51QVZvflO+3afjmmyt1aLKF4FrFNsFbrqyTJH352/v9sKPWZ0NKN
 Vxl0cfZ4iNfvc6najRmqGNDQFisSt7EaTbgVmWrNmViLLdRwpFWZll1LADRZHZUak+HtDigE2O/
 a7S69x4cNcQHvzpCptNSyhlmCkWircPZuXT2CKurj8mIMlqgXPXKZp/g24kc7MXZ8UU1J26mldZ
 feskTMKHCNu26JPo3cJPxoZ7f1aQ015lg4c4dYZIhM2jzcSq0bcj6ftrZsxl91JYf1mnTlqCCeJ
 +2B8xlgCDO1x5lg7+WixjGc9//wbVQ==
X-Authority-Analysis: v=2.4 cv=Y7f1cxeN c=1 sm=1 tr=0 ts=69312fac cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=CfmVPr1kf39V_BDwOI8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: luYedrKw_OxEzAjRdFteVuidYFbmZYHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
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

This patch adds the support of halos in CN20K mempool driver. It
introduces a new devargs parameter "halo_ena" to enable or disable
halo feature. If halo_ena is set to 1, halos will be enabled for
NPA pools created by the mempool driver.

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/mempool/cnxk/cn10k_mempool_ops.c | 19 ++++----
 drivers/mempool/cnxk/cn20k_mempool_ops.c | 60 ++++++++++++++++++++++++
 drivers/mempool/cnxk/cn9k_mempool_ops.c  |  2 +-
 drivers/mempool/cnxk/cnxk_mempool.c      | 40 +++++++++++-----
 drivers/mempool/cnxk/cnxk_mempool.h      | 16 ++++++-
 drivers/mempool/cnxk/cnxk_mempool_ops.c  | 11 +++--
 drivers/mempool/cnxk/meson.build         |  1 +
 7 files changed, 120 insertions(+), 29 deletions(-)
 create mode 100644 drivers/mempool/cnxk/cn20k_mempool_ops.c

diff --git a/drivers/mempool/cnxk/cn10k_mempool_ops.c b/drivers/mempool/cnxk/cn10k_mempool_ops.c
index a5be0ccafe..09f900a850 100644
--- a/drivers/mempool/cnxk/cn10k_mempool_ops.c
+++ b/drivers/mempool/cnxk/cn10k_mempool_ops.c
@@ -2,9 +2,6 @@
  * Copyright(C) 2021 Marvell.
  */
 
-#include <rte_mempool.h>
-
-#include "roc_api.h"
 #include "cnxk_mempool.h"
 
 #define BATCH_ALLOC_SZ              ROC_CN10K_NPA_BATCH_ALLOC_MAX_PTRS
@@ -79,7 +76,7 @@ batch_op_data_set(uint64_t pool_id, struct batch_op_data *op_data)
 	batch_op_data_tbl[aura] = op_data;
 }
 
-static int
+int
 batch_op_init(struct rte_mempool *mp)
 {
 	struct batch_op_data *op_data;
@@ -109,7 +106,7 @@ batch_op_init(struct rte_mempool *mp)
 	return 0;
 }
 
-static void
+void
 batch_op_fini(struct rte_mempool *mp)
 {
 	struct batch_op_data *op_data;
@@ -149,7 +146,7 @@ batch_op_fini(struct rte_mempool *mp)
 	rte_wmb();
 }
 
-static int __rte_hot
+int __rte_hot
 cn10k_mempool_enq(struct rte_mempool *mp, void *const *obj_table,
 		  unsigned int n)
 {
@@ -181,7 +178,7 @@ cn10k_mempool_enq(struct rte_mempool *mp, void *const *obj_table,
 	return 0;
 }
 
-static unsigned int
+unsigned int
 cn10k_mempool_get_count(const struct rte_mempool *mp)
 {
 	struct batch_op_data *op_data;
@@ -326,7 +323,7 @@ mempool_deq_batch_sync(struct rte_mempool *mp, void **obj_table, unsigned int n)
 	return count;
 }
 
-static int __rte_hot
+int __rte_hot
 cn10k_mempool_deq(struct rte_mempool *mp, void **obj_table, unsigned int n)
 {
 	struct batch_op_data *op_data;
@@ -353,7 +350,7 @@ cn10k_mempool_deq(struct rte_mempool *mp, void **obj_table, unsigned int n)
 	return 0;
 }
 
-static int
+int
 cn10k_mempool_alloc(struct rte_mempool *mp)
 {
 	uint32_t block_size;
@@ -376,7 +373,7 @@ cn10k_mempool_alloc(struct rte_mempool *mp)
 		block_size += padding;
 	}
 
-	rc = cnxk_mempool_alloc(mp);
+	rc = cnxk_mempool_alloc(mp, 0);
 	if (rc)
 		return rc;
 
@@ -392,7 +389,7 @@ cn10k_mempool_alloc(struct rte_mempool *mp)
 	return rc;
 }
 
-static void
+void
 cn10k_mempool_free(struct rte_mempool *mp)
 {
 	batch_op_fini(mp);
diff --git a/drivers/mempool/cnxk/cn20k_mempool_ops.c b/drivers/mempool/cnxk/cn20k_mempool_ops.c
new file mode 100644
index 0000000000..f8817d8743
--- /dev/null
+++ b/drivers/mempool/cnxk/cn20k_mempool_ops.c
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include "cnxk_mempool.h"
+
+static int
+cn20k_mempool_alloc(struct rte_mempool *mp)
+{
+	uint32_t block_size;
+	int halo_ena, rc;
+	size_t padding;
+
+	block_size = mp->elt_size + mp->header_size + mp->trailer_size;
+	/* Align header size to ROC_ALIGN */
+	if (mp->header_size % ROC_ALIGN != 0) {
+		padding = RTE_ALIGN_CEIL(mp->header_size, ROC_ALIGN) -
+			  mp->header_size;
+		mp->header_size += padding;
+		block_size += padding;
+	}
+
+	/* Align block size to ROC_ALIGN */
+	if (block_size % ROC_ALIGN != 0) {
+		padding = RTE_ALIGN_CEIL(block_size, ROC_ALIGN) - block_size;
+		mp->trailer_size += padding;
+		block_size += padding;
+	}
+
+	/* Get halo status */
+	halo_ena = roc_idev_npa_halo_ena_get();
+
+	rc = cnxk_mempool_alloc(mp, halo_ena ? ROC_NPA_HALO_F : 0);
+	if (rc)
+		return rc;
+
+	rc = batch_op_init(mp);
+	if (rc) {
+		plt_err("Failed to init batch alloc mem rc=%d", rc);
+		goto error;
+	}
+
+	return 0;
+error:
+	cnxk_mempool_free(mp);
+	return rc;
+}
+
+static struct rte_mempool_ops cn20k_mempool_ops = {
+	.name = "cn20k_mempool_ops",
+	.alloc = cn20k_mempool_alloc,
+	.free = cn10k_mempool_free,
+	.enqueue = cn10k_mempool_enq,
+	.dequeue = cn10k_mempool_deq,
+	.get_count = cn10k_mempool_get_count,
+	.calc_mem_size = cnxk_mempool_calc_mem_size,
+	.populate = cnxk_mempool_populate,
+};
+
+RTE_MEMPOOL_REGISTER_OPS(cn20k_mempool_ops);
diff --git a/drivers/mempool/cnxk/cn9k_mempool_ops.c b/drivers/mempool/cnxk/cn9k_mempool_ops.c
index b7967f8085..8248071cb7 100644
--- a/drivers/mempool/cnxk/cn9k_mempool_ops.c
+++ b/drivers/mempool/cnxk/cn9k_mempool_ops.c
@@ -72,7 +72,7 @@ cn9k_mempool_alloc(struct rte_mempool *mp)
 	padding = ((block_size / ROC_ALIGN) % 2) ? 0 : ROC_ALIGN;
 	mp->trailer_size += padding;
 
-	return cnxk_mempool_alloc(mp);
+	return cnxk_mempool_alloc(mp, 0);
 }
 
 static struct rte_mempool_ops cn9k_mempool_ops = {
diff --git a/drivers/mempool/cnxk/cnxk_mempool.c b/drivers/mempool/cnxk/cnxk_mempool.c
index 6ff11d8004..6939fccff4 100644
--- a/drivers/mempool/cnxk/cnxk_mempool.c
+++ b/drivers/mempool/cnxk/cnxk_mempool.c
@@ -18,6 +18,7 @@
 #define CNXK_NPA_DEV_NAME	 RTE_STR(cnxk_npa_dev_)
 #define CNXK_NPA_DEV_NAME_LEN	 (sizeof(CNXK_NPA_DEV_NAME) + PCI_PRI_STR_SIZE)
 #define CNXK_NPA_MAX_POOLS_PARAM "max_pools"
+#define CNXK_NPA_HALO_ENA_PARAM	 "halo_ena"
 
 static inline uint32_t
 npa_aura_size_to_u32(uint8_t val)
@@ -46,30 +47,46 @@ parse_max_pools_handler(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
-static inline uint32_t
-parse_max_pools(struct rte_devargs *devargs)
+static int
+parse_halo_ena_handler(const char *key, const char *value, void *extra_args)
+{
+	RTE_SET_USED(key);
+	uint8_t val;
+
+	val = atoi(value);
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	*(uint8_t *)extra_args = val;
+	return 0;
+}
+
+static int
+cnxk_mempool_plt_parse_devargs(struct rte_pci_device *pci_dev)
 {
 	uint32_t max_pools = npa_aura_size_to_u32(NPA_AURA_SZ_128);
+	struct rte_devargs *devargs = pci_dev->device.devargs;
 	struct rte_kvargs *kvlist;
+	uint32_t halo_ena = 0;
 
 	if (devargs == NULL)
-		goto exit;
+		goto null_devargs;
 	kvlist = rte_kvargs_parse(devargs->args, NULL);
 	if (kvlist == NULL)
 		goto exit;
 
 	rte_kvargs_process(kvlist, CNXK_NPA_MAX_POOLS_PARAM,
 			   &parse_max_pools_handler, &max_pools);
+	rte_kvargs_process(kvlist, CNXK_NPA_HALO_ENA_PARAM,
+			   &parse_halo_ena_handler, &halo_ena);
 	rte_kvargs_free(kvlist);
-exit:
-	return max_pools;
-}
 
-static int
-cnxk_mempool_plt_parse_devargs(struct rte_pci_device *pci_dev)
-{
-	roc_idev_npa_maxpools_set(parse_max_pools(pci_dev->device.devargs));
+null_devargs:
+	roc_idev_npa_maxpools_set(max_pools);
+	roc_idev_npa_halo_ena_set(halo_ena);
 	return 0;
+exit:
+	return -EINVAL;
 }
 
 static inline char *
@@ -201,7 +218,8 @@ RTE_PMD_REGISTER_PCI(mempool_cnxk, npa_pci);
 RTE_PMD_REGISTER_PCI_TABLE(mempool_cnxk, npa_pci_map);
 RTE_PMD_REGISTER_KMOD_DEP(mempool_cnxk, "vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(mempool_cnxk,
-			      CNXK_NPA_MAX_POOLS_PARAM "=<128-1048576>");
+			      CNXK_NPA_MAX_POOLS_PARAM "=<128-1048576>"
+			      CNXK_NPA_HALO_ENA_PARAM "=<0-1>");
 
 RTE_INIT(cnxk_mempool_parse_devargs)
 {
diff --git a/drivers/mempool/cnxk/cnxk_mempool.h b/drivers/mempool/cnxk/cnxk_mempool.h
index 669e617952..941290061e 100644
--- a/drivers/mempool/cnxk/cnxk_mempool.h
+++ b/drivers/mempool/cnxk/cnxk_mempool.h
@@ -7,6 +7,8 @@
 
 #include <rte_mempool.h>
 
+#include "roc_api.h"
+
 enum cnxk_mempool_flags {
 	/* This flag is used to ensure that only aura zero is allocated.
 	 * If aura zero is not available, then mempool creation fails.
@@ -47,7 +49,7 @@ int cnxk_mempool_populate(struct rte_mempool *mp, unsigned int max_objs,
 			  void *vaddr, rte_iova_t iova, size_t len,
 			  rte_mempool_populate_obj_cb_t *obj_cb,
 			  void *obj_cb_arg);
-int cnxk_mempool_alloc(struct rte_mempool *mp);
+int cnxk_mempool_alloc(struct rte_mempool *mp, uint64_t roc_flags);
 void cnxk_mempool_free(struct rte_mempool *mp);
 
 int __rte_hot cnxk_mempool_enq(struct rte_mempool *mp, void *const *obj_table,
@@ -55,6 +57,16 @@ int __rte_hot cnxk_mempool_enq(struct rte_mempool *mp, void *const *obj_table,
 int __rte_hot cnxk_mempool_deq(struct rte_mempool *mp, void **obj_table,
 			       unsigned int n);
 
+int batch_op_init(struct rte_mempool *mp);
+void batch_op_fini(struct rte_mempool *mp);
+int __rte_hot cn10k_mempool_enq(struct rte_mempool *mp, void *const *obj_table,
+				unsigned int n);
+unsigned int cn10k_mempool_get_count(const struct rte_mempool *mp);
+int __rte_hot cn10k_mempool_deq(struct rte_mempool *mp, void **obj_table,
+				unsigned int n);
+int cn10k_mempool_alloc(struct rte_mempool *mp);
+void cn10k_mempool_free(struct rte_mempool *mp);
+
 int cn10k_mempool_plt_init(void);
 
-#endif
+#endif /* _CNXK_MEMPOOL_H_ */
diff --git a/drivers/mempool/cnxk/cnxk_mempool_ops.c b/drivers/mempool/cnxk/cnxk_mempool_ops.c
index 5c7fcea487..01b6247fbb 100644
--- a/drivers/mempool/cnxk/cnxk_mempool_ops.c
+++ b/drivers/mempool/cnxk/cnxk_mempool_ops.c
@@ -70,9 +70,9 @@ cnxk_mempool_calc_mem_size(const struct rte_mempool *mp, uint32_t obj_num,
 }
 
 int
-cnxk_mempool_alloc(struct rte_mempool *mp)
+cnxk_mempool_alloc(struct rte_mempool *mp, uint64_t roc_flags)
 {
-	uint32_t block_count, flags, roc_flags = 0;
+	uint32_t block_count, flags;
 	uint64_t aura_handle = 0;
 	struct npa_aura_s aura;
 	struct npa_pool_s pool;
@@ -98,7 +98,7 @@ cnxk_mempool_alloc(struct rte_mempool *mp)
 
 	flags = CNXK_MEMPOOL_FLAGS(mp);
 	if (flags & CNXK_MEMPOOL_F_ZERO_AURA) {
-		roc_flags = ROC_NPA_ZERO_AURA_F;
+		roc_flags |= ROC_NPA_ZERO_AURA_F;
 	} else if (flags & CNXK_MEMPOOL_F_CUSTOM_AURA) {
 		struct npa_aura_s *paura;
 
@@ -192,9 +192,12 @@ cnxk_mempool_plt_init(void)
 
 	if (roc_model_is_cn9k()) {
 		rte_mbuf_set_platform_mempool_ops("cn9k_mempool_ops");
-	} else if (roc_model_is_cn10k() || roc_model_is_cn20k()) {
+	} else if (roc_model_is_cn10k()) {
 		rte_mbuf_set_platform_mempool_ops("cn10k_mempool_ops");
 		rc = cn10k_mempool_plt_init();
+	} else if (roc_model_is_cn20k()) {
+		rte_mbuf_set_platform_mempool_ops("cn20k_mempool_ops");
+		rc = cn10k_mempool_plt_init();
 	}
 	return rc;
 }
diff --git a/drivers/mempool/cnxk/meson.build b/drivers/mempool/cnxk/meson.build
index e388cce26a..7722264320 100644
--- a/drivers/mempool/cnxk/meson.build
+++ b/drivers/mempool/cnxk/meson.build
@@ -14,6 +14,7 @@ sources = files(
         'cnxk_mempool_telemetry.c',
         'cn9k_mempool_ops.c',
         'cn10k_mempool_ops.c',
+        'cn20k_mempool_ops.c',
         'cn10k_hwpool_ops.c',
 )
 
-- 
2.48.1


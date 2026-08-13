Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540FBC5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3397142E9C;
	Thu, 13 Aug 2026 16:42:43 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id DC52742E67
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:42:39 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C0DFF1A009B;
 Thu, 13 Aug 2026 16:42:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AE301A0071;
 Thu, 13 Aug 2026 16:42:39 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0E09818000B5;
 Thu, 13 Aug 2026 22:42:37 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v11 24/25] drivers: add dpaax enter destructor to gate EAL
 memory frees
Date: Thu, 13 Aug 2026 20:12:04 +0530
Message-Id: <20260813144205.2505031-25-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
References: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
 <20260813144205.2505031-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

Add a dpaax_enter_destructor() function that drivers call at the start
of their RTE_FINI destructors to signal that the process is tearing
down. Subsequent attempts to free EAL-backed memory (such as IOVA table
entries) are then skipped, avoiding use-after-free crashes when the EAL
has already unmapped hugepages before per-driver destructors run.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus.c             |  1 +
 drivers/common/dpaax/compat.h           | 22 +++++++++++++++++-----
 drivers/common/dpaax/dpaax_iova_table.c | 25 ++++++++++++++++++++++++-
 drivers/mempool/dpaa/dpaa_mempool.c     |  2 ++
 drivers/net/dpaa/dpaa_ethdev.c          |  1 +
 5 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 16892b5247..01bfaacbf7 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -915,6 +915,7 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
 	if (!dpaa_bus_global_init)
 		return;
 
+	dpaax_enter_destructor();
 	/* cleanup portals in case non-graceful exit */
 	RTE_LCORE_FOREACH_WORKER(lcore_id) {
 		/* Check for non zero id */
diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d0635255da..b826a55de2 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -2,7 +2,7 @@
  *
  * Copyright 2011 Freescale Semiconductor, Inc.
  * All rights reserved.
- * Copyright 2019-2020 NXP
+ * Copyright 2019-2020, 2026 NXP
  *
  */
 
@@ -336,11 +336,23 @@ static inline void copy_bytes(void *dest, const void *src, size_t sz)
 #define copy_bytes memcpy
 #endif
 
-/* Allocator stuff */
-#define kmalloc(sz, t)	rte_malloc(NULL, sz, 0)
-#define kzalloc(sz, t)  rte_zmalloc(NULL, sz, 0)
+__rte_internal
+void dpaax_enter_destructor(void);
+__rte_internal
+int is_dpaax_in_destructor(void);
+
+/* Allocator stuff, make sure the eal memory pool is available when calling.*/
+#define kmalloc(sz, _t) ((void)(_t), rte_malloc(NULL, sz, 0))
+#define kzalloc(sz, _t) ((void)(_t), rte_zmalloc(NULL, sz, 0))
 #define vmalloc(sz)	rte_malloc(NULL, sz, 0)
-#define kfree(p)	rte_free(p)
+
+#define kfree(p) \
+({ \
+	if (!is_dpaax_in_destructor()) \
+		rte_free(p); \
+	else \
+		pr_debug("Eal memory has been destroyed.\n"); \
+})
 
 static inline unsigned long get_zeroed_page(gfp_t __foo __rte_unused)
 {
diff --git a/drivers/common/dpaax/dpaax_iova_table.c b/drivers/common/dpaax/dpaax_iova_table.c
index 1220d9654b..d53b24d4f4 100644
--- a/drivers/common/dpaax/dpaax_iova_table.c
+++ b/drivers/common/dpaax/dpaax_iova_table.c
@@ -1,17 +1,40 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2023 NXP
+ * Copyright 2018-2023,2026 NXP
  */
 
 #include <eal_export.h>
 #include <rte_memory.h>
 
 #include "dpaax_iova_table.h"
+#include "compat.h"
 #include "dpaax_logs.h"
 
 /* Global table reference */
 RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_p)
 struct dpaax_iova_table *dpaax_iova_table_p;
 
+/*
+ * Track whether the process is executing DPDK destructors. During
+ * teardown the EAL memory subsystem may already be gone, so freeing
+ * EAL memory from a DPAAx destructor is unsafe. Drivers mark the
+ * destructor context via dpaax_enter_destructor() so that kfree()
+ * (see compat.h) can skip rte_free() in that window.
+ */
+static int s_dpaax_in_destructor;
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_enter_destructor)
+void dpaax_enter_destructor(void)
+{
+	s_dpaax_in_destructor = 1;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(is_dpaax_in_destructor)
+int is_dpaax_in_destructor(void)
+{
+	return s_dpaax_in_destructor;
+}
+
+
 static int dpaax_handle_memevents(void);
 
 /* A structure representing the device-tree node available in /proc/device-tree.
diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 3d44739028..d0d451ca50 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -517,6 +517,8 @@ RTE_FINI_PRIO(dpaa_mpool_finish, RTE_PRIORITY_104)
 {
 	uint16_t bpid;
 
+	dpaax_enter_destructor();
+
 	for (bpid = 0; bpid < DPAA_MAX_BPOOLS; bpid++) {
 		if (s_dpaa_bpid_allocated_flag[bpid].used) {
 			bman_free_bpid(bpid, s_dpaa_bpid_allocated_flag[bpid].flags);
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index f31a529915..0d75b5fc0a 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2827,6 +2827,7 @@ RTE_FINI_PRIO(dpaa_finish, 103)
 	struct rte_eth_dev *dev;
 
 	PMD_INIT_FUNC_TRACE();
+	dpaax_enter_destructor();
 	/* For secondary, primary will do all the cleanup */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return;
-- 
2.25.1


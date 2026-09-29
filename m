Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4170DCA5FAC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 10:45:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 525B141104;
	Tue, 29 Sep 2026 12:45:40 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4C14540E96
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:45:25 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 22AB61A00C8;
 Tue, 29 Sep 2026 12:45:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA9391A00C9;
 Tue, 29 Sep 2026 12:45:24 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1639E18000BA;
 Tue, 29 Sep 2026 18:45:24 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v17 05/23] bus/dpaa: scan max BPID from DTS
Date: Tue, 29 Sep 2026 16:15:01 +0530
Message-Id: <20260929104519.1770698-6-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
References: <20260928065849.126909-1-hemant.agrawal@nxp.com>
 <20260929104519.1770698-1-hemant.agrawal@nxp.com>
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

Calculate the maximum BPID dynamically from the device tree
configuration instead of using a hardcoded value. This ensures
correct operation across different DPAA hardware configurations.

Also update the default BMAN HW version for Layerscape devices.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman_driver.c | 65 ++++++++++++++++-------
 drivers/bus/dpaa/include/fsl_bman.h       |  5 ++
 2 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman_driver.c b/drivers/bus/dpaa/base/qbman/bman_driver.c
index 71a2028383..9021d43688 100644
--- a/drivers/bus/dpaa/base/qbman/bman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/bman_driver.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017 NXP
+ * Copyright 2017,2026 NXP
  *
  */
 
@@ -17,7 +17,7 @@
  * Global variables of the max portal/pool number this bman version supported
  */
 static u16 bman_ip_rev;
-u16 bman_pool_max;
+u16 bman_pool_max = BMAN_MAX_POOLS;
 static void *bman_ccsr_map;
 
 /*****************/
@@ -180,9 +180,16 @@ int bman_init_ccsr(const struct device_node *node)
 	return 0;
 }
 
+#define BPID_RANGE_START_INDEX 0
+#define BPID_RANGE_COUNT_INDEX 1
+
 int bman_global_init(void)
 {
 	const struct device_node *dt_node;
+	const rte_be32_t *range;
+	uint32_t start = 0, count = 0;
+	int ret;
+	size_t len;
 	static int done;
 
 	if (done)
@@ -198,7 +205,6 @@ int bman_global_init(void)
 	if (of_device_is_compatible(dt_node, "fsl,bman-portal-1.0") ||
 	    of_device_is_compatible(dt_node, "fsl,bman-portal-1.0.0")) {
 		bman_ip_rev = BMAN_REV10;
-		bman_pool_max = 64;
 	} else if (of_device_is_compatible(dt_node, "fsl,bman-portal-2.0") ||
 		of_device_is_compatible(dt_node, "fsl,bman-portal-2.0.8")) {
 		bman_ip_rev = BMAN_REV20;
@@ -208,26 +214,49 @@ int bman_global_init(void)
 		of_device_is_compatible(dt_node, "fsl,bman-portal-2.1.2") ||
 		of_device_is_compatible(dt_node, "fsl,bman-portal-2.1.3")) {
 		bman_ip_rev = BMAN_REV21;
-		bman_pool_max = 64;
 	} else {
-		pr_warn("unknown BMan version in portal node,default "
-			"to rev1.0");
-		bman_ip_rev = BMAN_REV10;
-		bman_pool_max = 64;
+		pr_warn("unknown bman version in portal node, default to rev2.1.0");
+		bman_ip_rev = BMAN_REV21;
+	}
+
+	for_each_compatible_node(dt_node, NULL, "fsl,bpid-range") {
+		range = of_get_property(dt_node, "fsl,bpid-range", &len);
+		if (!range || len < (int)(2 * sizeof(rte_be32_t)))
+			continue;
+		start = rte_be_to_cpu_32(range[BPID_RANGE_START_INDEX]);
+		count = rte_be_to_cpu_32(range[BPID_RANGE_COUNT_INDEX]);
+		if (!count) {
+			pr_warn("Empty BPID range in DTS, using default pool max\n");
+			continue;
+		}
+		/* The depletion mask and the SCN registers only describe
+		 * BPID 0..BMAN_MAX_POOLS-1, and bman_create_portal() walks
+		 * this bound with a u8, so a larger value from the DTS would
+		 * write past the last SCN register and never terminate.
+		 */
+		if (start + count > BMAN_MAX_POOLS) {
+			pr_warn("BPID range %u+%u exceeds max %u, clamping\n",
+				start, count, BMAN_MAX_POOLS);
+			bman_pool_max = BMAN_MAX_POOLS;
+		} else {
+			bman_pool_max = start + count;
+		}
+		pr_info("Max BPID: %d, fixed BPID < %d", bman_pool_max, start);
+		break;
 	}
+	if (!count)
+		pr_warn("No BPID range found in DTS, using default pool max\n");
 
-	if (!bman_ip_rev) {
-		pr_err("Unknown bman portal version\n");
+	dt_node = of_find_compatible_node(NULL, NULL, "fsl,bman");
+	if (!dt_node) {
+		pr_err("No bman device node available");
 		return -ENODEV;
 	}
-	{
-		const struct device_node *dn = of_find_compatible_node(NULL,
-							NULL, "fsl,bman");
-		if (!dn)
-			pr_err("No bman device node available");
-
-		if (bman_init_ccsr(dn))
-			pr_err("BMan CCSR map failed.");
+
+	ret = bman_init_ccsr(dt_node);
+	if (ret) {
+		pr_err("Failed(%d) to init bman ccsr", ret);
+		return ret;
 	}
 
 	done = 1;
diff --git a/drivers/bus/dpaa/include/fsl_bman.h b/drivers/bus/dpaa/include/fsl_bman.h
index 2d24b89889..639e0edc96 100644
--- a/drivers/bus/dpaa/include/fsl_bman.h
+++ b/drivers/bus/dpaa/include/fsl_bman.h
@@ -21,6 +21,11 @@ struct bman_depletion {
 	u32 state[2];
 };
 
+/* Number of buffer pools the depletion mask above, and the BMan portal SCN
+ * registers, can describe. BPIDs are limited to this range.
+ */
+#define BMAN_MAX_POOLS	64U
+
 static inline void bman_depletion_init(struct bman_depletion *c)
 {
 	c->state[0] = c->state[1] = 0;
-- 
2.25.1


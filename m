Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ABCCD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0DFC40E11;
	Fri, 19 Jun 2026 14:29:31 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9F10C40BA0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 14:29:29 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DC70200251;
 Fri, 19 Jun 2026 14:29:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4501A200248;
 Fri, 19 Jun 2026 14:29:29 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA6F4180004C;
 Fri, 19 Jun 2026 20:29:27 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 02/18] bus/dpaa: scan max BPID from DTS
Date: Fri, 19 Jun 2026 17:58:59 +0530
Message-Id: <20260619122922.3774666-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
References: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
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

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman_driver.c | 48 ++++++++++++++++-------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman_driver.c b/drivers/bus/dpaa/base/qbman/bman_driver.c
index 71a2028383..f227e8fc44 100644
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
 
@@ -183,7 +183,12 @@ int bman_init_ccsr(const struct device_node *node)
 int bman_global_init(void)
 {
 	const struct device_node *dt_node;
+	const rte_be32_t *range;
+	uint32_t start, count;
+	int ret;
 	static int done;
+#define BPID_RANGE_START_INDEX 0
+#define BPID_RANGE_COUNT_INDEX 1
 
 	if (done)
 		return -EBUSY;
@@ -198,36 +203,49 @@ int bman_global_init(void)
 	if (of_device_is_compatible(dt_node, "fsl,bman-portal-1.0") ||
 	    of_device_is_compatible(dt_node, "fsl,bman-portal-1.0.0")) {
 		bman_ip_rev = BMAN_REV10;
-		bman_pool_max = 64;
 	} else if (of_device_is_compatible(dt_node, "fsl,bman-portal-2.0") ||
 		of_device_is_compatible(dt_node, "fsl,bman-portal-2.0.8")) {
 		bman_ip_rev = BMAN_REV20;
-		bman_pool_max = 8;
 	} else if (of_device_is_compatible(dt_node, "fsl,bman-portal-2.1.0") ||
 		of_device_is_compatible(dt_node, "fsl,bman-portal-2.1.1") ||
 		of_device_is_compatible(dt_node, "fsl,bman-portal-2.1.2") ||
 		of_device_is_compatible(dt_node, "fsl,bman-portal-2.1.3")) {
 		bman_ip_rev = BMAN_REV21;
-		bman_pool_max = 64;
 	} else {
-		pr_warn("unknown BMan version in portal node,default "
-			"to rev1.0");
+		pr_warn("unknown BMan version in portal node, default to rev1.0");
 		bman_ip_rev = BMAN_REV10;
-		bman_pool_max = 64;
 	}
 
 	if (!bman_ip_rev) {
 		pr_err("Unknown bman portal version\n");
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
+	for_each_compatible_node(dt_node, NULL, "fsl,bpid-range") {
+		range = of_get_property(dt_node, "fsl,bpid-range", NULL);
+		if (!range)
+			continue;
+		start = rte_be_to_cpu_32(range[BPID_RANGE_START_INDEX]);
+		count = rte_be_to_cpu_32(range[BPID_RANGE_COUNT_INDEX]);
+		bman_pool_max = start + count;
+		pr_info("Max BPID: %d, fixed BPID < %d", bman_pool_max, start);
+		break;
+	}
+	if (!bman_pool_max) {
+		pr_err("No BPID range found");
+		return -ENODEV;
+	}
+
+	dt_node = of_find_compatible_node(NULL, NULL, "fsl,bman");
+	if (!dt_node) {
+		pr_err("No bman device node available");
+		return -ENODEV;
+	}
+
+	ret = bman_init_ccsr(dt_node);
+	if (ret) {
+		pr_err("Failed(%d) to init bman ccsr", ret);
+		return ret;
 	}
 
 	done = 1;
-- 
2.25.1


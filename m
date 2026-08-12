Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D7C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:46:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8EFB40DDC;
	Wed, 12 Aug 2026 19:46:21 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id BC29A40BA0
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:46:18 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 93F451A0046;
 Wed, 12 Aug 2026 19:46:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B3C91A0043;
 Wed, 12 Aug 2026 19:46:18 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D371418000B0;
 Thu, 13 Aug 2026 01:46:16 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v9 03/25] bus/dpaa: scan max BPID from DTS
Date: Wed, 12 Aug 2026 23:15:46 +0530
Message-Id: <20260812174609.1100111-4-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260812174609.1100111-1-hemant.agrawal@nxp.com>
References: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
 <20260812174609.1100111-1-hemant.agrawal@nxp.com>
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

Also update the default BMAN HW verion for Layerscape devices.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman_driver.c | 45 +++++++++++++++++------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman_driver.c b/drivers/bus/dpaa/base/qbman/bman_driver.c
index 71a2028383..42f810490d 100644
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
 
@@ -180,9 +180,15 @@ int bman_init_ccsr(const struct device_node *node)
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
 	static int done;
 
 	if (done)
@@ -210,9 +216,8 @@ int bman_global_init(void)
 		bman_ip_rev = BMAN_REV21;
 		bman_pool_max = 64;
 	} else {
-		pr_warn("unknown BMan version in portal node,default "
-			"to rev1.0");
-		bman_ip_rev = BMAN_REV10;
+		pr_warn("unknown BMan version in portal node, default to rev2.1.0");
+		bman_ip_rev = BMAN_REV21;
 		bman_pool_max = 64;
 	}
 
@@ -220,14 +225,30 @@ int bman_global_init(void)
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
+	if (!(start + count))
+		pr_warn("No BPID range found in DTS, using default pool max\n");
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


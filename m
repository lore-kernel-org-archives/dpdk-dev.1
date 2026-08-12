Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877ECC5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 09:29:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7DC6402B8;
	Wed, 12 Aug 2026 11:29:37 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 34733402B8
 for <dev@dpdk.org>; Wed, 12 Aug 2026 11:29:34 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 141032002FF;
 Wed, 12 Aug 2026 11:29:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D37F020001E;
 Wed, 12 Aug 2026 11:29:33 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B6E218000B1;
 Wed, 12 Aug 2026 17:29:33 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 1/5] bus/platform: match device by devicetree compatible
 string
Date: Wed, 12 Aug 2026 14:59:25 +0530
Message-Id: <20260812092929.563973-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260812092929.563973-1-g.singh@nxp.com>
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
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

The platform bus currently matches a DPDK driver to a device only by
comparing the kernel driver name bound to the device against the DPDK
driver name. Devices bound to the generic vfio-platform kernel driver
all report the same driver name, which carries no device identity, so a
specific DPDK driver cannot claim its device this way.

Add of_device_is_compatible(), which reads the device-tree "compatible"
strings exposed under the device's of_node in sysfs and compares them
against a requested string. platform_bus_match() now falls back to
matching the DPDK driver name or its alias against these compatible
strings, letting a driver bind to a device identified by its
device-tree "compatible" value.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst     |  9 ++++
 drivers/bus/platform/bus_platform_driver.h | 11 ++++-
 drivers/bus/platform/platform.c            | 49 +++++++++++++++++++++-
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..a2c0267818 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,15 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **bus/platform: match devices by device-tree compatible string.**
+
+  The platform bus now matches DPDK drivers against the device-tree
+  ``compatible`` sysfs strings exposed by each platform device, in
+  addition to the existing kernel driver name and device name checks.
+  This allows drivers to be probed by DT compatible string when the
+  kernel driver is the generic ``vfio-platform``, which carries no
+  device identity in its name.
+
 
 Removed Items
 -------------
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index e4dcbacf5e..607fd0bd1d 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -121,12 +121,19 @@ static const char *pdrvinit_ ## nm ## _alias; \
 RTE_INIT(pdrvinitfn_ ##nm) \
 { \
 	(platform_drv).driver.name = RTE_STR(nm); \
-	(platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
+	if (pdrvinit_ ## nm ## _alias != NULL) \
+		(platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
 	rte_platform_register(&(platform_drv)); \
 } \
 RTE_PMD_EXPORT_NAME(nm)
 
-/** Helper for setting platform driver alias. */
+/**
+ * Helper for setting platform driver alias.
+ *
+ * Note: this macro uses RTE_STR() to stringify the alias argument, so it
+ * cannot express strings that contain a comma. For such aliases,
+ * set .driver.alias directly in the rte_platform_driver initializer instead.
+ */
 #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
 static const char *pdrvinit_ ## nm ## _alias = RTE_STR(alias)
 
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 90d865a8df..b3bc66be01 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2023 Marvell.
+ * Copyright 2026 NXP
  */
 
 #include <uapi/linux/vfio.h>
@@ -230,6 +231,41 @@ of_resource_name(const char *dev_name, int index)
 	return NULL;
 }
 
+/*
+ * Check whether any of the NUL-separated device-tree "compatible" strings
+ * exposed by the platform device matches the given string.
+ */
+static bool
+of_device_is_compatible(const char *dev_name, const char *compat)
+{
+	char path[PATH_MAX], buf[BUFSIZ] = { };
+	const char *s;
+	FILE *f;
+	size_t len;
+
+	if (compat == NULL)
+		return false;
+
+	snprintf(path, sizeof(path), PLATFORM_BUS_DEVICES_PATH "/%s/of_node/compatible", dev_name);
+	f = fopen(path, "r");
+	if (f == NULL)
+		return false;
+
+	/* Read the raw contents, preserving embedded NULL separators. */
+	len = fread(buf, 1, sizeof(buf) - 1, f);
+	fclose(f);
+	if (len == 0)
+		return false;
+
+	/* Bound the walk by the read length: some kernels omit the trailing NULL. */
+	for (s = buf; s < buf + len; s += strlen(s) + 1) {
+		if (!strcmp(s, compat))
+			return true;
+	}
+
+	return false;
+}
+
 static int
 device_map_resources(struct rte_platform_device *pdev, unsigned int num)
 {
@@ -386,7 +422,18 @@ platform_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 	}
 
 	/* match by device name */
-	if (!strcmp(pdev->name, pdrv->driver.name))
+	if (!strcmp(pdev->name, pdrv->driver.name)) {
+		match = true;
+		goto out;
+	}
+
+	/*
+	 * The generic vfio-platform kernel driver name carries no device
+	 * identity, so fall back to matching the device-tree "compatible"
+	 * strings against the DPDK driver name or alias.
+	 */
+	if (of_device_is_compatible(pdev->name, pdrv->driver.name) ||
+	    of_device_is_compatible(pdev->name, pdrv->driver.alias))
 		match = true;
 
 out:
-- 
2.25.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4349DC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 09:22:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 370A140431;
	Thu,  6 Aug 2026 11:22:12 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id BE0D0402F1
 for <dev@dpdk.org>; Thu,  6 Aug 2026 11:22:10 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 961142002A8;
 Thu,  6 Aug 2026 11:22:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F090200028;
 Thu,  6 Aug 2026 11:22:10 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8B2EA1800088;
 Thu,  6 Aug 2026 17:22:09 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	Tomasz Duszynski <tduszynski@marvell.com>
Cc: hemant.agrawal@nxp.com
Subject: [PATCH] bus/platform: match device by devicetree compatible string
Date: Thu,  6 Aug 2026 14:52:08 +0530
Message-Id: <20260806092208.587673-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/bus/platform/platform.c | 67 ++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 90d865a8df..6d5b0d3a4e 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2023 Marvell.
+ * Copyright 2026 NXP
  */
 
 #include <uapi/linux/vfio.h>
@@ -230,6 +231,57 @@ of_resource_name(const char *dev_name, int index)
 	return NULL;
 }
 
+/*
+ * Check whether any of the NUL-separated device-tree "compatible" strings
+ * exposed by the platform device matches the given string. A single pair of
+ * enclosing double quotes is stripped from the requested compatible so both
+ * quoted and unquoted spellings match the raw device-tree value.
+ */
+static bool
+of_device_is_compatible(const char *dev_name, const char *compat)
+{
+	char path[PATH_MAX], buf[BUFSIZ] = { };
+	char want[BUFSIZ];
+	const char *s;
+	size_t clen;
+	FILE *f;
+	size_t len;
+
+	if (compat == NULL)
+		return false;
+
+	/* Copy the requested compatible, dropping a pair of enclosing quotes. */
+	clen = strlen(compat);
+	if (clen >= 2 && compat[0] == '"' && compat[clen - 1] == '"') {
+		clen -= 2;
+		if (clen >= sizeof(want))
+			clen = sizeof(want) - 1;
+		memcpy(want, compat + 1, clen);
+		want[clen] = '\0';
+	} else {
+		rte_strscpy(want, compat, sizeof(want));
+	}
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
+		if (!strcmp(s, want))
+			return true;
+	}
+
+	return false;
+}
+
 static int
 device_map_resources(struct rte_platform_device *pdev, unsigned int num)
 {
@@ -386,8 +438,21 @@ platform_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 	}
 
 	/* match by device name */
-	if (!strcmp(pdev->name, pdrv->driver.name))
+	if (!strcmp(pdev->name, pdrv->driver.name)) {
 		match = true;
+		goto out;
+	}
+
+	/*
+	 * The generic vfio-platform kernel driver name carries no device
+	 * identity, so fall back to matching the device-tree "compatible"
+	 * strings against the DPDK driver name or alias.
+	 */
+	if (of_device_is_compatible(pdev->name, pdrv->driver.name) ||
+	    of_device_is_compatible(pdev->name, pdrv->driver.alias)) {
+		match = true;
+		goto out;
+	}
 
 out:
 	free(kdrv);
-- 
2.25.1


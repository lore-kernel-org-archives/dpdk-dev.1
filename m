Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FFDCC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1191E402DF;
	Thu, 15 Oct 2026 17:43:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 422B8402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792079036; x=1823615036;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K44T2FwQyLLZGmynnEM2mKm5dgVn2IeKoRyTstgcDiY=;
 b=fYnzMvO4DSzT0A8xcXkERXjVL34K6F3peIO5cTt7Y6A2up8R5QBB6MZg
 mbeZ7nlYU/NU95/kRQmKFtf+yPX3WhKlpwTwjpbw+pVY+0rJ7hsVZC1+7
 I2LATryQpvSiNgT58LmWiUGlkG1hIcJj8lTv1NFcXqEOmKBfQpLNlswv1
 GwKC4j2cPiUAyKSJ6JoBfCaUYhcMrvrYSJqw5rli+WB/yNLIHGVERktK+
 1KPsXWLB6q+M8IpXaV/KQEVfBbMsCMQwCad0Gr0YYK7Z1IW+ieaAOrr0k
 Vj8WUMiXhiT6YXGzvkvNhQE1QnsSNulnIiMlwhQ7MT/cZRO72XK2g56Xm w==;
X-CSE-ConnectionGUID: GJAK6ufHSky9Tgkq//HncQ==
X-CSE-MsgGUID: vE8OggrTTmKGNiTIZGhwGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="849508"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="849508"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 08:43:55 -0700
X-CSE-ConnectionGUID: kKuyzDv7T32X3RnJALtlmA==
X-CSE-MsgGUID: mtue2Gb8Q+CaJI8tP889Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="3474488"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 15 Oct 2026 08:43:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v1 1/1] vfio: fix device lookup with no-IOMMU mode enabled
Date: Thu, 15 Oct 2026 16:43:53 +0100
Message-ID: <ee502d37f54dbb6ea8ae4473e684eeb0f500db1d.1792079025.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, when the `enable_unsafe_noiommu_mode` VFIO module parameter is
set, VFIO selects PA IOVA mode and then only looks for no-IOMMU device
nodes: `/dev/vfio/noiommu-N` in group mode, and `noiommu-vfioN` in cdev
mode.

However, the parameter does not make every VFIO device a no-IOMMU
device. The kernel only creates a no-IOMMU group for a device that has no
IOMMU group of its own; devices behind a real IOMMU still get a regular
`/dev/vfio/N` group and `vfioN` cdev. On such systems, devices bound
to `vfio-pci` are therefore reported as not managed by VFIO and fail
to probe.

Fix it by trying the regular node name first and falling back to the
no-IOMMU one, in both group and cdev modes.

Fixes: 6cb38a7f56e0 ("vfio: introduce VFIO mode")
Fixes: d129414711aa ("vfio: introduce cdev mode")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_vfio_cdev.c  | 65 +++++++++++++++++-----------------
 lib/eal/linux/eal_vfio_group.c | 19 +++++-----
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/lib/eal/linux/eal_vfio_cdev.c b/lib/eal/linux/eal_vfio_cdev.c
index ab4d3f9f44..4a955248ae 100644
--- a/lib/eal/linux/eal_vfio_cdev.c
+++ b/lib/eal/linux/eal_vfio_cdev.c
@@ -23,8 +23,29 @@
 #include "eal_internal_cfg.h"
 
 #define DEV_VFIO_IOMMUFD_PATH "/dev/iommu"
-#define DEV_VFIO_CDEV_FMT "/dev/vfio/devices/vfio%d"
-#define DEV_VFIO_NOIOMMU_CDEV_FMT "/dev/vfio/devices/noiommu-vfio%d"
+#define DEV_VFIO_CDEV_FMT "/dev/vfio/devices/%s%d"
+
+/*
+ * Global no-IOMMU mode does not mean every device is no-IOMMU: the kernel only
+ * creates no-IOMMU devices for devices without an IOMMU group, so cdev names
+ * are tried in this order regardless of IOVA mode.
+ */
+static const char * const cdev_prefixes[] = {"vfio", "noiommu-vfio"};
+
+/* return length of the matching cdev prefix, or 0 if the name has none */
+static size_t
+cdev_match_prefix(const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(cdev_prefixes); i++) {
+		size_t len = strlen(cdev_prefixes[i]);
+
+		if (strncmp(name, cdev_prefixes[i], len) == 0)
+			return len;
+	}
+	return 0;
+}
 
 static int vfio_cdev_dma_map(struct vfio_container *cfg);
 static int vfio_cdev_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr,
@@ -208,28 +229,12 @@ int
 vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr, int *cdev_dev_num)
 {
 	char linkname[PATH_MAX] = {0};
-	const char *prefix;
 	size_t prefix_len;
 	char *dev_tok, *end;
 	int dev_num;
 	DIR *dir;
 	struct dirent *entry;
 
-	/* different prefixes for different IOMMU modes */
-	switch (vfio_global_cfg.iova_mode) {
-	case DEV_VFIO_IOVA_MODE_VA:
-		prefix = "vfio";
-		prefix_len = strlen(prefix);
-		break;
-	case DEV_VFIO_IOVA_MODE_PA:
-		prefix = "noiommu-vfio";
-		prefix_len = strlen(prefix);
-		break;
-	default:
-		EAL_LOG(ERR, "VFIO IOMMU mode is not initialized");
-		return -1;
-	}
-
 	/* check if vfio-dev directory exists for this device */
 	snprintf(linkname, sizeof(linkname), "%s/%s/vfio-dev", sysfs_base, dev_addr);
 
@@ -241,7 +246,8 @@ vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr, int *cdev
 
 	/* find the matching VFIO cdev entry */
 	while ((entry = readdir(dir)) != NULL) {
-		if (strncmp(entry->d_name, prefix, prefix_len) != 0)
+		prefix_len = cdev_match_prefix(entry->d_name);
+		if (prefix_len == 0)
 			continue;
 
 		/* parse device number after the cdev entry prefix */
@@ -281,21 +287,16 @@ static int
 cdev_open_device_fd(int cdev_dev_num)
 {
 	char devname[PATH_MAX] = {0};
-	int dev_fd;
+	int dev_fd = -1;
+	unsigned int i;
 
-	switch (vfio_global_cfg.iova_mode) {
-	case DEV_VFIO_IOVA_MODE_VA:
-		snprintf(devname, sizeof(devname), DEV_VFIO_CDEV_FMT, cdev_dev_num);
-		break;
-	case DEV_VFIO_IOVA_MODE_PA:
-		snprintf(devname, sizeof(devname), DEV_VFIO_NOIOMMU_CDEV_FMT, cdev_dev_num);
-		break;
-	default:
-		EAL_LOG(ERR, "VFIO IOMMU mode is not initialized");
-		return -1;
+	for (i = 0; i < RTE_DIM(cdev_prefixes); i++) {
+		snprintf(devname, sizeof(devname), DEV_VFIO_CDEV_FMT,
+			cdev_prefixes[i], cdev_dev_num);
+		dev_fd = open(devname, O_RDWR);
+		if (dev_fd >= 0 || errno != ENOENT)
+			break;
 	}
-
-	dev_fd = open(devname, O_RDWR);
 	if (dev_fd < 0) {
 		EAL_LOG(ERR, "Cannot open %s: %s", devname, strerror(errno));
 		return -1;
diff --git a/lib/eal/linux/eal_vfio_group.c b/lib/eal/linux/eal_vfio_group.c
index aef3e9f27a..7c879830ac 100644
--- a/lib/eal/linux/eal_vfio_group.c
+++ b/lib/eal/linux/eal_vfio_group.c
@@ -554,17 +554,20 @@ vfio_open_group_sysfs(int iommu_group_num)
 	char filename[PATH_MAX];
 	int fd;
 
-	if (vfio_global_cfg.iova_mode == DEV_VFIO_IOVA_MODE_VA)
-		snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
-	else if (vfio_global_cfg.iova_mode == DEV_VFIO_IOVA_MODE_PA)
-		snprintf(filename, sizeof(filename), DEV_VFIO_NOIOMMU_GROUP_FMT, iommu_group_num);
-
-	/* reset errno before open to differentiate errors */
-	errno = 0;
+	/*
+	 * Global no-IOMMU mode does not mean every group is no-IOMMU: the
+	 * kernel only creates no-IOMMU groups for devices without an IOMMU
+	 * group, so try the regular group first, then the no-IOMMU one.
+	 */
+	snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
 	fd = open(filename, O_RDWR);
+	if (fd < 0 && errno == ENOENT) {
+		snprintf(filename, sizeof(filename), DEV_VFIO_NOIOMMU_GROUP_FMT, iommu_group_num);
+		fd = open(filename, O_RDWR);
+	}
 
 	/* we have to differentiate between failed open and non-existence */
-	if (errno == ENOENT)
+	if (fd < 0 && errno == ENOENT)
 		return -ENOENT;
 	return fd;
 }
-- 
2.52.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AB8CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0CAA40291;
	Fri, 16 Oct 2026 13:11:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5AA2F400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792149115; x=1823685115;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mDdrWC/3qLi1vNoCXZj5sCuaRj6NNLrNZp/G9SLKRuc=;
 b=TQnpQQikkwcgnvXVo4tlnhOovSFqbFmsrVP6J/W6cU9FUqNwCLhtOVMX
 xl5O6B2VtPrAOY8iL1Kr2AXw3q/rDU2czgPLiJyLmn/GfNTsb+k/jPIkJ
 HQS7lSLiPX0HQP2T18tA7JSeNltXYPAuWMrqq3JtlWsf2b7n9pbNCJ/yN
 2htJKd7+pWWSt4cGrCSuM0KjQtJJ+mNA4/gth/CTp8GOypKMtsevmvk9k
 f9Q7nxRIuxAKI6/iSH2Cyeif5wU3t7CWRIGuoqg7EkWhGBnpxEckGU/8H
 oC/gTaPdQtYE31UolGvJJjNLFJNmJNpsAo1DriK+7nUsBW49DUQABKDzR Q==;
X-CSE-ConnectionGUID: nAy5F86VRAGvcb6Fh1tzng==
X-CSE-MsgGUID: RJmejNmlSFytWKdyWVOUNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="835952"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="835952"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:11:54 -0700
X-CSE-ConnectionGUID: UeFg4PlGQ+SboHplHR0LJA==
X-CSE-MsgGUID: MUlJrS5xTKijvM/kW91Tiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1830424"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 16 Oct 2026 04:11:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/1] vfio: make container IOMMU type sticky
Date: Fri, 16 Oct 2026 12:11:51 +0100
Message-ID: <051e9222e64646d597f115eb0c8e18138959af80.1792149104.git.anatoly.burakov@intel.com>
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

In VFIO, technically, no-IOMMU mode can be enabled even if the system
itself still uses IOMMU and all devices have full IOMMU backing. Thus,
the no-IOMMU status is effectively per-container, not global.

Currently, we check device path for no-IOMMU-ness each time we try to
open them. We can improve upon that by taking advantage of the fact that
one cannot mix IOMMU types within a container - once a container opens a
device that uses or does not use IOMMU, no other device type can be added
to the container.

To address that, at the time of opening/closing first/close last device,
we store the IOMMU type used by the container, and expect all other
devices to match without any need to check for that any further. The
IOMMU mode mismatch (i.e. trying to open a no-IOMMU device and use it
with an IOMMU-ful container) is a new error condition as it does not
quite map to "device not managed by VFIO" semantics, so also document a
new return code, and add internal plumbing to handle this correctly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_vfio.c         | 115 +++++++++++++++++++++++++++++--
 lib/eal/linux/eal_vfio.h         |  24 ++++++-
 lib/eal/linux/eal_vfio_cdev.c    |  78 ++++++++++++++-------
 lib/eal/linux/eal_vfio_group.c   |  41 ++++++-----
 lib/eal/linux/include/dev_vfio.h |   2 +
 5 files changed, 206 insertions(+), 54 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index fdf500cd5b..e50550c7fe 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -40,6 +40,7 @@
  * - EEXIST: device already assigned
  * - ENOENT: group or device not found
  * - ENOMEM: memory allocation failed
+ * - EPERM: device IOMMU mode does not match container
  * - EIO: underlying VFIO operation failed
  */
 
@@ -53,6 +54,7 @@ enum vfio_result {
 	VFIO_NOT_FOUND,
 	VFIO_NO_SPACE,
 	VFIO_NO_MEM,
+	VFIO_IOMMU_MISMATCH,
 };
 
 /* per-process, per-container data */
@@ -481,6 +483,76 @@ vfio_container_erase(struct vfio_container *cfg)
 	*cfg = VFIO_CONTAINER_INITIALIZER;
 }
 
+static const char *
+vfio_node_type_to_str(enum vfio_node_type type)
+{
+	switch (type) {
+	case VFIO_NODE_IOMMU: return "IOMMU";
+	case VFIO_NODE_NOIOMMU: return "no-IOMMU";
+	default: return "unset";
+	}
+}
+
+/*
+ * Open a VFIO group or cdev node. If the container's node type is not yet
+ * known, try the IOMMU node first, then the no-IOMMU one, and remember which
+ * one was found. Returns fd on success, -ENOENT if no node exists, -EXDEV if
+ * only a node of the other type exists, or -1 with errno set on other errors.
+ */
+int
+vfio_open_node(struct vfio_container *cfg,
+		vfio_node_path_t path_fn,
+		int node_num)
+{
+	static const enum vfio_node_type probe_order[] = {VFIO_NODE_IOMMU, VFIO_NODE_NOIOMMU};
+	enum vfio_node_type cur, other;
+	char path[PATH_MAX];
+	unsigned int i;
+	int fd;
+
+	if (cfg->node_type != VFIO_NODE_UNSET) {
+		if (path_fn(cfg->node_type, node_num, path, sizeof(path)) < 0)
+			goto path_fail;
+		fd = open(path, O_RDWR);
+		if (fd >= 0 || errno != ENOENT)
+			return fd;
+
+		/* a node of the other type means the user is trying to mix them */
+		other = cfg->node_type == VFIO_NODE_IOMMU ? VFIO_NODE_NOIOMMU : VFIO_NODE_IOMMU;
+		if (path_fn(other, node_num, path, sizeof(path)) < 0)
+			goto path_fail;
+		if (access(path, F_OK) == 0) {
+			EAL_LOG(DEBUG, "Found %s, but container uses %s devices",
+				path, vfio_node_type_to_str(cfg->node_type));
+			return -EXDEV;
+		}
+		return -ENOENT;
+	}
+
+	/* probe the IOMMU and no-IOMMU nodes in order */
+	for (i = 0; i < RTE_DIM(probe_order); i++) {
+		cur = probe_order[i];
+
+		if (path_fn(cur, node_num, path, sizeof(path)) < 0)
+			goto path_fail;
+		fd = open(path, O_RDWR);
+		if (fd >= 0) {
+			cfg->node_type = cur;
+			EAL_LOG(DEBUG, "VFIO container uses %s devices",
+				vfio_node_type_to_str(cfg->node_type));
+			return fd;
+		}
+		if (errno != ENOENT)
+			return -1;
+	}
+	return -ENOENT;
+
+path_fail:
+	EAL_LOG(ERR, "Cannot build VFIO node path for node %d", node_num);
+	errno = EINVAL;
+	return -1;
+}
+
 static struct vfio_device *
 vfio_device_create(struct vfio_container *cfg, enum dev_vfio_mode mode)
 {
@@ -509,15 +581,20 @@ vfio_device_create(struct vfio_container *cfg, enum dev_vfio_mode mode)
 static void
 vfio_device_erase(struct vfio_container *cfg, struct vfio_device *dev)
 {
+	enum dev_vfio_mode mode = dev->mode;
+
 	if (dev->fd >= 0 && close(dev->fd))
 		EAL_LOG(ERR, "Error when closing device, %d (%s)", errno, strerror(errno));
 
-	if (dev->mode == DEV_VFIO_MODE_GROUP) {
+	if (mode == DEV_VFIO_MODE_GROUP) {
 		free(dev->sysfs_base);
 		free(dev->dev_addr);
 	}
 	*dev = (struct vfio_device){0};
 	cfg->n_devices--;
+
+	if (mode == DEV_VFIO_MODE_CDEV && cfg->n_devices == 0)
+		cfg->node_type = VFIO_NODE_UNSET;
 }
 
 static struct vfio_device *
@@ -648,8 +725,14 @@ vfio_cdev_assign_device(struct vfio_container *cfg, const char *sysfs_base, cons
 	enum vfio_result res;
 	int dev_num, ret;
 
-	/* get the cdev device number from sysfs */
-	ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, &dev_num);
+	/* get the cdev device number from sysfs, matching container node type if known */
+	ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, cfg->node_type, &dev_num);
+	if (ret == 0 && cfg->node_type != VFIO_NODE_UNSET) {
+		/* device may be bound to VFIO, but with a different node type */
+		ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, VFIO_NODE_UNSET, &dev_num);
+		if (ret > 0)
+			return VFIO_IOMMU_MISMATCH;
+	}
 	if (ret < 0) {
 		EAL_LOG(ERR, "Failed to get cdev device number for %s", dev_addr);
 		return VFIO_ERROR;
@@ -676,7 +759,10 @@ vfio_cdev_assign_device(struct vfio_container *cfg, const char *sysfs_base, cons
 
 	/* set up our device now and store it in config */
 	ret = vfio_cdev_setup_device(cfg, dev);
-	if (ret < 0) {
+	if (ret == -EXDEV) {
+		res = VFIO_IOMMU_MISMATCH;
+		goto err;
+	} else if (ret < 0) {
 		EAL_LOG(ERR, "Cannot setup cdev device %s", dev_addr);
 		res = VFIO_ERROR;
 		goto err;
@@ -760,6 +846,9 @@ vfio_group_assign_device(struct vfio_container *cfg, const char *sysfs_base, con
 				dev_addr, iommu_group_num);
 			res = VFIO_NOT_MANAGED;
 			goto group_erase;
+		} else if (ret == -EXDEV) {
+			res = VFIO_IOMMU_MISMATCH;
+			goto group_erase;
 		} else if (ret < 0) {
 			EAL_LOG(ERR, "Cannot open VFIO group %d for device %s",
 				iommu_group_num, dev_addr);
@@ -951,6 +1040,11 @@ dev_vfio_container_assign_device(int container_fd, const char *sysfs_base, const
 		EAL_LOG(ERR, "Memory allocation failed for device %s", dev_addr);
 		rte_errno = ENOMEM;
 		return -1;
+	case VFIO_IOMMU_MISMATCH:
+		EAL_LOG(ERR, "Cannot assign device %s: cannot mix IOMMU and no-IOMMU",
+			dev_addr);
+		rte_errno = EPERM;
+		return -1;
 	default:
 		EAL_LOG(ERR, "Error assigning device %s to container", dev_addr);
 		rte_errno = EIO;
@@ -1004,8 +1098,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 	{
 		int dev_num;
 
-		/* find device number */
-		ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, &dev_num);
+		/* device may belong to custom container, do not assume node type */
+		ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, VFIO_NODE_UNSET, &dev_num);
 		if (ret < 0)
 			goto assign_fail;
 		else if (ret == 0)
@@ -1045,6 +1139,12 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 		rte_errno = ENOMEM;
 		ret = -1;
 		goto unlock;
+	case VFIO_IOMMU_MISMATCH:
+		EAL_LOG(ERR, "Cannot set up device %s: cannot mix IOMMU and no-IOMMU",
+			dev_addr);
+		rte_errno = EPERM;
+		ret = -1;
+		goto unlock;
 	default:
 assign_fail:
 		EAL_LOG(ERR, "Error assigning device %s to container", dev_addr);
@@ -1506,7 +1606,8 @@ dev_vfio_get_device_num(const char *sysfs_base, const char *dev_addr, int *devic
 		return -1;
 	}
 
-	ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, device_num);
+	/* device may belong to custom container, do not assume node type */
+	ret = vfio_cdev_get_device_num(sysfs_base, dev_addr, VFIO_NODE_UNSET, device_num);
 	if (ret < 0) {
 		rte_errno = EINVAL;
 		return -1;
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 980bdae0ba..56ddaac955 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -75,10 +75,29 @@ struct vfio_cdev_config {
 	uint32_t ioas_id;
 };
 
+/*
+ * Device node namespace used by a container. Global no-IOMMU mode does not make
+ * every device no-IOMMU, but a container cannot mix both kinds, so once the
+ * first group/device is opened, the node type is fixed for that container.
+ */
+enum vfio_node_type {
+	VFIO_NODE_UNSET = 0, /**< no group/device opened yet */
+	VFIO_NODE_IOMMU,     /**< /dev/vfio/N or /dev/vfio/devices/vfioN */
+	VFIO_NODE_NOIOMMU,   /**< /dev/vfio/noiommu-N or /dev/vfio/devices/noiommu-vfioN */
+};
+
+/* Mode-specific node path function.
+ * Builds path to group/cdev node number node_num of a given type into buf.
+ * Returns 0 on success, -1 on failure.
+ */
+typedef int (*vfio_node_path_t)(enum vfio_node_type type, int node_num,
+		char *buf, size_t len);
+
 /* per-container configuration */
 struct vfio_container {
 	bool active;
 	bool dma_setup_done;
+	enum vfio_node_type node_type;
 	int container_fd;
 	struct vfio_user_mem_maps mem_maps;
 	union {
@@ -145,6 +164,9 @@ int vfio_get_iommu_type(void);
 int vfio_mp_sync_setup(void);
 void vfio_mp_sync_cleanup(void);
 bool vfio_container_is_default(struct vfio_container *cfg);
+int vfio_open_node(struct vfio_container *cfg,
+		vfio_node_path_t path_fn,
+		int node_num);
 
 /* group mode functions */
 int vfio_group_enable(struct vfio_container *cfg);
@@ -167,7 +189,7 @@ int vfio_cdev_setup_ioas(struct vfio_container *cfg);
 int vfio_cdev_sync_ioas(struct vfio_container *cfg);
 int vfio_cdev_get_iommufd(void);
 int vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr,
-		int *cdev_dev_num);
+		enum vfio_node_type node_type, int *cdev_dev_num);
 struct vfio_device *vfio_cdev_get_dev_by_num(struct vfio_container *cfg, int cdev_dev_num);
 int vfio_cdev_setup_device(struct vfio_container *cfg, struct vfio_device *dev);
 
diff --git a/lib/eal/linux/eal_vfio_cdev.c b/lib/eal/linux/eal_vfio_cdev.c
index 4a955248ae..13979a9526 100644
--- a/lib/eal/linux/eal_vfio_cdev.c
+++ b/lib/eal/linux/eal_vfio_cdev.c
@@ -23,25 +23,37 @@
 #include "eal_internal_cfg.h"
 
 #define DEV_VFIO_IOMMUFD_PATH "/dev/iommu"
-#define DEV_VFIO_CDEV_FMT "/dev/vfio/devices/%s%d"
+#define DEV_VFIO_CDEV_FMT "/dev/vfio/devices/vfio%d"
+#define DEV_VFIO_NOIOMMU_CDEV_FMT "/dev/vfio/devices/noiommu-vfio%d"
 
 /*
  * Global no-IOMMU mode does not mean every device is no-IOMMU: the kernel only
- * creates no-IOMMU devices for devices without an IOMMU group, so cdev names
- * are tried in this order regardless of IOVA mode.
+ * creates no-IOMMU devices for devices without an IOMMU group, so both cdev
+ * names must be recognized in sysfs regardless of IOVA mode.
  */
-static const char * const cdev_prefixes[] = {"vfio", "noiommu-vfio"};
+static const struct {
+	enum vfio_node_type type;
+	const char *prefix;
+} cdev_prefixes[] = {
+	{ VFIO_NODE_IOMMU, "vfio" },
+	{ VFIO_NODE_NOIOMMU, "noiommu-vfio" },
+};
 
-/* return length of the matching cdev prefix, or 0 if the name has none */
+/*
+ * return length of the matching cdev prefix, or 0 if the name has none. If
+ * type is set, only the prefix for that node type is matched.
+ */
 static size_t
-cdev_match_prefix(const char *name)
+cdev_match_prefix(const char *name, enum vfio_node_type type)
 {
 	unsigned int i;
 
 	for (i = 0; i < RTE_DIM(cdev_prefixes); i++) {
-		size_t len = strlen(cdev_prefixes[i]);
+		size_t len = strlen(cdev_prefixes[i].prefix);
 
-		if (strncmp(name, cdev_prefixes[i], len) == 0)
+		if (type != VFIO_NODE_UNSET && type != cdev_prefixes[i].type)
+			continue;
+		if (strncmp(name, cdev_prefixes[i].prefix, len) == 0)
 			return len;
 	}
 	return 0;
@@ -226,7 +238,8 @@ vfio_cdev_enable(struct vfio_container *cfg)
 }
 
 int
-vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr, int *cdev_dev_num)
+vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr,
+		enum vfio_node_type node_type, int *cdev_dev_num)
 {
 	char linkname[PATH_MAX] = {0};
 	size_t prefix_len;
@@ -246,7 +259,7 @@ vfio_cdev_get_device_num(const char *sysfs_base, const char *dev_addr, int *cdev
 
 	/* find the matching VFIO cdev entry */
 	while ((entry = readdir(dir)) != NULL) {
-		prefix_len = cdev_match_prefix(entry->d_name);
+		prefix_len = cdev_match_prefix(entry->d_name, node_type);
 		if (prefix_len == 0)
 			continue;
 
@@ -284,21 +297,36 @@ vfio_cdev_get_dev_by_num(struct vfio_container *cfg, int cdev_dev_num)
 }
 
 static int
-cdev_open_device_fd(int cdev_dev_num)
+cdev_node_path(enum vfio_node_type type, int cdev_dev_num, char *buf, size_t len)
 {
-	char devname[PATH_MAX] = {0};
-	int dev_fd = -1;
-	unsigned int i;
-
-	for (i = 0; i < RTE_DIM(cdev_prefixes); i++) {
-		snprintf(devname, sizeof(devname), DEV_VFIO_CDEV_FMT,
-			cdev_prefixes[i], cdev_dev_num);
-		dev_fd = open(devname, O_RDWR);
-		if (dev_fd >= 0 || errno != ENOENT)
-			break;
+	switch (type) {
+	case VFIO_NODE_IOMMU:
+		snprintf(buf, len, DEV_VFIO_CDEV_FMT, cdev_dev_num);
+		return 0;
+	case VFIO_NODE_NOIOMMU:
+		snprintf(buf, len, DEV_VFIO_NOIOMMU_CDEV_FMT, cdev_dev_num);
+		return 0;
+	default:
+		errno = EINVAL;
+		return -1;
 	}
-	if (dev_fd < 0) {
-		EAL_LOG(ERR, "Cannot open %s: %s", devname, strerror(errno));
+}
+
+static int
+cdev_open_device_fd(struct vfio_container *cfg, int cdev_dev_num)
+{
+	int dev_fd;
+
+	dev_fd = vfio_open_node(cfg, cdev_node_path, cdev_dev_num);
+	if (dev_fd == -EXDEV) {
+		/* node type mismatch, reported by caller */
+		return -EXDEV;
+	} else if (dev_fd == -ENOENT) {
+		EAL_LOG(ERR, "Cannot find VFIO cdev for device %d", cdev_dev_num);
+		return -1;
+	} else if (dev_fd < 0) {
+		EAL_LOG(ERR, "Cannot open VFIO cdev for device %d: %s", cdev_dev_num,
+			strerror(errno));
 		return -1;
 	}
 
@@ -398,9 +426,9 @@ vfio_cdev_setup_device(struct vfio_container *cfg, struct vfio_device *dev)
 
 	/* get device fd - primary or custom container opens it, secondary requests from primary */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY || !vfio_container_is_default(cfg)) {
-		device_fd = cdev_open_device_fd(dev->dev_num);
+		device_fd = cdev_open_device_fd(cfg, dev->dev_num);
 		if (device_fd < 0)
-			return -1;
+			return device_fd == -EXDEV ? -EXDEV : -1;
 		dev->fd = device_fd;
 
 		/* attach device to iommufd */
diff --git a/lib/eal/linux/eal_vfio_group.c b/lib/eal/linux/eal_vfio_group.c
index 7c879830ac..c8f3ee29ce 100644
--- a/lib/eal/linux/eal_vfio_group.c
+++ b/lib/eal/linux/eal_vfio_group.c
@@ -532,6 +532,7 @@ vfio_group_erase(struct vfio_container *cfg, struct vfio_group *grp)
 	/* if this was the last group in config, erase IOMMU setup and unregister callback */
 	if (group_cfg->n_groups == 0) {
 		cfg->dma_setup_done = false;
+		cfg->node_type = VFIO_NODE_UNSET;
 		group_cfg->iommu_type_set = false;
 	}
 }
@@ -549,27 +550,25 @@ vfio_group_get_by_num(struct vfio_container *cfg, int iommu_group)
 }
 
 static int
-vfio_open_group_sysfs(int iommu_group_num)
+vfio_group_node_path(enum vfio_node_type type, int iommu_group_num, char *buf, size_t len)
 {
-	char filename[PATH_MAX];
-	int fd;
-
-	/*
-	 * Global no-IOMMU mode does not mean every group is no-IOMMU: the
-	 * kernel only creates no-IOMMU groups for devices without an IOMMU
-	 * group, so try the regular group first, then the no-IOMMU one.
-	 */
-	snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
-	fd = open(filename, O_RDWR);
-	if (fd < 0 && errno == ENOENT) {
-		snprintf(filename, sizeof(filename), DEV_VFIO_NOIOMMU_GROUP_FMT, iommu_group_num);
-		fd = open(filename, O_RDWR);
+	switch (type) {
+	case VFIO_NODE_IOMMU:
+		snprintf(buf, len, DEV_VFIO_GROUP_FMT, iommu_group_num);
+		return 0;
+	case VFIO_NODE_NOIOMMU:
+		snprintf(buf, len, DEV_VFIO_NOIOMMU_GROUP_FMT, iommu_group_num);
+		return 0;
+	default:
+		errno = EINVAL;
+		return -1;
 	}
+}
 
-	/* we have to differentiate between failed open and non-existence */
-	if (fd < 0 && errno == ENOENT)
-		return -ENOENT;
-	return fd;
+static int
+vfio_open_group_sysfs(struct vfio_container *cfg, int iommu_group_num)
+{
+	return vfio_open_node(cfg, vfio_group_node_path, iommu_group_num);
 }
 
 static int
@@ -611,10 +610,10 @@ vfio_group_open_fd(struct vfio_container *cfg, struct vfio_group *grp)
 	if ((rte_eal_process_type() != RTE_PROC_PRIMARY) && (vfio_container_is_default(cfg)))
 		vfio_group_fd = vfio_group_request_fd(grp->group_num);
 	else
-		vfio_group_fd = vfio_open_group_sysfs(grp->group_num);
+		vfio_group_fd = vfio_open_group_sysfs(cfg, grp->group_num);
 
-	/* pass the non-existence up the chain */
-	if (vfio_group_fd == -ENOENT)
+	/* pass the non-existence and node type mismatch up the chain */
+	if (vfio_group_fd == -ENOENT || vfio_group_fd == -EXDEV)
 		return vfio_group_fd;
 	else if (vfio_group_fd < 0) {
 		EAL_LOG(ERR, "Failed to open VFIO group %d", grp->group_num);
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index 57c5894679..0e5f14cabb 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -101,6 +101,7 @@ enum dev_vfio_iova_mode {
  * - ENXIO   - VFIO support not initialized.
  * - ENOTSUP - Unsupported VFIO mode.
  * - ENOMEM  - Memory allocation failed for device tracking.
+ * - EPERM   - Device IOMMU mode does not match container.
  */
 __rte_internal
 int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_dev_fd);
@@ -384,6 +385,7 @@ dev_vfio_container_destroy(int container_fd);
  * - ENXIO   - VFIO support not initialized.
  * - ENOTSUP - Unsupported VFIO mode.
  * - ENOMEM  - Memory allocation failed for device tracking.
+ * - EPERM   - Device IOMMU mode does not match container.
  */
 __rte_internal
 int
-- 
2.52.0


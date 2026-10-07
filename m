Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A6ACA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 373C842E8B;
	Wed,  7 Oct 2026 10:11:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1006440290
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VamV7qzmolGSXtHGR/vrpS/X5VYHr0bo2O4d2xFOMA=;
 b=QIGypAEwkA7/dNz6EIDWN+Q7TDC2WLRKBvegq+5twdxMF6DWCrUksGODHruR2Au9gwDbKo
 Aqep822exOrtcD2yGGIlmCNb2hr4yZPo1dwgTX+HD5cXr7Mze/OkGJUeBDrLhODj96hEOF
 xOjzzXNTacqcHpWp0OgH+2veaOhLRHE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-Pdl9WwuBN8GV1zexW1N9TQ-1; Wed,
 07 Oct 2026 04:11:05 -0400
X-MC-Unique: Pdl9WwuBN8GV1zexW1N9TQ-1
X-Mimecast-MFC-AGG-ID: Pdl9WwuBN8GV1zexW1N9TQ_1791360664
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9752A1944D69; Wed,  7 Oct 2026 08:11:04 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8A0C180034C; Wed,  7 Oct 2026 08:11:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RESEND][PATCH v19 08/26] vfio: teardown internals on VFIO cleanup
Date: Wed,  7 Oct 2026 10:10:05 +0200
Message-ID: <20261007081026.574382-9-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bax0rsIKntYLp-j7xhyCXiOUwTYqNaNU3-TTzHwiKvw_1791360664
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Anatoly Burakov <anatoly.burakov@intel.com>

Currently, VFIO cleanup only unregisters multiprocess callback, but does
not destroy containers, groups, and user mem maps. Do all of that on VFIO
cleanup. We don't actually need a per-config enabled flag, as container fd
should be enough to determine whether the config is active.

While we're at it, also harden the API against repeated
initialization and attempts at using the API without having VFIO
initialized.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
Changes since v18:
- squashed with introduction of dev_vfio_cleanup(),
- removed rte_errno = ENODEV updates since most of them are dropped
  later in the series,

---
 lib/eal/linux/eal.c              |   3 +-
 lib/eal/linux/eal_vfio.c         | 136 +++++++++++++++++++++++++++++--
 lib/eal/linux/include/dev_vfio.h |   7 ++
 3 files changed, 139 insertions(+), 7 deletions(-)

diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 55734b6057..419cebc236 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -52,7 +52,6 @@
 #include "eal_memcfg.h"
 #include "eal_trace.h"
 #include "eal_options.h"
-#include "eal_vfio.h"
 #include "hotplug_mp.h"
 #include "log_internal.h"
 
@@ -984,7 +983,7 @@ rte_eal_cleanup(void)
 
 	rte_service_finalize();
 	eal_bus_cleanup();
-	vfio_mp_sync_cleanup();
+	dev_vfio_cleanup();
 	rte_mp_channel_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 3548c87884..8461e47740 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -49,7 +49,6 @@ struct user_mem_maps {
 };
 
 struct vfio_config {
-	int vfio_enabled;
 	int vfio_container_fd;
 	int vfio_active_groups;
 	const struct vfio_iommu_type *vfio_iommu_type;
@@ -61,6 +60,9 @@ struct vfio_config {
 static struct vfio_config vfio_cfgs[RTE_MAX_VFIO_CONTAINERS];
 static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 
+/* whether VFIO is enabled (usable) in this process */
+static bool vfio_enabled;
+
 static int
 vfio_check_module(enum dev_vfio_module module)
 {
@@ -583,6 +585,9 @@ dev_vfio_get_group_fd(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled)
+		return -1;
+
 	/* get the vfio_config it belongs to */
 	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
 	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
@@ -731,7 +736,7 @@ vfio_sync_default_container(void)
 		return -1;
 
 	/* default container fd should have been opened in dev_vfio_enable() */
-	if (!default_vfio_cfg->vfio_enabled ||
+	if (!vfio_enabled ||
 			default_vfio_cfg->vfio_container_fd < 0) {
 		EAL_LOG(ERR, "VFIO support is not initialized");
 		return -1;
@@ -783,6 +788,9 @@ dev_vfio_clear_group(int vfio_group_fd)
 	int i;
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled)
+		return -1;
+
 	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO group fd!");
@@ -818,6 +826,9 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
+	if (!vfio_enabled)
+		return -1;
+
 	/* get group number */
 	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
 	if (ret == 0) {
@@ -1064,6 +1075,9 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	int iommu_group_num;
 	int ret;
 
+	if (!vfio_enabled)
+		return -1;
+
 	/* we don't want any DMA mapping messages to come while we're detaching
 	 * VFIO device, because this might be the last device and we might need
 	 * to unregister the callback.
@@ -1156,6 +1170,9 @@ dev_vfio_enable(void)
 
 	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
 
+	if (vfio_enabled)
+		return 0;
+
 	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
 		vfio_cfgs[i].vfio_container_fd = -1;
 		vfio_cfgs[i].vfio_active_groups = 0;
@@ -1212,7 +1229,7 @@ dev_vfio_enable(void)
 	/* check if we have VFIO driver enabled */
 	if (default_vfio_cfg->vfio_container_fd != -1) {
 		EAL_LOG(INFO, "VFIO support initialized");
-		default_vfio_cfg->vfio_enabled = 1;
+		vfio_enabled = true;
 	} else {
 		EAL_LOG(NOTICE, "VFIO support could not be initialized");
 	}
@@ -1231,12 +1248,15 @@ RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_is_enabled)
 int
 dev_vfio_is_enabled(void)
 {
-	return default_vfio_cfg->vfio_enabled;
+	return vfio_enabled;
 }
 
 int
 vfio_get_iommu_type(void)
 {
+	if (!vfio_enabled)
+		return -1;
+
 	if (default_vfio_cfg->vfio_iommu_type == NULL)
 		return -1;
 
@@ -1273,6 +1293,9 @@ dev_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 {
 	int ret;
 
+	if (!vfio_enabled)
+		return -1;
+
 	if (device_info == NULL || *vfio_dev_fd < 0)
 		return -1;
 
@@ -1408,7 +1431,7 @@ dev_vfio_get_container_fd(void)
 	 * The default container is set up during dev_vfio_enable().
 	 * This function does not create a new container.
 	 */
-	if (!default_vfio_cfg->vfio_enabled)
+	if (!vfio_enabled)
 		return -1;
 
 	return default_vfio_cfg->vfio_container_fd;
@@ -1424,6 +1447,9 @@ dev_vfio_get_group_num(const char *sysfs_base,
 	char *tok[16], *group_tok, *end;
 	int ret;
 
+	if (!vfio_enabled)
+		return -1;
+
 	memset(linkname, 0, sizeof(linkname));
 	memset(filename, 0, sizeof(filename));
 
@@ -2124,6 +2150,9 @@ dev_vfio_container_create(void)
 {
 	unsigned int i;
 
+	if (!vfio_enabled)
+		return -1;
+
 	/* Find an empty slot to store new vfio config */
 	for (i = 1; i < RTE_DIM(vfio_cfgs); i++) {
 		if (vfio_cfgs[i].vfio_container_fd == -1)
@@ -2152,6 +2181,14 @@ dev_vfio_container_destroy(int container_fd)
 	struct vfio_config *vfio_cfg;
 	unsigned int i;
 
+	if (!vfio_enabled)
+		return -1;
+
+	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD) {
+		EAL_LOG(ERR, "Cannot destroy default VFIO container");
+		return -1;
+	}
+
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
@@ -2177,6 +2214,9 @@ dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled)
+		return -1;
+
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
@@ -2194,6 +2234,9 @@ dev_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	struct vfio_config *vfio_cfg;
 	unsigned int i;
 
+	if (!vfio_enabled)
+		return -1;
+
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
@@ -2234,6 +2277,9 @@ dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled)
+		return -1;
+
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
@@ -2255,6 +2301,9 @@ dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled)
+		return -1;
+
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
@@ -2268,3 +2317,80 @@ dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 
 	return container_dma_unmap(vfio_cfg, vaddr, iova, len);
 }
+
+static int
+vfio_cleanup_config(struct vfio_config *vfio_cfg)
+{
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
+		struct vfio_group *group = &vfio_cfg->vfio_groups[i];
+
+		if (group->group_num == -1)
+			continue;
+		if (group->devices != 0) {
+			EAL_LOG(ERR, "Cannot cleanup VFIO group %d with %d devices",
+				group->group_num, group->devices);
+			continue;
+		}
+		if (group->fd >= 0 && close(group->fd) < 0) {
+			EAL_LOG(ERR, "Cannot close VFIO group %d: %s",
+				group->group_num, strerror(errno));
+			continue;
+		}
+
+		group->group_num = -1;
+		group->fd = -1;
+		group->devices = 0;
+		vfio_cfg->vfio_active_groups--;
+	}
+
+	/* if there are still active groups, we cannot cleanup the container */
+	if (vfio_cfg->vfio_active_groups != 0) {
+		EAL_LOG(ERR, "Cannot cleanup VFIO container with %d active groups",
+			vfio_cfg->vfio_active_groups);
+		return -1;
+	}
+
+	if (vfio_cfg->vfio_container_fd >= 0 && close(vfio_cfg->vfio_container_fd) < 0) {
+		EAL_LOG(ERR, "Cannot close VFIO container: %s", strerror(errno));
+		return -1;
+	}
+
+	vfio_cfg->vfio_container_fd = -1;
+	vfio_cfg->vfio_iommu_type = NULL;
+
+	vfio_cfg->mem_maps.n_maps = 0;
+	memset(vfio_cfg->mem_maps.maps, 0, sizeof(vfio_cfg->mem_maps.maps));
+
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_cleanup)
+void
+dev_vfio_cleanup(void)
+{
+	unsigned int i;
+	bool stuck = false;
+
+	if (!vfio_enabled)
+		return;
+
+	vfio_mp_sync_cleanup();
+
+	/* mem events can only be unregistered from the primary process */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+
+	/* cleanup all initialized configs */
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
+		if (vfio_cfgs[i].vfio_container_fd != -1)
+			stuck |= vfio_cleanup_config(&vfio_cfgs[i]) != 0;
+	}
+
+	/* failed to deinitialize some configs, so don't set VFIO as disabled */
+	if (stuck)
+		return;
+
+	vfio_enabled = false;
+}
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index 8e06f7dee8..46ec508083 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -104,6 +104,13 @@ int dev_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
 __rte_internal
 int dev_vfio_enable(void);
 
+/**
+ * @internal
+ * Cleanup VFIO resources.
+ */
+__rte_internal
+void dev_vfio_cleanup(void);
+
 /**
  * @internal
  * Check whether a VFIO module is loaded.
-- 
2.54.0


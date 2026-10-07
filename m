Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B24FCA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C10D842ECD;
	Wed,  7 Oct 2026 10:11:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 564FD42ED9
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ccJF1vmkl5k5rOCCL/67nmQf042ta9Lwd93EkkAz2s=;
 b=Db1vzX+l+MkGDLBQiaUW5Ln5GHZb5suAEMiD8SNm9uvkQhB0K29A5uRZc0qTY35jJt85fF
 Oq4w0Mn6FEcVya3yga4CNjxUn1TGJUBBoB5rmSeeNB/fz9Rl/bH5oMNMvY6ESRuj6zSAUU
 dkHTZSFOkl4z2UpprmAQLdyq4Jg/mag=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-OjMuCmXkONS4xxVWNH-g-Q-1; Wed,
 07 Oct 2026 04:11:51 -0400
X-MC-Unique: OjMuCmXkONS4xxVWNH-g-Q-1
X-Mimecast-MFC-AGG-ID: OjMuCmXkONS4xxVWNH-g-Q_1791360710
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EA7A1802556; Wed,  7 Oct 2026 08:11:50 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 865B018004D4; Wed,  7 Oct 2026 08:11:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RESEND][PATCH v19 21/26] vfio: add some check on input parameters
Date: Wed,  7 Oct 2026 10:10:18 +0200
Message-ID: <20261007081026.574382-22-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VeDNH7dpJ-vrqohxG7PtJxcmIlgcOU_zOOr4qHWJ9ws_1791360710
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

Make error handling more consistent, and provide/document rte_errno values
returned from API's to indicate various conditions.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_vfio.c         | 33 ++++++++++++-
 lib/eal/linux/include/dev_vfio.h | 84 +++++++++++++++++---------------
 2 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index bd267d1796..d4a165464f 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -29,6 +29,12 @@
 
 #define VFIO_MEM_EVENT_CLB_NAME "vfio_mem_event_clb"
 
+/*
+ * rte_errno convention:
+ *
+ * - EINVAL: invalid parameters
+ */
+
 /* per-process VFIO config */
 static struct vfio_container vfio_containers[RTE_MAX_VFIO_CONTAINERS];
 
@@ -755,6 +761,11 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
+	if (sysfs_base == NULL || dev_addr == NULL || vfio_dev_fd == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	if (!vfio_enabled)
 		return -1;
 
@@ -986,6 +997,11 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	int iommu_group_num;
 	int ret;
 
+	if (sysfs_base == NULL || dev_addr == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	if (!vfio_enabled)
 		return -1;
 
@@ -1177,10 +1193,15 @@ dev_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
 {
 	int ret;
 
+	if (device_info == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	if (!vfio_enabled)
 		return -1;
 
-	if (device_info == NULL || vfio_dev_fd < 0)
+	if (vfio_dev_fd < 0)
 		return -1;
 
 	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
@@ -1291,6 +1312,11 @@ dev_vfio_get_group_num(const char *sysfs_base,
 	char *tok[16], *group_tok, *end;
 	int ret;
 
+	if (sysfs_base == NULL || dev_addr == NULL || iommu_group_num == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	if (!vfio_enabled)
 		return -1;
 
@@ -1610,6 +1636,11 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 	int iommu_group_num;
 	int ret;
 
+	if (sysfs_base == NULL || dev_addr == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
 	if (ret < 0) {
 		EAL_LOG(ERR, "Cannot get IOMMU group number for device %s", dev_addr);
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index 08f4c902e7..b3bf1ed7eb 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -48,43 +48,46 @@ enum dev_vfio_module {
 
 /**
  * @internal
- * Setup vfio_cfg for the device identified by its address.
- * It discovers the configured I/O MMU groups or sets a new one for the device.
- * If a new groups is assigned, the DMA mapping is performed.
+ * Set up a device managed by VFIO driver.
  *
- * @param sysfs_base
- *   sysfs path prefix.
+ * If the device was not previously assigned to a container using
+ * `dev_vfio_container_assign_device()`, default container will be used.
  *
+ * @param sysfs_base
+ *   Sysfs path prefix.
  * @param dev_addr
- *   device location.
- *
+ *   Device identifier.
  * @param vfio_dev_fd
- *   Pointer to VFIO fd, will be set to the opened device fd on success.
+ *   Pointer to where VFIO device file descriptor will be stored.
  *
  * @return
  *   0 on success.
- *   <0 on failure.
  *   >1 if the device cannot be managed this way.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
  */
 __rte_internal
 int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_dev_fd);
 
 /**
  * @internal
- * Release a device mapped to a VFIO-managed I/O MMU group.
+ * Release a device managed by VFIO driver.
  *
  * @param sysfs_base
- *   sysfs path prefix.
- *
+ *   Sysfs path prefix.
  * @param dev_addr
- *   device location.
- *
+ *   Device identifier.
  * @param fd
- *   VFIO fd.
+ *   A previously set up VFIO file descriptor.
  *
  * @return
  *   0 on success.
- *   <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
  */
 __rte_internal
 int dev_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
@@ -149,18 +152,19 @@ int dev_vfio_noiommu_is_enabled(void);
  * Parse IOMMU group number for a device.
  *
  * @param sysfs_base
- *   sysfs path prefix.
- *
+ *   Sysfs path prefix.
  * @param dev_addr
- *   device location.
- *
+ *   Device identifier.
  * @param iommu_group_num
- *   iommu group number
+ *   Pointer to where IOMMU group number will be stored.
  *
  * @return
  *  >0 on success
  *   0 for non-existent group or VFIO
- *  <0 for errors
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
  */
 __rte_internal
 int
@@ -181,7 +185,10 @@ dev_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_
  *
  * @return
  *   0 on success.
- *   <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
  */
 __rte_internal
 int
@@ -251,7 +258,10 @@ dev_vfio_container_destroy(int container_fd);
  *
  * @return
  *   0 on success.
- *   <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid container file descriptor.
  */
 __rte_internal
 int
@@ -263,21 +273,20 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
  * Perform DMA mapping for devices in a container.
  *
  * @param container_fd
- *   the specified container fd. Use DEV_VFIO_DEFAULT_CONTAINER_FD to
- *   use the default container.
- *
+ *   Container file descriptor. Use DEV_VFIO_DEFAULT_CONTAINER_FD to use the default container.
  * @param vaddr
  *   Starting virtual address of memory to be mapped.
- *
  * @param iova
  *   Starting IOVA address of memory to be mapped.
- *
  * @param len
  *   Length of memory segment being mapped.
  *
  * @return
- *    0 if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
  */
 __rte_internal
 int
@@ -288,21 +297,20 @@ dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova, uint
  * Perform DMA unmapping for devices in a container.
  *
  * @param container_fd
- *   the specified container fd. Use DEV_VFIO_DEFAULT_CONTAINER_FD to
- *   use the default container.
- *
+ *   Container file descriptor. Use DEV_VFIO_DEFAULT_CONTAINER_FD to use the default container.
  * @param vaddr
  *   Starting virtual address of memory to be unmapped.
- *
  * @param iova
  *   Starting IOVA address of memory to be unmapped.
- *
  * @param len
  *   Length of memory segment being unmapped.
  *
  * @return
- *    0 if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
  */
 __rte_internal
 int
-- 
2.54.0


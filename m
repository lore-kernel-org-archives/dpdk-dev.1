Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C518CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:18:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E02340E4F;
	Wed,  3 Sep 2025 17:18:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B98BF40E2D
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:18:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JjWSpPPsfI4Fn+Uw3qlLQLVxSTeC7jKiXaP8EIPjZ0=;
 b=KXMEyz836LDAL6szLV0EjtyS0FOgPNWoQicCaabki7smv8YTA0vnvb2RzjFiYZrnwJWFLf
 s1Y0zDlzjnPyp2f7afLRxNLxb6q3xT7CwKb8Hrcgd/E8M8HA+CCNxbanfXcZtBKXM89F0r
 BYGkBCcOe7iNb6L2gwcsYSnYPBoniF8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-YX-u6pU6Mg-FptvhSTOxrA-1; Wed,
 03 Sep 2025 11:18:35 -0400
X-MC-Unique: YX-u6pU6Mg-FptvhSTOxrA-1
X-Mimecast-MFC-AGG-ID: YX-u6pU6Mg-FptvhSTOxrA_1756912713
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F7FB1800286; Wed,  3 Sep 2025 15:18:33 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BB5D19560B1; Wed,  3 Sep 2025 15:18:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC v2 4/9] vfio: remove public wrappers
Date: Wed,  3 Sep 2025 17:17:54 +0200
Message-ID: <20250903151800.1965006-5-david.marchand@redhat.com>
In-Reply-To: <20250903151800.1965006-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CBf8DxSvDn3KO0inpEMLbvpx8vNqXqMM-RrrE_hGZgk_1756912713
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

The public header defines a number of wrappers that can be removed or
hidden internally.

Either, those concern old Linux kernel versions that are not supported by
dpdk anymore (DPDK now requires Linux v5.4 at least), like:
- the request notifier feature, present since Linux v4.0,
- the noiommu mode, present since Linux v4.5,
- the capability support, present since Linux v4.6,
- the msix mapping feature, present since Linux v4.16,

Or, those wrappers can be made private as only consumed internally.
- VFIO_GET_REGION_IDX() has no equivalent in the Linux uapi, but
  is only used by the Linux PCI bus code,
- VFIO_DEVICE_FEATURE is only used by the CDX bus code,
- the various macros around /dev/vfio/ or the noiommu kmod parameter are
  only used by eal_vfio.c,

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/cdx/cdx_vfio.c       | 27 ++++++++++++
 drivers/bus/fslmc/fslmc_vfio.c   | 17 ++++----
 drivers/bus/pci/linux/pci_vfio.c | 23 +++--------
 drivers/bus/pci/pci_common.c     |  2 -
 lib/eal/include/rte_vfio.h       | 71 --------------------------------
 lib/eal/linux/eal_interrupts.c   | 10 -----
 lib/eal/linux/eal_vfio.c         | 23 ++++-------
 7 files changed, 50 insertions(+), 123 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 37e0c424d4..03d156388e 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -613,6 +613,33 @@ rte_cdx_vfio_intr_disable(const struct rte_intr_handle *intr_handle)
 	return ret;
 }
 
+/* VFIO_DEVICE_FEATURE is defined for kernel version 5.7 and newer. */
+#ifdef	VFIO_DEVICE_FEATURE
+#define	RTE_VFIO_DEVICE_FEATURE	VFIO_DEVICE_FEATURE
+#else
+#define	RTE_VFIO_DEVICE_FEATURE	_IO(VFIO_TYPE, VFIO_BASE + 17)
+struct vfio_device_feature {
+	__u32	argsz;
+	__u32	flags;
+#define	VFIO_DEVICE_FEATURE_MASK	(0xffff) /* 16-bit feature index */
+#define	VFIO_DEVICE_FEATURE_GET		(1 << 16) /* Get feature into data[] */
+#define	VFIO_DEVICE_FEATURE_SET		(1 << 17) /* Set feature from data[] */
+#define	VFIO_DEVICE_FEATURE_PROBE	(1 << 18) /* Probe feature support */
+	__u8	data[];
+};
+#endif
+
+#ifdef	VFIO_DEVICE_FEATURE_BUS_MASTER
+#define	RTE_VFIO_DEVICE_FEATURE_BUS_MASTER	VFIO_DEVICE_FEATURE_BUS_MASTER
+#else
+#define	RTE_VFIO_DEVICE_FEATURE_BUS_MASTER	10
+struct vfio_device_feature_bus_master {
+	__u32 op;
+#define	VFIO_DEVICE_FEATURE_CLEAR_MASTER	0	/* Clear Bus Master */
+#define	VFIO_DEVICE_FEATURE_SET_MASTER		1	/* Set Bus Master */
+};
+#endif
+
 /* Enable Bus Mastering */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_enable)
 int
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 68439cbd8c..cc4311989b 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -190,7 +190,7 @@ fslmc_vfio_add_group(int vfio_group_fd,
 	group->groupid = iommu_group_num;
 	rte_strscpy(group->group_name, group_name, sizeof(group->group_name));
 	if (rte_vfio_noiommu_is_enabled() > 0)
-		group->iommu_type = RTE_VFIO_NOIOMMU;
+		group->iommu_type = VFIO_NOIOMMU_IOMMU;
 	else
 		group->iommu_type = VFIO_TYPE1_IOMMU;
 	LIST_INSERT_HEAD(&s_vfio_container.groups, group, next);
@@ -396,8 +396,7 @@ fslmc_vfio_open_group_fd(const char *group_name)
 	/* if primary, try to open the group */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		/* try regular group format */
-		snprintf(filename, sizeof(filename),
-			VFIO_GROUP_FMT, iommu_group_num);
+		snprintf(filename, sizeof(filename), "/dev/vfio/%u", iommu_group_num);
 		vfio_group_fd = open(filename, O_RDWR);
 
 		goto add_vfio_group;
@@ -451,7 +450,7 @@ fslmc_vfio_check_extensions(int vfio_container_fd)
 	int ret;
 	uint32_t idx, n_extensions = 0;
 	static const int type_id[] = {RTE_VFIO_TYPE1, RTE_VFIO_SPAPR,
-		RTE_VFIO_NOIOMMU};
+		VFIO_NOIOMMU_IOMMU};
 	static const char * const type_id_nm[] = {"Type 1",
 		"sPAPR", "No-IOMMU"};
 
@@ -495,10 +494,10 @@ fslmc_vfio_open_container_fd(void)
 
 	/* if we're in a primary process, try to open the container */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		vfio_container_fd = open(VFIO_CONTAINER_PATH, O_RDWR);
+		vfio_container_fd = open("/dev/vfio/vfio", O_RDWR);
 		if (vfio_container_fd < 0) {
-			DPAA2_BUS_ERR("Open VFIO container(%s), err(%d)",
-				VFIO_CONTAINER_PATH, vfio_container_fd);
+			DPAA2_BUS_ERR("Open VFIO container, err(%d)",
+				vfio_container_fd);
 			ret = vfio_container_fd;
 			goto err_exit;
 		}
@@ -851,7 +850,7 @@ fslmc_map_dma(uint64_t vaddr, rte_iova_t iovaddr, size_t len)
 			return fd;
 		return -EIO;
 	}
-	if (fslmc_vfio_iommu_type(fd) == RTE_VFIO_NOIOMMU) {
+	if (fslmc_vfio_iommu_type(fd) == VFIO_NOIOMMU_IOMMU) {
 		DPAA2_BUS_DEBUG("Running in NOIOMMU mode");
 		if (phy != iovaddr) {
 			DPAA2_BUS_ERR("IOVA should support with IOMMU");
@@ -951,7 +950,7 @@ fslmc_unmap_dma(uint64_t vaddr, uint64_t iovaddr, size_t len)
 			return fd;
 		return -EIO;
 	}
-	if (fslmc_vfio_iommu_type(fd) == RTE_VFIO_NOIOMMU) {
+	if (fslmc_vfio_iommu_type(fd) == VFIO_NOIOMMU_IOMMU) {
 		DPAA2_BUS_DEBUG("Running in NOIOMMU mode");
 		return 0;
 	}
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index d0844585fe..9e5776ce3c 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -273,7 +273,6 @@ pci_vfio_setup_interrupts(struct rte_pci_device *dev, int vfio_dev_fd)
 	return -1;
 }
 
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 /*
  * Spinlock for device hot-unplug failure handling.
  * If it tries to access bus or device, such as handle sigbus on bus
@@ -390,7 +389,6 @@ pci_vfio_disable_notifier(struct rte_pci_device *dev)
 
 	return 0;
 }
-#endif
 
 static int
 pci_vfio_is_ioport_bar(const struct rte_pci_device *dev, int vfio_dev_fd,
@@ -665,12 +663,12 @@ pci_vfio_info_cap(struct vfio_region_info *info, int cap)
 	struct vfio_info_cap_header *h;
 	size_t offset;
 
-	if ((info->flags & RTE_VFIO_INFO_FLAG_CAPS) == 0) {
+	if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) == 0) {
 		/* VFIO info does not advertise capabilities */
 		return NULL;
 	}
 
-	offset = VFIO_CAP_OFFSET(info);
+	offset = info->cap_offset;
 	while (offset != 0) {
 		h = RTE_PTR_ADD(info, offset);
 		if (h->id == cap)
@@ -690,7 +688,7 @@ pci_vfio_msix_is_mappable(int vfio_dev_fd, int msix_region)
 	if (ret < 0)
 		return -1;
 
-	ret = pci_vfio_info_cap(info, RTE_VFIO_CAP_MSIX_MAPPABLE) != NULL;
+	ret = pci_vfio_info_cap(info, VFIO_REGION_INFO_CAP_MSIX_MAPPABLE) != NULL;
 
 	/* cleanup */
 	free(info);
@@ -745,10 +743,8 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	if (rte_intr_fd_set(dev->intr_handle, -1))
 		return -1;
 
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	if (rte_intr_fd_set(dev->vfio_req_intr_handle, -1))
 		return -1;
-#endif
 
 	/* store PCI address string */
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
@@ -904,13 +900,11 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 		goto err_map;
 	}
 
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	if (pci_vfio_enable_notifier(dev, vfio_dev_fd) != 0) {
 		PCI_LOG(ERR, "Error setting up notifier!");
 		goto err_map;
 	}
 
-#endif
 	TAILQ_INSERT_TAIL(vfio_res_list, vfio_res, next);
 
 	return 0;
@@ -945,10 +939,8 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 
 	if (rte_intr_fd_set(dev->intr_handle, -1))
 		return -1;
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	if (rte_intr_fd_set(dev->vfio_req_intr_handle, -1))
 		return -1;
-#endif
 
 	/* store PCI address string */
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
@@ -1002,10 +994,8 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 	/* we need save vfio_dev_fd, so it can be used during release */
 	if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd))
 		goto err_vfio_dev_fd;
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	if (rte_intr_dev_fd_set(dev->vfio_req_intr_handle, vfio_dev_fd))
 		goto err_vfio_dev_fd;
-#endif
 
 	return 0;
 err_vfio_dev_fd:
@@ -1085,14 +1075,12 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
 			loc->domain, loc->bus, loc->devid, loc->function);
 
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	ret = pci_vfio_disable_notifier(dev);
 	if (ret) {
 		PCI_LOG(ERR, "fail to disable req notifier.");
 		return -1;
 	}
 
-#endif
 	if (rte_intr_fd_get(dev->intr_handle) < 0)
 		return -1;
 
@@ -1226,6 +1214,7 @@ pci_vfio_ioport_map(struct rte_pci_device *dev, int bar,
 	return 0;
 }
 
+#define PCI_VFIO_GET_REGION_IDX(x) (x >> 40)
 void
 pci_vfio_ioport_read(struct rte_pci_ioport *p,
 		     void *data, size_t len, off_t offset)
@@ -1239,7 +1228,7 @@ pci_vfio_ioport_read(struct rte_pci_ioport *p,
 	if (pread(vfio_dev_fd, data,
 		    len, p->base + offset) <= 0)
 		PCI_LOG(ERR, "Can't read from PCI bar (%" PRIu64 ") : offset (%x)",
-			VFIO_GET_REGION_IDX(p->base), (int)offset);
+			PCI_VFIO_GET_REGION_IDX(p->base), (int)offset);
 }
 
 void
@@ -1255,7 +1244,7 @@ pci_vfio_ioport_write(struct rte_pci_ioport *p,
 	if (pwrite(vfio_dev_fd, data,
 		     len, p->base + offset) <= 0)
 		PCI_LOG(ERR, "Can't write to PCI bar (%" PRIu64 ") : offset (%x)",
-			VFIO_GET_REGION_IDX(p->base), (int)offset);
+			PCI_VFIO_GET_REGION_IDX(p->base), (int)offset);
 }
 
 int
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index c88634f790..bf5df3d94e 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -603,7 +603,6 @@ pci_hot_unplug_handler(struct rte_device *dev)
 		return -1;
 
 	switch (pdev->kdrv) {
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	case RTE_PCI_KDRV_VFIO:
 		/*
 		 * vfio kernel module guaranty the pci device would not be
@@ -614,7 +613,6 @@ pci_hot_unplug_handler(struct rte_device *dev)
 		rte_dev_event_callback_process(dev->name,
 					       RTE_DEV_EVENT_REMOVE);
 		break;
-#endif
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 	case RTE_PCI_KDRV_NIC_UIO:
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 035b727dd0..509ffec80c 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -21,79 +21,8 @@ extern "C" {
 
 #ifdef RTE_EXEC_ENV_LINUX
 
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0)
-#define HAVE_VFIO_DEV_REQ_INTERFACE
-#endif /* kernel version >= 4.0.0 */
-
 #include <linux/vfio.h>
 
-#define VFIO_DIR "/dev/vfio"
-#define VFIO_CONTAINER_PATH "/dev/vfio/vfio"
-#define VFIO_GROUP_FMT "/dev/vfio/%u"
-#define VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
-#define VFIO_GET_REGION_IDX(x) (x >> 40)
-#define VFIO_NOIOMMU_MODE      \
-	"/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
-
-/* NOIOMMU is defined from kernel version 4.5 onwards */
-#ifdef VFIO_NOIOMMU_IOMMU
-#define RTE_VFIO_NOIOMMU VFIO_NOIOMMU_IOMMU
-#else
-#define RTE_VFIO_NOIOMMU 8
-#endif
-
-/*
- * capabilities are only supported on kernel 4.6+. there were also some API
- * changes as well, so add a macro to get cap offset.
- */
-#ifdef VFIO_REGION_INFO_FLAG_CAPS
-#define RTE_VFIO_INFO_FLAG_CAPS VFIO_REGION_INFO_FLAG_CAPS
-#define VFIO_CAP_OFFSET(x) (x->cap_offset)
-#else
-#define RTE_VFIO_INFO_FLAG_CAPS (1 << 3)
-#define VFIO_CAP_OFFSET(x) (x->resv)
-struct vfio_info_cap_header {
-	uint16_t id;
-	uint16_t version;
-	uint32_t next;
-};
-#endif
-
-/* kernels 4.16+ can map BAR containing MSI-X table */
-#ifdef VFIO_REGION_INFO_CAP_MSIX_MAPPABLE
-#define RTE_VFIO_CAP_MSIX_MAPPABLE VFIO_REGION_INFO_CAP_MSIX_MAPPABLE
-#else
-#define RTE_VFIO_CAP_MSIX_MAPPABLE 3
-#endif
-
-/* VFIO_DEVICE_FEATURE is defined for kernel version 5.7 and newer. */
-#ifdef	VFIO_DEVICE_FEATURE
-#define	RTE_VFIO_DEVICE_FEATURE	VFIO_DEVICE_FEATURE
-#else
-#define	RTE_VFIO_DEVICE_FEATURE	_IO(VFIO_TYPE, VFIO_BASE + 17)
-struct vfio_device_feature {
-	__u32	argsz;
-	__u32	flags;
-#define	VFIO_DEVICE_FEATURE_MASK	(0xffff) /* 16-bit feature index */
-#define	VFIO_DEVICE_FEATURE_GET		(1 << 16) /* Get feature into data[] */
-#define	VFIO_DEVICE_FEATURE_SET		(1 << 17) /* Set feature from data[] */
-#define	VFIO_DEVICE_FEATURE_PROBE	(1 << 18) /* Probe feature support */
-	__u8	data[];
-};
-#endif
-
-#ifdef	VFIO_DEVICE_FEATURE_BUS_MASTER
-#define	RTE_VFIO_DEVICE_FEATURE_BUS_MASTER	VFIO_DEVICE_FEATURE_BUS_MASTER
-#else
-#define	RTE_VFIO_DEVICE_FEATURE_BUS_MASTER	10
-struct vfio_device_feature_bus_master {
-	__u32 op;
-#define	VFIO_DEVICE_FEATURE_CLEAR_MASTER	0	/* Clear Bus Master */
-#define	VFIO_DEVICE_FEATURE_SET_MASTER		1	/* Set Bus Master */
-};
-#endif
-
 #else /* ! RTE_EXEC_ENV_LINUX */
 
 /* we don't need an actual definition, only pointer is used */
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index d420ecf947..43e05c86a2 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -336,7 +336,6 @@ vfio_disable_msix(const struct rte_intr_handle *intr_handle) {
 	return ret;
 }
 
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 /* enable req notifier */
 static int
 vfio_enable_req(const struct rte_intr_handle *intr_handle)
@@ -396,7 +395,6 @@ vfio_disable_req(const struct rte_intr_handle *intr_handle)
 
 	return ret;
 }
-#endif
 
 static int
 uio_intx_intr_disable(const struct rte_intr_handle *intr_handle)
@@ -741,12 +739,10 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
 		if (vfio_enable_intx(intr_handle))
 			rc = -1;
 		break;
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	case RTE_INTR_HANDLE_VFIO_REQ:
 		if (vfio_enable_req(intr_handle))
 			rc = -1;
 		break;
-#endif
 	/* not used at this moment */
 	case RTE_INTR_HANDLE_DEV_EVENT:
 		rc = -1;
@@ -808,10 +804,8 @@ rte_intr_ack(const struct rte_intr_handle *intr_handle)
 		if (vfio_ack_intx(intr_handle))
 			return -1;
 		break;
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	case RTE_INTR_HANDLE_VFIO_REQ:
 		return -1;
-#endif
 	/* not used at this moment */
 	case RTE_INTR_HANDLE_DEV_EVENT:
 		return -1;
@@ -871,12 +865,10 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 		if (vfio_disable_intx(intr_handle))
 			rc = -1;
 		break;
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	case RTE_INTR_HANDLE_VFIO_REQ:
 		if (vfio_disable_req(intr_handle))
 			rc = -1;
 		break;
-#endif
 	/* not used at this moment */
 	case RTE_INTR_HANDLE_DEV_EVENT:
 		rc = -1;
@@ -937,9 +929,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		case RTE_INTR_HANDLE_ALARM:
 			bytes_read = sizeof(buf.timerfd_num);
 			break;
-#ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 		case RTE_INTR_HANDLE_VFIO_REQ:
-#endif
 		case RTE_INTR_HANDLE_VFIO_MSIX:
 		case RTE_INTR_HANDLE_VFIO_MSI:
 		case RTE_INTR_HANDLE_VFIO_LEGACY:
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 805f0ff92c..dfc3bd6e62 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -85,7 +85,7 @@ static const struct vfio_iommu_type iommu_types[] = {
 	},
 	/* IOMMU-less mode */
 	{
-		.type_id = RTE_VFIO_NOIOMMU,
+		.type_id = VFIO_NOIOMMU_IOMMU,
 		.name = "No-IOMMU",
 		.partial_unmap = true,
 		.dma_map_func = &vfio_noiommu_dma_map,
@@ -363,8 +363,7 @@ vfio_open_group_fd(int iommu_group_num)
 	/* if primary, try to open the group */
 	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
 		/* try regular group format */
-		snprintf(filename, sizeof(filename),
-				 VFIO_GROUP_FMT, iommu_group_num);
+		snprintf(filename, sizeof(filename), "/dev/vfio/%u", iommu_group_num);
 		vfio_group_fd = open(filename, O_RDWR);
 		if (vfio_group_fd < 0) {
 			/* if file not found, it's not an error */
@@ -375,9 +374,8 @@ vfio_open_group_fd(int iommu_group_num)
 			}
 
 			/* special case: try no-IOMMU path as well */
-			snprintf(filename, sizeof(filename),
-					VFIO_NOIOMMU_GROUP_FMT,
-					iommu_group_num);
+			snprintf(filename, sizeof(filename), "/dev/vfio/noiommu-%u",
+				iommu_group_num);
 			vfio_group_fd = open(filename, O_RDWR);
 			if (vfio_group_fd < 0) {
 				if (errno != ENOENT) {
@@ -1128,7 +1126,7 @@ rte_vfio_enable(const char *modname)
 	}
 
 	/* VFIO directory might not exist (e.g., unprivileged containers) */
-	dir = opendir(VFIO_DIR);
+	dir = opendir("/dev/vfio");
 	if (dir == NULL) {
 		EAL_LOG(DEBUG,
 			"VFIO directory does not exist, skipping VFIO support...");
@@ -1315,15 +1313,12 @@ rte_vfio_get_container_fd(void)
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
-
 	/* if we're in a primary process, try to open the container */
 	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
-		vfio_container_fd = open(VFIO_CONTAINER_PATH, O_RDWR);
+		vfio_container_fd = open("/dev/vfio/vfio", O_RDWR);
 		if (vfio_container_fd < 0) {
-			EAL_LOG(ERR,
-					"Cannot open VFIO container %s, error "
-					"%i (%s)", VFIO_CONTAINER_PATH,
-					errno, strerror(errno));
+			EAL_LOG(ERR, "Cannot open VFIO container, error %i (%s)",
+				errno, strerror(errno));
 			return -1;
 		}
 
@@ -2053,7 +2048,7 @@ rte_vfio_noiommu_is_enabled(void)
 	ssize_t cnt;
 	char c;
 
-	fd = open(VFIO_NOIOMMU_MODE, O_RDONLY);
+	fd = open("/sys/module/vfio/parameters/enable_unsafe_noiommu_mode", O_RDONLY);
 	if (fd < 0) {
 		if (errno != ENOENT) {
 			EAL_LOG(ERR, "Cannot open VFIO noiommu file "
-- 
2.51.0


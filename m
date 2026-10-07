Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8DCA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4C1E42ED2;
	Wed,  7 Oct 2026 10:12:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A17B842EB8
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eeHbW+7cY6olwCdYZIDD6FJWe5BQ+bc36XvPrA+MHR0=;
 b=ERsxK5eMvHjuxBynwIx5M3tdWYxQr0WFufOaMKByjmlPK4jUel2F6WkEZJZSMSDY5ENe1n
 vswkwuTruADsRWPEzd0quWwljoHZrPmepoYp0ZKQ1gf/P/aaSZZZTiTMj/TShuyz0QmsA9
 ECZkTrj9qvhHhXbwuVMJxoto/m8o72I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-yX5z8dT1MzynX97EdMooCg-1; Wed,
 07 Oct 2026 04:12:02 -0400
X-MC-Unique: yX5z8dT1MzynX97EdMooCg-1
X-Mimecast-MFC-AGG-ID: yX5z8dT1MzynX97EdMooCg_1791360721
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7AE9180064F; Wed,  7 Oct 2026 08:12:00 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAF4319560AB; Wed,  7 Oct 2026 08:11:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [RESEND][PATCH v19 23/26] vfio: introduce IOVA mode
Date: Wed,  7 Oct 2026 10:10:20 +0200
Message-ID: <20261007081026.574382-24-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -CBlEszpRMLFhU4q5GlbloOFbTLTB43jyigaoxBUN2k_1791360721
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

Introduce dev_vfio_get_iova_mode() to return the IOVA remapping capability
(PA, VA or UNKNOWN).

Because the no-IOMMU check will rely on new mode infrastructure in
later commits, the VFIO initialization now needs to happen before bus
scan, as buses depend on no-IOMMU information.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c          |   3 +-
 drivers/bus/fslmc/fslmc_vfio.c         |   2 +-
 drivers/bus/pci/linux/pci.c            |   2 +-
 drivers/net/hinic3/base/hinic3_hwdev.c |   3 +-
 drivers/net/ntnic/ntnic_ethdev.c       |   2 +-
 lib/eal/linux/eal.c                    |  15 ++-
 lib/eal/linux/eal_vfio.c               | 130 ++++++++++++++++++-------
 lib/eal/linux/eal_vfio.h               |   5 +
 lib/eal/linux/eal_vfio_mp_sync.c       |   5 +
 lib/eal/linux/include/dev_vfio.h       |  27 +++--
 10 files changed, 143 insertions(+), 51 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index d55c414ead..dab3a8a677 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -500,7 +500,8 @@ rte_dpaa2_get_iommu_class(void)
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
-	if (fslmc_all_device_support_iova() != 0 && dev_vfio_noiommu_is_enabled() == 0)
+	if (fslmc_all_device_support_iova() != 0 &&
+			dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_VA)
 		return RTE_IOVA_VA;
 
 	return RTE_IOVA_PA;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index c2b6ac1f3f..8e80336d51 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -204,7 +204,7 @@ fslmc_vfio_add_group(int vfio_group_fd,
 	group->fd = vfio_group_fd;
 	group->groupid = iommu_group_num;
 	rte_strscpy(group->group_name, group_name, sizeof(group->group_name));
-	if (dev_vfio_noiommu_is_enabled() > 0)
+	if (dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_PA)
 		group->iommu_type = VFIO_NOIOMMU_IOMMU;
 	else
 		group->iommu_type = VFIO_TYPE1_IOMMU;
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 3819961d2f..28949e3720 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -635,7 +635,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (dev_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_PA)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 6a6cf44752..9406b6cff2 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -78,7 +78,8 @@ hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && dev_vfio_noiommu_is_enabled() != 1;
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO &&
+			dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_VA;
 }
 
 int
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d79c4fc1d5..e0d84705f5 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2729,7 +2729,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_PA;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 419cebc236..a6003559da 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -674,6 +674,16 @@ rte_eal_init(int argc, char **argv)
 		}
 	}
 
+	/*
+	 * VFIO must be initialized before bus scan because buses need to know
+	 * about no-IOMMU mode status.
+	 */
+	if (dev_vfio_enable()) {
+		rte_eal_init_alert("Cannot init VFIO");
+		rte_errno = EAGAIN;
+		goto err_out;
+	}
+
 	if (rte_bus_scan()) {
 		rte_eal_init_alert("Cannot scan the buses for devices");
 		rte_errno = ENODEV;
@@ -769,11 +779,6 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (dev_vfio_enable()) {
-		rte_eal_init_alert("Cannot init VFIO");
-		rte_errno = EAGAIN;
-		goto err_out;
-	}
 	/* in secondary processes, memory init may allocate additional fbarrays
 	 * not present in primary processes, so to avoid any potential issues,
 	 * initialize memzones first.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index fe60c57fc5..d2fe459774 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -40,6 +40,7 @@
 static struct vfio_container vfio_containers[RTE_MAX_VFIO_CONTAINERS];
 
 struct vfio_config vfio_global_cfg = {
+	.iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN,
 	.default_cfg = &vfio_containers[0]
 };
 
@@ -341,6 +342,36 @@ compact_user_maps(struct vfio_user_mem_maps *user_mem_maps)
 		user_mem_map_cmp);
 }
 
+#define VFIO_NOIOMMU_MODE_PATH "/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
+
+static int
+vfio_noiommu_is_enabled(void)
+{
+	int fd;
+	ssize_t cnt;
+	char c;
+
+	fd = open(VFIO_NOIOMMU_MODE_PATH, O_RDONLY);
+	if (fd < 0) {
+		if (errno != ENOENT) {
+			EAL_LOG(ERR, "Cannot open VFIO noiommu file %i (%s)", errno,
+				strerror(errno));
+			return -1;
+		}
+		return 0;
+	}
+
+	cnt = read(fd, &c, 1);
+	close(fd);
+	if (cnt != 1) {
+		EAL_LOG(ERR, "Unable to read from VFIO noiommu file %i (%s)", errno,
+			strerror(errno));
+		return -1;
+	}
+
+	return c == 'Y';
+}
+
 static int
 vfio_open_group_fd(int iommu_group_num, bool mp_request)
 {
@@ -1072,6 +1103,46 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	return ret;
 }
 
+static int
+vfio_sync_iova_mode(enum dev_vfio_iova_mode *iova_mode)
+{
+	struct vfio_mp_param *p;
+	struct rte_mp_msg mp_req = {0};
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {5, 0};
+
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+	p = (struct vfio_mp_param *)mp_req.param;
+	p->req = VFIO_SOCKET_REQ_IOVA_MODE;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 && mp_reply.nb_received == 1) {
+		struct rte_mp_msg *mp_rep = &mp_reply.msgs[0];
+
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == VFIO_SOCKET_OK) {
+			*iova_mode = p->iova_mode;
+			free(mp_reply.msgs);
+			return 0;
+		}
+	}
+
+	free(mp_reply.msgs);
+	EAL_LOG(ERR, "Cannot request VFIO IOMMU mode");
+	return -1;
+}
+
+static const char *
+vfio_iova_mode_to_str(enum dev_vfio_iova_mode iova_mode)
+{
+	switch (iova_mode) {
+	case DEV_VFIO_IOVA_MODE_VA: return "VA";
+	case DEV_VFIO_IOVA_MODE_PA: return "PA";
+	default: return "unknown";
+	}
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_enable)
 int
 dev_vfio_enable(void)
@@ -1141,8 +1212,25 @@ dev_vfio_enable(void)
 
 	/* check if we have VFIO driver enabled */
 	if (vfio_global_cfg.default_cfg->container_fd != -1) {
-		EAL_LOG(INFO, "VFIO support initialized");
 		vfio_enabled = true;
+
+		if (internal_conf->process_type == RTE_PROC_PRIMARY) {
+			int ret = vfio_noiommu_is_enabled();
+			if (ret < 0) {
+				EAL_LOG(ERR, "Cannot determine IOVA mode");
+				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN;
+			} else if (ret == 1) {
+				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_PA;
+			} else {
+				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_VA;
+			}
+		} else {
+			if (vfio_sync_iova_mode(&vfio_global_cfg.iova_mode) < 0)
+				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN;
+		}
+
+		EAL_LOG(NOTICE, "VFIO support initialized: IOVA as %s",
+			vfio_iova_mode_to_str(vfio_global_cfg.iova_mode));
 	} else {
 		EAL_LOG(NOTICE, "VFIO support could not be initialized");
 	}
@@ -1522,39 +1610,6 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, u
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
-int
-dev_vfio_noiommu_is_enabled(void)
-{
-	int fd;
-	ssize_t cnt;
-	char c;
-
-	fd = open(DEV_VFIO_NOIOMMU_MODE, O_RDONLY);
-	if (fd < 0) {
-		if (errno != ENOENT) {
-			EAL_LOG(ERR, "Cannot open VFIO noiommu file "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-		/*
-		 * else the file does not exists
-		 * i.e. noiommu is not enabled
-		 */
-		return 0;
-	}
-
-	cnt = read(fd, &c, 1);
-	close(fd);
-	if (cnt != 1) {
-		EAL_LOG(ERR, "Unable to read from VFIO noiommu file "
-				"%i (%s)", errno, strerror(errno));
-		return -1;
-	}
-
-	return c == 'Y';
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
 dev_vfio_container_create(void)
@@ -1802,6 +1857,13 @@ vfio_cleanup_config(struct vfio_container *cfg)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_iova_mode)
+enum dev_vfio_iova_mode
+dev_vfio_get_iova_mode(void)
+{
+	return vfio_global_cfg.iova_mode;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_cleanup)
 void
 dev_vfio_cleanup(void)
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 5dae09b125..ce81526daf 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -9,6 +9,8 @@
 
 #include <stdint.h>
 
+#include <dev_vfio.h>
+
 /* hot plug/unplug of VFIO groups may cause all DMA maps to be dropped. we can
  * recreate the mappings for DPDK segments, but we cannot do so for memory that
  * was registered by the user themselves, so we need to store the user mappings
@@ -78,6 +80,7 @@ int vfio_open_container_fd(bool mp_request);
 /* global configuration */
 struct vfio_config {
 	struct vfio_container *default_cfg;
+	enum dev_vfio_iova_mode iova_mode;
 	const struct vfio_iommu_ops *ops;
 };
 
@@ -105,6 +108,7 @@ void vfio_mp_sync_cleanup(void);
 #define VFIO_SOCKET_REQ_CONTAINER 0x100
 #define VFIO_SOCKET_REQ_GROUP 0x200
 #define VFIO_SOCKET_REQ_IOMMU_TYPE 0x400
+#define VFIO_SOCKET_REQ_IOVA_MODE 0x800
 #define VFIO_SOCKET_OK 0x0
 #define VFIO_SOCKET_NO_FD 0x1
 #define VFIO_SOCKET_ERR 0xFF
@@ -115,6 +119,7 @@ struct vfio_mp_param {
 	union {
 		int group_num;
 		int iommu_type_id;
+		enum dev_vfio_iova_mode iova_mode;
 	};
 };
 
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index f394f3d227..aa90ab7bd0 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -74,6 +74,11 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 		}
 		break;
 	}
+	case VFIO_SOCKET_REQ_IOVA_MODE:
+		r->req = VFIO_SOCKET_REQ_IOVA_MODE;
+		r->iova_mode = vfio_global_cfg.iova_mode;
+		r->result = VFIO_SOCKET_OK;
+		break;
 	default:
 		EAL_LOG(ERR, "vfio received invalid message!");
 		return -1;
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index 4e2c21ae89..f3ce665366 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -27,8 +27,6 @@ extern "C" {
 #define DEV_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
 #define DEV_VFIO_GROUP_FMT "/dev/vfio/%u"
 #define DEV_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
-#define DEV_VFIO_NOIOMMU_MODE      \
-	"/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
 
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
@@ -46,6 +44,22 @@ enum dev_vfio_module {
 	DEV_VFIO_MODULE_VFIO_PCI, /**< VFIO PCI module. */
 };
 
+/**
+ * @enum dev_vfio_iova_mode
+ * IOVA modes.
+ *
+ * These modes describe IOVA remapping capability.
+ *
+ * - DEV_VFIO_IOVA_MODE_UNKNOWN: IOVA mode is unknown.
+ * - DEV_VFIO_IOVA_MODE_VA: IOVA addresses can be remapped.
+ * - DEV_VFIO_IOVA_MODE_PA: IOVA addresses cannot be remapped.
+ */
+enum dev_vfio_iova_mode {
+	DEV_VFIO_IOVA_MODE_UNKNOWN = 0, /**< IOVA mode not determined */
+	DEV_VFIO_IOVA_MODE_VA,          /**< IOVA addresses can be remapped */
+	DEV_VFIO_IOVA_MODE_PA,          /**< IOVA addresses cannot be remapped */
+};
+
 /**
  * @internal
  * Set up a device managed by VFIO driver.
@@ -136,15 +150,14 @@ int dev_vfio_is_enabled(void);
 
 /**
  * @internal
- * Whether VFIO NOIOMMU mode is enabled.
+ * Get current VFIO IOVA mode.
  *
  * @return
- *   1 if true.
- *   0 if false.
- *   <0 for errors.
+ *   VFIO IOVA mode currently in use.
  */
 __rte_internal
-int dev_vfio_noiommu_is_enabled(void);
+enum dev_vfio_iova_mode
+dev_vfio_get_iova_mode(void);
 
 /**
  * @internal
-- 
2.54.0


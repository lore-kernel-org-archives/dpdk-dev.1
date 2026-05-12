Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B19ACD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 09:23:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 102BC40668;
	Tue, 12 May 2026 11:23:16 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 798114060F
 for <dev@dpdk.org>; Tue, 12 May 2026 11:23:11 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JvvcaUmEKHaFkwJQPI8KKi2eBkPozP3SEttiAvBRbYE=;
 b=rdf9hwuYq15/eagCjXlu5+FAtZ1KNoKsCt0C6NZyq9vl0eZzLpR0xx+QBu0HzQD+p+2IdXiQ0
 VtnX6cR8K+wjRqBJKfGbt9smSglF7EUYyl0hp+O7o+qGwFsMT/chRQj64PXriWPjHpvmwLN0L7Z
 VZcB7KMtnavy+5ciaACozmg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gF9t973Ldz1prKB;
 Tue, 12 May 2026 17:15:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 042D9202E6;
 Tue, 12 May 2026 17:23:09 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 17:23:08 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <wathsala.vithanage@arm.com>, <liuyonglong@huawei.com>
Subject: [PATCH v2 1/4] bus/pci: introduce PCIe TPH support
Date: Tue, 12 May 2026 17:22:59 +0800
Message-ID: <20260512092302.23735-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260512092302.23735-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
 <20260512092302.23735-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Add experimental API and Linux VFIO implementation for PCIe TLP
Processing Hints (TPH). Support device capability query, TPH
enable/disable, and steering tag get/set operations.

Stub functions are added for BSD and Windows.

The API includes:
- rte_pci_tph_query:   Query device TPH capabilities
- rte_pci_tph_enable:  Enable TPH with specified mode
- rte_pci_tph_disable: Disable TPH on device
- rte_pci_tph_st_get:  Get steering tags for CPUs
- rte_pci_tph_st_set:  Program steering tags into device's ST table

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/bus/pci/bsd/pci.c        |  51 ++++++++++
 drivers/bus/pci/linux/pci.c      |  48 +++++++++
 drivers/bus/pci/linux/pci_init.h |   9 ++
 drivers/bus/pci/linux/pci_vfio.c | 164 +++++++++++++++++++++++++++++++
 drivers/bus/pci/rte_bus_pci.h    | 114 +++++++++++++++++++++
 drivers/bus/pci/windows/pci.c    |  51 ++++++++++
 kernel/linux/uapi/linux/vfio.h   |  41 ++++++++
 lib/pci/rte_pci.h                |   1 +
 8 files changed, 479 insertions(+)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index aba44492e0..15b65091b3 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -667,3 +667,54 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 
 	return ret;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_query, 26.07)
+int
+rte_pci_tph_query(const struct rte_pci_device *dev, uint32_t *supported_modes,
+		  uint32_t *st_table_sz)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(supported_modes);
+	RTE_SET_USED(st_table_sz);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 26.07)
+int
+rte_pci_tph_enable(const struct rte_pci_device *dev, uint32_t mode)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(mode);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 26.07)
+int
+rte_pci_tph_disable(const struct rte_pci_device *dev)
+{
+	RTE_SET_USED(dev);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 26.07)
+int
+rte_pci_tph_st_get(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(ents);
+	RTE_SET_USED(count);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 26.07)
+int
+rte_pci_tph_st_set(const struct rte_pci_device *dev, uint16_t index,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(index);
+	RTE_SET_USED(ents);
+	RTE_SET_USED(count);
+	return -ENOTSUP;
+}
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 5f263f8b28..824be47b36 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -791,3 +791,51 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 
 	return ret;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_query, 26.07)
+int
+rte_pci_tph_query(const struct rte_pci_device *dev, uint32_t *supported_modes,
+		  uint32_t *st_table_sz)
+{
+	if (dev->kdrv == RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled())
+		return pci_vfio_tph_query(dev, supported_modes, st_table_sz);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 26.07)
+int
+rte_pci_tph_enable(const struct rte_pci_device *dev, uint32_t mode)
+{
+	if (dev->kdrv == RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled())
+		return pci_vfio_tph_enable(dev, mode);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 26.07)
+int
+rte_pci_tph_disable(const struct rte_pci_device *dev)
+{
+	if (dev->kdrv == RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled())
+		return pci_vfio_tph_disable(dev);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 26.07)
+int
+rte_pci_tph_st_get(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	if (dev->kdrv == RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled())
+		return pci_vfio_tph_st_get(dev, ents, count);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 26.07)
+int
+rte_pci_tph_st_set(const struct rte_pci_device *dev, uint16_t index,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	if (dev->kdrv == RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled())
+		return pci_vfio_tph_st_set(dev, index, ents, count);
+	return -ENOTSUP;
+}
diff --git a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci_init.h
index 6949dd57d9..c475a4cfbf 100644
--- a/drivers/bus/pci/linux/pci_init.h
+++ b/drivers/bus/pci/linux/pci_init.h
@@ -73,4 +73,13 @@ int pci_vfio_unmap_resource(struct rte_pci_device *dev);
 
 int pci_vfio_is_enabled(void);
 
+int pci_vfio_tph_query(const struct rte_pci_device *dev, uint32_t *supported_modes,
+		   uint32_t *st_table_sz);
+int pci_vfio_tph_enable(const struct rte_pci_device *dev, uint32_t mode);
+int pci_vfio_tph_disable(const struct rte_pci_device *dev);
+int pci_vfio_tph_st_get(const struct rte_pci_device *dev,
+		    struct rte_pci_tph_entry *ents, uint32_t count);
+int pci_vfio_tph_st_set(const struct rte_pci_device *dev, uint16_t index,
+		    struct rte_pci_tph_entry *ents, uint32_t count);
+
 #endif /* EAL_PCI_INIT_H_ */
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index bc5c5c2499..dac745cd74 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1308,3 +1308,167 @@ pci_vfio_is_enabled(void)
 	}
 	return status;
 }
+
+#define  PCI_TPH_CAP_OFF	0x4
+#define  PCI_TPH_CAP_ST_NS	0x00000001 /* No ST Mode Supported */
+#define  PCI_TPH_CAP_ST_IV	0x00000002 /* Interrupt Vector Mode Supported */
+#define  PCI_TPH_CAP_ST_DS	0x00000004 /* Device Specific Mode Supported */
+#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* ST Table Location */
+#define  PCI_TPH_LOC_NONE	0x00000000 /* Not present */
+#define  PCI_TPH_LOC_CAP	0x00000200 /* In capability */
+#define  PCI_TPH_LOC_MSIX	0x00000400 /* In MSI-X */
+#define  PCI_TPH_CTRL_OFF	0x8
+#define  PCI_TPH_ST_NS_MODE	0x0 /* No ST Mode */
+#define  PCI_TPH_ST_IV_MODE	0x1 /* Interrupt Vector Mode */
+#define  PCI_TPH_ST_DS_MODE	0x2 /* Device Specific Mode */
+
+int
+pci_vfio_tph_query(const struct rte_pci_device *dev, uint32_t *supported_modes,
+		   uint32_t *st_table_sz)
+{
+	off_t off = rte_pci_find_ext_capability(dev, RTE_PCI_EXT_CAP_ID_TPH);
+	uint32_t cap, loc;
+	int ret;
+
+	if (off <= 0)
+		return -ENOTSUP;
+
+	ret = rte_pci_read_config(dev, &cap, 4, off + PCI_TPH_CAP_OFF);
+	if (ret != 4)
+		return -EIO;
+
+	*supported_modes = 0;
+	if (cap & PCI_TPH_CAP_ST_IV)
+		*supported_modes |= RTE_PCI_TPH_MODE_IV;
+	if (cap & PCI_TPH_CAP_ST_DS)
+		*supported_modes |= RTE_PCI_TPH_MODE_DS;
+	loc = cap & PCI_TPH_CAP_LOC_MASK;
+	if (loc == PCI_TPH_LOC_CAP || loc == PCI_TPH_LOC_MSIX)
+		*st_table_sz = RTE_FIELD_GET32(PCI_TPH_LOC_MSIX, cap) + 1;
+	else
+		*st_table_sz = 0;
+
+	return 0;
+}
+
+static int
+pci_vfio_tph_ctrl(const struct rte_pci_device *dev, uint32_t mode)
+{
+	off_t off = rte_pci_find_ext_capability(dev, RTE_PCI_EXT_CAP_ID_TPH);
+	int ret;
+
+	if (off <= 0)
+		return -ENOTSUP;
+
+	ret = rte_pci_write_config(dev, &mode, 4, off + PCI_TPH_CTRL_OFF);
+	if (ret != 4)
+		return -EIO;
+
+	return 0;
+}
+
+int
+pci_vfio_tph_enable(const struct rte_pci_device *dev, uint32_t mode)
+{
+	uint32_t st_mode;
+
+	if (mode == RTE_PCI_TPH_MODE_IV)
+		st_mode = PCI_TPH_ST_IV_MODE;
+	else if (mode == RTE_PCI_TPH_MODE_DS)
+		st_mode = PCI_TPH_ST_DS_MODE;
+	else
+		return -EINVAL;
+
+	return pci_vfio_tph_ctrl(dev, st_mode);
+}
+
+int
+pci_vfio_tph_disable(const struct rte_pci_device *dev)
+{
+	return pci_vfio_tph_ctrl(dev, PCI_TPH_ST_NS_MODE);
+}
+
+int
+pci_vfio_tph_st_get(const struct rte_pci_device *dev,
+		    struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	struct vfio_device_feature_tph_st *tph_st;
+	struct vfio_device_feature *feature;
+	int vfio_dev_fd, ret;
+	size_t argsz;
+	uint32_t i;
+
+	if (count > VFIO_TPH_ST_MAX_COUNT)
+		return -EINVAL;
+
+	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
+	if (vfio_dev_fd < 0)
+		return -1;
+
+	argsz = sizeof(struct vfio_device_feature) +
+		sizeof(struct vfio_device_feature_tph_st) +
+		count * sizeof(uint32_t);
+	feature = (struct vfio_device_feature *)calloc(1, argsz);
+	if (feature == NULL)
+		return -ENOMEM;
+	tph_st = (struct vfio_device_feature_tph_st *)feature->data;
+
+	feature->argsz = argsz;
+	feature->flags = VFIO_DEVICE_FEATURE_TPH_ST;
+	feature->flags |= VFIO_DEVICE_FEATURE_GET;
+	for (i = 0; i < count; i++)
+		tph_st->data[i] = ents[i].cpu;
+	tph_st->flags = VFIO_TPH_ST_MEM_TYPE_VM;
+	tph_st->index = 0;
+	tph_st->count = count;
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
+	if (ret) {
+		free(feature);
+		return ret;
+	}
+
+	for (i = 0; i < count; i++)
+		ents[i].st = tph_st->data[i];
+	free(feature);
+
+	return 0;
+}
+
+int
+pci_vfio_tph_st_set(const struct rte_pci_device *dev, uint16_t index,
+		    struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	struct vfio_device_feature_tph_st *tph_st;
+	struct vfio_device_feature *feature;
+	int vfio_dev_fd, ret;
+	size_t argsz;
+	uint32_t i;
+
+	if (count > VFIO_TPH_ST_MAX_COUNT)
+		return -EINVAL;
+
+	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
+	if (vfio_dev_fd < 0)
+		return -1;
+
+	argsz = sizeof(struct vfio_device_feature) +
+		sizeof(struct vfio_device_feature_tph_st) +
+		count * sizeof(uint32_t);
+	feature = (struct vfio_device_feature *)calloc(1, argsz);
+	if (feature == NULL)
+		return -ENOMEM;
+	tph_st = (struct vfio_device_feature_tph_st *)feature->data;
+
+	feature->argsz = argsz;
+	feature->flags = VFIO_DEVICE_FEATURE_TPH_ST;
+	feature->flags |= VFIO_DEVICE_FEATURE_SET;
+	tph_st->flags = VFIO_TPH_ST_MEM_TYPE_VM;
+	tph_st->index = index;
+	tph_st->count = count;
+	for (i = 0; i < count; i++)
+		tph_st->data[i] = ents[i].cpu;
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
+	free(feature);
+
+	return ret;
+}
diff --git a/drivers/bus/pci/rte_bus_pci.h b/drivers/bus/pci/rte_bus_pci.h
index 19a7b15b99..623c80e855 100644
--- a/drivers/bus/pci/rte_bus_pci.h
+++ b/drivers/bus/pci/rte_bus_pci.h
@@ -312,6 +312,120 @@ void rte_pci_ioport_read(struct rte_pci_ioport *p,
 void rte_pci_ioport_write(struct rte_pci_ioport *p,
 		const void *data, size_t len, off_t offset);
 
+#define RTE_PCI_TPH_MODE_IV	(1u << 0) /* Interrupt vector */
+#define RTE_PCI_TPH_MODE_DS	(1u << 1) /* Device specific */
+
+/**
+ * @struct rte_pci_tph_entry
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ *
+ * An entry used for TPH Steering Tag (ST) get/set operations.
+ */
+struct rte_pci_tph_entry {
+	/**
+	 * CPU ID used for both get and set operations.
+	 * For set operation: if set to U32_MAX, clear the ST entry at
+	 * specified index.
+	 */
+	uint32_t cpu;
+	/**
+	 * Steering tag value, only used for get operation to return result.
+	 */
+	uint16_t st;
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Query PCIe TLP Processing Hints (TPH) capabilities of a device.
+ *
+ * @param dev
+ *   A pointer to a rte_pci_device structure describing the device to query.
+ * @param supported_modes
+ *   Output: supported TPH modes (RTE_PCI_TPH_MODE_*).
+ * @param st_table_sz
+ *   Output: number of entries in the ST table; 0 means no table present.
+ * @return
+ *   0 on success, negative value on error.
+ */
+__rte_experimental
+int rte_pci_tph_query(const struct rte_pci_device *dev, uint32_t *supported_modes,
+		  uint32_t *st_table_sz);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Enable PCIe TLP Processing Hints (TPH) on a device with specified mode.
+ *
+ * @param dev
+ *   A pointer to a rte_pci_device structure describing the device to enable.
+ * @param mode
+ *   TPH operating mode (RTE_PCI_TPH_MODE_*).
+ * @return
+ *   0 on success, negative value on error.
+ */
+__rte_experimental
+int rte_pci_tph_enable(const struct rte_pci_device *dev, uint32_t mode);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Disable PCIe TLP Processing Hints (TPH) on a device.
+ *
+ * @param dev
+ *   A pointer to a rte_pci_device structure describing the device to disable.
+ * @return
+ *   0 on success, negative value on error.
+ */
+__rte_experimental
+int rte_pci_tph_disable(const struct rte_pci_device *dev);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Get steering tags for given CPU IDs from the device.
+ * Only valid when TPH is enabled in Device-Specific (DS) mode.
+ *
+ * @param dev
+ *   A pointer to a rte_pci_device structure describing the device.
+ * @param ents
+ *   Array of entries with CPU IDs as input; steering tags are returned
+ *   as output.
+ * @param count
+ *   Number of entries in the array.
+ * @return
+ *   0 on success, negative value on error.
+ */
+__rte_experimental
+int rte_pci_tph_st_get(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Program steering tags into the device's ST table.
+ *
+ * @param dev
+ *   A pointer to a rte_pci_device structure describing the device.
+ * @index
+ *   Start ST table index to program.
+ * @param ents
+ *   Array of entries with CPU IDs and index indices to program.
+ * @param count
+ *   Number of entries in the array.
+ * @return
+ *   0 on success, negative errno value on error.
+ */
+__rte_experimental
+int rte_pci_tph_st_set(const struct rte_pci_device *dev, uint16_t index,
+		   struct rte_pci_tph_entry *ents, uint32_t count);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 549319ad5b..53d7bebde9 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -207,6 +207,57 @@ pci_uio_remap_resource(struct rte_pci_device *dev __rte_unused)
 	return -1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_query, 26.07)
+int
+rte_pci_tph_query(const struct rte_pci_device *dev, uint32_t *supported_modes,
+		  uint32_t *st_table_sz)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(supported_modes);
+	RTE_SET_USED(st_table_sz);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_enable, 26.07)
+int
+rte_pci_tph_enable(const struct rte_pci_device *dev, uint32_t mode)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(mode);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_disable, 26.07)
+int
+rte_pci_tph_disable(const struct rte_pci_device *dev)
+{
+	RTE_SET_USED(dev);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_get, 26.07)
+int
+rte_pci_tph_st_get(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(ents);
+	RTE_SET_USED(count);
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_tph_st_set, 26.07)
+int
+rte_pci_tph_st_set(const struct rte_pci_device *dev, uint16_t index,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(index);
+	RTE_SET_USED(ents);
+	RTE_SET_USED(count);
+	return -ENOTSUP;
+}
+
 static int
 get_device_pci_address(HDEVINFO dev_info,
 	PSP_DEVINFO_DATA device_info_data, struct rte_pci_addr *addr)
diff --git a/kernel/linux/uapi/linux/vfio.h b/kernel/linux/uapi/linux/vfio.h
index 79bf8c0cc5..f0676310bf 100644
--- a/kernel/linux/uapi/linux/vfio.h
+++ b/kernel/linux/uapi/linux/vfio.h
@@ -1468,6 +1468,47 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * VFIO_DEVICE_FEATURE_TPH_ST - Get/Set PCIe TPH Steering Tag (ST) entries
+ *
+ * Provides userspace interface to manage PCIe TPH ST table entries.
+ * This feature is only available when device TPH is enabled.
+ *
+ * Upon VFIO_DEVICE_FEATURE_SET:
+ *   Program contiguous ST table entries from the starting @index.
+ *   Valid only for hardware with ST table located in TPH Capability
+ *   space or MSI-X table. If an entry CPU ID is specified as U32_MAX,
+ *   the corresponding ST entry will be cleared. @index and @count define
+ *   the contiguous entry range to be programmed.
+ *   If any entry programming fails, the operation will roll back and
+ *   clear all entries that were successfully programmed before the error.
+ *
+ * Upon VFIO_DEVICE_FEATURE_GET:
+ *   Retrieve the ST value mapped to each given CPU ID in the @data array.
+ *   Userspace fills @data with CPU ID array, the interface returns each
+ *   CPU's corresponding ST value back in place.
+ *   Valid only when TPH DS mode is enabled.
+ *
+ * @flags: Operation flags (VFIO_TPH_ST_MEM_TYPE_*).
+ * @index: Starting ST entry index, only valid for FEATURE_SET.
+ * @count: Number of contiguous entries to access.
+ * @data: Array of CPU IDs for both SET and GET. On SET it programs ST for
+ *        each CPU; on GET it returns the mapped ST value of each CPU.
+ *
+ * This feature is gated by enable_unsafe_tph module parameter.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_ST     13
+
+struct vfio_device_feature_tph_st {
+	__u32 flags;
+#define VFIO_TPH_ST_MEM_TYPE_VM                (0U << 0)
+#define VFIO_TPH_ST_MEM_TYPE_PM                (1U << 0)
+	__u16 index;
+	__u16 count;
+#define VFIO_TPH_ST_MAX_COUNT          2048
+	__u32 data[];
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h
index 9d04978a0f..f9129723eb 100644
--- a/lib/pci/rte_pci.h
+++ b/lib/pci/rte_pci.h
@@ -111,6 +111,7 @@ extern "C" {
 #define RTE_PCI_EXT_CAP_ID_ACS		0x0d	/* Access Control Services */
 #define RTE_PCI_EXT_CAP_ID_SRIOV	0x10	/* SR-IOV */
 #define RTE_PCI_EXT_CAP_ID_PRI		0x13	/* Page Request Interface */
+#define RTE_PCI_EXT_CAP_ID_TPH		0x17	/* TLP Processing Hints */
 #define RTE_PCI_EXT_CAP_ID_PASID	0x1b    /* Process Address Space ID */
 
 /* Advanced Error Reporting (RTE_PCI_EXT_CAP_ID_ERR) */
-- 
2.17.1


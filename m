Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E02CD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 09:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4FB640656;
	Fri,  8 May 2026 11:29:10 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 24B764013F
 for <dev@dpdk.org>; Fri,  8 May 2026 11:29:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6YjSOgUQS3qKfJiW1eXUz0o12KnddZqFhBayHqyHjC8=;
 b=FZE0AOBetOmQI5Q65Sguzma3SwU2FymhM0zQPCxM7VnfaAFZ88ZLRT0Elw7PVuJMR70g8A/gL
 5wl/bS+Dgss/1pORKWsDzbmriWls+bH/dtBGpzccDMCBwX1RZDnlzO840kouWL+EAa0/6RWKZvW
 Pb6Ly05aRiK2C0PDUmt7fj4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gBkCm0hckzpSv5;
 Fri,  8 May 2026 17:22:12 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id BD3EB40576;
 Fri,  8 May 2026 17:29:04 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 17:29:04 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: [PATCH v1 1/4] bus/pci: introduce PCIe TPH support
Date: Fri, 8 May 2026 17:28:52 +0800
Message-ID: <20260508092855.51987-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508092855.51987-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
 drivers/bus/pci/bsd/pci.c        |  50 ++++++
 drivers/bus/pci/linux/pci.c      |  48 ++++++
 drivers/bus/pci/linux/pci_init.h |   9 +
 drivers/bus/pci/linux/pci_vfio.c | 272 +++++++++++++++++++++++++++++++
 drivers/bus/pci/rte_bus_pci.h    | 112 +++++++++++++
 drivers/bus/pci/windows/pci.c    |  50 ++++++
 6 files changed, 541 insertions(+)

diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index aba44492e0..0ba1c9d898 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -667,3 +667,53 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 
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
+rte_pci_tph_st_set(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(ents);
+	RTE_SET_USED(count);
+	return -ENOTSUP;
+}
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 5f263f8b28..d2eade14a5 100644
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
+rte_pci_tph_st_set(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	if (dev->kdrv == RTE_PCI_KDRV_VFIO && pci_vfio_is_enabled())
+		return pci_vfio_tph_st_set(dev, ents, count);
+	return -ENOTSUP;
+}
diff --git a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci_init.h
index 6949dd57d9..7cbdc7e807 100644
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
+int pci_vfio_tph_st_set(const struct rte_pci_device *dev,
+		    struct rte_pci_tph_entry *ents, uint32_t count);
+
 #endif /* EAL_PCI_INIT_H_ */
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index bc5c5c2499..d109f44d45 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1308,3 +1308,275 @@ pci_vfio_is_enabled(void)
 	}
 	return status;
 }
+
+/**
+ * struct vfio_pci_tph_cap - PCIe TPH capability information
+ * @supported_modes: Supported TPH operating modes
+ * @st_table_sz: Number of entries in ST table; 0 means no ST table
+ * @reserved: Must be zero
+ *
+ * Used with VFIO_PCI_TPH_GET_CAP operation to return device
+ * TLP Processing Hints (TPH) capabilities to userspace.
+ */
+struct vfio_pci_tph_cap {
+	__u8  supported_modes;
+#define VFIO_PCI_TPH_MODE_IV	(1u << 0) /* Interrupt vector */
+#define VFIO_PCI_TPH_MODE_DS	(1u << 1) /* Device specific */
+	__u8  reserved0;
+	__u16 st_table_sz;
+	__u32 reserved;
+};
+
+/**
+ * struct vfio_pci_tph_ctrl - TPH enable control structure
+ * @mode: Selected TPH operating mode (VFIO_PCI_TPH_MODE_*)
+ * @reserved: Must be zero
+ *
+ * Used with VFIO_PCI_TPH_ENABLE operation to specify the
+ * operating mode when enabling TPH on the device.
+ */
+struct vfio_pci_tph_ctrl {
+	__u8 mode;
+	__u8 reserved[7];
+};
+
+/**
+ * struct vfio_pci_tph_entry - Single TPH steering tag entry
+ * @cpu: CPU identifier for steering tag calculation
+ * @mem_type: Memory type (VFIO_PCI_TPH_MEM_TYPE_*)
+ * @reserved0: Must be zero
+ * @index: ST table index for programming
+ * @st: Unused for SET_ST
+ * @reserved1: Must be zero
+ *
+ * For VFIO_PCI_TPH_GET_ST:
+ *   Userspace sets @cpu and @mem_type; kernel returns @st.
+ *
+ * For VFIO_PCI_TPH_SET_ST:
+ *   Userspace sets @index, @cpu, and @mem_type.
+ *   Kernel internally computes the steering tag and programs
+ *   it into the specified @index.
+ *
+ *   If @cpu == U32_MAX, kernel clears the steering tag at
+ *   the specified @index.
+ */
+struct vfio_pci_tph_entry {
+	__u32 cpu;
+	__u8  mem_type;
+#define VFIO_PCI_TPH_MEM_TYPE_VM	0
+#define VFIO_PCI_TPH_MEM_TYPE_PM	1
+	__u8  reserved0;
+	__u16 index;
+	__u16 st;
+	__u16 reserved1;
+};
+
+/**
+ * struct vfio_pci_tph_st - Batch steering tag request
+ * @count: Number of entries in the array
+ * @reserved: Must be zero
+ * @ents: Flexible array of steering tag entries
+ *
+ * Container structure for batch get/set operations.
+ * Used with both VFIO_PCI_TPH_GET_ST and VFIO_PCI_TPH_SET_ST.
+ */
+struct vfio_pci_tph_st {
+	__u32 count;
+	__u32 reserved;
+	struct vfio_pci_tph_entry ents[];
+#define VFIO_PCI_TPH_MAX_ENTRIES    2048
+};
+
+/**
+ * struct vfio_device_pci_tph_op - Argument for VFIO_DEVICE_PCI_TPH
+ * @argsz: User allocated size of this structure
+ * @op: TPH operation (VFIO_PCI_TPH_*)
+ * @cap: Capability data for GET_CAP
+ * @ctrl: Control data for ENABLE
+ * @st: Batch entry data for GET_ST/SET_ST
+ *
+ * @argsz must be set by the user to the size of the structure
+ * being executed. Kernel validates input and returns data
+ * only within the specified size.
+ *
+ * Operations:
+ * - VFIO_PCI_TPH_GET_CAP: Query device TPH capabilities.
+ * - VFIO_PCI_TPH_ENABLE:  Enable TPH using mode from &ctrl.
+ * - VFIO_PCI_TPH_DISABLE: Disable TPH on the device.
+ * - VFIO_PCI_TPH_GET_ST:  Retrieve CPU steering tags for Device-Specific (DS)
+ *                         mode. Used when device requires SW to obtain ST
+ *                         values for programming.
+ * - VFIO_PCI_TPH_SET_ST:  Program steering tag entries into device ST table.
+ *                         Valid when ST table resides in TPH Requester
+ *                         Capability or MSI-X Table.
+ *                         If any entry fails, all programmed entries are rolled
+ *                         back to 0 before returning error.
+ */
+struct vfio_device_pci_tph_op {
+	__u32 argsz;
+	__u32 op;
+#define VFIO_PCI_TPH_GET_CAP	0
+#define VFIO_PCI_TPH_ENABLE	1
+#define VFIO_PCI_TPH_DISABLE	2
+#define VFIO_PCI_TPH_GET_ST	3
+#define VFIO_PCI_TPH_SET_ST	4
+	union {
+		struct vfio_pci_tph_cap cap;
+		struct vfio_pci_tph_ctrl ctrl;
+		struct vfio_pci_tph_st st;
+	};
+};
+
+/**
+ * VFIO_DEVICE_PCI_TPH - _IO(VFIO_TYPE, VFIO_BASE + 22)
+ *
+ * IOCTL for managing PCIe TLP Processing Hints (TPH) on
+ * a VFIO-assigned PCI device. Provides operations to query
+ * device capabilities, enable/disable TPH, retrieve CPU's
+ * steering tags, and program steering tag tables.
+ *
+ * Return: 0 on success, negative errno on failure.
+ *         -EOPNOTSUPP: Operation not supported
+ *         -ENODEV: Device or required functionality not present
+ *         -EINVAL: Invalid argument or TPH not supported
+ */
+#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+static int
+pci_vfio_tph_ioctl(const struct rte_pci_device *dev, struct vfio_device_pci_tph_op *op)
+{
+	const struct rte_intr_handle *intr_handle = dev->intr_handle;
+	int vfio_dev_fd;
+
+	vfio_dev_fd = rte_intr_dev_fd_get(intr_handle);
+	if (vfio_dev_fd < 0)
+		return -EIO;
+
+	return ioctl(vfio_dev_fd, VFIO_DEVICE_PCI_TPH, op);
+}
+
+int
+pci_vfio_tph_query(const struct rte_pci_device *dev, uint32_t *supported_modes,
+		   uint32_t *st_table_sz)
+{
+	struct vfio_device_pci_tph_op op = {
+		.argsz = sizeof(struct vfio_device_pci_tph_op),
+		.op = VFIO_PCI_TPH_GET_CAP,
+	};
+	int ret;
+
+	ret = pci_vfio_tph_ioctl(dev, &op);
+	if (ret != 0)
+		return ret;
+
+	*supported_modes = 0;
+	if (op.cap.supported_modes & VFIO_PCI_TPH_MODE_IV)
+		*supported_modes |= RTE_PCI_TPH_MODE_IV;
+	if (op.cap.supported_modes & VFIO_PCI_TPH_MODE_DS)
+		*supported_modes |= RTE_PCI_TPH_MODE_DS;
+	*st_table_sz = op.cap.st_table_sz;
+
+	return 0;
+}
+
+int
+pci_vfio_tph_enable(const struct rte_pci_device *dev, uint32_t mode)
+{
+	struct vfio_device_pci_tph_op op = {
+		.argsz = sizeof(struct vfio_device_pci_tph_op),
+		.op = VFIO_PCI_TPH_ENABLE,
+	};
+
+	if (mode == RTE_PCI_TPH_MODE_IV)
+		op.ctrl.mode = VFIO_PCI_TPH_MODE_IV;
+	else if (mode == RTE_PCI_TPH_MODE_DS)
+		op.ctrl.mode = VFIO_PCI_TPH_MODE_DS;
+	else
+		return -EINVAL;
+
+	return pci_vfio_tph_ioctl(dev, &op);
+}
+
+int
+pci_vfio_tph_disable(const struct rte_pci_device *dev)
+{
+	struct vfio_device_pci_tph_op op = {
+		.argsz = sizeof(struct vfio_device_pci_tph_op),
+		.op = VFIO_PCI_TPH_DISABLE,
+	};
+	return pci_vfio_tph_ioctl(dev, &op);
+}
+
+static struct vfio_device_pci_tph_op *
+pci_vfio_tph_alloc_st_op(uint32_t count)
+{
+	struct vfio_device_pci_tph_op *op;
+	ssize_t sz = sizeof(struct vfio_device_pci_tph_op) +
+			count * sizeof(struct vfio_pci_tph_entry);
+	op = calloc(1, sz);
+	if (op == NULL)
+		return NULL;
+	op->argsz = sz;
+	op->st.count = count;
+	return op;
+}
+
+static void
+pci_vfio_tph_free_st_op(struct vfio_device_pci_tph_op *op)
+{
+	free(op);
+}
+
+int
+pci_vfio_tph_st_get(const struct rte_pci_device *dev,
+		    struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	struct vfio_device_pci_tph_op *op;
+	uint32_t i;
+	int ret;
+
+	op = pci_vfio_tph_alloc_st_op(count);
+	if (op == NULL)
+		return -ENOMEM;
+
+	op->op = VFIO_PCI_TPH_GET_ST;
+	for (i = 0; i < count; i++) {
+		op->st.ents[i].cpu = ents[i].cpu;
+		op->st.ents[i].mem_type = VFIO_PCI_TPH_MEM_TYPE_VM;
+	}
+
+	ret = pci_vfio_tph_ioctl(dev, op);
+	if (ret != 0) {
+		pci_vfio_tph_free_st_op(op);
+		return ret;
+	}
+	for (i = 0; i < count; i++)
+		ents[i].st = op->st.ents[i].st;
+
+	pci_vfio_tph_free_st_op(op);
+	return 0;
+}
+
+int
+pci_vfio_tph_st_set(const struct rte_pci_device *dev,
+		    struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	struct vfio_device_pci_tph_op *op;
+	uint32_t i;
+	int ret;
+
+	op = pci_vfio_tph_alloc_st_op(count);
+	if (op == NULL)
+		return -ENOMEM;
+
+	op->op = VFIO_PCI_TPH_SET_ST;
+	for (i = 0; i < count; i++) {
+		op->st.ents[i].cpu = ents[i].cpu;
+		op->st.ents[i].mem_type = VFIO_PCI_TPH_MEM_TYPE_VM;
+		op->st.ents[i].index = ents[i].index;
+	}
+
+	ret = pci_vfio_tph_ioctl(dev, op);
+	pci_vfio_tph_free_st_op(op);
+	return ret;
+}
diff --git a/drivers/bus/pci/rte_bus_pci.h b/drivers/bus/pci/rte_bus_pci.h
index 19a7b15b99..58dd4620a3 100644
--- a/drivers/bus/pci/rte_bus_pci.h
+++ b/drivers/bus/pci/rte_bus_pci.h
@@ -312,6 +312,118 @@ void rte_pci_ioport_read(struct rte_pci_ioport *p,
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
+	/** ST table index, only used for set operation */
+	uint16_t index;
+	/** Steering tag value, only used for get operation to return result */
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
+ * @param ents
+ *   Array of entries with CPU IDs and index indices to program.
+ * @param count
+ *   Number of entries in the array.
+ * @return
+ *   0 on success, negative errno value on error.
+ */
+__rte_experimental
+int rte_pci_tph_st_set(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 549319ad5b..0a2f0408ca 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -207,6 +207,56 @@ pci_uio_remap_resource(struct rte_pci_device *dev __rte_unused)
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
+rte_pci_tph_st_set(const struct rte_pci_device *dev,
+		   struct rte_pci_tph_entry *ents, uint32_t count)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(ents);
+	RTE_SET_USED(count);
+	return -ENOTSUP;
+}
+
 static int
 get_device_pci_address(HDEVINFO dev_info,
 	PSP_DEVINFO_DATA device_info_data, struct rte_pci_addr *addr)
-- 
2.17.1


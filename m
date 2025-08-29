Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A226CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 03:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BFC540616;
	Fri, 29 Aug 2025 05:28:36 +0200 (CEST)
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com
 [115.124.28.195])
 by mails.dpdk.org (Postfix) with ESMTP id 53602402A2
 for <dev@dpdk.org>; Fri, 29 Aug 2025 05:28:31 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eScIZeW_1756438107 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 29 Aug 2025 11:28:27 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 02/17] net/nbl: add simple probe/remove and log module
Date: Thu, 28 Aug 2025 20:27:50 -0700
Message-Id: <20250829032805.2955351-3-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829032805.2955351-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250829032805.2955351-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Our driver architecture is relatively complex because the code
is highly reusable and designed to support multiple features.
For example, our driver can support open-source UIO/VFIO drivers
while also coexisting with kernel drivers.
Additionally, the codebase supports multiple chip variants,
each with distinct hardware-software interactions.
To ensure compatibility, our architecture is divided
into the following layers:

1. Dev Layer (Device Layer)
The top-level business logic layer where all DPDK operations
are device-centric. Every operation is performed relative
to the device context.

2. Dispatch Layer
The dispatching layer determines whether tasks from the
Dev Layer should be routed to the Resource Layer or
Channel Layer based on two criteria:
2.1 The driver type in use (UIO/VFIO vs. vendor-specific driver)
2.2 Whether the task requires hardware access

3. Resource Layer
Handles tasks dispatched from the Dev Layer (via Dispatch Layer)
in userspace. These tasks fall into two categories:
3.1 Hardware control in userspace (common with UIO/VFIO drivers):
The Resource Layer further invokes the HW Layer
when hardware access is needed, as only the HW Layer
has OS-level privileges.
3.2 Software resource management: Operations like packet
statistics collection that don't require hardware access.

4. HW Layer (Hardware Layer)
Serves the Resource Layer by interacting with different
hardware chipsets.Writes to hardware registers to drive
the hardware based on Resource Layer directives.

5. Channel Layer
Dedicated to coexistence mode with kernel drivers.
When a BDF device is shared between two drivers
(with the kernel driver as primary), all hardware operations from
DPDK are forwarded through this layer to the kernel driver.
Exceptions include performance-sensitive operations
(e.g., doorbell ringing) handled directly in userspace.

Architecture Flow Summary
Our top-down architecture varies by driver mode:
1. UIO/VFIO Mode (e.g., configuring a hardware queue)
Dev Layer → Dispatch Layer → Resource Layer → HW Layer
The Dispatch Layer routes tasks to the Resource Layer,
which interacts with the HW Layer for hardware writes.

2. Coexistence Mode
Dev Layer → Dispatch Layer → Channel Layer
The Dispatch Layer redirects hooks to the Channel Layer,
which communicates with the kernel driver to configure hardware.

This layered approach ensures flexibility across driver types
and hardware variants. My subsequent patches will
iteratively define and implement each layer’s functionality.
Let me know if further clarification would be helpful
for the review process.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build               |   3 +
 drivers/net/nbl/nbl_core.c                |  30 ++++++
 drivers/net/nbl/nbl_core.h                |  40 ++++++++
 drivers/net/nbl/nbl_ethdev.c              | 119 ++++++++++++++++++++++
 drivers/net/nbl/nbl_ethdev.h              |  13 +++
 drivers/net/nbl/nbl_include/nbl_include.h |  43 ++++++++
 drivers/net/nbl/nbl_include/nbl_logs.h    |  25 +++++
 7 files changed, 273 insertions(+)
 create mode 100644 drivers/net/nbl/nbl_core.c
 create mode 100644 drivers/net/nbl/nbl_core.h
 create mode 100644 drivers/net/nbl/nbl_ethdev.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index 68c045a48c..778c495c68 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -6,6 +6,9 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
     reason = 'only supported on 64bit Linux'
 endif
 
+includes += include_directories('nbl_include')
+
 sources = files(
         'nbl_ethdev.c',
+        'nbl_core.c',
 )
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
new file mode 100644
index 0000000000..267293715a
--- /dev/null
+++ b/drivers/net/nbl/nbl_core.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_core.h"
+
+int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(adapter);
+	RTE_SET_USED(eth_dev);
+
+	return 0;
+}
+
+void nbl_core_remove(struct nbl_adapter *adapter)
+{
+	RTE_SET_USED(adapter);
+}
+
+int nbl_core_start(struct nbl_adapter *adapter)
+{
+	RTE_SET_USED(adapter);
+
+	return 0;
+}
+
+void nbl_core_stop(struct nbl_adapter *adapter)
+{
+	RTE_SET_USED(adapter);
+}
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
new file mode 100644
index 0000000000..0b0769a780
--- /dev/null
+++ b/drivers/net/nbl/nbl_core.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_CORE_H_
+#define _NBL_CORE_H_
+
+#include "nbl_include.h"
+
+#define NBL_VENDOR_ID				(0x1F0F)
+#define NBL_DEVICE_ID_M18110			(0x3403)
+#define NBL_DEVICE_ID_M18110_LX			(0x3404)
+#define NBL_DEVICE_ID_M18110_BASE_T		(0x3405)
+#define NBL_DEVICE_ID_M18110_LX_BASE_T		(0x3406)
+#define NBL_DEVICE_ID_M18110_OCP		(0x3407)
+#define NBL_DEVICE_ID_M18110_LX_OCP		(0x3408)
+#define NBL_DEVICE_ID_M18110_BASE_T_OCP		(0x3409)
+#define NBL_DEVICE_ID_M18110_LX_BASE_T_OCP	(0x340a)
+#define NBL_DEVICE_ID_M18120			(0x340b)
+#define NBL_DEVICE_ID_M18120_LX			(0x340c)
+#define NBL_DEVICE_ID_M18120_BASE_T		(0x340d)
+#define NBL_DEVICE_ID_M18120_LX_BASE_T		(0x340e)
+#define NBL_DEVICE_ID_M18120_OCP		(0x340f)
+#define NBL_DEVICE_ID_M18120_LX_OCP		(0x3410)
+#define NBL_DEVICE_ID_M18120_BASE_T_OCP		(0x3411)
+#define NBL_DEVICE_ID_M18120_LX_BASE_T_OCP	(0x3412)
+#define NBL_DEVICE_ID_M18100_VF			(0x3413)
+
+#define NBL_MAX_INSTANCE_CNT 516
+struct nbl_adapter {
+	TAILQ_ENTRY(nbl_adapter) next;
+	struct rte_pci_device *pci_dev;
+};
+
+int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev);
+void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
+
+#endif
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index 3ad8e4033a..7276fb6b5c 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -1,3 +1,122 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2025 Nebulamatrix Technology Co., Ltd.
  */
+
+#include "nbl_ethdev.h"
+
+RTE_LOG_REGISTER_SUFFIX(nbl_logtype_init, init, INFO);
+RTE_LOG_REGISTER_SUFFIX(nbl_logtype_driver, driver, INFO);
+
+static int nbl_dev_release_pf(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+
+	if (!adapter)
+		return -EINVAL;
+	NBL_LOG(DEBUG, "start to close device %s", eth_dev->device->name);
+	nbl_core_stop(adapter);
+	nbl_core_remove(adapter);
+	return 0;
+}
+
+static int nbl_dev_close(struct rte_eth_dev *eth_dev)
+{
+	rte_free(eth_dev->data->mac_addrs);
+	eth_dev->data->mac_addrs = NULL;
+
+	return nbl_dev_release_pf(eth_dev);
+}
+
+struct eth_dev_ops nbl_eth_dev_ops = {
+	.dev_close = nbl_dev_close,
+};
+
+static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+	ret = nbl_core_init(adapter, eth_dev);
+	if (ret) {
+		NBL_LOG(ERR, "core init failed ret %d", ret);
+		goto eth_init_failed;
+	}
+
+	ret = nbl_core_start(adapter);
+	if (ret) {
+		NBL_LOG(ERR, "core start failed ret %d", ret);
+		nbl_core_remove(adapter);
+		goto eth_init_failed;
+	}
+
+	eth_dev->dev_ops = &nbl_eth_dev_ops;
+	return 0;
+
+eth_init_failed:
+	return ret;
+}
+
+/**
+ * @brief: nbl device pci probe
+ * @param[in]: {rte_pci_driver} *pci_drv
+ * @param[in]: {rte_pci_device} *pci_dev
+ * @return: {0-success,negative-fail}
+ */
+static int nbl_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+			 struct rte_pci_device *pci_dev)
+{
+	NBL_LOG(INFO, "nbl probe device %s", pci_dev->name);
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		NBL_LOG(ERR, "Secondary process is not supported.");
+		return -ENOTSUP;
+	}
+	return rte_eth_dev_pci_generic_probe(pci_dev, sizeof(struct nbl_adapter),
+					     nbl_eth_dev_init);
+}
+
+static int nbl_eth_dev_uninit(struct rte_eth_dev *eth_dev)
+{
+	PMD_INIT_FUNC_TRACE();
+	return nbl_dev_close(eth_dev);
+}
+
+static int nbl_pci_remove(struct rte_pci_device *pci_dev)
+{
+	PMD_INIT_FUNC_TRACE();
+	return rte_eth_dev_pci_generic_remove(pci_dev, nbl_eth_dev_uninit);
+}
+
+static const struct rte_pci_id pci_id_nbl_map[] = {
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_LX) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_BASE_T) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_LX_BASE_T) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_LX_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_BASE_T_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_LX_BASE_T_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18100_VF) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
+static struct rte_pci_driver nbl_pmd = {
+	.id_table = pci_id_nbl_map,
+	.drv_flags =
+		RTE_PCI_DRV_INTR_LSC |
+		RTE_PCI_DRV_PROBE_AGAIN,
+	.probe = nbl_pci_probe,
+	.remove = nbl_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_nbl, nbl_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_nbl, pci_id_nbl_map);
+RTE_PMD_REGISTER_KMOD_DEP(net_nbl, "* nbl_core");
diff --git a/drivers/net/nbl/nbl_ethdev.h b/drivers/net/nbl/nbl_ethdev.h
new file mode 100644
index 0000000000..e20a7b940e
--- /dev/null
+++ b/drivers/net/nbl/nbl_ethdev.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_ETHDEV_H_
+#define _NBL_ETHDEV_H_
+
+#include "nbl_core.h"
+
+#define ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev) \
+	((struct nbl_adapter *)((eth_dev)->data->dev_private))
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
new file mode 100644
index 0000000000..3c7573f3bf
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_INCLUDE_H_
+#define _NBL_INCLUDE_H_
+
+#include <ctype.h>
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/genetlink.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <rte_ethdev.h>
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <bus_pci_driver.h>
+
+#include "nbl_logs.h"
+
+typedef uint64_t u64;
+typedef uint32_t u32;
+typedef uint16_t u16;
+typedef uint8_t u8;
+typedef int64_t s64;
+typedef int32_t s32;
+typedef int16_t s16;
+typedef int8_t s8;
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_logs.h b/drivers/net/nbl/nbl_include/nbl_logs.h
new file mode 100644
index 0000000000..161e07b29d
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_logs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_LOGS_H_
+#define _NBL_LOGS_H_
+
+#include <rte_log.h>
+
+extern int nbl_logtype_init;
+#define RTE_LOGTYPE_NBL_INIT nbl_logtype_init
+#define PMD_INIT_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, NBL_INIT, "%s(): ", __func__, __VA_ARGS__)
+
+extern int nbl_logtype_driver;
+#define RTE_LOGTYPE_NBL_DRIVER nbl_logtype_driver
+
+#define NBL_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, NBL_DRIVER, "%s: ", __func__, __VA_ARGS__)
+
+#define NBL_ASSERT(exp)		RTE_VERIFY(exp)
+
+#define PMD_INIT_FUNC_TRACE() PMD_INIT_LOG(DEBUG, ">>")
+
+#endif
-- 
2.34.1


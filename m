Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F430C8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 03:28:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE00D402EF;
	Fri, 29 Aug 2025 05:28:33 +0200 (CEST)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com
 [115.124.28.173])
 by mails.dpdk.org (Postfix) with ESMTP id 93AAE4027D
 for <dev@dpdk.org>; Fri, 29 Aug 2025 05:28:30 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eScIZfK_1756438108 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 29 Aug 2025 11:28:28 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v7 03/17] net/nbl: add HW layer definitions and implementation
Date: Thu, 28 Aug 2025 20:27:51 -0700
Message-Id: <20250829032805.2955351-4-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829032805.2955351-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250829032805.2955351-1-dimon.zhao@nebula-matrix.com>
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

add HW layer related definitions and product ops

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |  2 +
 drivers/net/nbl/nbl_core.c                    | 49 +++++++++-
 drivers/net/nbl/nbl_core.h                    | 22 ++++-
 drivers/net/nbl/nbl_hw/nbl_hw.h               | 28 ++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c | 98 +++++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h | 10 ++
 drivers/net/nbl/nbl_include/nbl_def_hw.h      | 35 +++++++
 drivers/net/nbl/nbl_include/nbl_include.h     | 12 +++
 8 files changed, 252 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_hw.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index 778c495c68..dca81f9586 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -7,8 +7,10 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
 endif
 
 includes += include_directories('nbl_include')
+includes += include_directories('nbl_hw')
 
 sources = files(
         'nbl_ethdev.c',
         'nbl_core.c',
+        'nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c',
 )
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 267293715a..decab211d3 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -4,17 +4,60 @@
 
 #include "nbl_core.h"
 
+const struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
+	[NBL_LEONIS_TYPE] = {
+		.hw_init	= nbl_hw_init_leonis_snic,
+		.hw_remove	= nbl_hw_remove_leonis_snic,
+		.res_init	= NULL,
+		.res_remove	= NULL,
+		.chan_init	= NULL,
+		.chan_remove	= NULL,
+	},
+};
+
+static const struct nbl_product_core_ops *
+nbl_core_get_product_ops(enum nbl_product_type product_type)
+{
+	RTE_ASSERT(product_type < NBL_PRODUCT_MAX);
+	return &nbl_product_core_ops[product_type];
+}
+
+static void nbl_init_func_caps(const struct rte_pci_device *pci_dev, struct nbl_func_caps *caps)
+{
+	caps->product_type = NBL_PRODUCT_MAX;
+	if (pci_dev->id.device_id >= NBL_DEVICE_ID_M18110 &&
+	    pci_dev->id.device_id <= NBL_DEVICE_ID_M18100_VF)
+		caps->product_type = NBL_LEONIS_TYPE;
+}
+
 int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev)
 {
-	RTE_SET_USED(adapter);
-	RTE_SET_USED(eth_dev);
+	const struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	const struct nbl_product_core_ops *product_base_ops = NULL;
+	int ret = 0;
+
+	nbl_init_func_caps(pci_dev, &adapter->caps);
+
+	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
+
+	/* every product's hw/chan/res layer has a great difference, so call their own init ops */
+	ret = product_base_ops->hw_init(adapter);
+	if (ret)
+		goto hw_init_fail;
 
 	return 0;
+
+hw_init_fail:
+	return -EINVAL;
 }
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
-	RTE_SET_USED(adapter);
+	const struct nbl_product_core_ops *product_base_ops = NULL;
+
+	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
+
+	product_base_ops->hw_remove(adapter);
 }
 
 int nbl_core_start(struct nbl_adapter *adapter)
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 0b0769a780..036f04b395 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -5,7 +5,8 @@
 #ifndef _NBL_CORE_H_
 #define _NBL_CORE_H_
 
-#include "nbl_include.h"
+#include "nbl_product_base.h"
+#include "nbl_def_hw.h"
 
 #define NBL_VENDOR_ID				(0x1F0F)
 #define NBL_DEVICE_ID_M18110			(0x3403)
@@ -27,9 +28,28 @@
 #define NBL_DEVICE_ID_M18100_VF			(0x3413)
 
 #define NBL_MAX_INSTANCE_CNT 516
+
+#define NBL_ADAPTER_TO_HW_MGT(adapter)		((adapter)->core.hw_mgt)
+#define NBL_ADAPTER_TO_HW_OPS_TBL(adapter)	((adapter)->intf.hw_ops_tbl)
+
+struct nbl_core {
+	void *hw_mgt;
+	void *res_mgt;
+	void *disp_mgt;
+	void *chan_mgt;
+	void *dev_mgt;
+};
+
+struct nbl_interface {
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+};
+
 struct nbl_adapter {
 	TAILQ_ENTRY(nbl_adapter) next;
 	struct rte_pci_device *pci_dev;
+	struct nbl_core core;
+	struct nbl_interface intf;
+	struct nbl_func_caps caps;
 };
 
 int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev);
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw.h b/drivers/net/nbl/nbl_hw/nbl_hw.h
new file mode 100644
index 0000000000..03500a0d07
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_HW_H_
+#define _NBL_HW_H_
+
+#include "nbl_ethdev.h"
+
+#define NBL_NOTIFY_ADDR			(0x00000000)
+#define NBL_BYTES_IN_REG		(4)
+#define NBL_TAIL_PTR_OFT		(16)
+#define NBL_LO_DWORD(x)			((u32)((x) & 0xFFFFFFFF))
+#define NBL_HI_DWORD(x)			((u32)(((x) >> 32) & 0xFFFFFFFF))
+
+struct nbl_hw_mgt {
+	u8 *hw_addr;
+	u64 memory_bar_pa;
+	u8 *mailbox_bar_hw_addr;
+	u64 notify_addr;
+	u32 version;
+};
+
+struct nbl_hw_mgt_leonis_snic {
+	struct nbl_hw_mgt hw_mgt;
+};
+
+#endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
new file mode 100644
index 0000000000..3bcf68a46d
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_hw_leonis_snic.h"
+
+static inline void nbl_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	rte_write32(rte_cpu_to_le_32(value), ((hw_mgt)->hw_addr + (reg)));
+}
+
+static void nbl_hw_update_tail_ptr(void *priv, u16 notify_qid, u16 tail_ptr)
+{
+	nbl_wr32(priv, NBL_NOTIFY_ADDR, ((u32)tail_ptr << NBL_TAIL_PTR_OFT | (u32)notify_qid));
+}
+
+static u8 *nbl_hw_get_tail_ptr(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	return hw_mgt->hw_addr;
+}
+
+static struct nbl_hw_ops hw_ops = {
+	.update_tail_ptr		= nbl_hw_update_tail_ptr,
+	.get_tail_ptr			= nbl_hw_get_tail_ptr,
+};
+
+static int nbl_hw_setup_ops(struct nbl_hw_ops_tbl **hw_ops_tbl,
+			    struct nbl_hw_mgt_leonis_snic *hw_mgt_leonis_snic)
+{
+	*hw_ops_tbl = calloc(1, sizeof(**hw_ops_tbl));
+	if (!*hw_ops_tbl)
+		return -ENOMEM;
+
+	NBL_HW_OPS_TBL_TO_OPS(*hw_ops_tbl) = &hw_ops;
+	NBL_HW_OPS_TBL_TO_PRIV(*hw_ops_tbl) = hw_mgt_leonis_snic;
+
+	return 0;
+}
+
+static void nbl_hw_remove_ops(struct nbl_hw_ops_tbl **hw_ops_tbl)
+{
+	free(*hw_ops_tbl);
+	*hw_ops_tbl = NULL;
+}
+
+int nbl_hw_init_leonis_snic(void *p)
+{
+	struct nbl_hw_mgt_leonis_snic **hw_mgt_leonis_snic;
+	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct rte_pci_device *pci_dev = adapter->pci_dev;
+	int ret = 0;
+
+	hw_mgt_leonis_snic = (struct nbl_hw_mgt_leonis_snic **)&NBL_ADAPTER_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+
+	*hw_mgt_leonis_snic = rte_zmalloc("nbl_hw_mgt", sizeof(**hw_mgt_leonis_snic), 0);
+	if (!*hw_mgt_leonis_snic) {
+		ret = -ENOMEM;
+		goto alloc_hw_mgt_failed;
+	}
+
+	hw_mgt = &(*hw_mgt_leonis_snic)->hw_mgt;
+
+	hw_mgt->hw_addr = (u8 *)pci_dev->mem_resource[0].addr;
+	hw_mgt->memory_bar_pa = pci_dev->mem_resource[0].phys_addr;
+	hw_mgt->mailbox_bar_hw_addr = (u8 *)pci_dev->mem_resource[2].addr;
+
+	ret = nbl_hw_setup_ops(hw_ops_tbl, *hw_mgt_leonis_snic);
+	if (ret)
+		goto setup_ops_failed;
+
+	return ret;
+
+setup_ops_failed:
+	rte_free(*hw_mgt_leonis_snic);
+alloc_hw_mgt_failed:
+	return ret;
+}
+
+void nbl_hw_remove_leonis_snic(void *p)
+{
+	struct nbl_hw_mgt_leonis_snic **hw_mgt_leonis_snic;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+
+	hw_mgt_leonis_snic = (struct nbl_hw_mgt_leonis_snic **)&adapter->core.hw_mgt;
+	hw_ops_tbl = &NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+
+	rte_free(*hw_mgt_leonis_snic);
+
+	nbl_hw_remove_ops(hw_ops_tbl);
+}
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
new file mode 100644
index 0000000000..94f5062cf0
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_HW_LEONIS_SNIC_H_
+#define _NBL_HW_LEONIS_SNIC_H_
+
+#include "../nbl_hw.h"
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_hw.h b/drivers/net/nbl/nbl_include/nbl_def_hw.h
new file mode 100644
index 0000000000..1e16e1bb5d
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_HW_H_
+#define _NBL_DEF_HW_H_
+
+#include "nbl_include.h"
+
+#define NBL_HW_OPS_TBL_TO_OPS(hw_ops_tbl)	((hw_ops_tbl)->ops)
+#define NBL_HW_OPS_TBL_TO_PRIV(hw_ops_tbl)	((hw_ops_tbl)->priv)
+
+struct nbl_hw_ops {
+	/* queue */
+	void (*update_tail_ptr)(void *priv, u16 notify_qid, u16 tail_ptr);
+	u8 *(*get_tail_ptr)(void *priv);
+
+	/* mailbox */
+	void (*config_mailbox_rxq)(void *priv, uint64_t dma_addr, int size_bwid);
+	void (*config_mailbox_txq)(void *priv, uint64_t dma_addr, int size_bwid);
+	void (*stop_mailbox_rxq)(void *priv);
+	void (*stop_mailbox_txq)(void *priv);
+	uint16_t (*get_mailbox_rx_tail_ptr)(void *priv);
+	void (*update_mailbox_queue_tail_ptr)(void *priv, uint16_t tail_ptr, uint8_t txrx);
+};
+
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_ops *ops;
+	void *priv;
+};
+
+int nbl_hw_init_leonis_snic(void *adapter);
+void nbl_hw_remove_leonis_snic(void *adapter);
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 3c7573f3bf..d116d22f51 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -28,6 +28,7 @@
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
+#include <rte_io.h>
 
 #include "nbl_logs.h"
 
@@ -40,4 +41,15 @@ typedef int32_t s32;
 typedef int16_t s16;
 typedef int8_t s8;
 
+enum nbl_product_type {
+	NBL_LEONIS_TYPE,
+	NBL_PRODUCT_MAX,
+};
+
+struct nbl_func_caps {
+	enum nbl_product_type product_type;
+	u32 is_vf:1;
+	u32 rsv:31;
+};
+
 #endif
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1657C71155
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 03:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A13CA40B91;
	Tue, 17 Jun 2025 05:24:21 +0200 (CEST)
Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com
 [115.124.28.127])
 by mails.dpdk.org (Postfix) with ESMTP id 6E25540156
 for <dev@dpdk.org>; Tue, 17 Jun 2025 05:24:15 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.dNoTypB_1750130650 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 17 Jun 2025 11:24:11 +0800
From: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 03/16] net/nbl: add PHY layer definitions and implementation
Date: Mon, 16 Jun 2025 20:23:40 -0700
Message-Id: <20250617032353.3036379-4-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617032353.3036379-1-dimon.zhao@nebula-matrix.com>
References: <20250617032353.3036379-1-dimon.zhao@nebula-matrix.com>
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

add PHY layer related definitions and product ops

Signed-off-by: dimon.zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |  2 +
 drivers/net/nbl/nbl_core.c                    | 54 ++++++++--
 drivers/net/nbl/nbl_core.h                    | 30 +++++-
 drivers/net/nbl/nbl_ethdev.c                  |  4 +-
 .../nbl_hw_leonis/nbl_phy_leonis_snic.c       | 99 +++++++++++++++++++
 .../nbl_hw_leonis/nbl_phy_leonis_snic.h       | 10 ++
 drivers/net/nbl/nbl_hw/nbl_phy.h              | 28 ++++++
 drivers/net/nbl/nbl_include/nbl_def_phy.h     | 35 +++++++
 drivers/net/nbl/nbl_include/nbl_include.h     | 15 +++
 .../net/nbl/nbl_include/nbl_product_base.h    | 37 +++++++
 10 files changed, 300 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_phy.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_phy.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index 013a4126f6..4ec1273100 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -7,8 +7,10 @@ if not is_linux
 endif
 
 includes += include_directories('nbl_include')
+includes += include_directories('nbl_hw')
 
 sources = files(
         'nbl_ethdev.c',
         'nbl_core.c',
+        'nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c',
 )
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 63b707f0ba..fc7222d526 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -4,27 +4,67 @@
 
 #include "nbl_core.h"
 
-int nbl_core_init(const struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev)
+static struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
+	{
+		.phy_init	= nbl_phy_init_leonis_snic,
+		.phy_remove	= nbl_phy_remove_leonis_snic,
+		.res_init	= NULL,
+		.res_remove	= NULL,
+		.chan_init	= NULL,
+		.chan_remove	= NULL,
+	},
+};
+
+static struct nbl_product_core_ops *nbl_core_get_product_ops(enum nbl_product_type product_type)
 {
-	RTE_SET_USED(adapter);
-	RTE_SET_USED(eth_dev);
+	return &nbl_product_core_ops[product_type];
+}
+
+static void nbl_init_func_caps(struct rte_pci_device *pci_dev, struct nbl_func_caps *caps)
+{
+	if (pci_dev->id.device_id >= NBL_DEVICE_ID_M18110 &&
+	    pci_dev->id.device_id <= NBL_DEVICE_ID_M18100_VF)
+		caps->product_type = NBL_LEONIS_TYPE;
+}
+
+int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct nbl_product_core_ops *product_base_ops = NULL;
+	int ret = 0;
+
+	nbl_init_func_caps(pci_dev, &adapter->caps);
+
+	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
+
+	/* every product's phy/chan/res layer has a great difference, so call their own init ops */
+	ret = product_base_ops->phy_init(adapter);
+	if (ret)
+		goto phy_init_fail;
 
 	return 0;
+
+phy_init_fail:
+	return -EINVAL;
 }
 
-void nbl_core_remove(const struct nbl_adapter *adapter)
+void nbl_core_remove(struct nbl_adapter *adapter)
 {
-	RTE_SET_USED(adapter);
+	struct nbl_product_core_ops *product_base_ops = NULL;
+
+	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
+
+	product_base_ops->phy_remove(adapter);
 }
 
-int nbl_core_start(const struct nbl_adapter *adapter)
+int nbl_core_start(struct nbl_adapter *adapter)
 {
 	RTE_SET_USED(adapter);
 
 	return 0;
 }
 
-void nbl_core_stop(const struct nbl_adapter *adapter)
+void nbl_core_stop(struct nbl_adapter *adapter)
 {
 	RTE_SET_USED(adapter);
 }
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 4ba13e5bd7..2d0e39afa2 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -5,7 +5,8 @@
 #ifndef _NBL_CORE_H_
 #define _NBL_CORE_H_
 
-#include "nbl_include.h"
+#include "nbl_product_base.h"
+#include "nbl_def_phy.h"
 
 #define NBL_VENDOR_ID				(0x1F0F)
 #define NBL_DEVICE_ID_M18110			(0x3403)
@@ -27,14 +28,33 @@
 #define NBL_DEVICE_ID_M18100_VF			(0x3413)
 
 #define NBL_MAX_INSTANCE_CNT 516
+
+#define NBL_ADAPTER_TO_PHY_MGT(adapter)		((adapter)->core.phy_mgt)
+#define NBL_ADAPTER_TO_PHY_OPS_TBL(adapter)	((adapter)->intf.phy_ops_tbl)
+
+struct nbl_core {
+	void *phy_mgt;
+	void *res_mgt;
+	void *disp_mgt;
+	void *chan_mgt;
+	void *dev_mgt;
+};
+
+struct nbl_interface {
+	struct nbl_phy_ops_tbl *phy_ops_tbl;
+};
+
 struct nbl_adapter {
 	TAILQ_ENTRY(nbl_adapter) next;
 	struct rte_pci_device *pci_dev;
+	struct nbl_core core;
+	struct nbl_interface intf;
+	struct nbl_func_caps caps;
 };
 
-int nbl_core_init(const struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev);
-void nbl_core_remove(const struct nbl_adapter *adapter);
-int nbl_core_start(const struct nbl_adapter *adapter);
-void nbl_core_stop(const struct nbl_adapter *adapter);
+int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev);
+void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index 9f44d21b8e..261f8a522a 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -9,7 +9,7 @@ RTE_LOG_REGISTER_SUFFIX(nbl_logtype_driver, driver, INFO);
 
 static int nbl_dev_release_pf(struct rte_eth_dev *eth_dev)
 {
-	const struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 
 	if (!adapter)
 		return -EINVAL;
@@ -33,7 +33,7 @@ struct eth_dev_ops nbl_eth_dev_ops = {
 
 static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
 {
-	const struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c
new file mode 100644
index 0000000000..febee34edd
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_phy_leonis_snic.h"
+
+static inline void nbl_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_phy_mgt *phy_mgt = (struct nbl_phy_mgt *)priv;
+
+	rte_write32(rte_cpu_to_le_32(value), ((phy_mgt)->hw_addr + (reg)));
+}
+
+static void nbl_phy_update_tail_ptr(void *priv, u16 notify_qid, u16 tail_ptr)
+{
+	nbl_wr32(priv, NBL_NOTIFY_ADDR, ((u32)tail_ptr << NBL_TAIL_PTR_OFT | (u32)notify_qid));
+}
+
+static u8 *nbl_phy_get_tail_ptr(void *priv)
+{
+	struct nbl_phy_mgt *phy_mgt = (struct nbl_phy_mgt *)priv;
+
+	return phy_mgt->hw_addr;
+}
+
+static struct nbl_phy_ops phy_ops = {
+	.update_tail_ptr		= nbl_phy_update_tail_ptr,
+	.get_tail_ptr			= nbl_phy_get_tail_ptr,
+};
+
+static int nbl_phy_setup_ops(struct nbl_phy_ops_tbl **phy_ops_tbl,
+			     struct nbl_phy_mgt_leonis_snic *phy_mgt_leonis_snic)
+{
+	*phy_ops_tbl = rte_zmalloc("nbl_phy_ops", sizeof(struct nbl_phy_ops_tbl), 0);
+	if (!*phy_ops_tbl)
+		return -ENOMEM;
+
+	NBL_PHY_OPS_TBL_TO_OPS(*phy_ops_tbl) = &phy_ops;
+	NBL_PHY_OPS_TBL_TO_PRIV(*phy_ops_tbl) = phy_mgt_leonis_snic;
+
+	return 0;
+}
+
+static void nbl_phy_remove_ops(struct nbl_phy_ops_tbl **phy_ops_tbl)
+{
+	rte_free(*phy_ops_tbl);
+	*phy_ops_tbl = NULL;
+}
+
+int nbl_phy_init_leonis_snic(void *p)
+{
+	struct nbl_phy_mgt_leonis_snic **phy_mgt_leonis_snic;
+	struct nbl_phy_mgt *phy_mgt;
+	struct nbl_phy_ops_tbl **phy_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct rte_pci_device *pci_dev = adapter->pci_dev;
+	int ret = 0;
+
+	phy_mgt_leonis_snic = (struct nbl_phy_mgt_leonis_snic **)&NBL_ADAPTER_TO_PHY_MGT(adapter);
+	phy_ops_tbl = &NBL_ADAPTER_TO_PHY_OPS_TBL(adapter);
+
+	*phy_mgt_leonis_snic = rte_zmalloc("nbl_phy_mgt",
+					   sizeof(struct nbl_phy_mgt_leonis_snic), 0);
+	if (!*phy_mgt_leonis_snic) {
+		ret = -ENOMEM;
+		goto alloc_phy_mgt_failed;
+	}
+
+	phy_mgt = &(*phy_mgt_leonis_snic)->phy_mgt;
+
+	phy_mgt->hw_addr = (u8 *)pci_dev->mem_resource[0].addr;
+	phy_mgt->memory_bar_pa = pci_dev->mem_resource[0].phys_addr;
+	phy_mgt->mailbox_bar_hw_addr = (u8 *)pci_dev->mem_resource[2].addr;
+
+	ret = nbl_phy_setup_ops(phy_ops_tbl, *phy_mgt_leonis_snic);
+	if (ret)
+		goto setup_ops_failed;
+
+	return ret;
+
+setup_ops_failed:
+	rte_free(*phy_mgt_leonis_snic);
+alloc_phy_mgt_failed:
+	return ret;
+}
+
+void nbl_phy_remove_leonis_snic(void *p)
+{
+	struct nbl_phy_mgt_leonis_snic **phy_mgt_leonis_snic;
+	struct nbl_phy_ops_tbl **phy_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+
+	phy_mgt_leonis_snic = (struct nbl_phy_mgt_leonis_snic **)&adapter->core.phy_mgt;
+	phy_ops_tbl = &NBL_ADAPTER_TO_PHY_OPS_TBL(adapter);
+
+	rte_free(*phy_mgt_leonis_snic);
+
+	nbl_phy_remove_ops(phy_ops_tbl);
+}
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.h b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.h
new file mode 100644
index 0000000000..5440cf41be
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_PHY_LEONIS_SNIC_H_
+#define _NBL_PHY_LEONIS_SNIC_H_
+
+#include "../nbl_phy.h"
+
+#endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_phy.h b/drivers/net/nbl/nbl_hw/nbl_phy.h
new file mode 100644
index 0000000000..38b7fc2ec5
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_phy.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_PHY_H_
+#define _NBL_PHY_H_
+
+#include "nbl_ethdev.h"
+
+#define NBL_NOTIFY_ADDR			(0x00000000)
+#define NBL_BYTES_IN_REG		(4)
+#define NBL_TAIL_PTR_OFT		(16)
+#define NBL_LO_DWORD(x)			((u32)((x) & 0xFFFFFFFF))
+#define NBL_HI_DWORD(x)			((u32)(((x) >> 32) & 0xFFFFFFFF))
+
+struct nbl_phy_mgt {
+	u8 *hw_addr;
+	u64 memory_bar_pa;
+	u8 *mailbox_bar_hw_addr;
+	u64 notify_addr;
+	u32 version;
+};
+
+struct nbl_phy_mgt_leonis_snic {
+	struct nbl_phy_mgt phy_mgt;
+};
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_phy.h b/drivers/net/nbl/nbl_include/nbl_def_phy.h
new file mode 100644
index 0000000000..09a3e125a9
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_def_phy.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_PHY_H_
+#define _NBL_DEF_PHY_H_
+
+#include "nbl_include.h"
+
+#define NBL_PHY_OPS_TBL_TO_OPS(phy_ops_tbl)	((phy_ops_tbl)->ops)
+#define NBL_PHY_OPS_TBL_TO_PRIV(phy_ops_tbl)	((phy_ops_tbl)->priv)
+
+struct nbl_phy_ops {
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
+struct nbl_phy_ops_tbl {
+	struct nbl_phy_ops *ops;
+	void *priv;
+};
+
+int nbl_phy_init_leonis_snic(void *adapter);
+void nbl_phy_remove_leonis_snic(void *adapter);
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 3c7573f3bf..554bb95f16 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -28,6 +28,7 @@
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
+#include <rte_io.h>
 
 #include "nbl_logs.h"
 
@@ -40,4 +41,18 @@ typedef int32_t s32;
 typedef int16_t s16;
 typedef int8_t s8;
 
+enum nbl_product_type {
+	NBL_LEONIS_TYPE,
+	NBL_DRACO_TYPE,
+	NBL_BOOTIS_TYPE,
+	NBL_PRODUCT_MAX,
+};
+
+struct nbl_func_caps {
+	enum nbl_product_type product_type;
+	u32 is_vf:1;
+	u32 is_user:1;
+	u32 rsv:30;
+};
+
 #endif
diff --git a/drivers/net/nbl/nbl_include/nbl_product_base.h b/drivers/net/nbl/nbl_include/nbl_product_base.h
new file mode 100644
index 0000000000..7b9c2ccf72
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_product_base.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_PRODUCT_BASE_H_
+#define _NBL_DEF_PRODUCT_BASE_H_
+
+#include "nbl_include.h"
+
+struct nbl_product_core_ops {
+	int (*phy_init)(void *p);
+	void (*phy_remove)(void *p);
+	int (*res_init)(void *p, struct rte_eth_dev *eth_dev);
+	void (*res_remove)(void *p);
+	int (*chan_init)(void *p);
+	void (*chan_remove)(void *p);
+};
+
+struct nbl_product_dev_ops {
+	int (*dev_init)(void *adapter);
+	void (*dev_uninit)(void *adapter);
+	int (*dev_start)(void *adapter);
+	void (*dev_stop)(void *adapter);
+};
+
+struct nbl_product_dispatch_ops {
+	int (*dispatch_init)(void *mgt);
+	int (*dispatch_uninit)(void *mgt);
+};
+
+struct nbl_product_dev_external_ops {
+	int (*external_pf_ops_get)(struct rte_eth_dev *dev, void *arg);
+	int (*external_rep_ops_get)(struct rte_eth_dev *dev, void *arg);
+	int (*external_bond_ops_get)(struct rte_eth_dev *dev, void *arg);
+};
+
+#endif
-- 
2.34.1


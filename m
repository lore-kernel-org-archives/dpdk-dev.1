Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB4C7114A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 06:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6401140DD2;
	Tue, 17 Jun 2025 08:12:15 +0200 (CEST)
Received: from out28-103.mail.aliyun.com (out28-103.mail.aliyun.com
 [115.124.28.103])
 by mails.dpdk.org (Postfix) with ESMTP id E47A540A73
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:12:09 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.dO-dyYO_1750140727 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 17 Jun 2025 14:12:08 +0800
From: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 05/16] net/nbl: add Resource layer definitions and
 implementation
Date: Mon, 16 Jun 2025 23:11:47 -0700
Message-Id: <20250617061158.3097233-6-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617061158.3097233-1-dimon.zhao@nebula-matrix.com>
References: <20250617061158.3097233-1-dimon.zhao@nebula-matrix.com>
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

add Resource layer related definitions

Signed-off-by: dimon.zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |   3 +
 drivers/net/nbl/nbl_core.c                    |  11 +-
 drivers/net/nbl/nbl_core.h                    |   4 +
 drivers/net/nbl/nbl_hw/nbl_channel.h          |   2 +-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 137 ++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |  10 ++
 drivers/net/nbl/nbl_hw/nbl_resource.c         |   5 +
 drivers/net/nbl/nbl_hw/nbl_resource.h         |  51 ++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.c             | 148 ++++++++++++++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.h             |  10 ++
 .../net/nbl/nbl_include/nbl_def_resource.h    |  47 ++++++
 drivers/net/nbl/nbl_include/nbl_include.h     |  20 +++
 12 files changed, 445 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index c849cab185..f34121260e 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -15,5 +15,8 @@ sources = files(
         'nbl_common/nbl_common.c',
         'nbl_common/nbl_thread.c',
         'nbl_hw/nbl_channel.c',
+        'nbl_hw/nbl_resource.c',
+        'nbl_hw/nbl_txrx.c',
         'nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c',
+        'nbl_hw/nbl_hw_leonis/nbl_res_leonis.c',
 )
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index f4388fe3b5..70600401fe 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -8,8 +8,8 @@ static struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
 	{
 		.phy_init	= nbl_phy_init_leonis_snic,
 		.phy_remove	= nbl_phy_remove_leonis_snic,
-		.res_init	= NULL,
-		.res_remove	= NULL,
+		.res_init	= nbl_res_init_leonis,
+		.res_remove	= nbl_res_remove_leonis,
 		.chan_init	= nbl_chan_init_leonis,
 		.chan_remove	= nbl_chan_remove_leonis,
 	},
@@ -46,8 +46,14 @@ int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
 	if (ret)
 		goto chan_init_fail;
 
+	ret = product_base_ops->res_init(adapter, eth_dev);
+	if (ret)
+		goto res_init_fail;
+
 	return 0;
 
+res_init_fail:
+	product_base_ops->chan_remove(adapter);
 chan_init_fail:
 	product_base_ops->phy_remove(adapter);
 phy_init_fail:
@@ -60,6 +66,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
 
+	product_base_ops->res_remove(adapter);
 	product_base_ops->chan_remove(adapter);
 	product_base_ops->phy_remove(adapter);
 }
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index a6c1103c77..f693913b47 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -9,6 +9,7 @@
 #include "nbl_def_common.h"
 #include "nbl_def_phy.h"
 #include "nbl_def_channel.h"
+#include "nbl_def_resource.h"
 
 #define NBL_VENDOR_ID				(0x1F0F)
 #define NBL_DEVICE_ID_M18110			(0x3403)
@@ -33,9 +34,11 @@
 
 #define NBL_ADAPTER_TO_PHY_MGT(adapter)		((adapter)->core.phy_mgt)
 #define NBL_ADAPTER_TO_CHAN_MGT(adapter)	((adapter)->core.chan_mgt)
+#define NBL_ADAPTER_TO_RES_MGT(adapter)		((adapter)->core.res_mgt)
 
 #define NBL_ADAPTER_TO_PHY_OPS_TBL(adapter)	((adapter)->intf.phy_ops_tbl)
 #define NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter)	((adapter)->intf.channel_ops_tbl)
+#define NBL_ADAPTER_TO_RES_OPS_TBL(adapter)	((adapter)->intf.resource_ops_tbl)
 
 struct nbl_core {
 	void *phy_mgt;
@@ -48,6 +51,7 @@ struct nbl_core {
 struct nbl_interface {
 	struct nbl_phy_ops_tbl *phy_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
+	struct nbl_resource_ops_tbl *resource_ops_tbl;
 };
 
 struct nbl_adapter {
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.h b/drivers/net/nbl/nbl_hw/nbl_channel.h
index df2222d995..59e8dfc800 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.h
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.h
@@ -106,7 +106,7 @@ struct nbl_channel_mgt {
 };
 
 /* Mgt structure for each product.
- * Every indivisual mgt must have the common mgt as its first member, and contains its unique
+ * Every individual mgt must have the common mgt as its first member, and contains its unique
  * data structure in the reset of it.
  */
 struct nbl_channel_mgt_leonis {
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
new file mode 100644
index 0000000000..6327aa55b4
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_res_leonis.h"
+
+static struct nbl_resource_ops res_ops = {
+};
+
+static bool is_ops_inited;
+
+static void nbl_res_remove_ops(struct nbl_resource_ops_tbl **res_ops_tbl)
+{
+	rte_free(*res_ops_tbl);
+	*res_ops_tbl = NULL;
+}
+
+static int nbl_res_setup_ops(struct nbl_resource_ops_tbl **res_ops_tbl,
+			     struct nbl_resource_mgt_leonis *res_mgt_leonis)
+{
+	int ret = 0;
+
+	*res_ops_tbl = rte_zmalloc("nbl_res_ops", sizeof(struct nbl_resource_ops_tbl), 0);
+	if (!*res_ops_tbl)
+		return -ENOMEM;
+
+	if (!is_ops_inited) {
+		ret = nbl_txrx_setup_ops(&res_ops);
+		if (ret)
+			goto set_ops_failed;
+
+		is_ops_inited = true;
+	}
+
+	NBL_RES_OPS_TBL_TO_OPS(*res_ops_tbl) = &res_ops;
+	NBL_RES_OPS_TBL_TO_PRIV(*res_ops_tbl) = res_mgt_leonis;
+
+	return ret;
+
+set_ops_failed:
+	rte_free(*res_ops_tbl);
+	return ret;
+}
+
+static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
+{
+	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
+	nbl_txrx_mgt_stop(res_mgt);
+}
+
+static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis)
+{
+	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
+	int ret;
+
+	ret = nbl_txrx_mgt_start(res_mgt);
+	if (ret)
+		goto txrx_failed;
+
+	return 0;
+
+txrx_failed:
+	return ret;
+}
+
+static void
+nbl_res_remove_res_mgt(struct nbl_resource_mgt_leonis **res_mgt_leonis)
+{
+	rte_free(*res_mgt_leonis);
+	*res_mgt_leonis = NULL;
+}
+
+static int
+nbl_res_setup_res_mgt(struct nbl_resource_mgt_leonis **res_mgt_leonis)
+{
+	*res_mgt_leonis = rte_zmalloc("nbl_res_mgt",
+				      sizeof(struct nbl_resource_mgt_leonis),
+				      0);
+	if (!*res_mgt_leonis)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int nbl_res_init_leonis(void *p, struct rte_eth_dev *eth_dev)
+{
+	struct nbl_resource_mgt_leonis **res_mgt_leonis;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+	struct nbl_phy_ops_tbl *phy_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	int ret = 0;
+
+	res_mgt_leonis = (struct nbl_resource_mgt_leonis **)&NBL_ADAPTER_TO_RES_MGT(adapter);
+	res_ops_tbl = &NBL_ADAPTER_TO_RES_OPS_TBL(adapter);
+	phy_ops_tbl = NBL_ADAPTER_TO_PHY_OPS_TBL(adapter);
+	chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+
+	ret = nbl_res_setup_res_mgt(res_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+
+	NBL_RES_MGT_TO_CHAN_OPS_TBL(&(*res_mgt_leonis)->res_mgt) = chan_ops_tbl;
+	NBL_RES_MGT_TO_PHY_OPS_TBL(&(*res_mgt_leonis)->res_mgt) = phy_ops_tbl;
+	NBL_RES_MGT_TO_ETH_DEV(&(*res_mgt_leonis)->res_mgt) = eth_dev;
+
+	ret = nbl_res_start(*res_mgt_leonis);
+	if (ret)
+		goto start_fail;
+
+	ret = nbl_res_setup_ops(res_ops_tbl, *res_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_res_stop(*res_mgt_leonis);
+start_fail:
+	nbl_res_remove_res_mgt(res_mgt_leonis);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_res_remove_leonis(void *p)
+{
+	struct nbl_resource_mgt_leonis **res_mgt_leonis;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+
+	res_mgt_leonis = (struct nbl_resource_mgt_leonis **)&NBL_ADAPTER_TO_RES_MGT(adapter);
+	res_ops_tbl = &NBL_ADAPTER_TO_RES_OPS_TBL(adapter);
+
+	nbl_res_remove_ops(res_ops_tbl);
+	nbl_res_stop(*res_mgt_leonis);
+	nbl_res_remove_res_mgt(res_mgt_leonis);
+}
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
new file mode 100644
index 0000000000..d14f868d55
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_RES_LEONIS_H_
+#define _NBL_RES_LEONIS_H_
+
+#include "nbl_resource.h"
+
+#endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.c b/drivers/net/nbl/nbl_hw/nbl_resource.c
new file mode 100644
index 0000000000..47baaa2a91
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.c
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_resource.h"
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
new file mode 100644
index 0000000000..2ea79563cc
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_RESOURCE_H_
+#define _NBL_RESOURCE_H_
+
+#include "nbl_ethdev.h"
+#include "nbl_include.h"
+#include <stdint.h>
+
+#define NBL_RES_MGT_TO_PHY_OPS_TBL(res_mgt)	((res_mgt)->phy_ops_tbl)
+#define NBL_RES_MGT_TO_PHY_OPS(res_mgt)		(NBL_RES_MGT_TO_PHY_OPS_TBL(res_mgt)->ops)
+#define NBL_RES_MGT_TO_PHY_PRIV(res_mgt)	(NBL_RES_MGT_TO_PHY_OPS_TBL(res_mgt)->priv)
+#define NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)	((res_mgt)->chan_ops_tbl)
+#define NBL_RES_MGT_TO_CHAN_OPS(res_mgt)	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->ops)
+#define NBL_RES_MGT_TO_CHAN_PRIV(res_mgt)	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->priv)
+#define NBL_RES_MGT_TO_ETH_DEV(res_mgt)		((res_mgt)->eth_dev)
+#define NBL_RES_MGT_TO_TXRX_MGT(res_mgt)	((res_mgt)->txrx_mgt)
+
+struct nbl_res_tx_ring {
+};
+
+struct nbl_res_rx_ring {
+};
+
+struct nbl_txrx_mgt {
+	rte_spinlock_t tx_lock;
+	struct nbl_res_tx_ring **tx_rings;
+	struct nbl_res_rx_ring **rx_rings;
+	u8 tx_ring_num;
+	u8 rx_ring_num;
+};
+
+struct nbl_resource_mgt {
+	struct rte_eth_dev *eth_dev;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_phy_ops_tbl *phy_ops_tbl;
+	struct nbl_txrx_mgt *txrx_mgt;
+};
+
+struct nbl_resource_mgt_leonis {
+	struct nbl_resource_mgt res_mgt;
+};
+
+int nbl_txrx_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_txrx_mgt_stop(struct nbl_resource_mgt *res_mgt);
+int nbl_txrx_setup_ops(struct nbl_resource_ops *resource_ops);
+void nbl_txrx_remove_ops(struct nbl_resource_ops *resource_ops);
+
+#endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
new file mode 100644
index 0000000000..0df204e425
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_txrx.h"
+#include "nbl_include.h"
+
+static int nbl_res_txrx_alloc_rings(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(tx_num);
+	RTE_SET_USED(rx_num);
+	RTE_SET_USED(queue_offset);
+	return 0;
+}
+
+static void nbl_res_txrx_remove_rings(void *priv)
+{
+	RTE_SET_USED(priv);
+}
+
+static int nbl_res_txrx_start_tx_ring(void *priv,
+				      struct nbl_start_tx_ring_param *param,
+				      u64 *dma_addr)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(param);
+	RTE_SET_USED(dma_addr);
+	return 0;
+}
+
+static void nbl_res_txrx_stop_tx_ring(void *priv, u16 queue_idx)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(queue_idx);
+}
+
+static void nbl_res_txrx_release_txring(void *priv, u16 queue_idx)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(queue_idx);
+}
+
+static int nbl_res_txrx_start_rx_ring(void *priv,
+				      struct nbl_start_rx_ring_param *param,
+				      u64 *dma_addr)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(param);
+	RTE_SET_USED(dma_addr);
+	return 0;
+}
+
+static int nbl_res_alloc_rx_bufs(void *priv, u16 queue_idx)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(queue_idx);
+	return 0;
+}
+
+static void nbl_res_txrx_stop_rx_ring(void *priv, u16 queue_idx)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(queue_idx);
+}
+
+static void nbl_res_txrx_release_rx_ring(void *priv, u16 queue_idx)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(queue_idx);
+}
+
+static void nbl_res_txrx_update_rx_ring(void *priv, u16 index)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(index);
+}
+
+/* NBL_TXRX_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_TXRX_OPS_TBL							\
+do {										\
+	NBL_TXRX_SET_OPS(alloc_rings, nbl_res_txrx_alloc_rings);		\
+	NBL_TXRX_SET_OPS(remove_rings, nbl_res_txrx_remove_rings);		\
+	NBL_TXRX_SET_OPS(start_tx_ring, nbl_res_txrx_start_tx_ring);		\
+	NBL_TXRX_SET_OPS(stop_tx_ring, nbl_res_txrx_stop_tx_ring);		\
+	NBL_TXRX_SET_OPS(release_tx_ring, nbl_res_txrx_release_txring);		\
+	NBL_TXRX_SET_OPS(start_rx_ring, nbl_res_txrx_start_rx_ring);		\
+	NBL_TXRX_SET_OPS(alloc_rx_bufs, nbl_res_alloc_rx_bufs);			\
+	NBL_TXRX_SET_OPS(stop_rx_ring, nbl_res_txrx_stop_rx_ring);		\
+	NBL_TXRX_SET_OPS(release_rx_ring, nbl_res_txrx_release_rx_ring);	\
+	NBL_TXRX_SET_OPS(update_rx_ring, nbl_res_txrx_update_rx_ring);		\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_txrx_setup_mgt(struct nbl_txrx_mgt **txrx_mgt)
+{
+	*txrx_mgt = rte_zmalloc("nbl_txrx_mgt", sizeof(struct nbl_txrx_mgt), 0);
+	if (!*txrx_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_txrx_remove_mgt(struct nbl_txrx_mgt **txrx_mgt)
+{
+	rte_free(*txrx_mgt);
+	*txrx_mgt = NULL;
+}
+
+int nbl_txrx_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_txrx_mgt **txrx_mgt;
+
+	txrx_mgt = &NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+
+	return nbl_txrx_setup_mgt(txrx_mgt);
+}
+
+void nbl_txrx_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_txrx_mgt **txrx_mgt;
+
+	txrx_mgt = &NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+
+	if (!(*txrx_mgt))
+		return;
+
+	nbl_txrx_remove_mgt(txrx_mgt);
+}
+
+int nbl_txrx_setup_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_TXRX_SET_OPS(name, func) do {res_ops->NBL_NAME(name) = func; ; } while (0)
+	NBL_TXRX_OPS_TBL;
+#undef  NBL_TXRX_SET_OPS
+
+	return 0;
+}
+
+void nbl_txrx_remove_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_TXRX_SET_OPS(name, func) do {res_ops->NBL_NAME(name) = NULL; ; } while (0)
+	NBL_TXRX_OPS_TBL;
+#undef  NBL_TXRX_SET_OPS
+}
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.h b/drivers/net/nbl/nbl_hw/nbl_txrx.h
new file mode 100644
index 0000000000..56dbd3c587
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_TXRX_H_
+#define _NBL_TXRX_H_
+
+#include "nbl_resource.h"
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
new file mode 100644
index 0000000000..c1cf041c74
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_RESOURCE_H_
+#define _NBL_DEF_RESOURCE_H_
+
+#include "nbl_include.h"
+#include "rte_ethdev_core.h"
+
+#define NBL_RES_OPS_TBL_TO_OPS(res_ops_tbl)		((res_ops_tbl)->ops)
+#define NBL_RES_OPS_TBL_TO_PRIV(res_ops_tbl)		((res_ops_tbl)->priv)
+
+struct nbl_resource_ops {
+	int (*alloc_rings)(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset);
+	void (*remove_rings)(void *priv);
+	int (*start_tx_ring)(void *priv, struct nbl_start_tx_ring_param *param, u64 *dma_addr);
+	void (*stop_tx_ring)(void *priv, u16 queue_idx);
+	void (*release_tx_ring)(void *priv, u16 queue_idx);
+	int (*start_rx_ring)(void *priv, struct nbl_start_rx_ring_param *param, u64 *dma_addr);
+	int (*alloc_rx_bufs)(void *priv, u16 queue_idx);
+	void (*stop_rx_ring)(void *priv, u16 queue_idx);
+	void (*release_rx_ring)(void *priv, u16 queue_idx);
+	int (*get_stats)(void *priv, struct rte_eth_stats *rte_stats);
+	int (*reset_stats)(void *priv);
+	void (*update_rx_ring)(void *priv, u16 queue_idx);
+	u16 (*get_tx_ehdr_len)(void *priv);
+	u64 (*restore_abnormal_ring)(void *priv, u16 local_queue_id, int type);
+	int (*restart_abnormal_ring)(void *priv, int ring_index, int type);
+	void (*cfg_txrx_vlan)(void *priv, u16 vlan_tci, u16 vlan_proto);
+	int (*txrx_burst_mode_get)(void *priv, struct rte_eth_dev *dev,
+				   struct rte_eth_burst_mode *mode, bool is_tx);
+	int (*get_txrx_xstats_cnt)(void *priv, u16 *xstats_cnt);
+	int (*get_txrx_xstats)(void *priv, struct rte_eth_xstat *xstats, u16 *xstats_cnt);
+	int (*get_txrx_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
+				     u16 *xstats_cnt);
+};
+
+struct nbl_resource_ops_tbl {
+	struct nbl_resource_ops *ops;
+	void *priv;
+};
+
+int nbl_res_init_leonis(void *p, struct rte_eth_dev *eth_dev);
+void nbl_res_remove_leonis(void *p);
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 8270475e47..0eae45ecf1 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -47,6 +47,9 @@ typedef int32_t s32;
 typedef int16_t s16;
 typedef int8_t s8;
 
+/* Used for macros to pass checkpatch */
+#define NBL_NAME(x)					x
+
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
 	NBL_DRACO_TYPE,
@@ -63,4 +66,21 @@ struct nbl_func_caps {
 
 #define BIT(a)			(1UL << (a))
 
+struct nbl_start_rx_ring_param {
+	u16 queue_idx;
+	u16 nb_desc;
+	u32 socket_id;
+	enum nbl_product_type product;
+	const struct rte_eth_rxconf *conf;
+	struct rte_mempool *mempool;
+};
+
+struct nbl_start_tx_ring_param {
+	u16 queue_idx;
+	u16 nb_desc;
+	u32 socket_id;
+	enum nbl_product_type product;
+	const struct rte_eth_txconf *conf;
+};
+
 #endif
-- 
2.34.1


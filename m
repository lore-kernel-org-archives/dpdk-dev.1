Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC62FCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 09:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0869740B8C;
	Fri, 22 Aug 2025 11:04:23 +0200 (CEST)
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com
 [115.124.28.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5B99F4069F
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:04:15 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eN-Jehy_1755853450 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 22 Aug 2025 17:04:11 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v6 07/17] net/nbl: add Dev layer definitions and implementation
Date: Fri, 22 Aug 2025 02:03:49 -0700
Message-Id: <20250822090359.614551-8-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822090359.614551-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250822090359.614551-1-dimon.zhao@nebula-matrix.com>
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

add Dev layer related definitions

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build               |   3 +
 drivers/net/nbl/nbl_core.c                |  14 +-
 drivers/net/nbl/nbl_core.h                |  16 ++
 drivers/net/nbl/nbl_dev/nbl_dev.c         | 197 ++++++++++++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.h         |  28 +++
 drivers/net/nbl/nbl_ethdev.c              |   8 +-
 drivers/net/nbl/nbl_include/nbl_def_dev.h |  26 +++
 7 files changed, 287 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.c
 create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index 2afdf81dcf..bcea1e80fb 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -8,12 +8,15 @@ endif
 
 includes += include_directories('nbl_include')
 includes += include_directories('nbl_hw')
+includes += include_directories('nbl_common')
+includes += include_directories('nbl_dev')
 
 sources = files(
         'nbl_ethdev.c',
         'nbl_core.c',
         'nbl_dispatch.c',
         'nbl_common/nbl_common.c',
+        'nbl_dev/nbl_dev.c',
         'nbl_hw/nbl_channel.c',
         'nbl_hw/nbl_resource.c',
         'nbl_hw/nbl_txrx.c',
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 0c0b9450e7..c21a12728f 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -57,8 +57,14 @@ int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev
 	if (ret)
 		goto disp_init_fail;
 
+	ret = nbl_dev_init(adapter, eth_dev);
+	if (ret)
+		goto dev_init_fail;
+
 	return 0;
 
+dev_init_fail:
+	nbl_disp_remove(adapter);
 disp_init_fail:
 	product_base_ops->res_remove(adapter);
 res_init_fail:
@@ -75,6 +81,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
 
+	nbl_dev_remove(adapter);
 	nbl_disp_remove(adapter);
 	product_base_ops->res_remove(adapter);
 	product_base_ops->chan_remove(adapter);
@@ -83,12 +90,13 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 int nbl_core_start(struct nbl_adapter *adapter)
 {
-	RTE_SET_USED(adapter);
+	int ret = 0;
 
-	return 0;
+	ret = nbl_dev_start(adapter);
+	return ret;
 }
 
 void nbl_core_stop(struct nbl_adapter *adapter)
 {
-	RTE_SET_USED(adapter);
+	nbl_dev_stop(adapter);
 }
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 20475c07fb..73188f83d9 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -11,6 +11,7 @@
 #include "nbl_def_channel.h"
 #include "nbl_def_resource.h"
 #include "nbl_def_dispatch.h"
+#include "nbl_def_dev.h"
 
 #define NBL_VENDOR_ID				(0x1F0F)
 #define NBL_DEVICE_ID_M18110			(0x3403)
@@ -37,11 +38,13 @@
 #define NBL_ADAPTER_TO_CHAN_MGT(adapter)	((adapter)->core.chan_mgt)
 #define NBL_ADAPTER_TO_RES_MGT(adapter)		((adapter)->core.res_mgt)
 #define NBL_ADAPTER_TO_DISP_MGT(adapter)	((adapter)->core.disp_mgt)
+#define NBL_ADAPTER_TO_DEV_MGT(adapter)		((adapter)->core.dev_mgt)
 
 #define NBL_ADAPTER_TO_HW_OPS_TBL(adapter)	((adapter)->intf.hw_ops_tbl)
 #define NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter)	((adapter)->intf.channel_ops_tbl)
 #define NBL_ADAPTER_TO_RES_OPS_TBL(adapter)	((adapter)->intf.resource_ops_tbl)
 #define NBL_ADAPTER_TO_DISP_OPS_TBL(adapter)	((adapter)->intf.dispatch_ops_tbl)
+#define NBL_ADAPTER_TO_DEV_OPS_TBL(adapter)	((adapter)->intf.dev_ops_tbl)
 
 struct nbl_core {
 	void *hw_mgt;
@@ -51,11 +54,23 @@ struct nbl_core {
 	void *dev_mgt;
 };
 
+enum nbl_ethdev_state {
+	NBL_ETHDEV_UNINITIALIZED = 0,
+	NBL_ETHDEV_INITIALIZED,
+	NBL_ETHDEV_CONFIGURING,
+	NBL_ETHDEV_CONFIGURED,
+	NBL_ETHDEV_CLOSING,
+	NBL_ETHDEV_STARTING,
+	NBL_ETHDEV_STARTED,
+	NBL_ETHDEV_STOPPING,
+};
+
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 	struct nbl_resource_ops_tbl *resource_ops_tbl;
 	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
+	struct nbl_dev_ops_tbl *dev_ops_tbl;
 };
 
 struct nbl_adapter {
@@ -64,6 +79,7 @@ struct nbl_adapter {
 	struct nbl_core core;
 	struct nbl_interface intf;
 	struct nbl_func_caps caps;
+	enum nbl_ethdev_state state;
 };
 
 int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
new file mode 100644
index 0000000000..ef65990ad8
--- /dev/null
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_dev.h"
+
+int nbl_dev_configure(struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(eth_dev);
+	return 0;
+}
+
+int nbl_dev_port_start(struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(eth_dev);
+	return 0;
+}
+
+int nbl_dev_port_stop(struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(eth_dev);
+	return 0;
+}
+
+int nbl_dev_port_close(struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(eth_dev);
+	return 0;
+}
+
+struct nbl_dev_ops dev_ops = {
+};
+
+static int nbl_dev_setup_chan_queue(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	int ret = 0;
+
+	ret = chan_ops->setup_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+
+	return ret;
+}
+
+static int nbl_dev_teardown_chan_queue(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	int ret = 0;
+
+	ret = chan_ops->teardown_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+
+	return ret;
+}
+
+static int nbl_dev_leonis_init(void *adapter)
+{
+	return nbl_dev_setup_chan_queue((struct nbl_adapter *)adapter);
+}
+
+static void nbl_dev_leonis_uninit(void *adapter)
+{
+	nbl_dev_teardown_chan_queue((struct nbl_adapter *)adapter);
+}
+
+static int nbl_dev_leonis_start(void *p)
+{
+	RTE_SET_USED(p);
+	return 0;
+}
+
+static void nbl_dev_leonis_stop(void *p)
+{
+	RTE_SET_USED(p);
+}
+
+static void nbl_dev_remove_ops(struct nbl_dev_ops_tbl **dev_ops_tbl)
+{
+	free(*dev_ops_tbl);
+	*dev_ops_tbl = NULL;
+}
+
+static int nbl_dev_setup_ops(struct nbl_dev_ops_tbl **dev_ops_tbl,
+			     struct nbl_adapter *adapter)
+{
+	*dev_ops_tbl = calloc(1, sizeof(struct nbl_dev_ops_tbl));
+	if (!*dev_ops_tbl)
+		return -ENOMEM;
+
+	NBL_DEV_OPS_TBL_TO_OPS(*dev_ops_tbl) = &dev_ops;
+	NBL_DEV_OPS_TBL_TO_PRIV(*dev_ops_tbl) = adapter;
+
+	return 0;
+}
+
+int nbl_dev_init(void *p, __rte_unused const struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt **dev_mgt;
+	struct nbl_dev_ops_tbl **dev_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
+	const struct nbl_product_dev_ops *product_dev_ops = NULL;
+	int ret = 0;
+
+	dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
+	dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
+	chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+	dispatch_ops_tbl = NBL_ADAPTER_TO_DISP_OPS_TBL(adapter);
+	product_dev_ops = nbl_dev_get_product_ops(adapter->caps.product_type);
+
+	*dev_mgt = rte_zmalloc("nbl_dev_mgt", sizeof(struct nbl_dev_mgt), 0);
+	if (*dev_mgt == NULL) {
+		NBL_LOG(ERR, "Failed to allocate nbl_dev_mgt memory");
+		return -ENOMEM;
+	}
+
+	NBL_DEV_MGT_TO_CHAN_OPS_TBL(*dev_mgt) = chan_ops_tbl;
+	NBL_DEV_MGT_TO_DISP_OPS_TBL(*dev_mgt) = dispatch_ops_tbl;
+
+	if (product_dev_ops->dev_init)
+		ret = product_dev_ops->dev_init(adapter);
+
+	if (ret)
+		goto init_dev_failed;
+
+	ret = nbl_dev_setup_ops(dev_ops_tbl, adapter);
+	if (ret)
+		goto set_ops_failed;
+
+	adapter->state = NBL_ETHDEV_INITIALIZED;
+
+	return 0;
+
+set_ops_failed:
+	if (product_dev_ops->dev_uninit)
+		product_dev_ops->dev_uninit(adapter);
+init_dev_failed:
+	rte_free(*dev_mgt);
+	*dev_mgt = NULL;
+	return ret;
+}
+
+void nbl_dev_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt **dev_mgt;
+	struct nbl_dev_ops_tbl **dev_ops_tbl;
+	const struct nbl_product_dev_ops *product_dev_ops = NULL;
+
+	dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
+	dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
+	product_dev_ops = nbl_dev_get_product_ops(adapter->caps.product_type);
+
+	nbl_dev_remove_ops(dev_ops_tbl);
+	if (product_dev_ops->dev_uninit)
+		product_dev_ops->dev_uninit(adapter);
+
+	rte_free(*dev_mgt);
+	*dev_mgt = NULL;
+}
+
+void nbl_dev_stop(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	const struct nbl_product_dev_ops *product_dev_ops = NULL;
+
+	product_dev_ops = nbl_dev_get_product_ops(adapter->caps.product_type);
+	if (product_dev_ops->dev_stop)
+		return product_dev_ops->dev_stop(p);
+}
+
+int nbl_dev_start(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	const struct nbl_product_dev_ops *product_dev_ops = NULL;
+
+	product_dev_ops = nbl_dev_get_product_ops(adapter->caps.product_type);
+	if (product_dev_ops->dev_start)
+		return product_dev_ops->dev_start(p);
+	return 0;
+}
+
+const struct nbl_product_dev_ops nbl_product_dev_ops[NBL_PRODUCT_MAX] = {
+	[NBL_LEONIS_TYPE] = {
+		.dev_init	= nbl_dev_leonis_init,
+		.dev_uninit	= nbl_dev_leonis_uninit,
+		.dev_start	= nbl_dev_leonis_start,
+		.dev_stop	= nbl_dev_leonis_stop,
+	},
+};
+
+const struct nbl_product_dev_ops *nbl_dev_get_product_ops(enum nbl_product_type product_type)
+{
+	RTE_ASSERT(product_type < NBL_PRODUCT_MAX);
+	return &nbl_product_dev_ops[product_type];
+}
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
new file mode 100644
index 0000000000..57c30951f8
--- /dev/null
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEV_H_
+#define _NBL_DEV_H_
+
+#include "nbl_common.h"
+
+#define NBL_DEV_MGT_TO_DISP_OPS_TBL(dev_mgt)	((dev_mgt)->disp_ops_tbl)
+#define NBL_DEV_MGT_TO_DISP_OPS(dev_mgt)	(NBL_DEV_MGT_TO_DISP_OPS_TBL(dev_mgt)->ops)
+#define NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt)	(NBL_DEV_MGT_TO_DISP_OPS_TBL(dev_mgt)->priv)
+#define NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)	((dev_mgt)->chan_ops_tbl)
+#define NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt)	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->ops)
+#define NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt)	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->priv)
+
+struct nbl_dev_mgt {
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+};
+
+const struct nbl_product_dev_ops *nbl_dev_get_product_ops(enum nbl_product_type product_type);
+int nbl_dev_configure(struct rte_eth_dev *eth_dev);
+int nbl_dev_port_start(struct rte_eth_dev *eth_dev);
+int nbl_dev_port_stop(struct rte_eth_dev *eth_dev);
+int nbl_dev_port_close(struct rte_eth_dev *eth_dev);
+
+#endif
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index ed4fd8ee6e..1b399f0bd7 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include "nbl_ethdev.h"
+#include "nbl_dev.h"
 
 RTE_LOG_REGISTER_SUFFIX(nbl_logtype_init, init, INFO);
 RTE_LOG_REGISTER_SUFFIX(nbl_logtype_driver, driver, INFO);
@@ -27,8 +28,11 @@ static int nbl_dev_close(struct rte_eth_dev *eth_dev)
 	return nbl_dev_release_pf(eth_dev);
 }
 
-struct eth_dev_ops nbl_eth_dev_ops = {
-	.dev_close = nbl_dev_close,
+const struct eth_dev_ops nbl_eth_dev_ops = {
+	.dev_configure = nbl_dev_configure,
+	.dev_start = nbl_dev_port_start,
+	.dev_stop = nbl_dev_port_stop,
+	.dev_close = nbl_dev_port_close,
 };
 
 static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dev.h b/drivers/net/nbl/nbl_include/nbl_def_dev.h
new file mode 100644
index 0000000000..a0eba0f57c
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_def_dev.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_DEV_H_
+#define _NBL_DEF_DEV_H_
+
+#include "nbl_include.h"
+
+#define NBL_DEV_OPS_TBL_TO_OPS(dev_ops_tbl)	((dev_ops_tbl)->ops)
+#define NBL_DEV_OPS_TBL_TO_PRIV(dev_ops_tbl)	((dev_ops_tbl)->priv)
+
+struct nbl_dev_ops {
+};
+
+struct nbl_dev_ops_tbl {
+	struct nbl_dev_ops *ops;
+	void *priv;
+};
+
+int nbl_dev_init(void *p, const struct rte_eth_dev *eth_dev);
+void nbl_dev_remove(void *p);
+int nbl_dev_start(void *p);
+void nbl_dev_stop(void *p);
+
+#endif
-- 
2.34.1


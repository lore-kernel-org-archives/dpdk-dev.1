Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D61C7EE32
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 01:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4B9A4068A;
	Fri, 27 Jun 2025 03:40:46 +0200 (CEST)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com
 [115.124.28.123])
 by mails.dpdk.org (Postfix) with ESMTP id 1D5D940650
 for <dev@dpdk.org>; Fri, 27 Jun 2025 03:40:38 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.dXhaq6t_1750988436 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 27 Jun 2025 09:40:37 +0800
From: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v3 09/16] net/nbl: add UIO and VFIO mode for nbl
Date: Thu, 26 Jun 2025 18:40:15 -0700
Message-Id: <20250627014022.4019625-10-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
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

NBL device support UIO/VFIO

Signed-off-by: dimon.zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |  1 +
 drivers/net/nbl/nbl_common/nbl_userdev.c      | 24 +++++++++++++++++++
 drivers/net/nbl/nbl_common/nbl_userdev.h      | 10 ++++++++
 .../nbl_hw_leonis/nbl_phy_leonis_snic.c       |  7 ++++++
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  4 ++++
 5 files changed, 46 insertions(+)
 create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.c
 create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index 7f4abd3db0..8be3100369 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -16,6 +16,7 @@ sources = files(
         'nbl_dispatch.c',
         'nbl_common/nbl_common.c',
         'nbl_common/nbl_thread.c',
+        'nbl_common/nbl_userdev.c',
         'nbl_dev/nbl_dev.c',
         'nbl_hw/nbl_channel.c',
         'nbl_hw/nbl_resource.c',
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
new file mode 100644
index 0000000000..87b943ccd7
--- /dev/null
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_userdev.h"
+
+int nbl_pci_map_device(struct nbl_adapter *adapter)
+{
+	struct rte_pci_device *pci_dev = adapter->pci_dev;
+	int ret = 0;
+
+	ret = rte_pci_map_device(pci_dev);
+	if (ret)
+		NBL_LOG(ERR, "device %s uio or vfio map failed", pci_dev->device.name);
+
+	return ret;
+}
+
+void nbl_pci_unmap_device(struct nbl_adapter *adapter)
+{
+	struct rte_pci_device *pci_dev = adapter->pci_dev;
+
+	return rte_pci_unmap_device(pci_dev);
+}
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.h b/drivers/net/nbl/nbl_common/nbl_userdev.h
new file mode 100644
index 0000000000..11cc29999c
--- /dev/null
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_USERDEV_H_
+#define _NBL_USERDEV_H_
+
+#include "nbl_ethdev.h"
+
+#endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c
index 49ada3b525..9ed375bc1e 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c
@@ -183,6 +183,11 @@ int nbl_phy_init_leonis_snic(void *p)
 	phy_mgt_leonis_snic = (struct nbl_phy_mgt_leonis_snic **)&NBL_ADAPTER_TO_PHY_MGT(adapter);
 	phy_ops_tbl = &NBL_ADAPTER_TO_PHY_OPS_TBL(adapter);
 
+	/* map device */
+	ret = nbl_pci_map_device(adapter);
+	if (ret)
+		return ret;
+
 	*phy_mgt_leonis_snic = rte_zmalloc("nbl_phy_mgt",
 					   sizeof(struct nbl_phy_mgt_leonis_snic), 0);
 	if (!*phy_mgt_leonis_snic) {
@@ -205,6 +210,7 @@ int nbl_phy_init_leonis_snic(void *p)
 setup_ops_failed:
 	rte_free(*phy_mgt_leonis_snic);
 alloc_phy_mgt_failed:
+	nbl_pci_unmap_device(adapter);
 	return ret;
 }
 
@@ -220,4 +226,5 @@ void nbl_phy_remove_leonis_snic(void *p)
 	rte_free(*phy_mgt_leonis_snic);
 
 	nbl_phy_remove_ops(phy_ops_tbl);
+	nbl_pci_unmap_device(adapter);
 }
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index b7955abfab..0b87c3003d 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -48,4 +48,8 @@ void nbl_free_dma_mem(struct nbl_dma_mem *mem);
 int nbl_thread_add_work(struct nbl_work *work);
 void nbl_thread_del_work(struct nbl_work *work);
 
+struct nbl_adapter;
+int nbl_pci_map_device(struct nbl_adapter *adapter);
+void nbl_pci_unmap_device(struct nbl_adapter *adapter);
+
 #endif
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F74BCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 09:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDB0940A6D;
	Fri, 22 Aug 2025 11:04:21 +0200 (CEST)
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com
 [115.124.28.147])
 by mails.dpdk.org (Postfix) with ESMTP id 36C0740676
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:04:14 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eN-JekL_1755853452 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 22 Aug 2025 17:04:12 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v6 09/17] net/nbl: add UIO and VFIO mode for nbl
Date: Fri, 22 Aug 2025 02:03:51 -0700
Message-Id: <20250822090359.614551-10-dimon.zhao@nebula-matrix.com>
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

NBL device support UIO/VFIO

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |  1 +
 drivers/net/nbl/nbl_common/nbl_userdev.c      | 24 +++++++++++++++++++
 drivers/net/nbl/nbl_common/nbl_userdev.h      | 10 ++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c |  7 ++++++
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  4 ++++
 5 files changed, 46 insertions(+)
 create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.c
 create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index bcea1e80fb..1ec36c3d7f 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -16,6 +16,7 @@ sources = files(
         'nbl_core.c',
         'nbl_dispatch.c',
         'nbl_common/nbl_common.c',
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
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
index 52eabaf307..5013323338 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
@@ -182,6 +182,11 @@ int nbl_hw_init_leonis_snic(void *p)
 	hw_mgt_leonis_snic = (struct nbl_hw_mgt_leonis_snic **)&NBL_ADAPTER_TO_HW_MGT(adapter);
 	hw_ops_tbl = &NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
 
+	/* map device */
+	ret = nbl_pci_map_device(adapter);
+	if (ret)
+		return ret;
+
 	*hw_mgt_leonis_snic = rte_zmalloc("nbl_hw_mgt", sizeof(**hw_mgt_leonis_snic), 0);
 	if (!*hw_mgt_leonis_snic) {
 		ret = -ENOMEM;
@@ -203,6 +208,7 @@ int nbl_hw_init_leonis_snic(void *p)
 setup_ops_failed:
 	rte_free(*hw_mgt_leonis_snic);
 alloc_hw_mgt_failed:
+	nbl_pci_unmap_device(adapter);
 	return ret;
 }
 
@@ -218,4 +224,5 @@ void nbl_hw_remove_leonis_snic(void *p)
 	rte_free(*hw_mgt_leonis_snic);
 
 	nbl_hw_remove_ops(hw_ops_tbl);
+	nbl_pci_unmap_device(adapter);
 }
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index df5743e82d..1ab9295d47 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -39,4 +39,8 @@ struct nbl_work {
 void *nbl_alloc_dma_mem(struct nbl_dma_mem *mem, uint32_t size);
 void nbl_free_dma_mem(struct nbl_dma_mem *mem);
 
+struct nbl_adapter;
+int nbl_pci_map_device(struct nbl_adapter *adapter);
+void nbl_pci_unmap_device(struct nbl_adapter *adapter);
+
 #endif
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC9C021A1
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2AE342792;
	Wed, 12 Feb 2025 15:36:37 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 986FA4111B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 15:36:34 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id A11E1554A7A; Wed, 12 Feb 2025 22:36:32 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v11 02/28] net/rnp: add ethdev probe and remove
Date: Wed, 12 Feb 2025 22:35:59 +0800
Message-Id: <1739370987-3989-3-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
References: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
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

Add basic PCIe ethdev probe and remove.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/rnp.h        | 13 +++++++
 drivers/net/rnp/rnp_ethdev.c | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 drivers/net/rnp/rnp.h

diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
new file mode 100644
index 0000000000..6cd717a36e
--- /dev/null
+++ b/drivers/net/rnp/rnp.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+#ifndef __RNP_H__
+#define __RNP_H__
+
+#define PCI_VENDOR_ID_MUCSE	(0x8848)
+#define RNP_DEV_ID_N10G		(0x1000)
+
+struct rnp_eth_port {
+};
+
+#endif /* __RNP_H__ */
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 9ce3c0b497..b71226cb84 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1,3 +1,77 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2023 Mucse IC Design Ltd.
  */
+
+#include <ethdev_pci.h>
+#include <rte_io.h>
+#include <rte_malloc.h>
+
+#include "rnp.h"
+
+static int
+rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(eth_dev);
+
+	return -ENODEV;
+}
+
+static int
+rnp_eth_dev_uninit(struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(eth_dev);
+
+	return -ENODEV;
+}
+
+static int
+rnp_pci_remove(struct rte_pci_device *pci_dev)
+{
+	struct rte_eth_dev *eth_dev;
+	int rc;
+
+	eth_dev = rte_eth_dev_allocated(pci_dev->device.name);
+
+	if (eth_dev) {
+		/* Cleanup eth dev */
+		rc = rte_eth_dev_pci_generic_remove(pci_dev,
+				rnp_eth_dev_uninit);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int
+rnp_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
+{
+	int rc;
+
+	RTE_SET_USED(pci_drv);
+
+	rc = rte_eth_dev_pci_generic_probe(pci_dev, sizeof(struct rnp_eth_port),
+			rnp_eth_dev_init);
+
+	return rc;
+}
+
+static const struct rte_pci_id pci_id_rnp_map[] = {
+	{
+		RTE_PCI_DEVICE(PCI_VENDOR_ID_MUCSE, RNP_DEV_ID_N10G)
+	},
+	{
+		.vendor_id = 0,
+	},
+};
+
+static struct rte_pci_driver rte_rnp_pmd = {
+	.id_table = pci_id_rnp_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
+	.probe = rnp_pci_probe,
+	.remove = rnp_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_rnp, rte_rnp_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_rnp, pci_id_rnp_map);
+RTE_PMD_REGISTER_KMOD_DEP(net_rnp, "igb_uio | uio_pci_generic | vfio-pci");
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E650C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 08:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 433BC42D45;
	Tue, 25 Feb 2025 09:41:34 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 46EB24281D
 for <dev@dpdk.org>; Tue, 25 Feb 2025 09:41:32 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 19EAFAE827; Tue, 25 Feb 2025 16:41:31 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v15 02/29] net/rnp: add ethdev probe and remove
Date: Tue, 25 Feb 2025 16:40:59 +0800
Message-Id: <1740472886-30411-3-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>
References: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>
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
 doc/guides/nics/rnp.rst      | 17 ++++++++++
 drivers/net/rnp/rnp.h        | 16 +++++++++
 drivers/net/rnp/rnp_ethdev.c | 66 ++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/net/rnp/rnp.h

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index b76c60349c..cca249be78 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -14,6 +14,23 @@ Supported Chipsets and NICs
 
 - MUCSE Ethernet Controller N10 Series for 10GbE or 40GbE (Dual-port)
 
+Support of Ethernet Network Controllers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+PCIE NICS
+^^^^^^^^^
+
+* ``N10G-X2-DC .... Dual-port 10 Gigabit SFP Ethernet Adapter``
+* ``N10G-X4-QC .... Quad-port 10 Gigabit SFP Ethernet Adapter``
+* ``N10G-X8-DC .... Octa-port 10 Gigabit SFP Ethernet Adapter``
+
+OCP 3.0 NICs
+^^^^^^^^^^^^
+
+* ``N10G-X2-DCP .... Dual-port 10 Gigabit SFP Ethernet Adapter``
+* ``N10G-X4-DCP .... Dual-port 10 Gigabit SFP Ethernet Adapter``
+* ``N10G-X8-DCP .... Dual-port 10 Gigabit SFP Ethernet Adapter``
+
 Chip Basic Overview
 -------------------
 N10 has two functions, each function support muiple ports(1 to 8),which not same as normal pcie network card(one pf for each port).
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
new file mode 100644
index 0000000000..4413a03d9d
--- /dev/null
+++ b/drivers/net/rnp/rnp.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef __RNP_H__
+#define __RNP_H__
+
+#define PCI_VENDOR_ID_MUCSE	(0x8848)
+#define RNP_DEV_ID_N10G_X2	(0x1000)
+#define RNP_DEV_ID_N10G_X4	(0x1020)
+#define RNP_DEV_ID_N10G_X8	(0x1060)
+
+struct rnp_eth_port {
+};
+
+#endif /* __RNP_H__ */
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 9ce3c0b497..e2eb80ba69 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1,3 +1,69 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2023 Mucse IC Design Ltd.
  */
+
+#include <ethdev_pci.h>
+#include <rte_io.h>
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
+
+	eth_dev = rte_eth_dev_allocated(pci_dev->device.name);
+
+	if (eth_dev)
+		/* Cleanup eth dev */
+		return rte_eth_dev_pci_generic_remove(pci_dev,
+				rnp_eth_dev_uninit);
+	return -ENODEV;
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
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_MUCSE, RNP_DEV_ID_N10G_X2) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_MUCSE, RNP_DEV_ID_N10G_X4) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_MUCSE, RNP_DEV_ID_N10G_X8) },
+	{ .vendor_id = 0, },
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
2.25.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09336C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD9A540395;
	Fri, 28 Mar 2025 06:15:03 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 65BF440299
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:00 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138894t15eej
X-QQ-Originating-IP: +qbqYAKJlZQhLdeE76rvW0zxt3xRLL0OPfeQvw4+B/w=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:14:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16688384082987645965
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 02/29] net/rnp: add ethdev probe and remove
Date: Fri, 28 Mar 2025 05:14:17 +0000
Message-Id: <20250328051444.1019208-3-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: M/ESU50hZOEXtsIDlDyNanqMcrEDY+gcMnLZIM0f1ib99h26LzYhlRHq
 PHB0Ja7PdN+RJHEbo8AiICIE/hu/368hI+uJSNcMwpk09LJiLsZxxArCbKT4DZho5v+9mO7
 kLQ42dJ/TVjTuBA0WX2MnF5yy6OlJSOIf80ssq/206eODHgnmSnNCLQgy4q3OmZGaswi9d8
 vPTYalUyb2xV3L9CiER83nKRrfkEsofGHa1e2l3YJp8twXnejg5KUm6zUFOWuOghbsugzdI
 CFBFKwki25QCqCXfFBg8g1Cv+clrV9tlkIcr2ZDOU6CCdtETxB2qnNn7f4aHSmU+Yn3UfUr
 ISCOoW0eYEytaagGyec1VlbkVidLzWnFAhW22UdNBImrX1jIpfei+UEXB+/yvrLw8+ZeZF8
 SFIJcPEcbg0SCpe94FJfNLD4Vqyl5qPOSB5ANSLcUu+Lcifw9Yf96LYq8D7FeAiQ+AxqJn5
 QxyyThomDxZYTXFR41ReeA33k1eD/PeC5Oc2rFATm98sU7QIWeGDwii9LlHuWPuz8MKd99x
 GUWLUPpS7m75jAQ0UHZX0wninCSuOa0eP3bc74Eb6I3qzwY1lEA6KYSA6CKNiFYfQRsGb6h
 rj+iNOKnmQywS+MaNo4hUXtfdSHppCUswGc5d0sGTm2BHTWQFLdotE7LbvhmyjWRa6W0DMq
 fM4/5wVP7By15DG6FOEk8Z3CfpUHbaUZlm6ZdxWDLRC0qYBJMwksmXcAEQSuQP6/LZHPVsN
 EOAHGp5I5ih1pd/aK6OG+qMZtVuTT8jK2e7+tbbmsy0M7kNW/S/DkdmVwOQKPrWgfdNn19+
 zVCpo+VQ8t/fEegpk6sgZxnXsc0GX/qOHWE7FXyyh/5eVGydqtebYQKV+UwbJ71n+mOCqzn
 9ch16j2TRl+26YnNs7fbsxOxx+LrywbTIP2K88lR8+97u2jTLqsr26sy0BTdUMD24nmeQn1
 oRI+HvbNpYKWzA9q9P6pXSFRXSz2KrZl6BLVEmQ8tLfZxiCFGYtlQKgJJkTNTqeIz2DBfNe
 Ts4BsrvZN1TReznqapsFqKOzeTxKU=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
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
 doc/guides/nics/rnp.rst      | 10 ++++++
 drivers/net/rnp/rnp.h        | 16 +++++++++
 drivers/net/rnp/rnp_ethdev.c | 66 ++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/net/rnp/rnp.h

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index b76c60349c..89c2f64d35 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -14,6 +14,16 @@ Supported Chipsets and NICs
 
 - MUCSE Ethernet Controller N10 Series for 10GbE or 40GbE (Dual-port)
 
+Support of Ethernet Network Controllers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+PCIE NICS
+^^^^^^^^^
+
+* ``N10G-X2-DC .... Dual-port 10 Gigabit SFP Ethernet Adapter``
+* ``N10G-X4-QC .... Quad-port 10 Gigabit SFP Ethernet Adapter``
+* ``N10G-X8-OC .... Octa-port 10 Gigabit SFP Ethernet Adapter``
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


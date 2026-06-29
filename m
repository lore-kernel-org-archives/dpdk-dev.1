Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF17C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:22:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F1F340668;
	Mon, 29 Jun 2026 07:22:18 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A5FB640654
 for <dev@dpdk.org>; Mon, 29 Jun 2026 07:22:13 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B4D81A080B;
 Mon, 29 Jun 2026 07:22:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA31E1A0CD5;
 Mon, 29 Jun 2026 07:18:22 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 11169180007B;
 Mon, 29 Jun 2026 13:18:22 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 6/9] net/enetc: add option to disable VSI messaging
Date: Mon, 29 Jun 2026 10:48:16 +0530
Message-Id: <20260629051819.989176-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260629051819.989176-1-g.singh@nxp.com>
References: <20260623060004.2187716-1-g.singh@nxp.com>
 <20260629051819.989176-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add devarg 'enetc4_vsi_disable' to allow disabling features
dependent on VSI-PSI messaging. This is useful for testing DPDK
with a PF driver that does not support VSI-PSI messages.

When the devarg is present, a reduced ops table
(enetc4_vf_ops_no_vsi_m) is used that replaces link_update with
a no-op stub and omits MAC/VLAN filter ops that require VSI msgs.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/enetc4.rst             | 22 +++++++++-
 doc/guides/rel_notes/release_26_07.rst |  2 +
 drivers/net/enetc/enetc4_vf.c          | 61 ++++++++++++++++++++++++--
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index 866d389..7b94941 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -1,5 +1,5 @@
 .. SPDX-License-Identifier: BSD-3-Clause
-   Copyright 2024-2025 NXP
+   Copyright 2024-2026 NXP
 
 ENETC4 Poll Mode Driver
 =======================
@@ -90,3 +90,23 @@ Driver compilation and testing
 Follow instructions available in the document
 :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
 to launch **testpmd**.
+
+
+Driver Arguments (devargs)
+--------------------------
+
+The ENETC4 PMD supports the following device arguments (devargs)
+that can be passed via ``-a`` (allow-list) option in DPDK applications.
+
+VF-specific devargs
+~~~~~~~~~~~~~~~~~~~
+
+``enetc4_vsi_disable``
+  Disable VSI-PSI messaging for the VF.
+  When present, features that require VSI-PSI communication
+  (link update, MAC filter, VLAN filter) are replaced with no-op stubs.
+  Useful when the PF driver does not support VSI-PSI messages.
+
+  Usage example::
+
+    dpdk-testpmd -a 0000:00:01.0,enetc4_vsi_disable -- -i
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f900145..783ad16 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -191,6 +191,8 @@ New Features
 
   * Added support for ESP packet type in packet parsing.
   * Added scatter-gather support for ENETC4 PFs and VFs.
+  * Added devargs option ``enetc4_vsi_disable`` to disable VSI-PSI
+    messaging.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 9dc4e1d..44c0dc0 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -3,11 +3,14 @@
  */
 
 #include <stdbool.h>
+#include <rte_kvargs.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>
 #include "enetc_logs.h"
 #include "enetc.h"
 
+#define ENETC4_VSI_DISABLE		"enetc4_vsi_disable"
+
 #define ENETC_CRC_TABLE_SIZE		256
 #define ENETC_POLY			0x1021
 #define ENETC_CRC_INIT			0xffff
@@ -687,6 +690,13 @@ enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *re
 	return err;
 }
 
+static int
+enetc4_vf_link_update_dummy(struct rte_eth_dev *dev __rte_unused,
+			    int wait_to_complete __rte_unused)
+{
+	return 0;
+}
+
 static int
 enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
@@ -1148,6 +1158,27 @@ static const struct rte_pci_id pci_vf_id_enetc4_map[] = {
 };
 
 /* Features supported by this driver */
+/* ops table used when VSI messaging is disabled */
+static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
+	.dev_configure        = enetc4_dev_configure,
+	.dev_start            = enetc4_vf_dev_start,
+	.dev_stop             = enetc4_vf_dev_stop,
+	.dev_close            = enetc4_dev_close,
+	.stats_get            = enetc4_vf_stats_get,
+	.dev_infos_get        = enetc4_vf_dev_infos_get,
+	.mtu_set              = enetc4_vf_mtu_set,
+	.link_update	      = enetc4_vf_link_update_dummy,
+	.rx_queue_setup       = enetc4_rx_queue_setup,
+	.rx_queue_start       = enetc4_rx_queue_start,
+	.rx_queue_stop        = enetc4_rx_queue_stop,
+	.rx_queue_release     = enetc4_rx_queue_release,
+	.tx_queue_setup       = enetc4_tx_queue_setup,
+	.tx_queue_start       = enetc4_tx_queue_start,
+	.tx_queue_stop        = enetc4_tx_queue_stop,
+	.tx_queue_release     = enetc4_tx_queue_release,
+	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
+};
+
 static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_configure        = enetc4_dev_configure,
 	.dev_start            = enetc4_vf_dev_start,
@@ -1283,7 +1314,28 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 	struct enetc_hw *enetc_hw = &hw->hw;
 
 	PMD_INIT_FUNC_TRACE();
-	eth_dev->dev_ops = &enetc4_vf_ops;
+
+	/* check if VSI messaging should be disabled via devarg */
+	if (eth_dev->device->devargs) {
+		struct rte_kvargs *kvlist;
+
+		kvlist = rte_kvargs_parse(eth_dev->device->devargs->args,
+					  NULL);
+		if (kvlist) {
+			if (rte_kvargs_count(kvlist, ENETC4_VSI_DISABLE) != 0) {
+				ENETC_PMD_NOTICE("VSI messaging disabled by devarg");
+				eth_dev->dev_ops = &enetc4_vf_ops_no_vsi_m;
+			} else {
+				eth_dev->dev_ops = &enetc4_vf_ops;
+			}
+			rte_kvargs_free(kvlist);
+		} else {
+			eth_dev->dev_ops = &enetc4_vf_ops;
+		}
+	} else {
+		eth_dev->dev_ops = &enetc4_vf_ops;
+	}
+
 	enetc4_dev_hw_init(eth_dev);
 
 	si_cap = enetc_rd(enetc_hw, ENETC_SICAPR0);
@@ -1304,8 +1356,9 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 	ENETC_PMD_DEBUG("port_id %d vendorID=0x%x deviceID=0x%x",
 			eth_dev->data->port_id, pci_dev->id.vendor_id,
 			pci_dev->id.device_id);
-	/* update link */
-	enetc4_vf_link_update(eth_dev, 0);
+	/* update link if VSI messaging is enabled */
+	if (eth_dev->dev_ops == &enetc4_vf_ops)
+		enetc4_vf_link_update(eth_dev, 0);
 
 	return 0;
 }
@@ -1389,4 +1442,6 @@ static struct rte_pci_driver rte_enetc4_vf_pmd = {
 RTE_PMD_REGISTER_PCI(net_enetc4_vf, rte_enetc4_vf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_enetc4_vf, pci_vf_id_enetc4_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* igb_uio | uio_pci_generic");
+RTE_PMD_REGISTER_PARAM_STRING(net_enetc4_vf,
+			      ENETC4_VSI_DISABLE "=<any>");
 RTE_LOG_REGISTER_DEFAULT(enetc4_vf_logtype_pmd, NOTICE);
-- 
2.25.1


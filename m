Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B80CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 10:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 605834028B;
	Fri,  3 Oct 2025 12:24:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5B2DD40262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 12:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759487052; x=1791023052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/5WS8gZ6PRhdvm79pDj5qzibecpbtsCxGckoqQFdGFM=;
 b=DTu6BN/NUfltMQVEWU3uCP+wTbercwFoT8fMgLxFdb4nO2dHJtIlQoV1
 Gcxkke35xhp5bL9sem9NZ5rLoCmlPHwBTmZOQ/pdXLsnsFRv7epf2bYEM
 uvfrOZ/qeT7S5OYiK7eNHi7JwXRi3fSdef6//DBeeySr1Fg2pSIrZKHDf
 qlKG3jSviyedfOgQMcCuV+GAJq9pJgjzC5GhtIp1zbC/1jueE48sxsv6N
 TsPVcmx4gcHI/+7kyvepCelDiz4erZ9LKojA574op1yQNH8XTYnZdnVpQ
 P1kVJjE0/dpVvVVK7wK3apEbSmN8PS943mgbb5gTc3K0NIcG/SiKflsMh Q==;
X-CSE-ConnectionGUID: ioN22FwVTL+WIFt4DVcu/w==
X-CSE-MsgGUID: CkcVfu20QnG7aYUlQvaGMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61931481"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61931481"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 03:24:10 -0700
X-CSE-ConnectionGUID: W4YvEiiNQL+JRNoFP0L6IQ==
X-CSE-MsgGUID: LZl1bgzAQ1C4un7Z2dyI5w==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 03 Oct 2025 03:24:09 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
Subject: [PATCH v2 1/2] net/iavf: support VF initiated resets
Date: Fri,  3 Oct 2025 10:23:58 +0000
Message-Id: <20251003102359.823028-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929143039.547207-1-ciara.loftus@intel.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
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

Introduce a function that allows a VF to request the PF to reset the VF
and then subsequently reinitialise and restart the VF transparently.
This is useful for example when the application detects that one of the
queues have hung or any event where a reset is required and the PF is
unlikely to trigger it.

This commit leverages the existing graceful reset recovery path that was
introduced in commit 3e6a5d2d310a ("net/iavf: add devargs to enable VF
auto-reset").

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
---
v2:
* Always perform the requested reset, regardless of whether the
auto_reset devarg is set or not.
* Don't use the event handler to call iavf_handle_hw_reset. Call it
inline in the rte_pmd_iavf_reset function call.
* Do not send VIRTCHNL_OP_RESET_VF to the adminq before the
iavf_handle_hw_reset sequence. That message is already sent within the
iavf_handle_hw_reset function during iavf_dev_reset.
* Rename the function to rte_pmd_iavf_restore to reflect that it's not
just a reset being performed, but a restoration afterwards too.
---
 drivers/net/intel/iavf/iavf.h         |  4 +++-
 drivers/net/intel/iavf/iavf_ethdev.c  | 10 ++++++--
 drivers/net/intel/iavf/iavf_vchnl.c   | 14 +++++++++++-
 drivers/net/intel/iavf/meson.build    |  1 +
 drivers/net/intel/iavf/rte_pmd_iavf.c | 33 +++++++++++++++++++++++++++
 drivers/net/intel/iavf/rte_pmd_iavf.h | 13 +++++++++++
 6 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 435902fbc2..e38fa66d1a 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -563,6 +563,8 @@ int iavf_flow_sub_check(struct iavf_adapter *adapter,
 			struct iavf_fsub_conf *filter);
 void iavf_dev_watchdog_enable(struct iavf_adapter *adapter);
 void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
-void iavf_handle_hw_reset(struct rte_eth_dev *dev);
+void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
+bool is_iavf_supported(struct rte_eth_dev *dev);
+int iavf_request_restore(struct rte_eth_dev *dev);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 08c814725d..1d665f4af1 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3096,7 +3096,7 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
  * Handle hardware reset
  */
 void
-iavf_handle_hw_reset(struct rte_eth_dev *dev)
+iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_adapter *adapter = dev->data->dev_private;
@@ -3105,7 +3105,8 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev)
 	if (!dev->data->dev_started)
 		return;
 
-	if (!iavf_is_reset_detected(adapter)) {
+	/* If the reset is VF-initated, the reset will be started during iavf_dev_reset */
+	if (!vf_initiated_reset && !iavf_is_reset_detected(adapter)) {
 		PMD_DRV_LOG(DEBUG, "reset not start");
 		return;
 	}
@@ -3212,6 +3213,11 @@ static struct rte_pci_driver rte_iavf_pmd = {
 	.remove = eth_iavf_pci_remove,
 };
 
+bool is_iavf_supported(struct rte_eth_dev *dev)
+{
+	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
+}
+
 RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index b1b7a5bf94..1e3b4716b0 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -83,7 +83,7 @@ iavf_dev_event_handle(void *param __rte_unused)
 			struct iavf_adapter *adapter = pos->dev->data->dev_private;
 			if (pos->event == RTE_ETH_EVENT_INTR_RESET &&
 			    adapter->devargs.auto_reset) {
-				iavf_handle_hw_reset(pos->dev);
+				iavf_handle_hw_reset(pos->dev, false);
 				rte_free(pos);
 				continue;
 			}
@@ -2271,3 +2271,15 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 	rte_spinlock_unlock(&vf->phc_time_aq_lock);
 	return err;
 }
+
+int
+iavf_request_restore(struct rte_eth_dev *dev)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+
+	vf->vf_reset = true;
+	iavf_set_no_poll(dev->data->dev_private, false);
+	iavf_handle_hw_reset(dev, true);
+
+	return 0;
+}
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 0db94d6fe6..b39337733f 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -24,6 +24,7 @@ sources = files(
         'iavf_tm.c',
         'iavf_ipsec_crypto.c',
         'iavf_fsub.c',
+        'rte_pmd_iavf.c',
 )
 
 if arch_subdir == 'x86'
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.c b/drivers/net/intel/iavf/rte_pmd_iavf.c
new file mode 100644
index 0000000000..a9a0225282
--- /dev/null
+++ b/drivers/net/intel/iavf/rte_pmd_iavf.c
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2025 Intel Corporation
+ */
+
+#include <eal_export.h>
+
+#include "iavf.h"
+#include "rte_pmd_iavf.h"
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_restore, 25.11)
+int
+rte_pmd_iavf_restore(uint16_t port)
+{
+	struct rte_eth_dev *dev;
+	int ret;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+
+	if (!is_iavf_supported(dev)) {
+		PMD_DRV_LOG(ERR, "Cannot restore VF, port %u is not an IAVF device.", port);
+		return -ENOTSUP;
+	}
+
+	ret = iavf_request_restore(dev);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Request to restore VF failed for port %u", port);
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
index 04b86a5dd7..50a8cd0070 100644
--- a/drivers/net/intel/iavf/rte_pmd_iavf.h
+++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
@@ -96,6 +96,19 @@ extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_tcp_mask;
 extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask;
 extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
 
+/**
+ * Request PF driver to initiate a PF-to-VF RESET and restore the device
+ * following the reset by reconfiguring and restarting the device. The
+ * port must be started before calling this function.
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @return
+ *   0 if successful, otherwise if a failure occurs
+ */
+__rte_experimental
+int rte_pmd_iavf_restore(uint16_t port);
+
 /**
  * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
  */
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357CFCCD18D
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BBE9402AE;
	Tue, 14 Oct 2025 14:36:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2AD2840288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760445390; x=1791981390;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=70QyDoePauC9t6avm3WPEt+K6LQV3XIPw4/tmuQNDpI=;
 b=j1YQWNU7lbXtyD3KWb0/AmfdkJIqH1tk9DDIPMuf/nL6FPN36Io3p8dz
 sY5TJ7gZYOuS6OsjtS7ruwVWFi/HHUVUBzf7vcI9fa51FSQhw8o7oEiGV
 euQtTCYhKJkI1T/CVSD4f1Vm/lAt6MCkdoQxL+MVe8u/8CxuDtmDxkISd
 VTAKDxCRG8VH7PYoVdgFqP5Edpca550qP8C5kvGGzW3pG5EXXak4GjUOz
 yQJB1GJJul3bnnG4iC+LRBdymQPDs+ZPjFya3ENwYoS2fVEsAbwv5RLVs
 nDJfvtXi9p6iyntKbxDr0/sj95BHlhRqzaqSnhG16K3+1nZrqzlSgkpyF Q==;
X-CSE-ConnectionGUID: QfMOzV5wQMC8TZ3AnPyIow==
X-CSE-MsgGUID: s7Gl2GDwTAWhvV3C0XxojA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62308159"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="62308159"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:36:29 -0700
X-CSE-ConnectionGUID: 4swfZqdGStGJdMWvbvwqLw==
X-CSE-MsgGUID: 8Sn25HpkQS+flkZL+yBpRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181093724"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 14 Oct 2025 05:36:28 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
Subject: [PATCH v4 1/2] net/iavf: support VF initiated resets
Date: Tue, 14 Oct 2025 12:36:23 +0000
Message-Id: <20251014123624.1413473-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009102835.926479-1-ciara.loftus@intel.com>
References: <20251009102835.926479-1-ciara.loftus@intel.com>
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
v4:
* Move the new reinit function to an existing file instead of creating
a new one.
* Rename restore -> reinit

v3:
* Don't set the "vf_reset" flag before iavf_handle_hw_reset. It is only
for cases when the PF has initiated the reset.

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
 drivers/net/intel/iavf/iavf.h         |  3 ++-
 drivers/net/intel/iavf/iavf_ethdev.c  | 30 +++++++++++++++++++++++++--
 drivers/net/intel/iavf/iavf_vchnl.c   |  2 +-
 drivers/net/intel/iavf/rte_pmd_iavf.h | 13 ++++++++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 435902fbc2..3552db7e06 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -563,6 +563,7 @@ int iavf_flow_sub_check(struct iavf_adapter *adapter,
 			struct iavf_fsub_conf *filter);
 void iavf_dev_watchdog_enable(struct iavf_adapter *adapter);
 void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
-void iavf_handle_hw_reset(struct rte_eth_dev *dev);
+void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
+bool is_iavf_supported(struct rte_eth_dev *dev);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 08c814725d..95e5832f03 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -28,6 +28,7 @@
 #include <rte_malloc.h>
 #include <rte_memzone.h>
 #include <dev_driver.h>
+#include <eal_export.h>
 
 #include "iavf.h"
 #include "iavf_rxtx.h"
@@ -3096,7 +3097,7 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
  * Handle hardware reset
  */
 void
-iavf_handle_hw_reset(struct rte_eth_dev *dev)
+iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_adapter *adapter = dev->data->dev_private;
@@ -3105,7 +3106,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev)
 	if (!dev->data->dev_started)
 		return;
 
-	if (!iavf_is_reset_detected(adapter)) {
+	if (!vf_initiated_reset && !iavf_is_reset_detected(adapter)) {
 		PMD_DRV_LOG(DEBUG, "reset not start");
 		return;
 	}
@@ -3141,6 +3142,26 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev)
 	return;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_reinit, 25.11)
+int
+rte_pmd_iavf_reinit(uint16_t port)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+
+	if (!is_iavf_supported(dev)) {
+		PMD_DRV_LOG(ERR, "Cannot reinit VF, port %u is not an IAVF device.", port);
+		return -ENOTSUP;
+	}
+
+	iavf_handle_hw_reset(dev, true);
+
+	return 0;
+}
+
 void
 iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 {
@@ -3212,6 +3233,11 @@ static struct rte_pci_driver rte_iavf_pmd = {
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
index b1b7a5bf94..460035d772 100644
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
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
index 04b86a5dd7..dea1bd2789 100644
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
+int rte_pmd_iavf_reinit(uint16_t port);
+
 /**
  * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
  */
-- 
2.34.1


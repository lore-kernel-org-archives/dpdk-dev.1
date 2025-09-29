Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB0ECAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 14:31:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22F2F4067B;
	Mon, 29 Sep 2025 16:31:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 967CC40668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 16:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759156279; x=1790692279;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K+9wZ6eM789IktAND5OuYSfZwU/nLqQNkyZGdqDRnIY=;
 b=FMUVAcx/jSwWInYf4lbR1cZzEcqHtI5O2jY5tcZY0wfwybMczPuCr+D3
 b1y8BemFvrY7NC7NtEyFP7+SY7MQDtz37r0AJNwkbxbRLpL9UK3D/kTVS
 7C/kEqeUsTWh/9zM+MAbQscQrKTPOqYq8C6YhrYSzOvRjxTe5W6hHWRmy
 XdsFM8vUYkiE8hz99l10Cvgm9ncxJMz3bJcEu2YG7jqld3ds9xlMxZqTa
 Rq5gsa6bPYDyG0FMrnHTfIFW5zp5KZdeobb5ch+M+HFz3xgP9nUGkYl8T
 Y1Ghn+uqwqKc64mh9mSQ/FZYfRkeFV5/CbwTsZ0znpGGtlTQKfR+gHM3d w==;
X-CSE-ConnectionGUID: RACLPhJzQUqCBwArSJQvAA==
X-CSE-MsgGUID: bQ8YTLDJQ5OzLvx0n4w97g==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72076962"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="72076962"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 07:31:14 -0700
X-CSE-ConnectionGUID: JZyswfGARZ6/5ppOjK5adQ==
X-CSE-MsgGUID: B2msc8IBTkyvjnJ+pWCutQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="183440198"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa005.jf.intel.com with ESMTP; 29 Sep 2025 07:31:12 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
Subject: [PATCH 1/2] net/iavf: support VF initiated resets
Date: Mon, 29 Sep 2025 14:30:38 +0000
Message-Id: <20250929143039.547207-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

Introduce a function that allows a VF to request the PF to reset itself.
This is useful for example when the application detects that one of the
queues have hung or any event where a reset is required and the PF is
unlikely to trigger it.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
---
 drivers/net/intel/iavf/iavf.h         |  2 ++
 drivers/net/intel/iavf/iavf_ethdev.c  |  5 ++++
 drivers/net/intel/iavf/iavf_vchnl.c   | 29 +++++++++++++++++++++++
 drivers/net/intel/iavf/meson.build    |  1 +
 drivers/net/intel/iavf/rte_pmd_iavf.c | 33 +++++++++++++++++++++++++++
 drivers/net/intel/iavf/rte_pmd_iavf.h | 11 +++++++++
 6 files changed, 81 insertions(+)
 create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 435902fbc2..6e7aec1bb1 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -565,4 +565,6 @@ void iavf_dev_watchdog_enable(struct iavf_adapter *adapter);
 void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
 void iavf_handle_hw_reset(struct rte_eth_dev *dev);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
+bool is_iavf_supported(struct rte_eth_dev *dev);
+int iavf_request_reset(struct rte_eth_dev *dev);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 08c814725d..996c7274ce 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3212,6 +3212,11 @@ static struct rte_pci_driver rte_iavf_pmd = {
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
index b1b7a5bf94..65afd2c2d5 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -2271,3 +2271,32 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 	rte_spinlock_unlock(&vf->phc_time_aq_lock);
 	return err;
 }
+
+int
+iavf_request_reset(struct rte_eth_dev *dev)
+{
+	struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	struct iavf_cmd_info args;
+	int err = 0;
+
+	args.ops = VIRTCHNL_OP_RESET_VF;
+	args.in_args = NULL;
+	args.in_args_size = 0;
+	args.out_buffer = vf->aq_resp;
+	args.out_size = IAVF_AQ_BUF_SZ;
+
+	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed to execute command of VIRTCHNL_OP_RESET_VF");
+		return err;
+	}
+
+	PMD_DRV_LOG(DEBUG, "VF reset request sent to PF successfully");
+
+	vf->vf_reset = true;
+	iavf_set_no_poll(dev->data->dev_private, false);
+	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET, NULL, 0);
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
index 0000000000..4cb7fe11b8
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_reset, 25.11)
+int
+rte_pmd_iavf_reset(uint16_t port)
+{
+	struct rte_eth_dev *dev;
+	int ret;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+
+	if (!is_iavf_supported(dev)) {
+		PMD_DRV_LOG(ERR, "Cannot reset VF, port %u is not an IAVF device.", port);
+		return -ENOTSUP;
+	}
+
+	ret = iavf_request_reset(dev);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Request to reset VF failed for port %u", port);
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
index 56d453fc4c..1de490a977 100644
--- a/drivers/net/intel/iavf/rte_pmd_iavf.h
+++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
@@ -95,6 +95,17 @@ extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_tcp_mask;
 extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask;
 extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
 
+/**
+ * Request PF driver to initiate a PF-to-VF RESET
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @return
+ *   0 if successful, otherwise if a failure occurs
+ */
+__rte_experimental
+int rte_pmd_iavf_reset(uint16_t port);
+
 /**
  * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
  */
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A0CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E80440668;
	Tue, 30 Sep 2025 09:05:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4D5B640668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 16:00:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759154459; x=1790690459;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=E5bcLVYfRjgtsZk4RoQMm6TXLzD0Gn833UuK3jnWVFI=;
 b=RNL9SvrlAyUcMcIvlYZ2P5zV3vXo0rJ3KdOQAMkORSKQ+tGmVUDioJ3Y
 If5IMxs+nO8+lUBcbmYnL6ot726hMe3EAX0mXTTgm+51W4qqtImeH4ouH
 ERX9WHGDohHC5ndbx0MnT8MCqABDnOHoSlAl6jKMnJAjHcc5FwQm9OTqR
 WHK6WtgP5zAn+eHFas8h+UQr28jdW9C/SRghisuIJwDNavJnWTBJAFFub
 LnOfLwc2IMEnQG6xoR4xlBk9dDhkZeps/6aK0ca5DGcMRDIi4HTr1P52B
 JbQPL78k3CMt8DxX/z3qNb08abButuy6GNrryA6tNyuoiWoEt9ozsWUJg A==;
X-CSE-ConnectionGUID: 8dhlhSJqSPee40HqtpySyA==
X-CSE-MsgGUID: 5JLXP511SjuvpOEMX2KBdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61283216"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="61283216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 07:00:58 -0700
X-CSE-ConnectionGUID: b0wcqGd0RD2GMmdGndNasg==
X-CSE-MsgGUID: 9tBL5hSmTl6ZcTDyB91QDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="201920239"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by fmviesa002.fm.intel.com with ESMTP; 29 Sep 2025 07:00:55 -0700
From: Vemula Venkatesh <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v4] net/intel: add IDPF PCI class ID support
Date: Mon, 29 Sep 2025 19:30:15 +0530
Message-Id: <20250929140015.198615-1-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919145125.113028-1-venkatesh.vemula@intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:06 +0200
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

Current IDPF supports only the MEV device IDs. MMG has new set of
device IDs and same might be the case for the future devices. Instead
of adding new device IDs every time, make use of the IDPF PCI class
ID(0x20001) to differentiate between PF and VF.

Write and read the VF_ARQBAL register to find if the current device is
a PF or a VF.

Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
---
v2:
*Renamed macro RTE_PCI_CLASS name to IDPF_PCI_CLASS.
*Renamed macro IDPF_DEV_ID_CPF to CPFL_DEV_ID_MMG and
 CPFL_DEV_ID_MEV

v3:
*Moved cls_id varible in idpf_hw struct to avoid more struct padding.
*Simplied and moved this check "(hw->device_id == IDPF_DEV_ID_SRIOV)"
 to idpf_is_vf_device function also switch case is removed. returns
 true for VF device and false for PF.
*Simplified the IDPF_CLASS_NETWORK_ETHERNET_PROGIF macro
 logic with detailed fields "PCI_SUB_BASE_CLASS_NETWORK_ETHERNET"
 and PCI_BASE_CLASS_NETWORK_ETHERNET.

v4:
*Fixed code styling errors.
*Removed cls_id varible in the idpf_hw structure no longer needed.
---
 drivers/net/intel/cpfl/cpfl_ethdev.c        |  3 ++-
 drivers/net/intel/cpfl/cpfl_ethdev.h        |  3 ++-
 drivers/net/intel/idpf/idpf_common_device.c | 20 ++++++++++++++++++--
 drivers/net/intel/idpf/idpf_common_device.h | 20 ++++++++++++++++++++
 drivers/net/intel/idpf/idpf_ethdev.c        |  1 +
 5 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 6d7b23ad7a..8cec977ecf 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2606,7 +2606,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 }
 
 static const struct rte_pci_id pci_id_cpfl_map[] = {
-	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_CPF) },
+	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MEV) },
+	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MMG) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index d4e1176ab1..566b395dae 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -59,7 +59,8 @@
 #define CPFL_ALARM_INTERVAL	50000 /* us */
 
 /* Device IDs */
-#define IDPF_DEV_ID_CPF			0x1453
+#define CPFL_DEV_ID_MMG			0x11E0
+#define CPFL_DEV_ID_MEV			0x1453
 #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
 
 #define CPFL_HOST_ID_NUM	2
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index ff1fbcd2b4..3d093e039b 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -130,7 +130,7 @@ idpf_init_mbx(struct idpf_hw *hw)
 	struct idpf_ctlq_info *ctlq;
 	int ret = 0;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV)
+	if (idpf_is_vf_device(hw))
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
 	else
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info);
@@ -389,7 +389,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 	struct idpf_hw *hw = &adapter->hw;
 	int ret;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV) {
+	if (idpf_is_vf_device(hw)) {
 		ret = idpf_check_vf_reset_done(hw);
 	} else {
 		idpf_reset_pf(hw);
@@ -443,6 +443,22 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 	return ret;
 }
 
+#define IDPF_VF_TEST_VAL		0xFEED0000
+
+/**
+ * idpf_is_vf_device - Helper to find if it is a VF/PF device
+ * @hw: idpf_hw struct
+ *
+ * Return: 1 for VF device, 0 for PF device.
+ */
+bool idpf_is_vf_device(struct idpf_hw *hw)
+{
+	if (hw->device_id == IDPF_DEV_ID_SRIOV)
+		return 1;
+	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
+	return IDPF_READ_REG(hw, VF_ARQBAL) == IDPF_VF_TEST_VAL;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
 int
 idpf_adapter_deinit(struct idpf_adapter *adapter)
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 5f3e4a4fcf..0104891fcc 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -44,6 +44,26 @@
 	(sizeof(struct virtchnl2_ptype) +				\
 	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
 
+/** Macro used to help building up tables of device IDs with PCI class */
+#define IDPF_PCI_CLASS(cls)          \
+	.class_id = (cls),      \
+	.vendor_id = RTE_PCI_ANY_ID,  \
+	.device_id = RTE_PCI_ANY_ID,  \
+	.subsystem_vendor_id = RTE_PCI_ANY_ID, \
+	.subsystem_device_id = RTE_PCI_ANY_ID
+
+
+/* PCI Class network ethernet */
+#define PCI_BASE_CLASS_NETWORK_ETHERNET 0x02
+#define PCI_SUB_BASE_CLASS_NETWORK_ETHERNET 0x00
+
+#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
+#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
+(PCI_BASE_CLASS_NETWORK_ETHERNET << 16 | PCI_SUB_BASE_CLASS_NETWORK_ETHERNET << 8 |  \
+IDPF_NETWORK_ETHERNET_PROGIF)
+
+bool idpf_is_vf_device(struct idpf_hw *hw);
+
 struct idpf_adapter {
 	struct idpf_hw hw;
 	struct virtchnl2_version_info virtchnl_version;
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 90720909bf..4118d8d94c 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1313,6 +1313,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 static const struct rte_pci_id pci_id_idpf_map[] = {
 	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_PF) },
 	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_SRIOV) },
+	{ IDPF_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.34.1


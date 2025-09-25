Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB7CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 08:50:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90B1A4066D;
	Fri, 26 Sep 2025 10:50:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9690D4065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 19:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758822469; x=1790358469;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RDkv0F7Aq7UhW9ezCvi03tuNgVSTDKj4XP+lZTYgmUc=;
 b=InXJ0J95O70VvegI68gHhdRBBdC9yI70ZB9TWJ4/Jb7PAbMHYRb745WB
 Z6DHwii8io38hgnBNV5Trs4Ly6zOw1lx/hFhl+PFM7IgBi70KxJzrqBUJ
 i8/nBZEbIRFbfa7lqpqRv9Ki/XdtRjO+BH+Gry+kUuoTHL4NvtlJWrtOl
 wQUy+pUSKDjs1EWcNevndrzaZE72/Yhl0FO+uiwDl5PAx0nKSnBfT8g+2
 6xUguar2KwM7shq8ibPuh1qIw1imAKZCz6ggjlczQV2ThiuSadzEFyIrr
 Bx6y8aWPyQnFjHmZljZSAEEyLpLnblwmVXt/BR/quuAqsaGnKNLn/QwTH A==;
X-CSE-ConnectionGUID: IQNxipI5Sq6XYNeoil9JbA==
X-CSE-MsgGUID: btswKpPiRDyskIveZZ906g==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="64785076"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="64785076"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 10:47:48 -0700
X-CSE-ConnectionGUID: 6XsiUmZFRw60o5Hhnqruzg==
X-CSE-MsgGUID: DB3dP7+oT2GSv39oofIxwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="177845212"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by fmviesa009.fm.intel.com with ESMTP; 25 Sep 2025 10:47:41 -0700
From: Vemula Venkatesh <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v3] net/intel: add IDPF PCI class ID support
Date: Thu, 25 Sep 2025 23:17:07 +0530
Message-Id: <20250925174707.131821-1-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924125749.83507-1-venkatesh.vemula@intel.com>
References: <20250924125749.83507-1-venkatesh.vemula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Sep 2025 10:50:13 +0200
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

v3: addressed reviewers comments.

Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 ++-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  3 ++-
 .../net/intel/idpf/base/idpf_controlq_api.h   |  1 +
 drivers/net/intel/idpf/idpf_common_device.c   | 20 +++++++++++++++++--
 drivers/net/intel/idpf/idpf_common_device.h   | 20 +++++++++++++++++++
 drivers/net/intel/idpf/idpf_ethdev.c          |  2 ++
 6 files changed, 45 insertions(+), 4 deletions(-)

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
diff --git a/drivers/net/intel/idpf/base/idpf_controlq_api.h b/drivers/net/intel/idpf/base/idpf_controlq_api.h
index 8a90258099..bcea789ae9 100644
--- a/drivers/net/intel/idpf/base/idpf_controlq_api.h
+++ b/drivers/net/intel/idpf/base/idpf_controlq_api.h
@@ -179,6 +179,7 @@ struct idpf_hw {
 	struct idpf_hw_func_caps func_caps;
 
 	/* pci info */
+	uint32_t cls_id;
 	u16 device_id;
 	u16 vendor_id;
 	u16 subsystem_device_id;
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index ff1fbcd2b4..357a2c692e 100644
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
+	if (idpf_is_vf_device(hw)){
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
index 5f3e4a4fcf..f6154862da 100644
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
+IDPF_NETWORK_ETHERNET_PROGIF )
+
+bool idpf_is_vf_device(struct idpf_hw *hw);
+
 struct idpf_adapter {
 	struct idpf_hw hw;
 	struct virtchnl2_version_info virtchnl_version;
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 90720909bf..80bf53db0f 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1201,6 +1201,7 @@ idpf_adapter_ext_init(struct rte_pci_device *pci_dev, struct idpf_adapter_ext *a
 	hw->vendor_id = pci_dev->id.vendor_id;
 	hw->device_id = pci_dev->id.device_id;
 	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
+	hw->cls_id = pci_dev->id.class_id;
 
 	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
 
@@ -1313,6 +1314,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 static const struct rte_pci_id pci_id_idpf_map[] = {
 	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_PF) },
 	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_SRIOV) },
+	{ IDPF_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.34.1


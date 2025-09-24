Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E1CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA95040289;
	Wed, 24 Sep 2025 15:18:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3C22B4027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 14:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758718735; x=1790254735;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7L4cGqqHCi0QuZMwbomelOp/3xInoXdIUHvsi/xepuE=;
 b=AqG/66rf1to8kh0+HgxJ4Frfp+8QwHsVExfKNRK4vg5EEre5AsYOtOvi
 c8I1qofGfb4zwxxmau25jQxzYMJKreJLZGRmVSXkADJse8Z2PpYU67q0H
 2tj5mpj7mqznv3xxXpmkeNokaDceESrQF2Q7q6UAEj3vGVuqJqN3NChrm
 A+HIc/3sXIGwCjh5M69ZWl0SiiXFGkmICoUOxndeMN4ODZkl5QdBHrZJV
 wN/Jb+8g1czWTFSJEfm8OIsTpqc+fJvFiRT49VqZd1o+1QcY3i6pwuIT3
 jtcZ+Cyf1p5gGlcC0uK++5mWxUO1SPICCRoBXEnuFdoMWBcmHrM4GDZ0I Q==;
X-CSE-ConnectionGUID: Gn4U+4xrSHOD4qu+oPpb8Q==
X-CSE-MsgGUID: tfIYSCpWTKSKtOz4Nesl0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61183671"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="61183671"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 05:58:51 -0700
X-CSE-ConnectionGUID: EqzK3WgBRlqz5YqrYmtHyg==
X-CSE-MsgGUID: vDyFpUynRoqzAzr4Qe9epg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="182304720"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by fmviesa004.fm.intel.com with ESMTP; 24 Sep 2025 05:58:50 -0700
From: Vemula Venkatesh <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v2] net/intel: add IDPF PCI class ID support
Date: Wed, 24 Sep 2025 18:27:49 +0530
Message-Id: <20250924125749.83507-1-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919145125.113028-1-venkatesh.vemula@intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Sep 2025 15:18:35 +0200
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

v2: addressed reviewers comments.

Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  3 +-
 .../net/intel/idpf/base/idpf_controlq_api.h   |  1 +
 drivers/net/intel/idpf/idpf_common_device.c   | 37 +++++++++++++++++--
 drivers/net/intel/idpf/idpf_common_device.h   | 17 +++++++++
 drivers/net/intel/idpf/idpf_ethdev.c          |  2 +
 6 files changed, 57 insertions(+), 6 deletions(-)

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
index 8a90258099..7c25aabb28 100644
--- a/drivers/net/intel/idpf/base/idpf_controlq_api.h
+++ b/drivers/net/intel/idpf/base/idpf_controlq_api.h
@@ -184,6 +184,7 @@ struct idpf_hw {
 	u16 subsystem_device_id;
 	u16 subsystem_vendor_id;
 	u8 revision_id;
+	uint32_t cls_id;
 	bool adapter_stopped;
 
 	LIST_HEAD_TYPE(list_head, idpf_ctlq_info) cq_list_head;
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index ff1fbcd2b4..6f083770d8 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -125,12 +125,12 @@ struct idpf_ctlq_create_info vf_ctlq_info[IDPF_CTLQ_NUM] = {
 };
 
 static int
-idpf_init_mbx(struct idpf_hw *hw)
+idpf_init_mbx(struct idpf_hw *hw, bool is_vf)
 {
 	struct idpf_ctlq_info *ctlq;
 	int ret = 0;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV)
+	if (is_vf == 1)
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
 	else
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info);
@@ -388,8 +388,21 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 {
 	struct idpf_hw *hw = &adapter->hw;
 	int ret;
+	int err;
+	bool is_vf = 0;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV) {
+	switch (hw->device_id) {
+	case IDPF_DEV_ID_SRIOV:
+			is_vf = 1;
+			break;
+	default:
+			if (hw->cls_id == IDPF_CLASS_NETWORK_ETHERNET_PROGIF) {
+				err = idpf_is_vf_device(hw, &is_vf);
+				if (err)
+					return err;
+			}
+	}
+	if (is_vf) {
 		ret = idpf_check_vf_reset_done(hw);
 	} else {
 		idpf_reset_pf(hw);
@@ -400,7 +413,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 		goto err_check_reset;
 	}
 
-	ret = idpf_init_mbx(hw);
+	ret = idpf_init_mbx(hw, is_vf);
 	if (ret != 0) {
 		DRV_LOG(ERR, "Failed to init mailbox");
 		goto err_check_reset;
@@ -443,6 +456,22 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 	return ret;
 }
 
+#define IDPF_VF_TEST_VAL		0xFEED0000
+
+/**
+ * idpf_is_vf_device - Helper to find if it is a VF device
+ * @pdev: PCI device information struct
+ * @is_vf: used to update VF device status
+ *
+ * Return: 0 on success, errno on failure.
+ */
+int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf)
+{
+	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
+	*is_vf = (IDPF_READ_REG(hw, VF_ARQBAL) == IDPF_VF_TEST_VAL);
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
 int
 idpf_adapter_deinit(struct idpf_adapter *adapter)
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 5f3e4a4fcf..51da8214cb 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -44,6 +44,23 @@
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
+#define PCI_CLASS_NETWORK_ETHERNET  0x0200
+#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
+#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
+	(PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
+
+int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf);
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


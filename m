Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA23CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 06:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D513402ED;
	Mon, 22 Sep 2025 08:34:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 311CD402C5
 for <dev@dpdk.org>; Fri, 19 Sep 2025 16:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758293457; x=1789829457;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TJvHDQGUk117szvE3HuBbWijrCjbBFbv5Rw59aB/Sfk=;
 b=DSn8qy7dtTExTHGfLgeqiXam1HW9gJopAqiRJWI4pouis/ZI2y7XxfGC
 Np5qfiGO/fEOR2hJw1s5F74Mg9GnicqF8qsFcl4uytqk6CYPLWLETFjO3
 wB0VAm3hzXCk2jIKBwy4+Je7+F3qx4aLwRv3j3reexPGQPcUxvrtNzooC
 Iy5uu3M2ckYg9mk8P5yvmA8cncWLsgDy02zezHP0Ijb47fExGEF/nTQkG
 qdiE5mwxKDEHFYQEe2aF3LicGDB15D92yvtBPWKpNOaaDfff+7a/Olghk
 MVD8mv1QKQrqF0gvK75AXMd3pyMqjQ8cLT+QSdTnOmUatwJzym4e3yuZe g==;
X-CSE-ConnectionGUID: Li5yFdpwSo+qfz+Fo/bevg==
X-CSE-MsgGUID: qM9Nh5dhT36Ne5S+xbR4AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="83245893"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; d="scan'208";a="83245893"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 07:50:55 -0700
X-CSE-ConnectionGUID: W95lpvJCSFmrbIAOgZszpg==
X-CSE-MsgGUID: efD6+NLVT16MmkTyt2dUYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; d="scan'208";a="180262998"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by fmviesa005.fm.intel.com with ESMTP; 19 Sep 2025 07:50:53 -0700
From: Vemula Venkatesh <venkatesh.vemula@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1] net/idpf: add IDPF PCI class ID support
Date: Fri, 19 Sep 2025 20:21:25 +0530
Message-Id: <20250919145125.113028-1-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Sep 2025 08:34:50 +0200
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

Current IDPF supports only the MEV device IDs. MMG has new set of device
IDs and same might be the case for the future devices. Instead of adding
new device IDs every time, make use of the IDPF PCI class ID(0x20001) to
differentiate between PF and VF.

Write and read the VF_ARQBAL register to find if the current device is
a PF or a VF.

Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
---
 .../net/intel/idpf/base/idpf_controlq_api.h   |  1 +
 drivers/net/intel/idpf/idpf_common_device.c   | 31 ++++++++++++++++++-
 drivers/net/intel/idpf/idpf_common_device.h   | 17 ++++++++++
 drivers/net/intel/idpf/idpf_ethdev.c          |  2 ++
 4 files changed, 50 insertions(+), 1 deletion(-)

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
index ff1fbcd2b4..4ad94da449 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
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
index 5f3e4a4fcf..9d1d7dc47c 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -44,6 +44,23 @@
 	(sizeof(struct virtchnl2_ptype) +				\
 	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
 
+/** Macro used to help building up tables of device IDs with PCI class */
+#define RTE_PCI_CLASS(cls)          \
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
index 90720909bf..7c1db00562 100644
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
+	{ RTE_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.34.1


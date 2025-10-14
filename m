Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BDACCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 08:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F97F40A73;
	Wed, 15 Oct 2025 10:59:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 88E43402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760437365; x=1791973365;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vEvwpIC5sWdmPr/zlmLaIvh3njRlbfqg43416unm8wY=;
 b=kxKTjk7EOABq4qRUvAUmzeZqlOIQud6gH7R1sd8/VGSfRzXe+OdvPR+S
 tUpHrEV8Vp6OpnI1eORdMEA2X3htU/VmvNm1ptwBNoH7mtsey3AhIxppQ
 IEiLXSqy6gXGE9fG62uv5d5ZFA8NER5qsgPBRfFSjqLM5wIlUZX4dyjQB
 UCWkO4rNeFLs/5RJW2SB6UaUttMuVbdn5XP4JBihdZObDSK4VmedZaAQ8
 5ZEpKOHdJh2mZyQeK4N+OGmoXDHhvuP01rb9c8iIpNAg8uXDm9225ZXpr
 gvYibdRGbSm1qgbKV4v2fGA94QnMmFHeS28si9r0OKXT6LCA59pIr17te Q==;
X-CSE-ConnectionGUID: gDY+EikIQbmTFeHAuiio5w==
X-CSE-MsgGUID: WS/CJVzvT16CntZmNo8GHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="80031853"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="80031853"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 03:22:45 -0700
X-CSE-ConnectionGUID: +YhbNKcQRKer5CTV0Vn7dw==
X-CSE-MsgGUID: uQJgkhN/QXyuwXCJtx1RQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="185863793"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by orviesa003.jf.intel.com with ESMTP; 14 Oct 2025 03:22:43 -0700
From: Venkatesh Vemula <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v7 1/2] net/idpf: add IDPF PCI class ID support
Date: Tue, 14 Oct 2025 15:50:55 +0530
Message-Id: <20251014102056.459175-2-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014102056.459175-1-venkatesh.vemula@intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251014102056.459175-1-venkatesh.vemula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Oct 2025 10:59:31 +0200
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

Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.c | 20 ++++++++++++++++++--
 drivers/net/intel/idpf/idpf_common_device.h | 18 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ethdev.c        |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index 8c637a2fb6..24ee00db23 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -130,7 +130,7 @@ idpf_init_mbx(struct idpf_hw *hw)
 	struct idpf_ctlq_info *ctlq;
 	int ret = 0;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV || hw->device_id == IXD_DEV_ID_VCPF)
+	if (idpf_is_vf_device(hw))
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
 	else
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info);
@@ -389,7 +389,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 	struct idpf_hw *hw = &adapter->hw;
 	int ret;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV || hw->device_id == IXD_DEV_ID_VCPF) {
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
+	if (hw->device_id == IDPF_DEV_ID_SRIOV  || hw->device_id == IXD_DEV_ID_VCPF)
+		return 1;
+	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
+	return IDPF_READ_REG(hw, VF_ARQBAL) == IDPF_VF_TEST_VAL;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
 int
 idpf_adapter_deinit(struct idpf_adapter *adapter)
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index b12bb8d9fc..c32dcfbb12 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -46,6 +46,24 @@
 	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
 
 #define VCPF_CFGQ_VPORT_ID               0xFFFFFFFF
+/** Macro used to help building up tables of device IDs with PCI class */
+#define IDPF_PCI_CLASS(cls)          \
+	.class_id = (cls),      \
+	.vendor_id = RTE_PCI_ANY_ID,  \
+	.device_id = RTE_PCI_ANY_ID,  \
+	.subsystem_vendor_id = RTE_PCI_ANY_ID, \
+	.subsystem_device_id = RTE_PCI_ANY_ID
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
 
 enum idpf_rx_func_type {
 	IDPF_RX_DEFAULT,
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index c04842c9df..411871beeb 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1315,6 +1315,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 static const struct rte_pci_id pci_id_idpf_map[] = {
 	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_PF) },
 	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_SRIOV) },
+	{ IDPF_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.34.1


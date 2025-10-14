Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE50CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D25CF40656;
	Tue, 14 Oct 2025 12:47:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 327484064C
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760438835; x=1791974835;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vEvwpIC5sWdmPr/zlmLaIvh3njRlbfqg43416unm8wY=;
 b=Dja2T7bkCz9GFxD5tN9dmC68wbaWReMy3Rk0+2PWA6gLCqLJo+yoSP7M
 4Eo+RwakNuCEzGaSPRoedlt4Z7grJEoKfNLL8EOCH/PXT7Fj+pxWAZZQy
 NmURJ4K3fSF+NbATx9Lk2Rzgv0w1g+ogsgGz1irEGmYYH203N684DE1bw
 mlBlc81UvScQRuYNTPVbQdiUYFLszA5DyRryyUD68NlDm8412HJb3HKco
 5irZ+3Y2e8gm4/2vTEOVEuyoTPClFbucuM91Sh0tvAaS5gbHDQ93sXpc6
 AE9IrP5yx9y5vN7mX+skuMWqZhIPmyzo2acEoA8xzIm8Nxxuw6fERtqUT A==;
X-CSE-ConnectionGUID: qv32FjrtRE24VBF64jn84g==
X-CSE-MsgGUID: o/6RE4j4TzWuhCFnqeDLzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66450558"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="66450558"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 03:47:15 -0700
X-CSE-ConnectionGUID: lgOZO/x5Qvq1zk88Pp7vdA==
X-CSE-MsgGUID: VUWLivZMQyiJOvF6zOAc7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181660408"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 03:47:13 -0700
From: Venkatesh Vemula <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v7 1/2] net/idpf: add IDPF PCI class ID support
Date: Tue, 14 Oct 2025 16:15:10 +0530
Message-Id: <20251014104511.459215-2-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014104511.459215-1-venkatesh.vemula@intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-1-venkatesh.vemula@intel.com>
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


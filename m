Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E9CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 09:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9803240672;
	Tue, 23 Sep 2025 11:33:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C97854021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 11:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758619996; x=1790155996;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ixdwtMrj9Wwmdoji3DqKXTLiIxMDfYQ4OQ8t4Ir4mtA=;
 b=KI8f6NAeDvqvi8J1S1U4ZeCAsckhpEUPlQTu6e5vQwhAEV9v0t3vQp+v
 z+ErQEwlzUDd8RDqzMlLfgl6DBaNgvKBGzNR4vAB02tT9CFZHtkjJiax4
 wDQgesPVhYdwM3Nw0hDiGbLub3Giz4BvgbqPk0ezcOvG0q9I56FAVSL2E
 AibZ/fXW0fIp1QDzOtb+jBZVfmw1BWQQ9VVNiKTvVxfsDVE8dTvIhIZFe
 mNsUAwn4LVXCAaRm4pBaqJipCHoytr3vBtgoidVNEmOD1wsXq8PUoneDR
 iLG1pAaYJn5aYZWVvPB8ZwOg8BFTSgnLVUf/pVByYJgj1O3lvcqYewqJJ A==;
X-CSE-ConnectionGUID: mKSZjRdPR0ycTzGjyptaNQ==
X-CSE-MsgGUID: FkGdvq+zTLmUKnJPlfGHdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86330412"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="86330412"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 02:33:15 -0700
X-CSE-ConnectionGUID: 2TUX8832R46Wo1iT+QwPNA==
X-CSE-MsgGUID: /qPFdxlrTtqa9GW+oKinJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="176307831"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2025 02:33:04 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>,
 Atul Patel <atul.patel@intel.com>,
 Dhananjay Shukla <dhananjay.shukla@intel.com>
Subject: [PATCH v3 1/4] net/intel: add vCPF PMD support
Date: Tue, 23 Sep 2025 14:54:52 +0200
Message-Id: <20250923125455.1484992-2-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250923125455.1484992-1-praveen.shetty@intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
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

From: Praveen Shetty <praveen.shetty@intel.com>

This patch adds the registration support for a new vCPF PMD.
vCPF PMD is responsible for enabling control and data path
functionality for the CPF VF devices.

Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
Tested-by: Atul Patel  <atul.patel@intel.com>
Tested-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c        | 17 +++++++++++++++++
 drivers/net/intel/cpfl/cpfl_ethdev.h        |  1 +
 drivers/net/intel/idpf/idpf_common_device.c |  4 ++--
 drivers/net/intel/idpf/idpf_common_device.h |  1 +
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 6d7b23ad7a..d6227c99b5 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1854,6 +1854,7 @@ cpfl_handle_virtchnl_msg(struct cpfl_adapter_ext *adapter)
 
 		switch (mbx_op) {
 		case idpf_mbq_opc_send_msg_to_peer_pf:
+		case idpf_mbq_opc_send_msg_to_peer_drv:
 			if (vc_op == VIRTCHNL2_OP_EVENT) {
 				cpfl_handle_vchnl_event_msg(adapter, adapter->base.mbx_resp,
 							    ctlq_msg.data_len);
@@ -2610,6 +2611,11 @@ static const struct rte_pci_id pci_id_cpfl_map[] = {
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
+static const struct rte_pci_id pci_id_vcpf_map[] = {
+	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IXD_DEV_ID_VCPF) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
 static struct cpfl_adapter_ext *
 cpfl_find_adapter_ext(struct rte_pci_device *pci_dev)
 {
@@ -2866,6 +2872,14 @@ static struct rte_pci_driver rte_cpfl_pmd = {
 	.remove		= cpfl_pci_remove,
 };
 
+static struct rte_pci_driver rte_vcpf_pmd = {
+	.id_table	= pci_id_vcpf_map,
+	.drv_flags	= RTE_PCI_DRV_NEED_MAPPING |
+			  RTE_PCI_DRV_PROBE_AGAIN,
+	.probe		= cpfl_pci_probe,
+	.remove		= cpfl_pci_remove,
+};
+
 /**
  * Driver initialization routine.
  * Invoked once at EAL init time.
@@ -2874,6 +2888,9 @@ static struct rte_pci_driver rte_cpfl_pmd = {
 RTE_PMD_REGISTER_PCI(net_cpfl, rte_cpfl_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_cpfl, pci_id_cpfl_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_cpfl, "* igb_uio | vfio-pci");
+RTE_PMD_REGISTER_PCI(net_vcpf, rte_vcpf_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_vcpf, pci_id_vcpf_map);
+RTE_PMD_REGISTER_KMOD_DEP(net_vcpf, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_cpfl,
 	CPFL_TX_SINGLE_Q "=<0|1> "
 	CPFL_RX_SINGLE_Q "=<0|1> "
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index d4e1176ab1..2cfcdd6206 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -60,6 +60,7 @@
 
 /* Device IDs */
 #define IDPF_DEV_ID_CPF			0x1453
+#define IXD_DEV_ID_VCPF			0x1203
 #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
 
 #define CPFL_HOST_ID_NUM	2
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index ff1fbcd2b4..8c637a2fb6 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -130,7 +130,7 @@ idpf_init_mbx(struct idpf_hw *hw)
 	struct idpf_ctlq_info *ctlq;
 	int ret = 0;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV)
+	if (hw->device_id == IDPF_DEV_ID_SRIOV || hw->device_id == IXD_DEV_ID_VCPF)
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
 	else
 		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info);
@@ -389,7 +389,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 	struct idpf_hw *hw = &adapter->hw;
 	int ret;
 
-	if (hw->device_id == IDPF_DEV_ID_SRIOV) {
+	if (hw->device_id == IDPF_DEV_ID_SRIOV || hw->device_id == IXD_DEV_ID_VCPF) {
 		ret = idpf_check_vf_reset_done(hw);
 	} else {
 		idpf_reset_pf(hw);
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 5f3e4a4fcf..d536ce7e15 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -11,6 +11,7 @@
 #include "idpf_common_logs.h"
 
 #define IDPF_DEV_ID_SRIOV	0x145C
+#define IXD_DEV_ID_VCPF         0x1203
 
 #define IDPF_RSS_KEY_LEN	52
 
-- 
2.37.3


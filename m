Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F02C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 13:54:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79350402C6;
	Mon, 17 Feb 2025 14:54:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id CA686402B5
 for <dev@dpdk.org>; Mon, 17 Feb 2025 14:54:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739800457; x=1771336457;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Vl2AURd6umAtdlBYvLJtHJ0cXVOO1U5ZWq3UkVDDB1I=;
 b=noRrTQ8bkU5clqw8EhOlCCqqFh4FBaDVgf99cIB7g94tijT9To1Z/izY
 H5W/7XnqjYs4uIY3I7gkqZE5Prs8un1NdQchYhSq1SsDC7JE1I/ena5ui
 5SdDIKTE5hFzUCUo0ptCVnDQ3TfleL07AIaXna2oePPlsBlH4ac+6jBdC
 lhSGn7L67GFqeia7zlvuo80f15pT5l4TdViIFrc5clcuCNAokxN07IcbG
 ox9zKHF3AbBtIqkBEn964LIyG7LfURnPVBN2fYyg2x/x5bReaHlayOak+
 Uzl6kb33ktrQAKeAzKgyREVsAW30nYPE/pq0OVGTn6+NCCOsjJrrXH1O+ A==;
X-CSE-ConnectionGUID: E8Xuk5xtQbWFwNEQgIgoEg==
X-CSE-MsgGUID: fIGciQgxSwug3HX3BT7xlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39712999"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="39712999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 05:54:16 -0800
X-CSE-ConnectionGUID: 27lhGbeuQgmRaPlzohwPIw==
X-CSE-MsgGUID: ex4QVo17S+aR6c1+fNSqgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115015615"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa008.jf.intel.com with ESMTP; 17 Feb 2025 05:54:14 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v2 3/4] net/e1000: prevent crashes in secondary processes
Date: Mon, 17 Feb 2025 13:54:07 +0000
Message-ID: <421d8b0458f2ab9912413705247cef7b1c593ff4.1739800426.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cd3ef1f143afdef81cf7086bf0e6a3e49c43fbff.1739800426.git.anatoly.burakov@intel.com>
References: <3c323577ce36cf4425d2c2def85d0d6644b87dc8.1734020337.git.anatoly.burakov@intel.com>
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

Currently, the architecture of e1000 base driver is such that it uses
function pointers internally. These are not guaranteed to be valid in
secondary processes, which can lead to crashes. This patch prevents IGC
ethdev driver from calling into these functions.

Fixes: 4f09bc55ac3d ("net/igc: implement device base operations")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/nics/igc.rst              |  5 ++
 drivers/net/intel/e1000/igc_ethdev.c | 97 ++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/doc/guides/nics/igc.rst b/doc/guides/nics/igc.rst
index c267431c5f..9790b58102 100644
--- a/doc/guides/nics/igc.rst
+++ b/doc/guides/nics/igc.rst
@@ -104,3 +104,8 @@ Add a rule to enable ipv4-udp RSS:
 .. code-block:: console
 
    testpmd> flow create 0 ingress pattern end actions rss types ipv4-udp end / end
+
+Secondary Process Support
+-------------------------
+
+Control plane operations are currently not supported in secondary processes.
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 136f5af2a0..e712cfcf7c 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -12,6 +12,7 @@
 #include <ethdev_pci.h>
 #include <rte_malloc.h>
 #include <rte_alarm.h>
+#include <rte_errno.h>
 
 #include "e1000_logs.h"
 #include "igc_txrx.h"
@@ -397,6 +398,14 @@ eth_igc_set_link_up(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (hw->phy.media_type == e1000_media_type_copper)
 		e1000_power_up_phy(hw);
 	else
@@ -409,6 +418,14 @@ eth_igc_set_link_down(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (hw->phy.media_type == e1000_media_type_copper)
 		e1000_power_down_phy(hw);
 	else
@@ -482,6 +499,14 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 	struct rte_eth_link link;
 	int link_check, count;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	link_check = 0;
 	hw->mac.get_link_status = 1;
 
@@ -659,6 +684,14 @@ eth_igc_stop(struct rte_eth_dev *dev)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rte_eth_link link;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	dev->data->dev_started = 0;
 	adapter->stopped = 1;
 
@@ -970,6 +1003,14 @@ eth_igc_start(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	/* disable all MSI-X interrupts */
 	E1000_WRITE_REG(hw, E1000_EIMC, 0x1f);
 	E1000_WRITE_FLUSH(hw);
@@ -1553,6 +1594,14 @@ eth_igc_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 	struct e1000_fw_version fw;
 	int ret;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	e1000_get_fw_version(hw, &fw);
 
 	/* if option rom is valid, display its version too */
@@ -1643,6 +1692,14 @@ eth_igc_led_on(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	return e1000_led_on(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
 
@@ -1651,6 +1708,14 @@ eth_igc_led_off(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	return e1000_led_off(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
 
@@ -2194,6 +2259,10 @@ eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (rte_intr_allow_others(intr_handle))
 		vec = IGC_RX_VEC_START;
 
@@ -2213,6 +2282,10 @@ eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (rte_intr_allow_others(intr_handle))
 		vec = IGC_RX_VEC_START;
 
@@ -2276,6 +2349,14 @@ eth_igc_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	uint32_t rctl;
 	int err;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (fc_conf->autoneg != hw->mac.autoneg)
 		return -ENOTSUP;
 
@@ -2777,6 +2858,14 @@ eth_igc_timesync_read_rx_timestamp(__rte_unused struct rte_eth_dev *dev,
 	struct igc_rx_queue *rxq;
 	uint64_t rx_timestamp;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	/* Get current link speed. */
 	eth_igc_link_update(dev, 1);
 	rte_eth_linkstatus_get(dev, &link);
@@ -2813,6 +2902,14 @@ eth_igc_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 	uint64_t tx_timestamp;
 	int adjust = 0;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	val = E1000_READ_REG(hw, E1000_TSYNCTXCTL);
 	if (!(val & E1000_TSYNCTXCTL_VALID))
 		return -EINVAL;
-- 
2.43.5


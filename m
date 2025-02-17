Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE85C021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 13:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35A2D400EF;
	Mon, 17 Feb 2025 14:54:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D54C3400D5
 for <dev@dpdk.org>; Mon, 17 Feb 2025 14:54:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739800454; x=1771336454;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iF9IIvK7SaovxLrST0VmmaK44jf2XXrhIPYfyMpd0GA=;
 b=ABHuns2bixxRj9hrNqUnQBjwiK33/Do/NLfb8a1r2LH6AtzZQWHMMulf
 AfaI4e9UJiZZG4vu3T7lgGFMs2PKw/n385dcgyjI7H4tElruytuGh5eZg
 gdEeQVWrbinCvsPj+745RkggGSdy/7giC7/8dmhlQlwm8vSDPReu19799
 KMmf28of0U827nqAUqyI65z+qdhZrg5z/NAlJTpiXipUKd8Kszq7bfZMh
 uboQRhvjICl4MLRnYQULAEejTygoKyYC8QE6INGVXasQQ6O9Kj7REkVMh
 GXL9O9SUgD49hyrRUFkQZR+vIwjeCN4tOZjUJckqmHoFIwez6ckcy9hlI A==;
X-CSE-ConnectionGUID: c6zINT50TEqmTPfk3Nd3tw==
X-CSE-MsgGUID: KKDH0E3TQlqXhaHiDFUMuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39712992"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="39712992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 05:54:12 -0800
X-CSE-ConnectionGUID: OMiB0nGSQsCorvI47jflhQ==
X-CSE-MsgGUID: hE3LLzM1Q8SwSTOPDSW+6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115015599"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa008.jf.intel.com with ESMTP; 17 Feb 2025 05:54:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 1/4] net/e1000: prevent crashes in secondary processes
Date: Mon, 17 Feb 2025 13:54:05 +0000
Message-ID: <cd3ef1f143afdef81cf7086bf0e6a3e49c43fbff.1739800426.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <3c323577ce36cf4425d2c2def85d0d6644b87dc8.1734020337.git.anatoly.burakov@intel.com>
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
secondary processes, which can lead to crashes. This patch prevents EM
ethdev driver from calling into these functions.

Fixes: 805803445a02 ("e1000: support EM devices (also known as e1000/e1000e)")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/nics/e1000em.rst         |  5 ++
 drivers/net/intel/e1000/em_ethdev.c | 80 +++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
index 5e752a29e5..ed4f57e9c6 100644
--- a/doc/guides/nics/e1000em.rst
+++ b/doc/guides/nics/e1000em.rst
@@ -153,3 +153,8 @@ The following are known limitations:
 #.  Qemu e1000 only supports one interrupt source, so link and Rx interrupt should be exclusive.
 
 #.  Qemu e1000 does not support interrupt auto-clear, application should disable interrupt immediately when woken up.
+
+Secondary Process Support
+-------------------------
+
+Control plane operations are currently not supported in secondary processes.
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index bd3f7e44df..39dddf3384 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -573,6 +573,14 @@ eth_em_start(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	ret = eth_em_stop(dev);
 	if (ret != 0)
 		return ret;
@@ -757,6 +765,14 @@ eth_em_stop(struct rte_eth_dev *dev)
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	dev->data->dev_started = 0;
 
 	eth_em_rxtx_control(dev, false);
@@ -1048,6 +1064,10 @@ eth_em_rx_queue_intr_enable(struct rte_eth_dev *dev, __rte_unused uint16_t queue
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	em_rxq_intr_enable(hw);
 	rte_intr_ack(intr_handle);
 
@@ -1059,6 +1079,10 @@ eth_em_rx_queue_intr_disable(struct rte_eth_dev *dev, __rte_unused uint16_t queu
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	em_rxq_intr_disable(hw);
 
 	return 0;
@@ -1688,6 +1712,14 @@ eth_em_led_on(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	return e1000_led_on(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
@@ -1697,6 +1729,14 @@ eth_em_led_off(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	return e1000_led_off(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
@@ -1758,6 +1798,14 @@ eth_em_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	uint32_t max_high_water;
 	uint32_t rctl;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	if (fc_conf->autoneg != hw->mac.autoneg)
 		return -ENOTSUP;
@@ -1809,6 +1857,14 @@ eth_em_rar_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	return e1000_rar_set(hw, mac_addr->addr_bytes, index);
 }
 
@@ -1818,6 +1874,14 @@ eth_em_rar_clear(struct rte_eth_dev *dev, uint32_t index)
 	uint8_t addr[RTE_ETHER_ADDR_LEN];
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return;
+
 	memset(addr, 0, sizeof(addr));
 
 	e1000_rar_set(hw, addr, index);
@@ -1827,6 +1891,14 @@ static int
 eth_em_default_mac_addr_set(struct rte_eth_dev *dev,
 			    struct rte_ether_addr *addr)
 {
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	eth_em_rar_clear(dev, 0);
 
 	return eth_em_rar_set(dev, (void *)addr, 0, 0);
@@ -1871,6 +1943,14 @@ eth_em_set_mc_addr_list(struct rte_eth_dev *dev,
 {
 	struct e1000_hw *hw;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	e1000_update_mc_addr_list(hw, (u8 *)mc_addr_set, nb_mc_addr);
 	return 0;
-- 
2.43.5


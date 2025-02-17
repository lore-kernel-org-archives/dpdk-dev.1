Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C85C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 13:54:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CDC4402A0;
	Mon, 17 Feb 2025 14:54:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id A64E6400D5
 for <dev@dpdk.org>; Mon, 17 Feb 2025 14:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739800455; x=1771336455;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=wMe/LLQxjIeEgzJLJ6r0OdvKeBn+CPH5ovW2wNs63AQ=;
 b=hUWPWCf1aUbJ0NW69akkbe8lk5mba5kHzXwLSIElwJIMOleCaFU6dq+f
 bKym54HCb0fJzgr1yGxFbaprX3k/m2E2xHLCoGttVFvCfpxIap1ls/tRl
 LzcngU3wPpjsL/eUvoDEbNUE4bVoorng2ZgzJ3TS77+/9zOypl+uLBGqG
 KgYZLdhjQA/kw2Qvj6O/Bg5izt7WlH6bABh55FoGMvn6RKm2RvJV/LQfk
 9N5AkwKVpVh5QmEH7Sc/gcwGOj+HhIIOlHXTdOvJJ5Z/u4yz0kZqCEol+
 7F+UcZGCMZnCkZcuxe2PUH9LIeVdiSOe6tD3qT1RNJN0n0DPPmQN+CzZ1 w==;
X-CSE-ConnectionGUID: KwhSGtPBTbu78efaU8SoOA==
X-CSE-MsgGUID: vBL0KNmvQya9n75YmhyVbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39712995"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="39712995"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 05:54:14 -0800
X-CSE-ConnectionGUID: QIUwdR6XQlyZyOFeI0f/7g==
X-CSE-MsgGUID: TE5G2zMoRIOLKZoWgFtUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115015602"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa008.jf.intel.com with ESMTP; 17 Feb 2025 05:54:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 2/4] net/e1000: prevent crashes in secondary processes
Date: Mon, 17 Feb 2025 13:54:06 +0000
Message-ID: <826ae61846fe7a60ef9ce55917d21292b1ce3a6a.1739800426.git.anatoly.burakov@intel.com>
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
secondary processes, which can lead to crashes. This patch prevents IGB
ethdev driver from calling into these functions.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/nics/igb.rst              |  13 ++
 drivers/net/intel/e1000/igb_ethdev.c | 176 +++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/doc/guides/nics/igb.rst b/doc/guides/nics/igb.rst
index e3a91c316b..3f7a4156ff 100644
--- a/doc/guides/nics/igb.rst
+++ b/doc/guides/nics/igb.rst
@@ -31,3 +31,16 @@ Features of the IGB PMD are:
 * Checksum offload
 * TCP segmentation offload
 * Jumbo frames supported
+
+Secondary Process Support
+-------------------------
+
+IGB Physical Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Control plane operations are currently not supported in secondary processes.
+
+IGB Virtual Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Control plane operations are currently not supported in secondary processes.
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index be3123572f..cbd2f15f5f 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -1248,6 +1248,14 @@ eth_igb_start(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	/* disable uio/vfio intr/eventfd mapping */
 	rte_intr_disable(intr_handle);
 
@@ -1471,6 +1479,14 @@ eth_igb_stop(struct rte_eth_dev *dev)
 	struct e1000_adapter *adapter =
 		E1000_DEV_PRIVATE(dev->data->dev_private);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (adapter->stopped)
 		return 0;
 
@@ -1524,6 +1540,14 @@ eth_igb_dev_set_link_up(struct rte_eth_dev *dev)
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
 	if (hw->phy.media_type == e1000_media_type_copper)
 		e1000_power_up_phy(hw);
 	else
@@ -1537,6 +1561,14 @@ eth_igb_dev_set_link_down(struct rte_eth_dev *dev)
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
 	if (hw->phy.media_type == e1000_media_type_copper)
 		e1000_power_down_phy(hw);
 	else
@@ -2158,6 +2190,14 @@ eth_igb_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
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
 
 	switch (hw->mac.type) {
@@ -2406,6 +2446,14 @@ eth_igb_link_update(struct rte_eth_dev *dev, int wait_to_complete)
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
 
@@ -3028,6 +3076,14 @@ eth_igb_led_on(struct rte_eth_dev *dev)
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
@@ -3037,6 +3093,14 @@ eth_igb_led_off(struct rte_eth_dev *dev)
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
@@ -3099,6 +3163,14 @@ eth_igb_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	uint32_t rctl;
 	uint32_t ctrl;
 
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
@@ -3185,6 +3257,14 @@ eth_igb_rar_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t rah;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	e1000_rar_set(hw, mac_addr->addr_bytes, index);
 	rah = E1000_READ_REG(hw, E1000_RAH(index));
 	rah |= (0x1 << (E1000_RAH_POOLSEL_SHIFT + pool));
@@ -3198,6 +3278,14 @@ eth_igb_rar_clear(struct rte_eth_dev *dev, uint32_t index)
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
@@ -3207,6 +3295,14 @@ static int
 eth_igb_default_mac_addr_set(struct rte_eth_dev *dev,
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
 	eth_igb_rar_clear(dev, 0);
 	eth_igb_rar_set(dev, (void *)addr, 0, 0);
 
@@ -3340,6 +3436,14 @@ igbvf_dev_start(struct rte_eth_dev *dev)
 	int ret;
 	uint32_t intr_vector = 0;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	PMD_INIT_FUNC_TRACE();
 
 	hw->mac.ops.reset_hw(hw);
@@ -3396,6 +3500,14 @@ igbvf_dev_stop(struct rte_eth_dev *dev)
 	struct e1000_adapter *adapter =
 		E1000_DEV_PRIVATE(dev->data->dev_private);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (adapter->stopped)
 		return 0;
 
@@ -3468,6 +3580,14 @@ igbvf_promiscuous_enable(struct rte_eth_dev *dev)
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
 	/* Set both unicast and multicast promisc */
 	e1000_promisc_set_vf(hw, e1000_promisc_enabled);
 
@@ -3479,6 +3599,14 @@ igbvf_promiscuous_disable(struct rte_eth_dev *dev)
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
 	/* If in allmulticast mode leave multicast promisc */
 	if (dev->data->all_multicast == 1)
 		e1000_promisc_set_vf(hw, e1000_promisc_multicast);
@@ -3493,6 +3621,14 @@ igbvf_allmulticast_enable(struct rte_eth_dev *dev)
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
 	/* In promiscuous mode multicast promisc already set */
 	if (dev->data->promiscuous == 0)
 		e1000_promisc_set_vf(hw, e1000_promisc_multicast);
@@ -3505,6 +3641,14 @@ igbvf_allmulticast_disable(struct rte_eth_dev *dev)
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
 	/* In promiscuous mode leave multicast promisc enabled */
 	if (dev->data->promiscuous == 0)
 		e1000_promisc_set_vf(hw, e1000_promisc_disabled);
@@ -4608,6 +4752,14 @@ eth_igb_set_mc_addr_list(struct rte_eth_dev *dev,
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
@@ -5056,6 +5208,14 @@ eth_igb_get_eeprom(struct rte_eth_dev *dev,
 	uint16_t *data = in_eeprom->data;
 	int first, length;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	first = in_eeprom->offset >> 1;
 	length = in_eeprom->length >> 1;
 	if ((first >= hw->nvm.word_size) ||
@@ -5080,6 +5240,14 @@ eth_igb_set_eeprom(struct rte_eth_dev *dev,
 	uint16_t *data = in_eeprom->data;
 	int first, length;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	first = in_eeprom->offset >> 1;
 	length = in_eeprom->length >> 1;
 	if ((first >= hw->nvm.word_size) ||
@@ -5180,6 +5348,10 @@ eth_igb_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = E1000_MISC_VEC_ID;
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (rte_intr_allow_others(intr_handle))
 		vec = E1000_RX_VEC_START;
 
@@ -5200,6 +5372,10 @@ eth_igb_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = E1000_MISC_VEC_ID;
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (rte_intr_allow_others(intr_handle))
 		vec = E1000_RX_VEC_START;
 
-- 
2.43.5


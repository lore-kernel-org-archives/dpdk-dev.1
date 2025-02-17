Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BDAC021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 13:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 580E2402DD;
	Mon, 17 Feb 2025 14:54:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5412F402C3
 for <dev@dpdk.org>; Mon, 17 Feb 2025 14:54:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739800458; x=1771336458;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rnOy+T3Xp2ADS5p2yQoeax2oVjGhNgf6TXQ1Qjpkiko=;
 b=mFAuSO8uUxRX4u0r43NwLc5b1pCqBcRd8LoBLvCF7EnpZP8jajj+vT+r
 NTNt3FLlwSCMz6Pio7Ul/aPInMVMTm4e9NHppQwykeYXA2TnHvZRmxbVm
 OhT2Two8ysB2394RUpTO1ulbj8Cf4bRu7I+7/s5GxOzbVsPSkyt1SBlw/
 Jjrhww/w8Bar8LTswBYZmqpxPXuOB75lbEIkkqhY779gCU7b2zpVRobh7
 3A5rV8O+i6cedTPaim4gRrTRf6PJKgR7m3cXS47wyF6PRdmhBmPC6ttX5
 tGh0r6YADjJMOtIjrXBTL7z8dOpR+0Ohtyo49tbDBfTBcXZzJWNLCyXhQ A==;
X-CSE-ConnectionGUID: kUNT+9cKToiDZLPQ4HruAA==
X-CSE-MsgGUID: rR+YZNbBTAG3hQ0wbPkfcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39713001"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="39713001"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 05:54:18 -0800
X-CSE-ConnectionGUID: MnaQose+TUWreXwZzx35Xw==
X-CSE-MsgGUID: qqVy3J8RT6KzGKQ+hFy+0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115015630"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa008.jf.intel.com with ESMTP; 17 Feb 2025 05:54:16 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 4/4] net/ixgbe: prevent crashes in secondary processes
Date: Mon, 17 Feb 2025 13:54:08 +0000
Message-ID: <11dadf1bf66aa2129a08b588b68ec0a8c992cfaa.1739800426.git.anatoly.burakov@intel.com>
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

Currently, the architecture of IXGBE base driver is such that it uses
function pointers internally. These are not guaranteed to be valid in
secondary processes, which can lead to crashes. This patch prevents IXGBE
ethdev driver from calling into these functions.

Bugzilla ID: 1575

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/nics/ixgbe.rst              |  14 ++
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 242 +++++++++++++++++++++++++
 2 files changed, 256 insertions(+)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index c5c6a6c34b..8dcde7ae1c 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -459,3 +459,17 @@ show bypass config
 Show the bypass configuration for a bypass enabled NIC using the lowest port on the NIC::
 
    testpmd> show bypass config (port_id)
+
+
+Secondary Process Support
+-------------------------
+
+IXGBE Physical Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Control plane operations are currently not supported in secondary processes.
+
+IXGBE Virtual Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Control plane operations are currently not supported in secondary processes.
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 6cb25778cc..b80d5894f8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2630,6 +2630,14 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	struct ixgbe_macsec_setting *macsec_setting =
 		IXGBE_DEV_PRIVATE_TO_MACSEC_SETTING(dev->data->dev_private);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	PMD_INIT_FUNC_TRACE();
 
 	/* Stop the link setup handler before resetting the HW. */
@@ -2918,6 +2926,14 @@ ixgbe_dev_stop(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	ixgbe_dev_wait_setup_link_complete(dev, 0);
 
 	/* disable interrupts */
@@ -2980,6 +2996,15 @@ ixgbe_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (hw->mac.type == ixgbe_mac_82599EB) {
 #ifdef RTE_LIBRTE_IXGBE_BYPASS
 		if (hw->device_id == IXGBE_DEV_ID_82599_BYPASS) {
@@ -3011,6 +3036,15 @@ ixgbe_dev_set_link_down(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (hw->mac.type == ixgbe_mac_82599EB) {
 #ifdef RTE_LIBRTE_IXGBE_BYPASS
 		if (hw->device_id == IXGBE_DEV_ID_82599_BYPASS) {
@@ -3879,6 +3913,14 @@ ixgbe_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 	struct ixgbe_nvm_version nvm_ver;
 	int ret;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	ixgbe_get_oem_prod_version(hw, &nvm_ver);
 	if (nvm_ver.oem_valid) {
 		snprintf(fw_version, fw_size, "%x.%x.%x",
@@ -4789,6 +4831,14 @@ ixgbe_dev_led_on(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	return ixgbe_led_on(hw, 0) == IXGBE_SUCCESS ? 0 : -ENOTSUP;
 }
@@ -4798,6 +4848,14 @@ ixgbe_dev_led_off(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	return ixgbe_led_off(hw, 0) == IXGBE_SUCCESS ? 0 : -ENOTSUP;
 }
@@ -4871,6 +4929,14 @@ ixgbe_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 		ixgbe_fc_full
 	};
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	PMD_INIT_FUNC_TRACE();
 
 	hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -5076,6 +5142,14 @@ ixgbe_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *p
 		ixgbe_fc_full
 	};
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	PMD_INIT_FUNC_TRACE();
 
 	ixgbe_dcb_unpack_map_cee(dcb_config, IXGBE_DCB_RX_CONFIG, map);
@@ -5224,6 +5298,14 @@ ixgbe_add_rar(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t enable_addr = 1;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	return ixgbe_set_rar(hw, index, mac_addr->addr_bytes,
 			     pool, enable_addr);
 }
@@ -5233,6 +5315,14 @@ ixgbe_remove_rar(struct rte_eth_dev *dev, uint32_t index)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return;
+
 	ixgbe_clear_rar(hw, index);
 }
 
@@ -5241,6 +5331,14 @@ ixgbe_set_default_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	ixgbe_remove_rar(dev, 0);
 	ixgbe_add_rar(dev, addr, 0, pci_dev->max_vfs);
 
@@ -5400,6 +5498,14 @@ ixgbevf_dev_start(struct rte_eth_dev *dev)
 
 	int err, mask = 0;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	PMD_INIT_FUNC_TRACE();
 
 	/* Stop the link setup handler before resetting the HW. */
@@ -5503,6 +5609,14 @@ ixgbevf_dev_stop(struct rte_eth_dev *dev)
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
 	if (hw->adapter_stopped)
 		return 0;
 
@@ -5618,6 +5732,14 @@ ixgbevf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 	uint32_t vid_bit = 0;
 	int ret = 0;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	PMD_INIT_FUNC_TRACE();
 
 	/* vind is not used in VF driver, set to 0, check ixgbe_set_vfta_vf */
@@ -5846,6 +5968,10 @@ ixgbevf_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t vec = IXGBE_MISC_VEC_ID;
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (rte_intr_allow_others(intr_handle))
 		vec = IXGBE_RX_VEC_START;
 	intr->mask |= (1 << vec);
@@ -5868,6 +5994,10 @@ ixgbevf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IXGBE_MISC_VEC_ID;
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (rte_intr_allow_others(intr_handle))
 		vec = IXGBE_RX_VEC_START;
 	intr->mask &= ~(1 << vec);
@@ -5888,6 +6018,10 @@ ixgbe_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct ixgbe_interrupt *intr =
 		IXGBE_DEV_PRIVATE_TO_INTR(dev->data->dev_private);
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (queue_id < 16) {
 		ixgbe_disable_intr(hw);
 		intr->mask |= (1 << queue_id);
@@ -5915,6 +6049,10 @@ ixgbe_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct ixgbe_interrupt *intr =
 		IXGBE_DEV_PRIVATE_TO_INTR(dev->data->dev_private);
 
+	/* device interrupts are only subscribed to in primary processes */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (queue_id < 16) {
 		ixgbe_disable_intr(hw);
 		intr->mask &= ~(1 << queue_id);
@@ -6194,6 +6332,14 @@ ixgbevf_add_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	int diag;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	/*
 	 * On a 82599 VF, adding again the same MAC addr is not an idempotent
 	 * operation. Trap this case to avoid exhausting the [very limited]
@@ -6220,6 +6366,14 @@ ixgbevf_remove_mac_addr(struct rte_eth_dev *dev, uint32_t index)
 	uint32_t i;
 	int diag;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return;
+
 	/*
 	 * The IXGBE_VF_SET_MACVLAN command of the ixgbe-pf driver does
 	 * not support the deletion of a given MAC address.
@@ -6260,6 +6414,14 @@ ixgbevf_set_default_mac_addr(struct rte_eth_dev *dev,
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw->mac.ops.set_rar(hw, 0, (void *)addr, 0, 0);
 
 	return 0;
@@ -6446,6 +6608,14 @@ ixgbevf_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 	uint32_t max_frame = mtu + IXGBE_ETH_OVERHEAD;
 	struct rte_eth_dev_data *dev_data = dev->data;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
 	if (mtu < RTE_ETHER_MIN_MTU || max_frame > RTE_ETHER_MAX_JUMBO_FRAME_LEN)
@@ -6737,6 +6907,14 @@ ixgbe_dev_set_mc_addr_list(struct rte_eth_dev *dev,
 	struct ixgbe_hw *hw;
 	u8 *mc_addr_list;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	mc_addr_list = (u8 *)mc_addr_set;
 	return ixgbe_update_mc_addr_list(hw, mc_addr_list, nb_mc_addr,
@@ -7157,6 +7335,14 @@ ixgbe_get_eeprom(struct rte_eth_dev *dev,
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
 	if ((first > hw->eeprom.word_size) ||
@@ -7177,6 +7363,14 @@ ixgbe_set_eeprom(struct rte_eth_dev *dev,
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
 	if ((first > hw->eeprom.word_size) ||
@@ -7197,6 +7391,14 @@ ixgbe_get_module_info(struct rte_eth_dev *dev,
 	uint8_t sff8472_rev, addr_mode;
 	bool page_swap = false;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	/* Check whether we support SFF-8472 or not */
 	status = hw->phy.ops.read_i2c_eeprom(hw,
 					     IXGBE_SFF_SFF_8472_COMP,
@@ -7242,6 +7444,14 @@ ixgbe_get_module_eeprom(struct rte_eth_dev *dev,
 	uint8_t *data = info->data;
 	uint32_t i = 0;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	for (i = info->offset; i < info->offset + info->length; i++) {
 		if (i < RTE_ETH_MODULE_SFF_8079_LEN)
 			status = hw->phy.ops.read_i2c_eeprom(hw, i, &databyte);
@@ -7837,6 +8047,14 @@ ixgbevf_dev_promiscuous_enable(struct rte_eth_dev *dev)
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	int ret;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	switch (hw->mac.ops.update_xcast_mode(hw, IXGBEVF_XCAST_MODE_PROMISC)) {
 	case IXGBE_SUCCESS:
 		ret = 0;
@@ -7859,6 +8077,14 @@ ixgbevf_dev_promiscuous_disable(struct rte_eth_dev *dev)
 	int mode = IXGBEVF_XCAST_MODE_NONE;
 	int ret;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (dev->data->all_multicast)
 		mode = IXGBEVF_XCAST_MODE_ALLMULTI;
 
@@ -7884,6 +8110,14 @@ ixgbevf_dev_allmulticast_enable(struct rte_eth_dev *dev)
 	int ret;
 	int mode = IXGBEVF_XCAST_MODE_ALLMULTI;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (dev->data->promiscuous)
 		return 0;
 
@@ -7908,6 +8142,14 @@ ixgbevf_dev_allmulticast_disable(struct rte_eth_dev *dev)
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	int ret;
 
+	/*
+	 * This function calls into the base driver, which in turn will use
+	 * function pointers, which are not guaranteed to be valid in secondary
+	 * processes, so avoid using this function in secondary processes.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -E_RTE_SECONDARY;
+
 	if (dev->data->promiscuous)
 		return 0;
 
-- 
2.43.5


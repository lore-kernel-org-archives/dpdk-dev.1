Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610BCD13DA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9426140DD7;
	Thu, 30 Apr 2026 13:15:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id AC54640B9C
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547712; x=1809083712;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0Sm3DX1v5qPwKa7UaPbGqGTHSG5iAkpxhu+nWw49kFU=;
 b=NsbjU7WadRFZkxsvjFVa616aZCaOH3bTpkz4Y4q/gY8zrri/zTYzVhl+
 MDxVdLSsd21lsATRHnKM8WlenbJMmBFQodYP1N0qUQc1UHFtG+49fH7xV
 XxNSZT93mucLt8n//rlVIZux1pYOnzIit4D9RBBzWMD5gDwChA7/nQn2W
 aZLDMO3EgbiQEEQtAXQWD/3Y94s0yaMKtejDHeroDusCVHYzHCoal6xmP
 tPCjOCcXEXTmDJiEDOSWVoqPbN2DyUU4SMvixtOjW/c86nKJiNyp/0CxM
 aCdz+ECYmuqjr+5R8ARzTAUvfs8nSbrMw7GYfZVTXzAJ187VkW6ijKACG Q==;
X-CSE-ConnectionGUID: BgjandgeTGK0rqHQeyE7kg==
X-CSE-MsgGUID: 0nYAZSfWRz2eoQZpfRkcHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482303"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482303"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:11 -0700
X-CSE-ConnectionGUID: nt74+7quQ7W8yHsniKvL8w==
X-CSE-MsgGUID: QFlvnwgqQK2zjmgYk0sEFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444840"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 14/15] net/ixgbe: rely less on global flow state
Date: Thu, 30 Apr 2026 12:14:43 +0100
Message-ID: <9370b7acdf9c78b806257fb6cedf3fbd0c6997fd.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
References: 
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

FDIR setup helpers were implicitly reading and updating global state.
This made behavior depend on cached values and tightly coupled call
ordering to hidden side effects.

Update `ixgbe_fdir_configure()`, `ixgbe_fdir_set_input_mask()`, and
`ixgbe_fdir_filter_program()` to take explicit inputs (`fdir_conf`,
`mask`, `mode`) and make the internal mask helpers use those arguments
instead of reading globals.

Also remove implicit cached-state behavior from
`ixgbe_fdir_set_flexbytes_offset()`: it no longer short-circuits on
cached offset and no longer updates cached offset internally.

Adjust all current callers to match the new semantics:
- pass local config/mask/mode values into setup APIs,
- write global mode/mask/flex cached state in caller code only after
  successful programming.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |   4 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  13 +++-
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 104 +++++++++++--------------
 drivers/net/intel/ixgbe/ixgbe_flow.c   |  32 +++++---
 4 files changed, 79 insertions(+), 74 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 62edada379..d4122107ac 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2724,7 +2724,9 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	ixgbe_configure_dcb(dev);
 
 	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
-		err = ixgbe_fdir_configure(adapter);
+		struct ixgbe_hw_fdir_info *info =
+			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+		err = ixgbe_fdir_configure(adapter, fdir_conf, &info->mask);
 		if (err)
 			goto error;
 	}
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 65e71e7689..165bd93379 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -705,13 +705,18 @@ void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 /*
  * Flow director function prototypes
  */
-int ixgbe_fdir_configure(struct ixgbe_adapter *adapter);
-int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter);
+int ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
+			 const struct rte_eth_fdir_conf *fdir_conf,
+			 const struct ixgbe_hw_fdir_mask *fdir_mask);
+int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
+			      const struct ixgbe_hw_fdir_mask *mask,
+			      enum rte_fdir_mode mode);
 int ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
 				    uint16_t offset);
 int ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-			      struct ixgbe_fdir_rule *rule,
-			      bool del, bool update);
+		struct rte_eth_fdir_conf *fdir_conf,
+		struct ixgbe_fdir_rule *rule,
+		bool del, bool update);
 void ixgbe_fdir_info_get(struct rte_eth_dev *dev,
 			 struct rte_eth_fdir_info *fdir_info);
 void ixgbe_fdir_stats_get(struct rte_eth_dev *dev,
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index e7a380da31..c2828df1f9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -79,8 +79,12 @@
 #define IXGBE_FDIRIP6M_INNER_MAC_SHIFT 4
 
 static int fdir_erase_filter_82599(struct ixgbe_hw *hw, uint32_t fdirhash);
-static int fdir_set_input_mask_82599(struct ixgbe_adapter *adapter);
-static int fdir_set_input_mask_x550(struct ixgbe_adapter *adapter);
+static int fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
+		const struct ixgbe_hw_fdir_mask *mask,
+		enum rte_fdir_mode mode);
+static int fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
+		const struct ixgbe_hw_fdir_mask *mask,
+		enum rte_fdir_mode mode);
 static int ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 		const struct rte_eth_fdir_flex_conf *conf, uint32_t *fdirctrl);
 static int fdir_enable_82599(struct ixgbe_hw *hw, uint32_t fdirctrl);
@@ -248,13 +252,11 @@ reverse_fdir_bitmasks(uint16_t hi_dword, uint16_t lo_dword)
  * but makes use of the rte_fdir_masks structure to see which bits to set.
  */
 static int
-fdir_set_input_mask_82599(struct ixgbe_adapter *adapter)
+fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
+		const struct ixgbe_hw_fdir_mask *mask,
+		enum rte_fdir_mode mode)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct rte_eth_fdir_conf *fdir_conf =
-		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	/*
 	 * mask VM pool and DIPv6 since there are currently not supported
 	 * mask FLEX byte, it will be set in flex_conf
@@ -266,34 +268,34 @@ fdir_set_input_mask_82599(struct ixgbe_adapter *adapter)
 
 	PMD_INIT_FUNC_TRACE();
 
-	if (!info->mask.l4_proto_match)
+	if (!mask->l4_proto_match)
 		/* set L4P to ignore L4 protocol for IP traffic */
 		fdirm |= IXGBE_FDIRM_L4P;
 
-	if (info->mask.vlan_tci_mask == rte_cpu_to_be_16(0x0FFF))
+	if (mask->vlan_tci_mask == rte_cpu_to_be_16(0x0FFF))
 		/* mask VLAN Priority */
 		fdirm |= IXGBE_FDIRM_VLANP;
-	else if (info->mask.vlan_tci_mask == rte_cpu_to_be_16(0xE000))
+	else if (mask->vlan_tci_mask == rte_cpu_to_be_16(0xE000))
 		/* mask VLAN ID */
 		fdirm |= IXGBE_FDIRM_VLANID;
-	else if (info->mask.vlan_tci_mask == 0)
+	else if (mask->vlan_tci_mask == 0)
 		/* mask VLAN ID and Priority */
 		fdirm |= IXGBE_FDIRM_VLANID | IXGBE_FDIRM_VLANP;
-	else if (info->mask.vlan_tci_mask != rte_cpu_to_be_16(0xEFFF)) {
+	else if (mask->vlan_tci_mask != rte_cpu_to_be_16(0xEFFF)) {
 		PMD_INIT_LOG(ERR, "invalid vlan_tci_mask");
 		return -EINVAL;
 	}
 
 	/* flex byte mask */
-	if (info->mask.flex_bytes_mask == 0)
+	if (mask->flex_bytes_mask == 0)
 		fdirm |= IXGBE_FDIRM_FLEX;
 
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRM, fdirm);
 
 	/* store the TCP/UDP port masks, bit reversed from port layout */
 	fdirtcpm = reverse_fdir_bitmasks(
-			rte_be_to_cpu_16(info->mask.dst_port_mask),
-			rte_be_to_cpu_16(info->mask.src_port_mask));
+			rte_be_to_cpu_16(mask->dst_port_mask),
+			rte_be_to_cpu_16(mask->src_port_mask));
 
 	/* write all the same so that UDP, TCP and SCTP use the same mask
 	 * (little-endian)
@@ -311,16 +313,16 @@ fdir_set_input_mask_82599(struct ixgbe_adapter *adapter)
 	 * can not use IXGBE_WRITE_REG.
 	 */
 	reg = IXGBE_PCI_REG_ADDR(hw, IXGBE_FDIRSIP4M);
-	*reg = ~(info->mask.src_ipv4_mask);
+	*reg = ~(mask->src_ipv4_mask);
 	reg = IXGBE_PCI_REG_ADDR(hw, IXGBE_FDIRDIP4M);
-	*reg = ~(info->mask.dst_ipv4_mask);
+	*reg = ~(mask->dst_ipv4_mask);
 
-	if (fdir_conf->mode == RTE_FDIR_MODE_SIGNATURE) {
+	if (mode == RTE_FDIR_MODE_SIGNATURE) {
 		/*
 		 * Store source and destination IPv6 masks (bit reversed)
 		 */
-		fdiripv6m = (info->mask.dst_ipv6_mask << 16) |
-			    info->mask.src_ipv6_mask;
+		fdiripv6m = (mask->dst_ipv6_mask << 16) |
+				mask->src_ipv6_mask;
 
 		IXGBE_WRITE_REG(hw, IXGBE_FDIRIP6M, ~fdiripv6m);
 	}
@@ -333,20 +335,17 @@ fdir_set_input_mask_82599(struct ixgbe_adapter *adapter)
  * but makes use of the rte_fdir_masks structure to see which bits to set.
  */
 static int
-fdir_set_input_mask_x550(struct ixgbe_adapter *adapter)
+fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
+		const struct ixgbe_hw_fdir_mask *mask,
+		enum rte_fdir_mode mode)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct rte_eth_fdir_conf *fdir_conf =
-		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	/* mask VM pool and DIPv6 since there are currently not supported
 	 * mask FLEX byte, it will be set in flex_conf
 	 */
 	uint32_t fdirm = IXGBE_FDIRM_POOL | IXGBE_FDIRM_DIPv6 |
 			 IXGBE_FDIRM_FLEX;
 	uint32_t fdiripv6m;
-	enum rte_fdir_mode mode = fdir_conf->mode;
 	uint16_t mac_mask;
 
 	PMD_INIT_FUNC_TRACE();
@@ -358,16 +357,16 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter)
 	/* some bits must be set for mac vlan or tunnel mode */
 	fdirm |= IXGBE_FDIRM_L4P | IXGBE_FDIRM_L3P;
 
-	if (info->mask.vlan_tci_mask == rte_cpu_to_be_16(0x0FFF))
+	if (mask->vlan_tci_mask == rte_cpu_to_be_16(0x0FFF))
 		/* mask VLAN Priority */
 		fdirm |= IXGBE_FDIRM_VLANP;
-	else if (info->mask.vlan_tci_mask == rte_cpu_to_be_16(0xE000))
+	else if (mask->vlan_tci_mask == rte_cpu_to_be_16(0xE000))
 		/* mask VLAN ID */
 		fdirm |= IXGBE_FDIRM_VLANID;
-	else if (info->mask.vlan_tci_mask == 0)
+	else if (mask->vlan_tci_mask == 0)
 		/* mask VLAN ID and Priority */
 		fdirm |= IXGBE_FDIRM_VLANID | IXGBE_FDIRM_VLANP;
-	else if (info->mask.vlan_tci_mask != rte_cpu_to_be_16(0xEFFF)) {
+	else if (mask->vlan_tci_mask != rte_cpu_to_be_16(0xEFFF)) {
 		PMD_INIT_LOG(ERR, "invalid vlan_tci_mask");
 		return -EINVAL;
 	}
@@ -382,13 +381,13 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter)
 
 	if (mode == RTE_FDIR_MODE_PERFECT_TUNNEL) {
 		fdiripv6m |= IXGBE_FDIRIP6M_INNER_MAC;
-		mac_mask = info->mask.mac_addr_byte_mask &
+		mac_mask = mask->mac_addr_byte_mask &
 			(IXGBE_FDIRIP6M_INNER_MAC >>
 			IXGBE_FDIRIP6M_INNER_MAC_SHIFT);
 		fdiripv6m &= ~((mac_mask << IXGBE_FDIRIP6M_INNER_MAC_SHIFT) &
 				IXGBE_FDIRIP6M_INNER_MAC);
 
-		switch (info->mask.tunnel_type_mask) {
+		switch (mask->tunnel_type_mask) {
 		case 0:
 			/* Mask tunnel type */
 			fdiripv6m |= IXGBE_FDIRIP6M_TUNNEL_TYPE;
@@ -400,7 +399,7 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter)
 			return -EINVAL;
 		}
 
-		switch (rte_be_to_cpu_32(info->mask.tunnel_id_mask)) {
+		switch (rte_be_to_cpu_32(mask->tunnel_id_mask)) {
 		case 0x0:
 			/* Mask vxlan id */
 			fdiripv6m |= IXGBE_FDIRIP6M_TNI_VNI;
@@ -427,36 +426,28 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter)
 }
 
 int
-ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter)
+ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
+		const struct ixgbe_hw_fdir_mask *mask,
+		enum rte_fdir_mode mode)
 {
-	struct rte_eth_fdir_conf *fdir_conf =
-		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
-	enum rte_fdir_mode mode = fdir_conf->mode;
-
 	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
 	    mode <= RTE_FDIR_MODE_PERFECT)
-		return fdir_set_input_mask_82599(adapter);
+		return fdir_set_input_mask_82599(adapter, mask, mode);
 	else if (mode >= RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
 		 mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		return fdir_set_input_mask_x550(adapter);
+		return fdir_set_input_mask_x550(adapter, mask, mode);
 
 	PMD_DRV_LOG(ERR, "Not supported fdir mode - %d!", mode);
 	return -ENOTSUP;
 }
 
 int
-ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
-				uint16_t offset)
+ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter, uint16_t offset)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	uint32_t fdirctrl;
 	int i;
 
-	if (fdir_info->flex_bytes_offset == offset)
-		return 0;
-
 	/**
 	 * 82599 adapters flow director init flow cannot be restarted,
 	 * Workaround 82599 silicon errata by performing the following steps
@@ -493,8 +484,6 @@ ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
 		return -ETIMEDOUT;
 	}
 
-	fdir_info->flex_bytes_offset = offset;
-
 	return 0;
 }
 
@@ -566,11 +555,11 @@ ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 }
 
 int
-ixgbe_fdir_configure(struct ixgbe_adapter *adapter)
+ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
+		const struct rte_eth_fdir_conf *fdir_conf,
+		const struct ixgbe_hw_fdir_mask *fdir_mask)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct rte_eth_fdir_conf *fdir_conf =
-		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	int err;
 	uint32_t fdirctrl, pbsize;
 	int i;
@@ -617,7 +606,7 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter)
 	for (i = 1; i < 8; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
 
-	err = ixgbe_fdir_set_input_mask(adapter);
+	err = ixgbe_fdir_set_input_mask(adapter, fdir_mask, mode);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
 		return err;
@@ -1046,13 +1035,12 @@ ixgbe_remove_fdir_filter(struct ixgbe_hw_fdir_info *fdir_info,
 
 int
 ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-			  struct ixgbe_fdir_rule *rule,
-			  bool del,
-			  bool update)
+		struct rte_eth_fdir_conf *fdir_conf,
+		struct ixgbe_fdir_rule *rule,
+		bool del,
+		bool update)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct rte_eth_fdir_conf *fdir_conf =
-		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
 	uint32_t fdircmd_flags;
 	uint32_t fdirhash;
 	uint8_t queue;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index eae81462f6..cda2e95d22 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2838,7 +2838,6 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 		hw->mac.type != ixgbe_mac_X540 &&
@@ -2863,12 +2862,15 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 step_next:
 
 	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
-		fdir_conf->mode = rule->mode;
-		ret = ixgbe_fdir_configure(adapter);
+		struct rte_eth_fdir_conf fc = *fdir_conf;
+
+		fc.mode = rule->mode;
+		ret = ixgbe_fdir_configure(adapter, &fc, &rule->mask);
 		if (ret) {
 			fdir_conf->mode = RTE_FDIR_MODE_NONE;
 			return ret;
 		}
+		fdir_conf->mode = rule->mode;
 	} else if (fdir_conf->mode != rule->mode) {
 		return -ENOTSUP;
 	}
@@ -3167,19 +3169,25 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		/* A mask cannot be deleted. */
 		if (fdir_rule.b_mask) {
 			if (!fdir_info->mask_added) {
-				/* It's the first time the mask is set. */
-				*&fdir_info->mask = *&fdir_rule.mask;
+				bool flex_byte_offset_changed =
+					fdir_info->flex_bytes_offset !=
+					fdir_rule.flex_bytes_offset;
 
-				if (fdir_rule.mask.flex_bytes_mask) {
+				if (fdir_rule.mask.flex_bytes_mask &&
+				    flex_byte_offset_changed) {
 					ret = ixgbe_fdir_set_flexbytes_offset(adapter,
 						fdir_rule.flex_bytes_offset);
 					if (ret)
 						goto out;
 				}
-				ret = ixgbe_fdir_set_input_mask(adapter);
+				ret = ixgbe_fdir_set_input_mask(adapter,
+						&fdir_rule.mask, fdir_rule.mode);
 				if (ret)
 					goto out;
 
+				fdir_info->mask = fdir_rule.mask;
+				fdir_info->flex_bytes_offset =
+					fdir_rule.flex_bytes_offset;
 				fdir_info->mask_added = TRUE;
 				first_mask = TRUE;
 			} else {
@@ -3201,8 +3209,10 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		}
 
 		if (fdir_rule.b_spec) {
-			ret = ixgbe_fdir_filter_program(adapter, &fdir_rule,
-					FALSE, FALSE);
+			struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+
+			ret = ixgbe_fdir_filter_program(adapter, fdir_conf,
+					&fdir_rule, FALSE, FALSE);
 			if (!ret) {
 				fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
 					sizeof(struct ixgbe_fdir_rule_ele), 0);
@@ -3374,6 +3384,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct ixgbe_filter_ele_base *flow_mem_base;
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
 	/* Validate ownership before touching HW/SW state. */
@@ -3433,9 +3444,8 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&fdir_rule,
 			&fdir_rule_ptr->filter_info,
 			sizeof(struct ixgbe_fdir_rule));
-		ret = ixgbe_fdir_filter_program(adapter, &fdir_rule, TRUE, FALSE);
+		ret = ixgbe_fdir_filter_program(adapter, fdir_conf, &fdir_rule, TRUE, FALSE);
 		if (!ret) {
-			struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 			rte_free(fdir_rule_ptr);
 			if (fdir_info->n_flows > 0 && --(fdir_info->n_flows) == 0) {
 				fdir_info->mask_added = false;
-- 
2.47.3


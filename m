Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E1CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC40406B7;
	Thu, 30 Apr 2026 13:15:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id ED76440674
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547699; x=1809083699;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XjvJg9vcvoHTEZMyLSDm5lbUEOZiHKMeKYX7UW+mhcs=;
 b=YsxKFIVEU9Bl4yMV6YGqG+NvO6EWOb7uKMxoRL0y7HfjCKWNPOagCgps
 QWGp2LC2rSOsCgo8DADzdYEt49XdlR60uM5ZfvZmnsHL229oSWvlFDDSM
 e8I++eF7psS6N6ze1T7aiGuC3zJtS7txvqEqWU4VRUPfoHl66FosS6XX/
 zhrM0WQGP0HOZHRLEci2W6UMYR2oI/3NbVPcT/vpAJzA72dx80NquA1XA
 pRtdcrRWf/AxQJh7CSGcS8yZ9UP5xmS8TBzvxsDwRMi1/eJ/spsWu9ura
 F3gBXZH+J7CSCDGWCpE+ZasyYWYfwL/SKjnpA7Lb9Ox/vsN+OB/FooQbl g==;
X-CSE-ConnectionGUID: ns8J59ybS0SbLMabLlvzAQ==
X-CSE-MsgGUID: zns71n4eTgCTdBJk2thd1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482269"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482269"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:14:58 -0700
X-CSE-ConnectionGUID: HcdAWVgJRSSpRxUddyTL1Q==
X-CSE-MsgGUID: +7utvnQNQYCQ/maJLlMO5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444721"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:14:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Wei Dai <wei.dai@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH v1 05/15] net/ixgbe: fix L4 protocol mask handling
Date: Thu, 30 Apr 2026 12:14:34 +0100
Message-ID: <e05216b320b4a37e8a8532fb7f7730bd125a70df.1777547413.git.anatoly.burakov@intel.com>
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

Currently, ixgbe uses zero `src_port_mask` and `dst_port_mask` to decide
whether `IXGBE_FDIRM_L4P` should ignore the L4 protocol. This conflates
two different cases: broad L4 matches that care about the L4 protocol but
ignore L4 ports, and plain IP matches that should ignore L4 protocol
entirely.

The current `rte_flow` path also copies parsed masks through `struct
rte_eth_fdir_masks`, which cannot preserve that distinction. As a
result, protocol-only `rte_flow` rules lose their L4 protocol match
information before the hardware FDIR mask is programmed.

Fix this by storing explicit L4 protocol match state in `struct
ixgbe_hw_fdir_mask` and by programming `IXGBE_FDIRM_L4P` from that state
instead of inferring it from port masks. Remove the lossy `struct
rte_eth_fdir_masks` mediation layer and program the hardware mask
directly from the ixgbe FDIR mask structure.

Fixes: 11777435c727 ("net/ixgbe: parse flow director filter")
Cc: wei.zhao1@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  1 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 90 +++-----------------------
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 11 ++--
 3 files changed, 15 insertions(+), 87 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 1293ea49cb..a0a2ea23b2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -151,6 +151,7 @@ struct ixgbe_hw_fdir_mask {
 	uint32_t dst_ipv4_mask;
 	uint16_t src_ipv6_mask;
 	uint16_t dst_ipv6_mask;
+	uint8_t  l4_proto_match;
 	uint16_t src_port_mask;
 	uint16_t dst_port_mask;
 	uint16_t flex_bytes_mask;
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 0bdfbd411a..38f589623e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -79,8 +79,6 @@
 #define IXGBE_FDIRIP6M_INNER_MAC_SHIFT 4
 
 static int fdir_erase_filter_82599(struct ixgbe_hw *hw, uint32_t fdirhash);
-static int fdir_set_input_mask(struct rte_eth_dev *dev,
-			       const struct rte_eth_fdir_masks *input_mask);
 static int fdir_set_input_mask_82599(struct rte_eth_dev *dev);
 static int fdir_set_input_mask_x550(struct rte_eth_dev *dev);
 static int ixgbe_set_fdir_flex_conf(struct rte_eth_dev *dev,
@@ -266,14 +264,8 @@ fdir_set_input_mask_82599(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	/*
-	 * Program the relevant mask registers.  If src/dst_port or src/dst_addr
-	 * are zero, then assume a full mask for that field. Also assume that
-	 * a VLAN of 0 is unspecified, so mask that out as well.  L4type
-	 * cannot be masked out in this implementation.
-	 */
-	if (info->mask.dst_port_mask == 0 && info->mask.src_port_mask == 0)
-		/* use the L4 protocol mask for raw IPv4/IPv6 traffic */
+	if (!info->mask.l4_proto_match)
+		/* set L4P to ignore L4 protocol for IP traffic */
 		fdirm |= IXGBE_FDIRM_L4P;
 
 	if (info->mask.vlan_tci_mask == rte_cpu_to_be_16(0x0FFF))
@@ -306,7 +298,12 @@ fdir_set_input_mask_82599(struct rte_eth_dev *dev)
 	 */
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRTCPM, ~fdirtcpm);
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRUDPM, ~fdirtcpm);
-	IXGBE_WRITE_REG(hw, IXGBE_FDIRSCTPM, ~fdirtcpm);
+	/* only certain MAC types have SCTP masking register */
+	if (hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610)
+		IXGBE_WRITE_REG(hw, IXGBE_FDIRSCTPM, ~fdirtcpm);
 
 	/* Store source and destination IPv4 masks (big-endian),
 	 * can not use IXGBE_WRITE_REG.
@@ -425,62 +422,6 @@ fdir_set_input_mask_x550(struct rte_eth_dev *dev)
 	return IXGBE_SUCCESS;
 }
 
-static int
-ixgbe_fdir_store_input_mask_82599(struct rte_eth_dev *dev,
-				  const struct rte_eth_fdir_masks *input_mask)
-{
-	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	uint16_t dst_ipv6m = 0;
-	uint16_t src_ipv6m = 0;
-
-	memset(&info->mask, 0, sizeof(struct ixgbe_hw_fdir_mask));
-	info->mask.vlan_tci_mask = input_mask->vlan_tci_mask;
-	info->mask.src_port_mask = input_mask->src_port_mask;
-	info->mask.dst_port_mask = input_mask->dst_port_mask;
-	info->mask.src_ipv4_mask = input_mask->ipv4_mask.src_ip;
-	info->mask.dst_ipv4_mask = input_mask->ipv4_mask.dst_ip;
-	IPV6_ADDR_TO_MASK(input_mask->ipv6_mask.src_ip, src_ipv6m);
-	IPV6_ADDR_TO_MASK(input_mask->ipv6_mask.dst_ip, dst_ipv6m);
-	info->mask.src_ipv6_mask = src_ipv6m;
-	info->mask.dst_ipv6_mask = dst_ipv6m;
-
-	return IXGBE_SUCCESS;
-}
-
-static int
-ixgbe_fdir_store_input_mask_x550(struct rte_eth_dev *dev,
-				 const struct rte_eth_fdir_masks *input_mask)
-{
-	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-
-	memset(&info->mask, 0, sizeof(struct ixgbe_hw_fdir_mask));
-	info->mask.vlan_tci_mask = input_mask->vlan_tci_mask;
-	info->mask.mac_addr_byte_mask = input_mask->mac_addr_byte_mask;
-	info->mask.tunnel_type_mask = input_mask->tunnel_type_mask;
-	info->mask.tunnel_id_mask = input_mask->tunnel_id_mask;
-
-	return IXGBE_SUCCESS;
-}
-
-static int
-ixgbe_fdir_store_input_mask(struct rte_eth_dev *dev,
-			    const struct rte_eth_fdir_masks *input_mask)
-{
-	enum rte_fdir_mode mode = IXGBE_DEV_FDIR_CONF(dev)->mode;
-
-	if (mode >= RTE_FDIR_MODE_SIGNATURE &&
-	    mode <= RTE_FDIR_MODE_PERFECT)
-		return ixgbe_fdir_store_input_mask_82599(dev, input_mask);
-	else if (mode >= RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
-		 mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		return ixgbe_fdir_store_input_mask_x550(dev, input_mask);
-
-	PMD_DRV_LOG(ERR, "Not supported fdir mode - %d!", mode);
-	return -ENOTSUP;
-}
-
 int
 ixgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 {
@@ -551,19 +492,6 @@ ixgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
 	return 0;
 }
 
-static int
-fdir_set_input_mask(struct rte_eth_dev *dev,
-		    const struct rte_eth_fdir_masks *input_mask)
-{
-	int ret;
-
-	ret = ixgbe_fdir_store_input_mask(dev, input_mask);
-	if (ret)
-		return ret;
-
-	return ixgbe_fdir_set_input_mask(dev);
-}
-
 /*
  * ixgbe_check_fdir_flex_conf -check if the flex payload and mask configuration
  * arguments are valid
@@ -681,7 +609,7 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
 	for (i = 1; i < 8; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
 
-	err = fdir_set_input_mask(dev, &IXGBE_DEV_FDIR_CONF(dev)->mask);
+	err = ixgbe_fdir_set_input_mask(dev);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
 		return err;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 71da5ac72e..6e87d373ad 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1713,6 +1713,7 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
 	rule->mask.vlan_tci_mask = 0;
 	rule->mask.flex_bytes_mask = 0;
+	rule->mask.l4_proto_match = 0;
 	rule->mask.dst_port_mask = 0;
 	rule->mask.src_port_mask = 0;
 
@@ -2325,6 +2326,10 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 		}
 	}
 
+	/* L4 protocol matching is enabled when parser selected an L4 type. */
+	rule->mask.l4_proto_match =
+		(rule->ixgbe_fdir.formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) != 0;
+
 	return ixgbe_parse_fdir_act_attr(attr, actions, rule, error);
 }
 
@@ -2852,12 +2857,6 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 
 step_next:
 
-	if (hw->mac.type == ixgbe_mac_82599EB &&
-		rule->fdirflags == IXGBE_FDIRCMD_DROP &&
-		(rule->ixgbe_fdir.formatted.src_port != 0 ||
-		rule->ixgbe_fdir.formatted.dst_port != 0))
-		return -ENOTSUP;
-
 	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
 		fdir_conf->mode = rule->mode;
 		ret = ixgbe_fdir_configure(dev);
-- 
2.47.3


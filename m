Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F3ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 01:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C109402B3;
	Sun,  2 Nov 2025 02:19:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id B9A0340261;
 Sun,  2 Nov 2025 02:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762046375; x=1793582375;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uItocSHNILMdO07+8EXAWA2cu/tiOK+sf1pFfWD9vG8=;
 b=YCQgLpGa5RhVrwbA89jJ4bGhSjwDOs9y0fkOjzPn89kMnsRkwdjIsLYc
 Gqz9VvDhAUsDXUF1a3+45ED3xl2E5kUbyJTWrFTUcokOIqnQ+aGJWCySJ
 TI5FYrni8RjIqr9b995LddBxHRjw/qdr5bTXC/DKNdSKbW8pYL3Nj/0ZT
 zG+RVjrnKXxa6cwbhJkzD71jQ1hVlnK36Pi8VtTCy9qClokhQrIIcz3YM
 3ThU2TTX0ynca+iQHvz/JA5r7YawMX4fJ5Ax9rhuqaFnptBy0QgANtcOL
 0uiVyiFmvSOgKT4UJJ/R2m6C4g8aYrh1yDRGHOXP/S4eWKPOfwu4YX1gt A==;
X-CSE-ConnectionGUID: dDPMNZaVRMCccwR4vSVkxg==
X-CSE-MsgGUID: hpivSi0oTvmbP+LU/hycFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="81795587"
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; d="scan'208";a="81795587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2025 18:19:33 -0700
X-CSE-ConnectionGUID: FC0VzQoqRXuVtTopB1ht6A==
X-CSE-MsgGUID: ymgCOjGgRZiWDuo2SOlYYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; d="scan'208";a="186503964"
Received: from pae-14.iind.intel.com ([10.190.203.159])
 by orviesa007.jf.intel.com with ESMTP; 01 Nov 2025 18:19:32 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v3] net/ice: add source prune configuration API
Date: Sun,  2 Nov 2025 01:19:19 +0000
Message-Id: <20251102011919.68783-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101182934.67105-1-anurag.mandal@intel.com>
References: <20251101182934.67105-1-anurag.mandal@intel.com>
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

Source prune is disabled by default to support
VRRP advertisement packets in a vsi of ice PF.
There is no way to enable source prune itself.

This patch adds a PMD specific API to enable/disable
source prune for all PF ports or for an individual PF port.

Tested the following with VRRP advertisement packets in a
vsi of ice PF:
1. Source prune default mode.
2. Enable source prune for an individual PF port.
3. Disable source prune for an individual PF port.
4. Enable source prune for all PF ports.
5. Disable source prune for all PF ports.

Fixes: 6f866eb93e79 ("net/ice: fix dropped packets when using VRRP")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c  | 72 +++++++++++++++++++++++
 drivers/net/intel/ice/ice_ethdev.h  | 16 ++++++
 drivers/net/intel/ice/ice_testpmd.c | 88 +++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..d1565f0a7a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <ethdev_pci.h>
 
@@ -201,6 +202,7 @@ static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_
 						size_t *no_of_elements);
 static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
 static int ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf);
+static int ice_pf_set_source_prune(struct ice_pf *pf, uint8_t on);
 
 static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
@@ -1703,6 +1705,75 @@ ice_pf_sw_init(struct rte_eth_dev *dev)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_set_pf_src_prune, 25.11)
+int
+rte_pmd_ice_set_pf_src_prune(uint16_t port, uint8_t on)
+{
+	struct rte_eth_dev *dev;
+	struct ice_pf *pf;
+	int ret;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+	if (!is_ice_supported(dev))
+		return -ENOTSUP;
+
+	pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+
+	ret = ice_pf_set_source_prune(pf, on);
+	return ret;
+}
+
+/* ice_pf_set_source_prune
+ * @pf: pointer to the pf structure
+ * @on: enable/disable source prune
+ *
+ * set source prune on pf
+ */
+static int
+ice_pf_set_source_prune(struct ice_pf *pf, uint8_t on)
+{
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_vsi *vsi = pf->main_vsi;
+	struct ice_vsi_ctx ctxt;
+	int ret;
+
+	memset(&ctxt, 0, sizeof(ctxt));
+	ctxt.flags = ICE_AQ_VSI_TYPE_PF;
+	ctxt.info.valid_sections |=
+		rte_cpu_to_le_16(ICE_AQ_VSI_PROP_SW_VALID);
+	ctxt.info.sw_id = hw->port_info->sw_id;
+	ctxt.vsi_num = vsi->vsi_id;
+
+	if (on) {
+		/* Enable source prune */
+		ctxt.info.sw_flags &=
+			~(ICE_AQ_VSI_SW_FLAG_LOCAL_LB);
+		ctxt.info.sw_flags &=
+			~(ICE_AQ_VSI_SW_FLAG_SRC_PRUNE);
+	} else {
+		/* Disable source prune to support VRRP */
+		ctxt.info.sw_flags =
+			ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
+		ctxt.info.sw_flags |=
+			ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+	}
+
+	ret = ice_update_vsi(hw, vsi->idx, &ctxt, NULL);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Update VSI failed to %s source prune",
+			on ? "enable" : "disable");
+		return -EINVAL;
+	}
+
+	vsi->info.valid_sections |=
+		rte_cpu_to_le_16(ICE_AQ_VSI_PROP_SW_VALID);
+	vsi->info.sw_flags = ctxt.info.sw_flags;
+
+	return 0;
+}
+
 struct ice_vsi *
 ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 {
@@ -1753,6 +1824,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		 * by ice_init_hw
 		 */
 		vsi_ctx.info.sw_id = hw->port_info->sw_id;
+		/* disable source prune to support VRRP in default */
 		vsi_ctx.info.sw_flags = ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
 		vsi_ctx.info.sw_flags |= ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 		cfg = ICE_AQ_VSI_PROP_SW_VALID;
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 6478d6dfbd..c2dad32045 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -805,6 +805,22 @@ int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size);
 __rte_experimental
 int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
 
+/**
+ * Enable/Disable source prune on all the PF.
+ *
+ * @param port
+ *    The port identifier of the Ethernet device.
+ * @param on
+ *    1 - Enable source prune.
+ *    0 - Disable source prune.
+ * @return
+ *   - (0) if successful.
+ *   - (-ENODEV) if *port* invalid.
+ *   - (-EINVAL) if bad parameter.
+ */
+__rte_experimental
+int rte_pmd_ice_set_pf_src_prune(uint16_t port, uint8_t on);
+
 int
 ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32_t node_teid);
 
diff --git a/drivers/net/intel/ice/ice_testpmd.c b/drivers/net/intel/ice/ice_testpmd.c
index 98c02d68c6..29a15f548f 100644
--- a/drivers/net/intel/ice/ice_testpmd.c
+++ b/drivers/net/intel/ice/ice_testpmd.c
@@ -206,6 +206,84 @@ cmdline_parse_inst_t cmd_txsched_dump = {
 	},
 };
 
+/* *** configure source prune for ice port *** */
+struct cmd_config_src_prune_result {
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t keyword;
+	cmdline_fixed_string_t port_all; /* valid if "allports" argument == 1 */
+	uint16_t port_id;                /* valid if "allports" argument == 0 */
+	cmdline_fixed_string_t item;
+	cmdline_fixed_string_t enable;
+};
+
+static void cmd_config_pf_src_prune_parsed(void *parsed_result,
+					__rte_unused struct cmdline *cl,
+					void *allports)
+{
+	struct cmd_config_src_prune_result *res = parsed_result;
+	uint8_t enable;
+	uint16_t i;
+
+	if (!strcmp(res->enable, "on"))
+		enable = 1;
+	else
+		enable = 0;
+
+	/* all ports */
+	if (allports) {
+		RTE_ETH_FOREACH_DEV(i)
+			rte_pmd_ice_set_pf_src_prune(i, enable);
+	} else {
+		rte_pmd_ice_set_pf_src_prune(res->port_id, enable);
+	}
+}
+
+static cmdline_parse_token_string_t cmd_config_src_prune_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_src_prune_result, port, "port");
+static cmdline_parse_token_string_t cmd_config_src_prune_keyword =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_src_prune_result, keyword,
+				 "config");
+static cmdline_parse_token_string_t cmd_config_src_prune_portall =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_src_prune_result, port_all,
+				 "all");
+static cmdline_parse_token_num_t cmd_config_src_prune_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_config_src_prune_result, port_id,
+			      RTE_UINT16);
+static cmdline_parse_token_string_t cmd_config_src_prune_item =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_src_prune_result,
+			item, "ice_source_prune");
+static cmdline_parse_token_string_t cmd_config_src_prune_enable =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_src_prune_result, enable,
+				 "on#off");
+
+static cmdline_parse_inst_t cmd_config_src_prune_all = {
+	.f = cmd_config_pf_src_prune_parsed,
+	.data = (void *)1,
+	.help_str = "port config all ice_source_prune on|off: Set source prune on/off all pf ports.",
+	.tokens = {
+		(void *)&cmd_config_src_prune_port,
+		(void *)&cmd_config_src_prune_keyword,
+		(void *)&cmd_config_src_prune_portall,
+		(void *)&cmd_config_src_prune_item,
+		(void *)&cmd_config_src_prune_enable,
+		NULL,
+	},
+};
+
+static cmdline_parse_inst_t cmd_config_src_prune_specific = {
+	.f = cmd_config_pf_src_prune_parsed,
+	.data = (void *)0,
+	.help_str = "port config <port_id> ice_source_prune on|off: Set source prune on/off specific pf port.",
+	.tokens = {
+		(void *)&cmd_config_src_prune_port,
+		(void *)&cmd_config_src_prune_keyword,
+		(void *)&cmd_config_src_prune_port_id,
+		(void *)&cmd_config_src_prune_item,
+		(void *)&cmd_config_src_prune_enable,
+		NULL,
+	},
+};
+
 static struct testpmd_driver_commands ice_cmds = {
 	.commands = {
 	{
@@ -225,6 +303,16 @@ static struct testpmd_driver_commands ice_cmds = {
 		"txsched dump (port_id) <brief|detail> (config_path)\n"
 		"    Dump tx scheduling runtime configure on a port\n\n",
 
+	},
+		{
+		&cmd_config_src_prune_all,
+		"port config all ice_source_prune (on|off)\n"
+		"    Set source prune on/off pf port all.\n"
+	},
+	{
+		&cmd_config_src_prune_specific,
+		"port config (port_id) ice_source_prune (on|off)\n"
+		"    Set source prune on/off pf port_id.\n"
 	},
 	{ NULL, NULL },
 	},
-- 
2.34.1


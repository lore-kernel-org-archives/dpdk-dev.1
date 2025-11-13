Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8A0CD5BC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 10:59:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE10140687;
	Thu, 13 Nov 2025 11:59:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id CB1F140151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 11:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763031562; x=1794567562;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hixstg6k/rR7BXW4+UlUcQfNRB2fEBd38VxkqUFsLSQ=;
 b=KzGSX3dLlkkbd+V6XPhpKq4llUxoYFY3T6KYdweySfvFIsKnQ3hQIP9D
 PVfgGbK+ejLmRnCzG55OX4WMToVESyBHsvTfP9FoVP8qtawLqj9MPbyEQ
 pCZnf17SagTMXu4wdgzkB9F4NN+Jdj+f0Knh5tj5l3SjpR3dRiG7LlTS+
 S7dgoJnLDtkUz7ggUuYNgWvfpu+I7vv/3swzcF2RGWPVqjC2Hg6K0cqcB
 3NV0LO2GT7DiCpwZ0G0yHwKA1VkH3sK82ye1gqTq2rKe+pJIZP6Pi84Eu
 ntjrTHoQDZ1B5Zq51sWChmD6ExnQreLONAz8gJ1y1AULkgzLl95XcBDAr Q==;
X-CSE-ConnectionGUID: 6qHuC9SZTz6X39NUobMgAA==
X-CSE-MsgGUID: wrjCFy9uRryMslhLSRvikA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65201978"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="65201978"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 02:59:21 -0800
X-CSE-ConnectionGUID: bvku37xET8WD55Sfb7d/lg==
X-CSE-MsgGUID: GquprekuQRamyZz6l+o9Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="188748424"
Received: from pae-14.iind.intel.com ([10.190.203.159])
 by orviesa010.jf.intel.com with ESMTP; 13 Nov 2025 02:59:20 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/ice: add MAC anti-spoof disable option
Date: Thu, 13 Nov 2025 10:59:14 +0000
Message-Id: <20251113105914.34949-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

VRRP advertisement packets are dropped as TX-errors upon transmission from
a vsi of ice PF due to MAC anti-spoof check. There is no way to disable
this check in the Tx direction to avoid these packets being dropped.

This patch introduces devarg "mac-anti-spoof-disable" to allow user to
disable MAC anti-spoof check. Disable MAC Anti-spoof check in the Tx
direction to avoid getting dropped as TX-errors upon packet transmission
when their source MAC address matches one of the MAC addresses assigned
to that same NIC port.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/nics/ice.rst            | 11 +++++++++++
 drivers/net/intel/ice/ice_ethdev.c | 22 ++++++++++++++++++++++
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 6cc27cefa7..bc86de0081 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -194,6 +194,17 @@ Runtime Configuration
 
     -a 80:00.0,source-prune=1
 
+- ``MAC Anti-spoof Disable`` (default ``0``)
+
+  Disable MAC Anti-spoof check in the Tx direction to avoid getting dropped
+  as TX-errors upon packet transmission when their source MAC address
+  matches one of the MAC addresses assigned to that same NIC port.
+
+  MAC Anti-spoof can be disabled by setting the devargs parameter ``mac-anti-spoof-disable``,
+  for example::
+
+    -a 80:00.0,mac-anti-spoof-disable=1
+
 - ``Protocol extraction for per queue``
 
   Configure the RX queues to do protocol extraction into mbuf for protocol
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c1d92435d1..a0eae74bbb 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -42,6 +42,7 @@
 #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
 #define ICE_SOURCE_PRUNE_ARG      "source-prune"
+#define ICE_MAC_ANTI_SPOOF_DISABLE "mac-anti-spoof-disable"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
@@ -60,6 +61,7 @@ static const char * const ice_valid_args[] = {
 	ICE_DDP_LOAD_SCHED_ARG,
 	ICE_TM_LEVELS_ARG,
 	ICE_SOURCE_PRUNE_ARG,
+	ICE_MAC_ANTI_SPOOF_DISABLE,
 	ICE_LINK_STATE_ON_CLOSE,
 	NULL
 };
@@ -1768,6 +1770,20 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 			vsi_ctx.info.sw_flags |=
 				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 		}
+		/* MAC Anti-Spoof */
+		if (ad->devargs.mac_anti_spoof_disable == 1) {
+			/* Disable mac anti-spoof check in the
+			 * Tx direction to avoid getting dropped
+			 * as TX-errors for VRRP support when
+			 * mac-anti-spoof-disable devarg is set
+			 */
+			vsi_ctx.info.sw_flags &=
+				~ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+			vsi_ctx.info.sw_flags |=
+				ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
+			vsi_ctx.info.sec_flags =
+				ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF;
+		}
 		cfg = ICE_AQ_VSI_PROP_SW_VALID;
 		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
 		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
@@ -2467,6 +2483,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_MAC_ANTI_SPOOF_DISABLE,
+				 &parse_bool, &ad->devargs.mac_anti_spoof_disable);
+	if (ret)
+		goto bail;
+
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
 
@@ -7732,6 +7753,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
 			      ICE_TM_LEVELS_ARG "=<N>"
 			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
+			      ICE_MAC_ANTI_SPOOF_DISABLE "=<0|1>"
 			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
 			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 72ed65f13b..9b36627d12 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -617,6 +617,7 @@ struct ice_devargs {
 	uint8_t ddp_load_sched;
 	uint8_t tm_exposed_levels;
 	uint8_t source_prune;
+	uint8_t mac_anti_spoof_disable;
 	int link_state_on_close;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013ECCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:30:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 992C540698;
	Wed,  5 Nov 2025 19:30:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 028A04021F;
 Wed,  5 Nov 2025 19:30:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762367451; x=1793903451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6OnCASym3Dp0Jkus7buNy854dfbQlTt3/M6CdMVD10g=;
 b=nXcFt1QTixkEq6YjA+P2vUNoLJsbi2zNqkAy2weT4HeaOaeJtIp0RZGc
 BHIqjAFLNJEaz1PxEDeLlKUEYVCkkDgEjo/T2zuL/MU4WB1aQNyawsqig
 7PrpBmdmk4TCYOvGq8eFdmcId/GeS11jkerFRXs/dv6OwuWaWFXrbKcfZ
 hBfKNYB/Vszz1h4QKXKq8zbwt0NPv+VoMywo5ffGWD7uBqkfMsuv8hWFY
 bmu1I65crWrCWPUdZlxD6nHQAMcJarREYRfpmCF759lLcp+ACIYQ9k37C
 e1g3EfA33E/gmwVpN0STA3vuMD4VHCRXGgoepazL5DlTzuGXZghM5uWDG Q==;
X-CSE-ConnectionGUID: f43hI5elSVuJHOW2o8NT3A==
X-CSE-MsgGUID: cTjaLdqNSiuNz+qFH95UvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="87120653"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="87120653"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:30:50 -0800
X-CSE-ConnectionGUID: 4osl6rNZSFOppoa2KOg39Q==
X-CSE-MsgGUID: Ftt9jADXTPG1R8PgmG4XvA==
X-ExtLoop1: 1
Received: from pae-14.iind.intel.com ([10.190.203.159])
 by fmviesa003.fm.intel.com with ESMTP; 05 Nov 2025 10:30:47 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v4] net/ice: add option to enable source prune
Date: Wed,  5 Nov 2025 18:30:31 +0000
Message-Id: <20251105183031.91709-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101104627.64906-1-anurag.mandal@intel.com>
References: <20251101104627.64906-1-anurag.mandal@intel.com>
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

This patch introduces devarg "source-prune-enable" to allow
user to enable source prune.

Enable Source Prune to automatically drop incoming packets when
their source MAC address matches one of the MAC addresses assigned
to that same NIC port.

Tested the following with VRRP advertisement packets in a
vsi of ice PF:
1. Source prune default mode with no devarg option.
2. Enable source prune with devarg"source-prune-enable=1".
3. Disable source prune with devarg"source-prune-enable=0".

Fixes: 6f866eb93e79 ("net/ice: fix dropped packets when using VRRP")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V4: Adressed Bruce Richardson's comment
 - changed from private API to devarg option.

 doc/guides/nics/ice.rst            | 11 +++++++++++
 drivers/net/intel/ice/ice_ethdev.c | 25 +++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e9ba23102..09561b08c5 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -183,6 +183,17 @@ Runtime Configuration
   If the value provided is greater than the number of levels provided by the HW,
   SW will use the hardware maximum value.
 
+- ``Source Prune Enable`` (default ``0``)
+
+  Enable Source Prune to automatically drop incoming packets when
+  their source MAC address matches one of the MAC addresses assigned
+  to that same NIC port.
+
+  Source Prune can be enabled by setting the devargs parameter ``source-prune-enable``,
+  for example::
+
+    -a 80:00.0,source-prune-enable=1
+
 - ``Protocol extraction for per queue``
 
   Configure the RX queues to do protocol extraction into mbuf for protocol
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..540d0bd977 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -41,6 +41,7 @@
 #define ICE_DDP_FILENAME_ARG      "ddp_pkg_file"
 #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
+#define ICE_SRC_PRUNE_ENABLE_ARG  "source-prune-enable"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
@@ -58,6 +59,7 @@ static const char * const ice_valid_args[] = {
 	ICE_DDP_FILENAME_ARG,
 	ICE_DDP_LOAD_SCHED_ARG,
 	ICE_TM_LEVELS_ARG,
+	ICE_SRC_PRUNE_ENABLE_ARG,
 	ICE_LINK_STATE_ON_CLOSE,
 	NULL
 };
@@ -1716,6 +1718,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 	uint16_t max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	uint8_t tc_bitmap = 0x1;
 	uint16_t cfg;
+	struct ice_adapter *ad = (struct ice_adapter *)hw->back;
 
 	/* hw->num_lports = 1 in NIC mode */
 	vsi = rte_zmalloc(NULL, sizeof(struct ice_vsi), 0);
@@ -1753,8 +1756,20 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		 * by ice_init_hw
 		 */
 		vsi_ctx.info.sw_id = hw->port_info->sw_id;
-		vsi_ctx.info.sw_flags = ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
-		vsi_ctx.info.sw_flags |= ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+		/* Source Prune */
+		if (ad->devargs.source_prune_enable == 1) {
+			/* Enable source prune */
+			vsi_ctx.info.sw_flags &=
+				~(ICE_AQ_VSI_SW_FLAG_LOCAL_LB);
+			vsi_ctx.info.sw_flags &=
+				~(ICE_AQ_VSI_SW_FLAG_SRC_PRUNE);
+		} else {
+			/* Disable source prune to support VRRP */
+			vsi_ctx.info.sw_flags =
+				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
+			vsi_ctx.info.sw_flags |=
+				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+		}
 		cfg = ICE_AQ_VSI_PROP_SW_VALID;
 		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
 		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
@@ -2449,6 +2464,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_SRC_PRUNE_ENABLE_ARG,
+				 &parse_bool, &ad->devargs.source_prune_enable);
+	if (ret)
+		goto bail;
+
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
 
@@ -7659,6 +7679,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_DDP_FILENAME_ARG "=</path/to/file>"
 			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
 			      ICE_TM_LEVELS_ARG "=<N>"
+			      ICE_SRC_PRUNE_ENABLE_ARG "=<0|1>"
 			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
 			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 6478d6dfbd..408cbe4a38 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -614,6 +614,7 @@ struct ice_devargs {
 	uint8_t pps_out_ena;
 	uint8_t ddp_load_sched;
 	uint8_t tm_exposed_levels;
+	uint8_t source_prune_enable;
 	int link_state_on_close;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469DDCCFA19
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 16:33:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 290BB4021F;
	Thu,  6 Nov 2025 17:33:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C9E064013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 17:33:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762446835; x=1793982835;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AqdQdN2VUlnpGVrvAc2nG4krvhBuH9fvkHB3I3/ixEA=;
 b=ehitS+yo16Rr3lfPcSlYq7UOFsgiVbtkMt76nrA1ahAszGA2hZJxu02S
 ZGrQUbi9j3JNbMKGaV+QzPCzFf8c5BG83LZpwIt6w5crKWNECUtBZi0gU
 x8pJDXQ8yhBstXyGb524LLtAT6guLHtwWm/vqFfZGLz3s76r9JsDFussn
 zwPIvsbFcDu9NCTftWTfqYMzeaHlGxeP7x0Y1Q4eJohIHGb3DsePKkjgN
 3djiB1i7/QSvBnq5pA+2P1qec3siEblV460/LM/Li3r6+bXYH1zz/XCHp
 bB5DHvozZqnDzkOp1RGlC5MDc0c5aKq+x+Bnv/ar/OFB4vyPN0r3ptTYY Q==;
X-CSE-ConnectionGUID: 8t1y+e46R6Onar0esJ+2gg==
X-CSE-MsgGUID: 4n6wscslTrSZKa9u7WDSaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75197882"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="75197882"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 08:33:53 -0800
X-CSE-ConnectionGUID: PSetqqh8SyWXHKxzqwxIfw==
X-CSE-MsgGUID: 3CQQvsCcQiOt73r43gzQ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="225047783"
Received: from pae-14.iind.intel.com ([10.190.203.159])
 by orviesa001.jf.intel.com with ESMTP; 06 Nov 2025 08:33:53 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v5] net/ice: add option to enable source prune
Date: Thu,  6 Nov 2025 16:33:34 +0000
Message-Id: <20251106163334.95660-1-anurag.mandal@intel.com>
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

This patch introduces devarg "source-prune" to
allow user to enable source prune.

Enable Source Prune to automatically drop incoming
packets when their source MAC address matches one
of the MAC addresses assigned to that same NIC port.

Tested the following with VRRP advertisement packets
in a vsi of ice PF:
1. Source prune default mode with no devarg option.
2. Enable source prune with devarg "source-prune=1".
3. Disable source prune with devarg "source-prune=0".

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V5:Addressed Bruce Richardson's minor feedbacks
 - changed devarg name to "source-prune"
 - removed "Fixes" from commit msg
 - removed explicit source prune enabling 'if' block
 - changed devargs member name to "source_prune"
 - changed macro name to "ICE_SOURCE_PRUNE_ARG"

V4: Addressed Bruce Richardson's feedback
 - changed from private API to devarg option.

V3: Addressed Coding Style Warning

V2: Addressed Coding Style Warnings

 doc/guides/nics/ice.rst            | 11 +++++++++++
 drivers/net/intel/ice/ice_ethdev.c | 21 +++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e9ba23102..d050140e84 100644
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
+  Source Prune can be enabled by setting the devargs parameter ``source-prune``,
+  for example::
+
+    -a 80:00.0,source-prune=1
+
 - ``Protocol extraction for per queue``
 
   Configure the RX queues to do protocol extraction into mbuf for protocol
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..65d4ae5407 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -41,6 +41,7 @@
 #define ICE_DDP_FILENAME_ARG      "ddp_pkg_file"
 #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
+#define ICE_SOURCE_PRUNE_ARG      "source-prune"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
@@ -58,6 +59,7 @@ static const char * const ice_valid_args[] = {
 	ICE_DDP_FILENAME_ARG,
 	ICE_DDP_LOAD_SCHED_ARG,
 	ICE_TM_LEVELS_ARG,
+	ICE_SOURCE_PRUNE_ARG,
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
@@ -1753,8 +1756,16 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		 * by ice_init_hw
 		 */
 		vsi_ctx.info.sw_id = hw->port_info->sw_id;
-		vsi_ctx.info.sw_flags = ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
-		vsi_ctx.info.sw_flags |= ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+		/* Source Prune */
+		if (ad->devargs.source_prune != 1) {
+			/* Disable source prune to support VRRP
+			 * when source-prune devarg is not set
+			 */
+			vsi_ctx.info.sw_flags =
+				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
+			vsi_ctx.info.sw_flags |=
+				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+		}
 		cfg = ICE_AQ_VSI_PROP_SW_VALID;
 		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
 		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
@@ -2449,6 +2460,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_SOURCE_PRUNE_ARG,
+				 &parse_bool, &ad->devargs.source_prune);
+	if (ret)
+		goto bail;
+
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
 
@@ -7659,6 +7675,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_DDP_FILENAME_ARG "=</path/to/file>"
 			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
 			      ICE_TM_LEVELS_ARG "=<N>"
+			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
 			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
 			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 6478d6dfbd..5decb05d5f 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -614,6 +614,7 @@ struct ice_devargs {
 	uint8_t pps_out_ena;
 	uint8_t ddp_load_sched;
 	uint8_t tm_exposed_levels;
+	uint8_t source_prune;
 	int link_state_on_close;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
-- 
2.34.1


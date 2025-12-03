Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A276D12694
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 10:42:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BD2B402BD;
	Wed,  3 Dec 2025 11:42:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E0B1D402B7
 for <dev@dpdk.org>; Wed,  3 Dec 2025 11:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764758532; x=1796294532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ah9dmcEagoPgE/gulPCP1c3tBLX101EMJNPD+7VWnI4=;
 b=WpKTytRNT9w+h8tdwVPp042srXAqbYQloIbGNmziNJ2zaqQ3VICpA3Aq
 7VlRJLzReHZkpufG2TvWZ3mZrdcK6HNomDb9406/5lNCCcBAk4HE5iNqJ
 9an7hRPO/vuWnmbN6oj/vcBmtSYUzBXOGJhMzJ6WGTpa3sZKDagrdDN+Q
 9SgreEdGFAgNOIuczW4MS8+/fjA/4/5API/vNdff7j3Od2uuscMT++Mmq
 7bS7/bwJ4ll/bYzvjnSHaVkwRaUek/OAXe2o7inZUB6JU0wm18cx9a2jc
 wAPz3Z1N7EX5Z4Pr+uwPI1dU2uxCcgmQVe/wShD5H8plqBTrBoDAMAeVu w==;
X-CSE-ConnectionGUID: fAPz20zUQI6YBr0XzsJJbA==
X-CSE-MsgGUID: AHA+fkdBRjuMT2emM+F1EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77856299"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="77856299"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 02:42:10 -0800
X-CSE-ConnectionGUID: C6pEnXB1RUyWNjeTGeCa4g==
X-CSE-MsgGUID: rluqfF+VSaWFfxxgR+29Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="225320450"
Received: from pae-14.iind.intel.com ([10.190.203.159])
 by orviesa002.jf.intel.com with ESMTP; 03 Dec 2025 02:42:07 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 mb@smartsharesystems.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v3] net/ice: add MAC anti-spoof option
Date: Wed,  3 Dec 2025 10:41:26 +0000
Message-Id: <20251203104126.75935-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113105914.34949-1-anurag.mandal@intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

MAC anti-spoof is disabled by default to support VRRP advertisement
packets from a vsi of ice PF. There is no way to enable this security
check in the Tx direction itself.

This patch introduces devargs "mac-anti-spoof" to allow user to
enable MAC anti-spoof check. Enable MAC Anti-spoof check in the
Tx direction to automatically drop outgoing packets as TX-errors
when their destination MAC address matches one of the MAC
addresses assigned to that same NIC port.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V3: Addressed Morten Brørup's feedback
 - set the default value of the devargs to 0
 - disabled MAC anti-spoof check by default
 - provided devargs option to enable the same
 - synchronized with source prune

V2: Addressed Bruce Richardson's feedback
 - changed devargs name to "mac-anti-spoof"
 - changed devargs member name to "mac_anti_spoof"
 - changed macro name to "ICE_MAC_ANTI_SPOOF_ARG"
 - set the default value of the devargs to 1
 - added NOTICE log msg when MAC Anti-spoof is disabled
 - added more code comments to provide clarity
 - fixed typo error with ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF

 doc/guides/nics/ice.rst            | 11 +++++++++
 drivers/net/intel/ice/ice_ethdev.c | 38 ++++++++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 6cc27cefa7..ee8d443c97 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -194,6 +194,17 @@ Runtime Configuration
 
     -a 80:00.0,source-prune=1
 
+- ``MAC Anti-spoof Enable`` (default ``0``)
+
+  Enable MAC Anti-spoof check in the Tx direction to drop outgoing
+  packets when their destination MAC address matches one of the
+  MAC addresses assigned to that same NIC port.
+
+  MAC Anti-spoof can be enabled by setting the devargs parameter ``mac-anti-spoof``,
+  for example::
+
+    -a 80:00.0,mac-anti-spoof=1
+
 - ``Protocol extraction for per queue``
 
   Configure the RX queues to do protocol extraction into mbuf for protocol
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c1d92435d1..fbecd00d35 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -42,6 +42,7 @@
 #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
 #define ICE_SOURCE_PRUNE_ARG      "source-prune"
+#define ICE_MAC_ANTI_SPOOF_ARG    "mac-anti-spoof"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
@@ -60,6 +61,7 @@ static const char * const ice_valid_args[] = {
 	ICE_DDP_LOAD_SCHED_ARG,
 	ICE_TM_LEVELS_ARG,
 	ICE_SOURCE_PRUNE_ARG,
+	ICE_MAC_ANTI_SPOOF_ARG,
 	ICE_LINK_STATE_ON_CLOSE,
 	NULL
 };
@@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		/* Source Prune */
 		if (ad->devargs.source_prune != 1) {
 			/* Disable source prune to support VRRP
-			 * when source-prune devarg is not set
+			 * when source-prune devargs is not set
 			 */
 			vsi_ctx.info.sw_flags =
 				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
-			vsi_ctx.info.sw_flags |=
+		} else { /* Enable Source Prune in Rx */
+			vsi_ctx.info.sw_flags =
 				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 		}
+		/* MAC Anti-spoof */
+		/* By default, Source Prune in Rx and
+		 * MAC Anti-spoof check in Tx are disabled.
+		 *
+		 * Source Prune is disabled by setting local
+		 * loopback with ICE_AQ_VSI_SW_FLAG_LOCAL_LB
+		 * flag in the Rx direction.
+		 *
+		 * MAC Anti-spoof check can be disabled by
+		 * setting Tx loopback with
+		 * ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the
+		 * Tx direction.
+		 */
+		if (ad->devargs.mac_anti_spoof != 1) {
+			/* Disable mac anti-spoof check in the
+			 * Tx direction to avoid getting dropped
+			 * as TX-errors for VRRP support when
+			 * mac-anti-spoof devargs is not set
+			 */
+			vsi_ctx.info.sw_flags |=
+				ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
+		} else { /* Enable MAC Anti-spoof check in Tx */
+			vsi_ctx.info.sec_flags =
+				ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF;
+		}
 		cfg = ICE_AQ_VSI_PROP_SW_VALID;
 		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
 		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
@@ -2467,6 +2495,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_MAC_ANTI_SPOOF_ARG,
+				 &parse_bool, &ad->devargs.mac_anti_spoof);
+	if (ret)
+		goto bail;
+
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
 
@@ -7732,6 +7765,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
 			      ICE_TM_LEVELS_ARG "=<N>"
 			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
+			      ICE_MAC_ANTI_SPOOF_ARG "=<0|1>"
 			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
 			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 72ed65f13b..5fe4688d57 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -617,6 +617,7 @@ struct ice_devargs {
 	uint8_t ddp_load_sched;
 	uint8_t tm_exposed_levels;
 	uint8_t source_prune;
+	uint8_t mac_anti_spoof;
 	int link_state_on_close;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
-- 
2.34.1


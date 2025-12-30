Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C60E95A77
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 11:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9170840267;
	Tue, 30 Dec 2025 12:48:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2AB1F4025A
 for <dev@dpdk.org>; Tue, 30 Dec 2025 12:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767095295; x=1798631295;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HbebFYGWFU1v93YSvZK+zIbvAmByNLUjmDioS2ulAwI=;
 b=XtSndlY0BZGPixJ92zPbR7FSpWqROH87QZDrNDkrc0BuIqKuKnQCi4AU
 rYKlAfZe70RUoxaWaNGS/dKekaX0sTei20OYzJsMl4nU7Em+3ALKEFwE0
 D5Kjgb74RPXW3Fxd19HygATuaFeN8aRzN3res6I3+nAom0OKAybjscwgE
 8OetdH6r2qNg4JMNlIwh6JmwgA3sp6+AB6wMVyhBCWp2u6fz4WQNeH3nN
 4LHk6KpuSgOJ7L97KsLlXoCaIgk2RFFvGy4tQP1FjynqT+7DdqVLbl+c5
 xu+05ta4OXO9DvG0tJCyXBN8aPwIclPkNkhNna5oMjuw9MxiqfLl1HizT w==;
X-CSE-ConnectionGUID: lbZzOiuDRZuQqQPtn6mB1A==
X-CSE-MsgGUID: YdG3uV6RTyKEQtVbhYAnnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="78989816"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; d="scan'208";a="78989816"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2025 03:48:13 -0800
X-CSE-ConnectionGUID: C8G6/01sTk6g6gA++XBupQ==
X-CSE-MsgGUID: aGI93JT4STW9/BzVHO8apA==
X-ExtLoop1: 1
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.168])
 by fmviesa003.fm.intel.com with ESMTP; 30 Dec 2025 03:48:11 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 mb@smartsharesystems.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v5] net/ice: add MAC anti-spoof option
Date: Tue, 30 Dec 2025 11:48:28 +0000
Message-Id: <20251230114828.6156-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113105914.34949-1-anurag.mandal@intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
a vsi of ice PF due to MAC anti-spoof check, which is enabled by default.
There is no way to disable this security check in the Tx direction to
avoid these packets being dropped.

This patch introduces devargs "mac-anti-spoof" to allow user to
disable MAC anti-spoof check. Disable MAC Anti-spoof check in the
Tx direction to send outgoing packets even when their destination
MAC address matches one of the MAC addresses assigned to that
same NIC port and avoid getting dropped as TX-errors.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V5: Addressed CI failures
 - Removed ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF
   flag as that is causing CI failures and observed
   MAC Anti-spoof check is enabled by default
   irrespective of that flag.
V4: Addressed ASan CI failures & Morten Brørup's feedback
 - set the default value of the devargs to 1
 - enabled MAC anti-spoof check by default
 - provided devargs option to disbale the same

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

 doc/guides/nics/ice.rst            | 12 ++++++++
 drivers/net/intel/ice/ice_ethdev.c | 44 +++++++++++++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 6cc27cefa7..c3e9cfaee3 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -194,6 +194,18 @@ Runtime Configuration
 
     -a 80:00.0,source-prune=1
 
+- ``MAC Anti-spoof Disable`` (default ``1``)
+
+  Disable MAC Anti-spoof check in the Tx direction to send outgoing
+  packets when their destination MAC address matches one of the
+  MAC addresses assigned to that same NIC port.By default, these
+  outgoing packets are dropped due to MAC Anti-spoof check.
+
+  MAC Anti-spoof can be disabled by resetting the devargs parameter ``mac-anti-spoof``,
+  for example::
+
+    -a 80:00.0,mac-anti-spoof=0
+
 - ``Protocol extraction for per queue``
 
   Configure the RX queues to do protocol extraction into mbuf for protocol
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c1d92435d1..7251b111e0 100644
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
@@ -1761,13 +1763,46 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		/* Source Prune */
 		if (ad->devargs.source_prune != 1) {
 			/* Disable source prune to support VRRP
-			 * when source-prune devarg is not set
+			 * when source-prune devargs is not set
 			 */
 			vsi_ctx.info.sw_flags =
 				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
 			vsi_ctx.info.sw_flags |=
 				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 		}
+		/* MAC Anti-spoof */
+		/* By default, Source Prune in Rx is disabled
+		 * and MAC Anti-spoof check in Tx is enabled.
+		 *
+		 * Source Prune is disabled by setting local
+		 * loopback with ICE_AQ_VSI_SW_FLAG_LOCAL_LB
+		 * flag in the Rx direction.
+		 * ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to
+		 * prevent transmitted packets from being
+		 * looped back in some circumstances.
+		 *
+		 * MAC Anti-spoof check can be disabled by
+		 * clearing ICE_AQ_VSI_SW_FLAG_SRC_PRUNE
+		 * flag and setting Tx loopback with
+		 * ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the
+		 * Tx direction.
+		 */
+		if (ad->devargs.mac_anti_spoof == 0) {
+			/* Disable mac anti-spoof check in the
+			 * Tx direction to avoid outgoing
+			 * packets getting dropped as
+			 * TX-errors for VRRP support when
+			 * mac-anti-spoof devargs is not set
+			 */
+			vsi_ctx.info.sw_flags &=
+				~ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+			PMD_INIT_LOG(NOTICE,
+				     "Disabling MAC Anti-spoof check "
+				     "in the Tx direction does not "
+				     "affect Source Prune in the Rx direction");
+			vsi_ctx.info.sw_flags |=
+				ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
+		}
 		cfg = ICE_AQ_VSI_PROP_SW_VALID;
 		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
 		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
@@ -2398,6 +2433,7 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
+	ad->devargs.mac_anti_spoof = 1; /* enabled by default */
 	ad->devargs.proto_xtr_dflt = PROTO_XTR_NONE;
 	memset(ad->devargs.proto_xtr, PROTO_XTR_NONE,
 	       sizeof(ad->devargs.proto_xtr));
@@ -2467,6 +2503,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_MAC_ANTI_SPOOF_ARG,
+				 &parse_bool, &ad->devargs.mac_anti_spoof);
+	if (ret)
+		goto bail;
+
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
 
@@ -7732,6 +7773,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
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


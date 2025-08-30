Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F3CA1000
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 17:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2A7D4066F;
	Sat, 30 Aug 2025 19:17:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 88A4740666
 for <dev@dpdk.org>; Sat, 30 Aug 2025 19:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756574238; x=1788110238;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C+V+30xwa3Dkxg6WbKA0ub1bBnu3Fp2cYJxMKaMosas=;
 b=UZNTUeTCVMfCTkmuWIy4MR/LTeuQLwBFLOu1R3t0yHg0AM+1af6CnGbK
 gszyea9179qbFtzJnK1OTmeGh6KZqfZiv2tKDjbepgi3TJHl5hkTveav9
 I7FObf3WN61jOrIi+EbkqCWscHXelL/97ApHs8FiLmFrZlxWL62tt5R/Q
 fDnx6jGYrt/Dcvx6Ana3a4w0R/VZbyg75c1d3EUsoIyFzMGmRPvPlMJ4H
 r9rAQKRDlpB8NND5v0Y0yx7UjXvKtcC4OL4WSWjOmhX6jJTebQ+7plvZG
 qxxTtBiJDu826cel8g8/giNjeKpEuqOr1/etQOdQHqe4gn2s/MlPnBuiV w==;
X-CSE-ConnectionGUID: zCQZnv1wRtWMK+0H0QC8Iw==
X-CSE-MsgGUID: HjLzFwXoQh66/VLwLjkU1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58781198"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58781198"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2025 10:17:17 -0700
X-CSE-ConnectionGUID: aWSbC7ytRmeNcaA+KkNL8w==
X-CSE-MsgGUID: PGOn5rFcQ8Ce26IeI9URng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="174966891"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2025 10:17:16 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: [RFC PATCH 3/6] ethdev: decouple VMDq and DCB cofiguration
Date: Sat, 30 Aug 2025 17:17:03 +0000
Message-ID: <20250830171706.428977-4-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
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

Current API expects that VMDq and DCB configuration are interconnected,
which may be true for some HW, but isn't universal. For one, we have a
VMDq+DCB configuration structure, but it is not needed because we already
have separate VMDq and DCB structures, so remove it.

Additionally, tx_adv_conf is currently a union, which makes the above
structure necessary, but again, it is not needed if we make tx_adv_conf a
structure and use separate VMDQ and DCB configurations.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-pmd/testpmd.c  | 31 +++++++++++++++++++++++++------
 lib/ethdev/rte_ethdev.h | 35 +----------------------------------
 2 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b551140165..b5a7e7b3ee 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4103,10 +4103,14 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 	 * given above, and the number of traffic classes available for use.
 	 */
 	if (dcb_mode == DCB_VT_ENABLED) {
-		struct rte_eth_vmdq_dcb_conf *vmdq_rx_conf =
-				&eth_conf->rx_adv_conf.vmdq_dcb_conf;
-		struct rte_eth_vmdq_dcb_tx_conf *vmdq_tx_conf =
-				&eth_conf->tx_adv_conf.vmdq_dcb_tx_conf;
+		struct rte_eth_vmdq_rx_conf *vmdq_rx_conf =
+				&eth_conf->rx_adv_conf.vmdq_rx_conf;
+		struct rte_eth_vmdq_tx_conf *vmdq_tx_conf =
+				&eth_conf->tx_adv_conf.vmdq_tx_conf;
+		struct rte_eth_dcb_conf *dcb_rx_conf =
+				&eth_conf->rx_adv_conf.dcb_rx_conf;
+		struct rte_eth_dcb_conf *dcb_tx_conf =
+				&eth_conf->tx_adv_conf.dcb_tx_conf;
 
 		/* VMDQ+DCB RX and TX configurations */
 		vmdq_rx_conf->enable_default_pool = 0;
@@ -4124,8 +4128,23 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		}
 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
 			dcb_tc_val = prio_tc_en ? prio_tc[i] : i % num_tcs;
-			vmdq_rx_conf->dcb_tc[i] = dcb_tc_val;
-			vmdq_tx_conf->dcb_tc[i] = dcb_tc_val;
+			dcb_rx_conf->dcb_tc[i] = dcb_tc_val;
+			dcb_tx_conf->dcb_tc[i] = dcb_tc_val;
+		}
+
+		const int bw_share_percent = 100 / num_tcs;
+		const int bw_share_left = 100 - bw_share_percent * num_tcs;
+		for (i = 0; i < num_tcs; i++) {
+			dcb_rx_conf->dcb_tc_bw[i] = bw_share_percent;
+			dcb_tx_conf->dcb_tc_bw[i] = bw_share_percent;
+
+			dcb_rx_conf->dcb_tsa[i] = RTE_ETH_DCB_TSA_ETS;
+			dcb_tx_conf->dcb_tsa[i] = RTE_ETH_DCB_TSA_ETS;
+		}
+
+		for (i = 0; i < bw_share_left; i++) {
+			dcb_rx_conf->dcb_tc_bw[i]++;
+			dcb_tx_conf->dcb_tc_bw[i]++;
 		}
 
 		/* set DCB mode of RX and TX of multiple queues */
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 1579be5a95..c220760043 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -937,39 +937,10 @@ struct rte_eth_dcb_conf {
 	uint8_t dcb_tc_bw[RTE_ETH_DCB_NUM_TCS];
 };
 
-struct rte_eth_vmdq_dcb_tx_conf {
-	enum rte_eth_nb_pools nb_queue_pools; /**< With DCB, 16 or 32 pools. */
-	/** Traffic class each UP mapped to. */
-	uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
-};
-
 struct rte_eth_vmdq_tx_conf {
 	enum rte_eth_nb_pools nb_queue_pools; /**< VMDq mode, 64 pools. */
 };
 
-/**
- * A structure used to configure the VMDq+DCB feature
- * of an Ethernet port.
- *
- * Using this feature, packets are routed to a pool of queues, based
- * on the VLAN ID in the VLAN tag, and then to a specific queue within
- * that pool, using the user priority VLAN tag field.
- *
- * A default pool may be used, if desired, to route all traffic which
- * does not match the VLAN filter rules.
- */
-struct rte_eth_vmdq_dcb_conf {
-	enum rte_eth_nb_pools nb_queue_pools; /**< With DCB, 16 or 32 pools */
-	uint8_t enable_default_pool; /**< If non-zero, use a default pool */
-	uint8_t default_pool; /**< The default pool, if applicable */
-	uint8_t nb_pool_maps; /**< We can have up to 64 filters/mappings */
-	struct {
-		uint16_t vlan_id; /**< The VLAN ID of the received frame */
-		uint64_t pools;   /**< Bitmask of pools for packet Rx */
-	} pool_map[RTE_ETH_VMDQ_MAX_VLAN_FILTERS]; /**< VMDq VLAN pool maps. */
-	/** Selects a queue in a pool */
-	uint8_t dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
-};
 
 /**
  * A structure used to configure the VMDq feature of an Ethernet port when
@@ -1523,16 +1494,12 @@ struct rte_eth_conf {
 				 are defined in implementation of each driver. */
 	struct {
 		struct rte_eth_rss_conf rss_conf; /**< Port RSS configuration */
-		/** Port VMDq+DCB configuration. */
-		struct rte_eth_vmdq_dcb_conf vmdq_dcb_conf;
 		/** Port DCB Rx configuration. */
 		struct rte_eth_dcb_conf dcb_rx_conf;
 		/** Port VMDq Rx configuration. */
 		struct rte_eth_vmdq_rx_conf vmdq_rx_conf;
 	} rx_adv_conf; /**< Port Rx filtering configuration. */
-	union {
-		/** Port VMDq+DCB Tx configuration. */
-		struct rte_eth_vmdq_dcb_tx_conf vmdq_dcb_tx_conf;
+	struct {
 		/** Port DCB Tx configuration. */
 		struct rte_eth_dcb_conf dcb_tx_conf;
 		/** Port VMDq Tx configuration. */
-- 
2.43.0


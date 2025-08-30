Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B01CA0FFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 17:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 938804066A;
	Sat, 30 Aug 2025 19:17:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D97C840648
 for <dev@dpdk.org>; Sat, 30 Aug 2025 19:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756574236; x=1788110236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9ZzNQ8sYQSLEVESJo4nNguQMipq8v2v6tG3Trb/ke0Y=;
 b=W5TvfIBCTQmyu+iHbTIlr20j96F3wYTM9R6EswLs3/AbXTEtBUNBEFK6
 KDyU6Oz4UA34uxE/9SB21nIQgnOnJaeaMPQqNrrMXzl7jEjAjtjj7KXAz
 J5GBShe3s4YUxsjzQQuwx19wJqyf13VT79s4S5P9378yiSZXlbr1xzDwa
 Tb92eyJzfxLIaPVGs9bwLX/Bm9xjOaZ+6ejeGrv8iz64KaBg8m33G/QJY
 MLGRxgDKsw2mXphA7TwerClIl0/UpTdYNRhv5PNh74LtYkonWm39Ww8Ik
 ECiJJXUahdxeE9phD+dypIuI8T6k0DQ+ZB3pzlIsg3HNQMp+XdBvAtXt2 g==;
X-CSE-ConnectionGUID: XhtmBQpvRYak+5LUYTjifw==
X-CSE-MsgGUID: Cn4KK4E6STqceuLTkOKKAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58781192"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58781192"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2025 10:17:16 -0700
X-CSE-ConnectionGUID: HsXivh8pTDWT6Q5OEn/ZSA==
X-CSE-MsgGUID: e2cvW+UBRHCh6o8tQhnWDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="174966882"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2025 10:17:14 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: [RFC PATCH 2/6] ethdev: remove nb_tcs from rte_eth_dcb_conf structure
Date: Sat, 30 Aug 2025 17:17:02 +0000
Message-ID: <20250830171706.428977-3-vladimir.medvedkin@intel.com>
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

Current DCB API was not changed since the first public release and is
heavily influenced by how DCB works in devices using ixgbe driver.
Specifically, the API assumes that we can only configure either 4 or 8
Traffic Classes per port. While that may be true on some HW, this has
nothing to do with DCB specification and instead is an artifact of how
DCB was implemented back in the day. Moreover, this is actually not
needed because the driver can infer the number of traffic classes from
the DCB configuration data (dcb_tc array).

Remove the unneeded field from DCB configuration structure.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-pmd/cmdline.c             |  8 ++++----
 app/test-pmd/testpmd.c             | 11 ++++-------
 app/test-pmd/testpmd.h             |  2 +-
 drivers/net/intel/ice/ice_ethdev.c | 18 ++++++------------
 lib/ethdev/rte_ethdev.h            | 10 ----------
 5 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..82322f3456 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3472,7 +3472,7 @@ parse_dcb_token_prio_tc(char *param_str[], int param_num,
 			return -1;
 		}
 		tc = strtoul(end + 1, &end, 10);
-		if (tc >= RTE_ETH_8_TCS) {
+		if (tc >= RTE_ETH_DCB_NUM_TCS) {
 			fprintf(stderr, "Bad Argument: invalid TC %lu\n", tc);
 			return -1;
 		}
@@ -3625,7 +3625,7 @@ cmd_config_dcb_parsed(void *parsed_result,
 		return;
 	}
 
-	if (res->num_tcs < 1 || res->num_tcs > RTE_ETH_8_TCS) {
+	if (res->num_tcs < 1 || res->num_tcs > RTE_ETH_DCB_NUM_TCS) {
 		fprintf(stderr,
 			"The invalid number of traffic class, only 1~8 allowed.\n");
 		return;
@@ -3651,11 +3651,11 @@ cmd_config_dcb_parsed(void *parsed_result,
 	/* DCB in VT mode */
 	if (!strncmp(res->vt_en, "on", 2))
 		ret = init_port_dcb_config(port_id, DCB_VT_ENABLED,
-				(enum rte_eth_nb_tcs)res->num_tcs,
+				(int)res->num_tcs,
 				pfc_en, prio_tc, prio_tc_en, keep_qnum);
 	else
 		ret = init_port_dcb_config(port_id, DCB_ENABLED,
-				(enum rte_eth_nb_tcs)res->num_tcs,
+				(int)res->num_tcs,
 				pfc_en, prio_tc, prio_tc_en, keep_qnum);
 	if (ret != 0) {
 		fprintf(stderr, "Cannot initialize network ports.\n");
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index d64a7dcac5..b551140165 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4093,7 +4093,7 @@ const uint16_t vlan_tags[] = {
 
 static void
 get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
-		 enum rte_eth_nb_tcs num_tcs, uint8_t pfc_en,
+		 int num_tcs, uint8_t pfc_en,
 		 uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES], uint8_t prio_tc_en)
 {
 	uint8_t dcb_tc_val, i;
@@ -4112,9 +4112,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		vmdq_rx_conf->enable_default_pool = 0;
 		vmdq_rx_conf->default_pool = 0;
 		vmdq_rx_conf->nb_queue_pools =
-			(num_tcs ==  RTE_ETH_4_TCS ? RTE_ETH_32_POOLS : RTE_ETH_16_POOLS);
+			(num_tcs <=  4 ? RTE_ETH_32_POOLS : RTE_ETH_16_POOLS);
 		vmdq_tx_conf->nb_queue_pools =
-			(num_tcs ==  RTE_ETH_4_TCS ? RTE_ETH_32_POOLS : RTE_ETH_16_POOLS);
+			(num_tcs <=  4 ? RTE_ETH_32_POOLS : RTE_ETH_16_POOLS);
 
 		vmdq_rx_conf->nb_pool_maps = vmdq_rx_conf->nb_queue_pools;
 		for (i = 0; i < vmdq_rx_conf->nb_pool_maps; i++) {
@@ -4139,9 +4139,6 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		struct rte_eth_dcb_conf *tx_conf =
 				&eth_conf->tx_adv_conf.dcb_tx_conf;
 
-		rx_conf->nb_tcs = num_tcs;
-		tx_conf->nb_tcs = num_tcs;
-
 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
 			dcb_tc_val = prio_tc_en ? prio_tc[i] : i % num_tcs;
 			rx_conf->dcb_tc[i] = dcb_tc_val;
@@ -4195,7 +4192,7 @@ clear_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf)
 int
 init_port_dcb_config(portid_t pid,
 		     enum dcb_mode_enable dcb_mode,
-		     enum rte_eth_nb_tcs num_tcs,
+		     int num_tcs,
 		     uint8_t pfc_en,
 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
 		     uint8_t prio_tc_en,
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index e629edaa02..4ff982ed3f 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1150,7 +1150,7 @@ void clear_port_member_flag(portid_t member_pid);
 uint8_t port_is_bonding_member(portid_t member_pid);
 
 int init_port_dcb_config(portid_t pid, enum dcb_mode_enable dcb_mode,
-		     enum rte_eth_nb_tcs num_tcs,
+		     int num_tcs,
 		     uint8_t pfc_en,
 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
 		     uint8_t prio_tc_en,
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 7ba25049d7..ecde00182f 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3768,15 +3768,6 @@ check_dcb_conf(int is_8_ports, struct rte_eth_dcb_conf *dcb_conf)
 	bool ets_seen = false;
 	int nb_tc_used;
 
-	enum rte_eth_nb_tcs nb_tcs = dcb_conf->nb_tcs;
-	if (nb_tcs != RTE_ETH_4_TCS && is_8_ports) {
-		PMD_DRV_LOG(ERR, "Invalid num TCs setting - only 4 TCs are supported");
-		return -1;
-	} else if (nb_tcs != RTE_ETH_4_TCS && nb_tcs != RTE_ETH_8_TCS) {
-		PMD_DRV_LOG(ERR, "Invalid num TCs setting - only 8 TCs or 4 TCs are supported");
-		return -1;
-	}
-
 	/* Check if associated TC are in continuous range */
 	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++)
 		tc_map |= 1 << (dcb_conf->dcb_tc[i] & 0x7);
@@ -3788,6 +3779,10 @@ check_dcb_conf(int is_8_ports, struct rte_eth_dcb_conf *dcb_conf)
 	}
 
 	nb_tc_used = rte_popcount32(tc_map);
+	if (nb_tc_used > 4 && is_8_ports) {
+		PMD_DRV_LOG(ERR, "Invalid num TCs setting - only 4 TCs are supported");
+		return -1;
+	}
 
 	/* calculate total ETS Bandwidth allocation */
 	for (i = 0; i < nb_tc_used; i++) {
@@ -3851,7 +3846,6 @@ ice_dev_configure(struct rte_eth_dev *dev)
 		struct rte_eth_dcb_conf *tx_dcb_conf =
 			&dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
 		int i;
-		enum rte_eth_nb_tcs nb_tcs = rx_dcb_conf->nb_tcs;
 		int nb_tc_used_rx, nb_tc_used_tx, queues_per_tc;
 		uint16_t total_q_nb;
 
@@ -3888,7 +3882,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
 
 		memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
 
-		local_dcb_conf->etscfg.maxtcs = nb_tcs;
+		local_dcb_conf->etscfg.maxtcs = nb_tc_used_rx;
 
 		/* Associate each VLAN UP with particular TC */
 		for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
@@ -3909,7 +3903,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
 			local_dcb_conf->etsrec.tsatable[i] = tx_dcb_conf->dcb_tsa[i];
 		}
 
-		local_dcb_conf->pfc.pfccap = nb_tcs;
+		local_dcb_conf->pfc.pfccap = RTE_MAX(nb_tc_used_rx, nb_tc_used_tx);
 		local_dcb_conf->pfc.pfcena = 0;
 
 		ret = ice_set_dcb_cfg(port_info);
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 13b1a41d3b..1579be5a95 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -910,15 +910,6 @@ struct rte_eth_rss_reta_entry64 {
 	uint16_t reta[RTE_ETH_RETA_GROUP_SIZE];
 };
 
-/**
- * This enum indicates the possible number of traffic classes
- * in DCB configurations
- */
-enum rte_eth_nb_tcs {
-	RTE_ETH_4_TCS = 4, /**< 4 TCs with DCB. */
-	RTE_ETH_8_TCS = 8  /**< 8 TCs with DCB. */
-};
-
 /**
  * This enum indicates the possible number of queue pools
  * in VMDq configurations.
@@ -935,7 +926,6 @@ enum rte_eth_nb_pools {
 
 /* This structure may be extended in future. */
 struct rte_eth_dcb_conf {
-	enum rte_eth_nb_tcs nb_tcs; /**< Possible DCB TCs, 4 or 8 TCs */
 	/** Traffic class each UP mapped to.
 	 *  Rx packets VLAN UP for Rx configuration
 	 *  Rx PFC Pause frames UP for Tx configuration
-- 
2.43.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5CCCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 17:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 632E9406A2;
	Sat, 30 Aug 2025 19:17:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 32C3540668
 for <dev@dpdk.org>; Sat, 30 Aug 2025 19:17:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756574244; x=1788110244;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ChQy0PoFKKHn0Brc+VOy+vQLnT/7gp6LRk6/XmXGYwM=;
 b=g4Ka0Aq00XaKNbQuRWOy3JvyHufY6HGwG/5F+hH1Ybo23Gg3Bv+O4b9t
 9HCT3dfPd1WlB6GWDts+N0XQGPlB+PPOC9TBlaGg+BOwHAOEP4uyXFrLm
 mlNyvUy6oDpeYcQZxcLrAnwRUdSzyuOKGTpji7aArXBxBjK5P5yRZCKtL
 xLmMBAEGlU+IBV1K5DQoGMrXHHOOX1+CzpdNL70km4ENsaf3x8Aw/Lo2c
 0oYYt2PupE++cCmTaJgZA8DAohQhbSJStYY/vozC37MNrhAHdaBLIZbnz
 uatlip/OEONsXdnJp05ZcQcB4COCC1hS1UpNB590APQAldBEI2Q4Lfl2Q w==;
X-CSE-ConnectionGUID: vuv0NFPkQE6ssRXHvf6plA==
X-CSE-MsgGUID: 1Fg3Qui5SluxgU4rV/Lu3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58781212"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58781212"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2025 10:17:23 -0700
X-CSE-ConnectionGUID: pYFFWYhJQcyJQzUjLXMyGA==
X-CSE-MsgGUID: KbgZrDrYQRSA3FhjO6Nwzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="174966913"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2025 10:17:21 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: [RFC PATCH 6/6] ethdev: move mq_mode to [r,t]x_adv_conf
Date: Sat, 30 Aug 2025 17:17:06 +0000
Message-ID: <20250830171706.428977-7-vladimir.medvedkin@intel.com>
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

Currently mq_mode for Rx and Tx side is located inside
rte_eth_[r,t]xmode. This seems questionable, because most of the
information in that structure is not related to anything multiqueue, and
advanced Rx/Tx configuration seems like a better place to put it. Also,
change type from enum to uint32_t to make it explicit that VMDq/DCB
configuration can be used independently from each other, which implies a
flag field and not an enum.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/graph/ethdev.c                       |  6 +--
 app/test-eventdev/test_perf_common.c     |  4 +-
 app/test-eventdev/test_pipeline_common.c |  4 +-
 app/test-pipeline/init.c                 |  2 +-
 app/test-pmd/parameters.c                |  4 +-
 app/test-pmd/testpmd.c                   | 27 ++++++-------
 app/test-pmd/testpmd.h                   |  2 +-
 app/test/test_event_eth_rx_adapter.c     |  4 +-
 app/test/test_link_bonding.c             |  4 +-
 app/test/test_link_bonding_rssconf.c     |  8 ++--
 app/test/test_pmd_perf.c                 |  4 +-
 app/test/test_security_inline_macsec.c   | 12 ++++--
 app/test/test_security_inline_proto.c    | 12 ++++--
 drivers/net/intel/ice/ice_dcf.c          |  2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c   |  2 +-
 drivers/net/intel/ice/ice_ethdev.c       |  8 ++--
 lib/ethdev/ethdev_trace.h                |  4 +-
 lib/ethdev/rte_ethdev.c                  | 10 ++---
 lib/ethdev/rte_ethdev.h                  | 48 +++++++++---------------
 19 files changed, 77 insertions(+), 90 deletions(-)

diff --git a/app/graph/ethdev.c b/app/graph/ethdev.c
index 2f4cf65c96..42739a4267 100644
--- a/app/graph/ethdev.c
+++ b/app/graph/ethdev.c
@@ -44,17 +44,17 @@ cmd_ethdev_forward_help[] = "ethdev forward <tx_dev_name> <rx_dev_name>";
 static struct rte_eth_conf port_conf_default = {
 	.link_speeds = 0,
 	.rxmode = {
-		.mq_mode = RTE_ETH_MQ_RX_NONE,
 		.mtu = 9000 - (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN), /* Jumbo frame MTU */
 	},
 	.rx_adv_conf = {
+		.mq_mode = RTE_ETH_MQ_RX_NONE,
 		.rss_conf = {
 			.rss_key = NULL,
 			.rss_key_len = 40,
 			.rss_hf = 0,
 		},
 	},
-	.txmode = {
+	.tx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 	.lpbk_mode = 0,
@@ -426,7 +426,7 @@ ethdev_process(const char *name, struct ethdev_config *params)
 	if (rss) {
 		uint64_t rss_hf = RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP;
 
-		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
+		port_conf.rx_adv_conf.mq_mode = RTE_ETH_MQ_RX_RSS;
 		port_conf.rx_adv_conf.rss_conf.rss_hf = rss_hf & port_info.flow_type_rss_offloads;
 	}
 
diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index f77557e765..c79a733cc9 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -1884,10 +1884,8 @@ perf_ethdev_setup(struct evt_test *test, struct evt_options *opt)
 	int ret;
 	struct test_perf *t = evt_test_priv(test);
 	struct rte_eth_conf port_conf = {
-		.rxmode = {
-			.mq_mode = RTE_ETH_MQ_RX_RSS,
-		},
 		.rx_adv_conf = {
+			.mq_mode = RTE_ETH_MQ_RX_RSS,
 			.rss_conf = {
 				.rss_key = NULL,
 				.rss_hf = RTE_ETH_RSS_IP,
diff --git a/app/test-eventdev/test_pipeline_common.c b/app/test-eventdev/test_pipeline_common.c
index c1382ac188..7c2cfdc9de 100644
--- a/app/test-eventdev/test_pipeline_common.c
+++ b/app/test-eventdev/test_pipeline_common.c
@@ -313,10 +313,8 @@ pipeline_ethdev_setup(struct evt_test *test, struct evt_options *opt)
 	struct test_pipeline *t = evt_test_priv(test);
 	struct rte_eth_rxconf rx_conf;
 	struct rte_eth_conf port_conf = {
-		.rxmode = {
-			.mq_mode = RTE_ETH_MQ_RX_RSS,
-		},
 		.rx_adv_conf = {
+			.mq_mode = RTE_ETH_MQ_RX_RSS,
 			.rss_conf = {
 				.rss_key = NULL,
 				.rss_hf = RTE_ETH_RSS_IP,
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..35917dec76 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -76,7 +76,7 @@ static struct rte_eth_conf port_conf = {
 			.rss_hf = RTE_ETH_RSS_IP,
 		},
 	},
-	.txmode = {
+	.tx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 };
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 1132972913..4de514ecf7 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -1713,8 +1713,8 @@ launch_args_parse(int argc, char** argv)
 			char *end = NULL;
 
 			n = strtoul(optarg, &end, 16);
-			if (n >= 0 && n <= RTE_ETH_MQ_RX_VMDQ_DCB_RSS)
-				rx_mq_mode = (enum rte_eth_rx_mq_mode)n;
+			if (n >= 0 && n <= (int)RTE_ETH_MQ_RX_VMDQ_DCB_RSS)
+				rx_mq_mode = n;
 			else
 				rte_exit(EXIT_FAILURE,
 					"rx-mq-mode must be >= 0 and <= %d\n",
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 8602781aac..3f1ab6ce5a 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -544,7 +544,7 @@ uint8_t gro_flush_cycles = GRO_DEFAULT_FLUSH_CYCLES;
 /*
  * hexadecimal bitmask of RX mq mode can be enabled.
  */
-enum rte_eth_rx_mq_mode rx_mq_mode = RTE_ETH_MQ_RX_VMDQ_DCB_RSS;
+uint32_t rx_mq_mode = RTE_ETH_MQ_RX_VMDQ_DCB_RSS;
 
 /*
  * Used to set forced link speed
@@ -4018,11 +4018,10 @@ init_port_config(void)
 
 		if (port->dcb_flag == 0) {
 			if (port->dev_conf.rx_adv_conf.rss_conf.rss_hf != 0) {
-				port->dev_conf.rxmode.mq_mode =
-					(enum rte_eth_rx_mq_mode)
-						(rx_mq_mode & RTE_ETH_MQ_RX_RSS);
+				port->dev_conf.rx_adv_conf.mq_mode =
+					(rx_mq_mode & RTE_ETH_MQ_RX_RSS);
 			} else {
-				port->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+				port->dev_conf.rx_adv_conf.mq_mode = RTE_ETH_MQ_RX_NONE;
 				port->dev_conf.rxmode.offloads &=
 						~RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
@@ -4147,10 +4146,8 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		}
 
 		/* set DCB mode of RX and TX of multiple queues */
-		eth_conf->rxmode.mq_mode =
-				(enum rte_eth_rx_mq_mode)
-					(rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_DCB);
-		eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_VMDQ_DCB;
+		eth_conf->rx_adv_conf.mq_mode = (rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_DCB);
+		eth_conf->tx_adv_conf.mq_mode = RTE_ETH_MQ_TX_VMDQ_DCB;
 	} else {
 		struct rte_eth_dcb_conf *rx_conf =
 				&eth_conf->rx_adv_conf.dcb_rx_conf;
@@ -4188,10 +4185,8 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 			tx_conf->dcb_tc_bw[i]++;
 		}
 
-		eth_conf->rxmode.mq_mode =
-				(enum rte_eth_rx_mq_mode)
-					(rx_mq_mode & RTE_ETH_MQ_RX_DCB_RSS);
-		eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_DCB;
+		eth_conf->rx_adv_conf.mq_mode = (rx_mq_mode & RTE_ETH_MQ_RX_DCB_RSS);
+		eth_conf->tx_adv_conf.mq_mode = RTE_ETH_MQ_TX_DCB;
 	}
 
 }
@@ -4201,8 +4196,8 @@ clear_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf)
 {
 	uint32_t i;
 
-	eth_conf->rxmode.mq_mode &= ~(RTE_ETH_MQ_RX_DCB | RTE_ETH_MQ_RX_VMDQ_DCB);
-	eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_NONE;
+	eth_conf->rx_adv_conf.mq_mode &= ~(RTE_ETH_MQ_RX_DCB | RTE_ETH_MQ_RX_VMDQ_DCB);
+	eth_conf->tx_adv_conf.mq_mode = RTE_ETH_MQ_TX_NONE;
 	if (dcb_config) {
 		/* Unset VLAN filter configuration if already config DCB. */
 		eth_conf->rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
@@ -4262,7 +4257,7 @@ init_port_dcb_config(portid_t pid,
 		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, prio_tc, prio_tc_en);
 		port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
 		/* remove RSS HASH offload for DCB in vt mode */
-		if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
+		if (port_conf.rx_adv_conf.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
 			port_conf.rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_RSS_HASH;
 			for (i = 0; i < nb_rxq; i++)
 				rte_port->rxq[i].conf.offloads &=
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index bb1aaec918..4f87a6147f 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -814,7 +814,7 @@ struct mplsoudp_decap_conf {
 };
 extern struct mplsoudp_decap_conf mplsoudp_decap_conf;
 
-extern enum rte_eth_rx_mq_mode rx_mq_mode;
+extern uint32_t rx_mq_mode;
 
 extern struct rte_flow_action_conntrack conntrack_context;
 
diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index 9f8c8c1b26..f7d94790af 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -123,7 +123,7 @@ static inline int
 port_init_rx_intr(uint16_t port, struct rte_mempool *mp)
 {
 	static const struct rte_eth_conf port_conf_default = {
-		.rxmode = {
+		.rx_adv_conf = {
 			.mq_mode = RTE_ETH_MQ_RX_NONE,
 		},
 		.intr_conf = {
@@ -138,7 +138,7 @@ static inline int
 port_init(uint16_t port, struct rte_mempool *mp)
 {
 	static const struct rte_eth_conf port_conf_default = {
-		.rxmode = {
+		.rx_adv_conf = {
 			.mq_mode = RTE_ETH_MQ_RX_NONE,
 		},
 	};
diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index 19b064771a..50b7e18f0e 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -135,10 +135,10 @@ static uint16_t dst_port_1 = 2024;
 static uint16_t vlan_id = 0x100;
 
 static struct rte_eth_conf default_pmd_conf = {
-	.rxmode = {
+	.rx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_RX_NONE,
 	},
-	.txmode = {
+	.tx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 	.lpbk_mode = 0,
diff --git a/app/test/test_link_bonding_rssconf.c b/app/test/test_link_bonding_rssconf.c
index 2cb689b1de..b16380fb34 100644
--- a/app/test/test_link_bonding_rssconf.c
+++ b/app/test/test_link_bonding_rssconf.c
@@ -79,20 +79,20 @@ static struct link_bonding_rssconf_unittest_params test_params  = {
  * Default port configuration with RSS turned off
  */
 static struct rte_eth_conf default_pmd_conf = {
-	.rxmode = {
+	.rx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_RX_NONE,
 	},
-	.txmode = {
+	.tx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 	.lpbk_mode = 0,
 };
 
 static struct rte_eth_conf rss_pmd_conf = {
-	.rxmode = {
+	.rx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_RX_RSS,
 	},
-	.txmode = {
+	.tx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 	.rx_adv_conf = {
diff --git a/app/test/test_pmd_perf.c b/app/test/test_pmd_perf.c
index 995b0a6f20..58943d5294 100644
--- a/app/test/test_pmd_perf.c
+++ b/app/test/test_pmd_perf.c
@@ -60,10 +60,10 @@ static struct rte_mempool *mbufpool[NB_SOCKETS];
 static struct rte_ether_addr ports_eth_addr[RTE_MAX_ETHPORTS];
 
 static struct rte_eth_conf port_conf = {
-	.rxmode = {
+	.rx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_RX_NONE,
 	},
-	.txmode = {
+	.tx_adv_conf = {
 		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 	.lpbk_mode = 1,  /* enable loopback */
diff --git a/app/test/test_security_inline_macsec.c b/app/test/test_security_inline_macsec.c
index 4043667701..4385343d41 100644
--- a/app/test/test_security_inline_macsec.c
+++ b/app/test/test_security_inline_macsec.c
@@ -78,14 +78,18 @@ struct mcs_test_opts {
 
 static struct rte_eth_conf port_conf = {
 	.rxmode = {
-		.mq_mode = RTE_ETH_MQ_RX_NONE,
 		.offloads = RTE_ETH_RX_OFFLOAD_CHECKSUM |
-			    RTE_ETH_RX_OFFLOAD_MACSEC_STRIP,
+		RTE_ETH_RX_OFFLOAD_MACSEC_STRIP,
+	},
+	.rx_adv_conf = {
+		.mq_mode = RTE_ETH_MQ_RX_NONE,
 	},
 	.txmode = {
-		.mq_mode = RTE_ETH_MQ_TX_NONE,
 		.offloads = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |
-			    RTE_ETH_TX_OFFLOAD_MACSEC_INSERT,
+		RTE_ETH_TX_OFFLOAD_MACSEC_INSERT,
+	},
+	.tx_adv_conf = {
+		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 	.lpbk_mode = 1,  /* enable loopback */
 };
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 04ecfd02c6..01e3b0a9cb 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -88,14 +88,18 @@ static struct rte_ether_addr ports_eth_addr[RTE_MAX_ETHPORTS];
 
 static struct rte_eth_conf port_conf = {
 	.rxmode = {
-		.mq_mode = RTE_ETH_MQ_RX_NONE,
 		.offloads = RTE_ETH_RX_OFFLOAD_CHECKSUM |
-			    RTE_ETH_RX_OFFLOAD_SECURITY,
+			RTE_ETH_RX_OFFLOAD_SECURITY,
+	},
+	.rx_adv_conf = {
+		.mq_mode = RTE_ETH_MQ_RX_NONE,
 	},
 	.txmode = {
-		.mq_mode = RTE_ETH_MQ_TX_NONE,
 		.offloads = RTE_ETH_TX_OFFLOAD_SECURITY |
-			    RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE,
+			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE,
+	},
+	.tx_adv_conf = {
+		.mq_mode = RTE_ETH_MQ_TX_NONE,
 	},
 	.lpbk_mode = 1,  /* enable loopback */
 };
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 51716a4d5b..363d0ed598 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1113,7 +1113,7 @@ ice_dcf_init_rss(struct ice_dcf_hw *hw)
 		PMD_DRV_LOG(DEBUG, "RSS is not supported");
 		return -ENOTSUP;
 	}
-	if (dev->data->dev_conf.rxmode.mq_mode != RTE_ETH_MQ_RX_RSS) {
+	if (dev->data->dev_conf.rx_adv_conf.mq_mode != RTE_ETH_MQ_RX_RSS) {
 		PMD_DRV_LOG(WARNING, "RSS is enabled by PF by default");
 		/* set all lut items to default queue */
 		memset(hw->rss_lut, 0, hw->vf_res->rss_lut_size);
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 499062be40..bd929b9f1f 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -709,7 +709,7 @@ ice_dcf_dev_configure(struct rte_eth_dev *dev)
 	ad->rx_bulk_alloc_allowed = true;
 	ad->tx_simple_allowed = true;
 
-	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
+	if (dev->data->dev_conf.rx_adv_conf.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
 	return 0;
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 27559bbe18..8234b35d10 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2888,8 +2888,8 @@ ice_deinit_dcb(struct rte_eth_dev *dev)
 	u8 max_tcs = local_dcb_conf->etscfg.maxtcs;
 	u8 tc;
 
-	if (!(dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG ||
-			dev->data->dev_conf.txmode.mq_mode == RTE_ETH_MQ_TX_DCB))
+	if (!(dev->data->dev_conf.rx_adv_conf.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG ||
+			dev->data->dev_conf.tx_adv_conf.mq_mode == RTE_ETH_MQ_TX_DCB))
 		return;
 
 	for (i = 0; i < max_tcs; i++) {
@@ -3823,7 +3823,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
 	ad->rx_bulk_alloc_allowed = true;
 	ad->tx_simple_allowed = true;
 
-	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
+	if (dev->data->dev_conf.rx_adv_conf.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
 	if (dev->data->nb_rx_queues) {
@@ -3834,7 +3834,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
+	if (dev->data->dev_conf.rx_adv_conf.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
 		struct ice_hw *hw = ICE_PF_TO_HW(pf);
 		struct ice_vsi *vsi = pf->main_vsi;
 		struct ice_port_info *port_info = hw->port_info;
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 482befc209..305ae4ba58 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -30,11 +30,11 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_u16(nb_rx_q);
 	rte_trace_point_emit_u16(nb_tx_q);
 	rte_trace_point_emit_u32(dev_conf->link_speeds);
-	rte_trace_point_emit_u32(dev_conf->rxmode.mq_mode);
+	rte_trace_point_emit_u32(dev_conf->rx_adv_conf.mq_mode);
 	rte_trace_point_emit_u32(dev_conf->rxmode.mtu);
 	rte_trace_point_emit_u32(dev_conf->rxmode.max_lro_pkt_size);
 	rte_trace_point_emit_u64(dev_conf->rxmode.offloads);
-	rte_trace_point_emit_u32(dev_conf->txmode.mq_mode);
+	rte_trace_point_emit_u32(dev_conf->tx_adv_conf.mq_mode);
 	rte_trace_point_emit_u64(dev_conf->txmode.offloads);
 	rte_trace_point_emit_u32(dev_conf->lpbk_mode);
 	rte_trace_point_emit_int(rc);
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..3fc8030cd0 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1547,7 +1547,7 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 	}
 
 	/* Check if Rx RSS distribution is disabled but RSS hash is enabled. */
-	if (((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) == 0) &&
+	if (((dev_conf->rx_adv_conf.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) == 0) &&
 	    (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH)) {
 		RTE_ETHDEV_LOG_LINE(ERR,
 			"Ethdev port_id=%u config invalid Rx mq_mode without RSS but %s offload is requested",
@@ -4916,7 +4916,7 @@ rte_eth_dev_rss_reta_update(uint16_t port_id,
 			    struct rte_eth_rss_reta_entry64 *reta_conf,
 			    uint16_t reta_size)
 {
-	enum rte_eth_rx_mq_mode mq_mode;
+	uint32_t mq_mode;
 	struct rte_eth_dev *dev;
 	int ret;
 
@@ -4948,7 +4948,7 @@ rte_eth_dev_rss_reta_update(uint16_t port_id,
 	if (ret < 0)
 		return ret;
 
-	mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+	mq_mode = dev->data->dev_conf.rx_adv_conf.mq_mode;
 	if (!(mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Multi-queue RSS mode isn't enabled.");
 		return -ENOTSUP;
@@ -5003,7 +5003,7 @@ rte_eth_dev_rss_hash_update(uint16_t port_id,
 {
 	struct rte_eth_dev *dev;
 	struct rte_eth_dev_info dev_info = { .flow_type_rss_offloads = 0, };
-	enum rte_eth_rx_mq_mode mq_mode;
+	uint32_t mq_mode;
 	int ret;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
@@ -5030,7 +5030,7 @@ rte_eth_dev_rss_hash_update(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+	mq_mode = dev->data->dev_conf.rx_adv_conf.mq_mode;
 	if (!(mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Multi-queue RSS mode isn't enabled.");
 		return -ENOTSUP;
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 60532e0155..ae8cc5e8ba 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -377,7 +377,7 @@ struct rte_eth_thresh {
 };
 
 /**@{@name Multi-queue mode
- * @see rte_eth_conf.rxmode.mq_mode.
+ * @see rte_eth_conf.rx_adv_conf.mq_mode.
  */
 #define RTE_ETH_MQ_RX_RSS_FLAG  RTE_BIT32(0) /**< Enable RSS. @see rte_eth_rss_conf */
 #define RTE_ETH_MQ_RX_DCB_FLAG  RTE_BIT32(1) /**< Enable DCB. */
@@ -388,45 +388,32 @@ struct rte_eth_thresh {
  *  A set of values to identify what method is to be used to route
  *  packets to multiple queues.
  */
-enum rte_eth_rx_mq_mode {
-	/** None of DCB, RSS or VMDq mode */
-	RTE_ETH_MQ_RX_NONE = 0,
-
-	/** For Rx side, only RSS is on */
-	RTE_ETH_MQ_RX_RSS = RTE_ETH_MQ_RX_RSS_FLAG,
-	/** For Rx side,only DCB is on. */
-	RTE_ETH_MQ_RX_DCB = RTE_ETH_MQ_RX_DCB_FLAG,
-	/** Both DCB and RSS enable */
-	RTE_ETH_MQ_RX_DCB_RSS = RTE_ETH_MQ_RX_RSS_FLAG | RTE_ETH_MQ_RX_DCB_FLAG,
-
-	/** Only VMDq, no RSS nor DCB */
-	RTE_ETH_MQ_RX_VMDQ_ONLY = RTE_ETH_MQ_RX_VMDQ_FLAG,
-	/** RSS mode with VMDq */
-	RTE_ETH_MQ_RX_VMDQ_RSS = RTE_ETH_MQ_RX_RSS_FLAG | RTE_ETH_MQ_RX_VMDQ_FLAG,
-	/** Use VMDq+DCB to route traffic to queues */
-	RTE_ETH_MQ_RX_VMDQ_DCB = RTE_ETH_MQ_RX_VMDQ_FLAG | RTE_ETH_MQ_RX_DCB_FLAG,
-	/** Enable both VMDq and DCB in VMDq */
-	RTE_ETH_MQ_RX_VMDQ_DCB_RSS = RTE_ETH_MQ_RX_RSS_FLAG | RTE_ETH_MQ_RX_DCB_FLAG |
-				 RTE_ETH_MQ_RX_VMDQ_FLAG,
-};
+#define RTE_ETH_MQ_RX_NONE	0
+#define RTE_ETH_MQ_RX_RSS	(RTE_ETH_MQ_RX_RSS_FLAG)
+#define RTE_ETH_MQ_RX_DCB	(RTE_ETH_MQ_RX_DCB_FLAG)
+#define RTE_ETH_MQ_RX_VMDQ_ONLY	(RTE_ETH_MQ_RX_VMDQ_FLAG)
+#define RTE_ETH_MQ_RX_DCB_RSS	(RTE_ETH_MQ_RX_RSS_FLAG | RTE_ETH_MQ_RX_DCB_FLAG)
+#define RTE_ETH_MQ_RX_VMDQ_RSS	(RTE_ETH_MQ_RX_RSS_FLAG | RTE_ETH_MQ_RX_VMDQ_FLAG)
+#define RTE_ETH_MQ_RX_VMDQ_DCB	(RTE_ETH_MQ_RX_VMDQ_FLAG | RTE_ETH_MQ_RX_DCB_FLAG)
+#define RTE_ETH_MQ_RX_VMDQ_DCB_RSS	(RTE_ETH_MQ_RX_RSS_FLAG|RTE_ETH_MQ_RX_DCB_FLAG|	\
+					RTE_ETH_MQ_RX_VMDQ_FLAG)
+#define RTE_ETH_MQ_RX_FLAG_MASK	RTE_ETH_MQ_RX_VMDQ_DCB_RSS
 
 /**
  * A set of values to identify what method is to be used to transmit
  * packets using multi-TCs.
  */
-enum rte_eth_tx_mq_mode {
-	RTE_ETH_MQ_TX_NONE    = 0,  /**< It is in neither DCB nor VT mode. */
-	RTE_ETH_MQ_TX_DCB,          /**< For Tx side,only DCB is on. */
-	RTE_ETH_MQ_TX_VMDQ_DCB,     /**< For Tx side,both DCB and VT is on. */
-	RTE_ETH_MQ_TX_VMDQ_ONLY,    /**< Only VT on, no DCB */
-};
+#define RTE_ETH_MQ_TX_NONE	0
+#define RTE_ETH_MQ_TX_DCB	RTE_BIT32(0)
+#define RTE_ETH_MQ_TX_VMDQ	RTE_BIT32(1)
+#define RTE_ETH_MQ_TX_VMDQ_DCB	(RTE_ETH_MQ_TX_DCB|RTE_ETH_MQ_TX_VMDQ)
+#define RTE_ETH_MQ_TX_FLAG_MASK	RTE_ETH_MQ_TX_VMDQ_DCB
 
 /**
  * A structure used to configure the Rx features of an Ethernet port.
  */
 struct rte_eth_rxmode {
 	/** The multi-queue packet distribution mode to be used, e.g. RSS. */
-	enum rte_eth_rx_mq_mode mq_mode;
 	uint32_t mtu;  /**< Requested MTU. */
 	/** Maximum allowed size of LRO aggregated packet. */
 	uint32_t max_lro_pkt_size;
@@ -972,7 +959,6 @@ struct rte_eth_vmdq_rx_conf {
  * A structure used to configure the Tx features of an Ethernet port.
  */
 struct rte_eth_txmode {
-	enum rte_eth_tx_mq_mode mq_mode; /**< Tx multi-queues mode. */
 	/**
 	 * Per-port Tx offloads to be set using RTE_ETH_TX_OFFLOAD_* flags.
 	 * Only offloads set on tx_offload_capa field on rte_eth_dev_info
@@ -1509,6 +1495,7 @@ struct rte_eth_conf {
 				 are defined in implementation of each driver. */
 	struct rte_eth_dcb_tc_queue_mapping q_map;
 	struct {
+		uint32_t mq_mode;	/**< Rx multi-queues mode. */
 		struct rte_eth_rss_conf rss_conf; /**< Port RSS configuration */
 		/** Port DCB Rx configuration. */
 		struct rte_eth_dcb_conf dcb_rx_conf;
@@ -1517,6 +1504,7 @@ struct rte_eth_conf {
 		/* VMDQ and DCB Rx queue mapping configuration. */
 	} rx_adv_conf; /**< Port Rx filtering configuration. */
 	struct {
+		uint32_t mq_mode; /**< Tx multi-queues mode. */
 		/** Port DCB Tx configuration. */
 		struct rte_eth_dcb_conf dcb_tx_conf;
 		/** Port VMDq Tx configuration. */
-- 
2.43.0


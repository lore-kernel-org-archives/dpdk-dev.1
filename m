Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA660A1DB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=al8MC6N8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FDC9402E3;
	Mon,  2 Nov 2026 16:36:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 077CF4028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633774; x=1825169774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/vmhiksH5bw/Va0DrsROND00PeYLv4GpNNRodP+nRTw=;
 b=al8MC6N8eKupyBJ4qCcJuC7ikXt9X1mR76Iae77whWos6m8j7hu2Gclu
 oSmS0fafpH4PhTGjReRpunzibnlXLjlp1noWrRU72ozln6k63NseOq1By
 S+gkNLdLedWeberAwMzNamhi2MANR+6ocXIBHOrJTi7atXXinDoCeJk6x
 p2J9aRN6+vpP95z8SaHB6/MtC8kHvNm7xbhtxCaunNxHNZzMCI3pv9ceS
 /iZAQu2fjJZkWsNclehN29AQmkxquR+0HWnanMdc11xGZ8Q8YkzCN5h0/
 2AgrraHY6JkNKq0NvTstXRk9OpEJLa7m6oBqClrTPYWbps+hh6ecGU5xe g==;
X-CSE-ConnectionGUID: gcL/E8P/QwytLh4+JnmpUA==
X-CSE-MsgGUID: JiVIwaqhQA6eNVKokyp9SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2209612"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2209612"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:36:12 -0800
X-CSE-ConnectionGUID: YaBttivNT+SJ4m0uamhYQg==
X-CSE-MsgGUID: LX2t/NSbSiKcTBsrWhK4oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6006469"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 02 Nov 2026 07:36:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] net/ice: add explicit control of link auto-negotiation
Date: Mon,  2 Nov 2026 15:36:02 +0000
Message-ID: <20261102153602.2804158-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030132616.2066712-1-bruce.richardson@intel.com>
References: <20261030132616.2066712-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When selecting a fixed speed of the link, whether or not
autonegotiation (e.g. AN Clause 37, etc.), needs to be enabled depends
on the peer link. While commit 3dc2933866d9 ("net/ice: disable link
negotiation for fixed speed selection") would allow link setup when the
remote side also has a fixed link without AN37 auto-negotiation, it
causes the link to flap up and down when e.g. two ports are connected
back to back and only one is set to a fixed speed.

Support both scenarios of auto-negotiation supported or unsupported on
the remote end by adding an explicit driver option for disabling
auto-negotiation when a fixed speed is selected. If no fixed speed
setting, then new option does nothing.

Fixes: 3dc2933866d9 ("net/ice: disable link negotiation for fixed speed selection")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/ice.rst                | 10 ++++++++++
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/intel/ice/ice_ethdev.c     | 23 +++++++++++++++++++----
 drivers/net/intel/ice/ice_ethdev.h     |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index faebfdcb63..15388f0185 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -107,6 +107,16 @@ Configuration
 Runtime Configuration
 ~~~~~~~~~~~~~~~~~~~~~
 
+``auto_neg_disable`` (default ``0``)
+   Control hardware link negotiation when a fixed speed is requested with ``RTE_ETH_LINK_SPEED_FIXED``.
+   By default, the firmware's negotiation settings are preserved,
+   allowing a fixed-speed link to use negotiation such as Clause 37 when required by its peer.
+   Set ``auto_neg_disable=1`` to disable Clause 28, Clause 37 and Clause 73 negotiation.
+   This option has no effect when automatic speed selection is requested.
+   For example::
+
+      -a 80:00.0,auto_neg_disable=1
+
 - ``Safe Mode Support`` (default ``0``)
 
   If driver failed to load OS package, by default driver's initialization failed.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9e120ec221..96bd0ed7ca 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -175,6 +175,8 @@ New Features
 
 * **Updated Intel ice driver.**
 
+  * Added ``auto_neg_disable`` devarg to disable hardware link negotiation for fixed-speed links.
+    By default, fixed-speed links now preserve the firmware's negotiation settings.
   * Added chip temperature to the extended statistics.
   * Added Tx context descriptor support to the AVX2 and AVX512 vector Tx paths,
     enabling QinQ tag insertion and outer IPv4/UDP checksum offloads on those paths.
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index d2ba64efb6..b18b4bbb05 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -45,6 +45,7 @@
 #define ICE_RL_BURST_SIZE_ARG     "rl_burst_size"
 #define ICE_SOURCE_PRUNE_ARG      "source-prune"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
+#define ICE_AUTO_NEG_DISABLE_ARG  "auto_neg_disable"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
 
@@ -64,6 +65,7 @@ static const char * const ice_valid_args[] = {
 	ICE_RL_BURST_SIZE_ARG,
 	ICE_SOURCE_PRUNE_ARG,
 	ICE_LINK_STATE_ON_CLOSE,
+	ICE_AUTO_NEG_DISABLE_ARG,
 	NULL
 };
 
@@ -2542,6 +2544,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
+	if (ret)
+		goto bail;
+
+	ret = rte_kvargs_process(kvlist, ICE_AUTO_NEG_DISABLE_ARG,
+				 &parse_bool, &ad->devargs.auto_neg_disable);
 
 bail:
 	rte_kvargs_free(kvlist);
@@ -5092,6 +5099,15 @@ ice_atomic_write_link_status(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static bool
+ice_link_autoneg_enabled(const struct rte_eth_dev *dev)
+{
+	const struct ice_adapter *ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+
+	return !ad->devargs.auto_neg_disable ||
+			(dev->data->dev_conf.link_speeds & RTE_ETH_LINK_SPEED_FIXED) == 0;
+}
+
 static int
 ice_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 {
@@ -5180,8 +5196,7 @@ ice_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 		break;
 	}
 
-	link.link_autoneg = !(dev->data->dev_conf.link_speeds &
-			      RTE_ETH_LINK_SPEED_FIXED);
+	link.link_autoneg = ice_link_autoneg_enabled(dev);
 
 out:
 	ice_atomic_write_link_status(dev, &link);
@@ -5248,8 +5263,7 @@ ice_apply_link_speed(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	bool link_autoneg = (conf->link_speeds & RTE_ETH_LINK_SPEED_FIXED) == 0;
-	return ice_phy_conf_link(hw, speed, true, link_autoneg);
+	return ice_phy_conf_link(hw, speed, true, ice_link_autoneg_enabled(dev));
 }
 
 static int
@@ -8198,6 +8212,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_RL_BURST_SIZE_ARG "=<N>"
 			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
 			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
+			      ICE_AUTO_NEG_DISABLE_ARG "=<0|1>"
 			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
 
 RTE_LOG_REGISTER_SUFFIX(ice_logtype_init, init, NOTICE);
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 945e765c2c..747c003bb3 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -634,6 +634,7 @@ struct ice_pf {
 struct ice_devargs {
 	bool rx_low_latency;
 	bool safe_mode_support;
+	bool auto_neg_disable;
 	uint8_t proto_xtr_dflt;
 	bool default_mac_disable;
 	uint8_t proto_xtr[ICE_MAX_QUEUE_NUM];
-- 
2.55.0


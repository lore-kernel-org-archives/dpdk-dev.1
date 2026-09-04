Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF3C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D76242EF6;
	Fri,  4 Sep 2026 12:52:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EA2C742EDC;
 Fri,  4 Sep 2026 12:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788519149; x=1820055149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FuayttlVRkzjWpu3wCnhIlUnes6p4hdeViMmjWo8yiI=;
 b=Z4qniEJupTj/SmfzbdTI3zFhiMay3IOKtEZ5eV3+/V3lC5a98gwt2ugV
 yUcOv73FTX7YO7PKYRKTtm8CfCmELOgEq0EXlbV4GUlq8K4Jcuq3DNh54
 t824WEGI1sZHdIGJHTPuuMQSj+Pt0dN/VGv5qnlNUJ1W6rjYSi43qwA3N
 vp10ABbuHrMUgBr3k86/eJ25N0lviIhFgf2mMRP21BjFVgRLh1jSdh3x7
 +FprcmyPAKQy7Q3KGH0NF/5F4ZAksAVSR8V9AsWK4eh4U9xNyDt4j+SWZ
 2d7LpvL1VIrKn5P/r/CBnGe/XRONku397oI3O1N/uQvjo8qHtiFh3SFzt w==;
X-CSE-ConnectionGUID: 2eZGM8/mSv2hZy1MrG/lng==
X-CSE-MsgGUID: xa6N5eHmS6OihEiAvRoEFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76573770"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76573770"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:52:29 -0700
X-CSE-ConnectionGUID: aJgtAAs4TnaAQh8VS47mUg==
X-CSE-MsgGUID: 9a1PgHqkQJy1cGRqMI9WHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="308223640"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa001.jf.intel.com with ESMTP; 04 Sep 2026 03:52:27 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/3] net/ice: skip TC validation if hierarchy committed
Date: Fri,  4 Sep 2026 10:51:38 +0000
Message-ID: <20260904105139.3117640-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904105139.3117640-1-ciara.loftus@intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
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

Currently, ice_tx_queue_start() determines a queue's congestion domain by
scanning vsi->info.tc_mapping[] for a matching traffic class range,
rejecting the queue if no match is found.

The Tx scheduler hierarchies only ever operate on a single traffic class,
TC0, so every queue managed by a committed TM hierarchy always belongs
to domain 0. The tc_mapping[] lookup doesn't account for this, and queues
added after a TM hierarchy is committed can be incorrectly rejected.

Fix this by skipping the lookup if a hierarchy has been committed as the
domain is already known to be 0 in that case. Since TM does not support
DCB's multi-TC queue layout, also reject queue start explicitly if DCB
has configured more than one TC while a TM hierarchy is committed.

Fixes: 02b71e570294 ("net/ice: support DCB")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c |  4 ++++
 drivers/net/intel/ice/ice_ethdev.h |  2 ++
 drivers/net/intel/ice/ice_rxtx.c   | 33 ++++++++++++++++++------------
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72e..fd148848d3c 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3963,6 +3963,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
 	ad->rx_func_type = ICE_RX_DEFAULT;
 	ad->tx_func_type = ICE_TX_DEFAULT;
 
+	pf->dcb_num_tcs = 1;
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
@@ -3992,6 +3994,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
 		if (nb_tc_used < 0)
 			return -EINVAL;
 
+		pf->dcb_num_tcs = nb_tc_used;
+
 		ctxt.info = vsi->info;
 		if (rte_le_to_cpu_16(ctxt.info.mapping_flags) == ICE_AQ_VSI_Q_MAP_NONCONTIG) {
 			PMD_DRV_LOG(ERR, "VSI configured with non contiguous queues, DCB is not supported");
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a709..5914454c7c2 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -609,6 +609,8 @@ struct ice_pf {
 	uint64_t rss_hf;
 	struct ice_tm_conf tm_conf;
 	uint16_t outer_ethertype;
+	/* Number of TCs requested, 1 if DCB not configured */
+	uint8_t dcb_num_tcs;
 	/* lock prevent race condition between lsc interrupt handler
 	 * and link status update during dev_start.
 	 */
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c530..71f9155e588 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -839,20 +839,27 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	tx_ctx.legacy_int = 1; /* Legacy or Advanced Host Interface */
 	tx_ctx.tsyn_ena = 1;
 
-	/* Mirror RXQ<->CGD association to TXQ<->CGD */
-	for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
-		q_base = rte_le_to_cpu_16(vsi->info.tc_mapping[i]) & ICE_AQ_VSI_TC_Q_OFFSET_M;
-		q_range = 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
-			ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
-
-		if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
-			break;
-
-		cgd_idx++;
-	}
+	if (!pf->tm_conf.committed) {
+		/* Mirror RXQ<->CGD association to TXQ<->CGD */
+		for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+			q_base = rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
+							ICE_AQ_VSI_TC_Q_OFFSET_M;
+			q_range = 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
+				ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
+
+			if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
+				break;
 
-	if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
-		PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
+			cgd_idx++;
+		}
+		if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
+			PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
+			rte_free(txq_elem);
+			return -EINVAL;
+		}
+	} else if (pf->dcb_num_tcs > 1) {
+		/* TM only manages the TC0 scheduler subtree. */
+		PMD_DRV_LOG(ERR, "TM hierarchy is not supported together with multi-TC DCB");
 		rte_free(txq_elem);
 		return -EINVAL;
 	}
-- 
2.43.0


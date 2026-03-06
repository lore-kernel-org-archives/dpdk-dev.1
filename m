Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85670F01826
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96E1D40A84;
	Fri,  6 Mar 2026 11:58:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9A76040278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794710; x=1804330710;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=X0ccAyEXWzrhK1kPRfaabYmJWpmsWvww/RUrssmzx9Q=;
 b=gw2y7UB87ePU2anx6WFmZi788HaR9uJJERCaWj/JV4dA0GFqqlXbF3+N
 BYErRZ3m2Noj7NyJ83F6C+QfXuT9coOMTf3dpsgI7NjQMNCVsJv+GVy9B
 uUf/Iac7UXP6aN6ysrWabotxFCn5eZPu2Unqsf5VcgyyfBchNytRAFNhj
 4w0lLmH6zbcrSGfBmgR/jz2xxhU5WaZKSLbfvC/vidSdYFLyexp7yUbfr
 c8ioHCScJEXTO6Mm6F7CFhc6m+BegKW1S+vDl9rI7rlfVgxPLA6KYZ88J
 ZrTQGMY79FgwUHBJDKIrzmnOld1TjMI1e5JLh9oVG66aJpKH1hO0aOl7r w==;
X-CSE-ConnectionGUID: Vkvn1LC8RZGw7ugc7XWikQ==
X-CSE-MsgGUID: RhhXJt+SS0icgSpMhU+bsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984542"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984542"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:29 -0800
X-CSE-ConnectionGUID: tMav1QD1Svy6Ev+3Zk0bOQ==
X-CSE-MsgGUID: YDRl72WkQVaiPZDBNz7PJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678382"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:28 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 1/8] net/iavf: avoid passing around pointers
Date: Fri,  6 Mar 2026 10:58:17 +0000
Message-ID: <6aa2ba5f52bef763fab2923f4b74757230c41376.1772794442.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
References: 
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

Currently, when querying the stats for IAVF, we pass a pointer-to-pointer
and then use it as an input for another function. It does not really need
to be a pointer because it is populated from virtchnl command response
anyway. Replace it with passing in a stack-allocated struct, and pass it
into the stats query function.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 34 ++++++++++++++--------------
 drivers/net/intel/iavf/iavf_vchnl.c  |  5 ++--
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 403c61e2e8..b2389e0bbd 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -518,7 +518,7 @@ int iavf_dev_link_update(struct rte_eth_dev *dev,
 			__rte_unused int wait_to_complete);
 void iavf_dev_alarm_handler(void *param);
 int iavf_query_stats(struct iavf_adapter *adapter,
-		    struct virtchnl_eth_stats **pstats);
+		    struct virtchnl_eth_stats *pstats);
 int iavf_config_promisc(struct iavf_adapter *adapter, bool enable_unicast,
 		       bool enable_multicast);
 int iavf_add_del_eth_addr(struct iavf_adapter *adapter,
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..e3690cce11 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1793,7 +1793,7 @@ iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_vsi *vsi = &vf->vsi;
-	struct virtchnl_eth_stats *pstats = NULL;
+	struct virtchnl_eth_stats pstats;
 	int ret;
 
 	ret = iavf_query_stats(adapter, &pstats);
@@ -1801,16 +1801,16 @@ iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		uint8_t crc_stats_len = (dev->data->dev_conf.rxmode.offloads &
 					 RTE_ETH_RX_OFFLOAD_KEEP_CRC) ? 0 :
 					 RTE_ETHER_CRC_LEN;
-		iavf_update_stats(vsi, pstats);
-		stats->ipackets = pstats->rx_unicast + pstats->rx_multicast +
-				pstats->rx_broadcast - pstats->rx_discards;
-		stats->opackets = pstats->tx_broadcast + pstats->tx_multicast +
-						pstats->tx_unicast;
-		stats->imissed = pstats->rx_discards;
-		stats->oerrors = pstats->tx_errors + pstats->tx_discards;
-		stats->ibytes = pstats->rx_bytes;
+		iavf_update_stats(vsi, &pstats);
+		stats->ipackets = pstats.rx_unicast + pstats.rx_multicast +
+				pstats.rx_broadcast - pstats.rx_discards;
+		stats->opackets = pstats.tx_broadcast + pstats.tx_multicast +
+						pstats.tx_unicast;
+		stats->imissed = pstats.rx_discards;
+		stats->oerrors = pstats.tx_errors + pstats.tx_discards;
+		stats->ibytes = pstats.rx_bytes;
 		stats->ibytes -= stats->ipackets * crc_stats_len;
-		stats->obytes = pstats->tx_bytes;
+		stats->obytes = pstats.tx_bytes;
 	} else {
 		PMD_DRV_LOG(ERR, "Get statistics failed");
 	}
@@ -1825,15 +1825,15 @@ iavf_dev_stats_reset(struct rte_eth_dev *dev)
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_vsi *vsi = &vf->vsi;
-	struct virtchnl_eth_stats *pstats = NULL;
+	struct virtchnl_eth_stats stats;
 
 	/* read stat values to clear hardware registers */
-	ret = iavf_query_stats(adapter, &pstats);
+	ret = iavf_query_stats(adapter, &stats);
 	if (ret != 0)
 		return ret;
 
 	/* set stats offset base on current values */
-	vsi->eth_stats_offset.eth_stats = *pstats;
+	vsi->eth_stats_offset.eth_stats = stats;
 
 	return 0;
 }
@@ -1909,21 +1909,21 @@ static int iavf_dev_xstats_get(struct rte_eth_dev *dev,
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_vsi *vsi = &vf->vsi;
-	struct virtchnl_eth_stats *pstats = NULL;
+	struct virtchnl_eth_stats stats;
 	struct iavf_eth_xstats iavf_xtats = {{0}};
 
 	if (n < IAVF_NB_XSTATS)
 		return IAVF_NB_XSTATS;
 
-	ret = iavf_query_stats(adapter, &pstats);
+	ret = iavf_query_stats(adapter, &stats);
 	if (ret != 0)
 		return 0;
 
 	if (!xstats)
 		return 0;
 
-	iavf_update_stats(vsi, pstats);
-	iavf_xtats.eth_stats = *pstats;
+	iavf_update_stats(vsi, &stats);
+	iavf_xtats.eth_stats = stats;
 
 	if (iavf_ipsec_crypto_supported(adapter))
 		iavf_dev_update_ipsec_xstats(dev, &iavf_xtats.ips_stats);
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 08dd6f2d7f..a1dc573841 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1483,7 +1483,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 
 int
 iavf_query_stats(struct iavf_adapter *adapter,
-		struct virtchnl_eth_stats **pstats)
+		struct virtchnl_eth_stats *pstats)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select q_stats;
@@ -1504,10 +1504,9 @@ iavf_query_stats(struct iavf_adapter *adapter,
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to execute command OP_GET_STATS");
-		*pstats = NULL;
 		return err;
 	}
-	*pstats = (struct virtchnl_eth_stats *)args.out_buffer;
+	*pstats = *(struct virtchnl_eth_stats *)args.out_buffer;
 	return 0;
 }
 
-- 
2.47.3


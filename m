Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16263C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 405D640E78;
	Thu, 12 Jun 2025 13:11:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 558ED40E4C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726719; x=1781262719;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bkz9tlymLlmrAwDuhkcRWJw1kwySph8rHoseL3jHbBE=;
 b=Ho6x46NomghioEynsdZoqRtyAbLzxb85X1id2MJ/Ry08P/aXuCWjzH/e
 Lk68wmuAPF6NEIRPvuVWAl4uKsx9pIs02H6doYPL3Ky1qfFCTOYrgrvn8
 J4bh2bhf/12wwCHW7icwft8pl7i4cCZSenq7n+PYOPRCtG2TdxcZ2HoqE
 gtKTAB92AhiftDzbSrB9E2MlwseO/T0qED6H84yidbxfhPd3tJySr4KiB
 cNZY/a/QYaJwMCs8Zw5FtZtJvaAaBM3aTIBj1olYp3t4bPuaywqJa7w7f
 DQLpKJJCKTYhqoEbTkoDxxIpr68rUVBXL639CUE7sJ6K0d1o1QUKJrwLN g==;
X-CSE-ConnectionGUID: 5/uaKre/QzCliorbRloKkA==
X-CSE-MsgGUID: qGG0kjTBTmCrYRQUPUFndg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177528"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177528"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:11:58 -0700
X-CSE-ConnectionGUID: QEByty60Tay6BsY2mPsRyg==
X-CSE-MsgGUID: m7S4GQxlRhyj39/df8FzhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371269"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:11:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 02/33] net/iavf: make IPsec stats dynamically allocated
Date: Thu, 12 Jun 2025 12:11:08 +0100
Message-ID: <b18aed2320c6b8f84a0fffa9d2a14f5cf9401cda.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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

Currently, the stats structure is directly embedded in the queue structure.
We're about to move iavf driver to a common Rx queue structure, so we can't
have driver-specific structures that aren't pointers, inside the common
queue structure. To prepare, we replace direct embedding into the queue
structure with a pointer to the stats structure.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.c   | 21 ++++++++++++++++++---
 drivers/net/intel/iavf/iavf_rxtx.h   |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b3dacbef84..5babd587b3 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1870,7 +1870,7 @@ iavf_dev_update_ipsec_xstats(struct rte_eth_dev *ethdev,
 		struct iavf_rx_queue *rxq;
 		struct iavf_ipsec_crypto_stats *stats;
 		rxq = (struct iavf_rx_queue *)ethdev->data->rx_queues[idx];
-		stats = &rxq->stats.ipsec_crypto;
+		stats = &rxq->stats->ipsec_crypto;
 		ips->icount += stats->icount;
 		ips->ibytes += stats->ibytes;
 		ips->ierrors.count += stats->ierrors.count;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 5411eb6897..d23d2df807 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -619,6 +619,18 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		return -ENOMEM;
 	}
 
+	/* Allocate stats */
+	rxq->stats = rte_zmalloc_socket("iavf rxq stats",
+				 sizeof(struct iavf_rx_queue_stats),
+				 RTE_CACHE_LINE_SIZE,
+				 socket_id);
+	if (!rxq->stats) {
+		PMD_INIT_LOG(ERR, "Failed to allocate memory for "
+			     "rx queue stats");
+		rte_free(rxq);
+		return -ENOMEM;
+	}
+
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
 		proto_xtr = vf->proto_xtr ? vf->proto_xtr[queue_idx] :
 				IAVF_PROTO_XTR_NONE;
@@ -677,6 +689,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 				   socket_id);
 	if (!rxq->sw_ring) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW ring");
+		rte_free(rxq->stats);
 		rte_free(rxq);
 		return -ENOMEM;
 	}
@@ -693,6 +706,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	if (!mz) {
 		PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for RX");
 		rte_free(rxq->sw_ring);
+		rte_free(rxq->stats);
 		rte_free(rxq);
 		return -ENOMEM;
 	}
@@ -1054,6 +1068,7 @@ iavf_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	iavf_rxq_release_mbufs_ops[q->rel_mbufs_type].release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
+	rte_free(q->stats);
 	rte_free(q);
 }
 
@@ -1581,7 +1596,7 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 			rte_le_to_cpu_16(rxd.wb.ptype_flex_flags0)];
 		iavf_flex_rxd_to_vlan_tci(rxm, &rxd);
 		iavf_flex_rxd_to_ipsec_crypto_status(rxm, &rxd,
-				&rxq->stats.ipsec_crypto);
+				&rxq->stats->ipsec_crypto);
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, rxm, &rxd);
 		pkt_flags = iavf_flex_rxd_error_to_pkt_flags(rx_stat_err0);
 
@@ -1750,7 +1765,7 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 			rte_le_to_cpu_16(rxd.wb.ptype_flex_flags0)];
 		iavf_flex_rxd_to_vlan_tci(first_seg, &rxd);
 		iavf_flex_rxd_to_ipsec_crypto_status(first_seg, &rxd,
-				&rxq->stats.ipsec_crypto);
+				&rxq->stats->ipsec_crypto);
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, first_seg, &rxd);
 		pkt_flags = iavf_flex_rxd_error_to_pkt_flags(rx_stat_err0);
 
@@ -2034,7 +2049,7 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 				rte_le_to_cpu_16(rxdp[j].wb.ptype_flex_flags0)];
 			iavf_flex_rxd_to_vlan_tci(mb, &rxdp[j]);
 			iavf_flex_rxd_to_ipsec_crypto_status(mb, &rxdp[j],
-				&rxq->stats.ipsec_crypto);
+				&rxq->stats->ipsec_crypto);
 			rxd_to_pkt_fields_ops[rxq->rxdid](rxq, mb, &rxdp[j]);
 			stat_err0 = rte_le_to_cpu_16(rxdp[j].wb.status_error0);
 			pkt_flags = iavf_flex_rxd_error_to_pkt_flags(stat_err0);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 0b5d67e718..62b5a67c84 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -268,7 +268,7 @@ struct iavf_rx_queue {
 	uint8_t proto_xtr; /* protocol extraction type */
 	uint64_t xtr_ol_flag;
 		/* flexible descriptor metadata extraction offload flag */
-	struct iavf_rx_queue_stats stats;
+	struct iavf_rx_queue_stats *stats;
 	uint64_t offloads;
 	uint64_t phc_time;
 	uint64_t hw_time_update;
-- 
2.47.1


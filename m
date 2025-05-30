Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D3BC5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:58:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F4124065D;
	Fri, 30 May 2025 15:57:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C91E040651
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613462; x=1780149462;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sGTaHnnPET/SUsaIz+0gQF3Ny4bW6g+kZ+41loKExoQ=;
 b=OrVf184/cEi66hcmD7lgMHBG7j2H/g1UsuKAxTNEzyzoVXizh14v9cSk
 VPA4LDSEG10WpjymjeXDSh5Mgqkl4e7epl1Blf0DqIEA7zmO8nROX58ma
 yWXy1o45o27dZMaKdpjMSJitB/yeAVMaq3BOsC3SRxijUyPFwCMWQ4I+p
 IWIFOT45/Y2lDn7jWP+S2lZv6EopmvLJRSh6CYm97LYVTSTkRCHO73Lqy
 u1zoZbyEU0wrWb9UUdL30evDkdJ7oxSjCztD34AigqFbHnUeFgY2i6/as
 QMY0fWcBCOJCLDFuf2nc2vSAnVdV7L3vStxyPSVe+2gshfkWYrVhlCPGY Q==;
X-CSE-ConnectionGUID: d2I2P92TTpqHiFj5WqI/AA==
X-CSE-MsgGUID: YilN6C1WQ5qmtZiISgIjZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809369"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809369"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:41 -0700
X-CSE-ConnectionGUID: 2Ovn0i9dSdurozcelE8Qjg==
X-CSE-MsgGUID: HDn4mOQHQ8ysrgKa4yUL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887374"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 04/25] net/i40e: match variable name to other drivers
Date: Fri, 30 May 2025 14:57:00 +0100
Message-ID: <5265721cd3bba6ce768a980c4c171d95ed7ab71f.1748612803.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
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

Currently, the i40e driver has a variable that has the same semantics as
in other drivers, but has a different name. Rename `rx_using_sse` to
`vector_rx` to match it to other drivers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Make this commit separate

 drivers/net/intel/i40e/i40e_rxtx.c             | 8 ++++----
 drivers/net/intel/i40e/i40e_rxtx.h             | 2 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c | 2 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c    | 2 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c3ff2e05c3..b4caa3bdd5 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2633,7 +2633,7 @@ i40e_rx_queue_release_mbufs(struct i40e_rx_queue *rxq)
 	uint16_t i;
 
 	/* SSE Vector driver has a different way of releasing mbufs. */
-	if (rxq->rx_using_sse) {
+	if (rxq->vector_rx) {
 		i40e_rx_queue_release_mbufs_vec(rxq);
 		return;
 	}
@@ -3316,7 +3316,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 {
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	uint16_t rx_using_sse, i;
+	uint16_t vector_rx, i;
 	/* In order to allow Vector Rx there are a few configuration
 	 * conditions to be met and Rx Bulk Allocation should be allowed.
 	 */
@@ -3427,7 +3427,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 
 	/* Propagate information about RX function choice through all queues. */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		rx_using_sse =
+		vector_rx =
 			(dev->rx_pkt_burst == i40e_recv_scattered_pkts_vec ||
 			 dev->rx_pkt_burst == i40e_recv_pkts_vec ||
 #ifdef CC_AVX512_SUPPORT
@@ -3441,7 +3441,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 			struct i40e_rx_queue *rxq = dev->data->rx_queues[i];
 
 			if (rxq)
-				rxq->rx_using_sse = rx_using_sse;
+				rxq->vector_rx = vector_rx;
 		}
 	}
 }
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 2f32fc5686..9db044f280 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -118,7 +118,7 @@ struct i40e_rx_queue {
 	uint8_t hs_mode; /* Header Split mode */
 	bool q_set; /**< indicate if rx queue has been configured */
 	bool rx_deferred_start; /**< don't start this queue in dev start */
-	uint16_t rx_using_sse; /**<flag indicate the usage of vPMD for rx */
+	uint16_t vector_rx; /**<flag indicate the usage of vPMD for rx */
 	uint8_t dcb_tc;         /**< Traffic class of rx queue */
 	uint64_t offloads; /**< Rx offload flags of RTE_ETH_RX_OFFLOAD_* */
 	const struct rte_memzone *mz;
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 42beff6e89..01dee811ba 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -619,7 +619,7 @@ i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
 int __rte_cold
 i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
 {
-	rxq->rx_using_sse = 1;
+	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
 }
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index d16ceb6b5d..317a0323bb 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -746,7 +746,7 @@ i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
 int __rte_cold
 i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
 {
-	rxq->rx_using_sse = 1;
+	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
 }
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 774519265b..25a3ef7352 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -763,7 +763,7 @@ i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
 int __rte_cold
 i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
 {
-	rxq->rx_using_sse = 1;
+	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
 }
-- 
2.47.1


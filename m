Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71970E6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4DA940E41;
	Fri, 30 Jan 2026 12:43:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9C8B740E42
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773386; x=1801309386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QnxEG2J7YeVkSdlb6HHu8Pe5FSLpc4yEex2HPx21pWM=;
 b=PeR03tN3JtdZRiAgiO+1J4uzci4jyy/hLx0trEJlfnoKmh1H4uk6Os0h
 K2WG0cCcYLc2pL+6fr+MVhVS/72otG0l59MumXVzVKFgIW3Dhe3pa+dTw
 2vqrEF0JBNgySYiA4coHs/KYF5K0XCkyrX7m8VqJ/x8NZWULBxfI/IkFE
 bjDdDypCTMNVCTplFemHRUrnMKvVYO9lQL34SXp/6ib/VBJA2kHJoP1NO
 UsKY8w5BSLEXCgbfPIso5S4ab/zWo6acE6+6Q41+9aPquPxDS9EcshUyi
 ssboXAWGNIXtHBxS6hwjqCnUHFhmS4ha9hzncT2et0r6XlL+xm1t/Fw62 g==;
X-CSE-ConnectionGUID: 2gLsAvVqRyKuf49L+ypRHw==
X-CSE-MsgGUID: mnJWWL3wRJOlQVQMqp5/8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392348"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392348"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:43:03 -0800
X-CSE-ConnectionGUID: MdjlkCjESFS0azOu6FpIag==
X-CSE-MsgGUID: x6SY5YLSTKmRlLEbfawKag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190602"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:43:02 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v3 36/36] net/idpf: enable simple Tx function
Date: Fri, 30 Jan 2026 11:42:03 +0000
Message-ID: <20260130114207.1126032-37-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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

The common "simple Tx" function - in some ways a scalar version of the
vector Tx functions - can be used by the idpf driver as well as i40e and
ice, so add support for it to the driver.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.h |  2 ++
 drivers/net/intel/idpf/idpf_common_rxtx.c   | 19 +++++++++++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h   |  3 +++
 drivers/net/intel/idpf/idpf_rxtx.c          | 26 ++++++++++++++++++++-
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 31915a03d4..527aa9b3dc 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -78,6 +78,7 @@ enum idpf_rx_func_type {
 enum idpf_tx_func_type {
 	IDPF_TX_DEFAULT,
 	IDPF_TX_SINGLEQ,
+	IDPF_TX_SINGLEQ_SIMPLE,
 	IDPF_TX_SINGLEQ_AVX2,
 	IDPF_TX_AVX512,
 	IDPF_TX_SINGLEQ_AVX512,
@@ -100,6 +101,7 @@ struct idpf_adapter {
 
 	bool is_tx_singleq; /* true - single queue model, false - split queue model */
 	bool is_rx_singleq; /* true - single queue model, false - split queue model */
+	bool tx_simple_allowed; /* true if all queues support simple TX */
 
 	/* For timestamp */
 	uint64_t time_hw;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index bd77113551..0da2506bf0 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1347,6 +1347,15 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			idpf_set_tso_ctx, NULL, NULL);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_simple)
+uint16_t
+idpf_dp_singleq_xmit_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts,
+				   uint16_t nb_pkts)
+{
+	return ci_xmit_pkts_simple(tx_queue, tx_pkts, nb_pkts);
+}
+
+
 /* TX prep functions */
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_prep_pkts)
 uint16_t
@@ -1532,6 +1541,16 @@ const struct ci_tx_path_info idpf_tx_path_infos[] = {
 			.single_queue = true
 		}
 	},
+	[IDPF_TX_SINGLEQ_SIMPLE] = {
+		.pkt_burst = idpf_dp_singleq_xmit_pkts_simple,
+		.info = "Single Queue Scalar Simple",
+		.features = {
+			.tx_offloads = IDPF_TX_VECTOR_OFFLOADS,
+			.single_queue = true,
+			.simple_tx = true,
+		}
+	},
+
 #ifdef RTE_ARCH_X86
 	[IDPF_TX_SINGLEQ_AVX2] = {
 		.pkt_burst = idpf_dp_singleq_xmit_pkts_avx2,
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index fe7094d434..914cab0f25 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -221,6 +221,9 @@ __rte_internal
 uint16_t idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				   uint16_t nb_pkts);
 __rte_internal
+uint16_t idpf_dp_singleq_xmit_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts,
+				   uint16_t nb_pkts);
+__rte_internal
 uint16_t idpf_dp_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			   uint16_t nb_pkts);
 __rte_internal
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 9420200f6d..f2e202d57d 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -509,6 +509,22 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = txq;
 
+	/* Set tx_simple_allowed flag based on queue configuration.
+	 * For queue 0: explicitly set the flag based on its configuration.
+	 * For other queues: only set to false if this queue cannot use simple_tx.
+	 */
+	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT)
+		goto out;
+
+	/* for first queue, default to true, disable later if any queue can't meet conditions */
+	if (queue_idx == 0)
+		adapter->tx_simple_allowed = true;
+
+	if ((txq->offloads != (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)) ||
+			txq->tx_rs_thresh < IDPF_VPMD_TX_MAX_BURST)
+		adapter->tx_simple_allowed = false;
+
+out:
 	return 0;
 
 err_complq_setup:
@@ -651,6 +667,7 @@ int
 idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *ad = vport->adapter;
 	struct ci_tx_queue *txq = dev->data->tx_queues[tx_queue_id];
 	int err = 0;
 
@@ -667,6 +684,12 @@ idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return err;
 	}
 
+	/* Record what kind of descriptor cleanup we need on teardown.
+	 * For single queue mode, vector or simple tx paths use vec entry format.
+	 */
+	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
+		txq->use_vec_entry = ad->tx_simple_allowed;
+
 	/* Ready to switch the queue on */
 	err = idpf_vc_queue_switch(vport, tx_queue_id, false, true,
 							VIRTCHNL2_QUEUE_TYPE_TX);
@@ -847,7 +870,8 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	struct ci_tx_path_features req_features = {
 		.tx_offloads = dev->data->dev_conf.txmode.offloads,
 		.simd_width = RTE_VECT_SIMD_DISABLED,
-		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
+		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE),
+		.simple_tx = ad->tx_simple_allowed
 	};
 
 	/* The primary process selects the tx path for all processes. */
-- 
2.51.0


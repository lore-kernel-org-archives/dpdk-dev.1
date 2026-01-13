Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C935D2F32E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBE7D40E7C;
	Tue, 13 Jan 2026 16:16:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2D2DC40679
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317359; x=1799853359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=trqIbtZArI/lRJ+CWsy6ZKu1spGivAKHnWF/2EdFieM=;
 b=EusdE3QUWXu0VniI286uFNUE/dnbg+VdhjGzbc41LMmBn8QXxzK91CbG
 LAkwK8WFZJI6LV0gtUrbX9SaCaY+eXAxo80bddHqmmc5IM6+oMsMuHczS
 iYOb5mbSJkEpErkegAVw9+NiaG09CIuz/8AK5GQg94SGTSHZYVmRuGw5V
 Fq/NkP6eDTXlgtRc8HWRAVBuwe75LY1O2hrq+5oLhrdym9IhtrF6q/M3J
 PKdu+wN43PP3S0wJQ6l2LbYnQd+gHDKiP3qep3x6B0rGwlyGdatk9TqbM
 i1/I/Rf7+96QGEtQ9foVGERzRWJOUIpayAktUbaVw1uAhr1wnSIOcFh8Y w==;
X-CSE-ConnectionGUID: OVfYF08mRsGeH7QGX6GCtQ==
X-CSE-MsgGUID: kjL45vywTBqSyKaLdI7pGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969243"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:59 -0800
X-CSE-ConnectionGUID: ZKWvJvj5TwmyEvf/MWYPPw==
X-CSE-MsgGUID: NVlxLj/UQKaHsC0Ws62N+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556700"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:58 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v2 36/36] net/idpf: enable simple Tx function
Date: Tue, 13 Jan 2026 15:15:00 +0000
Message-ID: <20260113151505.1871271-37-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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
index 781310e564..bf2e9363d4 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1348,6 +1348,15 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
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
@@ -1533,6 +1542,16 @@ const struct ci_tx_path_info idpf_tx_path_infos[] = {
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
index 5c2516f556..a2bb4b766d 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -497,6 +497,22 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
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
@@ -639,6 +655,7 @@ int
 idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *ad = vport->adapter;
 	struct ci_tx_queue *txq = dev->data->tx_queues[tx_queue_id];
 	int err = 0;
 
@@ -655,6 +672,12 @@ idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -835,7 +858,8 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
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


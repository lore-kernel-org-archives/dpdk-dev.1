Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A19FECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6455F41109;
	Wed, 11 Feb 2026 19:14:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7E926410E7
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833652; x=1802369652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZlVjU0wVpDB9pU/9KnlB3GvRoJUMA21F7wVRyrBoH0I=;
 b=UxEQH6lNaPJipQ+wu/nmTkRPO1qDEDXIJAzASfpG63jqJzeJ/fhc6oWp
 YnxsBhjHyZBByDH6mK4rAtDAAazN0WcRicnaJSv/RBb0PisGFrOP+47ic
 biSDL9oFclhDSJNfd/wKCbZ6+8Ymf5X4LBtAJrJlJQh3UPnRKhUiegIQ5
 H+2MrkWg6OWlpGQ/nNzkAEApJVueMe6hBeCRmqbB45JF5lLqufrKcjb/2
 cepbN1n/Aq0/0nF8B0F410MBN4MYpZCwTDKozNt+S1gWYcLQUK+PnXXg2
 BboAIckC++vBnteosNUvBfjlEoWyIUTXlAzQdDCyvrPKZjdgkZxChovJD g==;
X-CSE-ConnectionGUID: bOHxwOXTRkGok8/E2OfUjQ==
X-CSE-MsgGUID: wAfZJLDwTR+UTfWaR8UodA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834708"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:14:11 -0800
X-CSE-ConnectionGUID: LxRVlEvnSjmnskdwGJkpew==
X-CSE-MsgGUID: bZgK/DoyQU2RyeXQItqdbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986424"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:14:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 34/35] net/idpf: enable simple Tx function
Date: Wed, 11 Feb 2026 18:13:03 +0000
Message-ID: <20260211181309.2838042-35-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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
 drivers/net/intel/idpf/idpf_common_device.h   |  1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 19 ++++++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  3 ++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  1 -
 drivers/net/intel/idpf/idpf_rxtx.c            | 38 ++++++++++++++++---
 5 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 31915a03d4..bbc969c734 100644
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
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index f14a20d6ec..b8f6418d4a 100644
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
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 666ad1a4dd..c5f2018924 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1365,6 +1365,5 @@ idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
 	if (!txq)
 		return 0;
 
-	txq->use_vec_entry = true;
 	return 0;
 }
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 9420200f6d..6317112353 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -833,21 +833,39 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 
 }
 
+static bool
+idpf_tx_simple_allowed(struct rte_eth_dev *dev)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct ci_tx_queue *txq;
+
+	if (vport->txq_model != VIRTCHNL2_QUEUE_MODEL_SINGLE)
+		return false;
+
+	for (int i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (txq == NULL)
+			continue;
+		if (txq->offloads != (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) ||
+				txq->tx_rs_thresh < IDPF_VPMD_TX_MAX_BURST)
+			return false;
+	}
+	return true;
+}
+
 void
 idpf_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
 	struct ci_tx_queue *txq;
 	int i;
-#endif /* CC_AVX512_SUPPORT */
-#endif /* RTE_ARCH_X86 */
 	struct idpf_adapter *ad = vport->adapter;
+	bool simple_allowed = idpf_tx_simple_allowed(dev);
 	struct ci_tx_path_features req_features = {
 		.tx_offloads = dev->data->dev_conf.txmode.offloads,
 		.simd_width = RTE_VECT_SIMD_DISABLED,
-		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
+		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE),
+		.simple_tx = simple_allowed
 	};
 
 	/* The primary process selects the tx path for all processes. */
@@ -864,6 +882,16 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 					IDPF_TX_MAX,
 					IDPF_TX_DEFAULT);
 
+	/* Set use_vec_entry for single queue mode - only IDPF_TX_SINGLEQ uses regular entries */
+	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
+		for (i = 0; i < dev->data->nb_tx_queues; i++) {
+			txq = dev->data->tx_queues[i];
+			if (txq == NULL)
+				continue;
+			txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ);
+		}
+	}
+
 out:
 	dev->tx_pkt_burst = idpf_tx_path_infos[ad->tx_func_type].pkt_burst;
 	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-- 
2.51.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87929ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 691E940E15;
	Wed, 11 Feb 2026 19:14:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 909D640E4F
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833654; x=1802369654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xOO+rtWX5pBYEAk6WbQDeKtx7SmT6cb6vcDeB2joLls=;
 b=WIolaYR9eptYENNOLK27TAwAY6WeHUDPzzbn7ojIJ8tyLEQYrc3uyj6S
 K5OvTCzVzwjx3EovFY4ewuqGHMKqEEPqYDPK4GSNi5iQZqkSQDihfXbgj
 33BsVVc6LXZmXbbk9XshP9JFIPrEo9DSMRClyXQTf95kjSdO3sCXolAiK
 Ac36L7ASvHE3B9IxC9FwNA8xY3zPaXdWgllITgNksqG8oz7KqQIKnYPtL
 yIK0YUS5vUa6gpQKlwzRNyPpYkBIG4PNgsfseKe8KCopodNeLhVqK4U17
 sgCId+mma9DfTHDbmBbwiwuLNZdDC103HdmmY4G86lxR1Hf3gAz+PCwfl A==;
X-CSE-ConnectionGUID: +fDU9mNOQ4mVl3nn6aBFQw==
X-CSE-MsgGUID: sEhzODwPQQ+Y1ofDR/TdFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834714"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834714"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:14:13 -0800
X-CSE-ConnectionGUID: 0kdhmSnXSx+Jy685hDLbgQ==
X-CSE-MsgGUID: 2mAxCaXeQN2RvenrSae6kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986427"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:14:11 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 35/35] net/cpfl: enable simple Tx function
Date: Wed, 11 Feb 2026 18:13:04 +0000
Message-ID: <20260211181309.2838042-36-bruce.richardson@intel.com>
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
vector Tx functions - can be used by the cpfl driver in the same way as
the idpf driver does.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c | 39 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index b5b9015310..11451e1666 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1485,22 +1485,41 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 
 }
 
+static bool
+cpfl_tx_simple_allowed(struct rte_eth_dev *dev)
+{
+	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
+	struct idpf_vport *vport = &cpfl_vport->base;
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
 cpfl_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
 	struct ci_tx_queue *txq;
 	int i;
-#endif /* CC_AVX512_SUPPORT */
-#endif /* RTE_ARCH_X86 */
 	struct idpf_adapter *ad = vport->adapter;
+	bool simple_allowed = cpfl_tx_simple_allowed(dev);
 	struct ci_tx_path_features req_features = {
 		.tx_offloads = dev->data->dev_conf.txmode.offloads,
 		.simd_width = RTE_VECT_SIMD_DISABLED,
-		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
+		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE),
+		.simple_tx = simple_allowed
 	};
 
 	/* The primary process selects the tx path for all processes. */
@@ -1517,6 +1536,16 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
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


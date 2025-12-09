Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77976D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6713440A7F;
	Tue,  9 Dec 2025 12:27:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4F55A406BB
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279630; x=1796815630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3d2bq7IG96lIi78vePu3RkWGuLqFqPiejlwZGNmBhos=;
 b=ODyWXF24LIa8nM6oACDhlyXnfJaXBaFj7UKHSTooRR1hg2li+lMuRu3A
 rRF3B8I+N210oEIVDEf9IP+/6cf6MPaANuSnTgAQUeAqQJYgNU1E7uJPz
 olXYZoRFxawtUCiPjOuCkag1jePymaDAGCgZTPHMWLn9AQhCQziZ+KyQ+
 0aeyyKU6TbgJuShBfmaA1bRnd4o62lu4YVUxbvV0L+CnEakWCHsWa+Rke
 YK0LQFpdH5mRbtb3awOaQm2bpj79fR9D3H8XBODalzPK9jzYzvfqy70Ue
 Emn2SnLuDFnxjGL52BIHANMYDDAIONe4jgD9Tm3WosW2ZKPcW8jbtO+Pb g==;
X-CSE-ConnectionGUID: 7GOVmtROTrGz7pmSwmsLfw==
X-CSE-MsgGUID: S3qstLYzRYqNHzqaMO4SMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117036"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:10 -0800
X-CSE-ConnectionGUID: OOD/8s94SsCpkqOMpgJ+0w==
X-CSE-MsgGUID: BVL4EZllTYy4VmtDUS2i3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270203"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:09 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 04/13] net/iavf: use same Tx path across processes
Date: Tue,  9 Dec 2025 11:26:43 +0000
Message-ID: <20251209112652.963981-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

In the interest of simplicity, let the primary process select the Tx
path to be used by all processes using the given device.

The many logs which report individual Tx path selections have been
consolidated into one single log.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c |  5 +-
 drivers/net/intel/iavf/iavf_rxtx.c   | 90 ++++++++++------------------
 2 files changed, 34 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 15e49fe248..ab65e99f68 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -671,6 +671,8 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 	 */
 	ad->tx_vec_allowed = true;
 
+	ad->tx_func_type = IAVF_TX_DEFAULT;
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
@@ -2795,8 +2797,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	eth_dev->tx_pkt_prepare = &iavf_prep_pkts;
 
 	/* For secondary processes, we don't initialise any further as primary
-	 * has already done this work. Only check if we need a different RX
-	 * and TX function.
+	 * has already done this work.
 	 */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		iavf_set_rx_function(eth_dev);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d8662fd815..055b2b0ae0 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4229,7 +4229,6 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	enum iavf_tx_func_type tx_func_type;
 	int mbuf_check = adapter->devargs.mbuf_check;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
 #ifdef RTE_ARCH_X86
@@ -4241,6 +4240,10 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	bool use_avx512 = false;
 	enum rte_vect_max_simd tx_simd_path = iavf_get_max_simd_bitwidth();
 
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
+
 	check_ret = iavf_tx_vec_dev_check(dev);
 
 	if (check_ret >= 0 &&
@@ -4254,47 +4257,29 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		use_avx512 = tx_simd_path == RTE_VECT_SIMD_512;
 
 		if (!use_sse && !use_avx2 && !use_avx512)
-			goto normal;
+			goto out;
+
+		if (use_sse)
+			adapter->tx_func_type = IAVF_TX_SSE;
 
-		if (use_sse) {
-			PMD_DRV_LOG(DEBUG, "Using Vector Tx (port %d).",
-				    dev->data->port_id);
-			tx_func_type = IAVF_TX_SSE;
-		}
 		if (!use_avx512 && use_avx2) {
-			if (check_ret == IAVF_VECTOR_PATH) {
-				tx_func_type = IAVF_TX_AVX2;
-				PMD_DRV_LOG(DEBUG, "Using AVX2 Vector Tx (port %d).",
-					    dev->data->port_id);
-			} else if (check_ret == IAVF_VECTOR_CTX_OFFLOAD_PATH) {
-				PMD_DRV_LOG(DEBUG,
-					"AVX2 does not support requested Tx offloads.");
-				goto normal;
-			} else {
-				tx_func_type = IAVF_TX_AVX2_OFFLOAD;
-				PMD_DRV_LOG(DEBUG, "Using AVX2 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-			}
+			if (check_ret == IAVF_VECTOR_PATH)
+				adapter->tx_func_type = IAVF_TX_AVX2;
+			else if (check_ret == IAVF_VECTOR_CTX_OFFLOAD_PATH)
+				goto out;
+			else
+				adapter->tx_func_type = IAVF_TX_AVX2_OFFLOAD;
 		}
 #ifdef CC_AVX512_SUPPORT
 		if (use_avx512) {
-			if (check_ret == IAVF_VECTOR_PATH) {
-				tx_func_type = IAVF_TX_AVX512;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-			} else if (check_ret == IAVF_VECTOR_OFFLOAD_PATH) {
-				tx_func_type = IAVF_TX_AVX512_OFFLOAD;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-			} else if (check_ret == IAVF_VECTOR_CTX_PATH) {
-				tx_func_type = IAVF_TX_AVX512_CTX;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 CONTEXT Vector Tx (port %d).",
-						dev->data->port_id);
-			} else {
-				tx_func_type = IAVF_TX_AVX512_CTX_OFFLOAD;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 CONTEXT OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-			}
+			if (check_ret == IAVF_VECTOR_PATH)
+				adapter->tx_func_type = IAVF_TX_AVX512;
+			else if (check_ret == IAVF_VECTOR_OFFLOAD_PATH)
+				adapter->tx_func_type = IAVF_TX_AVX512_OFFLOAD;
+			else if (check_ret == IAVF_VECTOR_CTX_PATH)
+				adapter->tx_func_type = IAVF_TX_AVX512_CTX;
+			else
+				adapter->tx_func_type = IAVF_TX_AVX512_CTX_OFFLOAD;
 		}
 #endif
 
@@ -4305,33 +4290,20 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 			iavf_txq_vec_setup(txq);
 		}
 
-		if (no_poll_on_link_down) {
-			adapter->tx_func_type = tx_func_type;
-			dev->tx_pkt_burst = iavf_xmit_pkts_no_poll;
-		} else if (mbuf_check) {
-			adapter->tx_func_type = tx_func_type;
-			dev->tx_pkt_burst = iavf_xmit_pkts_check;
-		} else {
-			dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst;
-		}
-		return;
+		goto out;
 	}
-
-normal:
 #endif
-	PMD_DRV_LOG(DEBUG, "Using Basic Tx callback (port=%d).",
-		    dev->data->port_id);
-	tx_func_type = IAVF_TX_DEFAULT;
 
-	if (no_poll_on_link_down) {
-		adapter->tx_func_type = tx_func_type;
+out:
+	if (no_poll_on_link_down)
 		dev->tx_pkt_burst = iavf_xmit_pkts_no_poll;
-	} else if (mbuf_check) {
-		adapter->tx_func_type = tx_func_type;
+	else if (mbuf_check)
 		dev->tx_pkt_burst = iavf_xmit_pkts_check;
-	} else {
-		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst;
-	}
+	else
+		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[adapter->tx_func_type].pkt_burst;
+
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+		 iavf_tx_pkt_burst_ops[adapter->tx_func_type].info, dev->data->port_id);
 }
 
 static int
-- 
2.43.0


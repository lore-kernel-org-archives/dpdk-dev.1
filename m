Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A33AC87FDA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76DC74042E;
	Thu,  7 Aug 2025 14:39:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 54BDF4042E
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570397; x=1786106397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=31Qq/NBeWV4r39kp26nN4ev6rgtzxbA7CrIgkOyfNow=;
 b=k8j1yuNIlf5UyEVGUuyZ6QmyrhAiyjOrke7Bzd3yQw2Ho2JoFFIkLIxO
 L3VEBuRKQ4XV+hTFttjB91el1sJQonwtf4ni6tROfVr7Bz/2E4j6itAlt
 NqHo1SyZCKnB4ib+JouOUaiKGhNSxedcCRMoXzhuR7UW5Xn/BzXgzk4Wh
 YmWUKKUyLMyxqPjdgubLjIcu2dlcGHnJdxFfXOHo9laLbLI4GFA8M5jH7
 0TCgXthfkWlDVdTw98/LOWgqdr0hP+by7Kw+UEW3yYdrSgBsMp6F/seWE
 vHzb4U7JKhMQ7+x3hHaLP+WojBNDEF1d3u1ZbTfAn4K3A3m9Xizj6dYPe A==;
X-CSE-ConnectionGUID: acl5QZNtSSKm33nRnB0Gsw==
X-CSE-MsgGUID: VgXVOBbkSN2HRWdDr5kj8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981114"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981114"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:39:56 -0700
X-CSE-ConnectionGUID: B6sDDI45R/iJyo8Te9V6nw==
X-CSE-MsgGUID: 9VXhy/moQx+XBj6I5SkSlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886716"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:39:55 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 02/15] net/iavf: rename Rx/Tx function type variables
Date: Thu,  7 Aug 2025 12:39:36 +0000
Message-Id: <20250807123949.4063416-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123949.4063416-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
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

Rename variables from burst_type to func_type to better reflect
the information the variables are storing.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf.h      |   8 +-
 drivers/net/intel/iavf/iavf_rxtx.c | 114 ++++++++++++++---------------
 2 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index f81c939c96..dacfb92d5f 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -320,7 +320,7 @@ struct iavf_devargs {
 
 struct iavf_security_ctx;
 
-enum iavf_rx_burst_type {
+enum iavf_rx_func_type {
 	IAVF_RX_DISABLED,
 	IAVF_RX_DEFAULT,
 	IAVF_RX_FLEX_RXD,
@@ -349,7 +349,7 @@ enum iavf_rx_burst_type {
 	IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD,
 };
 
-enum iavf_tx_burst_type {
+enum iavf_tx_func_type {
 	IAVF_TX_DISABLED,
 	IAVF_TX_DEFAULT,
 	IAVF_TX_SSE,
@@ -381,8 +381,8 @@ struct iavf_adapter {
 	bool stopped;
 	bool closed;
 	bool no_poll;
-	enum iavf_rx_burst_type rx_burst_type;
-	enum iavf_tx_burst_type tx_burst_type;
+	enum iavf_rx_func_type rx_func_type;
+	enum iavf_tx_func_type tx_func_type;
 	uint16_t fdir_ref_cnt;
 	struct iavf_devargs devargs;
 };
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 7033a74610..57f7a4b67d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3826,14 +3826,14 @@ iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
 				uint16_t nb_pkts)
 {
 	struct ci_rx_queue *rxq = rx_queue;
-	enum iavf_rx_burst_type rx_burst_type;
+	enum iavf_rx_func_type rx_func_type;
 
 	if (!rxq->iavf_vsi || rxq->iavf_vsi->adapter->no_poll)
 		return 0;
 
-	rx_burst_type = rxq->iavf_vsi->adapter->rx_burst_type;
+	rx_func_type = rxq->iavf_vsi->adapter->rx_func_type;
 
-	return iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst(rx_queue,
+	return iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst(rx_queue,
 								rx_pkts, nb_pkts);
 }
 
@@ -3842,14 +3842,14 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = tx_queue;
-	enum iavf_tx_burst_type tx_burst_type;
+	enum iavf_tx_func_type tx_func_type;
 
 	if (!txq->iavf_vsi || txq->iavf_vsi->adapter->no_poll)
 		return 0;
 
-	tx_burst_type = txq->iavf_vsi->adapter->tx_burst_type;
+	tx_func_type = txq->iavf_vsi->adapter->tx_func_type;
 
-	return iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst(tx_queue,
+	return iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst(tx_queue,
 								tx_pkts, nb_pkts);
 }
 
@@ -3866,8 +3866,8 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
 	bool pkt_error = false;
 	struct ci_tx_queue *txq = tx_queue;
 	struct iavf_adapter *adapter = txq->iavf_vsi->adapter;
-	enum iavf_tx_burst_type tx_burst_type =
-		txq->iavf_vsi->adapter->tx_burst_type;
+	enum iavf_tx_func_type tx_func_type =
+		txq->iavf_vsi->adapter->tx_func_type;
 
 	for (idx = 0; idx < nb_pkts; idx++) {
 		mb = tx_pkts[idx];
@@ -3934,7 +3934,7 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
 			return 0;
 	}
 
-	return iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst(tx_queue, tx_pkts, good_pkts);
+	return iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst(tx_queue, tx_pkts, good_pkts);
 }
 
 /* choose rx function*/
@@ -3944,7 +3944,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
-	enum iavf_rx_burst_type rx_burst_type;
+	enum iavf_rx_func_type rx_func_type;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
 	int i;
 	struct ci_rx_queue *rxq;
@@ -4015,42 +4015,42 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 				}
 			}
 			if (use_flex) {
-				rx_burst_type = IAVF_RX_SSE_SCATTERED_FLEX_RXD;
+				rx_func_type = IAVF_RX_SSE_SCATTERED_FLEX_RXD;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX2_SCATTERED_FLEX_RXD;
 					else
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX512_SCATTERED_FLEX_RXD;
 					else
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD;
 				}
 #endif
 			} else {
-				rx_burst_type = IAVF_RX_SSE_SCATTERED;
+				rx_func_type = IAVF_RX_SSE_SCATTERED;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX2_SCATTERED;
 					else
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX2_SCATTERED_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX512_SCATTERED;
 					else
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX512_SCATTERED_OFFLOAD;
 				}
 #endif
@@ -4081,46 +4081,46 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 				}
 			}
 			if (use_flex) {
-				rx_burst_type = IAVF_RX_SSE_FLEX_RXD;
+				rx_func_type = IAVF_RX_SSE_FLEX_RXD;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type = IAVF_RX_AVX2_FLEX_RXD;
+						rx_func_type = IAVF_RX_AVX2_FLEX_RXD;
 					else
-						rx_burst_type = IAVF_RX_AVX2_FLEX_RXD_OFFLOAD;
+						rx_func_type = IAVF_RX_AVX2_FLEX_RXD_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type = IAVF_RX_AVX512_FLEX_RXD;
+						rx_func_type = IAVF_RX_AVX512_FLEX_RXD;
 					else
-						rx_burst_type =
+						rx_func_type =
 							IAVF_RX_AVX512_FLEX_RXD_OFFLOAD;
 				}
 #endif
 			} else {
-				rx_burst_type = IAVF_RX_SSE;
+				rx_func_type = IAVF_RX_SSE;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type = IAVF_RX_AVX2;
+						rx_func_type = IAVF_RX_AVX2;
 					else
-						rx_burst_type = IAVF_RX_AVX2_OFFLOAD;
+						rx_func_type = IAVF_RX_AVX2_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_burst_type = IAVF_RX_AVX512;
+						rx_func_type = IAVF_RX_AVX512;
 					else
-						rx_burst_type = IAVF_RX_AVX512_OFFLOAD;
+						rx_func_type = IAVF_RX_AVX512_OFFLOAD;
 				}
 #endif
 			}
 		}
 
 		if (no_poll_on_link_down) {
-			adapter->rx_burst_type = rx_burst_type;
+			adapter->rx_func_type = rx_func_type;
 			dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
 		} else {
-			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst;
+			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst;
 		}
 		return;
 	}
@@ -4136,13 +4136,13 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 			rxq = dev->data->rx_queues[i];
 			(void)iavf_rxq_vec_setup(rxq);
 		}
-		rx_burst_type = IAVF_RX_SSE;
+		rx_func_type = IAVF_RX_SSE;
 
 		if (no_poll_on_link_down) {
-			adapter->rx_burst_type = rx_burst_type;
+			adapter->rx_func_type = rx_func_type;
 			dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
 		} else {
-			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst;
+			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst;
 		}
 		return;
 	}
@@ -4151,27 +4151,27 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 		PMD_DRV_LOG(DEBUG, "Using a Scattered Rx callback (port=%d).",
 			    dev->data->port_id);
 		if (use_flex)
-			rx_burst_type = IAVF_RX_SCATTERED_FLEX_RXD;
+			rx_func_type = IAVF_RX_SCATTERED_FLEX_RXD;
 		else
-			rx_burst_type = IAVF_RX_SCATTERED;
+			rx_func_type = IAVF_RX_SCATTERED;
 	} else if (adapter->rx_bulk_alloc_allowed) {
 		PMD_DRV_LOG(DEBUG, "Using bulk Rx callback (port=%d).",
 			    dev->data->port_id);
-		rx_burst_type = IAVF_RX_BULK_ALLOC;
+		rx_func_type = IAVF_RX_BULK_ALLOC;
 	} else {
 		PMD_DRV_LOG(DEBUG, "Using Basic Rx callback (port=%d).",
 			    dev->data->port_id);
 		if (use_flex)
-			rx_burst_type = IAVF_RX_FLEX_RXD;
+			rx_func_type = IAVF_RX_FLEX_RXD;
 		else
-			rx_burst_type = IAVF_RX_DEFAULT;
+			rx_func_type = IAVF_RX_DEFAULT;
 	}
 
 	if (no_poll_on_link_down) {
-		adapter->rx_burst_type = rx_burst_type;
+		adapter->rx_func_type = rx_func_type;
 		dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
 	} else {
-		dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst;
+		dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst;
 	}
 }
 
@@ -4181,7 +4181,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	enum iavf_tx_burst_type tx_burst_type;
+	enum iavf_tx_func_type tx_func_type;
 	int mbuf_check = adapter->devargs.mbuf_check;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
 #ifdef RTE_ARCH_X86
@@ -4217,11 +4217,11 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		if (use_sse) {
 			PMD_DRV_LOG(DEBUG, "Using Vector Tx (port %d).",
 				    dev->data->port_id);
-			tx_burst_type = IAVF_TX_SSE;
+			tx_func_type = IAVF_TX_SSE;
 		}
 		if (use_avx2) {
 			if (check_ret == IAVF_VECTOR_PATH) {
-				tx_burst_type = IAVF_TX_AVX2;
+				tx_func_type = IAVF_TX_AVX2;
 				PMD_DRV_LOG(DEBUG, "Using AVX2 Vector Tx (port %d).",
 					    dev->data->port_id);
 			} else if (check_ret == IAVF_VECTOR_CTX_OFFLOAD_PATH) {
@@ -4229,7 +4229,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 					"AVX2 does not support outer checksum offload.");
 				goto normal;
 			} else {
-				tx_burst_type = IAVF_TX_AVX2_OFFLOAD;
+				tx_func_type = IAVF_TX_AVX2_OFFLOAD;
 				PMD_DRV_LOG(DEBUG, "Using AVX2 OFFLOAD Vector Tx (port %d).",
 					    dev->data->port_id);
 			}
@@ -4237,19 +4237,19 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 #ifdef CC_AVX512_SUPPORT
 		if (use_avx512) {
 			if (check_ret == IAVF_VECTOR_PATH) {
-				tx_burst_type = IAVF_TX_AVX512;
+				tx_func_type = IAVF_TX_AVX512;
 				PMD_DRV_LOG(DEBUG, "Using AVX512 Vector Tx (port %d).",
 					    dev->data->port_id);
 			} else if (check_ret == IAVF_VECTOR_OFFLOAD_PATH) {
-				tx_burst_type = IAVF_TX_AVX512_OFFLOAD;
+				tx_func_type = IAVF_TX_AVX512_OFFLOAD;
 				PMD_DRV_LOG(DEBUG, "Using AVX512 OFFLOAD Vector Tx (port %d).",
 					    dev->data->port_id);
 			} else if (check_ret == IAVF_VECTOR_CTX_PATH) {
-				tx_burst_type = IAVF_TX_AVX512_CTX;
+				tx_func_type = IAVF_TX_AVX512_CTX;
 				PMD_DRV_LOG(DEBUG, "Using AVX512 CONTEXT Vector Tx (port %d).",
 						dev->data->port_id);
 			} else {
-				tx_burst_type = IAVF_TX_AVX512_CTX_OFFLOAD;
+				tx_func_type = IAVF_TX_AVX512_CTX_OFFLOAD;
 				PMD_DRV_LOG(DEBUG, "Using AVX512 CONTEXT OFFLOAD Vector Tx (port %d).",
 					    dev->data->port_id);
 			}
@@ -4264,13 +4264,13 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		}
 
 		if (no_poll_on_link_down) {
-			adapter->tx_burst_type = tx_burst_type;
+			adapter->tx_func_type = tx_func_type;
 			dev->tx_pkt_burst = iavf_xmit_pkts_no_poll;
 		} else if (mbuf_check) {
-			adapter->tx_burst_type = tx_burst_type;
+			adapter->tx_func_type = tx_func_type;
 			dev->tx_pkt_burst = iavf_xmit_pkts_check;
 		} else {
-			dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst;
+			dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst;
 		}
 		return;
 	}
@@ -4279,16 +4279,16 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 #endif
 	PMD_DRV_LOG(DEBUG, "Using Basic Tx callback (port=%d).",
 		    dev->data->port_id);
-	tx_burst_type = IAVF_TX_DEFAULT;
+	tx_func_type = IAVF_TX_DEFAULT;
 
 	if (no_poll_on_link_down) {
-		adapter->tx_burst_type = tx_burst_type;
+		adapter->tx_func_type = tx_func_type;
 		dev->tx_pkt_burst = iavf_xmit_pkts_no_poll;
 	} else if (mbuf_check) {
-		adapter->tx_burst_type = tx_burst_type;
+		adapter->tx_func_type = tx_func_type;
 		dev->tx_pkt_burst = iavf_xmit_pkts_check;
 	} else {
-		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst;
+		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst;
 	}
 }
 
-- 
2.34.1


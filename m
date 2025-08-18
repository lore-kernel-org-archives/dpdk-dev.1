Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E022DCA0EC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 10:59:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BAE14065D;
	Mon, 18 Aug 2025 12:59:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 0BE1840611
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514774; x=1787050774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aSAMVbN1f/6oA6y64MpKSUFg4BMroXA6SJkhwr08Skc=;
 b=RzkAYQFg/uNfonYs8SFdc7aXaY/cVZh640gc14UdzJmGessjc0tAmRjr
 rbKlSYEL64sjU9essLki1M2U0vO6rnO3VsKX7x7avjh2o+Fcz8be6wgwy
 K6JQJAD9wFYew/xBHe5JAT202VnxZsictcl/szpOZWT59DrMGbLy/ayCz
 5mkD7QnwkdwltgDZL8S4GXI30uP3lDrbdm62rvY2vfsRbYwd3/w6AgWtS
 sxuE2g34lYHfH819FSt63YY7aw8/BtiV3XguwIrDyOwgjM5C1F8ofT0c9
 18gFnY5GUpLbt2OnegLhDmXdxn5NOifsfj6ICChstohoudNesDB1x79oD Q==;
X-CSE-ConnectionGUID: cF/qL7zrRXWVSw6We0ddGA==
X-CSE-MsgGUID: RkjDUf8SQnq6ltTusX4g7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165420"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165420"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:33 -0700
X-CSE-ConnectionGUID: RrBXqQhkRiGC+8FggAqobQ==
X-CSE-MsgGUID: 2MUs1UfrRsqHLvFNbE/Irw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722929"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:32 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 03/15] net/iavf: use the same Rx path across process types
Date: Mon, 18 Aug 2025 10:59:02 +0000
Message-Id: <20250818105914.169732-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
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

In the interest of simplicity, let the primary process select the Rx
path to be used by all processes using the given device.

The many logs which report individual Rx path selections have been
consolidated into one single log

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 142 ++++++++---------------------
 1 file changed, 40 insertions(+), 102 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 57f7a4b67d..3329499e59 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3944,12 +3944,15 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
-	enum iavf_rx_func_type rx_func_type;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
 	int i;
 	struct ci_rx_queue *rxq;
 	bool use_flex = true;
 
+	/* The primary process selects the rx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
+
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		rxq = dev->data->rx_queues[i];
 		if (rxq->rxdid <= IAVF_RXDID_LEGACY_1) {
@@ -3989,140 +3992,85 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 		}
 
 		if (dev->data->scattered_rx) {
-			if (!use_avx2 && !use_avx512) {
-				PMD_DRV_LOG(DEBUG,
-					    "Using Vector Scattered Rx (port %d).",
-					    dev->data->port_id);
-			} else {
-				if (use_avx2) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX2 Vector Scattered Rx (port %d).",
-							    dev->data->port_id);
-					else
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX2 OFFLOAD Vector Scattered Rx (port %d).",
-							    dev->data->port_id);
-				} else {
-					if (check_ret == IAVF_VECTOR_PATH)
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX512 Vector Scattered Rx (port %d).",
-							    dev->data->port_id);
-					else
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX512 OFFLOAD Vector Scattered Rx (port %d).",
-							    dev->data->port_id);
-				}
-			}
 			if (use_flex) {
-				rx_func_type = IAVF_RX_SSE_SCATTERED_FLEX_RXD;
+				adapter->rx_func_type = IAVF_RX_SSE_SCATTERED_FLEX_RXD;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX2_SCATTERED_FLEX_RXD;
 					else
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX512_SCATTERED_FLEX_RXD;
 					else
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD;
 				}
 #endif
 			} else {
-				rx_func_type = IAVF_RX_SSE_SCATTERED;
+				adapter->rx_func_type = IAVF_RX_SSE_SCATTERED;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX2_SCATTERED;
 					else
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX2_SCATTERED_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX512_SCATTERED;
 					else
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX512_SCATTERED_OFFLOAD;
 				}
 #endif
 			}
 		} else {
-			if (!use_avx2 && !use_avx512) {
-				PMD_DRV_LOG(DEBUG, "Using Vector Rx (port %d).",
-					    dev->data->port_id);
-			} else {
-				if (use_avx2) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX2 Vector Rx (port %d).",
-							    dev->data->port_id);
-					else
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX2 OFFLOAD Vector Rx (port %d).",
-							    dev->data->port_id);
-				} else {
-					if (check_ret == IAVF_VECTOR_PATH)
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX512 Vector Rx (port %d).",
-							    dev->data->port_id);
-					else
-						PMD_DRV_LOG(DEBUG,
-							    "Using AVX512 OFFLOAD Vector Rx (port %d).",
-							    dev->data->port_id);
-				}
-			}
 			if (use_flex) {
-				rx_func_type = IAVF_RX_SSE_FLEX_RXD;
+				adapter->rx_func_type = IAVF_RX_SSE_FLEX_RXD;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type = IAVF_RX_AVX2_FLEX_RXD;
+						adapter->rx_func_type = IAVF_RX_AVX2_FLEX_RXD;
 					else
-						rx_func_type = IAVF_RX_AVX2_FLEX_RXD_OFFLOAD;
+						adapter->rx_func_type =
+							IAVF_RX_AVX2_FLEX_RXD_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type = IAVF_RX_AVX512_FLEX_RXD;
+						adapter->rx_func_type = IAVF_RX_AVX512_FLEX_RXD;
 					else
-						rx_func_type =
+						adapter->rx_func_type =
 							IAVF_RX_AVX512_FLEX_RXD_OFFLOAD;
 				}
 #endif
 			} else {
-				rx_func_type = IAVF_RX_SSE;
+				adapter->rx_func_type = IAVF_RX_SSE;
 				if (use_avx2) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type = IAVF_RX_AVX2;
+						adapter->rx_func_type = IAVF_RX_AVX2;
 					else
-						rx_func_type = IAVF_RX_AVX2_OFFLOAD;
+						adapter->rx_func_type = IAVF_RX_AVX2_OFFLOAD;
 				}
 #ifdef CC_AVX512_SUPPORT
 				if (use_avx512) {
 					if (check_ret == IAVF_VECTOR_PATH)
-						rx_func_type = IAVF_RX_AVX512;
+						adapter->rx_func_type = IAVF_RX_AVX512;
 					else
-						rx_func_type = IAVF_RX_AVX512_OFFLOAD;
+						adapter->rx_func_type = IAVF_RX_AVX512_OFFLOAD;
 				}
 #endif
 			}
 		}
-
-		if (no_poll_on_link_down) {
-			adapter->rx_func_type = rx_func_type;
-			dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
-		} else {
-			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst;
-		}
-		return;
+		goto out;
 	}
 #elif defined RTE_ARCH_ARM
 	int check_ret;
@@ -4136,43 +4084,33 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 			rxq = dev->data->rx_queues[i];
 			(void)iavf_rxq_vec_setup(rxq);
 		}
-		rx_func_type = IAVF_RX_SSE;
+		adapter->rx_func_type = IAVF_RX_SSE;
 
-		if (no_poll_on_link_down) {
-			adapter->rx_func_type = rx_func_type;
-			dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
-		} else {
-			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst;
-		}
-		return;
+		goto out;
 	}
 #endif
 	if (dev->data->scattered_rx) {
-		PMD_DRV_LOG(DEBUG, "Using a Scattered Rx callback (port=%d).",
-			    dev->data->port_id);
 		if (use_flex)
-			rx_func_type = IAVF_RX_SCATTERED_FLEX_RXD;
+			adapter->rx_func_type = IAVF_RX_SCATTERED_FLEX_RXD;
 		else
-			rx_func_type = IAVF_RX_SCATTERED;
+			adapter->rx_func_type = IAVF_RX_SCATTERED;
 	} else if (adapter->rx_bulk_alloc_allowed) {
-		PMD_DRV_LOG(DEBUG, "Using bulk Rx callback (port=%d).",
-			    dev->data->port_id);
-		rx_func_type = IAVF_RX_BULK_ALLOC;
+		adapter->rx_func_type = IAVF_RX_BULK_ALLOC;
 	} else {
-		PMD_DRV_LOG(DEBUG, "Using Basic Rx callback (port=%d).",
-			    dev->data->port_id);
 		if (use_flex)
-			rx_func_type = IAVF_RX_FLEX_RXD;
+			adapter->rx_func_type = IAVF_RX_FLEX_RXD;
 		else
-			rx_func_type = IAVF_RX_DEFAULT;
+			adapter->rx_func_type = IAVF_RX_DEFAULT;
 	}
 
-	if (no_poll_on_link_down) {
-		adapter->rx_func_type = rx_func_type;
+out:
+	if (no_poll_on_link_down)
 		dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
-	} else {
-		dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst;
-	}
+	else
+		dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[adapter->rx_func_type].pkt_burst;
+
+	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
+		iavf_rx_pkt_burst_ops[adapter->rx_func_type].info, dev->data->port_id);
 }
 
 /* choose tx function*/
-- 
2.34.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9FFC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D04A40658;
	Thu,  7 Aug 2025 14:40:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 108564042E
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570398; x=1786106398;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aSAMVbN1f/6oA6y64MpKSUFg4BMroXA6SJkhwr08Skc=;
 b=fV9ZJOqSmUf60cRy8GJhNikbXmFMfLRbkpo1qEBd8wPbqikBRd1KatHp
 ZSYWpH+YHUIZTVKTjlvcBS/DSoLZQxdy7Gniv3GCP4ye2h3yEJE9Ze0K6
 3imVWu1JLQARM43JWIS4m0YwMzUiqovdO805vL0BQBl+/TMP4M4lZg1Dw
 hKCETGdYdTagJcDmPYojR5mlSRt2NYVvjy8mtKahOybWz7vnZkR/Fldhn
 UZ/GVaieS7xaLZHR6u5IwUqx/cmO7T6UXVRIDZZs7RbdzIwb9Bhz5tqQr
 LPi+FMJkEh8FyoTrlPRSt3EbwG8xFhoWjf2W8WihDZRRmo8+SeZJJIQsy A==;
X-CSE-ConnectionGUID: gYi/IYHYT2OEPs7iAgVxDg==
X-CSE-MsgGUID: J2VtLUtdQLiHxIXXyLL0hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981116"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981116"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:39:57 -0700
X-CSE-ConnectionGUID: avSB53M+RNW4iZQ/6spHyw==
X-CSE-MsgGUID: UC8eTsqwRTOtDwAuxEjtCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886721"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:39:56 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 03/15] net/iavf: use the same Rx path across process types
Date: Thu,  7 Aug 2025 12:39:37 +0000
Message-Id: <20250807123949.4063416-4-ciara.loftus@intel.com>
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


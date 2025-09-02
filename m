Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084ACA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 10:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D844E40665;
	Tue,  2 Sep 2025 12:49:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id BDDA1402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 12:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756810167; x=1788346167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ytGtSXHnrARLI+YpPAyMxXIimyDpqSXhMNr4TCHwV/M=;
 b=WpHLgufQ9707UDJpS2Ys6Rcv/12ARf5cqRDXgnxPdvTIy5hOrRjy1972
 3YpC3Yw6aFvw4GDD6uiq4S1+RyJJ3D5BF4MMYXr97VZKdeaT6jqs7sGOO
 YkABb/SpCzGQFm2xW/YrOvxarRljcmz6R0Ia5ObZ7L0hyhkKdUjf66ldX
 I3dqrqKZQuo2DvfYK5QvqBwz6TmFx67QtTq43SFWu+Y9G/gQ5FNLmtdj5
 Njd1Pj52LqyJgteY84cMkMyO+iXehR4mAXzWSc3gThuTLqQYkEtAJnRoc
 qtGFtI1ekh05LZa7oP7vP/B1BhQCdxcVuPrZEK4+7Xa9LAvWmYODrbf61 A==;
X-CSE-ConnectionGUID: eZZf1MKbTP6djHfIzkWCWw==
X-CSE-MsgGUID: efg9AsJOSLysAfJHoMK0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59014551"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="59014551"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 03:49:26 -0700
X-CSE-ConnectionGUID: UJ3WNZK6TN68XC7vCwflYQ==
X-CSE-MsgGUID: C/wDdel9SEKjkMhoBebf2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="175609394"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa004.jf.intel.com with ESMTP; 02 Sep 2025 03:49:26 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 3/4] net/i40e: remove redundant vector Rx queue setup code
Date: Tue,  2 Sep 2025 10:48:58 +0000
Message-Id: <20250902104859.2100141-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902104859.2100141-1-ciara.loftus@intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
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

Some assignments were being done twice:
1. Marking each rxq as a vector queue
2. Marking the device as vector allowed

This commit makes sure that these are only performed once.

Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 434959e1c0..e22233daae 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3338,7 +3338,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
-	uint16_t vector_rx, i;
+	uint16_t i;
 	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
 
 	/* The primary process selects the rx path for all processes. */
@@ -3367,11 +3367,13 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 						&i40e_rx_path_infos[0],
 						RTE_DIM(i40e_rx_path_infos),
 						I40E_RX_DEFAULT);
-	if (i40e_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+	if (i40e_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128) {
 		/* Vector function selected. Prepare the rxq accordingly. */
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
 			if (dev->data->rx_queues[i])
 				i40e_rxq_vec_setup(dev->data->rx_queues[i]);
+		ad->rx_vec_allowed = true;
+	}
 
 	if (i40e_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128 &&
 			i40e_rx_path_infos[ad->rx_func_type].features.simd_width <
@@ -3382,29 +3384,6 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 	dev->rx_pkt_burst = i40e_rx_path_infos[ad->rx_func_type].pkt_burst;
 	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
 			i40e_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
-
-	/* Propagate information about RX function choice through all queues. */
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		vector_rx =
-			(dev->rx_pkt_burst == i40e_recv_scattered_pkts_vec ||
-			 dev->rx_pkt_burst == i40e_recv_pkts_vec ||
-#ifdef CC_AVX512_SUPPORT
-			 dev->rx_pkt_burst == i40e_recv_scattered_pkts_vec_avx512 ||
-			 dev->rx_pkt_burst == i40e_recv_pkts_vec_avx512 ||
-#endif
-			 dev->rx_pkt_burst == i40e_recv_scattered_pkts_vec_avx2 ||
-			 dev->rx_pkt_burst == i40e_recv_pkts_vec_avx2);
-
-		for (i = 0; i < dev->data->nb_rx_queues; i++) {
-			struct ci_rx_queue *rxq = dev->data->rx_queues[i];
-
-			if (rxq)
-				rxq->vector_rx = vector_rx;
-		}
-	}
-
-	ad->rx_vec_allowed = i40e_rx_path_infos[ad->rx_func_type].features.simd_width >=
-				RTE_VECT_SIMD_128;
 }
 
 int
-- 
2.34.1


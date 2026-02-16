Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E9EE7BD86
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 10:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BBC440289;
	Mon, 16 Feb 2026 11:23:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A872140269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 11:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771237393; x=1802773393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ydjGRnDWBj1Y8k+czd9UziHGbwJFHdyiYOKRcjFkoUs=;
 b=FjDjbyEgG45gHrwqbjxN1/VKv8F8dgp8QLXF3ErHRiHzHGVJhhjN0K5z
 h9i9MhXJpZtP0L7kfKM3VD8iC5MH43CvbSL2PPEuPTp4hXQymg0W246LM
 Y1ni0aGW6dyhDggOgOj5xErA5cKgJTXTbsbDLxZ1qcJtsY0xym3nnHq6a
 sl3b2GiJt5us1bnU8vrM3jVg96XQIbNe9qZzaiXWPMoUk0ZmI094Xh+6u
 /VUsmxGWfzGojPmkr2QOkQNb7oPI0OChy2VVX9+2AKCwBytdfD6DUeLwH
 AfnAuZNQWqrgT9tGoSsgW6MtWmlI2gTISwAiFm7MswrE1UDn4YPVDx/D5 A==;
X-CSE-ConnectionGUID: f6snM/P6RPqvxtmFSoWOCA==
X-CSE-MsgGUID: VB/0qdMGQ5OBtW0qrjALoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72219448"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72219448"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 02:23:12 -0800
X-CSE-ConnectionGUID: LR8sxZaJQqeCOs/LhCf3iA==
X-CSE-MsgGUID: HHuRweeKRm+xsa6xdfeJdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="217573633"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa004.fm.intel.com with ESMTP; 16 Feb 2026 02:23:12 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] net/iavf: fix txq flags setting after Tx path selection
Date: Mon, 16 Feb 2026 10:22:53 +0000
Message-ID: <20260216102253.2801021-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210095045.1901921-1-ciara.loftus@intel.com>
References: <20260210095045.1901921-1-ciara.loftus@intel.com>
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

Ensure the txq flags "use_ctx" and "use_vec_entry" are set/unset
properly after tx path selection. Prior to this commit these flags were
only configured if a vector path was chosen. Fix this by making their
configuration unconditional. Also simplify how the "use_vec_entry" flag
is set by removing the dedicated function that sets the flag in favour
of just setting it inline.

Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
* Get a pointer to the selected tx path features and use it instead of
 directly referencing it twice in a row.
* Use >= SIMD_128 instead of != 0 to determine if a selected path is
 vector (future proofing).
---
 drivers/net/intel/iavf/iavf_rxtx.c          | 17 ++++++++---------
 drivers/net/intel/iavf/iavf_rxtx.h          |  1 -
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c |  7 -------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index e621d4bf47..4bcdd202c0 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3871,6 +3871,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 #ifdef RTE_ARCH_X86
 	struct ci_tx_queue *txq;
 	int i;
+	const struct ci_tx_path_features *selected_features;
 #endif
 	struct ci_tx_path_features req_features = {
 		.tx_offloads = dev->data->dev_conf.txmode.offloads,
@@ -3905,15 +3906,13 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 
 out:
 #ifdef RTE_ARCH_X86
-	if (iavf_tx_path_infos[adapter->tx_func_type].features.simd_width != 0) {
-		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			txq = dev->data->tx_queues[i];
-			if (!txq)
-				continue;
-			iavf_txq_vec_setup(txq);
-			txq->use_ctx =
-				iavf_tx_path_infos[adapter->tx_func_type].features.ctx_desc;
-		}
+	selected_features = &iavf_tx_path_infos[adapter->tx_func_type].features;
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (!txq)
+			continue;
+		txq->use_ctx = selected_features->ctx_desc;
+		txq->use_vec_entry = selected_features->simd_width >= RTE_VECT_SIMD_128;
 	}
 #endif
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index fe3385dcf6..80b06518b0 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -592,7 +592,6 @@ int iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
 int iavf_rx_vec_dev_check(struct rte_eth_dev *dev);
 int iavf_tx_vec_dev_check(struct rte_eth_dev *dev);
 int iavf_rxq_vec_setup(struct ci_rx_queue *rxq);
-int iavf_txq_vec_setup(struct ci_tx_queue *txq);
 uint16_t iavf_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				   uint16_t nb_pkts);
 uint16_t iavf_recv_pkts_vec_avx512_offload(void *rx_queue,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 2e18be3616..db0462f0f5 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1800,13 +1800,6 @@ iavf_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return iavf_xmit_pkts_vec_avx2_common(tx_queue, tx_pkts, nb_pkts, true);
 }
 
-int __rte_cold
-iavf_txq_vec_setup(struct ci_tx_queue *txq)
-{
-	txq->use_vec_entry = true;
-	return 0;
-}
-
 void __rte_cold
 iavf_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
-- 
2.43.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9810DEA3F2A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:51:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80C0E400D7;
	Tue, 10 Feb 2026 10:51:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id F2339400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:51:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770717067; x=1802253067;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+lvi0VV/spSQg9AkYZKzLt6JPfY9TtWHDzPVVgXekfc=;
 b=njKUu0rcNXJaXYOJnVTZJARquKGNRs0qkcyUXF9iyFpr9NsWkLsqSxhk
 hxObhGVCKD9xdzFMTw1pt0xZrqnKFCu0WJBP44X9kpOPxK2HoXwjPHEpP
 xv6D4wUfYVz/7ynuIwEZ2Qr7c5Il+QVyCKTVEWbJ8mIUsxc8tGUFTec2O
 6roMXOkPxxcMfV1aFeNyn6tgaBkDcH+vSLTwq8xUToaLfBmPnxsPRTOOa
 lyJ1H9Ob7LeKbem3Rjz/9CuK66i/FRPYUzzO0/XfI/UKoAst7PMxVPBD6
 2503fCaKvxkIdzLwEjjdwS6zzgwDnFL/cbNs80MI92elxiF7EB46SWlT/ g==;
X-CSE-ConnectionGUID: KlAdd0++QrKhgJ4q+ZgxVg==
X-CSE-MsgGUID: m8MFPGJ6QAi7g9z617Rb4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="74443921"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="74443921"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 01:51:05 -0800
X-CSE-ConnectionGUID: pzACl8cJRf+hQuK5b8qFoA==
X-CSE-MsgGUID: dDkfQl5eQjiX74Z/zx0uqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211197572"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 01:51:04 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/iavf: fix txq flags setting after Tx path selection
Date: Tue, 10 Feb 2026 09:50:44 +0000
Message-ID: <20260210095045.1901921-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Ensure the txq flags "use_ctx" and "vector_tx" are set/unset properly
after tx path selection. Prior to this commit these flags were only
configured if a vector path was chosen. Fix this by making their
configuration unconditional. Also simplify how the "vector_tx" flag is
set by removing the dedicated function that sets the flag in favour of
just setting it inline.

Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c          | 15 ++++++---------
 drivers/net/intel/iavf/iavf_rxtx.h          |  1 -
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c |  7 -------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4b763627bc..da8ac488fe 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4263,15 +4263,12 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 
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
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (!txq)
+			continue;
+		txq->use_ctx = iavf_tx_path_infos[adapter->tx_func_type].features.ctx_desc;
+		txq->vector_tx = iavf_tx_path_infos[adapter->tx_func_type].features.simd_width != 0;
 	}
 #endif
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index e1f78dcde0..d258c1fc1b 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -615,7 +615,6 @@ int iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
 int iavf_rx_vec_dev_check(struct rte_eth_dev *dev);
 int iavf_tx_vec_dev_check(struct rte_eth_dev *dev);
 int iavf_rxq_vec_setup(struct ci_rx_queue *rxq);
-int iavf_txq_vec_setup(struct ci_tx_queue *txq);
 uint16_t iavf_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				   uint16_t nb_pkts);
 uint16_t iavf_recv_pkts_vec_avx512_offload(void *rx_queue,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index e29958e0bc..1849af166a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1811,13 +1811,6 @@ iavf_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return iavf_xmit_pkts_vec_avx2_common(tx_queue, tx_pkts, nb_pkts, true);
 }
 
-int __rte_cold
-iavf_txq_vec_setup(struct ci_tx_queue *txq)
-{
-	txq->vector_tx = true;
-	return 0;
-}
-
 void __rte_cold
 iavf_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
-- 
2.43.0


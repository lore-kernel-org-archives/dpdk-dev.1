Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91776C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2168542EDC;
	Wed, 16 Sep 2026 12:36:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1326A42EAB
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789555002; x=1821091002;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Hioj3jE4yNUMONEwn7wh0iVpscoVnXQB/leeh0qE4k=;
 b=FKsYmMFLn9FM9RTO19tdAdpWNqFoa9EElKKGVDZchUrxdxIysgxRjQFT
 d/1od17dBgyWESGUyExlEJ4QZAdGyXLHueC1c9XJu+zVEcFpStT/Kexop
 SoET3CPICV6NI6jRot4OUv0YfCwnuaj/oJESktQ9BSkssAvGg7IgbiuVx
 GgyavYshIXPt+Gs3WP/KEYZEv6JgHaHfSdLZROmFpLdtfM4qaVRBpbD7z
 qqLHmRMM5qA9f/ZD+tjd0HFK9ZsVfGLHgCoLjIK8I3uXv2Gjh3HN2XNlu
 msT9qH5IDw2kC9NGj6zZwBkEK/AaEFlShoI+HFU21X6FH0IKuSaqvuoNN A==;
X-CSE-ConnectionGUID: 0WFQdgkNSaWV0auxBCUAKA==
X-CSE-MsgGUID: m1+Wa0XjReyJjV8O4gPKmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867634"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867634"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:41 -0700
X-CSE-ConnectionGUID: NbpOLnOJSmq6tLiZk+wrbg==
X-CSE-MsgGUID: ZZAaQweKQ4CNkqnpTOGgNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528290"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 11/15] net/ice: use common AVX Tx functions
Date: Wed, 16 Sep 2026 11:36:18 +0100
Message-ID: <20260916103622.319874-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916103622.319874-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
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

Use the newly created common Tx functions in the vector path.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |  72 +-------------
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 102 +++-----------------
 2 files changed, 14 insertions(+), 160 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 68401560ce..00b5d51aab 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -774,74 +774,6 @@ ice_recv_scattered_pkts_vec_avx2_offload(void *rx_queue,
 						       true);
 }
 
-static __rte_always_inline uint16_t
-ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
-			      uint16_t nb_pkts, bool offload)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
-	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
-
-	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, ice_tx_desc_done, false);
-
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	tx_id = txq->tx_tail;
-	txdp = &txq->ci_tx_ring[tx_id];
-	txep = &txq->sw_ring_vec[tx_id];
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-	if (nb_commit >= n) {
-		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
-
-		ci_vtx_avx2(txdp, tx_pkts, n - 1, flags, offload,
-			CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
-		tx_pkts += (n - 1);
-		txdp += (n - 1);
-
-		ci_vtx1(txdp, *tx_pkts++, rs, offload, CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		tx_id = 0;
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-		/* avoid reach the end of ring */
-		txdp = &txq->ci_tx_ring[tx_id];
-		txep = &txq->sw_ring_vec[tx_id];
-	}
-
-	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
-
-	ci_vtx_avx2(txdp, tx_pkts, nb_commit, flags, offload,
-		CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
-
-	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->tx_next_rs) {
-		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
 static __rte_always_inline uint16_t
 ice_xmit_pkts_vec_avx2_common(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts, bool offload)
@@ -853,8 +785,8 @@ ice_xmit_pkts_vec_avx2_common(void *tx_queue, struct rte_mbuf **tx_pkts,
 		uint16_t ret, num;
 
 		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = ice_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx],
-						    num, offload);
+		ret = ci_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx], num,
+				offload, CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 		nb_tx += ret;
 		nb_pkts -= ret;
 		if (ret < num)
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index b4695c398e..d8ede5cb42 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -848,77 +848,8 @@ ice_recv_scattered_pkts_vec_avx512_offload(void *rx_queue,
 }
 
 static __rte_always_inline uint16_t
-ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
-				uint16_t nb_pkts, bool do_offload)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
-	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
-
-	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, ice_tx_desc_done, false);
-
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	tx_id = txq->tx_tail;
-	txdp = &txq->ci_tx_ring[tx_id];
-	txep = (void *)txq->sw_ring;
-	txep += tx_id;
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-	if (nb_commit >= n) {
-		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
-
-		ci_vtx_avx512(txdp, tx_pkts, n - 1, flags, do_offload,
-			CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
-		tx_pkts += (n - 1);
-		txdp += (n - 1);
-
-		ci_vtx1(txdp, *tx_pkts++, rs, do_offload, CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		tx_id = 0;
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-		/* avoid reach the end of ring */
-		txdp = txq->ci_tx_ring;
-		txep = (void *)txq->sw_ring;
-	}
-
-	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
-
-	ci_vtx_avx512(txdp, tx_pkts, nb_commit, flags, do_offload,
-		CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
-
-	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->tx_next_rs) {
-		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
-uint16_t
-ice_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
-			 uint16_t nb_pkts)
+ice_xmit_pkts_vec_avx512_common(void *tx_queue, struct rte_mbuf **tx_pkts,
+				uint16_t nb_pkts, bool offload)
 {
 	uint16_t nb_tx = 0;
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
@@ -927,8 +858,8 @@ ice_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 		uint16_t ret, num;
 
 		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = ice_xmit_fixed_burst_vec_avx512(tx_queue,
-				&tx_pkts[nb_tx], num, false);
+		ret = ci_xmit_fixed_burst_vec_avx512(tx_queue, &tx_pkts[nb_tx], num,
+				offload, CI_TAG_IN_DATA_DESC, CI_TAG_IN_DATA_DESC);
 		nb_tx += ret;
 		nb_pkts -= ret;
 		if (ret < num)
@@ -938,25 +869,16 @@ ice_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
+uint16_t
+ice_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
+			 uint16_t nb_pkts)
+{
+	return ice_xmit_pkts_vec_avx512_common(tx_queue, tx_pkts, nb_pkts, false);
+}
+
 uint16_t
 ice_xmit_pkts_vec_avx512_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts)
 {
-	uint16_t nb_tx = 0;
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-
-	while (nb_pkts) {
-		uint16_t ret, num;
-
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = ice_xmit_fixed_burst_vec_avx512(tx_queue,
-				&tx_pkts[nb_tx], num, true);
-
-		nb_tx += ret;
-		nb_pkts -= ret;
-		if (ret < num)
-			break;
-	}
-
-	return nb_tx;
+	return ice_xmit_pkts_vec_avx512_common(tx_queue, tx_pkts, nb_pkts, true);
 }
-- 
2.53.0


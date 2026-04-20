Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C71F55809
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 10:31:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BF8C402E7;
	Mon, 20 Apr 2026 12:31:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E62584064C
 for <dev@dpdk.org>; Mon, 20 Apr 2026 12:31:00 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935881596;
 Mon, 20 Apr 2026 03:30:54 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C7DB3F99C;
 Mon, 20 Apr 2026 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776681060; bh=s+9xcWBu8ZUzhpUV31wLbZ4sg+bc9Z0L3nnbiXsxt+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=btrLqdfuvdto1ikSPoEjgF3cboVz1jBL8M91Zc2jQ7JDJ/ue6JLS7TcTPbaaRTYdt
 WEoJnAKWcyQN3ZqWU1ry9Bemb4a2YnUW2EL6vBkwaG7Bxxwl/wIM0gwNA3u9vPdubi
 vW1fVkfQgYltA1AqFvBLcduAEoLeBRwftTMLA87U=
From: Jay Wang <jay.wang2@arm.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v2 2/3] net/iavf: add NEON-optimised Tx burst function
Date: Mon, 20 Apr 2026 10:30:37 +0000
Message-ID: <20260420103042.2836732-3-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420103042.2836732-1-jay.wang2@arm.com>
References: <20260417130833.2503592-1-jay.wang2@arm.com>
 <20260420103042.2836732-1-jay.wang2@arm.com>
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

This patch adds the NEON-optimised Tx burst function for Intel IAVF
driver on AArch64.

Signed-off-by: Jay Wang <jay.wang2@arm.com>
---
 drivers/net/intel/iavf/iavf.h               |   1 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  15 ++-
 drivers/net/intel/iavf/iavf_rxtx.h          |   2 -
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 120 ++++++++++++++++++++
 4 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index e4936f3566..3e71d345a9 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -356,6 +356,7 @@ enum iavf_rx_func_type {
 enum iavf_tx_func_type {
 	IAVF_TX_DISABLED,
 	IAVF_TX_DEFAULT,
+	IAVF_TX_NEON,
 	IAVF_TX_AVX2,
 	IAVF_TX_AVX2_OFFLOAD,
 	IAVF_TX_AVX512,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 15566a0e18..645bc5ccf6 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3662,6 +3662,15 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		}
 	},
 #endif
+#elif defined(RTE_ARCH_ARM64)
+	[IAVF_TX_NEON] = {
+		.pkt_burst = iavf_xmit_pkts_vec,
+		.info = "Vector Neon",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128
+		}
+	},
 #endif
 };
 
@@ -3878,7 +3887,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int mbuf_check = adapter->devargs.mbuf_check;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
-#ifdef RTE_ARCH_X86
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	struct ci_tx_queue *txq;
 	int i;
 	const struct ci_tx_path_features *selected_features;
@@ -3892,7 +3901,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	if (dev->data->dev_started)
 		goto out;
 
-#ifdef RTE_ARCH_X86
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	if (iavf_tx_vec_dev_check(dev) != -1)
 		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
@@ -3915,7 +3924,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 						IAVF_TX_DEFAULT);
 
 out:
-#ifdef RTE_ARCH_X86
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	selected_features = &iavf_tx_path_infos[adapter->tx_func_type].features;
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 80b06518b0..8b8e55e66f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -558,8 +558,6 @@ uint16_t iavf_recv_scattered_pkts_vec(void *rx_queue,
 uint16_t iavf_recv_scattered_pkts_vec_flex_rxd(void *rx_queue,
 					       struct rte_mbuf **rx_pkts,
 					       uint16_t nb_pkts);
-uint16_t iavf_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
-				  uint16_t nb_pkts);
 uint16_t iavf_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				 uint16_t nb_pkts);
 uint16_t iavf_recv_pkts_vec_avx2_offload(void *rx_queue, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index 45e377d728..9c91b6bac1 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -445,6 +445,120 @@ iavf_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			rx_pkts + retval, nb_pkts);
 }
 
+static __rte_always_inline void
+iavf_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
+	 uint64_t flags)
+{
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+
+	uint64x2_t descriptor = {rte_pktmbuf_iova(pkt), high_qw};
+	vst1q_u64(RTE_CAST_PTR(uint64_t *, txdp), descriptor);
+}
+
+static __rte_always_inline void
+iavf_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
+	uint16_t nb_pkts, uint64_t flags)
+{
+	int i;
+
+	for (i = 0; i < nb_pkts; ++i, ++txdp, ++pkt)
+		iavf_vtx1(txdp, *pkt, flags);
+}
+
+static __rte_always_inline uint16_t
+iavf_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts)
+{
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, tx_id;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
+	int i;
+
+	/* cross rx_thresh boundary is not allowed */
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false);
+
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	nb_commit = nb_pkts;
+	if (unlikely(nb_pkts == 0))
+		return 0;
+
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
+
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+	if (nb_commit >= n) {
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
+
+		for (i = 0; i < n - 1; ++i, ++tx_pkts, ++txdp)
+			iavf_vtx1(txdp, *tx_pkts, flags);
+
+		/* write with RS for the last descriptor in the segment */
+		iavf_vtx1(txdp, *tx_pkts++, rs);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		tx_id = 0;
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+
+		/* avoid reach the end of ring */
+		txdp = &txq->ci_tx_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
+	}
+
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
+
+	iavf_vtx(txdp, tx_pkts, nb_commit, flags);
+
+	tx_id = (uint16_t)(tx_id + nb_commit);
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
+					 CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	IAVF_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
+
+	return nb_pkts;
+}
+
+uint16_t
+iavf_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
+		   uint16_t nb_pkts)
+{
+	uint16_t nb_tx = 0;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+
+		/* cross rs_thresh boundary is not allowed */
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+		ret = iavf_xmit_fixed_burst_vec(tx_queue, &tx_pkts[nb_tx],
+				num);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
 void __rte_cold
 iavf_rx_queue_release_mbufs_neon(struct ci_rx_queue *rxq)
 {
@@ -465,6 +579,12 @@ iavf_rx_vec_dev_check(struct rte_eth_dev *dev)
 	return iavf_rx_vec_dev_check_default(dev);
 }
 
+int __rte_cold
+iavf_tx_vec_dev_check(struct rte_eth_dev *dev)
+{
+	return iavf_tx_vec_dev_check_default(dev);
+}
+
 enum rte_vect_max_simd
 iavf_get_max_simd_bitwidth(void)
 {
-- 
2.43.0


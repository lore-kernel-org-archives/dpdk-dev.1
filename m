Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8934D2F327
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50AB640E32;
	Tue, 13 Jan 2026 16:15:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id EB71440E3B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317355; x=1799853355;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wRgK7wvkAZ7dE6aHCI0F+Z5kaS5m4qK8OIVZmInoNtI=;
 b=d1Lj4a70nzU9BRYXDSia1Zn5xy4C6C61Ri5zvi6Yt2XC106oeXnsQ3lf
 VASVTYZ/NGTQRJEZFTSYaOoQgZjop7aEugOnFJXMC7tQxDUIw5uolKPk0
 kFlyxzTciUJssSvj9cEIeMjPtDb2Qeq4ARufnxuZIVKkm6ufC42LfXcv9
 22wc2KgeBharNlip0xBMxO3X/Q+q/pZWv065N6IPY5b91a9viYSVL1vfQ
 tij2qCI8JUHVQVwem/e8MOMSoLL5Ki1KdgzZoXuCuvnnqU6H1X4C4XA2b
 t/jU+SUSEUs3YVH3su6ZRuLHvIarc6ZbFpL42+9l8CvWvVi5YEMJEWIKk w==;
X-CSE-ConnectionGUID: ZF0SP7EDS4uZ28rHMeH3CQ==
X-CSE-MsgGUID: ymjCsy+aSXOsfsFSB6iPxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969235"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969235"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:55 -0800
X-CSE-ConnectionGUID: 7vsPlMKiRBSW8qhQttI+yw==
X-CSE-MsgGUID: YjO8C5DjRDaXi45xoU7QfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556676"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:54 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 33/36] net/intel: align scalar simple Tx path with vector
 logic
Date: Tue, 13 Jan 2026 15:14:57 +0000
Message-ID: <20260113151505.1871271-34-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

The scalar simple Tx path has the same restrictions as the vector Tx
path, so we can use the same logic flow in both, to try and ensure we
get best performance from the scalar path.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 54 +++++++++++++++---------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 16f802e902..f85ca741a9 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -21,13 +21,11 @@ write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
 	txd_qw[1] = rte_cpu_to_le_64(qw1);
 }
 
-/* Fill hardware descriptor ring with mbuf data */
+/* Fill hardware descriptor ring with mbuf data (simple path) */
 static inline void
-ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
-		   uint16_t nb_pkts)
+ci_tx_fill_hw_ring_simple(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts,
+			  uint16_t nb_pkts)
 {
-	volatile struct ci_tx_desc *txdp = &txq->ci_tx_ring[txq->tx_tail];
-	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
 	const int N_PER_LOOP = 4;
 	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
 	int mainpart, leftover;
@@ -36,8 +34,6 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	mainpart = nb_pkts & ((uint32_t)~N_PER_LOOP_MASK);
 	leftover = nb_pkts & ((uint32_t)N_PER_LOOP_MASK);
 	for (i = 0; i < mainpart; i += N_PER_LOOP) {
-		for (j = 0; j < N_PER_LOOP; ++j)
-			(txep + i + j)->mbuf = *(pkts + i + j);
 		for (j = 0; j < N_PER_LOOP; ++j)
 			write_txd(txdp + i + j, rte_mbuf_data_iova(*(pkts + i + j)),
 				CI_TX_DESC_DTYPE_DATA |
@@ -48,12 +44,10 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	if (unlikely(leftover > 0)) {
 		for (i = 0; i < leftover; ++i) {
 			uint16_t idx = mainpart + i;
-			(txep + idx)->mbuf = *(pkts + idx);
 			write_txd(txdp + idx, rte_mbuf_data_iova(*(pkts + idx)),
 				CI_TX_DESC_DTYPE_DATA |
 				((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
 				((uint64_t)(*(pkts + idx))->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-
 		}
 	}
 }
@@ -127,6 +121,9 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 		     uint16_t nb_pkts)
 {
 	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry *txep;
+	uint16_t tx_id;
 	uint16_t n = 0;
 
 	/**
@@ -142,23 +139,41 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 	if (unlikely(!nb_pkts))
 		return 0;
 
+	tx_id = txq->tx_tail;
+	txdp = &txr[tx_id];
+	txep = &txq->sw_ring[tx_id];
+
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-	if ((txq->tx_tail + nb_pkts) > txq->nb_tx_desc) {
-		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
-		ci_tx_fill_hw_ring(txq, tx_pkts, n);
+
+	if ((tx_id + nb_pkts) > txq->nb_tx_desc) {
+		n = (uint16_t)(txq->nb_tx_desc - tx_id);
+
+		/* Store mbufs in backlog */
+		ci_tx_backlog_entry(txep, tx_pkts, n);
+
+		/* Write descriptors to HW ring */
+		ci_tx_fill_hw_ring_simple(txdp, tx_pkts, n);
+
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
 					  CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-		txq->tx_tail = 0;
+
+		tx_id = 0;
+		txdp = &txr[tx_id];
+		txep = &txq->sw_ring[tx_id];
 	}
 
-	/* Fill hardware descriptor ring with mbuf data */
-	ci_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
-	txq->tx_tail = (uint16_t)(txq->tx_tail + (nb_pkts - n));
+	/* Store remaining mbufs in backlog */
+	ci_tx_backlog_entry(txep, tx_pkts + n, (uint16_t)(nb_pkts - n));
+
+	/* Write remaining descriptors to HW ring */
+	ci_tx_fill_hw_ring_simple(txdp, tx_pkts + n, (uint16_t)(nb_pkts - n));
+
+	tx_id = (uint16_t)(tx_id + (nb_pkts - n));
 
 	/* Determine if RS bit needs to be set */
-	if (txq->tx_tail > txq->tx_next_rs) {
+	if (tx_id > txq->tx_next_rs) {
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
 					  CI_TXD_QW1_CMD_S);
@@ -168,11 +183,10 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 			txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 	}
 
-	if (txq->tx_tail >= txq->nb_tx_desc)
-		txq->tx_tail = 0;
+	txq->tx_tail = tx_id;
 
 	/* Update the tx tail register */
-	rte_write32_wc((uint32_t)txq->tx_tail, txq->qtx_tail);
+	rte_write32_wc((uint32_t)tx_id, txq->qtx_tail);
 
 	return nb_pkts;
 }
-- 
2.51.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E1CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C94BD40E4A;
	Wed, 14 Oct 2026 17:10:12 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id B6D1C40B90
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=KNf5E358Z1m+GGg+gTBDd3VWxnNZrIRxc1gGDi4WmiQ=;
 b=kVZdQVqtK2/zFbW0en3e10MXA/MGn9sWSByfAwHFZjZUciJjWWwetcs/7N+95N
 UIHFkTeo6mgp8T+CiSrWmswDKOotTgq/dMvBqVofPIMGckqRYsJ2hpH8hki9egwi
 QE8kixR7+CTWkm/1vSpqnTfYMeaPtkfdT+DqPH1n5yu1M=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 26/26] net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops
Date: Wed, 14 Oct 2026 23:09:22 +0800
Message-ID: <20261014150923.838-27-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S28
X-Coremail-Antispam: 1Uf129KBjvAXoWfWF1fCFWkZF4xur4DJw1xGrg_yoW5XF45to
 WftF1avw1xJw1IkF9IgF1kK3yDAw1DX3Z8Ja93WF9FqFy7J34UG3Z8Aw1F93WagayrA3W3
 AFn3Kr1DZ3yDu3y5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwb10UUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMx6EjmrPmz4eRwAA3+
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

Move prefetch, packet-drop, and CEQ context setup into per-tile cmdq ops so
each tile can apply its own policy and runtime coalescing parameters.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_nic_io.c            | 146 +++-------------
 drivers/net/hinic3/hinic3_nic_io.h            | 156 +++++++++++++-----
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |  54 +++++-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |   2 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |  56 +++++++
 5 files changed, 241 insertions(+), 173 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index 5b905f203e..73080abcd5 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -11,15 +11,6 @@
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
-#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT	3
-#define HINIC3_DEAULT_TX_CI_COALESCING_TIME	16
-#define HINIC3_DEAULT_DROP_THD_ON		0xFFFF
-#define HINIC3_DEAULT_DROP_THD_OFF		0
-
-#define WQ_PREFETCH_MAX				6
-#define WQ_PREFETCH_MIN				1
-#define WQ_PREFETCH_THRESHOLD			256
-
 #define CI_IDX_HIGH_SHIFH			12
 
 #define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)
@@ -53,16 +44,6 @@
 	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK)	\
 	 << SQ_CTXT_WQ_PAGE_##member##_SHIFT)
 
-#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0
-#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16
-
-#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU
-#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU
-
-#define SQ_CTXT_PKT_DROP_THD_SET(val, member)		\
-	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK)	\
-	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)
-
 #define SQ_CTXT_GLOBAL_SQ_ID_SHIFT		0
 
 #define SQ_CTXT_GLOBAL_SQ_ID_MASK		0x1FFFU
@@ -84,30 +65,6 @@
 	(((val) & SQ_CTXT_VLAN_##member##_MASK)		\
 	 << SQ_CTXT_VLAN_##member##_SHIFT)
 
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
-#define SQ_CTXT_PREF_CACHE_MAX_SHIFT		14
-#define SQ_CTXT_PREF_CACHE_MIN_SHIFT		25
-
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
-#define SQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
-#define SQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
-
-#define SQ_CTXT_PREF_CI_HI_SHIFT		0
-#define SQ_CTXT_PREF_OWNER_SHIFT		4
-
-#define SQ_CTXT_PREF_CI_HI_MASK			0xFU
-#define SQ_CTXT_PREF_OWNER_MASK			0x1U
-
-#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
-#define SQ_CTXT_PREF_CI_LOW_SHIFT		20
-
-#define SQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
-#define SQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
-
-#define SQ_CTXT_PREF_SET(val, member)			\
-	(((val) & SQ_CTXT_PREF_##member##_MASK)		\
-	 << SQ_CTXT_PREF_##member##_SHIFT)
-
 #define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0
 
 #define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU
@@ -125,18 +82,6 @@
 #define RQ_CTXT_CI_PI_SET(val, member)			\
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
 
-#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT		21
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT		30
-#define RQ_CTXT_CEQ_ATTR_EN_SHIFT		31
-
-#define RQ_CTXT_CEQ_ATTR_INTR_MASK		0x3FFU
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK		0x1U
-#define RQ_CTXT_CEQ_ATTR_EN_MASK		0x1U
-
-#define RQ_CTXT_CEQ_ATTR_SET(val, member)		\
-	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK)	\
-	 << RQ_CTXT_CEQ_ATTR_##member##_SHIFT)
-
 #define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0
 #define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT		28
 #define RQ_CTXT_WQ_PAGE_OWNER_SHIFT		31
@@ -148,38 +93,6 @@
 #define RQ_CTXT_WQ_PAGE_SET(val, member)		\
 	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK)	\
 	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)
-
-#define RQ_CTXT_CQE_LEN_SHIFT			28
-
-#define RQ_CTXT_CQE_LEN_MASK			0x3U
-
-#define RQ_CTXT_CQE_LEN_SET(val, member)		\
-	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
-
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
-#define RQ_CTXT_PREF_CACHE_MAX_SHIFT		14
-#define RQ_CTXT_PREF_CACHE_MIN_SHIFT		25
-
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
-#define RQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
-#define RQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
-
-#define RQ_CTXT_PREF_CI_HI_SHIFT		0
-#define RQ_CTXT_PREF_OWNER_SHIFT		4
-
-#define RQ_CTXT_PREF_CI_HI_MASK			0xFU
-#define RQ_CTXT_PREF_OWNER_MASK			0x1U
-
-#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
-#define RQ_CTXT_PREF_CI_LOW_SHIFT		20
-
-#define RQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
-#define RQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
-
-#define RQ_CTXT_PREF_SET(val, member)			\
-	(((val) & RQ_CTXT_PREF_##member##_MASK)		\
-	 << RQ_CTXT_PREF_##member##_SHIFT)
-
 #define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0
 
 #define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU
@@ -191,12 +104,7 @@
 #define SIZE_16BYTES(size) (RTE_ALIGN((size), 16) >> 4)
 
 #define WQ_PAGE_PFN_SHIFT			12
-#define WQ_BLOCK_PFN_SHIFT			9
-
 #define WQ_PAGE_PFN(page_addr)	((page_addr) >> WQ_PAGE_PFN_SHIFT)
-#define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)
-
-#define CQE_CTX_CI_ADDR_SHIFT			4
 
 void
 hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
@@ -206,6 +114,8 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;
 	uint16_t pi_start, ci_start;
 
+	hinic3_cmdq_get_ops(sq->nic_dev)->prepare_sq_ctxt_drop_and_prefetch(sq_ctxt);
+
 	ci_start = sq->cons_idx & sq->q_mask;
 	pi_start = sq->prod_idx & sq->q_mask;
 
@@ -232,10 +142,6 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 
 	sq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
 
-	sq_ctxt->pkt_drop_thd =
-		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |
-		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);
-
 	sq_ctxt->global_sq_id =
 		SQ_CTXT_GLOBAL_QUEUE_ID_SET(sq_id, GLOBAL_SQ_ID);
 
@@ -245,11 +151,6 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 
 	sq_ctxt->rsvd0 = 0;
 
-	sq_ctxt->pref_cache =
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
-		SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
-
 	sq_ctxt->pref_ci_owner =
 		SQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
 		SQ_CTXT_PREF_SET(1, OWNER);
@@ -277,7 +178,6 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;
 	uint16_t pi_start, ci_start;
 	uint16_t wqe_type = rq->wqe_type;
-	uint8_t intr_disable;
 
 	/* RQ depth is in unit of 8 Bytes. */
 	ci_start = (uint16_t)((rq->cons_idx & rq->q_mask) << wqe_type);
@@ -298,17 +198,14 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 	rq_ctxt->ci_pi = RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
 			 RQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
 
-	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable. */
-	intr_disable = rq->dp_intr_en ? 0 : 1;
-	rq_ctxt->ceq_attr = RQ_CTXT_CEQ_ATTR_SET(intr_disable, EN) |
-			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |
-			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);
-
 	/* Use 32Byte WQE with SGE for CQE in default. */
 	rq_ctxt->wq_pfn_hi_type_owner =
 		RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
 		RQ_CTXT_WQ_PAGE_SET(1, OWNER);
 
+	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable */
+	hinic3_cmdq_get_ops(rq->nic_dev)->prepare_rq_ctxt_ceq_and_prefetch(rq, rq_ctxt);
+
 	switch (wqe_type) {
 	case HINIC3_EXTEND_RQ_WQE:
 		/* Use 32Byte WQE with SGE for CQE. */
@@ -331,11 +228,6 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 
 	rq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
 
-	rq_ctxt->pref_cache =
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
-		RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
-
 	rq_ctxt->pref_ci_owner =
 		RQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
 		RQ_CTXT_PREF_SET(1, OWNER);
@@ -346,8 +238,15 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 
 	rq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
 
-	rq_ctxt->pi_paddr_hi = upper_32_bits(rq->pi_dma_addr);
-	rq_ctxt->pi_paddr_lo = lower_32_bits(rq->pi_dma_addr);
+	/*
+	 * In compact CQE mode the STN command queue ops repurpose pi_paddr as
+	 * the aggregated CQE CI write-back address, so do not overwrite it here.
+	 */
+	if (rq->wqe_type != HINIC3_COMPACT_RQ_WQE ||
+	    !rq->nic_dev->config.rx_cqe_compact_en) {
+		rq_ctxt->pi_paddr_hi = upper_32_bits(rq->pi_dma_addr);
+		rq_ctxt->pi_paddr_lo = lower_32_bits(rq->pi_dma_addr);
+	}
 
 	rq_ctxt->wq_block_pfn_hi =
 		RQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
@@ -392,7 +291,7 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
 				    ? HINIC3_Q_CTXT_MAX
 				    : (nic_dev->num_sqs - q_id);
 		cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_store(nic_dev,
-			cmd_buf, HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);
+				cmd_buf, HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
 					      cmd, cmd_buf, &out_param, 0);
@@ -444,7 +343,8 @@ init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
 				    ? HINIC3_Q_CTXT_MAX
 				    : (nic_dev->num_rqs - q_id);
 		cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_store(nic_dev,
-			cmd_buf, HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);
+				cmd_buf, HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);
+
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
 					      cmd, cmd_buf, &out_param, 0);
@@ -490,10 +390,8 @@ clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
 		PMD_DRV_LOG(ERR, "Allocate cmd buf for LRO/TSO space failed");
 		return -ENOMEM;
 	}
-
-	cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_clean_tso_lro_space(nic_dev,
-		cmd_buf, ctxt_type);
-
+	cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_clean_tso_lro_space(nic_dev, cmd_buf,
+										ctxt_type);
 	/* Send a command to hardware to clean up queue offload context. */
 	err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
 				      cmd, cmd_buf, &out_param, 0);
@@ -563,7 +461,7 @@ hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
 	while (q_id < nic_dev->num_rqs) {
 		rxq = nic_dev->rxqs[q_id];
 		if (rxq->wqe_type == HINIC3_COMPACT_RQ_WQE) {
-			rq_ci_paddr = rxq->rq_ci_paddr >> CQE_CTX_CI_ADDR_SHIFT;
+			rq_ci_paddr = rxq->rq_ci_paddr >> RQ_CI_ADDR_SHIFT;
 			cqe_ctx.ci_addr_hi = upper_32_bits(rq_ci_paddr);
 			cqe_ctx.ci_addr_lo = lower_32_bits(rq_ci_paddr);
 			cqe_ctx.threshold_cqe_num = nic_dev->config.rx_cqe_coalesce_num;
@@ -641,8 +539,8 @@ hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
 	/* Configure CI tables for each SQ. */
 	for (q_id = 0; q_id < nic_dev->num_sqs; q_id++) {
 		sq_attr.ci_dma_base = nic_dev->txqs[q_id]->ci_dma_base >> 0x2;
-		sq_attr.pending_limit = HINIC3_DEAULT_TX_CI_PENDING_LIMIT;
-		sq_attr.coalescing_time = HINIC3_DEAULT_TX_CI_COALESCING_TIME;
+		sq_attr.pending_limit = nic_dev->config.tx_pending_limit;
+		sq_attr.coalescing_time = nic_dev->config.tx_coalescing_time;
 		sq_attr.intr_en = 0;
 		sq_attr.intr_idx = 0; /**< Tx doesn't need interrupt. */
 		sq_attr.l2nic_sqn = q_id;
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3_nic_io.h
index d7ec81f2e6..acad0ab3df 100644
--- a/drivers/net/hinic3/hinic3_nic_io.h
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -28,6 +28,82 @@
 
 #define HINIC3_Q_CTXT_MAX ((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))
 
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT		0
+#define RQ_CTXT_PREF_CACHE_MAX_SHIFT			14
+#define RQ_CTXT_PREF_CACHE_MIN_SHIFT			25
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK		0x3FFFU
+#define RQ_CTXT_PREF_CACHE_MAX_MASK			0x7FFU
+#define RQ_CTXT_PREF_CACHE_MIN_MASK			0x7FU
+
+#define RQ_CTXT_PREF_CI_HI_SHIFT			0
+#define RQ_CTXT_PREF_OWNER_SHIFT			4
+
+#define RQ_CTXT_PREF_CI_HI_MASK				0xFU
+#define RQ_CTXT_PREF_OWNER_MASK				0x1U
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT			0
+#define RQ_CTXT_PREF_CI_LOW_SHIFT			20
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK			0xFFFFFU
+#define RQ_CTXT_PREF_CI_LOW_MASK			0xFFFU
+
+#define RQ_CTXT_PREF_SET(val, member)			(((val) & \
+					RQ_CTXT_PREF_##member##_MASK) << \
+					RQ_CTXT_PREF_##member##_SHIFT)
+
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)		(((val) & \
+					RQ_CTXT_CEQ_ATTR_##member##_MASK) \
+					<< RQ_CTXT_CEQ_ATTR_##member##_SHIFT)
+
+#define RQ_CTXT_CQE_LEN_SHIFT				28
+#define RQ_CTXT_MAX_COUNT_SHIFT				18
+
+#define RQ_CTXT_CQE_LEN_MASK				0x3U
+#define RQ_CTXT_MAX_COUNT_MASK				0x3FFU
+#define RQ_CTXT_CQE_LEN_SET(val, member)		(((val) & \
+					RQ_CTXT_##member##_MASK) << \
+					RQ_CTXT_##member##_SHIFT)
+
+#define SQ_CI_ADDR_SHIFT	2
+#define RQ_CI_ADDR_SHIFT	4
+#define RQ_CQE_AGGREGATE_NUM		768
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT		0
+#define SQ_CTXT_PREF_CACHE_MAX_SHIFT			14
+#define SQ_CTXT_PREF_CACHE_MIN_SHIFT			25
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK		0x3FFFU
+#define SQ_CTXT_PREF_CACHE_MAX_MASK			0x7FFU
+#define SQ_CTXT_PREF_CACHE_MIN_MASK			0x7FU
+
+#define SQ_CTXT_PREF_CI_HI_SHIFT			0
+#define SQ_CTXT_PREF_OWNER_SHIFT			4
+
+#define SQ_CTXT_PREF_CI_HI_MASK				0xFU
+#define SQ_CTXT_PREF_OWNER_MASK				0x1U
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT			0
+#define SQ_CTXT_PREF_CI_LOW_SHIFT			20
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK			0xFFFFFU
+#define SQ_CTXT_PREF_CI_LOW_MASK			0xFFFU
+
+#define SQ_CTXT_PREF_SET(val, member)			(((val) & \
+					SQ_CTXT_PREF_##member##_MASK) \
+					<< SQ_CTXT_PREF_##member##_SHIFT)
+
+#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0
+#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16
+
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU
+
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)	(((val) & \
+			SQ_CTXT_PKT_DROP_##member##_MASK) \
+			<< SQ_CTXT_PKT_DROP_##member##_SHIFT)
+
 enum hinic3_rq_wqe_type {
 	HINIC3_COMPACT_RQ_WQE,
 	HINIC3_NORMAL_RQ_WQE,
@@ -45,51 +121,6 @@ enum hinic3_qp_ctxt_type {
 	HINIC3_QP_CTXT_TYPE_RQ,
 };
 
-/* Prepare cmd to clean tso/lro space */
-typedef uint8_t  (*prepare_cmd_buf_clean_tso_lro_space_t)(struct hinic3_nic_dev *nic_dev,
-							  struct hinic3_cmd_buf *cmd_buf,
-							  enum hinic3_qp_ctxt_type ctxt_type);
-/* Prepare cmd to store RQ and TQ ctxt */
-typedef uint8_t  (*prepare_cmd_buf_qp_context_multi_store_t)(struct hinic3_nic_dev *nic_dev,
-							     struct hinic3_cmd_buf *cmd_buf,
-							     enum hinic3_qp_ctxt_type ctxt_type,
-							     uint16_t start_qid,
-							     uint16_t max_ctxts);
-/* Prepare cmd to modify vlan tag */
-typedef uint8_t  (*prepare_cmd_buf_modify_svlan_t)(struct hinic3_cmd_buf *cmd_buf, uint16_t func_id,
-						   uint16_t vlan_tag, uint16_t q_id,
-						   uint8_t vlan_mode);
-/* Prepare cmd to set RSS indir table */
-typedef uint8_t  (*prepare_cmd_buf_set_rss_indir_table_t)(struct hinic3_nic_dev *nic_dev,
-							  const uint32_t *indir_table,
-							  struct hinic3_cmd_buf *cmd_buf);
-/* Prepare cmd to get RSS indir table */
-typedef uint8_t  (*prepare_cmd_buf_get_rss_indir_table_t)(struct hinic3_nic_dev *nic_dev,
-							  struct hinic3_cmd_buf *cmd_buf);
-/* Configure RSS indir table */
-typedef void     (*cmd_buf_to_rss_indir_table_t)(const struct hinic3_cmd_buf *cmd_buf,
-						 uint32_t *indir_table);
-
-struct hinic3_nic_cmdq_ops {
-	prepare_cmd_buf_clean_tso_lro_space_t		prepare_cmd_buf_clean_tso_lro_space;
-	prepare_cmd_buf_qp_context_multi_store_t	prepare_cmd_buf_qp_context_multi_store;
-	prepare_cmd_buf_modify_svlan_t			prepare_cmd_buf_modify_svlan;
-	prepare_cmd_buf_set_rss_indir_table_t		prepare_cmd_buf_set_rss_indir_table;
-	prepare_cmd_buf_get_rss_indir_table_t		prepare_cmd_buf_get_rss_indir_table;
-	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;
-};
-
-/**
- * Get cmdq ops for the given NIC device.
- *
- * @param[in] nic_dev
- * Pointer to NIC device structure.
- *
- * @return
- * Pointer to cmdq ops structure.
- */
-const struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev);
-
 /* Doorbell info. */
 struct hinic3_db {
 	uint32_t db_info;
@@ -164,6 +195,41 @@ struct hinic3_rq_enable {
 	uint8_t rsvd[3];
 };
 
+typedef uint8_t (*prepare_cmd_buf_clean_tso_lro_space_t)(struct hinic3_nic_dev *nic_dev,
+							 struct hinic3_cmd_buf *cmd_buf,
+							 enum hinic3_qp_ctxt_type ctxt_type);
+typedef uint8_t (*prepare_cmd_buf_qp_context_multi_store_t)(struct hinic3_nic_dev *nic_dev,
+							   struct hinic3_cmd_buf *cmd_buf,
+							   enum hinic3_qp_ctxt_type ctxt_type,
+							   uint16_t start_qid,
+							   uint16_t max_ctxts);
+typedef uint8_t  (*prepare_cmd_buf_modify_svlan_t)(struct hinic3_cmd_buf *cmd_buf, uint16_t func_id,
+						   uint16_t vlan_tag, uint16_t q_id,
+						   uint8_t vlan_mode);
+typedef uint8_t (*prepare_cmd_buf_set_rss_indir_table_t)(struct hinic3_nic_dev *nic_dev,
+							 const uint32_t *indir_table,
+							 struct hinic3_cmd_buf *cmd_buf);
+typedef uint8_t (*prepare_cmd_buf_get_rss_indir_table_t)(struct hinic3_nic_dev *nic_dev,
+							 struct hinic3_cmd_buf *cmd_buf);
+typedef void (*cmd_buf_to_rss_indir_table_t)(const struct hinic3_cmd_buf *cmd_buf,
+					     uint32_t *indir_table);
+typedef void (*prepare_sq_ctxt_drop_and_prefetch_t)(struct hinic3_sq_ctxt *sq_ctxt);
+typedef void (*prepare_rq_ctxt_ceq_and_prefetch_t)(struct hinic3_rxq *rq,
+						   struct hinic3_rq_ctxt *rq_ctxt);
+
+struct hinic3_nic_cmdq_ops {
+	prepare_cmd_buf_clean_tso_lro_space_t		prepare_cmd_buf_clean_tso_lro_space;
+	prepare_cmd_buf_qp_context_multi_store_t	prepare_cmd_buf_qp_context_multi_store;
+	prepare_cmd_buf_modify_svlan_t			prepare_cmd_buf_modify_svlan;
+	prepare_cmd_buf_set_rss_indir_table_t		prepare_cmd_buf_set_rss_indir_table;
+	prepare_cmd_buf_get_rss_indir_table_t		prepare_cmd_buf_get_rss_indir_table;
+	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;
+	prepare_sq_ctxt_drop_and_prefetch_t		prepare_sq_ctxt_drop_and_prefetch;
+	prepare_rq_ctxt_ceq_and_prefetch_t		prepare_rq_ctxt_ceq_and_prefetch;
+};
+
+const struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev);
+
 #define DB_INFO_QID_SHIFT	 0
 #define DB_INFO_NON_FILTER_SHIFT 22
 #define DB_INFO_CFLAG_SHIFT	 23
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
index 607fe2d0fe..1eb5ea19b4 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
@@ -7,6 +7,28 @@
 #include "hinic3_cmd.h"
 #include "hinic3_hwif.h"
 #include "hinic3_htn_cmdq.h"
+#include "hinic3_rx.h"
+
+#define HINIC3_DEAULT_DROP_THD_OFF	0xFFFF
+#define HINIC3_DEAULT_DROP_THD_ON	0xFFFF
+
+#define SQ_PREFETCH_MAX			5
+#define SQ_PREFETCH_MIN			4
+#define SQ_PREFETCH_THRESHOLD		48
+
+#define RQ_PREFETCH_MAX			4
+#define RQ_PREFETCH_MIN			2
+#define RQ_PREFETCH_THRESHOLD		32
+
+#define RQ_PFH_TH			7
+
+#define RQ_CTXT_CEQ_ATTR_PFH_TH_SHIFT			0
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT			21
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT			31
+
+#define RQ_CTXT_CEQ_ATTR_PFH_TH_MASK			0x1FU
+#define RQ_CTXT_CEQ_ATTR_EN_MASK			0x1U
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK			0x3FFU
 
 #define HTN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_ctxt_header) \
 						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
@@ -100,7 +122,7 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf,
 static void prepare_rss_indir_table_cmd_header(struct hinic3_nic_dev *nic_dev,
 					       struct hinic3_cmd_buf *cmd_buf)
 {
-	struct hinic3_rss_cmd_header *header = cmd_buf->buf;
+	struct hinic3_htn_rss_cmd_header *header = cmd_buf->buf;
 
 	header->dest_func_id = hinic3_global_func_id(nic_dev->hwdev);
 
@@ -115,8 +137,8 @@ static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_de
 	uint32_t i;
 	uint8_t *indir_tbl = NULL;
 
-	indir_tbl = (uint8_t *)cmd_buf->buf + sizeof(struct hinic3_rss_cmd_header);
-	cmd_buf->size = sizeof(struct hinic3_rss_cmd_header) + HINIC3_RSS_INDIR_SIZE;
+	indir_tbl = (uint8_t *)cmd_buf->buf + sizeof(struct hinic3_htn_rss_cmd_header);
+	cmd_buf->size = sizeof(struct hinic3_htn_rss_cmd_header) + HINIC3_RSS_INDIR_SIZE;
 	memset(indir_tbl, 0, HINIC3_RSS_INDIR_SIZE);
 
 	prepare_rss_indir_table_cmd_header(nic_dev, cmd_buf);
@@ -152,6 +174,30 @@ static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uin
 		indir_table[i] = *(indir_tbl + i);
 }
 
+static void
+prepare_sq_ctxt_drop_and_prefetch(struct hinic3_sq_ctxt *sq_ctxt)
+{
+	sq_ctxt->pkt_drop_thd = SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |
+				SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);
+
+	sq_ctxt->pref_cache = SQ_CTXT_PREF_SET(SQ_PREFETCH_MIN, CACHE_MIN) |
+			      SQ_CTXT_PREF_SET(SQ_PREFETCH_MAX, CACHE_MAX) |
+			      SQ_CTXT_PREF_SET(SQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
+static void
+prepare_rq_ctxt_ceq_and_prefetch(struct hinic3_rxq *rq,
+				 struct hinic3_rq_ctxt *rq_ctxt)
+{
+	rq_ctxt->ceq_attr = RQ_CTXT_CEQ_ATTR_SET(rq->dp_intr_en ? 0 : 1, EN) |
+			    RQ_CTXT_CEQ_ATTR_SET(RQ_PFH_TH, PFH_TH) |
+			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);
+
+	rq_ctxt->pref_cache = RQ_CTXT_PREF_SET(RQ_PREFETCH_MIN, CACHE_MIN) |
+			      RQ_CTXT_PREF_SET(RQ_PREFETCH_MAX, CACHE_MAX) |
+			      RQ_CTXT_PREF_SET(RQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
 const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops = {
 	.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
 	.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
@@ -159,4 +205,6 @@ const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops = {
 	.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
 	.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
 	.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+	.prepare_sq_ctxt_drop_and_prefetch =      prepare_sq_ctxt_drop_and_prefetch,
+	.prepare_rq_ctxt_ceq_and_prefetch =       prepare_rq_ctxt_ceq_and_prefetch,
 };
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
index 158cbc5f8e..f87ea535ad 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
@@ -27,7 +27,7 @@ struct hinic3_htn_qp_ctxt_block {
 	};
 };
 
-struct hinic3_rss_cmd_header {
+struct hinic3_htn_rss_cmd_header {
 	uint32_t rsv[3];
 	uint16_t rsv1;
 	uint16_t dest_func_id;
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
index 23adbc79f4..c05e4bc11c 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
@@ -7,6 +7,25 @@
 #include "hinic3_cmd.h"
 #include "hinic3_hwif.h"
 #include "hinic3_stn_cmdq.h"
+#include "hinic3_rx.h"
+
+#define HINIC3_DEAULT_DROP_THD_ON			0xFFFF
+#define HINIC3_DEAULT_DROP_THD_OFF			0
+#define WQ_PREFETCH_MAX					6
+#define WQ_PREFETCH_MIN					1
+#define WQ_PREFETCH_THRESHOLD				256
+
+#define RQ_CTXT_CEQ_ATTR_CI_WR_SHIFT			0
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT			21
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT			30
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT			31
+
+#define RQ_CTXT_CEQ_ATTR_CI_WR_MASK			0x1U
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK			0x3FFU
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK			0x1U
+#define RQ_CTXT_CEQ_ATTR_EN_MASK			0x1U
+/* Indicate ucode that this is an interrupt in the DPDK scenario. */
+#define RQ_CTXT_INVALID_INTR_NUM			0x1FFU
 
 #define STN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_ctxt_header) \
 						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
@@ -136,6 +155,41 @@ static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uin
 		indir_table[i] = *(indir_tbl + i);
 }
 
+static void
+prepare_sq_ctxt_drop_and_prefetch(struct hinic3_sq_ctxt *sq_ctxt)
+{
+	sq_ctxt->pkt_drop_thd = SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |
+				SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);
+
+	sq_ctxt->pref_cache = SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
+			      SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
+			      SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
+static void
+prepare_rq_ctxt_ceq_and_prefetch(struct hinic3_rxq *rq,
+				 struct hinic3_rq_ctxt *rq_ctxt)
+{
+	uint16_t msix_entry_idx = rq->dp_intr_en ? rq->msix_entry_idx : RQ_CTXT_INVALID_INTR_NUM;
+
+	rq_ctxt->ceq_attr = RQ_CTXT_CEQ_ATTR_SET(rq->dp_intr_en ? 0 : 1, EN) |
+			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |
+			    RQ_CTXT_CEQ_ATTR_SET(msix_entry_idx, INTR);
+
+	if (rq->wqe_type == HINIC3_COMPACT_RQ_WQE && rq->nic_dev->config.rx_cqe_compact_en) {
+		rq_ctxt->ceq_attr |= RQ_CTXT_CEQ_ATTR_SET(1, EN);
+		rq_ctxt->ceq_attr |= RQ_CTXT_CEQ_ATTR_SET(1, CI_WR);
+		rq_ctxt->ceq_attr |= RQ_CTXT_CEQ_ATTR_SET(1, INTR_ARM);
+		rq_ctxt->cqe_sge_len |= RQ_CTXT_CQE_LEN_SET(RQ_CQE_AGGREGATE_NUM, MAX_COUNT);
+		rq_ctxt->pi_paddr_hi = upper_32_bits(rq->rq_ci_paddr >> RQ_CI_ADDR_SHIFT);
+		rq_ctxt->pi_paddr_lo = lower_32_bits(rq->rq_ci_paddr >> RQ_CI_ADDR_SHIFT);
+	}
+
+	rq_ctxt->pref_cache = RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
+			      RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
+			      RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+}
+
 const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops = {
 	.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
 	.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
@@ -143,4 +197,6 @@ const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops = {
 	.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
 	.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
 	.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+	.prepare_sq_ctxt_drop_and_prefetch =      prepare_sq_ctxt_drop_and_prefetch,
+	.prepare_rq_ctxt_ceq_and_prefetch =       prepare_rq_ctxt_ceq_and_prefetch,
 };
-- 
2.33.0


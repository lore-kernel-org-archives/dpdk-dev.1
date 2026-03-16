Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B3F506D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CAB94066E;
	Mon, 16 Mar 2026 14:44:10 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 8C2ED4065E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 14:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=vGHI1AYM1IPyD2QlFVuzekA4DGWs5LZRiETUCNsgnb0=;
 b=kN9bxpOx3E/di5q0nQrRo8w24MjVdt7XNyZCC10yqzfgbnL3/NVMPmdGORBDO1
 so+EKDBdz0tjvAet+llaJXm8O9F8oiLfTQlLCuDAxsLPMH9rp8HS4w2BHcIjjAwk
 AMDxWHpwFxijlHdXF6RcBjJqm88gBdN2vbLWQ2hSZR8AA=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgAXOR4WCbhpaIrGAg--.46641S10;
 Mon, 16 Mar 2026 21:44:03 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V2 6/7] net/hinic3: add tx ops to support Compact CQE
Date: Mon, 16 Mar 2026 21:43:28 +0800
Message-ID: <20260316134335.1640-7-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260316134335.1640-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260316134335.1640-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgAXOR4WCbhpaIrGAg--.46641S10
X-Coremail-Antispam: 1Uf129KBjvAXoWfAw4fKw4UJry7WrWxZF1kXwb_yoW5ZFyxZo
 WSqr15trn2vryxCFWj9w4DuF4Dtrs0yF45Jw4jyrWxZa17Xr1UG3y3Aw1Sga48W34qk3W7
 A3Z3KwnFkrsrJ39xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrJ5rDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwTT3Wm4CSSNGAAA3Q
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

From: Feifei Wang <wangfeifei40@huawei.com>

In pkt send path, use different func callback to configure
compact wqe and normal wqe offload.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/hinic3_tx.c | 454 +++++++++++++++++----------------
 drivers/net/hinic3/hinic3_tx.h | 146 +++++++++--
 2 files changed, 361 insertions(+), 239 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index c896fcc76b..fca94dd08e 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -21,6 +21,7 @@
 
 #define HINIC3_TX_OUTER_CHECKSUM_FLAG_SET    1
 #define HINIC3_TX_OUTER_CHECKSUM_FLAG_NO_SET 0
+#define MAX_TSO_NUM_FRAG 1024
 
 #define HINIC3_TX_OFFLOAD_MASK \
 	(HINIC3_TX_CKSUM_OFFLOAD_MASK | HINIC3_PKT_TX_VLAN_PKT)
@@ -28,7 +29,8 @@
 #define HINIC3_TX_CKSUM_OFFLOAD_MASK                          \
 	(HINIC3_PKT_TX_IP_CKSUM | HINIC3_PKT_TX_TCP_CKSUM |   \
 	 HINIC3_PKT_TX_UDP_CKSUM | HINIC3_PKT_TX_SCTP_CKSUM | \
-	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_TCP_SEG)
+	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_OUTER_UDP_CKSUM | \
+	 HINIC3_PKT_TX_TCP_SEG)
 
 static inline uint16_t
 hinic3_get_sq_free_wqebbs(struct hinic3_txq *sq)
@@ -56,26 +58,23 @@ hinic3_get_sq_hw_ci(struct hinic3_txq *sq)
 }
 
 static void *
-hinic3_get_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)
+hinic3_sq_get_wqebbs(struct hinic3_txq *sq, uint16_t num_wqebbs, uint16_t *prod_idx)
 {
-	uint16_t cur_pi = MASKED_QUEUE_IDX(sq, sq->prod_idx);
-	uint32_t end_pi;
+	*prod_idx = MASKED_QUEUE_IDX(sq, sq->prod_idx);
+	sq->prod_idx += num_wqebbs;
 
-	end_pi = cur_pi + wqe_info->wqebb_cnt;
-	sq->prod_idx += wqe_info->wqebb_cnt;
+	return NIC_WQE_ADDR(sq, *prod_idx);
+}
 
-	wqe_info->owner = (uint8_t)(sq->owner);
-	wqe_info->pi = cur_pi;
-	wqe_info->wrapped = 0;
+static inline uint16_t
+hinic3_get_and_update_sq_owner(struct hinic3_txq *sq, uint16_t curr_pi, uint16_t wqebb_cnt)
+{
+	uint16_t owner = sq->owner;
 
-	if (unlikely(end_pi >= sq->q_depth)) {
+	if (unlikely(curr_pi + wqebb_cnt >= sq->q_depth))
 		sq->owner = !sq->owner;
 
-		if (likely(end_pi > sq->q_depth))
-			wqe_info->wrapped = (uint8_t)(sq->q_depth - cur_pi);
-	}
-
-	return NIC_WQE_ADDR(sq, cur_pi);
+	return owner;
 }
 
 static inline void
@@ -90,61 +89,39 @@ hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)
 /**
  * Sets the WQE combination information in the transmit queue (SQ).
  *
- * @param[in] txq
+ * @param[in] sq
  * Point to send queue.
  * @param[out] wqe_combo
  * Point to wqe_combo of send queue(SQ).
- * @param[in] wqe
- * Point to wqe of send queue(SQ).
  * @param[in] wqe_info
  * Point to wqe_info of send queue(SQ).
  */
 static void
-hinic3_set_wqe_combo(struct hinic3_txq *txq,
+hinic3_set_wqe_combo(struct hinic3_txq *sq,
 		     struct hinic3_sq_wqe_combo *wqe_combo,
-		     struct hinic3_sq_wqe *wqe,
 		     struct hinic3_wqe_info *wqe_info)
 {
-	wqe_combo->hdr = &wqe->compact_wqe.wqe_desc;
-
-	if (wqe_info->offload) {
-		if (wqe_info->wrapped == HINIC3_TX_TASK_WRAPPED) {
-			wqe_combo->task = (struct hinic3_sq_task *)
-				(void *)txq->sq_head_addr;
-			wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
-				(void *)(txq->sq_head_addr + txq->wqebb_size);
-		} else if (wqe_info->wrapped == HINIC3_TX_BD_DESC_WRAPPED) {
-			wqe_combo->task = &wqe->extend_wqe.task;
-			wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
-				(void *)(txq->sq_head_addr);
-		} else {
-			wqe_combo->task = &wqe->extend_wqe.task;
-			wqe_combo->bds_head = wqe->extend_wqe.buf_desc;
-		}
+	uint16_t tmp_pi;
 
-		wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
-		wqe_combo->task_type = SQ_WQE_TASKSECT_16BYTES;
+	wqe_combo->hdr = hinic3_sq_get_wqebbs(sq, 1, &wqe_info->pi);
 
+	if (wqe_info->wqebb_cnt == 1) {
+		/* compact wqe */
+		wqe_combo->wqe_type = SQ_WQE_COMPACT_TYPE;
+		wqe_combo->task_type = SQ_WQE_TASKSECT_4BYTES;
+		wqe_combo->task = (struct hinic3_sq_task *)&wqe_combo->hdr->queue_info;
+		wqe_info->owner = hinic3_get_and_update_sq_owner(sq, wqe_info->pi, 1);
 		return;
 	}
 
-	if (wqe_info->wrapped == HINIC3_TX_TASK_WRAPPED) {
-		wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
-			(void *)(txq->sq_head_addr);
-	} else {
-		wqe_combo->bds_head =
-			(struct hinic3_sq_bufdesc *)(&wqe->extend_wqe.task);
-	}
+	/* extend normal wqe */
+	wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
+	wqe_combo->task_type = SQ_WQE_TASKSECT_16BYTES;
+	wqe_combo->task = hinic3_sq_get_wqebbs(sq, 1, &tmp_pi);
+	if (wqe_info->sge_cnt > 1)
+		wqe_combo->bds_head = hinic3_sq_get_wqebbs(sq, wqe_info->sge_cnt - 1, &tmp_pi);
 
-	if (wqe_info->wqebb_cnt > 1) {
-		wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
-		wqe_combo->task_type = SQ_WQE_TASKSECT_46BITS;
-
-		/* This section used as vlan insert, needs to clear. */
-		wqe_combo->bds_head->rsvd = 0;
-	} else {
-		wqe_combo->wqe_type = SQ_WQE_COMPACT_TYPE;
-	}
+	wqe_info->owner = hinic3_get_and_update_sq_owner(sq, wqe_info->pi, wqe_info->wqebb_cnt);
 }
 
 int
@@ -311,6 +288,8 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
 /**
  * Prepare the data packet to be sent and calculate the internal L3 offset.
  *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
  * @param[in] mbuf
  * Point to the mbuf to be processed.
  * @param[out] inner_l3_offset
@@ -319,14 +298,20 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
  * 0 as success, -EINVAL as failure.
  */
 static int
-hinic3_tx_offload_pkt_prepare(struct rte_mbuf *mbuf, uint16_t *inner_l3_offset)
+hinic3_tx_offload_pkt_prepare(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
+			      uint16_t *inner_l3_offset)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 
-	/* Only support vxlan offload. */
-	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) &&
-	    (!(ol_flags & HINIC3_PKT_TX_TUNNEL_VXLAN)))
-		return -EINVAL;
+	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {
+		if (!(((ol_flags & HINIC3_PKT_TX_TUNNEL_VXLAN) &&
+				HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev)) ||
+		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_GENEVE) &&
+				HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) ||
+		      ((ol_flags & HINIC3_PKT_TX_TUNNEL_IPIP) &&
+				HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))))
+			return -EINVAL;
+	}
 
 #ifdef RTE_LIBRTE_ETHDEV_DEBUG
 	if (rte_validate_tx_offload(mbuf) != 0)
@@ -358,107 +343,121 @@ hinic3_tx_offload_pkt_prepare(struct rte_mbuf *mbuf, uint16_t *inner_l3_offset)
 	return 0;
 }
 
-static inline void
-hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task, uint16_t vlan_tag,
-			   uint8_t vlan_type)
+void
+hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,
+				  struct hinic3_sq_wqe_combo *wqe_combo)
+{
+	struct hinic3_sq_task *task = wqe_combo->task;
+	struct hinic3_offload_info *offload_info = &wqe_info->offload_info;
+
+	task->pkt_info0 = 0;
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->inner_l4_en, INNER_L4_EN);
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->inner_l3_en, INNER_L3_EN);
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->encapsulation, TUNNEL_FLAG);
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->out_l3_en, OUT_L3_EN);
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(offload_info->out_l4_en, OUT_L4_EN);
+	task->pkt_info0 = hinic3_hw_be32(task->pkt_info0);
+
+	if (wqe_combo->task_type == SQ_WQE_TASKSECT_16BYTES) {
+		task->ip_identify = 0;
+		task->pkt_info2 = 0;
+		task->vlan_offload = 0;
+		task->vlan_offload = SQ_TASK_INFO3_SET(offload_info->vlan_tag, VLAN_TAG) |
+				     SQ_TASK_INFO3_SET(offload_info->vlan_sel, VLAN_TYPE) |
+				     SQ_TASK_INFO3_SET(offload_info->vlan_valid, VLAN_TAG_VALID);
+		task->vlan_offload = hinic3_hw_be32(task->vlan_offload);
+	}
+}
+
+void
+hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,
+				   struct hinic3_sq_wqe_combo *wqe_combo)
 {
-	task->vlan_offload = SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
-			     SQ_TASK_INFO3_SET(vlan_type, VLAN_TYPE) |
-			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);
+	struct hinic3_sq_task *task = wqe_combo->task;
+	struct hinic3_offload_info *offload_info = &wqe_info->offload_info;
+
+	task->pkt_info0 = 0;
+	wqe_combo->task->pkt_info0 =
+			SQ_TASK_INFO_SET(offload_info->out_l3_en, OUT_L3_EN) |
+			SQ_TASK_INFO_SET(offload_info->out_l4_en, OUT_L4_EN) |
+			SQ_TASK_INFO_SET(offload_info->inner_l3_en, INNER_L3_EN) |
+			SQ_TASK_INFO_SET(offload_info->inner_l4_en, INNER_L4_EN) |
+			SQ_TASK_INFO_SET(offload_info->vlan_valid, VLAN_VALID) |
+			SQ_TASK_INFO_SET(offload_info->vlan_sel, VLAN_SEL) |
+			SQ_TASK_INFO_SET(offload_info->vlan_tag, VLAN_TAG);
+
+	task->pkt_info0 = hinic3_hw_be32(task->pkt_info0);
 }
 
-/**
- * Set the corresponding offload information based on ol_flags of the mbuf.
- *
- * @param[in] mbuf
- * Point to the mbuf for which offload needs to be set in the sending queue.
- * @param[out] task
- * Point to task of send queue(SQ).
- * @param[out] wqe_info
- * Point to wqe_info of send queue(SQ).
- * @return
- * 0 as success, -EINVAL as failure.
- */
 static int
-hinic3_set_tx_offload(struct rte_mbuf *mbuf, struct hinic3_sq_task *task,
-		      struct hinic3_wqe_info *wqe_info)
+hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
+		      struct rte_mbuf *mbuf,
+		      struct hinic3_sq_wqe_combo *wqe_combo,
+					  struct hinic3_wqe_info *wqe_info)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
-	uint16_t pld_offset = 0;
-	uint32_t queue_info = 0;
-	uint16_t vlan_tag;
-
-	task->pkt_info0 = 0;
-	task->ip_identify = 0;
-	task->pkt_info2 = 0;
-	task->vlan_offload = 0;
+	struct hinic3_offload_info *offload_info = &wqe_info->offload_info;
 
 	/* Vlan offload. */
 	if (unlikely(ol_flags & HINIC3_PKT_TX_VLAN_PKT)) {
-		vlan_tag = mbuf->vlan_tci;
-		hinic3_set_vlan_tx_offload(task, vlan_tag, HINIC3_TX_TPID0);
-		task->vlan_offload = hinic3_hw_be32(task->vlan_offload);
+		offload_info->vlan_valid = 1;
+		offload_info->vlan_tag = mbuf->vlan_tci;
+		offload_info->vlan_sel = HINIC3_TX_TPID0;
 	}
-	/* Cksum offload. */
 	if (!(ol_flags & HINIC3_TX_CKSUM_OFFLOAD_MASK))
-		return 0;
+		goto set_tx_wqe_offload;
 
 	/* Tso offload. */
 	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {
-		pld_offset = wqe_info->payload_offset;
-		if ((pld_offset >> 1) > MAX_PAYLOAD_OFFSET)
+		wqe_info->queue_info.payload_offset = wqe_info->payload_offset;
+		if ((wqe_info->payload_offset >> 1) > MAX_PAYLOAD_OFFSET)
 			return -EINVAL;
 
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
-
-		queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, TSO);
-		queue_info |= SQ_CTRL_QUEUE_INFO_SET(pld_offset >> 1, PLDOFF);
-
-		/* Set MSS value. */
-		queue_info = SQ_CTRL_QUEUE_INFO_CLEAR(queue_info, MSS);
-		queue_info |= SQ_CTRL_QUEUE_INFO_SET(mbuf->tso_segsz, MSS);
+		offload_info->inner_l3_en = 1;
+		offload_info->inner_l4_en = 1;
+		wqe_info->queue_info.tso = 1;
+		wqe_info->queue_info.mss = mbuf->tso_segsz;
 	} else {
 		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)
-			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
+			offload_info->inner_l3_en = 1;
 
 		switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {
 		case HINIC3_PKT_TX_TCP_CKSUM:
 		case HINIC3_PKT_TX_UDP_CKSUM:
 		case HINIC3_PKT_TX_SCTP_CKSUM:
-			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+			offload_info->inner_l4_en = 1;
 			break;
-
 		case HINIC3_PKT_TX_L4_NO_CKSUM:
 			break;
-
 		default:
 			PMD_DRV_LOG(INFO, "not support pkt type");
 			return -EINVAL;
 		}
 	}
 
-	/* For vxlan, also can support PKT_TX_TUNNEL_GRE, etc. */
 	switch (ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) {
 	case HINIC3_PKT_TX_TUNNEL_VXLAN:
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+	case HINIC3_PKT_TX_TUNNEL_VXLAN_GPE:
+	case HINIC3_PKT_TX_TUNNEL_GENEVE:
+		offload_info->encapsulation = 1;
+		wqe_info->queue_info.udp_dp_en = 1;
 		break;
-
 	case 0:
 		break;
 
 	default:
-		/* For non UDP/GRE tunneling, drop the tunnel packet. */
 		PMD_DRV_LOG(INFO, "not support tunnel pkt type");
 		return -EINVAL;
 	}
 
 	if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L3_EN);
+		offload_info->out_l3_en = 1;
 
-	task->pkt_info0 = hinic3_hw_be32(task->pkt_info0);
-	task->pkt_info2 = hinic3_hw_be32(task->pkt_info2);
-	wqe_info->queue_info = queue_info;
+	if (ol_flags & HINIC3_PKT_TX_OUTER_UDP_CKSUM)
+		offload_info->out_l4_en = 1;
+
+set_tx_wqe_offload:
+	nic_dev->tx_ops->tx_set_wqe_offload(wqe_info, wqe_combo);
 
 	return 0;
 }
@@ -477,7 +476,9 @@ static bool
 hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
 {
 	uint32_t total_len, limit_len, checked_len, left_len, adjust_mss;
-	uint32_t i, max_sges, left_sges, first_len;
+	uint32_t max_sges, left_sges, first_len;
+	uint32_t payload_len, frag_num;
+	uint32_t i;
 	struct rte_mbuf *mbuf_head, *mbuf_first;
 	struct rte_mbuf *mbuf_pre = mbuf;
 
@@ -485,6 +486,17 @@ hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
 	mbuf_head = mbuf;
 	mbuf_first = mbuf;
 
+	/* Calculate the number of message payload frag,
+	 * if it exceeds the hardware limit of 10 bits,
+	 * packet will be discarded.
+	 */
+	payload_len = mbuf_head->pkt_len - wqe_info->payload_offset;
+	frag_num = (payload_len + mbuf_head->tso_segsz - 1) / mbuf_head->tso_segsz;
+	if (frag_num > MAX_TSO_NUM_FRAG) {
+		PMD_DRV_LOG(WARNING, "tso frag num over hw limit, frag_num:0x%x.", frag_num);
+		return false;
+	}
+
 	/* Tso sge number validation. */
 	if (unlikely(left_sges >= HINIC3_NONTSO_PKT_MAX_SGE)) {
 		checked_len = 0;
@@ -544,9 +556,48 @@ hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
 	return true;
 }
 
+static int
+hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
+{
+	struct rte_mbuf *mbuf_pkt = mbuf;
+	uint32_t total_len = 0;
+	uint16_t i;
+
+	if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))
+		return 0;
+
+	/* Non-tso packet length must less than 64KB. */
+	if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))
+		return -EINVAL;
+
+	/*
+	 * Mbuf number of non-tso packet must less than the sge number
+	 * that nic can support. The excess part will be copied to another
+	 * mbuf.
+	 */
+	for (i = 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {
+		total_len += mbuf_pkt->data_len;
+		mbuf_pkt = mbuf_pkt->next;
+	}
+
+	/*
+	 * Max copy mbuf size is 4KB, packet will be dropped directly,
+	 * if total copy length is more than it.
+	 */
+	if ((total_len + HINIC3_COPY_MBUF_SIZE) < mbuf->pkt_len)
+		return -EINVAL;
+
+	wqe_info->sge_cnt = HINIC3_NONTSO_PKT_MAX_SGE;
+	wqe_info->cpy_mbuf_cnt = 1;
+
+	return 0;
+}
+
 /**
  * Checks and processes transport offload information for data packets.
  *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
  * @param[in] mbuf
  * Point to the mbuf to send.
  * @param[in] wqe_info
@@ -555,56 +606,29 @@ hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
  * 0 as success, -EINVAL as failure.
  */
 static int
-hinic3_get_tx_offload(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
+hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
+		      struct hinic3_wqe_info *wqe_info)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
-	uint16_t i, total_len, inner_l3_offset = 0;
+	uint16_t inner_l3_offset = 0;
 	int err;
-	struct rte_mbuf *mbuf_pkt = NULL;
 
 	wqe_info->sge_cnt = mbuf->nb_segs;
+	wqe_info->cpy_mbuf_cnt = 0;
 	/* Check if the packet set available offload flags. */
 	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {
 		wqe_info->offload = 0;
-		return 0;
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);
 	}
 
 	wqe_info->offload = 1;
-	err = hinic3_tx_offload_pkt_prepare(mbuf, &inner_l3_offset);
+	err = hinic3_tx_offload_pkt_prepare(nic_dev, mbuf, &inner_l3_offset);
 	if (err)
 		return err;
 
-	/* Non tso mbuf only check sge num. */
+	/* Non-tso mbuf only check sge num. */
 	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG))) {
-		if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))
-			/* Non tso packet len must less than 64KB. */
-			return -EINVAL;
-
-		if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))
-			/* Valid non-tso mbuf. */
-			return 0;
-
-		/*
-		 * The number of non-tso packet fragments must be less than 38,
-		 * and mbuf segs greater than 38 must be copied to other
-		 * buffers.
-		 */
-		total_len = 0;
-		mbuf_pkt = mbuf;
-		for (i = 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {
-			total_len += mbuf_pkt->data_len;
-			mbuf_pkt = mbuf_pkt->next;
-		}
-
-		/* Default support copy total 4k mbuf segs. */
-		if ((uint32_t)(total_len + (uint16_t)HINIC3_COPY_MBUF_SIZE) <
-		    mbuf->pkt_len)
-			return -EINVAL;
-
-		wqe_info->sge_cnt = HINIC3_NONTSO_PKT_MAX_SGE;
-		wqe_info->cpy_mbuf_cnt = 1;
-
-		return 0;
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);
 	}
 
 	/* Tso mbuf. */
@@ -629,6 +653,7 @@ hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs, rte_iova_t addr,
 	buf_descs->hi_addr = hinic3_hw_be32(upper_32_bits(addr));
 	buf_descs->lo_addr = hinic3_hw_be32(lower_32_bits(addr));
 	buf_descs->len = hinic3_hw_be32(len);
+	buf_descs->rsvd = 0;
 }
 
 static inline struct rte_mbuf *
@@ -701,7 +726,6 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
 {
 	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
 	struct hinic3_sq_bufdesc *buf_desc = wqe_combo->bds_head;
-
 	uint16_t nb_segs = wqe_info->sge_cnt - wqe_info->cpy_mbuf_cnt;
 	uint16_t real_segs = mbuf->nb_segs;
 	rte_iova_t dma_addr;
@@ -736,11 +760,8 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
 			 * Parts of wqe is in sq bottom while parts
 			 * of wqe is in sq head.
 			 */
-			if (unlikely(wqe_info->wrapped &&
-				     (uint64_t)buf_desc == txq->sq_bot_sge_addr))
-				buf_desc = (struct hinic3_sq_bufdesc *)
-					   (void *)txq->sq_head_addr;
-
+			if (unlikely((uint64_t)buf_desc == txq->sq_bot_sge_addr))
+				buf_desc = (struct hinic3_sq_bufdesc *)txq->sq_head_addr;
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);
 			buf_desc++;
 		}
@@ -777,10 +798,8 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
 				hinic3_hw_be32(lower_32_bits(dma_addr));
 			wqe_desc->ctrl_len = mbuf->data_len;
 		} else {
-			if (unlikely(wqe_info->wrapped &&
-				     ((uint64_t)buf_desc == txq->sq_bot_sge_addr)))
-				buf_desc = (struct hinic3_sq_bufdesc *)
-						   txq->sq_head_addr;
+			if (unlikely(((uint64_t)buf_desc == txq->sq_bot_sge_addr)))
+				buf_desc = (struct hinic3_sq_bufdesc *)txq->sq_head_addr;
 
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);
 		}
@@ -802,44 +821,44 @@ static void
 hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
 		       struct hinic3_wqe_info *wqe_info)
 {
+	struct hinic3_queue_info *queue_info = &wqe_info->queue_info;
 	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
+	uint32_t *qsf = &wqe_desc->queue_info;
 
-	if (wqe_combo->wqe_type == SQ_WQE_COMPACT_TYPE) {
-		wqe_desc->ctrl_len |=
-			SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
-			SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
-			SQ_CTRL_SET(wqe_info->owner, OWNER);
-		wqe_desc->ctrl_len = hinic3_hw_be32(wqe_desc->ctrl_len);
-
-		/* Compact wqe queue_info will transfer to ucode. */
-		wqe_desc->queue_info = 0;
-
-		return;
-	}
-
-	wqe_desc->ctrl_len |= SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |
-			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
-			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+	wqe_desc->ctrl_len |= SQ_CTRL_SET(SQ_NORMAL_WQE, DIRECT) |
 			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
 			      SQ_CTRL_SET(wqe_info->owner, OWNER);
 
-	wqe_desc->ctrl_len = hinic3_hw_be32(wqe_desc->ctrl_len);
-
-	wqe_desc->queue_info = wqe_info->queue_info;
-	wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, UC);
-
-	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {
-		wqe_desc->queue_info |=
-			SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);
-	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <
-		   TX_MSS_MIN) {
-		/* Mss should not less than 80. */
-		wqe_desc->queue_info =
-			SQ_CTRL_QUEUE_INFO_CLEAR(wqe_desc->queue_info, MSS);
-		wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);
+	if (wqe_combo->wqe_type == SQ_WQE_EXTENDED_TYPE) {
+		wqe_desc->ctrl_len |= SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |
+				      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
+				      SQ_CTRL_SET(SQ_WQE_SGL, DATA_FORMAT);
+
+		*qsf = SQ_CTRL_QUEUE_INFO_SET(1, UC) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->sctp, SCTP) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->udp_dp_en, TCPUDP_CS) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->tso, TSO) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->ufo, UFO) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->payload_offset >> 1, PLDOFF) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->mss, MSS);
+
+		if (!SQ_CTRL_QUEUE_INFO_GET(*qsf, MSS)) {
+			*qsf |= SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);
+		} else if (SQ_CTRL_QUEUE_INFO_GET(*qsf, MSS) < TX_MSS_MIN) {
+			/* MSS should not less than 80. */
+			*qsf = SQ_CTRL_QUEUE_INFO_CLEAR(*qsf, MSS);
+			*qsf |= SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);
+		}
+		*qsf = hinic3_hw_be32(*qsf);
+	} else {
+		wqe_desc->ctrl_len |= SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->sctp, SCTP) |
+				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->udp_dp_en, UDP_DP_EN) |
+				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->ufo, UFO) |
+				SQ_CTRL_COMPACT_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE);
 	}
 
-	wqe_desc->queue_info = hinic3_hw_be32(wqe_desc->queue_info);
+	wqe_desc->ctrl_len = hinic3_hw_be32(wqe_desc->ctrl_len);
 }
 
 /**
@@ -861,9 +880,7 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct hinic3_tx_info *tx_info = NULL;
 	struct rte_mbuf *mbuf_pkt = NULL;
 	struct hinic3_sq_wqe_combo wqe_combo = {0};
-	struct hinic3_sq_wqe *sq_wqe = NULL;
 	struct hinic3_wqe_info wqe_info = {0};
-
 	uint32_t offload_err, free_cnt;
 	uint64_t tx_bytes = 0;
 	uint16_t free_wqebb_cnt, nb_tx;
@@ -885,16 +902,28 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	/* Tx loop routine. */
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		mbuf_pkt = *tx_pkts++;
-		if (unlikely(hinic3_get_tx_offload(mbuf_pkt, &wqe_info))) {
+		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info))) {
 			txq->txq_stats.offload_errors++;
 			break;
 		}
 
-		if (!wqe_info.offload)
-			wqe_info.wqebb_cnt = wqe_info.sge_cnt;
-		else
-			/* Use extended sq wqe with normal TS. */
-			wqe_info.wqebb_cnt = wqe_info.sge_cnt + 1;
+		wqe_info.wqebb_cnt = wqe_info.sge_cnt;
+		if (likely(wqe_info.offload || wqe_info.wqebb_cnt > 1)) {
+			if (txq->tx_wqe_compact_task) {
+				/**
+				 * One more wqebb is needed for compact task under two situations:
+				 * 1. TSO: MSS field is needed, no available space for
+				 *    compact task in compact wqe.
+				 * 2. SGE number > 1: wqe is handlerd as extented wqe by nic.
+				 */
+				if (mbuf_pkt->ol_flags & HINIC3_PKT_TX_TCP_SEG ||
+				    wqe_info.wqebb_cnt > 1)
+					wqe_info.wqebb_cnt++;
+			} else {
+				/* Use extended sq wqe with normal TS */
+				wqe_info.wqebb_cnt++;
+			}
+		}
 
 		free_wqebb_cnt = hinic3_get_sq_free_wqebbs(txq);
 		if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {
@@ -907,28 +936,16 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			}
 		}
 
-		/* Get sq wqe address from wqe_page. */
-		sq_wqe = hinic3_get_sq_wqe(txq, &wqe_info);
-		if (unlikely(!sq_wqe)) {
-			txq->txq_stats.tx_busy++;
-			break;
-		}
-
-		/* Task or bd section maybe wrapped for one wqe. */
-		hinic3_set_wqe_combo(txq, &wqe_combo, sq_wqe, &wqe_info);
+		/* Task or bd section maybe warpped for one wqe. */
+		hinic3_set_wqe_combo(txq, &wqe_combo, &wqe_info);
 
-		wqe_info.queue_info = 0;
 		/* Fill tx packet offload into qsf and task field. */
-		if (wqe_info.offload) {
-			offload_err = hinic3_set_tx_offload(mbuf_pkt,
-							    wqe_combo.task,
-							    &wqe_info);
+		offload_err = hinic3_set_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_combo, &wqe_info);
 			if (unlikely(offload_err)) {
 				hinic3_put_sq_wqe(txq, &wqe_info);
 				txq->txq_stats.offload_errors++;
 				break;
 			}
-		}
 
 		/* Fill sq_wqe buf_desc and bd_desc. */
 		err = hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo,
@@ -944,7 +961,12 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tx_info->mbuf = mbuf_pkt;
 		tx_info->wqebb_cnt = wqe_info.wqebb_cnt;
 
-		hinic3_prepare_sq_ctrl(&wqe_combo, &wqe_info);
+		/*
+		 * For wqe compact type, no need to prepare
+		 * sq ctrl info.
+		 */
+		if (wqe_combo.wqe_type != SQ_WQE_COMPACT_TYPE)
+			hinic3_prepare_sq_ctrl(&wqe_combo, &wqe_info);
 
 		tx_bytes += mbuf_pkt->pkt_len;
 	}
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index 21958a00cc..e0ed9908ad 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -6,30 +6,40 @@
 #define _HINIC3_TX_H_
 
 #define MAX_SINGLE_SGE_SIZE		 65536
-#define HINIC3_NONTSO_PKT_MAX_SGE	 38 /**< non-tso max sge 38. */
+#define HINIC3_NONTSO_PKT_MAX_SGE	 32 /**< non-tso max sge 32. */
 #define HINIC3_NONTSO_SEG_NUM_VALID(num) ((num) <= HINIC3_NONTSO_PKT_MAX_SGE)
 
 #define HINIC3_TSO_PKT_MAX_SGE		127 /**< tso max sge 127. */
 #define HINIC3_TSO_SEG_NUM_INVALID(num) ((num) > HINIC3_TSO_PKT_MAX_SGE)
 
-/* Tx offload info. */
-struct hinic3_tx_offload_info {
-	uint8_t outer_l2_len;
-	uint8_t outer_l3_type;
-	uint16_t outer_l3_len;
-
-	uint8_t inner_l2_len;
-	uint8_t inner_l3_type;
-	uint16_t inner_l3_len;
-
-	uint8_t tunnel_length;
-	uint8_t tunnel_type;
-	uint8_t inner_l4_type;
-	uint8_t inner_l4_len;
+/* Tx wqe queue info */
+struct hinic3_queue_info {
+	uint8_t pri;
+	uint8_t uc;
+	uint8_t sctp;
+	uint8_t udp_dp_en;
+	uint8_t tso;
+	uint8_t ufo;
+	uint8_t payload_offset;
+	uint8_t pkt_type;
+	uint16_t mss;
+	uint16_t rsvd;
+};
 
-	uint16_t payload_offset;
-	uint8_t inner_l4_tcp_udp;
-	uint8_t rsvd0; /**< Reserved field. */
+/* Tx wqe offload info */
+struct hinic3_offload_info {
+	uint8_t encapsulation;
+	uint8_t esp_next_proto;
+	uint8_t inner_l4_en;
+	uint8_t inner_l3_en;
+	uint8_t out_l4_en;
+	uint8_t out_l3_en;
+	uint8_t ipsec_offload;
+	uint8_t pkt_1588;
+	uint8_t vlan_sel;
+	uint8_t vlan_valid;
+	uint16_t vlan_tag;
+	uint32_t ip_identify;
 };
 
 /* Tx wqe ctx. */
@@ -42,14 +52,15 @@ struct hinic3_wqe_info {
 	uint8_t rsvd0; /**< Reserved field 0. */
 	uint16_t payload_offset;
 
-	uint8_t wrapped;
+	uint8_t rsvd1; /**< Reserved field 1. */
 	uint8_t owner;
 	uint16_t pi;
 
 	uint16_t wqebb_cnt;
-	uint16_t rsvd1; /**< Reserved field 1. */
+	uint16_t rsvd2; /**< Reserved field 2. */
 
-	uint32_t queue_info;
+	struct hinic3_queue_info queue_info;
+	struct hinic3_offload_info offload_info;
 };
 
 /* Descriptor for the send queue of wqe. */
@@ -103,8 +114,15 @@ struct hinic3_sq_wqe_combo {
 	uint32_t task_type;
 };
 
-enum sq_wqe_data_format {
+/* Tx queue ctrl info */
+enum sq_wqe_type {
 	SQ_NORMAL_WQE = 0,
+	SQ_DIRECT_WQE = 1,
+};
+
+enum sq_wqe_data_format {
+	SQ_WQE_SGL = 0,
+	SQ_WQE_INLINE_DATA = 1,
 };
 
 /* Indicates the type of a WQE. */
@@ -117,7 +135,7 @@ enum sq_wqe_ec_type {
 
 /* Indicates the type of tasks with different lengths. */
 enum sq_wqe_tasksect_len_type {
-	SQ_WQE_TASKSECT_46BITS = 0,
+	SQ_WQE_TASKSECT_4BYTES = 0,
 	SQ_WQE_TASKSECT_16BYTES = 1,
 };
 
@@ -177,6 +195,33 @@ enum sq_wqe_tasksect_len_type {
 	((val) & (~(SQ_CTRL_QUEUE_INFO_##member##_MASK \
 		    << SQ_CTRL_QUEUE_INFO_##member##_SHIFT)))
 
+/* Compact queue info */
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PKT_TYPE_SHIFT	14
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PLDOFF_SHIFT		16
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UFO_SHIFT		24
+#define SQ_CTRL_COMPACT_QUEUE_INFO_TSO_SHIFT		25
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UDP_DP_EN_SHIFT	26
+#define SQ_CTRL_COMPACT_QUEUE_INFO_SCTP_SHIFT		27
+
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PKT_TYPE_MASK	0x3U
+#define SQ_CTRL_COMPACT_QUEUE_INFO_PLDOFF_MASK		0xFFU
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UFO_MASK		0x1U
+#define SQ_CTRL_COMPACT_QUEUE_INFO_TSO_MASK		0x1U
+#define SQ_CTRL_COMPACT_QUEUE_INFO_UDP_DP_EN_MASK	0x1U
+#define SQ_CTRL_COMPACT_QUEUE_INFO_SCTP_MASK		0x1U
+
+#define SQ_CTRL_COMPACT_QUEUE_INFO_SET(val, member) \
+	(((uint32_t)(val) & SQ_CTRL_COMPACT_QUEUE_INFO_##member##_MASK) << \
+	 SQ_CTRL_COMPACT_QUEUE_INFO_##member##_SHIFT)
+
+#define SQ_CTRL_COMPACT_QUEUE_INFO_GET(val, member) \
+	(((val) >> SQ_CTRL_COMPACT_QUEUE_INFO_##member##_SHIFT) & \
+	 SQ_CTRL_COMPACT_QUEUE_INFO_##member##_MASK)
+
+#define SQ_CTRL_COMPACT_QUEUE_INFO_CLEAR(val, member) \
+	((val) & (~(SQ_CTRL_COMPACT_QUEUE_INFO_##member##_MASK << \
+		    SQ_CTRL_COMPACT_QUEUE_INFO_##member##_SHIFT)))
+
 /* Setting and obtaining task information */
 #define SQ_TASK_INFO0_TUNNEL_FLAG_SHIFT	    19
 #define SQ_TASK_INFO0_ESP_NEXT_PROTO_SHIFT  22
@@ -229,6 +274,37 @@ enum sq_wqe_tasksect_len_type {
 	(((val) >> SQ_TASK_INFO3_##member##_SHIFT) & \
 	 SQ_TASK_INFO3_##member##_MASK)
 
+/* compact wqe task field */
+#define SQ_TASK_INFO_PKT_1588_SHIFT		31
+#define SQ_TASK_INFO_IPSEC_PROTO_SHIFT		30
+#define SQ_TASK_INFO_OUT_L3_EN_SHIFT		28
+#define SQ_TASK_INFO_OUT_L4_EN_SHIFT		27
+#define SQ_TASK_INFO_INNER_L3_EN_SHIFT		25
+#define SQ_TASK_INFO_INNER_L4_EN_SHIFT		24
+#define SQ_TASK_INFO_ESP_NEXT_PROTO_SHIFT	22
+#define SQ_TASK_INFO_VLAN_VALID_SHIFT		19
+#define SQ_TASK_INFO_VLAN_SEL_SHIFT		16
+#define SQ_TASK_INFO_VLAN_TAG_SHIFT		0
+
+#define SQ_TASK_INFO_PKT_1588_MASK		0x1U
+#define SQ_TASK_INFO_IPSEC_PROTO_MASK		0x1U
+#define SQ_TASK_INFO_OUT_L3_EN_MASK		0x1U
+#define SQ_TASK_INFO_OUT_L4_EN_MASK		0x1U
+#define SQ_TASK_INFO_INNER_L3_EN_MASK		0x1U
+#define SQ_TASK_INFO_INNER_L4_EN_MASK		0x1U
+#define SQ_TASK_INFO_ESP_NEXT_PROTO_MASK	0x3U
+#define SQ_TASK_INFO_VLAN_VALID_MASK		0x1U
+#define SQ_TASK_INFO_VLAN_SEL_MASK		0x7U
+#define SQ_TASK_INFO_VLAN_TAG_MASK		0xFFFFU
+
+#define SQ_TASK_INFO_SET(val, member) \
+	(((uint32_t)(val) & SQ_TASK_INFO_##member##_MASK) << \
+	SQ_TASK_INFO_##member##_SHIFT)
+
+#define SQ_TASK_INFO_GET(val, member) \
+	(((val) >> SQ_TASK_INFO_##member##_SHIFT) & \
+	SQ_TASK_INFO_##member##_MASK)
+
 /* Defines the TX queue status. */
 enum hinic3_txq_status {
 	HINIC3_TXQ_STATUS_START = 0,
@@ -298,6 +374,8 @@ struct __rte_cache_aligned hinic3_txq {
 	uint64_t sq_head_addr;
 	uint64_t sq_bot_sge_addr;
 	uint32_t cos;
+	uint8_t tx_wqe_compact_task;
+	uint8_t rsvd[3];
 	struct hinic3_txq_stats txq_stats;
 #ifdef HINIC3_XSTAT_PROF_TX
 	uint64_t prof_tx_end_tsc;
@@ -319,4 +397,26 @@ uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
+
+/**
+ * Set wqe task section
+ *
+ * @param[in] wqe_info
+ * Packet info parsed according to mbuf
+ * @param[in] wqe_combo
+ * Wqe need to format
+ */
+void hinic3_tx_set_normal_task_offload(struct hinic3_wqe_info *wqe_info,
+				       struct hinic3_sq_wqe_combo *wqe_combo);
+
+/**
+ * Set compact wqe task section
+ *
+ * @param[in] wqe_info
+ * Packet info parsed according to mbuf
+ * @param[in] wqe_combo
+ * Wqe need to format
+ */
+void hinic3_tx_set_compact_task_offload(struct hinic3_wqe_info *wqe_info,
+					struct hinic3_sq_wqe_combo *wqe_combo);
 #endif /**< _HINIC3_TX_H_ */
-- 
2.45.1.windows.1


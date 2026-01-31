Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56DD79767
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 10:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3BE340612;
	Sat, 31 Jan 2026 11:06:50 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id A213F402D3
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:06:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=s0vtshW74/N8oVLhBn7/oy4vUz5p6PuwJoM1JWR0v/o=;
 b=kvuhqoM/VgFqZEzWk1T2OOOfUzfhn1m6mwgL5SV4AKHEpAJUVJseAxvZ/s0RPd
 RIQVeV5zQmbNFw4eNbWD0FJC6hlSUjWDml8rE49t8Pjr7jGYjm0zrRvajaHw5RJ1
 HZnAKh8IQz/UBgzLrIylv9qoVW4zTgxVZSc9dq3ZwNsfE=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAndJof1H1pOVL+BQ--.9138S9;
 Sat, 31 Jan 2026 18:06:45 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH 5/7] net/hinic3: add rx ops to support Compact CQE
Date: Sat, 31 Jan 2026 18:06:01 +0800
Message-ID: <20260131100608.12429-6-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260131100608.12429-1-wff_light@vip.163.com>
References: <20260131100608.12429-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAndJof1H1pOVL+BQ--.9138S9
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cw13Ar1fGr4kZr45Xw4DXFb_yoW8ZrWxXo
 WfXr15trn5tr1SkrWqgFs7uFyqvryqyw4rJ3yqk3WxZFyxWFy5tF93Jr1Fqa40q345CF17
 AasxK3Zrtr1xJa43n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUr-eoUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxX7Bml91DVbMwAA3G
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

In pkt receive path, use different func callback to seperate normal CQE
process and Compact CQE process.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/hinic3_rx.c | 232 ++++++++++++++++++++++++++-------
 drivers/net/hinic3/hinic3_rx.h | 147 +++++++++++++++++++++
 2 files changed, 329 insertions(+), 50 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index 3d5f4e4524..02c078de3d 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -219,11 +219,11 @@ hinic3_free_rxq_mbufs(struct hinic3_rxq *rxq)
 
 	while (free_wqebbs++ < rxq->q_depth) {
 		ci = hinic3_get_rq_local_ci(rxq);
-
-		rx_cqe = &rxq->rx_cqe[ci];
-
-		/* Clear done bit. */
-		rx_cqe->status = 0;
+		if (rxq->wqe_type != HINIC3_COMPACT_RQ_WQE) {
+			rx_cqe = &rxq->rx_cqe[ci];
+			/* Clear done bit. */
+			rx_cqe->status = 0;
+		}
 
 		rx_info = &rxq->rx_info[ci];
 		rte_pktmbuf_free(rx_info->mbuf);
@@ -299,7 +299,7 @@ hinic3_rearm_rxq_mbuf(struct hinic3_rxq *rxq)
 	for (i = 0; i < rearm_wqebbs; i++) {
 		dma_addr = rte_mbuf_data_iova_default(rearm_mbufs[i]);
 
-		/* Fill buffer address only. */
+		/* Fill packet dma address into wqe. */
 		if (rxq->wqe_type == HINIC3_EXTEND_RQ_WQE) {
 			rq_wqe->extend_wqe.buf_desc.sge.hi_addr =
 				hinic3_hw_be32(upper_32_bits(dma_addr));
@@ -307,11 +307,16 @@ hinic3_rearm_rxq_mbuf(struct hinic3_rxq *rxq)
 				hinic3_hw_be32(lower_32_bits(dma_addr));
 			rq_wqe->extend_wqe.buf_desc.sge.len =
 				nic_dev->rx_buff_len;
-		} else {
+		} else if (rxq->wqe_type == HINIC3_NORMAL_RQ_WQE) {
 			rq_wqe->normal_wqe.buf_hi_addr =
 				hinic3_hw_be32(upper_32_bits(dma_addr));
 			rq_wqe->normal_wqe.buf_lo_addr =
 				hinic3_hw_be32(lower_32_bits(dma_addr));
+		} else {
+			rq_wqe->compact_wqe.buf_hi_addr =
+				hinic3_hw_be32(upper_32_bits(dma_addr));
+			rq_wqe->compact_wqe.buf_lo_addr =
+				hinic3_hw_be32(lower_32_bits(dma_addr));
 		}
 
 		rq_wqe =
@@ -618,6 +623,31 @@ hinic3_poll_rq_empty(struct hinic3_rxq *rxq)
 	return err;
 }
 
+int
+hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq)
+{
+	struct hinic3_rx_info *rx_info;
+	struct hinic3_rq_ci_wb rq_ci;
+	uint16_t sw_ci;
+	uint16_t hw_ci;
+
+	sw_ci = hinic3_get_rq_local_ci(rxq);
+	rq_ci.dw1.value = hinic3_hw_cpu32(__atomic_load_n(&rxq->rq_ci->dw1.value, __ATOMIC_ACQUIRE));
+	hw_ci = rq_ci.dw1.bs.hw_ci;
+
+	while (sw_ci != hw_ci) {
+		rx_info = &rxq->rx_info[sw_ci];
+		rte_pktmbuf_free(rx_info->mbuf);
+		rx_info->mbuf = NULL;
+
+		sw_ci++;
+		sw_ci &= rxq->q_mask;
+		hinic3_update_rq_local_ci(rxq, 1);
+	}
+
+	return 0;
+}
+
 void
 hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,
 		       uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done)
@@ -701,14 +731,17 @@ hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	rte_spinlock_unlock(&nic_dev->queue_list_lock);
 
 	/* Send flush rxq cmd to device. */
-	err = hinic3_set_rq_flush(nic_dev->hwdev, rxq->q_id);
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) == 0)
+		err = hinic3_set_rq_flush(nic_dev->hwdev, rxq->q_id);
+	else
+		err = hinic3_set_rq_enable(nic_dev, rxq->q_id, false);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Flush rq failed, eth_dev:%s, queue_idx:%d",
 			    nic_dev->dev_name, rxq->q_id);
 		goto rq_flush_failed;
 	}
 
-	err = hinic3_poll_rq_empty(rxq);
+	err = nic_dev->tx_rx_ops.nic_rx_poll_rq_empty(rxq);
 	if (err) {
 		hinic3_dump_cqe_status(rxq, &cqe_done_cnt, &cqe_hole_cnt,
 				       &head_ci, &head_done);
@@ -724,6 +757,7 @@ hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	return 0;
 
 poll_rq_failed:
+	hinic3_set_rq_enable(nic_dev, rxq->q_id, true);
 rq_flush_failed:
 	rte_spinlock_lock(&nic_dev->queue_list_lock);
 set_indir_failed:
@@ -746,14 +780,22 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
 
 	if (nic_dev->rss_state == HINIC3_RSS_ENABLE) {
-		err = hinic3_refill_indir_rqid(rxq);
-		if (err) {
-			PMD_DRV_LOG(ERR,
-				    "Refill rq to indirect table failed, eth_dev:%s, queue_idx:%d err:%d",
-				    nic_dev->dev_name, rxq->q_id, err);
-			hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);
+		if ((hinic3_get_driver_feature(nic_dev) & NIC_F_FDIR) != 0)
+			err = hinic3_set_rq_enable(nic_dev, rxq->q_id, true);
+		if(err) {
+			PMD_DRV_LOG(ERR, "Flush rq failed, eth_dev:%s, queue_idx:%d\n",
+					nic_dev->dev_name, rxq->q_id);
+		} else {
+			err = hinic3_refill_indir_rqid(rxq);
+			if (err) {
+				PMD_DRV_LOG(ERR, "Refill rq to indirect table failed,"
+							"eth_dev:%s, queue_idx:%d err:%d",
+							nic_dev->dev_name, rxq->q_id, err);
+				hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);
+			}
 		}
 	}
+
 	hinic3_rearm_rxq_mbuf(rxq);
 	if (rxq->nic_dev->num_rss == 1) {
 		err = hinic3_set_vport_enable(nic_dev->hwdev, true);
@@ -772,12 +814,9 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 
 
 static inline uint64_t
-hinic3_rx_vlan(uint32_t offload_type, uint32_t vlan_len, uint16_t *vlan_tci)
+hinic3_rx_vlan(uint8_t vlan_offload, uint16_t vlan_tag, uint16_t *vlan_tci)
 {
-	uint16_t vlan_tag;
-
-	vlan_tag = HINIC3_GET_RX_VLAN_TAG(vlan_len);
-	if (!HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type) || vlan_tag == 0) {
+	if (!vlan_offload || vlan_tag == 0) {
 		*vlan_tci = 0;
 		return 0;
 	}
@@ -788,16 +827,14 @@ hinic3_rx_vlan(uint32_t offload_type, uint32_t vlan_len, uint16_t *vlan_tci)
 }
 
 static inline uint64_t
-hinic3_rx_csum(uint32_t status, struct hinic3_rxq *rxq)
+hinic3_rx_csum(uint16_t csum_err, struct hinic3_rxq *rxq)
 {
 	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
-	uint32_t csum_err;
 	uint64_t flags;
 
 	if (unlikely(!(nic_dev->rx_csum_en & HINIC3_DEFAULT_RX_CSUM_OFFLOAD)))
 		return HINIC3_PKT_RX_IP_CKSUM_UNKNOWN;
 
-	csum_err = HINIC3_GET_RX_CSUM_ERR(status);
 	if (likely(csum_err == 0))
 		return (HINIC3_PKT_RX_IP_CKSUM_GOOD |
 			HINIC3_PKT_RX_L4_CKSUM_GOOD);
@@ -931,18 +968,119 @@ hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
 	return err;
 }
 
+bool
+rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe)
+{
+	struct hinic3_rq_cqe *cqe = NULL;
+	uint16_t sw_ci;
+	uint32_t status;
+
+	sw_ci = hinic3_get_rq_local_ci(rxq);
+	*rx_cqe = &rxq->rx_cqe[sw_ci];
+	cqe = *rx_cqe;
+
+	status = hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&cqe->status,
+														rte_memory_order_acquire)));
+	if (!HINIC3_GET_RX_DONE(status))
+		return false;
+
+	return true;
+}
+
+bool
+rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe)
+{
+	struct hinic3_rq_ci_wb rq_ci;
+	struct rte_mbuf *rxm = NULL;
+	uint16_t sw_ci, hw_ci;
+
+	sw_ci = hinic3_get_rq_local_ci(rxq);
+	rq_ci.dw1.value = hinic3_hw_cpu32(rte_atomic_load_explicit(&rxq->rq_ci->dw1.value,
+														rte_memory_order_acquire));
+	hw_ci = rq_ci.dw1.bs.hw_ci;
+
+	if (hw_ci == sw_ci)
+		return false;
+
+	rxm = rxq->rx_info[sw_ci].mbuf;
+
+	*rx_cqe = rte_mbuf_buf_addr(rxm, rxm->pool) + RTE_PKTMBUF_HEADROOM;
+
+	return true;
+}
+
+void
+hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe,
+					   struct hinic3_cqe_info *cqe_info)
+{
+	uint32_t dw0 = hinic3_hw_cpu32(rx_cqe->status);
+	uint32_t dw1 = hinic3_hw_cpu32(rx_cqe->vlan_len);
+	uint32_t dw2 = hinic3_hw_cpu32(rx_cqe->offload_type);
+	uint32_t dw3 = hinic3_hw_cpu32(rx_cqe->hash_val);
+
+	cqe_info->lro_num =  RQ_CQE_STATUS_GET(dw0, NUM_LRO);
+	cqe_info->csum_err =  RQ_CQE_STATUS_GET(dw0, CSUM_ERR);
+
+	cqe_info->pkt_len = RQ_CQE_SGE_GET(dw1, LEN);
+	cqe_info->vlan_tag = RQ_CQE_SGE_GET(dw1, VLAN);
+
+	cqe_info->ptype = HINIC3_GET_RX_PTYPE_OFFLOAD(dw0);
+	cqe_info->vlan_offload = RQ_CQE_OFFOLAD_TYPE_GET(dw2, VLAN_EN);
+	cqe_info->rss_type = RQ_CQE_OFFOLAD_TYPE_GET(dw2, RSS_TYPE);
+	cqe_info->rss_hash_value = dw3;
+}
+
+void
+hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe,
+							   struct hinic3_cqe_info *cqe_info)
+{
+	struct hinic3_rq_cqe *cqe = (struct hinic3_rq_cqe *)rx_cqe;
+	struct hinic3_cqe_info *info = (struct hinic3_cqe_info *)cqe_info;
+	uint32_t dw0, dw1, dw2;
+
+	if (rxq->wqe_type != HINIC3_COMPACT_RQ_WQE) {
+		dw0 = hinic3_hw_cpu32(rx_cqe->status);
+		dw1 = hinic3_hw_cpu32(rx_cqe->vlan_len);
+		dw2 = hinic3_hw_cpu32(rx_cqe->offload_type);
+	} else {
+		/* Compact Rx CQE mode integrates cqe with packet in big endian way. */
+		dw0 = be32_to_cpu(rx_cqe->status);
+		dw1 = be32_to_cpu(rx_cqe->vlan_len);
+		dw2 = be32_to_cpu(rx_cqe->offload_type);
+	}
+
+	cqe_info->cqe_type = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, CQE_TYPE);
+	cqe_info->csum_err = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, CSUM_ERR);
+	cqe_info->vlan_offload = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, VLAN_EN);
+	cqe_info->cqe_len = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, CQE_LEN);
+	cqe_info->pkt_len = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PKT_LEN);
+	cqe_info->ts_flag = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, TS_FLAG);
+	cqe_info->ptype = HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);
+	cqe_info->rss_hash_value = dw1;
+
+	if (cqe_info->cqe_len == HINIC3_RQ_COMPACT_CQE_16BYTE) {
+		cqe_info->lro_num = HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, NUM_LRO);
+		cqe_info->vlan_tag = HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(dw2, VLAN);
+	}
+
+	if (cqe_info->cqe_type == HINIC3_RQ_CQE_INTEGRATE)
+		cqe_info->data_offset =
+				(cqe_info->cqe_len == HINIC3_RQ_COMPACT_CQE_16BYTE) ? 16 : 8;
+}
+
 #define HINIC3_RX_EMPTY_THRESHOLD 3
 uint16_t
 hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct hinic3_rxq *rxq = rx_queue;
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
 	struct hinic3_rx_info *rx_info = NULL;
 	volatile struct hinic3_rq_cqe *rx_cqe = NULL;
+	struct hinic3_cqe_info cqe_info = {0};
 	struct rte_mbuf *rxm = NULL;
-	uint16_t sw_ci, rx_buf_len, wqebb_cnt = 0, pkts = 0;
-	uint32_t status, pkt_len, vlan_len, offload_type, lro_num;
+	uint16_t sw_ci, rx_buf_len, pkts = 0;
+	uint32_t pkt_len;
 	uint64_t rx_bytes = 0;
-	uint32_t hash_value;
 
 #ifdef HINIC3_XSTAT_PROF_RX
 	uint64_t t1 = rte_get_tsc_cycles();
@@ -953,20 +1091,22 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		goto out;
 
 	sw_ci = hinic3_get_rq_local_ci(rxq);
-	rx_buf_len = rxq->buf_len;
 
 	while (pkts < nb_pkts) {
 		rx_cqe = &rxq->rx_cqe[sw_ci];
-		status = hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&rx_cqe->status,
-			rte_memory_order_acquire)));
-		if (!HINIC3_GET_RX_DONE(status)) {
+		if (!nic_dev->tx_rx_ops.rx_cqe_done(rxq, &rx_cqe)) {
 			rxq->rxq_stats.empty++;
 			break;
 		}
 
-		vlan_len = hinic3_hw_cpu32(rx_cqe->vlan_len);
+		nic_dev->tx_rx_ops.rx_get_cqe_info(rxq, rx_cqe, &cqe_info);
 
-		pkt_len = HINIC3_GET_RX_PKT_LEN(vlan_len);
+		pkt_len = cqe_info.pkt_len;
+		/*
+		 * Compact Rx CQE mode integrates cqe with packet,
+		 * so mbuf length needs to remove the length of cqe.
+		 */
+		rx_buf_len = rxq->buf_len - cqe_info.data_offset;
 
 		rx_info = &rxq->rx_info[sw_ci];
 		rxm = rx_info->mbuf;
@@ -982,7 +1122,7 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		if (likely(pkt_len <= rx_buf_len)) {
 			rxm->data_len = (uint16_t)pkt_len;
 			rxm->pkt_len = pkt_len;
-			wqebb_cnt++;
+			hinic3_update_rq_local_ci(rxq, 1);
 		} else {
 			rxm->data_len = rx_buf_len;
 			rxm->pkt_len = rx_buf_len;
@@ -991,33 +1131,28 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			 * If receive jumbo, updating ci will be done by
 			 * hinic3_recv_jumbo_pkt function.
 			 */
-			hinic3_update_rq_local_ci(rxq, wqebb_cnt + 1);
-			wqebb_cnt = 0;
+			hinic3_update_rq_local_ci(rxq, 1);
 			hinic3_recv_jumbo_pkt(rxq, rxm, pkt_len - rx_buf_len);
 			sw_ci = hinic3_get_rq_local_ci(rxq);
 		}
 
-		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+		rxm->data_off = RTE_PKTMBUF_HEADROOM + cqe_info.data_offset;
 		rxm->port = rxq->port_id;
 
 		/* 4. Rx checksum offload. */
-		rxm->ol_flags |= hinic3_rx_csum(status, rxq);
+		rxm->ol_flags |= hinic3_rx_csum(cqe_info.csum_err, rxq);
 
 		/* 5. Vlan offload. */
-		offload_type = hinic3_hw_cpu32(rx_cqe->offload_type);
-
-		rxm->ol_flags |=
-			hinic3_rx_vlan(offload_type, vlan_len, &rxm->vlan_tci);
+		rxm->ol_flags |= hinic3_rx_vlan(cqe_info.vlan_offload, cqe_info.vlan_tag,
+										&rxm->vlan_tci);
 
 		/* 6. RSS. */
-		hash_value = hinic3_hw_cpu32(rx_cqe->hash_val);
-		rxm->ol_flags |= hinic3_rx_rss_hash(offload_type, hash_value,
-						    &rxm->hash.rss);
+		rxm->ol_flags |= hinic3_rx_rss_hash(cqe_info.rss_type, cqe_info.rss_hash_value,
+											&rxm->hash.rss);
 		/* 8. LRO. */
-		lro_num = HINIC3_GET_RX_NUM_LRO(status);
-		if (unlikely(lro_num != 0)) {
+		if (unlikely(cqe_info.lro_num != 0)) {
 			rxm->ol_flags |= HINIC3_PKT_RX_LRO;
-			rxm->tso_segsz = pkt_len / lro_num;
+			rxm->tso_segsz = pkt_len / cqe_info.lro_num;
 		}
 
 		rx_cqe->status = 0;
@@ -1027,9 +1162,6 @@ hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	}
 
 	if (pkts) {
-		/* 9. Update local ci. */
-		hinic3_update_rq_local_ci(rxq, wqebb_cnt);
-
 		/* Update packet stats. */
 		rxq->rxq_stats.packets += pkts;
 		rxq->rxq_stats.bytes += rx_bytes;
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.h
index 1a92df59b7..9fc86ae20a 100644
--- a/drivers/net/hinic3/hinic3_rx.h
+++ b/drivers/net/hinic3/hinic3_rx.h
@@ -122,6 +122,53 @@
 #define HINIC3_GET_ESP_NEXT_HEAD(decry_info) \
 	RQ_CQE_DECRY_INFO_GET(decry_info, ESP_NEXT_HEAD)
 
+/* Compact CQE Field */
+/* cqe dw0 */
+#define RQ_COMPACT_CQE_STATUS_RXDONE_SHIFT		31
+#define RQ_COMPACT_CQE_STATUS_CQE_TYPE_SHIFT		30
+#define RQ_COMPACT_CQE_STATUS_TS_FLAG_SHIFT		29
+#define RQ_COMPACT_CQE_STATUS_VLAN_EN_SHIFT		28
+#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_SHIFT		25
+#define RQ_COMPACT_CQE_STATUS_IP_TYPE_SHIFT		24
+#define RQ_COMPACT_CQE_STATUS_CQE_LEN_SHIFT		23
+#define RQ_COMPACT_CQE_STATUS_PKT_MC_SHIFT		21
+#define RQ_COMPACT_CQE_STATUS_CSUM_ERR_SHIFT		19
+#define RQ_COMPACT_CQE_STATUS_PKT_TYPE_SHIFT		16
+#define RQ_COMPACT_CQE_STATUS_PTYPE_SHIFT		16
+#define RQ_COMPACT_CQE_STATUS_PKT_LEN_SHIFT		0
+
+#define RQ_COMPACT_CQE_STATUS_RXDONE_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_CQE_TYPE_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_TS_FLAG_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_VLAN_EN_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_PKT_FORMAT_MASK	0x7U
+#define RQ_COMPACT_CQE_STATUS_IP_TYPE_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_CQE_LEN_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_PKT_MC_MASK		0x1U
+#define RQ_COMPACT_CQE_STATUS_CSUM_ERR_MASK		0x3U
+#define RQ_COMPACT_CQE_STATUS_PKT_TYPE_MASK		0x7U
+#define RQ_COMPACT_CQE_STATUS_PTYPE_MASK		0xFFFU
+#define RQ_COMPACT_CQE_STATUS_PKT_LEN_MASK		0xFFFFU
+
+#define HINIC3_RQ_COMPACT_CQE_STATUS_GET(val, member) \
+	((((val) >> RQ_COMPACT_CQE_STATUS_##member##_SHIFT) & \
+		RQ_COMPACT_CQE_STATUS_##member##_MASK))
+
+#define HINIC3_RQ_CQE_SEPARATE 	0
+#define HINIC3_RQ_CQE_INTEGRATE 1
+
+/* cqe dw2 */
+#define RQ_COMPACT_CQE_OFFLOAD_NUM_LRO_SHIFT		24
+#define RQ_COMPACT_CQE_OFFLOAD_VLAN_SHIFT		8
+
+#define RQ_COMPACT_CQE_OFFLOAD_NUM_LRO_MASK		0xFFU
+#define RQ_COMPACT_CQE_OFFLOAD_VLAN_MASK		0xFFFFU
+
+#define HINIC3_RQ_COMPACT_CQE_OFFLOAD_GET(val, member) \
+	(((val) >> RQ_COMPACT_CQE_OFFLOAD_##member##_SHIFT) & RQ_COMPACT_CQE_OFFLOAD_##member##_MASK)
+
+#define HINIC3_RQ_COMPACT_CQE_16BYTE	0
+#define HINIC3_RQ_COMPACT_CQE_8BYTE 	1
 /* Rx cqe checksum err */
 #define HINIC3_RX_CSUM_IP_CSUM_ERR      RTE_BIT32(0)
 #define HINIC3_RX_CSUM_TCP_CSUM_ERR     RTE_BIT32(1)
@@ -151,6 +198,9 @@
 	RTE_ETH_RSS_IPV6_TCP_EX |        \
 	RTE_ETH_RSS_IPV6_UDP_EX)
 
+#define HINIC3_COMPACT_CQE_PTYPE_SHIFT 16
+
+
 struct hinic3_rxq_stats {
 	uint64_t packets;
 	uint64_t bytes;
@@ -195,6 +245,23 @@ struct __rte_cache_aligned hinic3_rq_cqe {
 	uint32_t pkt_info;
 };
 
+struct hinic3_cqe_info {
+	uint8_t data_offset;
+	uint8_t lro_num;
+	uint8_t vlan_offload;
+	uint8_t cqe_len;
+	uint8_t cqe_type;
+	uint8_t ts_flag;
+
+	uint16_t csum_err;
+	uint16_t vlan_tag;
+	uint16_t ptype;
+	uint16_t pkt_len;
+	uint16_t rss_type;
+
+	uint32_t rss_hash_value;
+};
+
 /**
  * Attention: please do not add any member in hinic3_rx_info
  * because rxq bulk rearm mode will write mbuf in rx_info.
@@ -220,13 +287,32 @@ struct hinic3_rq_normal_wqe {
 	uint32_t cqe_lo_addr;
 };
 
+struct hinic3_rq_compact_wqe {
+	uint32_t buf_hi_addr;
+	uint32_t buf_lo_addr;
+};
+
 struct hinic3_rq_wqe {
 	union {
+		struct hinic3_rq_compact_wqe compact_wqe;
 		struct hinic3_rq_normal_wqe normal_wqe;
 		struct hinic3_rq_extend_wqe extend_wqe;
 	};
 };
 
+struct hinic3_rq_ci_wb {
+	union {
+		struct {
+			uint16_t cqe_num;
+			uint16_t hw_ci;
+		} bs;
+		uint32_t value;
+	} dw1;
+
+	uint32_t rsvd[3];
+};
+
+
 struct __rte_cache_aligned hinic3_rxq {
 	struct hinic3_nic_dev *nic_dev;
 
@@ -263,6 +349,10 @@ struct __rte_cache_aligned hinic3_rxq {
 	struct hinic3_rq_cqe *rx_cqe;
 	struct rte_mempool *mb_pool;
 
+	const struct rte_memzone *ci_mz;
+	struct hinic3_rq_ci_wb *rq_ci;
+	rte_iova_t rq_ci_paddr;
+
 	const struct rte_memzone *cqe_mz;
 	rte_iova_t cqe_start_paddr;
 	void *cqe_start_vaddr;
@@ -290,6 +380,7 @@ void hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev *nic_dev);
 int hinic3_update_rss_config(struct rte_eth_dev *dev,
 			     struct rte_eth_rss_conf *rss_conf);
 
+int hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq *rxq);
 int hinic3_poll_rq_empty(struct hinic3_rxq *rxq);
 
 void hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,
@@ -351,4 +442,60 @@ hinic3_update_rq_local_ci(struct hinic3_rxq *rxq, uint16_t wqe_cnt)
 	rxq->delta += wqe_cnt;
 }
 
+/**
+ * Get receive cqe information
+ *
+ * @param[in] rxq
+ *   Receive queue
+ * @param[in] rx_cqe
+ *   Receive cqe
+ * @param[in] cqe_info
+ *   Packet information parsed from cqe
+ */
+void
+hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe,
+							struct hinic3_cqe_info *cqe_info);
+
+/**
+ * Get receive compact cqe information
+ *
+ * @param[in] rx_queue
+ *   Receive queue
+ * @param[in] rx_cqe
+ *   Receive compact cqe
+ * @param[in] cqe_info
+ *   Packet information parsed from cqe
+ */
+void
+hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe *rx_cqe
+									struct hinic3_cqe_info *cqe_info);
+
+/**
+ * Check whether pkt is received when CQE is separated
+ *
+ * @param[in] rxq
+ *   Receive queue
+ * @param[in] rx_cqe
+ *   The CQE written by hw
+ * @return
+ *   True: Packet is received
+ *   False: Packet is not received
+ */
+bool
+rx_separate_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe);
+
+/**
+ * Check whether pkt is received when CQE is integrated
+ *
+ * @param[in] rxq
+ *   Receive queue
+ * @param[in] rx_cqe
+ *   The CQE written by hw
+ * @return
+ *   True: Packet is received
+ *   False: Packet is not received
+ */
+bool
+rx_integrated_cqe_done(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe);
+
 #endif /* _HINIC3_RX_H_ */
-- 
2.45.1.windows.1


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10136CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 04:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 071A240A72;
	Tue,  2 Sep 2025 06:02:42 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id 5005C406BB
 for <dev@dpdk.org>; Tue,  2 Sep 2025 06:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=+9ST2t4O2JDyBxtKPcXRHtY93rghJ7F/P+ji146Qu34=;
 b=IeIIe70m02zC5N19wNvvXp0ba4HWSeo0kfOPWnQ+kSwBHChH2EcfhWMZ/TmWXV
 bylVwCb3zWk1CwooXUMJ4YbvZEeApBKusI2b4xkl5aq70ZT1NIx5hedZfPng6al2
 qLKeieKdnReMc23UXHdAt93qSyCrCalb+mspQUjsUI1TM=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgC3XbtJbLZoaQXrAg--.25878S18;
 Tue, 02 Sep 2025 12:02:34 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [V7 14/17] net/hinic3: add Rx/Tx functions
Date: Tue,  2 Sep 2025 12:01:48 +0800
Message-ID: <20250902040204.9572-15-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250902040204.9572-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250902040204.9572-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgC3XbtJbLZoaQXrAg--.25878S18
X-Coremail-Antispam: 1Uf129KBjvAXoWfCF45Zr1ftr47GF4DJF17GFg_yoW5Cw4UGo
 WfXr1ayrnYqryxCrWj9w4kuFn2qws0vFW5Jw4Fyr42vF18CryYga9xJw1rta48XrW5Ca1x
 Aa43JwnFy39xJay5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUoXdbUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHwe8Cmi2az4ERAAAsl
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

This patch add package sending and receiving function codes.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c |   4 +-
 drivers/net/hinic3/hinic3_rx.c     | 285 +++++++++++
 drivers/net/hinic3/hinic3_tx.c     | 754 +++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_tx.h     |   1 +
 4 files changed, 1043 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 71c5b4f3b4..0bca2c930f 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1521,7 +1521,6 @@ hinic3_init_rxq_msix_attr(void *hwdev, uint16_t msix_index)
 	info.pending_limt = HINIC3_TXRX_MSIX_PENDING_LIMIT;
 	info.coalesce_timer_cfg = HINIC3_TXRX_MSIX_COALESCE_TIMER;
 	info.resend_timer_cfg = HINIC3_TXRX_MSIX_RESEND_TIMER_CFG;
-
 	info.msix_index = msix_index;
 	err = hinic3_set_interrupt_cfg(hwdev, info);
 	if (err) {
@@ -3296,6 +3295,9 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 	PMD_DRV_LOG(INFO, "Network Interface pmd driver version: %s",
 		    HINIC3_PMD_DRV_VERSION);
 
+	eth_dev->rx_pkt_burst = hinic3_recv_pkts;
+	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
+
 	return hinic3_func_init(eth_dev);
 }
 
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index 2acef269e6..085662afbf 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -780,3 +780,288 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 
 	return err;
 }
+
+
+static inline uint64_t
+hinic3_rx_vlan(uint32_t offload_type, uint32_t vlan_len, uint16_t *vlan_tci)
+{
+	uint16_t vlan_tag;
+
+	vlan_tag = HINIC3_GET_RX_VLAN_TAG(vlan_len);
+	if (!HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type) || vlan_tag == 0) {
+		*vlan_tci = 0;
+		return 0;
+	}
+
+	*vlan_tci = vlan_tag;
+
+	return HINIC3_PKT_RX_VLAN | HINIC3_PKT_RX_VLAN_STRIPPED;
+}
+
+static inline uint64_t
+hinic3_rx_csum(uint32_t status, struct hinic3_rxq *rxq)
+{
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+	uint32_t csum_err;
+	uint64_t flags;
+
+	if (unlikely(!(nic_dev->rx_csum_en & HINIC3_DEFAULT_RX_CSUM_OFFLOAD)))
+		return HINIC3_PKT_RX_IP_CKSUM_UNKNOWN;
+
+	csum_err = HINIC3_GET_RX_CSUM_ERR(status);
+	if (likely(csum_err == 0))
+		return (HINIC3_PKT_RX_IP_CKSUM_GOOD |
+			HINIC3_PKT_RX_L4_CKSUM_GOOD);
+
+	/*
+	 * If bypass bit is set, all other err status indications should be
+	 * ignored.
+	 */
+	if (unlikely(csum_err & HINIC3_RX_CSUM_HW_CHECK_NONE))
+		return HINIC3_PKT_RX_IP_CKSUM_UNKNOWN;
+
+	flags = 0;
+
+	/* IP checksum error. */
+	if (csum_err & HINIC3_RX_CSUM_IP_CSUM_ERR) {
+		flags |= HINIC3_PKT_RX_IP_CKSUM_BAD;
+		rxq->rxq_stats.csum_errors++;
+	}
+
+	/* L4 checksum error. */
+	if ((csum_err & HINIC3_RX_CSUM_TCP_CSUM_ERR) ||
+	    (csum_err & HINIC3_RX_CSUM_UDP_CSUM_ERR) ||
+	    (csum_err & HINIC3_RX_CSUM_SCTP_CRC_ERR)) {
+		flags |= HINIC3_PKT_RX_L4_CKSUM_BAD;
+		rxq->rxq_stats.csum_errors++;
+	}
+
+	if (unlikely(csum_err == HINIC3_RX_CSUM_IPSU_OTHER_ERR))
+		rxq->rxq_stats.other_errors++;
+
+	return flags;
+}
+
+static inline uint64_t
+hinic3_rx_rss_hash(uint32_t offload_type, uint32_t rss_hash_value, uint32_t *rss_hash)
+{
+	uint32_t rss_type;
+
+	rss_type = HINIC3_GET_RSS_TYPES(offload_type);
+	if (likely(rss_type != 0)) {
+		*rss_hash = rss_hash_value;
+		return HINIC3_PKT_RX_RSS_HASH;
+	}
+
+	return 0;
+}
+
+static void
+hinic3_recv_jumbo_pkt(struct hinic3_rxq *rxq, struct rte_mbuf *head_mbuf,
+		      uint32_t remain_pkt_len)
+{
+	struct rte_mbuf *cur_mbuf = NULL;
+	struct rte_mbuf *rxm = NULL;
+	struct hinic3_rx_info *rx_info = NULL;
+	uint16_t sw_ci, rx_buf_len = rxq->buf_len;
+	uint32_t pkt_len;
+
+	while (remain_pkt_len > 0) {
+		sw_ci = hinic3_get_rq_local_ci(rxq);
+		rx_info = &rxq->rx_info[sw_ci];
+
+		hinic3_update_rq_local_ci(rxq, 1);
+
+		pkt_len = remain_pkt_len > rx_buf_len ? rx_buf_len
+						      : remain_pkt_len;
+		remain_pkt_len -= pkt_len;
+
+		cur_mbuf = rx_info->mbuf;
+		cur_mbuf->data_len = (uint16_t)pkt_len;
+		cur_mbuf->next = NULL;
+
+		head_mbuf->pkt_len += cur_mbuf->data_len;
+		head_mbuf->nb_segs++;
+#ifdef HINIC3_XSTAT_MBUF_USE
+		rxq->rxq_stats.rx_free_mbuf_bytes++;
+#endif
+		if (!rxm)
+			head_mbuf->next = cur_mbuf;
+		else
+			rxm->next = cur_mbuf;
+
+		rxm = cur_mbuf;
+	}
+}
+
+int
+hinic3_start_all_rqs(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_nic_dev *nic_dev = NULL;
+	struct hinic3_rxq *rxq = NULL;
+	int err = 0;
+	int i;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+
+	for (i = 0; i < nic_dev->num_rqs; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
+		err = hinic3_rearm_rxq_mbuf(rxq);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Fail to alloc mbuf for Rx queue %d, "
+				    "qid = %u, need_mbuf: %d",
+				    i, rxq->q_id, rxq->q_depth);
+			goto out;
+		}
+		hinic3_dev_rx_queue_intr_enable(eth_dev, rxq->q_id);
+		eth_dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	if (nic_dev->rss_state == HINIC3_RSS_ENABLE) {
+		err = hinic3_refill_indir_rqid(rxq);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Refill rq to indirect table failed, "
+				    "eth_dev:%s, queue_idx:%d, err:%d",
+				    rxq->nic_dev->dev_name, rxq->q_id, err);
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	for (i = 0; i < nic_dev->num_rqs; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);
+		hinic3_free_rxq_mbufs(rxq);
+		hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);
+		eth_dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+	return err;
+}
+
+#define HINIC3_RX_EMPTY_THRESHOLD 3
+uint16_t
+hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	struct hinic3_rxq *rxq = rx_queue;
+	struct hinic3_rx_info *rx_info = NULL;
+	volatile struct hinic3_rq_cqe *rx_cqe = NULL;
+	struct rte_mbuf *rxm = NULL;
+	uint16_t sw_ci, rx_buf_len, wqebb_cnt = 0, pkts = 0;
+	uint32_t status, pkt_len, vlan_len, offload_type, lro_num;
+	uint64_t rx_bytes = 0;
+	uint32_t hash_value;
+
+#ifdef HINIC3_XSTAT_PROF_RX
+	uint64_t t1 = rte_get_tsc_cycles();
+	uint64_t t2;
+#endif
+	if (((rte_get_timer_cycles() - rxq->rxq_stats.tsc) < rxq->wait_time_cycle) &&
+	    rxq->rxq_stats.empty >= HINIC3_RX_EMPTY_THRESHOLD)
+		goto out;
+
+	sw_ci = hinic3_get_rq_local_ci(rxq);
+	rx_buf_len = rxq->buf_len;
+
+	while (pkts < nb_pkts) {
+		rx_cqe = &rxq->rx_cqe[sw_ci];
+		status = hinic3_hw_cpu32((uint32_t)(rte_atomic_load_explicit(&rx_cqe->status,
+			rte_memory_order_acquire)));
+		if (!HINIC3_GET_RX_DONE(status)) {
+			rxq->rxq_stats.empty++;
+			break;
+		}
+
+		vlan_len = hinic3_hw_cpu32(rx_cqe->vlan_len);
+
+		pkt_len = HINIC3_GET_RX_PKT_LEN(vlan_len);
+
+		rx_info = &rxq->rx_info[sw_ci];
+		rxm = rx_info->mbuf;
+
+		/* 1. Next ci point and prefetch. */
+		sw_ci++;
+		sw_ci &= rxq->q_mask;
+
+		/* 2. Prefetch next mbuf first 64B. */
+		rte_prefetch0(rxq->rx_info[sw_ci].mbuf);
+
+		/* 3. Jumbo frame process. */
+		if (likely(pkt_len <= (uint32_t)rx_buf_len)) {
+			rxm->data_len = (uint16_t)pkt_len;
+			rxm->pkt_len = pkt_len;
+			wqebb_cnt++;
+		} else {
+			rxm->data_len = rx_buf_len;
+			rxm->pkt_len = rx_buf_len;
+
+			/*
+			 * If receive jumbo, updating ci will be done by
+			 * hinic3_recv_jumbo_pkt function.
+			 */
+			hinic3_update_rq_local_ci(rxq, wqebb_cnt + 1);
+			wqebb_cnt = 0;
+			hinic3_recv_jumbo_pkt(rxq, rxm, pkt_len - rx_buf_len);
+			sw_ci = hinic3_get_rq_local_ci(rxq);
+		}
+
+		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+		rxm->port = rxq->port_id;
+
+		/* 4. Rx checksum offload. */
+		rxm->ol_flags |= hinic3_rx_csum(status, rxq);
+
+		/* 5. Vlan offload. */
+		offload_type = hinic3_hw_cpu32(rx_cqe->offload_type);
+
+		rxm->ol_flags |=
+			hinic3_rx_vlan(offload_type, vlan_len, &rxm->vlan_tci);
+
+		/* 6. RSS. */
+		hash_value = hinic3_hw_cpu32(rx_cqe->hash_val);
+		rxm->ol_flags |= hinic3_rx_rss_hash(offload_type, hash_value,
+						    &rxm->hash.rss);
+		/* 8. LRO. */
+		lro_num = HINIC3_GET_RX_NUM_LRO(status);
+		if (unlikely(lro_num != 0)) {
+			rxm->ol_flags |= HINIC3_PKT_RX_LRO;
+			rxm->tso_segsz = pkt_len / lro_num;
+		}
+
+		rx_cqe->status = 0;
+
+		rx_bytes += pkt_len;
+		rx_pkts[pkts++] = rxm;
+	}
+
+	if (pkts) {
+		/* 9. Update local ci. */
+		hinic3_update_rq_local_ci(rxq, wqebb_cnt);
+
+		/* Update packet stats. */
+		rxq->rxq_stats.packets += pkts;
+		rxq->rxq_stats.bytes += rx_bytes;
+		rxq->rxq_stats.empty = 0;
+#ifdef HINIC3_XSTAT_MBUF_USE
+		rxq->rxq_stats.rx_free_mbuf_bytes += pkts;
+#endif
+	}
+	rxq->rxq_stats.burst_pkts = pkts;
+	rxq->rxq_stats.tsc = rte_get_timer_cycles();
+out:
+	/* 10. Rearm mbuf to rxq. */
+	hinic3_rearm_rxq_mbuf(rxq);
+
+#ifdef HINIC3_XSTAT_PROF_RX
+	/* Do profiling stats. */
+	t2 = rte_get_tsc_cycles();
+	rxq->rxq_stats.app_tsc = t1 - rxq->prof_rx_end_tsc;
+	rxq->prof_rx_end_tsc = t2;
+	rxq->rxq_stats.pmd_tsc = t2 - t1;
+#endif
+
+	return pkts;
+}
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index b16baa92ac..c883b999f5 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -56,6 +56,98 @@ hinic3_get_sq_hw_ci(struct hinic3_txq *sq)
 	return MASKED_QUEUE_IDX(sq, hinic3_hw_cpu16(*sq->ci_vaddr_base));
 }
 
+static void *
+hinic3_get_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)
+{
+	uint16_t cur_pi = MASKED_QUEUE_IDX(sq, sq->prod_idx);
+	uint32_t end_pi;
+
+	end_pi = cur_pi + wqe_info->wqebb_cnt;
+	sq->prod_idx += wqe_info->wqebb_cnt;
+
+	wqe_info->owner = (uint8_t)(sq->owner);
+	wqe_info->pi = cur_pi;
+	wqe_info->wrapped = 0;
+
+	if (unlikely(end_pi >= sq->q_depth)) {
+		sq->owner = !sq->owner;
+
+		if (likely(end_pi > sq->q_depth))
+			wqe_info->wrapped = (uint8_t)(sq->q_depth - cur_pi);
+	}
+
+	return NIC_WQE_ADDR(sq, cur_pi);
+}
+
+static inline void
+hinic3_put_sq_wqe(struct hinic3_txq *sq, struct hinic3_wqe_info *wqe_info)
+{
+	if (wqe_info->owner != sq->owner)
+		sq->owner = wqe_info->owner;
+
+	sq->prod_idx -= wqe_info->wqebb_cnt;
+}
+
+/**
+ * Sets the WQE combination information in the transmit queue (SQ).
+ *
+ * @param[in] txq
+ * Point to send queue.
+ * @param[out] wqe_combo
+ * Point to wqe_combo of send queue(SQ).
+ * @param[in] wqe
+ * Point to wqe of send queue(SQ).
+ * @param[in] wqe_info
+ * Point to wqe_info of send queue(SQ).
+ */
+static void
+hinic3_set_wqe_combo(struct hinic3_txq *txq,
+		     struct hinic3_sq_wqe_combo *wqe_combo,
+		     struct hinic3_sq_wqe *wqe,
+		     struct hinic3_wqe_info *wqe_info)
+{
+	wqe_combo->hdr = &wqe->compact_wqe.wqe_desc;
+
+	if (wqe_info->offload) {
+		if (wqe_info->wrapped == HINIC3_TX_TASK_WRAPPED) {
+			wqe_combo->task = (struct hinic3_sq_task *)
+				(void *)txq->sq_head_addr;
+			wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
+				(void *)(txq->sq_head_addr + txq->wqebb_size);
+		} else if (wqe_info->wrapped == HINIC3_TX_BD_DESC_WRAPPED) {
+			wqe_combo->task = &wqe->extend_wqe.task;
+			wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
+				(void *)(txq->sq_head_addr);
+		} else {
+			wqe_combo->task = &wqe->extend_wqe.task;
+			wqe_combo->bds_head = wqe->extend_wqe.buf_desc;
+		}
+
+		wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
+		wqe_combo->task_type = SQ_WQE_TASKSECT_16BYTES;
+
+		return;
+	}
+
+	if (wqe_info->wrapped == HINIC3_TX_TASK_WRAPPED) {
+		wqe_combo->bds_head = (struct hinic3_sq_bufdesc *)
+			(void *)(txq->sq_head_addr);
+	} else {
+		wqe_combo->bds_head =
+			(struct hinic3_sq_bufdesc *)(&wqe->extend_wqe.task);
+	}
+
+	if (wqe_info->wqebb_cnt > 1) {
+		wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
+		wqe_combo->task_type = SQ_WQE_TASKSECT_46BITS;
+
+		/* This section used as vlan insert, needs to clear. */
+		wqe_combo->bds_head->rsvd = 0;
+	} else {
+		wqe_combo->wqe_type = SQ_WQE_COMPACT_TYPE;
+	}
+}
+
 int
 hinic3_start_all_sqs(struct rte_eth_dev *eth_dev)
 {
@@ -216,6 +308,668 @@ hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
 	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);
 }
 
+/**
+ * Prepare the data packet to be sent and calculate the internal L3 offset.
+ *
+ * @param[in] mbuf
+ * Point to the mbuf to be processed.
+ * @param[out] inner_l3_offset
+ * Inner(IP Layer) L3 layer offset.
+ * @return
+ * 0 as success, -EINVAL as failure.
+ */
+static int
+hinic3_tx_offload_pkt_prepare(struct rte_mbuf *mbuf, uint16_t *inner_l3_offset)
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+
+	/* Only support vxlan offload. */
+	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) &&
+	    (!(ol_flags & HINIC3_PKT_TX_TUNNEL_VXLAN)))
+		return -EINVAL;
+
+#ifdef RTE_LIBRTE_ETHDEV_DEBUG
+	if (rte_validate_tx_offload(mbuf) != 0)
+		return -EINVAL;
+#endif
+	/* Support tunnel. */
+	if ((ol_flags & HINIC3_PKT_TX_TUNNEL_MASK)) {
+		if ((ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM) ||
+		    (ol_flags & HINIC3_PKT_TX_OUTER_IPV6) ||
+		    (ol_flags & HINIC3_PKT_TX_TCP_SEG)) {
+			/*
+			 * For this senmatic, l2_len of mbuf means
+			 * len(out_udp + vxlan + in_eth).
+			 */
+			*inner_l3_offset = mbuf->l2_len + mbuf->outer_l2_len +
+					   mbuf->outer_l3_len;
+		} else {
+			/*
+			 * For this senmatic, l2_len of mbuf means
+			 * len(out_eth + out_ip + out_udp + vxlan + in_eth).
+			 */
+			*inner_l3_offset = mbuf->l2_len;
+		}
+	} else {
+		/* For non-tunnel type pkts. */
+		*inner_l3_offset = mbuf->l2_len;
+	}
+
+	return 0;
+}
+
+static inline void
+hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task, uint16_t vlan_tag,
+			   uint8_t vlan_type)
+{
+	task->vlan_offload = SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
+			     SQ_TASK_INFO3_SET(vlan_type, VLAN_TYPE) |
+			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);
+}
+
+/**
+ * Set the corresponding offload information based on ol_flags of the mbuf.
+ *
+ * @param[in] mbuf
+ * Point to the mbuf for which offload needs to be set in the sending queue.
+ * @param[out] task
+ * Point to task of send queue(SQ).
+ * @param[out] wqe_info
+ * Point to wqe_info of send queue(SQ).
+ * @return
+ * 0 as success, -EINVAL as failure.
+ */
+static int
+hinic3_set_tx_offload(struct rte_mbuf *mbuf, struct hinic3_sq_task *task,
+		      struct hinic3_wqe_info *wqe_info)
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+	uint16_t pld_offset = 0;
+	uint32_t queue_info = 0;
+	uint16_t vlan_tag;
+
+	task->pkt_info0 = 0;
+	task->ip_identify = 0;
+	task->pkt_info2 = 0;
+	task->vlan_offload = 0;
+
+	/* Vlan offload. */
+	if (unlikely(ol_flags & HINIC3_PKT_TX_VLAN_PKT)) {
+		vlan_tag = mbuf->vlan_tci;
+		hinic3_set_vlan_tx_offload(task, vlan_tag, HINIC3_TX_TPID0);
+		task->vlan_offload = hinic3_hw_be32(task->vlan_offload);
+	}
+	/* Cksum offload. */
+	if (!(ol_flags & HINIC3_TX_CKSUM_OFFLOAD_MASK))
+		return 0;
+
+	/* Tso offload. */
+	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {
+		pld_offset = wqe_info->payload_offset;
+		if ((pld_offset >> 1) > MAX_PAYLOAD_OFFSET)
+			return -EINVAL;
+
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
+
+		queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, TSO);
+		queue_info |= SQ_CTRL_QUEUE_INFO_SET(pld_offset >> 1, PLDOFF);
+
+		/* Set MSS value. */
+		queue_info = SQ_CTRL_QUEUE_INFO_CLEAR(queue_info, MSS);
+		queue_info |= SQ_CTRL_QUEUE_INFO_SET(mbuf->tso_segsz, MSS);
+	} else {
+		if (ol_flags & HINIC3_PKT_TX_IP_CKSUM)
+			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
+
+		switch (ol_flags & HINIC3_PKT_TX_L4_MASK) {
+		case HINIC3_PKT_TX_TCP_CKSUM:
+		case HINIC3_PKT_TX_UDP_CKSUM:
+		case HINIC3_PKT_TX_SCTP_CKSUM:
+			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+			break;
+
+		case HINIC3_PKT_TX_L4_NO_CKSUM:
+			break;
+
+		default:
+			PMD_DRV_LOG(INFO, "not support pkt type");
+			return -EINVAL;
+		}
+	}
+
+	/* For vxlan, also can support PKT_TX_TUNNEL_GRE, etc. */
+	switch (ol_flags & HINIC3_PKT_TX_TUNNEL_MASK) {
+	case HINIC3_PKT_TX_TUNNEL_VXLAN:
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+		break;
+
+	case 0:
+		break;
+
+	default:
+		/* For non UDP/GRE tunneling, drop the tunnel packet. */
+		PMD_DRV_LOG(INFO, "not support tunnel pkt type");
+		return -EINVAL;
+	}
+
+	if (ol_flags & HINIC3_PKT_TX_OUTER_IP_CKSUM)
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L3_EN);
+
+	task->pkt_info0 = hinic3_hw_be32(task->pkt_info0);
+	task->pkt_info2 = hinic3_hw_be32(task->pkt_info2);
+	wqe_info->queue_info = queue_info;
+
+	return 0;
+}
+
+/**
+ * Check whether the number of segments in the mbuf is valid.
+ *
+ * @param[in] mbuf
+ * Point to the mbuf to be verified.
+ * @param[in] wqe_info
+ * Point to wqe_info of send queue(SQ).
+ * @return
+ * true as valid, false as invalid.
+ */
+static bool
+hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
+{
+	uint32_t total_len, limit_len, checked_len, left_len, adjust_mss;
+	uint32_t i, max_sges, left_sges, first_len;
+	struct rte_mbuf *mbuf_head, *mbuf_first;
+	struct rte_mbuf *mbuf_pre = mbuf;
+
+	left_sges = mbuf->nb_segs;
+	mbuf_head = mbuf;
+	mbuf_first = mbuf;
+
+	/* Tso sge number validation. */
+	if (unlikely(left_sges >= HINIC3_NONTSO_PKT_MAX_SGE)) {
+		checked_len = 0;
+		total_len = 0;
+		first_len = 0;
+		adjust_mss = mbuf->tso_segsz >= TX_MSS_MIN ? mbuf->tso_segsz
+							   : TX_MSS_MIN;
+		max_sges = HINIC3_NONTSO_PKT_MAX_SGE - 1;
+		limit_len = adjust_mss + wqe_info->payload_offset;
+
+		for (i = 0; (i < max_sges) && (total_len < limit_len); i++) {
+			total_len += mbuf->data_len;
+			mbuf_pre = mbuf;
+			mbuf = mbuf->next;
+		}
+
+		/* Each continues 38 mbufs segmust do one check. */
+		while (left_sges >= HINIC3_NONTSO_PKT_MAX_SGE) {
+			if (total_len >= limit_len) {
+				/* Update the limit len. */
+				limit_len = adjust_mss;
+				/* Update checked len. */
+				checked_len += first_len;
+				/* Record the first len. */
+				first_len = mbuf_first->data_len;
+				/* First mbuf move to the next. */
+				mbuf_first = mbuf_first->next;
+				/* Update total len. */
+				total_len -= first_len;
+				left_sges--;
+				i--;
+				for (;
+				     (i < max_sges) && (total_len < limit_len);
+				     i++) {
+					total_len += mbuf->data_len;
+					mbuf_pre = mbuf;
+					mbuf = mbuf->next;
+				}
+			} else {
+				/* Try to copy if not valid. */
+				checked_len += (total_len - mbuf_pre->data_len);
+
+				left_len = mbuf_head->pkt_len - checked_len;
+				if (left_len > HINIC3_COPY_MBUF_SIZE)
+					return false;
+				wqe_info->sge_cnt = (uint16_t)(mbuf_head->nb_segs +
+							  i - left_sges);
+				wqe_info->cpy_mbuf_cnt = 1;
+
+				return true;
+			}
+		} /**< End of while. */
+	}
+
+	wqe_info->sge_cnt = mbuf_head->nb_segs;
+
+	return true;
+}
+
+/**
+ * Checks and processes transport offload information for data packets.
+ *
+ * @param[in] mbuf
+ * Point to the mbuf to send.
+ * @param[in] wqe_info
+ * Point to wqe_info of send queue(SQ).
+ * @return
+ * 0 as success, -EINVAL as failure.
+ */
+static int
+hinic3_get_tx_offload(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
+{
+	uint64_t ol_flags = mbuf->ol_flags;
+	uint16_t i, total_len, inner_l3_offset = 0;
+	int err;
+	struct rte_mbuf *mbuf_pkt = NULL;
+
+	wqe_info->sge_cnt = mbuf->nb_segs;
+	/* Check if the packet set available offload flags. */
+	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {
+		wqe_info->offload = 0;
+		return 0;
+	}
+
+	wqe_info->offload = 1;
+	err = hinic3_tx_offload_pkt_prepare(mbuf, &inner_l3_offset);
+	if (err)
+		return err;
+
+	/* Non tso mbuf only check sge num. */
+	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG))) {
+		if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))
+			/* Non tso packet len must less than 64KB. */
+			return -EINVAL;
+
+		if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))
+			/* Valid non-tso mbuf. */
+			return 0;
+
+		/*
+		 * The number of non-tso packet fragments must be less than 38,
+		 * and mbuf segs greater than 38 must be copied to other
+		 * buffers.
+		 */
+		total_len = 0;
+		mbuf_pkt = mbuf;
+		for (i = 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {
+			total_len += mbuf_pkt->data_len;
+			mbuf_pkt = mbuf_pkt->next;
+		}
+
+		/* Default support copy total 4k mbuf segs. */
+		if ((uint32_t)(total_len + (uint16_t)HINIC3_COPY_MBUF_SIZE) <
+		    mbuf->pkt_len)
+			return -EINVAL;
+
+		wqe_info->sge_cnt = HINIC3_NONTSO_PKT_MAX_SGE;
+		wqe_info->cpy_mbuf_cnt = 1;
+
+		return 0;
+	}
+
+	/* Tso mbuf. */
+	wqe_info->payload_offset =
+		inner_l3_offset + mbuf->l3_len + mbuf->l4_len;
+
+	/* Too many mbuf segs. */
+	if (unlikely(HINIC3_TSO_SEG_NUM_INVALID(mbuf->nb_segs)))
+		return -EINVAL;
+
+	/* Check whether can cover all tso mbuf segs or not. */
+	if (unlikely(!hinic3_is_tso_sge_valid(mbuf, wqe_info)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void
+hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs, rte_iova_t addr,
+		    uint32_t len)
+{
+	buf_descs->hi_addr = hinic3_hw_be32(upper_32_bits(addr));
+	buf_descs->lo_addr = hinic3_hw_be32(lower_32_bits(addr));
+	buf_descs->len = hinic3_hw_be32(len);
+}
+
+static inline struct rte_mbuf *
+hinic3_alloc_cpy_mbuf(struct hinic3_nic_dev *nic_dev)
+{
+	return rte_pktmbuf_alloc(nic_dev->cpy_mpool);
+}
+
+/**
+ * Copy packets in the send queue(SQ).
+ *
+ * @param[in] nic_dev
+ * Point to nic device.
+ * @param[in] mbuf
+ * Point to the source mbuf.
+ * @param[in] seg_cnt
+ * Number of mbuf segments to be copied.
+ * @result
+ * The address of the copied mbuf.
+ */
+static void *
+hinic3_copy_tx_mbuf(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
+		    uint16_t sge_cnt)
+{
+	struct rte_mbuf *dst_mbuf;
+	uint32_t offset = 0;
+	uint16_t i;
+
+	if (unlikely(!nic_dev->cpy_mpool))
+		return NULL;
+
+	dst_mbuf = hinic3_alloc_cpy_mbuf(nic_dev);
+	if (unlikely(!dst_mbuf))
+		return NULL;
+
+	dst_mbuf->data_off = 0;
+	dst_mbuf->data_len = 0;
+	for (i = 0; i < sge_cnt; i++) {
+		rte_memcpy((uint8_t *)dst_mbuf->buf_addr + offset,
+			   (uint8_t *)mbuf->buf_addr + mbuf->data_off,
+			   mbuf->data_len);
+		dst_mbuf->data_len += mbuf->data_len;
+		offset += mbuf->data_len;
+		mbuf = mbuf->next;
+	}
+	dst_mbuf->pkt_len = dst_mbuf->data_len;
+
+	return dst_mbuf;
+}
+
+/**
+ * Map the TX mbuf to the DMA address space and set related information for
+ * subsequent DMA transmission.
+ *
+ * @param[in] txq
+ * Point to send queue.
+ * @param[in] mbuf
+ * Point to the tx mbuf.
+ * @param[out] wqe_combo
+ * Point to send queue wqe_combo.
+ * @param[in] wqe_info
+ * Point to wqe_info of send queue(SQ).
+ * @result
+ * 0 as success, -EINVAL as failure.
+ */
+static int
+hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
+			struct hinic3_sq_wqe_combo *wqe_combo,
+			struct hinic3_wqe_info *wqe_info)
+{
+	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
+	struct hinic3_sq_bufdesc *buf_desc = wqe_combo->bds_head;
+
+	uint16_t nb_segs = wqe_info->sge_cnt - wqe_info->cpy_mbuf_cnt;
+	uint16_t real_segs = mbuf->nb_segs;
+	rte_iova_t dma_addr;
+	uint32_t i;
+
+	for (i = 0; i < nb_segs; i++) {
+		if (unlikely(mbuf == NULL)) {
+			txq->txq_stats.mbuf_null++;
+			return -EINVAL;
+		}
+
+		if (unlikely(mbuf->data_len == 0)) {
+			txq->txq_stats.sge_len0++;
+			return -EINVAL;
+		}
+
+		dma_addr = rte_mbuf_data_iova(mbuf);
+		if (i == 0) {
+			if (wqe_combo->wqe_type == SQ_WQE_COMPACT_TYPE &&
+			    mbuf->data_len > COMPACT_WQE_MAX_CTRL_LEN) {
+				txq->txq_stats.sge_len_too_large++;
+				return -EINVAL;
+			}
+
+			wqe_desc->hi_addr =
+				hinic3_hw_be32(upper_32_bits(dma_addr));
+			wqe_desc->lo_addr =
+				hinic3_hw_be32(lower_32_bits(dma_addr));
+			wqe_desc->ctrl_len = mbuf->data_len;
+		} else {
+			/*
+			 * Parts of wqe is in sq bottom while parts
+			 * of wqe is in sq head.
+			 */
+			if (unlikely(wqe_info->wrapped &&
+				     (uint64_t)buf_desc == txq->sq_bot_sge_addr))
+				buf_desc = (struct hinic3_sq_bufdesc *)
+					   (void *)txq->sq_head_addr;
+
+			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);
+			buf_desc++;
+		}
+		mbuf = mbuf->next;
+	}
+
+	/* For now: support over 38 sge, copy the last 2 mbuf. */
+	if (unlikely(wqe_info->cpy_mbuf_cnt != 0)) {
+		/*
+		 * Copy invalid mbuf segs to a valid buffer, lost performance.
+		 */
+		txq->txq_stats.cpy_pkts += 1;
+		mbuf = hinic3_copy_tx_mbuf(txq->nic_dev, mbuf,
+					   real_segs - nb_segs);
+		if (unlikely(!mbuf))
+			return -EINVAL;
+
+		txq->tx_info[wqe_info->pi].cpy_mbuf = mbuf;
+
+		/* Deal with the last mbuf. */
+		dma_addr = rte_mbuf_data_iova(mbuf);
+		if (unlikely(mbuf->data_len == 0)) {
+			txq->txq_stats.sge_len0++;
+			return -EINVAL;
+		}
+		/*
+		 * Parts of wqe is in sq bottom while parts
+		 * of wqe is in sq head.
+		 */
+		if (i == 0) {
+			wqe_desc->hi_addr =
+				hinic3_hw_be32(upper_32_bits(dma_addr));
+			wqe_desc->lo_addr =
+				hinic3_hw_be32(lower_32_bits(dma_addr));
+			wqe_desc->ctrl_len = mbuf->data_len;
+		} else {
+			if (unlikely(wqe_info->wrapped &&
+				     ((uint64_t)buf_desc == txq->sq_bot_sge_addr)))
+				buf_desc = (struct hinic3_sq_bufdesc *)
+						   txq->sq_head_addr;
+
+			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * Sets and configures fields in the transmit queue control descriptor based on
+ * the WQE type.
+ *
+ * @param[out] wqe_combo
+ * Point to wqe_combo of send queue.
+ * @param[in] wqe_info
+ * Point to wqe_info of send queue.
+ */
+static void
+hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
+		       struct hinic3_wqe_info *wqe_info)
+{
+	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
+
+	if (wqe_combo->wqe_type == SQ_WQE_COMPACT_TYPE) {
+		wqe_desc->ctrl_len |=
+			SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+			SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+			SQ_CTRL_SET(wqe_info->owner, OWNER);
+		wqe_desc->ctrl_len = hinic3_hw_be32(wqe_desc->ctrl_len);
+
+		/* Compact wqe queue_info will transfer to ucode. */
+		wqe_desc->queue_info = 0;
+
+		return;
+	}
+
+	wqe_desc->ctrl_len |= SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |
+			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
+			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+			      SQ_CTRL_SET(wqe_info->owner, OWNER);
+
+	wqe_desc->ctrl_len = hinic3_hw_be32(wqe_desc->ctrl_len);
+
+	wqe_desc->queue_info = wqe_info->queue_info;
+	wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, UC);
+
+	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {
+		wqe_desc->queue_info |=
+			SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);
+	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <
+		   TX_MSS_MIN) {
+		/* Mss should not less than 80. */
+		wqe_desc->queue_info =
+			SQ_CTRL_QUEUE_INFO_CLEAR(wqe_desc->queue_info, MSS);
+		wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);
+	}
+
+	wqe_desc->queue_info = hinic3_hw_be32(wqe_desc->queue_info);
+}
+
+/**
+ * It is responsible for sending data packets.
+ *
+ * @param[in] tx_queue
+ * Point to send queue.
+ * @param[in] tx_pkts
+ * Pointer to the array of data packets to be sent.
+ * @param[in] nb_pkts
+ * Number of sent packets.
+ * @return
+ * Number of actually sent packets.
+ */
+uint16_t
+hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct hinic3_txq *txq = tx_queue;
+	struct hinic3_tx_info *tx_info = NULL;
+	struct rte_mbuf *mbuf_pkt = NULL;
+	struct hinic3_sq_wqe_combo wqe_combo = {0};
+	struct hinic3_sq_wqe *sq_wqe = NULL;
+	struct hinic3_wqe_info wqe_info = {0};
+
+	uint32_t offload_err, free_cnt;
+	uint64_t tx_bytes = 0;
+	uint16_t free_wqebb_cnt, nb_tx;
+	int err;
+
+#ifdef HINIC3_XSTAT_PROF_TX
+	uint64_t t1, t2;
+	t1 = rte_get_tsc_cycles();
+#endif
+
+	if (unlikely(!HINIC3_TXQ_IS_STARTED(txq)))
+		return 0;
+
+	free_cnt = txq->tx_free_thresh;
+	/* Reclaim tx mbuf before xmit new packets. */
+	if (hinic3_get_sq_free_wqebbs(txq) < txq->tx_free_thresh)
+		hinic3_xmit_mbuf_cleanup(txq, free_cnt);
+
+	/* Tx loop routine. */
+	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		mbuf_pkt = *tx_pkts++;
+		if (unlikely(hinic3_get_tx_offload(mbuf_pkt, &wqe_info))) {
+			txq->txq_stats.offload_errors++;
+			break;
+		}
+
+		if (!wqe_info.offload)
+			wqe_info.wqebb_cnt = wqe_info.sge_cnt;
+		else
+			/* Use extended sq wqe with normal TS. */
+			wqe_info.wqebb_cnt = wqe_info.sge_cnt + 1;
+
+		free_wqebb_cnt = hinic3_get_sq_free_wqebbs(txq);
+		if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {
+			/* Reclaim again. */
+			hinic3_xmit_mbuf_cleanup(txq, free_cnt);
+			free_wqebb_cnt = hinic3_get_sq_free_wqebbs(txq);
+			if (unlikely(wqe_info.wqebb_cnt > free_wqebb_cnt)) {
+				txq->txq_stats.tx_busy += (nb_pkts - nb_tx);
+				break;
+			}
+		}
+
+		/* Get sq wqe address from wqe_page. */
+		sq_wqe = hinic3_get_sq_wqe(txq, &wqe_info);
+		if (unlikely(!sq_wqe)) {
+			txq->txq_stats.tx_busy++;
+			break;
+		}
+
+		/* Task or bd section maybe wrapped for one wqe. */
+		hinic3_set_wqe_combo(txq, &wqe_combo, sq_wqe, &wqe_info);
+
+		wqe_info.queue_info = 0;
+		/* Fill tx packet offload into qsf and task field. */
+		if (wqe_info.offload) {
+			offload_err = hinic3_set_tx_offload(mbuf_pkt,
+							    wqe_combo.task,
+							    &wqe_info);
+			if (unlikely(offload_err)) {
+				hinic3_put_sq_wqe(txq, &wqe_info);
+				txq->txq_stats.offload_errors++;
+				break;
+			}
+		}
+
+		/* Fill sq_wqe buf_desc and bd_desc. */
+		err = hinic3_mbuf_dma_map_sge(txq, mbuf_pkt, &wqe_combo,
+					      &wqe_info);
+		if (err) {
+			hinic3_put_sq_wqe(txq, &wqe_info);
+			txq->txq_stats.offload_errors++;
+			break;
+		}
+
+		/* Record tx info. */
+		tx_info = &txq->tx_info[wqe_info.pi];
+		tx_info->mbuf = mbuf_pkt;
+		tx_info->wqebb_cnt = wqe_info.wqebb_cnt;
+
+		hinic3_prepare_sq_ctrl(&wqe_combo, &wqe_info);
+
+		tx_bytes += mbuf_pkt->pkt_len;
+	}
+
+	/* Update txq stats. */
+	if (nb_tx) {
+		hinic3_write_db(txq->db_addr, txq->q_id, (int)(txq->cos),
+				SQ_CFLAG_DP,
+				MASKED_QUEUE_IDX(txq, txq->prod_idx));
+		txq->txq_stats.packets += nb_tx;
+		txq->txq_stats.bytes += tx_bytes;
+	}
+	txq->txq_stats.burst_pkts = nb_tx;
+
+#ifdef HINIC3_XSTAT_PROF_TX
+	t2 = rte_get_tsc_cycles();
+	txq->txq_stats.app_tsc = t1 - txq->prof_tx_end_tsc;
+	txq->prof_tx_end_tsc = t2;
+	txq->txq_stats.pmd_tsc = t2 - t1;
+	txq->txq_stats.burst_pkts = nb_tx;
+#endif
+
+	return nb_tx;
+}
+
 int
 hinic3_stop_sq(struct hinic3_txq *txq)
 {
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index fcf07ece79..21b61dbb75 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -306,6 +306,7 @@ struct __rte_cache_aligned hinic3_txq {
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);
+uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
-- 
2.47.0.windows.2


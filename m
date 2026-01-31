Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EABD79769
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 10:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A38F340649;
	Sat, 31 Jan 2026 11:06:52 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id E6DD1402E9
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:06:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=CIRQGdzQQGVP+HbYYRP0foz2O3XHCVDgIlPCpAnwstA=;
 b=DM0Se/65Y8gTL7RqCbu4hjMqdDocccbhUP4k7AeGS4z3MaAJ1fJff1clceOIHp
 3YwME2y20kb44nMwNQ/K76BMwaaxN7vt1XGeS1UKm1dPptUeolv6dlRIpbTK4Wfw
 5gI5gPPzMc0XxGrgnxCPVeTKs7GDqteZCiVdY9pmCanHU=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAndJof1H1pOVL+BQ--.9138S8;
 Sat, 31 Jan 2026 18:06:44 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH 4/7] net/hinic3: add fun init ops to support Compact CQE
Date: Sat, 31 Jan 2026 18:06:00 +0800
Message-ID: <20260131100608.12429-5-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260131100608.12429-1-wff_light@vip.163.com>
References: <20260131100608.12429-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAndJof1H1pOVL+BQ--.9138S8
X-Coremail-Antispam: 1Uf129KBjvAXoWDArW8CF1rCF18Gw45Xr17trb_yoWrKr4DAo
 W3tr1aqw1fJr1IkFWqgan7WayDAwn5Z3Z8J39xW3s2qFy7WryjkasxAw1rXa4Fg395tF13
 AF9xKFnrJ3yjy398n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrD73DUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxT7Bml91DRIaQAA3L
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

For new SPx NIC, use compact CQE to achieve better performance.
In this mode, CQE is uploaded together with packet.

When doing fun init, replace CQE's dma memory mapping with CI index,
hinic3 driver will loop CI to check if packet arrive.

 Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 214 +++++++++---
 drivers/net/hinic3/hinic3_ethdev.h | 131 +++++---
 drivers/net/hinic3/hinic3_nic_io.c | 507 +++++++++++++----------------
 drivers/net/hinic3/hinic3_nic_io.h |  25 ++
 4 files changed, 496 insertions(+), 381 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index ecdfcd5654..f2dd414ce7 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -32,7 +32,7 @@
 #define HINIC3_DEFAULT_RX_FREE_THRESH 32u
 #define HINIC3_DEFAULT_TX_FREE_THRESH 32u
 
-#define HINIC3_RX_WAIT_CYCLE_THRESH 500
+#define HINIC3_RX_WAIT_CYCLE_THRESH 150
 
 /**
  * Get the 32-bit VFTA bit mask for the lower 5 bits of the VLAN ID.
@@ -431,8 +431,10 @@ hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev)
 static int
 hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 {
+	struct hinic3_nic_dev *nic_dev = (struct hinic3_nic_dev*)hwdev->dev_handle;
 	uint8_t default_cos = 0;
 	uint8_t valid_cos_bitmap;
+	uint8_t cos_num_max;
 	uint8_t i;
 
 	valid_cos_bitmap = hwdev->cfg_mgmt->svc_cap.cos_valid_bitmap;
@@ -441,7 +443,12 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 		return -EFAULT;
 	}
 
-	for (i = 0; i < HINIC3_COS_NUM_MAX; i++) {
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
+		cos_num_max = HINIC3_COS_NUM_MAX;
+	else
+		cos_num_max = HINIC3_COS_NUM_MAX_HTN;
+
+	for (i = 0; i < cos_num_max; i++) {
 		if (valid_cos_bitmap & RTE_BIT32(i))
 			/* Find max cos id as default cos. */
 			default_cos = i;
@@ -632,6 +639,26 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 	nic_dev->num_sqs = dev->data->nb_tx_queues;
 	nic_dev->num_rqs = dev->data->nb_rx_queues;
 
+
+	if (nic_dev->num_sqs > nic_dev->max_sqs ||
+		nic_dev->num_rqs > nic_dev->max_rqs) {
+		PMD_DRV_LOG(ERR, "num_sqs: %d or num_rqs: %d larger than max_sqs: %d or max_rqs: %d",
+			    nic_dev->num_sqs, nic_dev->num_rqs,
+			    nic_dev->max_sqs, nic_dev->max_rqs);
+		return -EINVAL;
+	}
+
+	/* The range of mtu is 384~9600 */
+	if (HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) < HINIC3_MIN_FRAME_SIZE ||
+	    HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) >
+	    HINIC3_MAX_JUMBO_FRAME_SIZE) {
+		PMD_DRV_LOG(ERR, "Max rx pkt len out of range, max_rx_pkt_len: %d, "
+			    "expect between %d and %d",
+			    HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode),
+			    HINIC3_MIN_FRAME_SIZE, HINIC3_MAX_JUMBO_FRAME_SIZE);
+		return -EINVAL;
+	}
+
 	nic_dev->mtu_size =
 		(uint16_t)HINIC3_PKTLEN_TO_MTU(HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode));
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
@@ -644,6 +671,16 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static void
+hinic3_dev_tnl_tso_support(struct rte_eth_dev_info *info, struct hinic3_nic_dev *nic_dev) {
+	if (HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev)) {
+		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+	}
+	if (HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev)) {
+		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO;
+	}
+}
+
 /**
  * Get information about the device.
  *
@@ -685,6 +722,8 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
+	hinic3_dev_tnl_tso_support(info, nic_dev);
+
 	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
 	info->reta_size = HINIC3_RSS_INDIR_SIZE;
 	info->flow_type_rss_offloads = HINIC3_RSS_OFFLOAD_ALL;
@@ -926,16 +965,25 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	struct hinic3_rxq *rxq = NULL;
 	const struct rte_memzone *rq_mz = NULL;
 	const struct rte_memzone *cqe_mz = NULL;
+	const struct rte_memzone *ci_mz = NULL;
 	const struct rte_memzone *pi_mz = NULL;
 	uint16_t rq_depth, rx_free_thresh;
 	uint32_t queue_buf_size;
 	void *db_addr = NULL;
 	int wqe_count;
 	uint32_t buf_size;
+	uint32_t rx_buf_size;
 	int err;
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 
+	/* Queue depth must be equal to queue 0 */
+	if (qid != 0 && (nb_desc != nic_dev->rxqs[0]->q_depth)) {
+		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to queue0 depth:%u.\n",
+			    qid, nb_desc, nic_dev->rxqs[0]->q_depth);
+		nb_desc = nic_dev->rxqs[0]->q_depth;
+	}
+
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
 	rq_depth = (nb_desc & (nb_desc - 1))
 			? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
@@ -988,17 +1036,19 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	nic_dev->rxqs[qid] = rxq;
 	rxq->mb_pool = mp;
 	rxq->q_id = qid;
+	rxq->next_to_update = 0;
 	rxq->q_depth = rq_depth;
 	rxq->q_mask = rq_depth - 1;
 	rxq->delta = rq_depth;
+	rxq->cons_idx = 0;
+	rxq->prod_idx = 0;
 	rxq->rx_free_thresh = rx_free_thresh;
 	rxq->rxinfo_align_end = rxq->q_depth - rxq->rx_free_thresh;
 	rxq->port_id = dev->data->port_id;
 	rxq->wait_time_cycle = HINIC3_RX_WAIT_CYCLE_THRESH;
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	/* If buf_len used for function table, need to translated. */
-	uint16_t rx_buf_size =
-		rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
+	rx_buf_size = rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
 	err = hinic3_convert_rx_buf_size(rx_buf_size, &buf_size);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Adjust buf size failed, dev_name: %s",
@@ -1006,11 +1056,17 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto adjust_bufsize_fail;
 	}
 
-	if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
-	    buf_size < HINIC3_RX_BUF_SIZE_16K)
-		rxq->wqe_type = HINIC3_EXTEND_RQ_WQE;
-	else
-		rxq->wqe_type = HINIC3_NORMAL_RQ_WQE;
+	/* If NIC support compact CQE, use compact wqe as default. */
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+
+		rxq->wqe_type = HINIC3_COMPACT_RQ_WQE;
+	} else {
+		if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
+			buf_size < HINIC3_RX_BUF_SIZE_16K)
+			rxq->wqe_type = HINIC3_EXTEND_RQ_WQE;
+		else
+			rxq->wqe_type = HINIC3_NORMAL_RQ_WQE;
+	}
 
 	rxq->wqebb_shift = HINIC3_RQ_WQEBB_SHIFT + rxq->wqe_type;
 	rxq->wqebb_size = (uint16_t)RTE_BIT32(rxq->wqebb_shift);
@@ -1062,36 +1118,52 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto alloc_rx_info_fail;
 	}
 
-	cqe_mz = hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,
-					 rq_depth * sizeof(*rxq->rx_cqe),
-					 RTE_CACHE_LINE_SIZE, socket_id);
-	if (!cqe_mz) {
-		PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed, dev_name: %s",
-			    dev->data->name);
-		err = -ENOMEM;
-		goto alloc_cqe_mz_fail;
-	}
-	memset(cqe_mz->addr, 0, rq_depth * sizeof(*rxq->rx_cqe));
-	rxq->cqe_mz = cqe_mz;
-	rxq->cqe_start_paddr = cqe_mz->iova;
-	rxq->cqe_start_vaddr = cqe_mz->addr;
-	rxq->rx_cqe = (struct hinic3_rq_cqe *)rxq->cqe_start_vaddr;
-
-	wqe_count = hinic3_rx_fill_wqe(rxq);
-	if (wqe_count != rq_depth) {
-		PMD_DRV_LOG(ERR, "Fill rx wqe failed, wqe_count: %d, dev_name: %s",
-				wqe_count, dev->data->name);
-		err = -ENOMEM;
-		goto fill_rx_wqe_fail;
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+		ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_ci_mz", qid,
+						sizeof(*rxq->rq_ci),
+						RTE_CACHE_LINE_SIZE, (int)socket_id);
+
+		if (!ci_mz) {
+			PMD_DRV_LOG(ERR, "Allocate ci mem zone failed, dev_name: %s", dev->data->name);
+			err = -ENOMEM;
+			hinic3_memzone_free(ci_mz);
+			goto alloc_cqe_ci_mz_fail;
+		}
+
+		memset(ci_mz->addr, 0, sizeof(*rxq->rq_ci));
+		rxq->ci_mz = ci_mz;
+		rxq->rq_ci = (struct hinic3_rq_ci_wb *)ci_mz->addr;
+		rxq->rq_ci_paddr = ci_mz->iova;
+	} else {
+		cqe_mz = hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,
+										rq_depth * sizeof(*rxq->rx_cqe),
+										RTE_CACHE_LINE_SIZE, socket_id);
+		if (!cqe_mz) {
+			PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed, dev_name: %s",
+			dev->data->name);
+			err = -ENOMEM;
+			goto alloc_cqe_ci_mz_fail;
+		}
+		memset(cqe_mz->addr, 0, rq_depth * sizeof(*rxq->rx_cqe));
+		rxq->cqe_mz = cqe_mz;
+		rxq->cqe_start_paddr = cqe_mz->iova;
+		rxq->cqe_start_vaddr = cqe_mz->addr;
+		rxq->rx_cqe = (struct hinic3_rq_cqe *)rxq->cqe_start_vaddr;
+
+		wqe_count = hinic3_rx_fill_wqe(rxq);
+		if (wqe_count != rq_depth) {
+			PMD_DRV_LOG(ERR, "Fill rx wqe failed, wqe_count: %d, dev_name: %s",
+					wqe_count, dev->data->name);
+			err = -ENOMEM;
+			hinic3_memzone_free(cqe_mz);
+			goto alloc_cqe_ci_mz_fail;
+		}
 	}
-	/* Record rxq pointer in rte_eth rx_queues. */
 	dev->data->rx_queues[qid] = rxq;
 
 	return 0;
 
-fill_rx_wqe_fail:
-	hinic3_memzone_free(rxq->cqe_mz);
-alloc_cqe_mz_fail:
+alloc_cqe_ci_mz_fail:
 	rte_free(rxq->rx_info);
 
 alloc_rx_info_fail:
@@ -1193,12 +1265,15 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	txq->q_id = qid;
 	txq->q_depth = sq_depth;
 	txq->q_mask = sq_depth - 1;
+	txq->cons_idx = 0;
+	txq->prod_idx = 0;
 	txq->wqebb_shift = HINIC3_SQ_WQEBB_SHIFT;
 	txq->wqebb_size = (uint16_t)RTE_BIT32(txq->wqebb_shift);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->owner = 1;
 	txq->cos = nic_dev->default_cos;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+	txq->tx_wqe_compact_task = HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);
 
 	ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,
 					HINIC3_CI_Q_ADDR_SIZE,
@@ -1246,7 +1321,6 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto alloc_tx_info_fail;
 	}
 
-	/* Record txq pointer in rte_eth tx_queues. */
 	dev->data->tx_queues[qid] = txq;
 
 	return 0;
@@ -1274,7 +1348,10 @@ hinic3_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	hinic3_free_rxq_mbufs(rxq);
 
-	hinic3_memzone_free(rxq->cqe_mz);
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev))
+		hinic3_memzone_free(rxq->ci_mz);
+	else
+		hinic3_memzone_free(rxq->cqe_mz);
 
 	rte_free(rxq->rx_info);
 	rxq->rx_info = NULL;
@@ -1323,24 +1400,31 @@ hinic3_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rq_id)
 {
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_rxq *rxq = dev->data->rx_queues[rq_id];
 	int rc;
 
+	rxq = dev->data->rx_queues[rq_id];
+
 	rc = hinic3_start_rq(dev, rxq);
 	if (rc) {
 		PMD_DRV_LOG(ERR,
-			    "Start rx queue failed, eth_dev:%s, queue_idx:%d",
-			    dev->data->name, rq_id);
+				"Start rx queue failed, eth_dev:%s, queue_idx:%d",
+				dev->data->name, rq_id);
 		return rc;
 	}
-	dev->data->rx_queue_state[rq_id] = RTE_ETH_QUEUE_STATE_STARTED;
 
-	rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, true);
-	if (rc) {
-		PMD_DRV_LOG(ERR, "Failed to enable rq : %d fdir filter.",
-			    rq_id);
-		return rc;
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) == 0) {
+		rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, true);
+		if (rc) {
+			PMD_DRV_LOG(ERR, "Failed to enable rq : %d fdir filter.",
+				rq_id);
+			return rc;
+		}
 	}
+
+	dev->data->rx_queue_state[rq_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
 	return 0;
 }
 
@@ -1358,21 +1442,24 @@ hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rq_id)
 static int
 hinic3_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rq_id)
 {
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_rxq *rxq = dev->data->rx_queues[rq_id];
 	int rc;
 
-	rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, false);
+	rc = hinic3_stop_rq(dev, rxq);
 	if (rc) {
 		PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.", rq_id);
 		return rc;
 	}
-	rc = hinic3_stop_rq(dev, rxq);
-	if (rc) {
-		PMD_DRV_LOG(ERR,
-			    "Stop rx queue failed, eth_dev:%s, queue_idx:%d",
-			    dev->data->name, rq_id);
-		return rc;
+
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) == 0) {
+		rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, false);
+		if (rc) {
+			PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.", rq_id);
+			return rc;
+		}
 	}
+
 	dev->data->rx_queue_state[rq_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
 	return 0;
@@ -1388,6 +1475,7 @@ hinic3_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t sq_id)
 
 	HINIC3_SET_TXQ_STARTED(txq);
 	dev->data->tx_queue_state[sq_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
 	return 0;
 }
 
@@ -1404,6 +1492,7 @@ hinic3_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t sq_id)
 			    dev->data->name, sq_id);
 		return rc;
 	}
+
 	HINIC3_SET_TXQ_STOPPED(txq);
 	dev->data->tx_queue_state[sq_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -3290,6 +3379,24 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 };
 
+static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)
+{
+	if (HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev))
+		nic_dev->tx_rx_ops.nic_tx_set_wqe_offload = hinic3_tx_set_compact_task_offload;
+	else
+		nic_dev->tx_rx_ops.nic_tx_set_wqe_offload = hinic3_tx_set_normal_task_offload;
+
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+		nic_dev->tx_rx_ops.nic_rx_get_cqe_info = hinic3_rx_get_compact_cqe_info;
+		nic_dev->tx_rx_ops.nic_rx_cqe_done = rx_integrated_cqe_done;
+		nic_dev->tx_rx_ops.nic_rx_poll_rq_empty = hinic3_poll_integrated_cqe_rq_empty;
+	} else {
+		nic_dev->tx_rx_ops.nic_rx_get_cqe_info = hinic3_rx_get_cqe_info;
+		nic_dev->tx_rx_ops.nic_rx_cqe_done = rx_separate_cqe_done;
+		nic_dev->tx_rx_ops.nic_rx_poll_rq_empty = hinic3_poll_rq_empty;
+	}
+}
+
 /**
  * Initialize the network function, including hardware configuration, memory
  * allocation for data structures, MAC address setup, and interrupt enabling.
@@ -3303,6 +3410,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
  * 0 on success, non-zero on failure.
  */
 static int
+
 hinic3_func_init(struct rte_eth_dev *eth_dev)
 {
 	struct hinic3_tcam_info *tcam_info = NULL;
@@ -3391,9 +3499,9 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	}
 
 	if (!(nic_dev->feature_cap & NIC_F_HTN_CMDQ))
-		nic_dev->cmdq_ops = hinic3_cmdq_get_stn_ops();
+		nic_dev->cmdq_ops = hinic3_nic_cmdq_get_stn_ops();
 	else
-		nic_dev->cmdq_ops = hinic3_cmdq_get_htn_ops();
+		nic_dev->cmdq_ops = hinic3_nic_cmdq_get_htn_ops();
 
 	err = hinic3_init_sw_rxtxqs(nic_dev);
 	if (err) {
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 4a5dbb0844..896f015341 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -10,48 +10,46 @@
 
 #include "hinic3_fdir.h"
 
-#define HINIC3_PMD_DRV_VERSION "B106"
-
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)
 
-#define HINIC3_PKT_RX_L4_CKSUM_BAD     RTE_MBUF_F_RX_L4_CKSUM_BAD
-#define HINIC3_PKT_RX_IP_CKSUM_BAD     RTE_MBUF_F_RX_IP_CKSUM_BAD
-#define HINIC3_PKT_RX_IP_CKSUM_UNKNOWN RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN
-#define HINIC3_PKT_RX_L4_CKSUM_GOOD    RTE_MBUF_F_RX_L4_CKSUM_GOOD
-#define HINIC3_PKT_RX_IP_CKSUM_GOOD    RTE_MBUF_F_RX_IP_CKSUM_GOOD
-#define HINIC3_PKT_TX_TCP_SEG	       RTE_MBUF_F_TX_TCP_SEG
-#define HINIC3_PKT_TX_UDP_CKSUM	       RTE_MBUF_F_TX_UDP_CKSUM
-#define HINIC3_PKT_TX_TCP_CKSUM	       RTE_MBUF_F_TX_TCP_CKSUM
-#define HINIC3_PKT_TX_IP_CKSUM	       RTE_MBUF_F_TX_IP_CKSUM
-#define HINIC3_PKT_TX_VLAN_PKT	       RTE_MBUF_F_TX_VLAN
-#define HINIC3_PKT_TX_L4_MASK	       RTE_MBUF_F_TX_L4_MASK
-#define HINIC3_PKT_TX_SCTP_CKSUM       RTE_MBUF_F_TX_SCTP_CKSUM
-#define HINIC3_PKT_TX_IPV6	       RTE_MBUF_F_TX_IPV6
-#define HINIC3_PKT_TX_IPV4	       RTE_MBUF_F_TX_IPV4
-#define HINIC3_PKT_RX_VLAN	       RTE_MBUF_F_RX_VLAN
-#define HINIC3_PKT_RX_VLAN_STRIPPED    RTE_MBUF_F_RX_VLAN_STRIPPED
-#define HINIC3_PKT_RX_RSS_HASH	       RTE_MBUF_F_RX_RSS_HASH
-#define HINIC3_PKT_TX_TUNNEL_MASK      RTE_MBUF_F_TX_TUNNEL_MASK
-#define HINIC3_PKT_TX_TUNNEL_VXLAN     RTE_MBUF_F_TX_TUNNEL_VXLAN
-#define HINIC3_PKT_TX_OUTER_IP_CKSUM   RTE_MBUF_F_TX_OUTER_IP_CKSUM
-#define HINIC3_PKT_TX_OUTER_IPV6       RTE_MBUF_F_TX_OUTER_IPV6
-#define HINIC3_PKT_RX_LRO	       RTE_MBUF_F_RX_LRO
-#define HINIC3_PKT_TX_L4_NO_CKSUM      RTE_MBUF_F_TX_L4_NO_CKSUM
+#define HINIC3_PKT_RX_L4_CKSUM_BAD		RTE_MBUF_F_RX_L4_CKSUM_BAD
+#define HINIC3_PKT_RX_IP_CKSUM_BAD		RTE_MBUF_F_RX_IP_CKSUM_BAD
+#define HINIC3_PKT_RX_IP_CKSUM_UNKNOWN	RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN
+#define HINIC3_PKT_RX_L4_CKSUM_GOOD		RTE_MBUF_F_RX_L4_CKSUM_GOOD
+#define HINIC3_PKT_RX_IP_CKSUM_GOOD		RTE_MBUF_F_RX_IP_CKSUM_GOOD
+#define HINIC3_PKT_TX_TCP_SEG			RTE_MBUF_F_TX_TCP_SEG
+#define HINIC3_PKT_TX_UDP_CKSUM			RTE_MBUF_F_TX_UDP_CKSUM
+#define HINIC3_PKT_TX_TCP_CKSUM			RTE_MBUF_F_TX_TCP_CKSUM
+#define HINIC3_PKT_TX_IP_CKSUM			RTE_MBUF_F_TX_IP_CKSUM
+#define HINIC3_PKT_TX_VLAN_PKT			RTE_MBUF_F_TX_VLAN
+#define HINIC3_PKT_TX_L4_MASK			RTE_MBUF_F_TX_L4_MASK
+#define HINIC3_PKT_TX_SCTP_CKSUM		RTE_MBUF_F_TX_SCTP_CKSUM
+#define HINIC3_PKT_TX_IPV6				RTE_MBUF_F_TX_IPV6
+#define HINIC3_PKT_TX_IPV4				RTE_MBUF_F_TX_IPV4
+#define HINIC3_PKT_RX_VLAN				RTE_MBUF_F_RX_VLAN
+#define HINIC3_PKT_RX_VLAN_STRIPPED		RTE_MBUF_F_RX_VLAN_STRIPPED
+#define HINIC3_PKT_RX_RSS_HASH			RTE_MBUF_F_RX_RSS_HASH
+#define HINIC3_PKT_TX_TUNNEL_MASK		RTE_MBUF_F_TX_TUNNEL_MASK
+#define HINIC3_PKT_TX_TUNNEL_VXLAN		RTE_MBUF_F_TX_TUNNEL_VXLAN
+#define HINIC3_PKT_TX_OUTER_IP_CKSUM	RTE_MBUF_F_TX_OUTER_IP_CKSUM
+#define HINIC3_PKT_TX_OUTER_IPV6		RTE_MBUF_F_TX_OUTER_IPV6
+#define HINIC3_PKT_RX_LRO				RTE_MBUF_F_RX_LRO
+#define HINIC3_PKT_TX_L4_NO_CKSUM		RTE_MBUF_F_TX_L4_NO_CKSUM
 
 #define HINCI3_CPY_MEMPOOL_NAME "cpy_mempool"
 /* Mbuf pool for copy invalid mbuf segs. */
-#define HINIC3_COPY_MEMPOOL_DEPTH 1024
-#define HINIC3_COPY_MEMPOOL_CACHE 128
-#define HINIC3_COPY_MBUF_SIZE	  4096
+#define HINIC3_COPY_MEMPOOL_DEPTH	1024
+#define HINIC3_COPY_MEMPOOL_CACHE	128
+#define HINIC3_COPY_MBUF_SIZE		4096
 
-#define HINIC3_DEV_NAME_LEN 32
-#define DEV_STOP_DELAY_MS   100
-#define DEV_START_DELAY_MS  100
-#define HINIC3_FLUSH_QUEUE_TIMEOUT 3000
+#define HINIC3_DEV_NAME_LEN			32
+#define DEV_STOP_DELAY_MS			100
+#define DEV_START_DELAY_MS			100
+#define HINIC3_FLUSH_QUEUE_TIMEOUT	3000
 
-#define HINIC3_UINT32_BIT_SIZE (CHAR_BIT * sizeof(uint32_t))
-#define HINIC3_VFTA_SIZE       (4096 / HINIC3_UINT32_BIT_SIZE)
-#define HINIC3_MAX_QUEUE_NUM   64
+#define HINIC3_UINT32_BIT_SIZE		(CHAR_BIT * sizeof(uint32_t))
+#define HINIC3_VFTA_SIZE			(4096 / HINIC3_UINT32_BIT_SIZE)
+#define HINIC3_MAX_QUEUE_NUM		256
 
 #define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \
 	((struct hinic3_nic_dev *)(dev)->data->dev_private)
@@ -68,27 +66,58 @@ enum hinic3_tx_cvlan_type {
 };
 
 enum nic_feature_cap {
-	NIC_F_CSUM		= RTE_BIT32(0),
-	NIC_F_SCTP_CRC		= RTE_BIT32(1),
-	NIC_F_TSO		= RTE_BIT32(2),
-	NIC_F_LRO		= RTE_BIT32(3),
-	NIC_F_UFO		= RTE_BIT32(4),
-	NIC_F_RSS		= RTE_BIT32(5),
-	NIC_F_RX_VLAN_FILTER	= RTE_BIT32(6),
-	NIC_F_RX_VLAN_STRIP	= RTE_BIT32(7),
-	NIC_F_TX_VLAN_INSERT	= RTE_BIT32(8),
-	NIC_F_VXLAN_OFFLOAD	= RTE_BIT32(9),
-	NIC_F_IPSEC_OFFLOAD	= RTE_BIT32(10),
-	NIC_F_FDIR		= RTE_BIT32(11),
-	NIC_F_PROMISC		= RTE_BIT32(12),
-	NIC_F_ALLMULTI		= RTE_BIT32(13),
+	NIC_F_CSUM					= RTE_BIT32(0),
+	NIC_F_SCTP_CRC				= RTE_BIT32(1),
+	NIC_F_TSO					= RTE_BIT32(2),
+	NIC_F_LRO					= RTE_BIT32(3),
+	NIC_F_UFO					= RTE_BIT32(4),
+	NIC_F_RSS					= RTE_BIT32(5),
+	NIC_F_RX_VLAN_FILTER		= RTE_BIT32(6),
+	NIC_F_RX_VLAN_STRIP			= RTE_BIT32(7),
+	NIC_F_TX_VLAN_INSERT		= RTE_BIT32(8),
+	NIC_F_VXLAN_OFFLOAD			= RTE_BIT32(9),
+	NIC_F_IPSEC_OFFLOAD			= RTE_BIT32(10),
+	NIC_F_FDIR					= RTE_BIT32(11),
+	NIC_F_PROMISC				= RTE_BIT32(12),
+	NIC_F_ALLMULTI				= RTE_BIT32(13),
+	NIC_F_PTP_1588_V2			= RTE_BIT32(18),
+	NIC_F_TX_WQE_COMPACT_TASK	= RTE_BIT32(19),
+	NIC_F_RX_HW_COMPACT_CQE		= RTE_BIT32(20),
+	NIC_F_HTN_CMDQ				= RTE_BIT32(21),
+	NIC_F_GENEVE_OFFLOAD		= RTE_BIT32(22),
+	NIC_F_IPXIP_OFFLOAD			= RTE_BIT32(23),
+	NIC_F_TC_FLOWER_OFFLOAD		= RTE_BIT32(24),
+	NIC_F_HTN_FDIR				= RTE_BIT32(25),
+	NIC_F_SQ_RQ_CI_COALESCE		= RTE_BIT32(26),
+	NIC_F_RX_SW_COMPACT_CQE		= RTE_BIT32(27),
+
 };
 
-#define DEFAULT_DRV_FEATURE 0x3FFF
+#define DEFAULT_DRV_FEATURE		0x3FC3FFF
 
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
 
+/* Tx WQE offload set callback function */
+typedef void  (*nic_tx_set_wqe_offload_t)(void *wqe_info, void *wqe_combo);
+
+/* Rx CQE info get callback function */
+typedef void  (*nic_rx_get_cqe_info_t)(struct hinic3_rxq *rx_queue, volatile struct hinic3_rq_cqe *rx_cqe,
+									   struct hinic3_cqe_info *cqe_info);
+
+/* Rx CQE check status callback funcion */
+typedef bool  (*nic_rx_cqe_done_t)(struct hinic3_rxq *rxq, volatile struct hinic3_rq_cqe **rx_cqe);
+
+/* Rx CQE empty poll callback function */
+typedef int   (*nic_rx_poll_rq_empty_t)(struct hinic3_rxq *rxq);
+
+struct hinic3_nic_tx_rx_ops {
+	nic_tx_set_wqe_offload_t		nic_tx_set_wqe_offload;
+	nic_rx_get_cqe_info_t			nic_rx_get_cqe_info;
+	nic_rx_cqe_done_t				nic_rx_cqe_done;
+	nic_rx_poll_rq_empty_t			nic_rx_poll_rq_empty;
+};
+
 struct hinic3_nic_dev {
 	struct hinic3_hwdev *hwdev; /**< Hardware device. */
 	struct hinic3_txq **txqs;
@@ -133,6 +162,8 @@ struct hinic3_nic_dev {
 	struct hinic3_tcam_info tcam;
 	struct hinic3_ethertype_filter_list filter_ethertype_list;
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;
+	struct hinic3_nic_cmdq_ops *cmdq_ops;
+	struct hinic3_nic_tx_rx_ops tx_rx_ops;
 };
 
 extern const struct rte_flow_ops hinic3_flow_ops;
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index 7f2972f1d1..26e832589b 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -11,297 +11,192 @@
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
-#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT   3
-#define HINIC3_DEAULT_TX_CI_COALESCING_TIME 16
-#define HINIC3_DEAULT_DROP_THD_ON	    0xFFFF
-#define HINIC3_DEAULT_DROP_THD_OFF	    0
-
-#define WQ_PREFETCH_MAX	      6
-#define WQ_PREFETCH_MIN	      1
-#define WQ_PREFETCH_THRESHOLD 256
-
-#define HINIC3_Q_CTXT_MAX \
-	((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))
-
-enum hinic3_qp_ctxt_type {
-	HINIC3_QP_CTXT_TYPE_SQ,
-	HINIC3_QP_CTXT_TYPE_RQ,
-};
-
-struct hinic3_qp_ctxt_header {
-	uint16_t num_queues;
-	uint16_t queue_type;
-	uint16_t start_qid;
-	uint16_t rsvd;
-};
-
-struct hinic3_sq_ctxt {
-	uint32_t ci_pi;
-	uint32_t drop_mode_sp;    /**< Packet drop mode and special flags. */
-	uint32_t wq_pfn_hi_owner; /**< High PFN and ownership flag. */
-	uint32_t wq_pfn_lo;	     /**< Low bits of work queue PFN. */
-
-	uint32_t rsvd0;	  /**< Reserved field 0. */
-	uint32_t pkt_drop_thd; /**< Packet drop threshold. */
-	uint32_t global_sq_id;
-	uint32_t vlan_ceq_attr; /**< VLAN and CEQ attributes. */
-
-	uint32_t pref_cache;	       /**< Cache prefetch settings for the queue. */
-	uint32_t pref_ci_owner;     /**< Prefetch settings for CI and ownership. */
-	uint32_t pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. */
-	uint32_t pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */
-
-	uint32_t rsvd8;	     /**< Reserved field 8. */
-	uint32_t rsvd9;	     /**< Reserved field 9. */
-	uint32_t wq_block_pfn_hi; /**< High bits of work queue block PFN. */
-	uint32_t wq_block_pfn_lo; /**< Low bits of work queue block PFN. */
-};
-
-struct hinic3_rq_ctxt {
-	uint32_t ci_pi;
-	uint32_t ceq_attr;		  /**< Completion event queue attributes. */
-	uint32_t wq_pfn_hi_type_owner; /**< High PFN, WQE type and ownership flag. */
-	uint32_t wq_pfn_lo;		  /**< Low bits of work queue PFN. */
-
-	uint32_t rsvd[3];	 /**< Reserved field. */
-	uint32_t cqe_sge_len; /**< CQE scatter/gather element length. */
-
-	uint32_t pref_cache;	       /**< Cache prefetch settings for the queue. */
-	uint32_t pref_ci_owner;     /**< Prefetch settings for CI and ownership. */
-	uint32_t pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. */
-	uint32_t pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */
-
-	uint32_t pi_paddr_hi;     /**< High 32-bits of PI DMA address. */
-	uint32_t pi_paddr_lo;     /**< Low 32-bits of PI DMA address. */
-	uint32_t wq_block_pfn_hi; /**< High bits of work queue block PFN. */
-	uint32_t wq_block_pfn_lo; /**< Low bits of work queue block PFN. */
-};
-
-struct hinic3_sq_ctxt_block {
-	struct hinic3_qp_ctxt_header cmdq_hdr;
-	struct hinic3_sq_ctxt sq_ctxt[HINIC3_Q_CTXT_MAX];
-};
-
-struct hinic3_rq_ctxt_block {
-	struct hinic3_qp_ctxt_header cmdq_hdr;
-	struct hinic3_rq_ctxt rq_ctxt[HINIC3_Q_CTXT_MAX];
-};
-
-struct hinic3_clean_queue_ctxt {
-	struct hinic3_qp_ctxt_header cmdq_hdr;
-	uint32_t rsvd;
-};
-
-#define SQ_CTXT_SIZE(num_sqs)                         \
-	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) + \
-	       (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
-
-#define RQ_CTXT_SIZE(num_rqs)                         \
-	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) + \
-	       (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
-
-#define CI_IDX_HIGH_SHIFH 12
+#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT	3
+#define HINIC3_DEAULT_TX_CI_COALESCING_TIME	16
+#define HINIC3_DEAULT_DROP_THD_ON			0xFFFF
+#define HINIC3_DEAULT_DROP_THD_OFF			0
+
+#define WQ_PREFETCH_MAX						6
+#define WQ_PREFETCH_MIN						1
+#define WQ_PREFETCH_THRESHOLD				256
+
+#define CI_IDX_HIGH_SHIFH					12
 
 #define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)
 
-#define SQ_CTXT_PI_IDX_SHIFT 0
-#define SQ_CTXT_CI_IDX_SHIFT 16
+#define SQ_CTXT_PI_IDX_SHIFT				0
+#define SQ_CTXT_CI_IDX_SHIFT				16
 
-#define SQ_CTXT_PI_IDX_MASK 0xFFFFU
-#define SQ_CTXT_CI_IDX_MASK 0xFFFFU
+#define SQ_CTXT_PI_IDX_MASK					0xFFFFU
+#define SQ_CTXT_CI_IDX_MASK					0xFFFFU
 
-#define SQ_CTXT_CI_PI_SET(val, member) \
+#define SQ_CTXT_CI_PI_SET(val, member)			\
 	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)
 
-#define SQ_CTXT_MODE_SP_FLAG_SHIFT  0
-#define SQ_CTXT_MODE_PKT_DROP_SHIFT 1
+#define SQ_CTXT_MODE_SP_FLAG_SHIFT			0
+#define SQ_CTXT_MODE_PKT_DROP_SHIFT			1
 
-#define SQ_CTXT_MODE_SP_FLAG_MASK  0x1U
-#define SQ_CTXT_MODE_PKT_DROP_MASK 0x1U
+#define SQ_CTXT_MODE_SP_FLAG_MASK			0x1U
+#define SQ_CTXT_MODE_PKT_DROP_MASK			0x1U
 
-#define SQ_CTXT_MODE_SET(val, member)           \
-	(((val) & SQ_CTXT_MODE_##member##_MASK) \
+#define SQ_CTXT_MODE_SET(val, member)			\
+	(((val) & SQ_CTXT_MODE_##member##_MASK)		\
 	 << SQ_CTXT_MODE_##member##_SHIFT)
 
-#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT 0
-#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT  23
+#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0
+#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT			23
 
-#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK 0xFFFFFU
-#define SQ_CTXT_WQ_PAGE_OWNER_MASK  0x1U
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK			0xFFFFFU
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK			0x1U
 
-#define SQ_CTXT_WQ_PAGE_SET(val, member)           \
-	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK) \
+#define SQ_CTXT_WQ_PAGE_SET(val, member)		\
+	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK)	\
 	 << SQ_CTXT_WQ_PAGE_##member##_SHIFT)
 
-#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT  0
-#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT 16
+#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT		0
+#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT		16
 
-#define SQ_CTXT_PKT_DROP_THD_ON_MASK  0xFFFFU
-#define SQ_CTXT_PKT_DROP_THD_OFF_MASK 0xFFFFU
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK		0xFFFFU
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK		0xFFFFU
 
-#define SQ_CTXT_PKT_DROP_THD_SET(val, member)       \
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)	\
 	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK) \
 	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)
 
-#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT 0
+#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT			0
 
-#define SQ_CTXT_GLOBAL_SQ_ID_MASK 0x1FFFU
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK			0x1FFFU
 
 #define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member) \
 	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)
 
-#define SQ_CTXT_VLAN_TAG_SHIFT	       0
-#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT    16
-#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT 19
-#define SQ_CTXT_VLAN_CEQ_EN_SHIFT      23
+#define SQ_CTXT_VLAN_TAG_SHIFT				0
+#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT			16
+#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT		19
+#define SQ_CTXT_VLAN_CEQ_EN_SHIFT			23
 
-#define SQ_CTXT_VLAN_TAG_MASK	      0xFFFFU
-#define SQ_CTXT_VLAN_TYPE_SEL_MASK    0x7U
-#define SQ_CTXT_VLAN_INSERT_MODE_MASK 0x3U
-#define SQ_CTXT_VLAN_CEQ_EN_MASK      0x1U
+#define SQ_CTXT_VLAN_TAG_MASK				0xFFFFU
+#define SQ_CTXT_VLAN_TYPE_SEL_MASK			0x7U
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK		0x3U
+#define SQ_CTXT_VLAN_CEQ_EN_MASK			0x1U
 
-#define SQ_CTXT_VLAN_CEQ_SET(val, member)       \
-	(((val) & SQ_CTXT_VLAN_##member##_MASK) \
+#define SQ_CTXT_VLAN_CEQ_SET(val, member)		\
+	(((val) & SQ_CTXT_VLAN_##member##_MASK)		\
 	 << SQ_CTXT_VLAN_##member##_SHIFT)
 
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0
-#define SQ_CTXT_PREF_CACHE_MAX_SHIFT	   14
-#define SQ_CTXT_PREF_CACHE_MIN_SHIFT	   25
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
+#define SQ_CTXT_PREF_CACHE_MAX_SHIFT		14
+#define SQ_CTXT_PREF_CACHE_MIN_SHIFT		25
 
-#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU
-#define SQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU
-#define SQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
+#define SQ_CTXT_PREF_CACHE_MAX_MASK			0x7FFU
+#define SQ_CTXT_PREF_CACHE_MIN_MASK			0x7FU
 
-#define SQ_CTXT_PREF_CI_HI_SHIFT 0
-#define SQ_CTXT_PREF_OWNER_SHIFT 4
+#define SQ_CTXT_PREF_CI_HI_SHIFT			0
+#define SQ_CTXT_PREF_OWNER_SHIFT			4
 
-#define SQ_CTXT_PREF_CI_HI_MASK 0xFU
-#define SQ_CTXT_PREF_OWNER_MASK 0x1U
+#define SQ_CTXT_PREF_CI_HI_MASK				0xFU
+#define SQ_CTXT_PREF_OWNER_MASK				0x1U
 
-#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0
-#define SQ_CTXT_PREF_CI_LOW_SHIFT    20
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
+#define SQ_CTXT_PREF_CI_LOW_SHIFT			20
 
-#define SQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU
-#define SQ_CTXT_PREF_CI_LOW_MASK    0xFFFU
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK			0xFFFFFU
+#define SQ_CTXT_PREF_CI_LOW_MASK			0xFFFU
 
-#define SQ_CTXT_PREF_SET(val, member)           \
-	(((val) & SQ_CTXT_PREF_##member##_MASK) \
+#define SQ_CTXT_PREF_SET(val, member)			\
+	(((val) & SQ_CTXT_PREF_##member##_MASK)		\
 	 << SQ_CTXT_PREF_##member##_SHIFT)
 
-#define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0
 
-#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU
 
-#define SQ_CTXT_WQ_BLOCK_SET(val, member)           \
-	(((val) & SQ_CTXT_WQ_BLOCK_##member##_MASK) \
+#define SQ_CTXT_WQ_BLOCK_SET(val, member)		\
+	(((val) & SQ_CTXT_WQ_BLOCK_##member##_MASK)	\
 	 << SQ_CTXT_WQ_BLOCK_##member##_SHIFT)
 
-#define RQ_CTXT_PI_IDX_SHIFT 0
-#define RQ_CTXT_CI_IDX_SHIFT 16
+#define RQ_CTXT_PI_IDX_SHIFT				0
+#define RQ_CTXT_CI_IDX_SHIFT				16
 
-#define RQ_CTXT_PI_IDX_MASK 0xFFFFU
-#define RQ_CTXT_CI_IDX_MASK 0xFFFFU
+#define RQ_CTXT_PI_IDX_MASK					0xFFFFU
+#define RQ_CTXT_CI_IDX_MASK					0xFFFFU
 
-#define RQ_CTXT_CI_PI_SET(val, member) \
+#define RQ_CTXT_CI_PI_SET(val, member)			\
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
 
-#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT	21
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT 30
-#define RQ_CTXT_CEQ_ATTR_EN_SHIFT	31
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT			21
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT		30
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT			31
 
-#define RQ_CTXT_CEQ_ATTR_INTR_MASK     0x3FFU
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK 0x1U
-#define RQ_CTXT_CEQ_ATTR_EN_MASK       0x1U
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK			0x3FFU
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK		0x1U
+#define RQ_CTXT_CEQ_ATTR_EN_MASK			0x1U
 
-#define RQ_CTXT_CEQ_ATTR_SET(val, member)           \
-	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK) \
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)		\
+	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK)	\
 	 << RQ_CTXT_CEQ_ATTR_##member##_SHIFT)
 
-#define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT   0
-#define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT 28
-#define RQ_CTXT_WQ_PAGE_OWNER_SHIFT    31
+#define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT		28
+#define RQ_CTXT_WQ_PAGE_OWNER_SHIFT			31
 
-#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK   0xFFFFFU
-#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK 0x3U
-#define RQ_CTXT_WQ_PAGE_OWNER_MASK    0x1U
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK			0xFFFFFU
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK		0x3U
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK			0x1U
 
-#define RQ_CTXT_WQ_PAGE_SET(val, member)           \
-	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK) \
+#define RQ_CTXT_WQ_PAGE_SET(val, member)		\
+	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK)	\
 	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)
 
-#define RQ_CTXT_CQE_LEN_SHIFT 28
+#define RQ_CTXT_CQE_LEN_SHIFT				28
 
-#define RQ_CTXT_CQE_LEN_MASK 0x3U
+#define RQ_CTXT_CQE_LEN_MASK				0x3U
 
-#define RQ_CTXT_CQE_LEN_SET(val, member) \
+#define RQ_CTXT_CQE_LEN_SET(val, member)		\
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
 
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0
-#define RQ_CTXT_PREF_CACHE_MAX_SHIFT	   14
-#define RQ_CTXT_PREF_CACHE_MIN_SHIFT	   25
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT	0
+#define RQ_CTXT_PREF_CACHE_MAX_SHIFT		14
+#define RQ_CTXT_PREF_CACHE_MIN_SHIFT		25
 
-#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU
-#define RQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU
-#define RQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK	0x3FFFU
+#define RQ_CTXT_PREF_CACHE_MAX_MASK			0x7FFU
+#define RQ_CTXT_PREF_CACHE_MIN_MASK			0x7FU
 
-#define RQ_CTXT_PREF_CI_HI_SHIFT 0
-#define RQ_CTXT_PREF_OWNER_SHIFT 4
+#define RQ_CTXT_PREF_CI_HI_SHIFT			0
+#define RQ_CTXT_PREF_OWNER_SHIFT			4
 
-#define RQ_CTXT_PREF_CI_HI_MASK 0xFU
-#define RQ_CTXT_PREF_OWNER_MASK 0x1U
+#define RQ_CTXT_PREF_CI_HI_MASK				0xFU
+#define RQ_CTXT_PREF_OWNER_MASK				0x1U
 
-#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0
-#define RQ_CTXT_PREF_CI_LOW_SHIFT    20
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
+#define RQ_CTXT_PREF_CI_LOW_SHIFT			20
 
-#define RQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU
-#define RQ_CTXT_PREF_CI_LOW_MASK    0xFFFU
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK			0xFFFFFU
+#define RQ_CTXT_PREF_CI_LOW_MASK			0xFFFU
 
-#define RQ_CTXT_PREF_SET(val, member)           \
-	(((val) & RQ_CTXT_PREF_##member##_MASK) \
+#define RQ_CTXT_PREF_SET(val, member)			\
+	(((val) & RQ_CTXT_PREF_##member##_MASK)		\
 	 << RQ_CTXT_PREF_##member##_SHIFT)
 
-#define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT		0
 
-#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK		0x7FFFFFU
 
-#define RQ_CTXT_WQ_BLOCK_SET(val, member)           \
-	(((val) & RQ_CTXT_WQ_BLOCK_##member##_MASK) \
+#define RQ_CTXT_WQ_BLOCK_SET(val, member)		\
+	(((val) & RQ_CTXT_WQ_BLOCK_##member##_MASK)	\
 	 << RQ_CTXT_WQ_BLOCK_##member##_SHIFT)
 
 #define SIZE_16BYTES(size) (RTE_ALIGN((size), 16) >> 4)
 
-#define WQ_PAGE_PFN_SHIFT  12
-#define WQ_BLOCK_PFN_SHIFT 9
+#define WQ_PAGE_PFN_SHIFT					12
+#define WQ_BLOCK_PFN_SHIFT					9
 
 #define WQ_PAGE_PFN(page_addr)	((page_addr) >> WQ_PAGE_PFN_SHIFT)
 #define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)
 
-/**
- * Prepare the command queue header and converted it to big-endian format.
- *
- * @param[out] qp_ctxt_hdr
- * Pointer to command queue context header structure to be initialized.
- * @param[in] ctxt_type
- * Type of context (SQ/RQ) to be set in header.
- * @param[in] num_queues
- * Number of queues.
- * @param[in] q_id
- * Starting queue ID for this context.
- */
-static void
-hinic3_qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,
-			      enum hinic3_qp_ctxt_type ctxt_type,
-			      uint16_t num_queues, uint16_t q_id)
-{
-	qp_ctxt_hdr->queue_type = ctxt_type;
-	qp_ctxt_hdr->num_queues = num_queues;
-	qp_ctxt_hdr->start_qid = q_id;
-	qp_ctxt_hdr->rsvd = 0;
-
-	rte_atomic_thread_fence(rte_memory_order_seq_cst);
-
-	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));
-}
+#define CQE_CTX_CI_ADDR_SHIFT				4
 
 /**
  * Initialize context structure for specified TXQ by configuring various queue
@@ -401,7 +296,7 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 	uint64_t wq_page_addr, wq_page_pfn, wq_block_pfn;
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;
 	uint16_t pi_start, ci_start;
-	uint16_t wqe_type = rq->wqebb_shift - HINIC3_RQ_WQEBB_SHIFT;
+	uint16_t wqe_type = rq->wqebb_shift;
 	uint8_t intr_disable;
 
 	/* RQ depth is in unit of 8 Bytes. */
@@ -446,6 +341,10 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 			RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE);
 		rq_ctxt->cqe_sge_len = RQ_CTXT_CQE_LEN_SET(1, CQE_LEN);
 		break;
+	case HINIC3_COMPACT_RQ_WQE:
+		/* Use 8Byte WQE without SGE for CQE. */
+		rq_ctxt->wq_pfn_hi_type_owner |= RQ_CTXT_WQ_PAGE_SET(3, WQE_TYPE);
+		break;
 	default:
 		PMD_DRV_LOG(INFO, "Invalid rq wqe type: %u", wqe_type);
 	}
@@ -495,12 +394,10 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 static int
 init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
 {
-	struct hinic3_sq_ctxt_block *sq_ctxt_block = NULL;
-	struct hinic3_sq_ctxt *sq_ctxt = NULL;
 	struct hinic3_cmd_buf *cmd_buf = NULL;
-	struct hinic3_txq *sq = NULL;
 	uint64_t out_param = 0;
-	uint16_t q_id, curr_id, max_ctxts, i;
+	uint16_t q_id, max_ctxts;
+	uint8_t cmd;
 	int err = 0;
 
 	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
@@ -511,28 +408,15 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
 
 	q_id = 0;
 	while (q_id < nic_dev->num_sqs) {
-		sq_ctxt_block = cmd_buf->buf;
-		sq_ctxt = sq_ctxt_block->sq_ctxt;
-
 		max_ctxts = (nic_dev->num_sqs - q_id) > HINIC3_Q_CTXT_MAX
 				    ? HINIC3_Q_CTXT_MAX
 				    : (nic_dev->num_sqs - q_id);
-
-		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,
-					      HINIC3_QP_CTXT_TYPE_SQ,
-					      max_ctxts, q_id);
-
-		for (i = 0; i < max_ctxts; i++) {
-			curr_id = q_id + i;
-			sq = nic_dev->txqs[curr_id];
-			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);
-		}
-
-		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+		cmd = nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(
+											nic_dev, cmd_buf,
+											HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
-					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
-					      cmd_buf, &out_param, 0);
+									  cmd, cmd_buf, &out_param, 0);
 		if (err || out_param != 0) {
 			PMD_DRV_LOG(ERR,
 				    "Set SQ ctxts failed, err: %d, out_param: %" PRIu64,
@@ -563,12 +447,10 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
 static int
 init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
 {
-	struct hinic3_rq_ctxt_block *rq_ctxt_block = NULL;
-	struct hinic3_rq_ctxt *rq_ctxt = NULL;
 	struct hinic3_cmd_buf *cmd_buf = NULL;
-	struct hinic3_rxq *rq = NULL;
 	uint64_t out_param = 0;
-	uint16_t q_id, curr_id, max_ctxts, i;
+	uint16_t q_id, curr_id, max_ctxts;
+	uint8_t cmd;
 	int err = 0;
 
 	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
@@ -578,29 +460,16 @@ init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
 	}
 
 	q_id = 0;
-	while (q_id < nic_dev->num_rqs) {
-		rq_ctxt_block = cmd_buf->buf;
-		rq_ctxt = rq_ctxt_block->rq_ctxt;
-
+while (q_id < nic_dev->num_rqs) {
 		max_ctxts = (nic_dev->num_rqs - q_id) > HINIC3_Q_CTXT_MAX
 				    ? HINIC3_Q_CTXT_MAX
 				    : (nic_dev->num_rqs - q_id);
-
-		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,
-					      HINIC3_QP_CTXT_TYPE_RQ,
-					      max_ctxts, q_id);
-
-		for (i = 0; i < max_ctxts; i++) {
-			curr_id = q_id + i;
-			rq = nic_dev->rxqs[curr_id];
-			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);
-		}
-
-		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+		cmd = nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(
+											nic_dev, cmd_buf,
+											HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
-					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
-					      cmd_buf, &out_param, 0);
+									  cmd, cmd_buf, &out_param, 0);
 		if (err || out_param != 0) {
 			PMD_DRV_LOG(ERR,
 				    "Set RQ ctxts failed, err: %d, out_param: %" PRIu64,
@@ -633,9 +502,9 @@ static int
 clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
 			 enum hinic3_qp_ctxt_type ctxt_type)
 {
-	struct hinic3_clean_queue_ctxt *ctxt_block = NULL;
 	struct hinic3_cmd_buf *cmd_buf;
 	uint64_t out_param = 0;
+	uint8_t cmd;
 	int err;
 
 	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
@@ -644,26 +513,11 @@ clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
 		return -ENOMEM;
 	}
 
-	/* Construct related command request. */
-	ctxt_block = cmd_buf->buf;
-	/* Assumed max_rqs must be equal to max_sqs. */
-	ctxt_block->cmdq_hdr.num_queues = nic_dev->max_sqs;
-	ctxt_block->cmdq_hdr.queue_type = ctxt_type;
-	ctxt_block->cmdq_hdr.start_qid = 0;
-	/*
-	 * Add a memory barrier to ensure that instructions are not out of order
-	 * due to compilation optimization.
-	 */
-	rte_atomic_thread_fence(rte_memory_order_seq_cst);
-
-	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));
-
-	cmd_buf->size = sizeof(*ctxt_block);
+	cmd = nic_dev->cmdq_ops->prepare_cmd_buf_clean_tso_lro_space(nic_dev, cmd_buf, ctxt_type);
 
 	/* Send a command to hardware to clean up queue offload context. */
 	err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
-				      HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,
-				      cmd_buf, &out_param, 0);
+								  cmd, cmd_buf, &out_param, 0);
 	if ((err) || (out_param)) {
 		PMD_DRV_LOG(ERR,
 			    "Clean queue offload ctxts failed, err: %d, out_param: %" PRIu64,
@@ -705,6 +559,65 @@ hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev)
 	nic_dev->rx_buff_len = buf_size;
 }
 
+#define HINIC3_RX_CQE_TIMER_LOOP 		15
+#define HINIC3_RX_CQE_COALESCE_NUM		63
+
+int
+hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_hwdev *hwdev = NULL;
+	struct hinic3_rxq *rxq = NULL;
+	struct hinic3_rq_cqe_ctx cqe_ctx;
+	rte_iova_t rq_ci_paddr;
+	uint16_t out_size = sizeof(cqe_ctx);
+	uint16_t q_id = 0;
+	uint16_t cmd;
+	int err;
+
+	if (!nic_dev)
+		return -EINVAL;
+
+	hwdev = nic_dev->hwdev;
+
+	if (hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_CMDQ)
+		cmd = HINIC3_NIC_CMD_SET_RQ_CI_CTX_HTN;
+	else {
+		cmd = HINIC3_NIC_CMD_SET_RQ_CI_CTX;
+	}
+
+	memset(&cqe_ctx, 0, sizeof(cqe_ctx));
+
+	while (q_id < nic_dev->num_rqs) {
+		rxq = nic_dev->rxqs[q_id];
+		if (rxq->wqe_type == HINIC3_COMPACT_RQ_WQE) {
+			rq_ci_paddr = rxq->rq_ci_paddr >> CQE_CTX_CI_ADDR_SHIFT;
+			cqe_ctx.ci_addr_hi = upper_32_bits(rq_ci_paddr);
+			cqe_ctx.ci_addr_lo = lower_32_bits(rq_ci_paddr);
+			cqe_ctx.threshold_cqe_num = HINIC3_RX_CQE_COALESCE_NUM;
+			cqe_ctx.timer_loop = HINIC3_RX_CQE_TIMER_LOOP;
+		} else {
+			cqe_ctx.threshold_cqe_num = 0;
+			cqe_ctx.timer_loop = 0;
+		}
+
+		cqe_ctx.cqe_type = (rxq->wqe_type == HINIC3_COMPACT_RQ_WQE);
+		cqe_ctx.msix_entry_idx = rxq->msix_entry_idx;
+		cqe_ctx.rq_id = q_id;
+
+		err = l2nic_msg_to_mgmt_sync(hwdev, cmd,
+					     &cqe_ctx, sizeof(cqe_ctx),
+					     &cqe_ctx, &out_size);
+		if (err || !out_size || cqe_ctx.msg_head.status) {
+			PMD_DRV_LOG(ERR, "Set rq cqe context failed,
+							  qid: %d, err: %d, status: 0x%x, out_size: 0x%x",
+							  q_id, err, cqe_ctx.msg_head.status, out_size);
+			return -EFAULT;
+		}
+		q_id++;
+	}
+
+	return 0;
+}
 int
 hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
 {
@@ -768,13 +681,51 @@ hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
 		}
 	}
 
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+		/* Init Rxq CQE context. */
+		err = hinic3_init_rq_cqe_ctxts(nic_dev);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Set rq cqe context failed");
+			goto set_cqe_ctx_fail;
+		}
+	}
+
 	return 0;
 
+set_cqe_ctx_fail:
 set_cons_idx_table_err:
 	hinic3_clean_root_ctxt(hwdev);
 	return err;
 }
 
+int
+hinic3_set_rq_enable(struct hinic3_nic_dev *nic_dev, uint16_t q_id, bool enable)
+{
+	struct hinic3_nic_dev *nic_dev = NULL;
+	struct hinic3_hwdev *hwdev = NULL;
+	struct hinic3_rq_enable msg;
+	uint16_t out_size = sizeof(msg);
+	int err;
+
+	if (!dev)
+		return -EINVAL;
+
+	hwdev = nic_dev->hwdev;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.rq_enable = enable;
+	msg.rq_id = q_id;
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_RQ_ENABLE,
+								 &msg, sizeof(msg), &msg, &out_size);
+	if (err || !out_size || msg.msg_head.status) {
+		PMD_DRV_LOG(ERR, "Set rq enable failed, qid: %u, enable: %d, err: %d, status: 0x%x, out_size: 0x%x",
+			    q_id, enable, err, msg.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 void
 hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev)
 {
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3_nic_io.h
index 697e781bd0..6f1eebe8ca 100644
--- a/drivers/net/hinic3/hinic3_nic_io.h
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -223,6 +223,31 @@ hinic3_write_db(void *db_addr, uint16_t q_id, int cos, uint8_t cflag, uint16_t p
  */
 void hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev);
 
+/**
+ * Initialize RQ integrated CQE context
+ *
+ * @param[in] nic_dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev);
+
+/**
+ * Set RQ disable or enable
+ *
+ * @param[in] nic_dev
+ * Pointer to ethernet device structure.
+ * @param[in] q_id
+ * Receive queue id.
+ * @param[in] enable
+ *   1: enable  0: disable
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_set_rq_enable(struct hinic3_nic_dev *nic_dev, uint16_t q_id, bool enable);
+
 /**
  * Initialize qps contexts, set SQ ci attributes, arm all SQ.
  *
-- 
2.45.1.windows.1


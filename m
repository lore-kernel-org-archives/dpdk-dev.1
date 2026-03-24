Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E358AF532C0
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 01:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC7D04066B;
	Tue, 24 Mar 2026 02:55:50 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 32FCF4027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 02:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=bSeSoL53yCL0BKdwyb4s3IuSj6e3dLpC+C0/vcbZt3s=;
 b=isIQ7fc+FZ15cf1n5wKSULhe0lkRbQy5EWA2SmAOZvNFls+ngwdv0yNvYLkl9g
 oPKZLnzeMHYZdNRLj+WYTc1C/44EMqBAuHwMloUQe69hq7FASSyQh5umhF5ty+4W
 kKc9S54DIxd0wItnzLImK06eeLp75xsplRYCpOHjr9wxY=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAnW20U78FpSlhiAw--.50021S8;
 Tue, 24 Mar 2026 09:55:44 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v8 4/7] net/hinic3: add fun init ops to support Compact CQE
Date: Tue, 24 Mar 2026 09:55:07 +0800
Message-ID: <20260324015516.201-5-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260324015516.201-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260324015516.201-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnW20U78FpSlhiAw--.50021S8
X-Coremail-Antispam: 1Uf129KBjvAXoWDCr1DGF1fXw1kWw4rAFW5Jrb_yoW7KrW7Co
 W3Jr13tw1fJr1IkrZIgw4kWayDAwn8Z3Z8Ga9xW3sFqFy7G34UKasxAw1rX3WFg39YyF17
 AF9xK3WDt3yqv3s8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUz-BMDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQDO2GnB7yANSAAA3B
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
 drivers/net/hinic3/hinic3_ethdev.c            | 208 +++++--
 drivers/net/hinic3/hinic3_ethdev.h            | 117 ++--
 drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++++----------
 drivers/net/hinic3/hinic3_nic_io.h            |  58 +-
 drivers/net/hinic3/hinic3_rx.h                |  18 +
 drivers/net/hinic3/hinic3_tx.h                |   8 +
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |  24 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  12 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |  24 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  12 +-
 10 files changed, 573 insertions(+), 433 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index e39a6ecf13..1010773ac1 100644
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
+	struct hinic3_nic_dev *nic_dev = hwdev->dev_handle;
 	uint8_t default_cos = 0;
 	uint8_t valid_cos_bitmap;
+	uint8_t cos_num_max;
 	uint8_t i;
 
 	valid_cos_bitmap = hwdev->cfg_mgmt->svc_cap.cos_valid_bitmap;
@@ -441,7 +443,10 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 		return -EFAULT;
 	}
 
-	for (i = 0; i < HINIC3_COS_NUM_MAX; i++) {
+	cos_num_max = nic_dev->feature_cap & NIC_F_HTN_CMDQ ?
+		      HINIC3_COS_NUM_MAX_HTN : HINIC3_COS_NUM_MAX;
+
+	for (i = 0; i < cos_num_max; i++) {
 		if (valid_cos_bitmap & RTE_BIT32(i))
 			/* Find max cos id as default cos. */
 			default_cos = i;
@@ -644,6 +649,15 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static void
+hinic3_dev_tnl_tso_support(struct rte_eth_dev_info *info, struct hinic3_nic_dev *nic_dev)
+{
+	if (HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev))
+		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+	if (HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))
+		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO;
+}
+
 /**
  * Get information about the device.
  *
@@ -684,6 +698,8 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
+		hinic3_dev_tnl_tso_support(info, nic_dev);
 
 	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
 	info->reta_size = HINIC3_RSS_INDIR_SIZE;
@@ -926,16 +942,25 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
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
+	if (qid != 0 && nb_desc != nic_dev->rxqs[0]->q_depth) {
+		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to queue0 depth:%u.",
+			    qid, nb_desc, nic_dev->rxqs[0]->q_depth);
+		nb_desc = nic_dev->rxqs[0]->q_depth;
+	}
+
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
 	rq_depth = (nb_desc & (nb_desc - 1))
 			? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
@@ -997,8 +1022,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	rxq->wait_time_cycle = HINIC3_RX_WAIT_CYCLE_THRESH;
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	/* If buf_len used for function table, need to translated. */
-	uint16_t rx_buf_size =
-		rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
+	rx_buf_size = rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
 	err = hinic3_convert_rx_buf_size(rx_buf_size, &buf_size);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Adjust buf size failed, dev_name: %s",
@@ -1006,11 +1030,16 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto adjust_bufsize_fail;
 	}
 
-	if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
-	    buf_size < HINIC3_RX_BUF_SIZE_16K)
-		rxq->wqe_type = HINIC3_EXTEND_RQ_WQE;
-	else
-		rxq->wqe_type = HINIC3_NORMAL_RQ_WQE;
+	/* If NIC support compact CQE, use compact wqe as default. */
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
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
@@ -1062,36 +1091,52 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
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
+			PMD_DRV_LOG(ERR, "Allocate ci mem zone failed, dev_name: %s",
+				    dev->data->name);
+			err = -ENOMEM;
+			goto alloc_cqe_ci_mz_fail;
+		}
+
+		memset(ci_mz->addr, 0, sizeof(*rxq->rq_ci));
+		rxq->ci_mz = ci_mz;
+		rxq->rq_ci = (struct hinic3_rq_ci_wb *)ci_mz->addr;
+		rxq->rq_ci_paddr = ci_mz->iova;
+	} else {
+		cqe_mz = hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,
+						 rq_depth * sizeof(*rxq->rx_cqe),
+						 RTE_CACHE_LINE_SIZE, socket_id);
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
@@ -1199,6 +1244,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	txq->owner = 1;
 	txq->cos = nic_dev->default_cos;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+	txq->tx_wqe_compact_task = HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);
 
 	ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,
 					HINIC3_CI_Q_ADDR_SIZE,
@@ -1246,7 +1292,6 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		goto alloc_tx_info_fail;
 	}
 
-	/* Record txq pointer in rte_eth tx_queues. */
 	dev->data->tx_queues[qid] = txq;
 
 	return 0;
@@ -1274,7 +1319,10 @@ hinic3_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	hinic3_free_rxq_mbufs(rxq);
 
-	hinic3_memzone_free(rxq->cqe_mz);
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev))
+		hinic3_memzone_free(rxq->ci_mz);
+	else
+		hinic3_memzone_free(rxq->cqe_mz);
 
 	rte_free(rxq->rx_info);
 	rxq->rx_info = NULL;
@@ -1323,9 +1371,12 @@ hinic3_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
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
@@ -1333,14 +1384,17 @@ hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rq_id)
 			    dev->data->name, rq_id);
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
+			PMD_DRV_LOG(ERR, "Failed to enable rq : %d fdir filter.", rq_id);
+			return rc;
+		}
 	}
+
+	dev->data->rx_queue_state[rq_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
 	return 0;
 }
 
@@ -1358,14 +1412,10 @@ hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rq_id)
 static int
 hinic3_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rq_id)
 {
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_rxq *rxq = dev->data->rx_queues[rq_id];
 	int rc;
 
-	rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, false);
-	if (rc) {
-		PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.", rq_id);
-		return rc;
-	}
 	rc = hinic3_stop_rq(dev, rxq);
 	if (rc) {
 		PMD_DRV_LOG(ERR,
@@ -1373,6 +1423,15 @@ hinic3_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rq_id)
 			    dev->data->name, rq_id);
 		return rc;
 	}
+
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) == 0) {
+		rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, false);
+		if (rc) {
+			PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.", rq_id);
+			return rc;
+		}
+	}
+
 	dev->data->rx_queue_state[rq_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
 	return 0;
@@ -1388,6 +1447,7 @@ hinic3_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t sq_id)
 
 	HINIC3_SET_TXQ_STARTED(txq);
 	dev->data->tx_queue_state[sq_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
 	return 0;
 }
 
@@ -1404,6 +1464,7 @@ hinic3_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t sq_id)
 			    dev->data->name, sq_id);
 		return rc;
 	}
+
 	HINIC3_SET_TXQ_STOPPED(txq);
 	dev->data->tx_queue_state[sq_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -3286,6 +3347,24 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 };
 
+static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)
+{
+	if (HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev))
+		nic_dev->tx_ops->nic_tx_set_wqe_offload = hinic3_tx_set_compact_task_offload;
+	else
+		nic_dev->tx_ops->nic_tx_set_wqe_offload = hinic3_tx_set_normal_task_offload;
+
+	if (HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev)) {
+		nic_dev->rx_ops->nic_rx_get_cqe_info = hinic3_rx_get_compact_cqe_info;
+		nic_dev->rx_ops->nic_rx_cqe_done = hinic3_rx_integrated_cqe_done;
+		nic_dev->rx_ops->nic_rx_poll_rq_empty = hinic3_poll_integrated_cqe_rq_empty;
+	} else {
+		nic_dev->rx_ops->nic_rx_get_cqe_info = hinic3_rx_get_cqe_info;
+		nic_dev->rx_ops->nic_rx_cqe_done = hinic3_rx_separate_cqe_done;
+		nic_dev->rx_ops->nic_rx_poll_rq_empty = hinic3_poll_rq_empty;
+	}
+}
+
 /**
  * Initialize the network function, including hardware configuration, memory
  * allocation for data structures, MAC address setup, and interrupt enabling.
@@ -3333,6 +3412,27 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		goto alloc_eth_addr_fail;
 	}
 
+	nic_dev->cmdq_ops = rte_zmalloc("cmdq_ops", sizeof(struct hinic3_nic_cmdq_ops), 0);
+	if (!nic_dev->cmdq_ops) {
+		PMD_DRV_LOG(ERR, "Allocate cmdq_ops memory failed");
+		err = -ENOMEM;
+		goto alloc_cmdq_ops_fail;
+	}
+
+	nic_dev->rx_ops = rte_zmalloc("rx_ops", sizeof(struct hinic3_nic_rx_ops), 0);
+	if (!nic_dev->rx_ops) {
+		PMD_DRV_LOG(ERR, "Allocate rx_ops memory failed");
+		err = -ENOMEM;
+		goto alloc_rx_ops_fail;
+	}
+
+	nic_dev->tx_ops = rte_zmalloc("tx_ops", sizeof(struct hinic3_nic_tx_ops), 0);
+	if (!nic_dev->tx_ops) {
+		PMD_DRV_LOG(ERR, "Allocate tx_ops memory failed");
+		err = -ENOMEM;
+		goto alloc_tx_ops_fail;
+	}
+
 	nic_dev->mc_list = rte_zmalloc("hinic3_mc",
 		HINIC3_MAX_MC_MAC_ADDRS * sizeof(struct rte_ether_addr), 0);
 	if (!nic_dev->mc_list) {
@@ -3391,6 +3491,8 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	else
 		nic_dev->cmdq_ops = hinic3_nic_cmdq_get_htn_ops();
 
+	hinic3_nic_tx_rx_ops_init(nic_dev);
+
 	err = hinic3_init_sw_rxtxqs(nic_dev);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Init sw rxqs or txqs failed, dev_name: %s",
@@ -3479,6 +3581,18 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	nic_dev->mc_list = NULL;
 
 alloc_mc_list_fail:
+	rte_free(nic_dev->tx_ops);
+	nic_dev->tx_ops = NULL;
+
+alloc_tx_ops_fail:
+	rte_free(nic_dev->rx_ops);
+	nic_dev->rx_ops = NULL;
+
+alloc_rx_ops_fail:
+	rte_free(nic_dev->cmdq_ops);
+	nic_dev->cmdq_ops = NULL;
+
+alloc_cmdq_ops_fail:
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 4a5dbb0844..3898edd076 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -14,44 +14,50 @@
 
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
+#define HINIC3_PKT_RX_L4_CKSUM_BAD	RTE_MBUF_F_RX_L4_CKSUM_BAD
+#define HINIC3_PKT_RX_IP_CKSUM_BAD	RTE_MBUF_F_RX_IP_CKSUM_BAD
+#define HINIC3_PKT_RX_IP_CKSUM_UNKNOWN	RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN
+#define HINIC3_PKT_RX_L4_CKSUM_GOOD	RTE_MBUF_F_RX_L4_CKSUM_GOOD
+#define HINIC3_PKT_RX_IP_CKSUM_GOOD	RTE_MBUF_F_RX_IP_CKSUM_GOOD
+#define HINIC3_PKT_TX_TCP_SEG		RTE_MBUF_F_TX_TCP_SEG
+#define HINIC3_PKT_TX_UDP_CKSUM		RTE_MBUF_F_TX_UDP_CKSUM
+#define HINIC3_PKT_TX_TCP_CKSUM		RTE_MBUF_F_TX_TCP_CKSUM
+#define HINIC3_PKT_TX_IP_CKSUM		RTE_MBUF_F_TX_IP_CKSUM
+#define HINIC3_PKT_TX_VLAN_PKT		RTE_MBUF_F_TX_VLAN
+#define HINIC3_PKT_TX_QINQ_PKT		RTE_MBUF_F_TX_QINQ
+#define HINIC3_PKT_TX_L4_MASK		RTE_MBUF_F_TX_L4_MASK
+#define HINIC3_PKT_TX_SCTP_CKSUM	RTE_MBUF_F_TX_SCTP_CKSUM
+#define HINIC3_PKT_TX_IPV6		RTE_MBUF_F_TX_IPV6
+#define HINIC3_PKT_TX_IPV4		RTE_MBUF_F_TX_IPV4
+#define HINIC3_PKT_RX_VLAN		RTE_MBUF_F_RX_VLAN
+#define HINIC3_PKT_RX_VLAN_STRIPPED	RTE_MBUF_F_RX_VLAN_STRIPPED
+#define HINIC3_PKT_RX_RSS_HASH	RTE_MBUF_F_RX_RSS_HASH
+#define HINIC3_PKT_TX_TUNNEL_MASK	RTE_MBUF_F_TX_TUNNEL_MASK
+#define HINIC3_PKT_TX_TUNNEL_GRE	RTE_MBUF_F_TX_TUNNEL_GRE
+#define HINIC3_PKT_TX_TUNNEL_VXLAN	RTE_MBUF_F_TX_TUNNEL_VXLAN
+#define HINIC3_PKT_TX_TUNNEL_VXLAN_GPE	RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE
+#define HINIC3_PKT_TX_TUNNEL_GENEVE	RTE_MBUF_F_TX_TUNNEL_GENEVE
+#define HINIC3_PKT_TX_TUNNEL_IPIP	RTE_MBUF_F_TX_TUNNEL_IPIP
+#define HINIC3_PKT_TX_OUTER_IP_CKSUM	RTE_MBUF_F_TX_OUTER_IP_CKSUM
+#define HINIC3_PKT_TX_OUTER_UDP_CKSUM	RTE_MBUF_F_TX_OUTER_UDP_CKSUM
+#define HINIC3_PKT_TX_OUTER_IPV6	RTE_MBUF_F_TX_OUTER_IPV6
+#define HINIC3_PKT_RX_LRO		RTE_MBUF_F_RX_LRO
+#define HINIC3_PKT_TX_L4_NO_CKSUM	RTE_MBUF_F_TX_L4_NO_CKSUM
 
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
+#define HINIC3_DEV_NAME_LEN		32
+#define DEV_STOP_DELAY_MS		100
+#define DEV_START_DELAY_MS		100
+#define HINIC3_FLUSH_QUEUE_TIMEOUT	3000
 
-#define HINIC3_UINT32_BIT_SIZE (CHAR_BIT * sizeof(uint32_t))
-#define HINIC3_VFTA_SIZE       (4096 / HINIC3_UINT32_BIT_SIZE)
-#define HINIC3_MAX_QUEUE_NUM   64
+#define HINIC3_UINT32_BIT_SIZE		(CHAR_BIT * sizeof(uint32_t))
+#define HINIC3_VFTA_SIZE		(4096 / HINIC3_UINT32_BIT_SIZE)
+#define HINIC3_MAX_QUEUE_NUM		256
 
 #define HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev) \
 	((struct hinic3_nic_dev *)(dev)->data->dev_private)
@@ -68,23 +74,34 @@ enum hinic3_tx_cvlan_type {
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
+	NIC_F_CSUM			= RTE_BIT32(0),
+	NIC_F_SCTP_CRC			= RTE_BIT32(1),
+	NIC_F_TSO			= RTE_BIT32(2),
+	NIC_F_LRO			= RTE_BIT32(3),
+	NIC_F_UFO			= RTE_BIT32(4),
+	NIC_F_RSS			= RTE_BIT32(5),
+	NIC_F_RX_VLAN_FILTER		= RTE_BIT32(6),
+	NIC_F_RX_VLAN_STRIP		= RTE_BIT32(7),
+	NIC_F_TX_VLAN_INSERT		= RTE_BIT32(8),
+	NIC_F_VXLAN_OFFLOAD		= RTE_BIT32(9),
+	NIC_F_IPSEC_OFFLOAD		= RTE_BIT32(10),
+	NIC_F_FDIR			= RTE_BIT32(11),
+	NIC_F_PROMISC			= RTE_BIT32(12),
+	NIC_F_ALLMULTI			= RTE_BIT32(13),
+	NIC_F_PTP_1588_V2		= RTE_BIT32(18),
+	NIC_F_TX_WQE_COMPACT_TASK	= RTE_BIT32(19),
+	NIC_F_RX_HW_COMPACT_CQE		= RTE_BIT32(20),
+	NIC_F_HTN_CMDQ			= RTE_BIT32(21),
+	NIC_F_GENEVE_OFFLOAD		= RTE_BIT32(22),
+	NIC_F_IPXIP_OFFLOAD		= RTE_BIT32(23),
+	NIC_F_TC_FLOWER_OFFLOAD		= RTE_BIT32(24),
+	NIC_F_HTN_FDIR			= RTE_BIT32(25),
+	NIC_F_SQ_RQ_CI_COALESCE		= RTE_BIT32(26),
+	NIC_F_RX_SW_COMPACT_CQE		= RTE_BIT32(27),
+
 };
 
-#define DEFAULT_DRV_FEATURE 0x3FFF
+#define DEFAULT_DRV_FEATURE		0x3FC3FFF
 
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
@@ -133,6 +150,10 @@ struct hinic3_nic_dev {
 	struct hinic3_tcam_info tcam;
 	struct hinic3_ethertype_filter_list filter_ethertype_list;
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;
+	struct hinic3_nic_cmdq_ops *cmdq_ops;
+	struct hinic3_nic_rx_ops *rx_ops;
+	struct hinic3_nic_tx_ops *tx_ops;
+
 };
 
 extern const struct rte_flow_ops hinic3_flow_ops;
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index 7f2972f1d1..9203dcce40 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -11,310 +11,194 @@
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
+#define HINIC3_DEAULT_DROP_THD_ON		0xFFFF
+#define HINIC3_DEAULT_DROP_THD_OFF		0
+
+#define WQ_PREFETCH_MAX				6
+#define WQ_PREFETCH_MIN				1
+#define WQ_PREFETCH_THRESHOLD			256
+
+#define CI_IDX_HIGH_SHIFH			12
 
 #define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)
 
-#define SQ_CTXT_PI_IDX_SHIFT 0
-#define SQ_CTXT_CI_IDX_SHIFT 16
+#define SQ_CTXT_PI_IDX_SHIFT			0
+#define SQ_CTXT_CI_IDX_SHIFT			16
 
-#define SQ_CTXT_PI_IDX_MASK 0xFFFFU
-#define SQ_CTXT_CI_IDX_MASK 0xFFFFU
+#define SQ_CTXT_PI_IDX_MASK			0xFFFFU
+#define SQ_CTXT_CI_IDX_MASK			0xFFFFU
 
-#define SQ_CTXT_CI_PI_SET(val, member) \
+#define SQ_CTXT_CI_PI_SET(val, member)			\
 	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)
 
-#define SQ_CTXT_MODE_SP_FLAG_SHIFT  0
-#define SQ_CTXT_MODE_PKT_DROP_SHIFT 1
+#define SQ_CTXT_MODE_SP_FLAG_SHIFT		0
+#define SQ_CTXT_MODE_PKT_DROP_SHIFT		1
 
-#define SQ_CTXT_MODE_SP_FLAG_MASK  0x1U
-#define SQ_CTXT_MODE_PKT_DROP_MASK 0x1U
+#define SQ_CTXT_MODE_SP_FLAG_MASK		0x1U
+#define SQ_CTXT_MODE_PKT_DROP_MASK		0x1U
 
-#define SQ_CTXT_MODE_SET(val, member)           \
-	(((val) & SQ_CTXT_MODE_##member##_MASK) \
+#define SQ_CTXT_MODE_SET(val, member)			\
+	(((val) & SQ_CTXT_MODE_##member##_MASK)		\
 	 << SQ_CTXT_MODE_##member##_SHIFT)
 
-#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT 0
-#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT  23
+#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT		0
+#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT		23
 
-#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK 0xFFFFFU
-#define SQ_CTXT_WQ_PAGE_OWNER_MASK  0x1U
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK		0xFFFFFU
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK		0x1U
 
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
-	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK) \
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)		\
+	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK)	\
 	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)
 
-#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT 0
+#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT		0
 
-#define SQ_CTXT_GLOBAL_SQ_ID_MASK 0x1FFFU
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK		0x1FFFU
 
 #define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member) \
 	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)
 
-#define SQ_CTXT_VLAN_TAG_SHIFT	       0
-#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT    16
-#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT 19
-#define SQ_CTXT_VLAN_CEQ_EN_SHIFT      23
+#define SQ_CTXT_VLAN_TAG_SHIFT			0
+#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT		16
+#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT		19
+#define SQ_CTXT_VLAN_CEQ_EN_SHIFT		23
 
-#define SQ_CTXT_VLAN_TAG_MASK	      0xFFFFU
-#define SQ_CTXT_VLAN_TYPE_SEL_MASK    0x7U
-#define SQ_CTXT_VLAN_INSERT_MODE_MASK 0x3U
-#define SQ_CTXT_VLAN_CEQ_EN_MASK      0x1U
+#define SQ_CTXT_VLAN_TAG_MASK			0xFFFFU
+#define SQ_CTXT_VLAN_TYPE_SEL_MASK		0x7U
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK		0x3U
+#define SQ_CTXT_VLAN_CEQ_EN_MASK		0x1U
 
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
+#define SQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
+#define SQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
 
-#define SQ_CTXT_PREF_CI_HI_SHIFT 0
-#define SQ_CTXT_PREF_OWNER_SHIFT 4
+#define SQ_CTXT_PREF_CI_HI_SHIFT		0
+#define SQ_CTXT_PREF_OWNER_SHIFT		4
 
-#define SQ_CTXT_PREF_CI_HI_MASK 0xFU
-#define SQ_CTXT_PREF_OWNER_MASK 0x1U
+#define SQ_CTXT_PREF_CI_HI_MASK			0xFU
+#define SQ_CTXT_PREF_OWNER_MASK			0x1U
 
-#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0
-#define SQ_CTXT_PREF_CI_LOW_SHIFT    20
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
+#define SQ_CTXT_PREF_CI_LOW_SHIFT		20
 
-#define SQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU
-#define SQ_CTXT_PREF_CI_LOW_MASK    0xFFFU
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
+#define SQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
 
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
+#define RQ_CTXT_PI_IDX_SHIFT			0
+#define RQ_CTXT_CI_IDX_SHIFT			16
 
-#define RQ_CTXT_PI_IDX_MASK 0xFFFFU
-#define RQ_CTXT_CI_IDX_MASK 0xFFFFU
+#define RQ_CTXT_PI_IDX_MASK			0xFFFFU
+#define RQ_CTXT_CI_IDX_MASK			0xFFFFU
 
-#define RQ_CTXT_CI_PI_SET(val, member) \
+#define RQ_CTXT_CI_PI_SET(val, member)			\
 	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
 
-#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT	21
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT 30
-#define RQ_CTXT_CEQ_ATTR_EN_SHIFT	31
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT		21
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT		30
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT		31
 
-#define RQ_CTXT_CEQ_ATTR_INTR_MASK     0x3FFU
-#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK 0x1U
-#define RQ_CTXT_CEQ_ATTR_EN_MASK       0x1U
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK		0x3FFU
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK		0x1U
+#define RQ_CTXT_CEQ_ATTR_EN_MASK		0x1U
 
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
+#define RQ_CTXT_WQ_PAGE_OWNER_SHIFT		31
 
-#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK   0xFFFFFU
-#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK 0x3U
-#define RQ_CTXT_WQ_PAGE_OWNER_MASK    0x1U
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK		0xFFFFFU
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK		0x3U
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK		0x1U
 
-#define RQ_CTXT_WQ_PAGE_SET(val, member)           \
-	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK) \
+#define RQ_CTXT_WQ_PAGE_SET(val, member)		\
+	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK)	\
 	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)
 
-#define RQ_CTXT_CQE_LEN_SHIFT 28
+#define RQ_CTXT_CQE_LEN_SHIFT			28
 
-#define RQ_CTXT_CQE_LEN_MASK 0x3U
+#define RQ_CTXT_CQE_LEN_MASK			0x3U
 
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
+#define RQ_CTXT_PREF_CACHE_MAX_MASK		0x7FFU
+#define RQ_CTXT_PREF_CACHE_MIN_MASK		0x7FU
 
-#define RQ_CTXT_PREF_CI_HI_SHIFT 0
-#define RQ_CTXT_PREF_OWNER_SHIFT 4
+#define RQ_CTXT_PREF_CI_HI_SHIFT		0
+#define RQ_CTXT_PREF_OWNER_SHIFT		4
 
-#define RQ_CTXT_PREF_CI_HI_MASK 0xFU
-#define RQ_CTXT_PREF_OWNER_MASK 0x1U
+#define RQ_CTXT_PREF_CI_HI_MASK			0xFU
+#define RQ_CTXT_PREF_OWNER_MASK			0x1U
 
-#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0
-#define RQ_CTXT_PREF_CI_LOW_SHIFT    20
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT		0
+#define RQ_CTXT_PREF_CI_LOW_SHIFT		20
 
-#define RQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU
-#define RQ_CTXT_PREF_CI_LOW_MASK    0xFFFU
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK		0xFFFFFU
+#define RQ_CTXT_PREF_CI_LOW_MASK		0xFFFU
 
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
+#define WQ_PAGE_PFN_SHIFT			12
+#define WQ_BLOCK_PFN_SHIFT			9
 
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
+#define CQE_CTX_CI_ADDR_SHIFT			4
 
-	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));
-}
-
-/**
- * Initialize context structure for specified TXQ by configuring various queue
- * parameters (e.g., ci, pi, work queue page addresses).
- *
- * @param[in] sq
- * Pointer to TXQ structure.
- * @param[in] sq_id
- * ID of TXQ being configured.
- * @param[out] sq_ctxt
- * Pointer to structure that will hold TXQ context.
- */
-static void
+void
 hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 		       struct hinic3_sq_ctxt *sq_ctxt)
 {
@@ -386,22 +270,13 @@ hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
 	hinic3_cpu_to_be32(sq_ctxt, sizeof(*sq_ctxt));
 }
 
-/**
- * Initialize context structure for specified RXQ by configuring various queue
- * parameters (e.g., ci, pi, work queue page addresses).
- *
- * @param[in] rq
- * Pointer to RXQ structure.
- * @param[out] rq_ctxt
- * Pointer to structure that will hold RXQ context.
- */
-static void
+void
 hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
 {
 	uint64_t wq_page_addr, wq_page_pfn, wq_block_pfn;
 	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;
 	uint16_t pi_start, ci_start;
-	uint16_t wqe_type = rq->wqebb_shift - HINIC3_RQ_WQEBB_SHIFT;
+	uint16_t wqe_type = rq->wqe_type;
 	uint8_t intr_disable;
 
 	/* RQ depth is in unit of 8 Bytes. */
@@ -446,6 +321,10 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
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
@@ -495,12 +374,10 @@ hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
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
@@ -511,28 +388,14 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
 
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
+		cmd = nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_dev, cmd_buf,
+			HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
-					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
-					      cmd_buf, &out_param, 0);
+					      cmd, cmd_buf, &out_param, 0);
 		if (err || out_param != 0) {
 			PMD_DRV_LOG(ERR,
 				    "Set SQ ctxts failed, err: %d, out_param: %" PRIu64,
@@ -563,12 +426,10 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
 static int
 init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
 {
-	struct hinic3_rq_ctxt_block *rq_ctxt_block = NULL;
-	struct hinic3_rq_ctxt *rq_ctxt = NULL;
 	struct hinic3_cmd_buf *cmd_buf = NULL;
-	struct hinic3_rxq *rq = NULL;
 	uint64_t out_param = 0;
-	uint16_t q_id, curr_id, max_ctxts, i;
+	uint16_t q_id, max_ctxts;
+	uint8_t cmd;
 	int err = 0;
 
 	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
@@ -579,28 +440,14 @@ init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
 
 	q_id = 0;
 	while (q_id < nic_dev->num_rqs) {
-		rq_ctxt_block = cmd_buf->buf;
-		rq_ctxt = rq_ctxt_block->rq_ctxt;
-
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
+		cmd = nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_dev, cmd_buf,
+			HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
-					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
-					      cmd_buf, &out_param, 0);
+					      cmd, cmd_buf, &out_param, 0);
 		if (err || out_param != 0) {
 			PMD_DRV_LOG(ERR,
 				    "Set RQ ctxts failed, err: %d, out_param: %" PRIu64,
@@ -633,9 +480,9 @@ static int
 clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
 			 enum hinic3_qp_ctxt_type ctxt_type)
 {
-	struct hinic3_clean_queue_ctxt *ctxt_block = NULL;
 	struct hinic3_cmd_buf *cmd_buf;
 	uint64_t out_param = 0;
+	uint8_t cmd;
 	int err;
 
 	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
@@ -644,26 +491,11 @@ clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
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
+				      cmd, cmd_buf, &out_param, 0);
 	if ((err) || (out_param)) {
 		PMD_DRV_LOG(ERR,
 			    "Clean queue offload ctxts failed, err: %d, out_param: %" PRIu64,
@@ -705,6 +537,62 @@ hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev)
 	nic_dev->rx_buff_len = buf_size;
 }
 
+#define HINIC3_RX_CQE_TIMER_LOOP		15
+#define HINIC3_RX_CQE_COALESCE_NUM		63
+
+int
+hinic3_init_rq_cqe_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_hwdev *hwdev = NULL;
+	struct hinic3_rxq *rxq = NULL;
+	struct hinic3_rq_cqe_ctx cqe_ctx = { 0 };
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
+	else
+		cmd = HINIC3_NIC_CMD_SET_RQ_CI_CTX;
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
+		err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, cmd,
+					      &cqe_ctx, sizeof(cqe_ctx),
+					      &cqe_ctx, &out_size);
+		if (err || !out_size || cqe_ctx.msg_head.status) {
+			PMD_DRV_LOG(ERR, "Set rq cqe context failed, qid: %d, err: %d, status: 0x%x, out_size: 0x%x",
+				    q_id, err, cqe_ctx.msg_head.status, out_size);
+			return -EFAULT;
+		}
+		q_id++;
+	}
+
+	return 0;
+}
+
 int
 hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
 {
@@ -768,13 +656,50 @@ hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
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
+	struct hinic3_hwdev *hwdev = NULL;
+	struct hinic3_rq_enable msg;
+	uint16_t out_size = sizeof(msg);
+	int err;
+
+	if (!nic_dev)
+		return -EINVAL;
+
+	hwdev = nic_dev->hwdev;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.rq_enable = enable;
+	msg.rq_id = q_id;
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC, HINIC3_NIC_CMD_SET_RQ_ENABLE_HTN,
+				      &msg, sizeof(msg), &msg, &out_size);
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
index e589deed23..e1741d1156 100644
--- a/drivers/net/hinic3/hinic3_nic_io.h
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -28,11 +28,6 @@
 
 #define HINIC3_Q_CTXT_MAX ((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))
 
-#define SQ_CTXT_SIZE(num_sqs) ((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) \
-					  + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
-#define RQ_CTXT_SIZE(num_rqs) ((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) \
-					  + (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
-
 enum hinic3_rq_wqe_type {
 	HINIC3_COMPACT_RQ_WQE,
 	HINIC3_NORMAL_RQ_WQE,
@@ -231,6 +226,31 @@ hinic3_write_db(void *db_addr, uint16_t q_id, int cos, uint8_t cflag, uint16_t p
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
@@ -264,9 +284,6 @@ void hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev);
  * Pointer to ethernet device structure.
  * @param[out] s_feature
  * s_feature driver supported.
- *
- * @return
- * 0 on success, non-zero on failure.
  */
 void hinic3_update_driver_feature(struct hinic3_nic_dev *nic_dev, uint64_t s_feature);
 
@@ -281,4 +298,29 @@ void hinic3_update_driver_feature(struct hinic3_nic_dev *nic_dev, uint64_t s_fea
  */
 uint64_t hinic3_get_driver_feature(struct hinic3_nic_dev *nic_dev);
 
+/**
+ * Initialize context structure for specified TXQ by configuring various queue
+ * parameters (e.g., ci, pi, work queue page addresses).
+ *
+ * @param[in] sq
+ * Pointer to TXQ structure.
+ * @param[in] sq_id
+ * ID of TXQ being configured.
+ * @param[out] sq_ctxt
+ * Pointer to structure that will hold TXQ context.
+ */
+void hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
+			    struct hinic3_sq_ctxt *sq_ctxt);
+
+/**
+ * Initialize context structure for specified RXQ by configuring various queue
+ * parameters (e.g., ci, pi, work queue page addresses).
+ *
+ * @param[in] rq
+ * Pointer to RXQ structure.
+ * @param[out] rq_ctxt
+ * Pointer to structure that will hold RXQ context.
+ */
+void hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt);
+
 #endif /* _HINIC3_NIC_IO_H_ */
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.h
index 1a92df59b7..7ae39e3e91 100644
--- a/drivers/net/hinic3/hinic3_rx.h
+++ b/drivers/net/hinic3/hinic3_rx.h
@@ -279,6 +279,24 @@ struct __rte_cache_aligned hinic3_rxq {
 #endif
 };
 
+/* Rx CQE info get callback function */
+typedef void  (*nic_rx_get_cqe_info_t)(struct hinic3_rxq *rxq,
+				       volatile struct hinic3_rq_cqe *rx_cqe,
+				       struct hinic3_cqe_info *cqe_info);
+
+/* Rx CQE check status callback function */
+typedef bool  (*nic_rx_cqe_done_t)(struct hinic3_rxq *rxq,
+				   volatile struct hinic3_rq_cqe **rx_cqe);
+
+/* Rx CQE empty poll callback function */
+typedef int   (*nic_rx_poll_rq_empty_t)(struct hinic3_rxq *rxq);
+
+struct hinic3_nic_rx_ops {
+	nic_rx_get_cqe_info_t		nic_rx_get_cqe_info;
+	nic_rx_cqe_done_t		nic_rx_cqe_done;
+	nic_rx_poll_rq_empty_t		nic_rx_poll_rq_empty;
+};
+
 uint16_t hinic3_rx_fill_wqe(struct hinic3_rxq *rxq);
 
 uint16_t hinic3_rx_fill_buffers(struct hinic3_rxq *rxq);
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index d150f7c6a4..21958a00cc 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -304,6 +304,14 @@ struct __rte_cache_aligned hinic3_txq {
 #endif
 };
 
+/* Tx WQE offload set callback function */
+typedef void  (*nic_tx_set_wqe_offload_t)(struct hinic3_wqe_info *wqe_info,
+					  struct hinic3_sq_wqe_combo *wqe_combo);
+
+struct hinic3_nic_tx_ops {
+	nic_tx_set_wqe_offload_t	nic_tx_set_wqe_offload;
+};
+
 void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_txq_mbufs(struct hinic3_txq *txq);
 void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
index d997647f48..634dfe7239 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
@@ -8,11 +8,16 @@
 #include "hinic3_hwif.h"
 #include "hinic3_htn_cmdq.h"
 
+#define HTN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_ctxt_header) \
+						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
+#define HTN_RQ_CTXT_SIZE(num_rqs)	((uint16_t)(sizeof(struct hinic3_htn_qp_ctxt_header) \
+						    + (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
+
 static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *nic_dev,
 						   struct hinic3_cmd_buf *cmd_buf,
 						   enum hinic3_qp_ctxt_type ctxt_type)
 {
-	struct hinic3_clean_queue_ctxt *ctxt_block = NULL;
+	struct hinic3_htn_clean_queue_ctxt *ctxt_block = NULL;
 
 	ctxt_block = cmd_buf->buf;
 	ctxt_block->cmdq_hdr.num_queues = nic_dev->max_sqs;
@@ -27,7 +32,7 @@ static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *nic_de
 	return HINIC3_HTN_CMD_TSO_LRO_SPACE_CLEAN;
 }
 
-static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,
+static void qp_prepare_cmdq_header(struct hinic3_htn_qp_ctxt_header *qp_ctxt_hdr,
 				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,
 				   uint16_t q_id, uint16_t func_id)
 {
@@ -45,7 +50,7 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic
 						      enum hinic3_qp_ctxt_type ctxt_type,
 						      uint16_t start_qid, uint16_t max_ctxts)
 {
-	struct hinic3_qp_ctxt_block *qp_ctxt_block = NULL;
+	struct hinic3_htn_qp_ctxt_block *qp_ctxt_block = NULL;
 	uint16_t func_id;
 	uint16_t i;
 
@@ -65,9 +70,9 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic
 	}
 
 	if (ctxt_type == HINIC3_QP_CTXT_TYPE_RQ)
-		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+		cmd_buf->size = HTN_RQ_CTXT_SIZE(max_ctxts);
 	else
-		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+		cmd_buf->size = HTN_SQ_CTXT_SIZE(max_ctxts);
 
 	return HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_ST;
 }
@@ -75,10 +80,10 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic
 static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf,
 			uint16_t func_id, uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)
 {
-	struct hinic3_vlan_ctx *vlan_ctx = NULL;
+	struct hinic3_htn_vlan_ctx *vlan_ctx = NULL;
 
-	cmd_buf->size = sizeof(struct hinic3_vlan_ctx);
-	vlan_ctx = (struct hinic3_vlan_ctx *)cmd_buf->buf;
+	cmd_buf->size = sizeof(struct hinic3_htn_vlan_ctx);
+	vlan_ctx = (struct hinic3_htn_vlan_ctx *)cmd_buf->buf;
 
 	vlan_ctx->dest_func_id = func_id;
 	vlan_ctx->start_qid = q_id;
@@ -87,7 +92,8 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf,
 	vlan_ctx->vlan_mode = vlan_mode;
 
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
-	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));
+
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_htn_vlan_ctx));
 	return HINIC3_HTN_CMD_SVLAN_MODIFY;
 }
 
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
index 89709efdd0..3dbbd53174 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
@@ -7,7 +7,7 @@
 
 #include "hinic3_nic_io.h"
 
-struct hinic3_qp_ctxt_header {
+struct hinic3_htn_qp_ctxt_header {
 	uint32_t rsvd[2];
 	uint16_t num_queues;
 	uint16_t queue_type;
@@ -15,12 +15,12 @@ struct hinic3_qp_ctxt_header {
 	uint16_t dest_func_id;
 };
 
-struct hinic3_clean_queue_ctxt {
-	struct hinic3_qp_ctxt_header cmdq_hdr;
+struct hinic3_htn_clean_queue_ctxt {
+	struct hinic3_htn_qp_ctxt_header cmdq_hdr;
 };
 
-struct hinic3_qp_ctxt_block {
-	struct hinic3_qp_ctxt_header   cmdq_hdr;
+struct hinic3_htn_qp_ctxt_block {
+	struct hinic3_htn_qp_ctxt_header cmdq_hdr;
 	union {
 		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];
 		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];
@@ -43,7 +43,7 @@ enum hinic3_htn_cmd {
 	HINIC3_HTN_CMD_GET_RSS_INDIR_TABLE
 };
 
-struct hinic3_vlan_ctx {
+struct hinic3_htn_vlan_ctx {
 	uint32_t rsv[2];
 	uint16_t vlan_tag;
 	uint8_t vlan_sel;
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
index 3d4becf07c..dfe8598f78 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
@@ -8,11 +8,16 @@
 #include "hinic3_hwif.h"
 #include "hinic3_stn_cmdq.h"
 
+#define STN_SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_ctxt_header) \
+						    + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
+#define STN_RQ_CTXT_SIZE(num_rqs)	((uint16_t)(sizeof(struct hinic3_stn_qp_ctxt_header) \
+						    + (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
+
 static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *nic_dev,
 						   struct hinic3_cmd_buf *cmd_buf,
 						   enum hinic3_qp_ctxt_type ctxt_type)
 {
-	struct hinic3_clean_queue_ctxt *ctxt_block = NULL;
+	struct hinic3_stn_clean_queue_ctxt *ctxt_block = NULL;
 
 	ctxt_block = cmd_buf->buf;
 	ctxt_block->cmdq_hdr.num_queues = nic_dev->max_sqs;
@@ -26,7 +31,7 @@ static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *nic_de
 	return HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT;
 }
 
-static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,
+static void qp_prepare_cmdq_header(struct hinic3_stn_qp_ctxt_header *qp_ctxt_hdr,
 				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,
 				   uint16_t q_id)
 {
@@ -44,7 +49,7 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic
 						 enum hinic3_qp_ctxt_type ctxt_type,
 						 uint16_t start_qid, uint16_t max_ctxts)
 {
-	struct hinic3_qp_ctxt_block *qp_ctxt_block = NULL;
+	struct hinic3_stn_qp_ctxt_block *qp_ctxt_block = NULL;
 	uint16_t i;
 
 	qp_ctxt_block = cmd_buf->buf;
@@ -62,9 +67,9 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic
 	}
 
 	if (ctxt_type == HINIC3_QP_CTXT_TYPE_RQ)
-		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+		cmd_buf->size = STN_RQ_CTXT_SIZE(max_ctxts);
 	else
-		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+		cmd_buf->size = STN_SQ_CTXT_SIZE(max_ctxts);
 
 	return HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX;
 }
@@ -72,10 +77,10 @@ static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic
 static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf, uint16_t func_id,
 					    uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)
 {
-	struct hinic3_vlan_ctx *vlan_ctx = NULL;
+	struct hinic3_stn_vlan_ctx *vlan_ctx = NULL;
 
-	cmd_buf->size = sizeof(struct hinic3_vlan_ctx);
-	vlan_ctx = (struct hinic3_vlan_ctx *)cmd_buf->buf;
+	cmd_buf->size = sizeof(struct hinic3_stn_vlan_ctx);
+	vlan_ctx = (struct hinic3_stn_vlan_ctx *)cmd_buf->buf;
 
 	vlan_ctx->func_id = func_id;
 	vlan_ctx->qid = q_id;
@@ -84,7 +89,8 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf, uint
 	vlan_ctx->vlan_mode = vlan_mode;
 
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
-	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));
+
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_stn_vlan_ctx));
 	return HINIC3_UCODE_CMD_MODIFY_VLAN_CTX;
 }
 
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
index 8235dcd0fa..f1720c29c7 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
@@ -7,27 +7,27 @@
 
 #include "hinic3_nic_io.h"
 
-struct hinic3_qp_ctxt_header {
+struct hinic3_stn_qp_ctxt_header {
 	uint16_t num_queues;
 	uint16_t queue_type;
 	uint16_t start_qid;
 	uint16_t rsvd;
 };
 
-struct hinic3_clean_queue_ctxt {
-	struct hinic3_qp_ctxt_header cmdq_hdr;
+struct hinic3_stn_clean_queue_ctxt {
+	struct hinic3_stn_qp_ctxt_header cmdq_hdr;
 	uint32_t rsvd;
 };
 
-struct hinic3_qp_ctxt_block {
-	struct hinic3_qp_ctxt_header   cmdq_hdr;
+struct hinic3_stn_qp_ctxt_block {
+	struct hinic3_stn_qp_ctxt_header   cmdq_hdr;
 	union {
 		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];
 		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];
 	};
 };
 
-struct hinic3_vlan_ctx {
+struct hinic3_stn_vlan_ctx {
 	uint32_t func_id;
 	uint32_t qid; /* if qid = 0xFFFF, config for all queues */
 	uint32_t vlan_id;
-- 
2.45.1.windows.1


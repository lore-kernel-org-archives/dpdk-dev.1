Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618BCCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:35:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C262F40668;
	Fri,  7 Nov 2025 08:35:12 +0100 (CET)
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com
 [115.124.28.194])
 by mails.dpdk.org (Postfix) with ESMTP id 9256140264
 for <dev@dpdk.org>; Fri,  7 Nov 2025 08:35:09 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fH1I0MW_1762500905 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 07 Nov 2025 15:35:05 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Alvin Wang <alvin.wang@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/4] net/nbl: change default Rx extension header size to 12
 bytes
Date: Thu,  6 Nov 2025 23:34:56 -0800
Message-Id: <20251107073459.3532524-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
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

The default Rx extension header size is reduced from 16 bytes to 12 bytes.
This reduction saves PCIe bandwidth by decreasing packet overhead.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c         | 4 +++-
 drivers/net/nbl/nbl_dev/nbl_dev.h         | 1 +
 drivers/net/nbl/nbl_hw/nbl_resource.h     | 1 +
 drivers/net/nbl/nbl_hw/nbl_txrx.c         | 6 +++++-
 drivers/net/nbl/nbl_include/nbl_include.h | 3 ++-
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 0381bb74ec..1992568088 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -87,7 +87,7 @@ static int nbl_dev_txrx_start(struct rte_eth_dev *eth_dev)
 		param.local_queue_id = i + ring_mgt->queue_offset;
 		param.intr_en = 0;
 		param.intr_mask = 0;
-		param.half_offload_en = 1;
+		param.half_offload_en = ring_mgt->rx_hash_en;
 		param.extend_header = 1;
 		param.split = 0;
 		param.rxcsum = 1;
@@ -266,6 +266,7 @@ int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 	param.conf = conf;
 	param.mempool = mempool;
 	param.product = adapter->caps.product_type;
+	param.rx_hash_en = ring_mgt->rx_hash_en;
 	ret =  disp_ops->start_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &param, &rx_ring->dma);
 	if (ret) {
 		NBL_LOG(ERR, "start_rx_ring failed %d", ret);
@@ -993,6 +994,7 @@ int nbl_dev_init(void *p, struct rte_eth_dev *eth_dev)
 			       eth_dev->data->mac_addrs[0].addr_bytes);
 
 	adapter->state = NBL_ETHDEV_INITIALIZED;
+	(*dev_mgt)->net_dev->ring_mgt.rx_hash_en = 0;
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 	disp_ops->get_resource_pt_ops(NBL_DEV_MGT_TO_DISP_PRIV(*dev_mgt),
 				      &(*dev_mgt)->pt_ops, 0);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 99d8fd9483..46683d0aff 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -35,6 +35,7 @@ struct nbl_dev_ring_mgt {
 	u8 tx_ring_num;
 	u8 rx_ring_num;
 	u8 active_ring_num;
+	bool rx_hash_en;
 };
 
 struct nbl_dev_net_mgt {
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index e5d184a2a0..7212778647 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -197,6 +197,7 @@ struct nbl_res_rx_ring {
 
 	u16 avail_used_flags;
 	bool used_wrap_counter;
+	bool rx_hash_en;
 	u16 notify_qid;
 	u16 exthdr_len;
 
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 77a982ccfb..3c93765a5f 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -284,10 +284,14 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 	rx_ring->dma_limit_msb = common->dma_limit_msb;
 	rx_ring->common = common;
 	rx_ring->notify = hw_ops->get_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	rx_ring->rx_hash_en = param->rx_hash_en;
 
 	switch (param->product) {
 	case NBL_LEONIS_TYPE:
-		rx_ring->exthdr_len = sizeof(struct nbl_rx_ehdr_leonis);
+		if (param->rx_hash_en)
+			rx_ring->exthdr_len = sizeof(struct nbl_rx_ehdr_leonis);
+		else
+			rx_ring->exthdr_len = sizeof(struct nbl_rx_ehdr_leonis) - 4;
 		break;
 	default:
 		rx_ring->exthdr_len = sizeof(union nbl_rx_extend_head);
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index e0f0497e3f..f565e321d4 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -82,9 +82,10 @@ struct nbl_start_rx_ring_param {
 	u16 queue_idx;
 	u16 nb_desc;
 	u32 socket_id;
-	enum nbl_product_type product;
 	const struct rte_eth_rxconf *conf;
 	struct rte_mempool *mempool;
+	enum nbl_product_type product;
+	bool rx_hash_en;
 };
 
 struct nbl_start_tx_ring_param {
-- 
2.34.1


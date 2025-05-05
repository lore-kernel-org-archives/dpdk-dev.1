Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB8C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 15:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 642ED4025D;
	Mon,  5 May 2025 17:16:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 225614003C
 for <dev@dpdk.org>; Mon,  5 May 2025 17:16:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 38E832115DB9; Mon,  5 May 2025 08:16:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38E832115DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746458208;
 bh=bi5YhY8TWVX7fd5fN7WM/Dyh2BRYE303l+KdD3KkFaM=;
 h=From:To:Cc:Subject:Date:From;
 b=r1nl3xEgT7duE/4O12MjhKr4EbnQhwFuUrcsiqF6DpE2hb9kH3Ir1L7MkSIhFNbug
 Gc3KnLHbGmPoa125ZqailI+qaTGQhrvZ4xM6FjCkmEABG68hNDAe+XmxKMnIFlBf3H
 sTE+589zH+hCZ8iWMSpIJIZNrnDgmAItOM7fKjOA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Matan Azrad <matan@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] net/mlx5: avoid implicit conversion to 64 bits
Date: Mon,  5 May 2025 08:16:42 -0700
Message-Id: <1746458202-12356-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

When compiling with MSVC, errors like the one below pop up:

../drivers/crypto/mlx5/mlx5_crypto_xts.c(488): warning C4334:
    '<<': result of 32-bit shift implicitly converted to 64 bits
    (was 64-bit shift intended?)

Depending on the situation, the fix is to do a 64-bit shift, or
be explicit about the type conversion by adding a cast.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/crypto/mlx5/mlx5_crypto_xts.c | 4 ++--
 drivers/net/mlx5/mlx5_devx.c          | 2 +-
 drivers/net/mlx5/mlx5_rx.c            | 2 +-
 drivers/net/mlx5/mlx5_rxq.c           | 2 +-
 drivers/net/mlx5/mlx5_trigger.c       | 2 +-
 drivers/net/mlx5/mlx5_tx.c            | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/mlx5/mlx5_crypto_xts.c b/drivers/crypto/mlx5/mlx5_crypto_xts.c
index b9214711ac..1c914caa85 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_xts.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_xts.c
@@ -485,7 +485,7 @@ mlx5_crypto_xts_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	alloc_size = RTE_ALIGN(alloc_size, RTE_CACHE_LINE_SIZE);
 	alloc_size += (sizeof(struct rte_crypto_op *) +
 		       sizeof(struct mlx5_devx_obj *)) *
-		       RTE_BIT32(log_nb_desc);
+		       (size_t)RTE_BIT32(log_nb_desc);
 	qp = rte_zmalloc_socket(__func__, alloc_size, RTE_CACHE_LINE_SIZE,
 				socket_id);
 	if (qp == NULL) {
@@ -529,7 +529,7 @@ mlx5_crypto_xts_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		goto error;
 	qp->mkey = (struct mlx5_devx_obj **)RTE_ALIGN((uintptr_t)(qp + 1),
 							   RTE_CACHE_LINE_SIZE);
-	qp->ops = (struct rte_crypto_op **)(qp->mkey + RTE_BIT32(log_nb_desc));
+	qp->ops = (struct rte_crypto_op **)(qp->mkey + (size_t)RTE_BIT32(log_nb_desc));
 	qp->entries_n = 1 << log_nb_desc;
 	if (mlx5_crypto_indirect_mkeys_prepare(priv, qp, &mkey_attr,
 					       mlx5_crypto_gcm_mkey_klm_update)) {
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index a12891a983..f56a3e26da 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1358,7 +1358,7 @@ mlx5_txq_obj_hairpin_new(struct rte_eth_dev *dev, uint16_t idx)
 		MLX5_ASSERT(hca_attr->hairpin_sq_wqe_bb_size > 0);
 		rte_memcpy(&host_mem_attr, &dev_mem_attr, sizeof(host_mem_attr));
 		umem_size = MLX5_WQE_SIZE *
-			RTE_BIT32(host_mem_attr.wq_attr.log_hairpin_num_packets);
+			(size_t)RTE_BIT32(host_mem_attr.wq_attr.log_hairpin_num_packets);
 		umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
 		umem_size += MLX5_DBR_SIZE;
 		umem_buf = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, umem_size,
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index b0b0ce250e..5f4a93fe8c 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -383,7 +383,7 @@ mlx5_rxq_initialize(struct mlx5_rxq_data *rxq)
 			scat = &((volatile struct mlx5_wqe_mprq *)
 				rxq->wqes)[i].dseg;
 			addr = (uintptr_t)mlx5_mprq_buf_addr
-					(buf, RTE_BIT32(rxq->log_strd_num));
+					(buf, (uintptr_t)RTE_BIT32(rxq->log_strd_num));
 			byte_count = RTE_BIT32(rxq->log_strd_sz) *
 				     RTE_BIT32(rxq->log_strd_num);
 			lkey = mlx5_rx_addr2mr(rxq, addr);
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index ab29b43875..b703a11137 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -1472,7 +1472,7 @@ mlx5_mprq_alloc_mp(struct rte_eth_dev *dev)
 	MLX5_ASSERT(log_strd_num && log_strd_sz);
 	buf_len = RTE_BIT32(log_strd_num) * RTE_BIT32(log_strd_sz);
 	obj_size = sizeof(struct mlx5_mprq_buf) + buf_len +
-		   RTE_BIT32(log_strd_num) *
+		   (size_t)RTE_BIT32(log_strd_num) *
 		   sizeof(struct rte_mbuf_ext_shared_info) +
 		   RTE_PKTMBUF_HEADROOM;
 	/*
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 4ee44e9165..212f6658bf 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1186,7 +1186,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	fine_inline = rte_mbuf_dynflag_lookup
 		(RTE_PMD_MLX5_FINE_GRANULARITY_INLINE, NULL);
 	if (fine_inline >= 0)
-		rte_net_mlx5_dynf_inline_mask = 1UL << fine_inline;
+		rte_net_mlx5_dynf_inline_mask = RTE_BIT64(fine_inline);
 	else
 		rte_net_mlx5_dynf_inline_mask = 0;
 	if (dev->data->nb_rx_queues > 0) {
diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index b2522e7170..fe9da7f8c1 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -109,12 +109,12 @@ mlx5_tx_error_cqe_handle(struct mlx5_txq_data *__rte_restrict txq,
 						    (const void *)((uintptr_t)
 						    txq->cqes),
 						    sizeof(struct mlx5_error_cqe) *
-						    (1 << txq->cqe_n));
+						    (size_t)RTE_BIT32(txq->cqe_n));
 			mlx5_dump_debug_information(name, "MLX5 Error SQ:",
 						    (const void *)((uintptr_t)
 						    txq->wqes),
 						    MLX5_WQE_SIZE *
-						    (1 << txq->wqe_n));
+						    (size_t)RTE_BIT32(txq->wqe_n));
 			txq_ctrl->dump_file_n++;
 		}
 		if (!seen)
-- 
2.49.0.vfs.0.2


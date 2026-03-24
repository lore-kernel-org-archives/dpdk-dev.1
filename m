Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33887F54ADC
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60DC54025F;
	Tue, 24 Mar 2026 17:53:21 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by mails.dpdk.org (Postfix) with ESMTP id B79CA4021F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:53:20 +0100 (CET)
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id A55DB60132;
 Tue, 24 Mar 2026 17:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774371200;
 bh=EAnf5FjS75vdFHOFn2kgaV679G6T5/bxdJNCzIQfk5Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BrKSX06KQW5JgdwlenhFG7s1r8Dvh4XP0rR9yTo18IszIpn59QueEQ8ESqmZhiBeB
 1FXpktFz/vpUP/E6fRDVR8JDgEOY9BnbNjsY/BPiOAgXTEqmANzGPWX0OGAGmdhNog
 WeMOe6nZsjLLkeSrJxiMPpVpkAP4SroBIzTGrXtLGbOEkaidi88d37QyEMXp/RaaOw
 SqNW5zOUexFaLQKeaod4NTlLtsLPP/8TaTzc7WF2RhfM0J81LRNuZGEoHk2b3ejzeH
 IuUJFNYpz0og0Iy6AAAHfrXo1daXzdSjmZ6d5rt/WTQi+T0ZdRulIwo3GbjyPcfSGw
 fBQ2MQRdQgW7g==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 09/10] net/mlx5: implement per-queue Tx rate limit getter
Date: Tue, 24 Mar 2026 17:50:46 +0100
Message-ID: <20260324165047.391137-10-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324165047.391137-1-vjardin@free.fr>
References: <20260322134629.94633-1-vjardin@free.fr>
 <20260324165047.391137-1-vjardin@free.fr>
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

Wire the mlx5 PMD to the new rte_eth_get_queue_rate_limit()
ethdev callback. The implementation reads the per-queue
rate_mbps tracking field from the txq_ctrl structure.

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/mlx5/mlx5.c     |  2 ++
 drivers/net/mlx5/mlx5_tx.h  |  2 ++
 drivers/net/mlx5/mlx5_txq.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 7d08d7886b..f5784761f9 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2652,6 +2652,7 @@ const struct eth_dev_ops mlx5_dev_ops = {
 	.rx_metadata_negotiate = mlx5_flow_rx_metadata_negotiate,
 	.get_restore_flags = mlx5_get_restore_flags,
 	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
+	.get_queue_rate_limit = mlx5_get_queue_rate_limit,
 };
 
 /* Available operations from secondary process. */
@@ -2746,6 +2747,7 @@ const struct eth_dev_ops mlx5_dev_ops_isolate = {
 	.map_aggr_tx_affinity = mlx5_map_aggr_tx_affinity,
 	.get_restore_flags = mlx5_get_restore_flags,
 	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
+	.get_queue_rate_limit = mlx5_get_queue_rate_limit,
 };
 
 /**
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 975ff57acd..02feb9e6fd 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -224,6 +224,8 @@ int mlx5_txq_releasable(struct rte_eth_dev *dev, uint16_t idx);
 int mlx5_txq_verify(struct rte_eth_dev *dev);
 int mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
 			      uint32_t tx_rate);
+int mlx5_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+			      uint32_t *tx_rate);
 int mlx5_txq_get_sqn(struct mlx5_txq_ctrl *txq);
 void mlx5_txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl);
 void mlx5_txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl);
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index ce08363ca9..867ea4b994 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1481,6 +1481,36 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 }
 
+/**
+ * Get per-queue packet pacing rate limit.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ * @param queue_idx
+ *   TX queue index.
+ * @param[out] tx_rate
+ *   Pointer to store the TX rate in Mbps, 0 if rate limiting is disabled.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ */
+int
+mlx5_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+			  uint32_t *tx_rate)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_txq_ctrl *txq_ctrl;
+
+	if (priv->txqs == NULL || (*priv->txqs)[queue_idx] == NULL) {
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	txq_ctrl = container_of((*priv->txqs)[queue_idx],
+				struct mlx5_txq_ctrl, txq);
+	*tx_rate = txq_ctrl->rate_limit.rate_mbps;
+	return 0;
+}
+
 /**
  * Verify if the queue can be released.
  *
-- 
2.43.0


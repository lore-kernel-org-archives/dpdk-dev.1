Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D55FD88CE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 23:28:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E7940E16;
	Wed, 11 Mar 2026 00:28:44 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id F205840E16
 for <dev@dpdk.org>; Wed, 11 Mar 2026 00:28:43 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 2125D780368;
 Wed, 11 Mar 2026 00:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773185323;
 bh=Hk6quqflAnb4j0v/tyTYvl3lcZRiZXJ77f8Ol3kki/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qVKblnSpcV8jjPUPuC6ucjfY1Ynrog2an4lpRHqLrLuhSNXl3+vKEl8LUrW4PUbI8
 yDhqesSZr+Hgs/Cb3c8FWVdcuSHVVjWNgv7YOyOtjW9Yh3QJhEoGmVrruMpaUV20s6
 Xdn5jE8zZGyX0QWC1meivDwxxKfwE8lbpyVTue0UsRasNbyi2Do3CKCCr0m47/c6HT
 c3rmBuVUGQijtZ6beGxfImK4shn1yrwnyZj+R0YqKq7F+Czlj6CMfqoPegMBMCwA7H
 oz4Y31CMhEYjWkMfe7hK35enuQXpcyuo2xW3SpVNEscpH56QBUJxjSsdAN0M+KtAuN
 +Fjbnlpa9iQ7A==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 05/10] net/mlx5: support per-queue rate limiting
Date: Wed, 11 Mar 2026 00:26:48 +0100
Message-ID: <20260310232653.2935764-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310232653.2935764-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Wire rte_eth_set_queue_rate_limit() to the mlx5 PMD. The callback
allocates a per-queue PP index with the requested data rate, then
modifies the live SQ via modify_bitmask bit 0 to apply the new
packet_pacing_rate_limit_index — no queue teardown required.

Setting tx_rate=0 clears the PP index on the SQ and frees it.

Capability check uses hca_attr.qos.packet_pacing directly (not
dev_cap.txpp_en which requires Clock Queue prerequisites). This
allows per-queue rate limiting without the tx_pp devarg.

The callback rejects hairpin queues and queues whose SQ is not
yet created.

testpmd usage (no testpmd changes needed):
  set port 0 queue 0 rate 1000
  set port 0 queue 1 rate 5000
  set port 0 queue 0 rate 0     # disable

Supported hardware:
- ConnectX-6 Dx: full support, per-SQ rate via HW rate table
- ConnectX-7/8: full support, coexists with wait-on-time scheduling
- BlueField-2/3: full support as DPU rep ports

Not supported:
- ConnectX-5: packet_pacing exists but dynamic SQ modify may not
  work on all firmware versions
- ConnectX-4 Lx and earlier: no packet_pacing capability

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/mlx5/mlx5.c     |   2 +
 drivers/net/mlx5/mlx5_tx.h  |   2 +
 drivers/net/mlx5/mlx5_txq.c | 103 ++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 4d3bfddc36..c390406ac7 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2690,6 +2690,7 @@ const struct eth_dev_ops mlx5_dev_ops = {
 	.map_aggr_tx_affinity = mlx5_map_aggr_tx_affinity,
 	.rx_metadata_negotiate = mlx5_flow_rx_metadata_negotiate,
 	.get_restore_flags = mlx5_get_restore_flags,
+	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
 };
 
 /* Available operations from secondary process. */
@@ -2783,6 +2784,7 @@ const struct eth_dev_ops mlx5_dev_ops_isolate = {
 	.count_aggr_ports = mlx5_count_aggr_ports,
 	.map_aggr_tx_affinity = mlx5_map_aggr_tx_affinity,
 	.get_restore_flags = mlx5_get_restore_flags,
+	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
 };
 
 /**
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index b1b3653247..3a37f5bb4d 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -222,6 +222,8 @@ struct mlx5_txq_ctrl *mlx5_txq_get(struct rte_eth_dev *dev, uint16_t idx);
 int mlx5_txq_release(struct rte_eth_dev *dev, uint16_t idx);
 int mlx5_txq_releasable(struct rte_eth_dev *dev, uint16_t idx);
 int mlx5_txq_verify(struct rte_eth_dev *dev);
+int mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+			      uint32_t tx_rate);
 int mlx5_txq_get_sqn(struct mlx5_txq_ctrl *txq);
 void mlx5_txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl);
 void mlx5_txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl);
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index fa9bb48fd4..7863b529f6 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1363,6 +1363,109 @@ mlx5_txq_release(struct rte_eth_dev *dev, uint16_t idx)
 	return 0;
 }
 
+/**
+ * Set per-queue packet pacing rate limit.
+ *
+ * @param dev
+ *   Pointer to Ethernet device.
+ * @param queue_idx
+ *   TX queue index.
+ * @param tx_rate
+ *   TX rate in Mbps, 0 to disable rate limiting.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ */
+int
+mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+			  uint32_t tx_rate)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_dev_ctx_shared *sh = priv->sh;
+	struct mlx5_txq_ctrl *txq_ctrl;
+	struct mlx5_devx_modify_sq_attr sq_attr = { 0 };
+	int ret;
+
+	if (!sh->cdev->config.hca_attr.qos.packet_pacing) {
+		DRV_LOG(ERR, "Port %u packet pacing not supported.",
+			dev->data->port_id);
+		rte_errno = ENOTSUP;
+		return -rte_errno;
+	}
+	if (queue_idx >= dev->data->nb_tx_queues) {
+		DRV_LOG(ERR, "Port %u Tx queue %u out of range.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (priv->txqs == NULL || (*priv->txqs)[queue_idx] == NULL) {
+		DRV_LOG(ERR, "Port %u Tx queue %u not configured.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	txq_ctrl = container_of((*priv->txqs)[queue_idx],
+				struct mlx5_txq_ctrl, txq);
+	if (txq_ctrl->is_hairpin) {
+		DRV_LOG(ERR, "Port %u Tx queue %u is hairpin.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (txq_ctrl->obj == NULL || txq_ctrl->obj->sq == NULL) {
+		DRV_LOG(ERR, "Port %u Tx queue %u SQ not ready.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (tx_rate == 0) {
+		/* Disable rate limiting. */
+		if (txq_ctrl->rl.pp_id == 0)
+			return 0; /* Already disabled. */
+		sq_attr.sq_state = MLX5_SQC_STATE_RDY;
+		sq_attr.state = MLX5_SQC_STATE_RDY;
+		sq_attr.rl_update = 1;
+		sq_attr.packet_pacing_rate_limit_index = 0;
+		ret = mlx5_devx_cmd_modify_sq(txq_ctrl->obj->sq, &sq_attr);
+		if (ret) {
+			DRV_LOG(ERR,
+				"Port %u Tx queue %u failed to clear rate.",
+				dev->data->port_id, queue_idx);
+			rte_errno = -ret;
+			return ret;
+		}
+		mlx5_txq_free_pp_rate_limit(&txq_ctrl->rl);
+		DRV_LOG(DEBUG, "Port %u Tx queue %u rate limit disabled.",
+			dev->data->port_id, queue_idx);
+		return 0;
+	}
+	/* Allocate a new PP index for the requested rate into a temp. */
+	struct mlx5_txq_rate_limit new_rl = { 0 };
+
+	ret = mlx5_txq_alloc_pp_rate_limit(sh, &new_rl, tx_rate);
+	if (ret)
+		return ret;
+	/* Modify live SQ to use the new PP index. */
+	sq_attr.sq_state = MLX5_SQC_STATE_RDY;
+	sq_attr.state = MLX5_SQC_STATE_RDY;
+	sq_attr.rl_update = 1;
+	sq_attr.packet_pacing_rate_limit_index = new_rl.pp_id;
+	ret = mlx5_devx_cmd_modify_sq(txq_ctrl->obj->sq, &sq_attr);
+	if (ret) {
+		DRV_LOG(ERR, "Port %u Tx queue %u failed to set rate %u Mbps.",
+			dev->data->port_id, queue_idx, tx_rate);
+		mlx5_txq_free_pp_rate_limit(&new_rl);
+		rte_errno = -ret;
+		return ret;
+	}
+	/* SQ updated — release old PP context, install new one. */
+	mlx5_txq_free_pp_rate_limit(&txq_ctrl->rl);
+	txq_ctrl->rl = new_rl;
+	DRV_LOG(DEBUG, "Port %u Tx queue %u rate set to %u Mbps (PP idx %u).",
+		dev->data->port_id, queue_idx, tx_rate, txq_ctrl->rl.pp_id);
+	return 0;
+}
+
 /**
  * Verify if the queue can be released.
  *
-- 
2.43.0


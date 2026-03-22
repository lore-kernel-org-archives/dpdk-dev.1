Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D57FC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 13:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2742240648;
	Sun, 22 Mar 2026 14:48:14 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 1A39D4042C
 for <dev@dpdk.org>; Sun, 22 Mar 2026 14:48:13 +0100 (CET)
Received: from localhost.localdomain (unknown [78.240.46.143])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id B6289780507;
 Sun, 22 Mar 2026 14:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774187293;
 bh=qqzXvrgu2lGnhItlQ76vM40tmazulWPLWruyaJ6aXSY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FNIXoh0J6yt/k40qdlXfqpwUD81qwT9v7p4w+6hiGt9tD0o/zEsddlMXr9PoLtQrc
 QS8shwwFpvPrreWBPnUKVaG0SOSF6fotRhlXrnq1fHZUi4uauDKZnq4QpKikkI4khj
 P7/NthmLK+QkPZ0pK7n8avLro0xDxSXw5vXOnx4H2Ghnddc3OZXk+/EWvG+U74jvFi
 np3X99VDVJCVG8/lPP/39pF2j3Da3JhOL3i9fmCcpFWQs4gzzgLiB1y0qScLEMpNsi
 YXn2GmxNZAArQbdDrqX3ayqMOhsqpz8+Myq86MaRIM5Njk9MYb2GyYBWrko50OYLcs
 YqJuC9Ax9LYBw==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 05/10] net/mlx5: support per-queue rate limiting
Date: Sun, 22 Mar 2026 14:46:24 +0100
Message-ID: <20260322134629.94633-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322134629.94633-1-vjardin@free.fr>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
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
 doc/guides/nics/features/mlx5.ini |   1 +
 doc/guides/nics/mlx5.rst          |  54 ++++++++++++++
 drivers/net/mlx5/mlx5.c           |   2 +
 drivers/net/mlx5/mlx5_tx.h        |   2 +
 drivers/net/mlx5/mlx5_txq.c       | 118 ++++++++++++++++++++++++++++++
 5 files changed, 177 insertions(+)

diff --git a/doc/guides/nics/features/mlx5.ini b/doc/guides/nics/features/mlx5.ini
index 4f9c4c309b..3b3eda28b8 100644
--- a/doc/guides/nics/features/mlx5.ini
+++ b/doc/guides/nics/features/mlx5.ini
@@ -30,6 +30,7 @@ Inner RSS            = Y
 SR-IOV               = Y
 VLAN filter          = Y
 Flow control         = Y
+Rate limitation      = Y
 CRC offload          = Y
 VLAN offload         = Y
 L3 checksum offload  = Y
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 6bb8c07353..c72a60f084 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -580,6 +580,60 @@ for an additional list of options shared with other mlx5 drivers.
   (with ``tx_pp``) and ConnectX-7+ (wait-on-time) scheduling modes.
   The default value is zero.
 
+.. _mlx5_per_queue_rate_limit:
+
+Per-Queue Tx Rate Limiting
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The mlx5 PMD supports per-queue Tx rate limiting via the standard ethdev
+API ``rte_eth_set_queue_rate_limit()`` and ``rte_eth_get_queue_rate_limit()``.
+
+This feature uses the hardware packet pacing mechanism to enforce a data
+rate on individual TX queues without tearing down the queue. The rate is
+specified in Mbps.
+
+**Requirements:**
+
+- ConnectX-6 Dx or later with ``packet_pacing`` HCA capability.
+- The DevX path must be used (default). The legacy Verbs path
+  (``dv_flow_en=0``) does not support dynamic SQ modification and
+  returns ``-EINVAL``.
+- The queue must be started (SQ in RDY state) before setting a rate.
+
+**Supported hardware:**
+
+- ConnectX-6 Dx: per-SQ rate via HW rate table.
+- ConnectX-7/8: full support, coexists with wait-on-time scheduling.
+- BlueField-2/3: full support as DPU rep ports.
+
+**Not supported:**
+
+- ConnectX-5: ``packet_pacing`` exists but dynamic SQ modify may not
+  work on all firmware versions.
+- ConnectX-4 Lx and earlier: no ``packet_pacing`` capability.
+
+**Rate table sharing:**
+
+The hardware rate table has a limited number of entries (typically 128 on
+ConnectX-6 Dx). When multiple queues are configured with identical rate
+parameters, the kernel mlx5 driver shares a single rate table entry across
+them. Each queue still has its own independent SQ and enforces the rate
+independently — queues are never merged. The rate cap applies per-queue:
+if two queues share the same 1000 Mbps entry, each can send up to
+1000 Mbps independently, they do not share a combined budget.
+
+This sharing is transparent and only affects table capacity: 128 entries
+can serve thousands of queues as long as many use the same rate. Queues
+with different rates consume separate entries.
+
+**Usage with testpmd:**
+
+.. code-block:: console
+
+   testpmd> set port 0 queue 0 rate 1000
+   testpmd> show port 0 queue 0 rate
+   testpmd> set port 0 queue 0 rate 0
+
 - ``tx_vec_en`` parameter [int]
 
   A nonzero value enables Tx vector with ConnectX-5 NICs and above.
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index e795948187..e718f0fa8c 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2621,6 +2621,7 @@ const struct eth_dev_ops mlx5_dev_ops = {
 	.map_aggr_tx_affinity = mlx5_map_aggr_tx_affinity,
 	.rx_metadata_negotiate = mlx5_flow_rx_metadata_negotiate,
 	.get_restore_flags = mlx5_get_restore_flags,
+	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
 };
 
 /* Available operations from secondary process. */
@@ -2714,6 +2715,7 @@ const struct eth_dev_ops mlx5_dev_ops_isolate = {
 	.count_aggr_ports = mlx5_count_aggr_ports,
 	.map_aggr_tx_affinity = mlx5_map_aggr_tx_affinity,
 	.get_restore_flags = mlx5_get_restore_flags,
+	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
 };
 
 /**
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 51f330454a..975ff57acd 100644
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
index 3356c89758..ce08363ca9 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1363,6 +1363,124 @@ mlx5_txq_release(struct rte_eth_dev *dev, uint16_t idx)
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
+	struct mlx5_devx_obj *sq_devx;
+	struct mlx5_devx_modify_sq_attr sq_attr = { 0 };
+	struct mlx5_txq_rate_limit new_rate_limit = { 0 };
+	int ret;
+
+	if (!sh->cdev->config.hca_attr.qos.packet_pacing) {
+		DRV_LOG(ERR, "Port %u packet pacing not supported.",
+			dev->data->port_id);
+		rte_errno = ENOTSUP;
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
+	if (txq_ctrl->obj == NULL) {
+		DRV_LOG(ERR, "Port %u Tx queue %u not initialized.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	/*
+	 * For non-hairpin queues the SQ DevX object lives in
+	 * obj->sq_obj.sq (used by DevX/HWS mode), while hairpin
+	 * queues use obj->sq directly. These are different members
+	 * of a union inside mlx5_txq_obj.
+	 */
+	sq_devx = txq_ctrl->obj->sq_obj.sq;
+	if (sq_devx == NULL) {
+		DRV_LOG(ERR, "Port %u Tx queue %u SQ not ready.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (dev->data->tx_queue_state[queue_idx] !=
+	    RTE_ETH_QUEUE_STATE_STARTED) {
+		DRV_LOG(ERR,
+			"Port %u Tx queue %u is not started, stop traffic before setting rate.",
+			dev->data->port_id, queue_idx);
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (tx_rate == 0) {
+		/* Disable rate limiting. */
+		if (txq_ctrl->rate_limit.pp_id == 0)
+			return 0; /* Already disabled. */
+		sq_attr.sq_state = MLX5_SQC_STATE_RDY;
+		sq_attr.state = MLX5_SQC_STATE_RDY;
+		sq_attr.rl_update = 1;
+		sq_attr.packet_pacing_rate_limit_index = 0;
+		ret = mlx5_devx_cmd_modify_sq(sq_devx, &sq_attr);
+		if (ret) {
+			DRV_LOG(ERR,
+				"Port %u Tx queue %u failed to clear rate.",
+				dev->data->port_id, queue_idx);
+			rte_errno = -ret;
+			return ret;
+		}
+		mlx5_txq_free_pp_rate_limit(&txq_ctrl->rate_limit);
+		DRV_LOG(DEBUG, "Port %u Tx queue %u rate limit disabled.",
+			dev->data->port_id, queue_idx);
+		return 0;
+	}
+	/* Allocate a new PP index for the requested rate into a temp. */
+	ret = mlx5_txq_alloc_pp_rate_limit(sh, &new_rate_limit, tx_rate);
+	if (ret)
+		return ret;
+	/* Modify live SQ to use the new PP index. */
+	sq_attr.sq_state = MLX5_SQC_STATE_RDY;
+	sq_attr.state = MLX5_SQC_STATE_RDY;
+	sq_attr.rl_update = 1;
+	sq_attr.packet_pacing_rate_limit_index = new_rate_limit.pp_id;
+	ret = mlx5_devx_cmd_modify_sq(sq_devx, &sq_attr);
+	if (ret) {
+		DRV_LOG(ERR, "Port %u Tx queue %u failed to set rate %u Mbps.",
+			dev->data->port_id, queue_idx, tx_rate);
+		mlx5_txq_free_pp_rate_limit(&new_rate_limit);
+		rte_errno = -ret;
+		return ret;
+	}
+	/* SQ updated — release old PP context, install new one. */
+	mlx5_txq_free_pp_rate_limit(&txq_ctrl->rate_limit);
+	txq_ctrl->rate_limit = new_rate_limit;
+	DRV_LOG(DEBUG, "Port %u Tx queue %u rate set to %u Mbps (PP idx %u).",
+		dev->data->port_id, queue_idx, tx_rate, txq_ctrl->rate_limit.pp_id);
+	return 0;
+}
+
 /**
  * Verify if the queue can be released.
  *
-- 
2.43.0


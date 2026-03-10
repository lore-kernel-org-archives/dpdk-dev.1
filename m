Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE2FD88CE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 23:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A76F40E01;
	Wed, 11 Mar 2026 00:28:32 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 03B6B402AC
 for <dev@dpdk.org>; Wed, 11 Mar 2026 00:28:30 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id DC2C1780371;
 Wed, 11 Mar 2026 00:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773185309;
 bh=aDRqfwOMUi6tLEClvDWcGczh7UYZ0e40UPaVYc9ZcDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tmeZq6QXtyp0qZ8efcV2lUC91MtD6SBcD2XY4MDExjq4/+YkRC9wOdtyrjY68B6aN
 jE0kDLDPkuUURnrKWEom58M4uZKmPvHONhjWszg937ACRG+O+KH45A40viQuL1esPV
 6IaEyv0qXvyNT9qmxFxjK5DOpVy4qF6ZXo2LwE2WovQ0CVEijX53L2vebmwp+MtkR5
 129/M31JCxN4/60Clgi+K9H6LSeDC74qZlbEpdeDUWweekbqmF+uXA/vL7zrMeTFgX
 7t/Wu0JWgR8Pj+8bXe31dNUT1pW2P7VBNCMehxoVpmkhpPzmVz1diswLBEAc5dOOqq
 V2k3XI0BUZ3gg==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 04/10] net/mlx5: add per-queue packet pacing infrastructure
Date: Wed, 11 Mar 2026 00:26:47 +0100
Message-ID: <20260310232653.2935764-5-vjardin@free.fr>
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

Add mlx5_txq_rate_limit structure and alloc/free helpers for
per-queue data-rate packet pacing. Each Tx queue can now hold
its own PP (Packet Pacing) index allocated via mlx5dv_pp_alloc()
with MLX5_DATA_RATE mode.

mlx5_txq_alloc_pp_rate_limit() converts Mbps to kbps for the PRM
rate_limit field and allocates a dedicated PP index from the HW
rate table. mlx5_txq_free_pp_rate_limit() releases it.

The existing Clock Queue path (sh->txpp.pp / sh->txpp.pp_id) is
untouched — it uses MLX5_WQE_RATE for per-packet scheduling,
while per-queue rate limiting uses MLX5_DATA_RATE.

PP index cleanup is added to mlx5_txq_release() to prevent leaks
when queues are destroyed.

Supported hardware:
- ConnectX-6 Dx: per-SQ rate via packet_pacing_rate_limit_index
- ConnectX-7/8: same mechanism, plus wait-on-time coexistence
- BlueField-2/3: same PP allocation support

Not supported:
- ConnectX-5: packet_pacing exists but MLX5_DATA_RATE mode may
  not be available on all firmware versions
- ConnectX-4 Lx and earlier: no packet_pacing capability

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/mlx5/mlx5.h      | 11 ++++++
 drivers/net/mlx5/mlx5_tx.h   |  1 +
 drivers/net/mlx5/mlx5_txpp.c | 75 ++++++++++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_txq.c  |  1 +
 4 files changed, 88 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index b83dda5652..c48c3072d1 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1296,6 +1296,13 @@ struct mlx5_txpp_ts {
 	RTE_ATOMIC(uint64_t) ts;
 };
 
+/* Per-queue rate limit tracking. */
+struct mlx5_txq_rate_limit {
+	void *pp;		/* Packet pacing context from dv_alloc_pp. */
+	uint16_t pp_id;		/* Packet pacing index. */
+	uint32_t rate_mbps;	/* Current rate in Mbps, 0 = disabled. */
+};
+
 /* Tx packet pacing structure. */
 struct mlx5_dev_txpp {
 	pthread_mutex_t mutex; /* Pacing create/destroy mutex. */
@@ -2634,6 +2641,10 @@ int mlx5_txpp_xstats_get_names(struct rte_eth_dev *dev,
 void mlx5_txpp_interrupt_handler(void *cb_arg);
 int mlx5_txpp_map_hca_bar(struct rte_eth_dev *dev);
 void mlx5_txpp_unmap_hca_bar(struct rte_eth_dev *dev);
+int mlx5_txq_alloc_pp_rate_limit(struct mlx5_dev_ctx_shared *sh,
+				 struct mlx5_txq_rate_limit *rl,
+				 uint32_t rate_mbps);
+void mlx5_txq_free_pp_rate_limit(struct mlx5_txq_rate_limit *rl);
 
 /* mlx5_rxtx.c */
 
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 0134a2e003..b1b3653247 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -192,6 +192,7 @@ struct mlx5_txq_ctrl {
 	uint16_t dump_file_n; /* Number of dump files. */
 	struct rte_eth_hairpin_conf hairpin_conf; /* Hairpin configuration. */
 	uint32_t hairpin_status; /* Hairpin binding status. */
+	struct mlx5_txq_rate_limit rl; /* Per-queue rate limit. */
 	struct mlx5_txq_data txq; /* Data path structure. */
 	/* Must be the last field in the structure, contains elts[]. */
 };
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index 0e99b58bde..5469120a83 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -128,6 +128,81 @@ mlx5_txpp_alloc_pp_index(struct mlx5_dev_ctx_shared *sh)
 #endif
 }
 
+/* Free a per-queue packet pacing index. */
+void
+mlx5_txq_free_pp_rate_limit(struct mlx5_txq_rate_limit *rl)
+{
+#ifdef HAVE_MLX5DV_PP_ALLOC
+	if (rl->pp) {
+		mlx5_glue->dv_free_pp(rl->pp);
+		rl->pp = NULL;
+		rl->pp_id = 0;
+		rl->rate_mbps = 0;
+	}
+#else
+	RTE_SET_USED(rl);
+#endif
+}
+
+/* Allocate a per-queue packet pacing index for data-rate limiting. */
+int
+mlx5_txq_alloc_pp_rate_limit(struct mlx5_dev_ctx_shared *sh,
+			     struct mlx5_txq_rate_limit *rl,
+			     uint32_t rate_mbps)
+{
+#ifdef HAVE_MLX5DV_PP_ALLOC
+	uint32_t pp[MLX5_ST_SZ_DW(set_pp_rate_limit_context)];
+	uint64_t rate_kbps;
+	struct mlx5_hca_qos_attr *qos = &sh->cdev->config.hca_attr.qos;
+
+	MLX5_ASSERT(rate_mbps > 0);
+	rate_kbps = (uint64_t)rate_mbps * 1000;
+	if (qos->packet_pacing_min_rate && rate_kbps < qos->packet_pacing_min_rate) {
+		DRV_LOG(ERR, "Rate %u Mbps below HW minimum (%u kbps).",
+			rate_mbps, qos->packet_pacing_min_rate);
+		rte_errno = ERANGE;
+		return -ERANGE;
+	}
+	if (qos->packet_pacing_max_rate && rate_kbps > qos->packet_pacing_max_rate) {
+		DRV_LOG(ERR, "Rate %u Mbps exceeds HW maximum (%u kbps).",
+			rate_mbps, qos->packet_pacing_max_rate);
+		rte_errno = ERANGE;
+		return -ERANGE;
+	}
+	memset(&pp, 0, sizeof(pp));
+	MLX5_SET(set_pp_rate_limit_context, &pp, rate_limit, (uint32_t)rate_kbps);
+	MLX5_SET(set_pp_rate_limit_context, &pp, rate_mode, MLX5_DATA_RATE);
+	rl->pp = mlx5_glue->dv_alloc_pp
+				(sh->cdev->ctx, sizeof(pp), &pp,
+				 MLX5DV_PP_ALLOC_FLAGS_DEDICATED_INDEX);
+	if (rl->pp == NULL) {
+		DRV_LOG(ERR, "Failed to allocate PP index for rate %u Mbps.",
+			rate_mbps);
+		rte_errno = errno;
+		return -errno;
+	}
+	rl->pp_id = ((struct mlx5dv_pp *)(rl->pp))->index;
+	if (!rl->pp_id) {
+		DRV_LOG(ERR, "Zero PP index allocated for rate %u Mbps.",
+			rate_mbps);
+		mlx5_txq_free_pp_rate_limit(rl);
+		rte_errno = ENOTSUP;
+		return -ENOTSUP;
+	}
+	rl->rate_mbps = rate_mbps;
+	DRV_LOG(DEBUG, "Allocated PP index %u for rate %u Mbps.",
+		rl->pp_id, rate_mbps);
+	return 0;
+#else
+	RTE_SET_USED(sh);
+	RTE_SET_USED(rl);
+	RTE_SET_USED(rate_mbps);
+	DRV_LOG(ERR, "Per-queue rate limit requires rdma-core PP support.");
+	rte_errno = ENOTSUP;
+	return -ENOTSUP;
+#endif
+}
+
 static void
 mlx5_txpp_destroy_send_queue(struct mlx5_txpp_wq *wq)
 {
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 9275efb58e..fa9bb48fd4 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1338,6 +1338,7 @@ mlx5_txq_release(struct rte_eth_dev *dev, uint16_t idx)
 	txq_ctrl = container_of((*priv->txqs)[idx], struct mlx5_txq_ctrl, txq);
 	if (rte_atomic_fetch_sub_explicit(&txq_ctrl->refcnt, 1, rte_memory_order_relaxed) - 1 > 1)
 		return 1;
+	mlx5_txq_free_pp_rate_limit(&txq_ctrl->rl);
 	if (txq_ctrl->obj) {
 		priv->obj_ops.txq_obj_release(txq_ctrl->obj);
 		LIST_REMOVE(txq_ctrl->obj, next);
-- 
2.43.0


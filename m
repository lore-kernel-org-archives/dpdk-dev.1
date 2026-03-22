Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D840AFC72AD
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 13:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FAA040649;
	Sun, 22 Mar 2026 14:47:58 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 8A33E40649
 for <dev@dpdk.org>; Sun, 22 Mar 2026 14:47:57 +0100 (CET)
Received: from localhost.localdomain (unknown [78.240.46.143])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id DA16A78032A;
 Sun, 22 Mar 2026 14:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774187277;
 bh=Mzm12X8Dh3KiFlFS54Lm0QJubTqHsNwvEGKB69gTy7I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EOlgltteEtEXHo7NSKQrqYD0yYBVVyHTkGkbvT971FcnRznIzuLprMsPFRu6CC4qB
 9/+gnx0rG3p4iPBNE+T6lAQGwwn06ytV8T1x6lxCCon8qVc080cpKak8pfz3jTrTkK
 JEEEcrDgL6XlrKiG8jwKT0SgHs43MjqvRGaMjVXuhCrbn+d6IO50nOsBDoN1+D+qYa
 0SMmVMNzGUi2/dvcSCFuLXH2SDKZY5KNLeO8kp8kKJpivMbSTK3xuCYTphkG5kdEiW
 /njcZPpDAl0ZqG1FcBgJ2+hZ2kE/jL2hxpKWiY/MU7MZve51DE45kge4gioIxVBLO8
 RfOG/h8pVURBg==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 04/10] net/mlx5: add per-queue packet pacing infrastructure
Date: Sun, 22 Mar 2026 14:46:23 +0100
Message-ID: <20260322134629.94633-5-vjardin@free.fr>
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

Add mlx5_txq_rate_limit structure and alloc/free helpers for
per-queue data-rate packet pacing. Each Tx queue can now hold
its own PP (Packet Pacing) context allocated via mlx5dv_pp_alloc()
with MLX5_DATA_RATE mode.

mlx5_txq_alloc_pp_rate_limit() converts Mbps to kbps for the PRM
rate_limit field and allocates a PP context from the HW rate table.
mlx5_txq_free_pp_rate_limit() releases it.

PP allocation uses shared mode (flags=0). Each dv_alloc_pp() call
returns a distinct PP handle (needed for per-queue dv_free_pp()
cleanup), but the kernel mlx5 driver internally maps identical
rate parameters to the same HW rate table entry (same pp_id) with
internal refcounting. This avoids exhausting the rate table
(typically 128 entries on ConnectX-6 Dx) when many queues share
the same rate.

The existing Clock Queue path (sh->txpp.pp / sh->txpp.pp_id) is
untouched — it uses MLX5_WQE_RATE for per-packet scheduling with
a dedicated index, while per-queue rate limiting uses MLX5_DATA_RATE.

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
 drivers/net/mlx5/mlx5.h      | 11 +++++
 drivers/net/mlx5/mlx5_tx.h   |  1 +
 drivers/net/mlx5/mlx5_txpp.c | 78 ++++++++++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5_txq.c  |  1 +
 4 files changed, 91 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 4da184eb47..33628d7987 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -1297,6 +1297,13 @@ struct mlx5_txpp_ts {
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
@@ -2630,6 +2637,10 @@ int mlx5_txpp_xstats_get_names(struct rte_eth_dev *dev,
 void mlx5_txpp_interrupt_handler(void *cb_arg);
 int mlx5_txpp_map_hca_bar(struct rte_eth_dev *dev);
 void mlx5_txpp_unmap_hca_bar(struct rte_eth_dev *dev);
+int mlx5_txq_alloc_pp_rate_limit(struct mlx5_dev_ctx_shared *sh,
+				 struct mlx5_txq_rate_limit *rate_limit,
+				 uint32_t rate_mbps);
+void mlx5_txq_free_pp_rate_limit(struct mlx5_txq_rate_limit *rate_limit);
 
 /* mlx5_rxtx.c */
 
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 0134a2e003..51f330454a 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -192,6 +192,7 @@ struct mlx5_txq_ctrl {
 	uint16_t dump_file_n; /* Number of dump files. */
 	struct rte_eth_hairpin_conf hairpin_conf; /* Hairpin configuration. */
 	uint32_t hairpin_status; /* Hairpin binding status. */
+	struct mlx5_txq_rate_limit rate_limit; /* Per-queue rate limit. */
 	struct mlx5_txq_data txq; /* Data path structure. */
 	/* Must be the last field in the structure, contains elts[]. */
 };
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index 0e99b58bde..e34e996e9b 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -128,6 +128,84 @@ mlx5_txpp_alloc_pp_index(struct mlx5_dev_ctx_shared *sh)
 #endif
 }
 
+/* Free a per-queue packet pacing index. */
+void
+mlx5_txq_free_pp_rate_limit(struct mlx5_txq_rate_limit *rate_limit)
+{
+#ifdef HAVE_MLX5DV_PP_ALLOC
+	if (rate_limit->pp) {
+		mlx5_glue->dv_free_pp(rate_limit->pp);
+		rate_limit->pp = NULL;
+		rate_limit->pp_id = 0;
+		rate_limit->rate_mbps = 0;
+	}
+#else
+	RTE_SET_USED(rate_limit);
+#endif
+}
+
+/* Allocate a per-queue packet pacing index for data-rate limiting. */
+int
+mlx5_txq_alloc_pp_rate_limit(struct mlx5_dev_ctx_shared *sh,
+			     struct mlx5_txq_rate_limit *rate_limit,
+			     uint32_t rate_mbps)
+{
+#ifdef HAVE_MLX5DV_PP_ALLOC
+	uint32_t pp[MLX5_ST_SZ_DW(set_pp_rate_limit_context)];
+	uint64_t rate_kbps;
+	struct mlx5_hca_qos_attr *qos = &sh->cdev->config.hca_attr.qos;
+
+	if (rate_mbps == 0) {
+		DRV_LOG(ERR, "Rate must be greater than zero.");
+		rte_errno = EINVAL;
+		return -EINVAL;
+	}
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
+	rate_limit->pp = mlx5_glue->dv_alloc_pp(sh->cdev->ctx, sizeof(pp),
+						 &pp, 0);
+	if (rate_limit->pp == NULL) {
+		DRV_LOG(ERR, "Failed to allocate PP index for rate %u Mbps.",
+			rate_mbps);
+		rte_errno = errno;
+		return -errno;
+	}
+	rate_limit->pp_id = ((struct mlx5dv_pp *)rate_limit->pp)->index;
+	if (!rate_limit->pp_id) {
+		DRV_LOG(ERR, "Zero PP index allocated for rate %u Mbps.",
+			rate_mbps);
+		mlx5_txq_free_pp_rate_limit(rate_limit);
+		rte_errno = ENOTSUP;
+		return -ENOTSUP;
+	}
+	rate_limit->rate_mbps = rate_mbps;
+	DRV_LOG(DEBUG, "Allocated PP index %u for rate %u Mbps.",
+		rate_limit->pp_id, rate_mbps);
+	return 0;
+#else
+	RTE_SET_USED(sh);
+	RTE_SET_USED(rate_limit);
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
index 9275efb58e..3356c89758 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1344,6 +1344,7 @@ mlx5_txq_release(struct rte_eth_dev *dev, uint16_t idx)
 		mlx5_free(txq_ctrl->obj);
 		txq_ctrl->obj = NULL;
 	}
+	mlx5_txq_free_pp_rate_limit(&txq_ctrl->rate_limit);
 	if (!txq_ctrl->is_hairpin) {
 		if (txq_ctrl->txq.fcqs) {
 			mlx5_free(txq_ctrl->txq.fcqs);
-- 
2.43.0


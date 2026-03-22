Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51A9FC72AD
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 13:48:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 148874042E;
	Sun, 22 Mar 2026 14:48:30 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id B59274042C
 for <dev@dpdk.org>; Sun, 22 Mar 2026 14:48:28 +0100 (CET)
Received: from localhost.localdomain (unknown [78.240.46.143])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4BFEC780505;
 Sun, 22 Mar 2026 14:48:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774187308;
 bh=a5ceYumj0ud1TiRo/owr4bC2dzIyOf+DKWiCeYQqVNo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=raRl6JZMuJRgqBDlqXUIGJjHQqZTrw+djR0YV73bm1T++gUFaQyVZfAJm/B693uRW
 ZKaiQOCYYIrRDxNkIX5tzQvtjgbui0/tizGmjL8rchGyfrmx7GVdrkhvEsgKe1auzj
 zsToMtnZPwrMmOlUYNH+YpknTuqBoFNpi9DfL8V9s+cBKMZsaBjgmuqNE2EDbcCQwq
 79GJX1WyHzZ019YtpxcErhzpPBxn7B0PsVrR4WxHUFQ+KDMESBr4zXcYLEyo2AGoM5
 Evaw0V0Ucu5fP0N+/HGl3ACLaQ32/q0OlMgE38zONJwT4AgGj5UCCZZMCykfraKVMq
 SdGmdc3WIOpOg==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 06/10] net/mlx5: add burst pacing devargs
Date: Sun, 22 Mar 2026 14:46:25 +0100
Message-ID: <20260322134629.94633-7-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322134629.94633-1-vjardin@free.fr>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
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

Expose burst_upper_bound and typical_packet_size from the PRM
set_pp_rate_limit_context as devargs:
- tx_burst_bound=<bytes>: max burst before rate evaluation kicks in
- tx_typical_pkt_sz=<bytes>: typical packet size for accuracy

These parameters apply to per-queue rate limiting
(rte_eth_set_queue_rate_limit) only. The Clock Queue path
(tx_pp devarg) uses WQE rate pacing and does not need these
parameters.

Values are validated against HCA capabilities
(packet_pacing_burst_bound and packet_pacing_typical_size).
If the HW does not support them, a warning is logged and the
value is silently zeroed. Test mode still overrides both values.

Shared context mismatch checks ensure all ports on the same
device use the same burst parameters.

Supported hardware:
- ConnectX-6 Dx: burst_upper_bound and typical_packet_size
  reported via packet_pacing_burst_bound / packet_pacing_typical_size
  QoS capability bits
- ConnectX-7/8: full support for both parameters
- BlueField-2/3: same capabilities as host-side ConnectX

Not supported:
- ConnectX-5: may not report burst_bound or typical_size caps
- ConnectX-4 Lx and earlier: no packet_pacing at all

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 doc/guides/nics/mlx5.rst     | 17 +++++++++++++++
 drivers/net/mlx5/mlx5.c      | 42 ++++++++++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5.h      |  2 ++
 drivers/net/mlx5/mlx5_txpp.c |  6 ++++++
 4 files changed, 67 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c72a60f084..d0b403dd5c 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -580,6 +580,23 @@ for an additional list of options shared with other mlx5 drivers.
   (with ``tx_pp``) and ConnectX-7+ (wait-on-time) scheduling modes.
   The default value is zero.
 
+- ``tx_burst_bound`` parameter [int]
+
+  Specifies the burst upper bound in bytes for packet pacing rate evaluation.
+  When set, the hardware considers this burst size when enforcing the configured
+  rate limit. Only effective when the HCA reports ``packet_pacing_burst_bound``
+  capability. Applies to per-queue rate limiting
+  (``rte_eth_set_queue_rate_limit()``). The Clock Queue path (``tx_pp``)
+  uses WQE rate pacing and does not use this parameter.
+  The default value is zero (hardware default).
+
+- ``tx_typical_pkt_sz`` parameter [int]
+
+  Specifies the typical packet size in bytes for packet pacing rate accuracy
+  improvement. Only effective when the HCA reports
+  ``packet_pacing_typical_size`` capability. Applies to per-queue rate
+  limiting only. The default value is zero (hardware default).
+
 .. _mlx5_per_queue_rate_limit:
 
 Per-Queue Tx Rate Limiting
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index e718f0fa8c..7d08d7886b 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -119,6 +119,18 @@
  */
 #define MLX5_TX_SKEW "tx_skew"
 
+/*
+ * Device parameter to specify burst upper bound in bytes
+ * for packet pacing rate evaluation.
+ */
+#define MLX5_TX_BURST_BOUND "tx_burst_bound"
+
+/*
+ * Device parameter to specify typical packet size in bytes
+ * for packet pacing rate accuracy improvement.
+ */
+#define MLX5_TX_TYPICAL_PKT_SZ "tx_typical_pkt_sz"
+
 /*
  * Device parameter to enable hardware Tx vector.
  * Deprecated, ignored (no vectorized Tx routines anymore).
@@ -1407,6 +1419,10 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 		config->tx_pp = tmp;
 	} else if (strcmp(MLX5_TX_SKEW, key) == 0) {
 		config->tx_skew = tmp;
+	} else if (strcmp(MLX5_TX_BURST_BOUND, key) == 0) {
+		config->tx_burst_bound = tmp;
+	} else if (strcmp(MLX5_TX_TYPICAL_PKT_SZ, key) == 0) {
+		config->tx_typical_pkt_sz = tmp;
 	} else if (strcmp(MLX5_L3_VXLAN_EN, key) == 0) {
 		config->l3_vxlan_en = !!tmp;
 	} else if (strcmp(MLX5_VF_NL_EN, key) == 0) {
@@ -1481,8 +1497,10 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 				struct mlx5_sh_config *config)
 {
 	const char **params = (const char *[]){
+		MLX5_TX_BURST_BOUND,
 		MLX5_TX_PP,
 		MLX5_TX_SKEW,
+		MLX5_TX_TYPICAL_PKT_SZ,
 		MLX5_L3_VXLAN_EN,
 		MLX5_VF_NL_EN,
 		MLX5_DV_ESW_EN,
@@ -1557,6 +1575,18 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		DRV_LOG(WARNING,
 			"\"tx_skew\" doesn't affect without \"tx_pp\".");
 	}
+	if (config->tx_burst_bound &&
+	    !sh->cdev->config.hca_attr.qos.packet_pacing_burst_bound) {
+		DRV_LOG(WARNING,
+			"HW does not support burst_upper_bound, ignoring.");
+		config->tx_burst_bound = 0;
+	}
+	if (config->tx_typical_pkt_sz &&
+	    !sh->cdev->config.hca_attr.qos.packet_pacing_typical_size) {
+		DRV_LOG(WARNING,
+			"HW does not support typical_packet_size, ignoring.");
+		config->tx_typical_pkt_sz = 0;
+	}
 	/* Check for LRO support. */
 	if (mlx5_devx_obj_ops_en(sh) && sh->cdev->config.hca_attr.lro_cap) {
 		/* TBD check tunnel lro caps. */
@@ -3191,6 +3221,18 @@ mlx5_probe_again_args_validate(struct mlx5_common_device *cdev,
 			sh->ibdev_name);
 		goto error;
 	}
+	if (sh->config.tx_burst_bound != config->tx_burst_bound) {
+		DRV_LOG(ERR, "\"tx_burst_bound\" "
+			"configuration mismatch for shared %s context.",
+			sh->ibdev_name);
+		goto error;
+	}
+	if (sh->config.tx_typical_pkt_sz != config->tx_typical_pkt_sz) {
+		DRV_LOG(ERR, "\"tx_typical_pkt_sz\" "
+			"configuration mismatch for shared %s context.",
+			sh->ibdev_name);
+		goto error;
+	}
 	if (sh->config.txq_mem_algn != config->txq_mem_algn) {
 		DRV_LOG(ERR, "\"TxQ memory alignment\" "
 			"configuration mismatch for shared %s context. %u - %u",
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 33628d7987..5ae01ec491 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -383,6 +383,8 @@ struct mlx5_port_config {
 struct mlx5_sh_config {
 	int tx_pp; /* Timestamp scheduling granularity in nanoseconds. */
 	int tx_skew; /* Tx scheduling skew between WQE and data on wire. */
+	uint32_t tx_burst_bound; /* Burst upper bound in bytes, 0 = default. */
+	uint32_t tx_typical_pkt_sz; /* Typical packet size in bytes, 0 = default. */
 	uint32_t reclaim_mode:2; /* Memory reclaim mode. */
 	uint32_t dv_esw_en:1; /* Enable E-Switch DV flow. */
 	/* Enable DV flow. 1 means SW steering, 2 means HW steering. */
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index e34e996e9b..707ef9d111 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -176,6 +176,12 @@ mlx5_txq_alloc_pp_rate_limit(struct mlx5_dev_ctx_shared *sh,
 	memset(&pp, 0, sizeof(pp));
 	MLX5_SET(set_pp_rate_limit_context, &pp, rate_limit, (uint32_t)rate_kbps);
 	MLX5_SET(set_pp_rate_limit_context, &pp, rate_mode, MLX5_DATA_RATE);
+	if (sh->config.tx_burst_bound)
+		MLX5_SET(set_pp_rate_limit_context, &pp,
+			 burst_upper_bound, sh->config.tx_burst_bound);
+	if (sh->config.tx_typical_pkt_sz)
+		MLX5_SET(set_pp_rate_limit_context, &pp,
+			 typical_packet_size, sh->config.tx_typical_pkt_sz);
 	rate_limit->pp = mlx5_glue->dv_alloc_pp(sh->cdev->ctx, sizeof(pp),
 						 &pp, 0);
 	if (rate_limit->pp == NULL) {
-- 
2.43.0


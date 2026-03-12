Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED0106ACEE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4A474064F;
	Thu, 12 Mar 2026 23:03:48 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 5D4194060B
 for <dev@dpdk.org>; Thu, 12 Mar 2026 23:03:47 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5175378032A;
 Thu, 12 Mar 2026 23:03:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773353027;
 bh=o4aQPtFYiroi/G3CrP4qyJ1OoF+M7mD0tQiJeeszUFI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=omfedkYMjD3e7bAxgjcRSAynHvYbcTlSFCoNYBYLYimAyxFbRYxU4T76B+gsEG4Pq
 2ynn/nHyF5LoJf2NTrPifXRyPyN85i86GxdmzlpDLe5Oa4U3s27Pw+zbfj8RD+Ku9/
 FgRCE/UPU1pzWqCtivgIGlxt8uevQBl3fJFOqww0mAoxQeWOOFd0SHQC8FSPPnaI7i
 YtQUBsMyq3Y05mfUDoxcdfYndrWxol9YVgxeE2IJs8qHwWG401g+FL8/2mKietLUWr
 EZHVwM5xJI4Z+Ppx2AG2qnhv9wCBZLQF7dVTC0I8LbsWXNWbtuvRHWLXH5udDj6CQ/
 e+jOIlColCXaA==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 09/9] net/mlx5: add rate table capacity query API
Date: Thu, 12 Mar 2026 23:01:20 +0100
Message-ID: <20260312220120.3256755-10-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312220120.3256755-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
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

Add rte_pmd_mlx5_pp_rate_table_query() to report the HW packet
pacing rate table size and how many entries are currently in use.

The total comes from the HCA QoS capability
packet_pacing_rate_table_size. The used count is derived by
collecting unique non-zero PP indices across all TX queues.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/mlx5/mlx5_tx.c      | 64 +++++++++++++++++++++++++++++++++
 drivers/net/mlx5/rte_pmd_mlx5.h | 32 +++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index fa57d3ef98..968aceb24f 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -19,6 +19,7 @@
 
 #include <mlx5_prm.h>
 #include <mlx5_common.h>
+#include <mlx5_malloc.h>
 
 #include "mlx5_autoconf.h"
 #include "mlx5_defs.h"
@@ -886,3 +887,66 @@ int rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
 				     packet_pacing_rate_limit_index);
 	return 0;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_pp_rate_table_query, 26.07)
+int rte_pmd_mlx5_pp_rate_table_query(uint16_t port_id,
+				     struct rte_pmd_mlx5_pp_rate_table_info *info)
+{
+	struct rte_eth_dev *dev;
+	struct mlx5_priv *priv;
+	uint16_t used = 0;
+	uint16_t *seen;
+	unsigned int i;
+
+	if (info == NULL)
+		return -EINVAL;
+	if (!rte_eth_dev_is_valid_port(port_id))
+		return -ENODEV;
+	dev = &rte_eth_devices[port_id];
+	priv = dev->data->dev_private;
+	if (!priv->sh->cdev->config.hca_attr.qos.packet_pacing) {
+		rte_errno = ENOTSUP;
+		return -ENOTSUP;
+	}
+	info->total = priv->sh->cdev->config.hca_attr.qos.packet_pacing_rate_table_size;
+	if (priv->txqs == NULL || priv->txqs_n == 0) {
+		info->used = 0;
+		return 0;
+	}
+	seen = mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO,
+			   priv->txqs_n * sizeof(*seen), 0, SOCKET_ID_ANY);
+	if (seen == NULL)
+		return -ENOMEM;
+	/*
+	 * Count unique non-zero PP indices across this port's TX queues.
+	 * Note: the count reflects only queues on this port; other ports
+	 * sharing the same device may also consume rate table entries.
+	 */
+	for (i = 0; i < priv->txqs_n; i++) {
+		struct mlx5_txq_data *txq_data;
+		struct mlx5_txq_ctrl *txq_ctrl;
+		uint16_t pp_id;
+		uint16_t j;
+		bool dup;
+
+		if ((*priv->txqs)[i] == NULL)
+			continue;
+		txq_data = (*priv->txqs)[i];
+		txq_ctrl = container_of(txq_data, struct mlx5_txq_ctrl, txq);
+		pp_id = txq_ctrl->rl.pp_id;
+		if (pp_id == 0)
+			continue;
+		dup = false;
+		for (j = 0; j < used; j++) {
+			if (seen[j] == pp_id) {
+				dup = true;
+				break;
+			}
+		}
+		if (!dup)
+			seen[used++] = pp_id;
+	}
+	mlx5_free(seen);
+	info->used = used;
+	return 0;
+}
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index 698d7d2032..f7970dd7fb 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -450,6 +450,38 @@ int
 rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
 				  struct rte_pmd_mlx5_txq_rate_limit_info *info);
 
+/**
+ * Packet pacing rate table capacity information.
+ */
+struct rte_pmd_mlx5_pp_rate_table_info {
+	uint16_t total;		/**< Total HW rate table entries. */
+	uint16_t used;		/**< Currently allocated entries. */
+};
+
+/**
+ * Query packet pacing rate table capacity.
+ *
+ * The ``used`` count reflects only the queried port's TX queues.
+ * Other ports sharing the same physical device may also consume
+ * rate table entries that are not included in this count.
+ *
+ * @param[in] port_id
+ *   Port ID.
+ * @param[out] info
+ *   Rate table capacity information.
+ *
+ * @return
+ *   0 on success, negative errno on failure:
+ *   - -ENODEV: invalid port_id.
+ *   - -EINVAL: info is NULL.
+ *   - -ENOTSUP: packet pacing not supported.
+ *   - -ENOMEM: allocation failure.
+ */
+__rte_experimental
+int
+rte_pmd_mlx5_pp_rate_table_query(uint16_t port_id,
+				 struct rte_pmd_mlx5_pp_rate_table_info *info);
+
 /** Type of mlx5 driver event for which custom callback is called. */
 enum rte_pmd_mlx5_driver_event_cb_type {
 	/** Called after HW Rx queue is created. */
-- 
2.43.0


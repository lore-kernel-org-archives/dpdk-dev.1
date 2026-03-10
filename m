Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF8EA8550
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8CCA40BA2;
	Tue, 10 Mar 2026 10:22:51 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 564B74060A
 for <dev@dpdk.org>; Tue, 10 Mar 2026 10:22:50 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id C9035780375;
 Tue, 10 Mar 2026 10:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773134570;
 bh=mSXKSpnFPPkm4J9eDOZCFhHaw+QGgRFkaOOw53ZrssE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LsTD+kQUhs6t1/dnzOlZYupaXojyGCf08o/QiOKqY2GJt+uctvotJdQkMxlbt11KI
 YDvC09sswP61fLOcuggglFUJ475ySPBY06Sembj/oQZvVicbztK4i138GeCVJGQ73s
 CWNMxWxT2dKWjkqwatekDBlhEAlqDqUZi0JngOJ/ViIYyv7Q48xAJ2SNj121qDt7Te
 RPOjzcj7+TMfsAHJeCwsGMbTDAUkoHNrUCoH+fc/k4xGfl+UBmP0f0bZWx2ywVcBKk
 Xi4/C7lmzHlLjn3FpEEvEtx6X7E1ODG2zIHGRKpyfAPQVFfTK+Y4SDZcyxCn/XyFK3
 bVwTaD2icWbkA==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 10/10] net/mlx5: add rate table capacity query API
Date: Tue, 10 Mar 2026 10:20:14 +0100
Message-ID: <20260310092014.2762894-11-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310092014.2762894-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
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
 drivers/net/mlx5/mlx5_tx.c      | 51 +++++++++++++++++++++++++++++++++
 drivers/net/mlx5/rte_pmd_mlx5.h | 27 +++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 7051390a5e..4cd0e1ce60 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -886,3 +886,54 @@ int rte_pmd_mlx5_txq_rate_limit_query(uint16_t port_id, uint16_t queue_id,
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
+	uint16_t seen[RTE_MAX_QUEUES_PER_PORT];
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
+	info->total = priv->sh->cdev->config.hca_attr.qos
+			.packet_pacing_rate_table_size;
+	/* Count unique non-zero PP indices across all TX queues. */
+	for (i = 0; i < priv->txqs_n; i++) {
+		struct mlx5_txq_data *txq_data;
+		struct mlx5_txq_ctrl *txq_ctrl;
+		uint16_t pp_id;
+		uint16_t j;
+		bool dup;
+
+		if (priv->txqs == NULL || (*priv->txqs)[i] == NULL)
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
+		if (!dup && used < RTE_DIM(seen))
+			seen[used++] = pp_id;
+	}
+	info->used = used;
+	return 0;
+}
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index 698d7d2032..4033b9acc7 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -450,6 +450,33 @@ int
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


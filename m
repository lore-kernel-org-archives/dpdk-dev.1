Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F2EFD88CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 23:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6547140E25;
	Wed, 11 Mar 2026 00:29:27 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id F3DBB40B9D
 for <dev@dpdk.org>; Wed, 11 Mar 2026 00:29:25 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 3FDA7780372;
 Wed, 11 Mar 2026 00:29:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773185365;
 bh=kv0o1YEvw1vbA0RcCIeKu7HfTQaIRB/6XO//PzaW2Bo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gkJ6SpbPoq79Db51YdHrpNMhZJb233NeRukpx843pC4hl93/Dw4vhzGmJptqywpUe
 UN435T4fPaqqxFFrGhWKgnYX5pMwzmEght8hCjzO1MJfhHhXjGDeNqATokB911HCFj
 p0e2KlJ/ZsmSzzN4A3V16ta0f4VJhVO1EK+kQ6irGz5eAtOrYs2NLQ51MSk07hdY2r
 HDFM69+jf3xyfyK1yJ/ksvxdum7X1OLPW+XyFJ2naIBuD7zDZhKvyaxTGPzvYUZI7F
 ax+yAPS299ri+Nc3sB4MKFgHApjxivr5Y6Rhkg6PpgSw/treWdCDiMI5wMOz+i3ReD
 jc/jWwqn36u1A==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 08/10] ethdev: add getter for per-queue Tx rate limit
Date: Wed, 11 Mar 2026 00:26:51 +0100
Message-ID: <20260310232653.2935764-9-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310232653.2935764-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
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

The existing rte_eth_set_queue_rate_limit() API allows setting a
per-queue Tx rate but provides no way to read it back. Applications
such as grout are forced to maintain a shadow copy of the rate to
be able to report it.

Add rte_eth_get_queue_rate_limit() as the symmetric getter, following
the established DPDK pattern (e.g. rte_eth_dev_set_mtu/get_mtu,
rte_eth_dev_set_vlan_offload/get_vlan_offload).

This adds:
- eth_get_queue_rate_limit_t driver callback in ethdev_driver.h
- rte_eth_get_queue_rate_limit() public experimental API (26.07)
- mlx5 PMD implementation reading from the existing per-queue
  rate_mbps tracking field

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 doc/guides/rel_notes/release_26_03.rst |  5 ++++
 drivers/net/mlx5/mlx5.c                |  2 ++
 drivers/net/mlx5/mlx5_tx.h             |  2 ++
 drivers/net/mlx5/mlx5_txq.c            | 34 ++++++++++++++++++++++++++
 lib/ethdev/ethdev_driver.h             |  7 ++++++
 lib/ethdev/rte_ethdev.c                | 28 +++++++++++++++++++++
 lib/ethdev/rte_ethdev.h                | 24 ++++++++++++++++++
 7 files changed, 102 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..5afb2fd6d9 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added per-queue Tx rate limit getter to ethdev.**
+
+  Added ``rte_eth_get_queue_rate_limit()`` experimental API
+  to retrieve the current per-queue Tx rate limit configured on a device.
+
 * **Added custom memory allocation hooks in ACL library.**
 
   Added a hook API mechanism
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index f399e0d5c9..6e21ed31f3 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2721,6 +2721,7 @@ const struct eth_dev_ops mlx5_dev_ops = {
 	.rx_metadata_negotiate = mlx5_flow_rx_metadata_negotiate,
 	.get_restore_flags = mlx5_get_restore_flags,
 	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
+	.get_queue_rate_limit = mlx5_get_queue_rate_limit,
 };
 
 /* Available operations from secondary process. */
@@ -2815,6 +2816,7 @@ const struct eth_dev_ops mlx5_dev_ops_isolate = {
 	.map_aggr_tx_affinity = mlx5_map_aggr_tx_affinity,
 	.get_restore_flags = mlx5_get_restore_flags,
 	.set_queue_rate_limit = mlx5_set_queue_rate_limit,
+	.get_queue_rate_limit = mlx5_get_queue_rate_limit,
 };
 
 /**
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 3a37f5bb4d..46e199d93e 100644
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
index 155d544434..d5dab4f14a 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1479,6 +1479,40 @@ mlx5_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
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
+	if (queue_idx >= dev->data->nb_tx_queues) {
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	if (priv->txqs == NULL || (*priv->txqs)[queue_idx] == NULL) {
+		rte_errno = EINVAL;
+		return -rte_errno;
+	}
+	txq_ctrl = container_of((*priv->txqs)[queue_idx],
+				struct mlx5_txq_ctrl, txq);
+	*tx_rate = txq_ctrl->rl.rate_mbps;
+	return 0;
+}
+
 /**
  * Verify if the queue can be released.
  *
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 1255cd6f2c..0f336f9567 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -762,6 +762,11 @@ typedef int (*eth_set_queue_rate_limit_t)(struct rte_eth_dev *dev,
 				uint16_t queue_idx,
 				uint32_t tx_rate);
 
+/** @internal Get queue Tx rate. */
+typedef int (*eth_get_queue_rate_limit_t)(struct rte_eth_dev *dev,
+				uint16_t queue_idx,
+				uint32_t *tx_rate);
+
 /** @internal Add tunneling UDP port. */
 typedef int (*eth_udp_tunnel_port_add_t)(struct rte_eth_dev *dev,
 					 struct rte_eth_udp_tunnel *tunnel_udp);
@@ -1522,6 +1527,8 @@ struct eth_dev_ops {
 
 	/** Set queue rate limit */
 	eth_set_queue_rate_limit_t set_queue_rate_limit;
+	/** Get queue rate limit */
+	eth_get_queue_rate_limit_t get_queue_rate_limit;
 
 	/** Configure RSS hash protocols and hashing key */
 	rss_hash_update_t          rss_hash_update;
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..c6ad399033 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -5694,6 +5694,34 @@ int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_queue_rate_limit, 26.07)
+int rte_eth_get_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
+					uint32_t *tx_rate)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (tx_rate == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Get queue rate limit:port %u: NULL tx_rate pointer",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (queue_idx >= dev->data->nb_tx_queues) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Get queue rate limit:port %u: invalid queue ID=%u",
+			port_id, queue_idx);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->get_queue_rate_limit == NULL)
+		return -ENOTSUP;
+	return eth_err(port_id, dev->dev_ops->get_queue_rate_limit(dev, queue_idx, tx_rate));
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07)
 int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			       uint8_t avail_thresh)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0d8e2d0236..e525217b77 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -4817,6 +4817,30 @@ int rte_eth_dev_uc_all_hash_table_set(uint16_t port_id, uint8_t on);
 int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 			uint32_t tx_rate);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Get the rate limitation for a queue on an Ethernet device.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param queue_idx
+ *   The queue ID.
+ * @param[out] tx_rate
+ *   A pointer to retrieve the Tx rate in Mbps.
+ *   0 means rate limiting is disabled.
+ * @return
+ *   - (0) if successful.
+ *   - (-ENOTSUP) if hardware doesn't support this feature.
+ *   - (-ENODEV) if *port_id* invalid.
+ *   - (-EIO) if device is removed.
+ *   - (-EINVAL) if bad parameter.
+ */
+__rte_experimental
+int rte_eth_get_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
+			uint32_t *tx_rate);
+
 /**
  * Configuration of Receive Side Scaling hash computation of Ethernet device.
  *
-- 
2.43.0


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F89CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 09:29:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4C094064E;
	Fri,  8 May 2026 11:29:08 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 46BD840268
 for <dev@dpdk.org>; Fri,  8 May 2026 11:29:06 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=uDfoVVlqiz31Q076ZujUs0mEUP12jJcdt7hCJD466b4=;
 b=hkc73NulYUlYFBfUuVmkDN3RMsR1V+Uxd4xPukzxp/0J17/iqOGKBYjqXXQT5AuibRQJL/Rbm
 TOyo6JMlEGMycuKLMcsP8rbCeDR/G5/nhNh1gzoFafD1ZgNp2Kc0m318/rtDYevLZnFW5RWEjAV
 HVpxlZbot/2uf7p+AJqLSGM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gBkBz23lQzRhR9;
 Fri,  8 May 2026 17:21:31 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 07AF440538;
 Fri,  8 May 2026 17:29:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 17:29:04 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: [PATCH v1 2/4] ethdev: introduce generic cache stash API
Date: Fri, 8 May 2026 17:28:53 +0800
Message-ID: <20260508092855.51987-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508092855.51987-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Introduce a generic Ethernet device API for cache stashing,
supporting hardware mechanisms such as PCIe TPH (Transaction
Processing Hints).

The API provides:
- Generic query for supported stashing types and objects
- Device-wide stashing enable/disable
- Per-queue stashing with target lcore and data objects
  (Rx/Tx descriptor, header, payload)

The design allows a device to support multiple stashing types
while only allowing one active type at runtime.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/ethdev_driver.h | 37 +++++++++++++++
 lib/ethdev/rte_ethdev.c    | 40 ++++++++++++++++
 lib/ethdev/rte_ethdev.h    | 95 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 1255cd6f2c..e7b4167939 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1409,6 +1409,38 @@ enum rte_eth_dev_operation {
 typedef uint64_t (*eth_get_restore_flags_t)(struct rte_eth_dev *dev,
 					    enum rte_eth_dev_operation op);
 
+/**
+ * @internal
+ * Get cache stash capabilities of the Ethernet device.
+ *
+ * @param dev
+ *   Port (ethdev) handle.
+ * @param capa
+ *   Pointer to capability structure to store supported stash types and objects.
+ *
+ * @return
+ *   Negative on error, 0 on success.
+ */
+typedef int (*eth_cache_stash_get_t)(struct rte_eth_dev *dev,
+				     struct rte_eth_cache_stash_capability *capa);
+
+/**
+ * @internal
+ * Configure cache stash for the Ethernet device or queue.
+ *
+ * @param dev
+ *   Port (ethdev) handle.
+ * @param op
+ *   Cache stash operation type (enable/disable device or queue).
+ * @param config
+ *   Cache stash configuration (device or queue level).
+ *
+ * @return
+ *   Negative on error, 0 on success.
+ */
+typedef int (*eth_cache_stash_set_t)(struct rte_eth_dev *dev, enum rte_eth_cache_stash_op op,
+				     struct rte_eth_cache_stash_config *config);
+
 /**
  * @internal A structure containing the functions exported by an Ethernet driver.
  */
@@ -1661,6 +1693,11 @@ struct eth_dev_ops {
 
 	/** Get configuration which ethdev should restore */
 	eth_get_restore_flags_t get_restore_flags;
+
+	/** Cache stash get ops */
+	eth_cache_stash_get_t cache_stash_get;
+	/** Cache stash set ops */
+	eth_cache_stash_set_t cache_stash_set;
 };
 
 /**
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..4398aca5e1 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -7460,5 +7460,45 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cache_stash_get, 26.03)
+int
+rte_eth_cache_stash_get(uint16_t port_id,
+			struct rte_eth_cache_stash_capability *capa)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	if (capa == NULL)
+		return -EINVAL;
+
+	dev = &rte_eth_devices[port_id];
+
+	if (*dev->dev_ops->cache_stash_get == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id, (*dev->dev_ops->cache_stash_get)(dev, capa));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cache_stash_set, 26.03)
+int
+rte_eth_cache_stash_set(uint16_t port_id, enum rte_eth_cache_stash_op op,
+		       struct rte_eth_cache_stash_config *config)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	if (op != RTE_ETH_CACHE_STASH_OP_DEV_DISABLE && config == NULL)
+		return -EINVAL;
+
+	dev = &rte_eth_devices[port_id];
+
+	if (*dev->dev_ops->cache_stash_set == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id, (*dev->dev_ops->cache_stash_set)(dev, op, config));
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_eth_dev_logtype, INFO);
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0d8e2d0236..014f0c21b6 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -7178,6 +7178,101 @@ rte_eth_tx_queue_count(uint16_t port_id, uint16_t queue_id)
 	return rc;
 }
 
+/**
+ * Cache stash mechanisms (bitmask).
+ * A device may support multiple types but can only enable one at a time.
+ */
+enum rte_eth_cache_stash_type {
+	RTE_ETH_CACHE_STASH_TYPE_TPH = RTE_BIT32(0),
+};
+
+/**
+ * Cache stash objects (bitmask).
+ */
+#define RTE_ETH_CACHE_STASH_OBJ_RX_DESC		RTE_BIT64(0)
+#define RTE_ETH_CACHE_STASH_OBJ_TX_DESC         RTE_BIT64(1)
+#define RTE_ETH_CACHE_STASH_OBJ_RX_HEADER	RTE_BIT64(2)
+#define RTE_ETH_CACHE_STASH_OBJ_TX_HEADER       RTE_BIT64(3)
+#define RTE_ETH_CACHE_STASH_OBJ_RX_PAYLOAD	RTE_BIT64(4)
+#define RTE_ETH_CACHE_STASH_OBJ_TX_PAYLOAD	RTE_BIT64(5)
+
+/**
+ * Cache stash capability.
+ */
+struct rte_eth_cache_stash_capability {
+	uint32_t supported_types;  /**< Bitmask of rte_eth_cache_stash_type */
+	uint64_t supported_objects;/**< Bitmask of RTE_ETH_CACHE_STASH_OBJ_* */
+};
+
+/**
+ * Cache stash operations.
+ */
+enum rte_eth_cache_stash_op {
+	RTE_ETH_CACHE_STASH_OP_DEV_ENABLE,	/**< Enable device-wide cache stash */
+	RTE_ETH_CACHE_STASH_OP_DEV_DISABLE,	/**< Disable device-wide cache stash */
+	RTE_ETH_CACHE_STASH_OP_QUEUE_ENABLE,	/**< Enable cache stash for a queue */
+	RTE_ETH_CACHE_STASH_OP_QUEUE_DISABLE,	/**< Disable cache stash for a queue */
+	RTE_ETH_CACHE_STASH_OP_BUTT
+};
+
+/**
+ * Cache stash configuration.
+ * The used union member is determined by the operation.
+ */
+struct rte_eth_cache_stash_config {
+	union {
+		/**
+		 * Device-level configuration (used with DEV_ENABLE).
+		 */
+		struct {
+			uint32_t type;	/**< Selected stash mechanism type */
+		} dev;
+		/**
+		 * Queue-level configuration (used with QUEUE_ENABLE/QUEUE_DISABLE).
+		 */
+		struct {
+			uint32_t lcore_id;	/**< Target CPU core ID */
+			uint32_t queue_id;	/**< Queue ID */
+			uint64_t objects;	/**< Objects bitmask to stash */
+		} queue;
+	};
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Get cache stash capabilities of a port.
+ *
+ * @param port_id
+ *   The port identifier.
+ * @param capa
+ *   Output: supported stash types and objects.
+ * @return
+ *   0 on success, negative on error.
+ */
+__rte_experimental
+int rte_eth_cache_stash_get(uint16_t port_id, struct rte_eth_cache_stash_capability *capa);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Configure cache stash.
+ *
+ * @param port_id
+ *   The port identifier.
+ * @param op
+ *   Configuration operation.
+ * @param config
+ *   Configuration structure.
+ * @return
+ *   0 on success, negative on error.
+ */
+__rte_experimental
+int rte_eth_cache_stash_set(uint16_t port_id, enum rte_eth_cache_stash_op op,
+			    struct rte_eth_cache_stash_config *config);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.17.1


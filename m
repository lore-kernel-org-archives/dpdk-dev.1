Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F458C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 22:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95EDB4064E;
	Tue,  3 Jun 2025 00:38:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id F35CF4028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 00:38:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E6E2364;
 Mon,  2 Jun 2025 15:37:58 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CA5F3F5A1;
 Mon,  2 Jun 2025 15:38:14 -0700 (PDT)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, nd@arm.com, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: [PATCH v5 3/4] ethdev: introduce the cache stashing hints API
Date: Mon,  2 Jun 2025 22:38:03 +0000
Message-ID: <20250602223805.816816-4-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602223805.816816-1-wathsala.vithanage@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
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

Extend the ethdev library to enable the stashing of different data
objects, such as the ones listed below, into CPU caches directly
from the NIC.

- Rx/Tx queue descriptors
- Rx packets
- Packet headers
- packet payloads
- Data of a packet at an offset from the start of the packet

The APIs are designed in a hardware/vendor agnostic manner such that
supporting PMDs could use any capabilities available in the underlying
hardware for fine-grained stashing of data objects into a CPU cache

The API provides an interface to query the availability of stashing
capabilities, i.e., platform/NIC support, stashable object types, etc,
via the rte_eth_dev_stashing_capabilities_get interface.

The function pair rte_eth_dev_stashing_rx_config_set and
rte_eth_dev_stashing_tx_config_set sets the stashing hint (the CPU, 
cache level, and data object types) on the Rx and Tx queues.

PMDs that support stashing must register their implementations with the
following eth_dev_ops callbacks, which are invoked by the ethdev
functions listed above.

- stashing_capabilities_get
- stashing_rx_hints_set
- stashing_tx_hints_set

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
---
 lib/ethdev/ethdev_driver.h |  66 ++++++++++++++++
 lib/ethdev/rte_ethdev.c    | 149 ++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h    | 158 +++++++++++++++++++++++++++++++++++++
 3 files changed, 373 insertions(+)

diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..8a4012db08 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1376,6 +1376,68 @@ enum rte_eth_dev_operation {
 typedef uint64_t (*eth_get_restore_flags_t)(struct rte_eth_dev *dev,
 					    enum rte_eth_dev_operation op);
 
+/**
+ * @internal
+ * Set cache stashing hints in Rx queue.
+ *
+ * @param dev
+ *   Port (ethdev) handle.
+ * @param queue_id
+ *   Rx queue.
+ * @param config
+ *   Stashing hints configuration for the queue.
+ *
+ * @return
+ *   -ENOTSUP if the device or the platform does not support cache stashing.
+ *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing feature.
+ *   -EINVAL  on invalid arguments.
+ *   0 on success.
+ */
+typedef int (*eth_stashing_rx_hints_set_t)(struct rte_eth_dev *dev, uint16_t queue_id,
+					   struct rte_eth_stashing_config *config);
+
+/**
+ * @internal
+ * Set cache stashing hints in Tx queue.
+ *
+ * @param dev
+ *   Port (ethdev) handle.
+ * @param queue_id
+ *   Tx queue.
+ * @param config
+ *   Stashing hints configuration for the queue.
+ *
+ * @return
+ *   -ENOTSUP if the device or the platform does not support cache stashing.
+ *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing feature.
+ *   -EINVAL  on invalid arguments.
+ *   0 on success.
+ */
+typedef int (*eth_stashing_tx_hints_set_t)(struct rte_eth_dev *dev, uint16_t queue_id,
+					   struct rte_eth_stashing_config *config);
+
+/**
+ * @internal
+ * Get cache stashing object types supported in the ethernet device.
+ * The return value indicates availability of stashing hints support
+ * in the hardware and the PMD.
+ *
+ * @param dev
+ *   Port (ethdev) handle.
+ * @param objects
+ *   PMD sets supported bits on return.
+ *
+ * @return
+ *   -ENOTSUP if the device or the platform does not support cache stashing.
+ *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing feature.
+ *   -EINVAL  on NULL values for types or hints parameters.
+ *   On return, types and hints parameters will have bits set for supported
+ *   object types and hints.
+ *   0 on success.
+ */
+typedef int (*eth_stashing_capabilities_get_t)(struct rte_eth_dev *dev,
+					     uint16_t *objects);
+
 /**
  * @internal A structure containing the functions exported by an Ethernet driver.
  */
@@ -1402,6 +1464,10 @@ struct eth_dev_ops {
 	eth_mac_addr_remove_t      mac_addr_remove; /**< Remove MAC address */
 	eth_mac_addr_add_t         mac_addr_add;  /**< Add a MAC address */
 	eth_mac_addr_set_t         mac_addr_set;  /**< Set a MAC address */
+	eth_stashing_rx_hints_set_t   stashing_rx_hints_set; /**< Set Rx cache stashing*/
+	eth_stashing_tx_hints_set_t   stashing_tx_hints_set; /**< Set Tx cache stashing*/
+	/** Get supported stashing hints*/
+	eth_stashing_capabilities_get_t stashing_capabilities_get;
 	/** Set list of multicast addresses */
 	eth_set_mc_addr_list_t     set_mc_addr_list;
 	mtu_set_t                  mtu_set;       /**< Set MTU */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d4197322a0..ae666c370b 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -158,6 +158,7 @@ static const struct {
 	{RTE_ETH_DEV_CAPA_RXQ_SHARE, "RXQ_SHARE"},
 	{RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP, "FLOW_RULE_KEEP"},
 	{RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP, "FLOW_SHARED_OBJECT_KEEP"},
+	{RTE_ETH_DEV_CAPA_CACHE_STASHING, "CACHE_STASHING"},
 };
 
 enum {
@@ -7419,5 +7420,153 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_validate_stashing_config, 25.07)
+int
+rte_eth_dev_validate_stashing_config(uint16_t port_id, uint16_t queue_id,
+				     uint8_t queue_direction,
+				     struct rte_eth_stashing_config *config)
+{
+	struct rte_eth_dev *dev;
+	struct rte_eth_dev_info dev_info;
+	int ret = 0;
+	uint16_t nb_queues;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	if (!config) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Invalid stashing configuration");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Check for invalid objects
+	 */
+	if (!RTE_ETH_DEV_STASH_OBJECTS_VALID(config->objects)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Invalid stashing objects");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev = &rte_eth_devices[port_id];
+
+	nb_queues = (queue_direction == RTE_ETH_DEV_RX_QUEUE) ?
+				      dev->data->nb_rx_queues :
+				      dev->data->nb_tx_queues;
+
+	if (queue_id >= nb_queues) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Invalid Rx queue_id=%u", queue_id);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = rte_eth_dev_info_get(port_id, &dev_info);
+	if (ret < 0)
+		goto out;
+
+	if ((dev_info.dev_capa & RTE_ETH_DEV_CAPA_CACHE_STASHING) !=
+	    RTE_ETH_DEV_CAPA_CACHE_STASHING) {
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	if (*dev->dev_ops->stashing_rx_hints_set == NULL ||
+	    *dev->dev_ops->stashing_tx_hints_set == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Stashing hints are not implemented "
+				    "in %s for %s", dev_info.driver_name,
+				    dev_info.device->name);
+		ret = -ENOSYS;
+	}
+
+out:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_rx_config_set, 25.07)
+int
+rte_eth_dev_stashing_rx_config_set(uint16_t port_id, uint16_t queue_id,
+				   struct rte_eth_stashing_config *config)
+{
+	struct rte_eth_dev *dev;
+	int ret = 0;
+
+	ret = rte_eth_dev_validate_stashing_config(port_id, queue_id,
+						   RTE_ETH_DEV_RX_QUEUE,
+						   config);
+	if (ret < 0)
+		goto out;
+
+	dev = &rte_eth_devices[port_id];
+
+	ret = eth_err(port_id,
+		      (*dev->dev_ops->stashing_rx_hints_set)(dev, queue_id,
+		      config));
+out:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_tx_config_set, 25.07)
+int
+rte_eth_dev_stashing_tx_config_set(uint16_t port_id, uint16_t queue_id,
+				   struct rte_eth_stashing_config *config)
+{
+	struct rte_eth_dev *dev;
+	int ret = 0;
+
+	ret = rte_eth_dev_validate_stashing_config(port_id, queue_id,
+						   RTE_ETH_DEV_TX_QUEUE,
+						   config);
+	if (ret < 0)
+		goto out;
+
+	dev = &rte_eth_devices[port_id];
+
+	ret = eth_err(port_id,
+		      (*dev->dev_ops->stashing_rx_hints_set) (dev, queue_id,
+		       config));
+out:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_capabilities_get, 25.07)
+int
+rte_eth_dev_stashing_capabilities_get(uint16_t port_id, uint16_t *objects)
+{
+	struct rte_eth_dev *dev;
+	struct rte_eth_dev_info dev_info;
+	int ret = 0;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	if (!objects) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev = &rte_eth_devices[port_id];
+
+	ret = rte_eth_dev_info_get(port_id, &dev_info);
+	if (ret < 0)
+		goto out;
+
+	if ((dev_info.dev_capa & RTE_ETH_DEV_CAPA_CACHE_STASHING) !=
+	    RTE_ETH_DEV_CAPA_CACHE_STASHING) {
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	if (*dev->dev_ops->stashing_capabilities_get == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Stashing hints are not implemented "
+				    "in %s for %s", dev_info.driver_name,
+				    dev_info.device->name);
+		ret = -ENOSYS;
+		goto out;
+	}
+	ret = eth_err(port_id,
+		      (*dev->dev_ops->stashing_capabilities_get)(dev, objects));
+out:
+	return ret;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_eth_dev_logtype, INFO);
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..1398f8c837 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1667,6 +1667,9 @@ struct rte_eth_conf {
 #define RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP RTE_BIT64(4)
 /**@}*/
 
+/** Device supports stashing to CPU/system caches. */
+#define RTE_ETH_DEV_CAPA_CACHE_STASHING RTE_BIT64(5)
+
 /*
  * Fallback default preferred Rx/Tx port parameters.
  * These are used if an application requests default parameters
@@ -1838,6 +1841,7 @@ struct rte_eth_dev_info {
 	struct rte_eth_dev_portconf default_txportconf;
 	/** Generic device capabilities (RTE_ETH_DEV_CAPA_). */
 	uint64_t dev_capa;
+	uint16_t stashing_capa;
 	/**
 	 * Switching information for ports on a device with a
 	 * embedded managed interconnect/switch.
@@ -6173,6 +6177,160 @@ int rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *
 __rte_experimental
 int rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config);
 
+
+/** Queue type is RX. */
+#define RTE_ETH_DEV_RX_QUEUE		0
+/** Queue type is TX. */
+#define RTE_ETH_DEV_TX_QUEUE		1
+
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change, or be removed, without prior notice
+ *
+ * A structure used for configuring the cache stashing hints.
+ */
+struct rte_eth_stashing_config {
+	/**
+	 * lcore_id of the processor the stashing hints are applied to.
+	 */
+	uint32_t	lcore_id;
+	/**
+	 * Zero based cache level relative to the CPU.
+	 * E.g. l1d = 0, l2d = 1,...
+	 */
+	uint32_t	cache_level;
+	/**
+	 * Object types the configuration is applied to
+	 */
+	uint16_t	objects;
+	/**
+	 * The offset if RTE_ETH_DEV_STASH_OBJECT_OFFSET bit is set
+	 *  in objects
+	 */
+	int		offset;
+};
+
+/**@{@name Stashable Rx/Tx queue object types supported by the ethernet device
+ *@see rte_eth_dev_stashing_capabilities_get
+ *@see rte_eth_dev_stashing_rx_config_set
+ *@see rte_eth_dev_stashing_tx_config_set
+ */
+
+/**
+ * Apply stashing hint to data at a given offset from the start of a
+ * received packet.
+ */
+#define RTE_ETH_DEV_STASH_OBJECT_OFFSET		0x0001
+
+/** Apply stashing hint to an rx descriptor. */
+#define RTE_ETH_DEV_STASH_OBJECT_DESC		0x0002
+
+/** Apply stashing hint to a header of a received packet. */
+#define RTE_ETH_DEV_STASH_OBJECT_HEADER		0x0004
+
+/** Apply stashing hint to a payload of a received packet. */
+#define RTE_ETH_DEV_STASH_OBJECT_PAYLOAD	0x0008
+
+#define __RTE_ETH_DEV_STASH_OBJECT_MASK		0x000f
+/**@}*/
+
+#define RTE_ETH_DEV_STASH_OBJECTS_VALID(t)				\
+	((!((t) & (~__RTE_ETH_DEV_STASH_OBJECT_MASK))) && (t))
+
+/**
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * @internal
+ * Helper function to validate stashing hints configuration.
+ */
+__rte_experimental
+int rte_eth_dev_validate_stashing_config(uint16_t port_id, uint16_t queue_id,
+					 uint8_t queue_direction,
+					 struct rte_eth_stashing_config *config);
+
+/**
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Provide cache stashing hints for improved memory access latencies for
+ * packets received by the NIC.
+ * This feature is available only in supported NICs and platforms.
+ *
+ * @param port_id
+ *  The port identifier of the Ethernet device.
+ * @param queue_id
+ *  The index of the receive queue to which hints are applied.
+ * @param config
+ *  Stashing configuration.
+ * @return
+ *  - (-ENODEV) on incorrect port_ids.
+ *  - (-EINVAL) if both RX and TX object types used in conjuection in objects
+ *  parameter.
+ *  - (-EINVAL) on invalid queue_id.
+ *  - (-ENOTSUP) if RTE_ETH_DEV_CAPA_CACHE_STASHING capability is unavailable.
+ *  - (-ENOSYS) if PMD does not implement cache stashing hints.
+ *  - (0) on Success.
+ */
+__rte_experimental
+int rte_eth_dev_stashing_rx_config_set(uint16_t port_id, uint16_t queue_id,
+				   struct rte_eth_stashing_config *config);
+
+/**
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Configure cache stashing for improved memory access latencies for Tx
+ * queue completion descriptors being sent to host system by the NIC.
+ * This feature is available only in supported NICs and platforms.
+ *
+ * @param port_id
+ *  The port identifier of the Ethernet device.
+ * @param queue_id
+ *  The index of the receive queue to which hints are applied.
+ * @param config
+ *  Stashing configuration.
+ * @return
+ *  - (-ENODEV) on incorrect port_ids.
+ *  - (-EINVAL) if both RX and TX object types are used in conjuection in objects
+ *  parameter.
+ *  - (-EINVAL) if hints are incompatible with TX queues.
+ *  - (-EINVAL) on invalid queue_id.
+ *  - (-ENOTSUP) if RTE_ETH_DEV_CAPA_CACHE_STASHING capability is unavailable.
+ *  - (-ENOSYS) if PMD does not implement cache stashing hints.
+ *  - (0) on Success.
+ */
+__rte_experimental
+int rte_eth_dev_stashing_tx_config_set(uint16_t port_id, uint16_t queue_id,
+				   struct rte_eth_stashing_config *config);
+
+/**
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Discover cache stashing objects supported in the ethernet device.
+ *
+ * @param port_id
+ *  The port identifier of the Ethernet device.
+ * @param objects
+ *  Supported objects vector set by the ethernet device.
+ * @return
+ *  On return types and hints parameters will have bits set for supported
+ *  object types.
+ *  - (-ENOTSUP) if the device or the platform does not support cache stashing.
+ *  - (-ENOSYS)  if the underlying PMD hasn't implemented cache stashing
+ *  feature.
+ *  - (-EINVAL)  on NULL values for types or hints parameters.
+ *  - (0) on success.
+ */
+__rte_experimental
+int rte_eth_dev_stashing_capabilities_get(uint16_t port_id, uint16_t *objects);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0


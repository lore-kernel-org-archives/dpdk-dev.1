Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A898C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E22A940A6F;
	Tue,  8 Sep 2026 09:32:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id E188540A6F
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788852752; x=1820388752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bR5BJ/C0b81GzbTR4dRWOKyZ1oJ7D1vWEJfIzloelY4=;
 b=g9rp5M8pbR/KDFqY48oopoEfz5p4kf3+v6he97McNEHd4zgf0AHK7OQU
 sUR0k1ZLd4m9YyzOh451Dcj1Ax0Dp8e8cfEpNDc1FmrJmi4gxtzSQ9PhB
 0AaBEWbcqZbP6r7lOA0jIFoSWP7VGqKQLrpMd9nTpRdmnoP6qKynHuFbs
 prAD9XqpF3kibftHDVs/ZL1QqVyGmmfuNhQRLdeDkOuGv5/tAaO6Y5hBw
 ROrhxF1yjZIknXjfGgJSkGo18FA3vCnV2xmiXN8EwJTE+GcBq6wFcQ6nq
 L/P/G+w2fU3J5WU70o5rw2DOk+cTSBqvdNkh4HDnreUS6mrMmdMoa5BoA g==;
X-CSE-ConnectionGUID: J2wJIm1kRGudYBmhodtviw==
X-CSE-MsgGUID: 1BJWrQj/T7Kz671jPZWnPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89290177"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89290177"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:32:31 -0700
X-CSE-ConnectionGUID: bxYlO9iXQuGfL0ieYKK9cQ==
X-CSE-MsgGUID: 9PiXP7/VQTCFJc+HEsfDQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="275057034"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 00:32:28 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v5 1/5] ethdev: add Tx timestamp slot management APIs
Date: Tue,  8 Sep 2026 13:02:02 +0530
Message-ID: <20260908073206.1236372-2-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908073206.1236372-1-rajesh3.kumar@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260908073206.1236372-1-rajesh3.kumar@intel.com>
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

Extend ethdev timesync with a capability model for selecting between
shared-register and per-packet Tx timestamping.

Add public and PMD interfaces to query timestamp capabilities, allocate
timestamp slots, retrieve timestamps asynchronously, and release slots.
Slots have port-global scope and can be used across Tx queues.

Add a dual-domain timestamp structure for reporting adjusted PHC time
and raw hardware time independently through validity flags.

Add APIs to register and unregister the mbuf dynamic field and dynflag
used to pass slot handles to the Tx datapath. Add helpers to associate
a slot handle with an mbuf before transmission.

Keep the legacy Tx timestamp API for shared-register hardware.

Programming guide documentation for the new slot API is added in a
following patch.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/nics/features.rst           |  15 +-
 doc/guides/rel_notes/release_26_11.rst |   7 +
 lib/ethdev/ethdev_driver.h             |  28 ++++
 lib/ethdev/rte_ethdev.c                | 151 ++++++++++++++++-
 lib/ethdev/rte_ethdev.h                | 220 +++++++++++++++++++++++++
 5 files changed, 415 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 0b0c69e7cd..4d96184a14 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -692,14 +692,21 @@ Timesync
 
 Supports IEEE1588/802.1AS timestamping.
 
-* **[implements] eth_dev_ops**: ``timesync_enable``, ``timesync_disable``
+* **[implements] eth_dev_ops**: ``timesync_enable``, ``timesync_disable``,
   ``timesync_read_rx_timestamp``, ``timesync_read_tx_timestamp``,
+  ``timesync_tx_slot_get_caps``, ``timesync_tx_slot_alloc``,
+  ``timesync_tx_slot_read``, ``timesync_tx_slot_release``,
   ``timesync_adjust_time``, ``timesync_adjust_freq``,
   ``timesync_read_time``, ``timesync_write_time``.
 * **[related]    API**: ``rte_eth_timesync_enable()``, ``rte_eth_timesync_disable()``,
-  ``rte_eth_timesync_read_rx_timestamp()``,
-  ``rte_eth_timesync_read_tx_timestamp``, ``rte_eth_timesync_adjust_time()``,
-  ``rte_eth_timesync_adjust_freq()``,
+  ``rte_eth_timesync_read_rx_timestamp()``, ``rte_eth_timesync_read_tx_timestamp()``,
+  ``rte_eth_timesync_tx_slot_caps()``,
+  ``rte_eth_timesync_tx_slot_alloc()``,
+  ``rte_eth_timesync_tx_slot_read()``,
+  ``rte_eth_timesync_tx_slot_release()``,
+  ``rte_eth_timesync_tx_slot_dynfield_register()``,
+  ``rte_eth_timesync_tx_slot_stamp()``,
+  ``rte_eth_timesync_adjust_time()``, ``rte_eth_timesync_adjust_freq()``,
   ``rte_eth_timesync_read_time()``, ``rte_eth_timesync_write_time()``.
 
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..b97e019043 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **ethdev: Added experimental per-packet Tx timestamp slot APIs.**
+
+  Added slot-based Tx timestamp allocation, mbuf stamping, and per-packet
+  timestamp reads for timesync-capable Ethernet devices. The new APIs support
+  both shared-register and slot-bank usage models through the
+  ``rte_eth_timesync_tx_slot_*`` interface family.
+
 
 Removed Items
 -------------
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..b6597987b2 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -795,6 +795,26 @@ typedef int (*eth_timesync_read_rx_timestamp_t)(struct rte_eth_dev *dev,
 typedef int (*eth_timesync_read_tx_timestamp_t)(struct rte_eth_dev *dev,
 						struct timespec *timestamp);
 
+/** @internal Query Tx timestamp hardware capability (single-register vs per-packet slot bank). */
+typedef int (*eth_timesync_tx_slot_get_caps_t)(struct rte_eth_dev *dev,
+		struct rte_eth_timesync_tx_slot_caps *caps);
+
+/** @internal Allocate a per-packet Tx timestamp slot handle. */
+typedef int (*eth_timesync_tx_slot_alloc_t)(struct rte_eth_dev *dev,
+		uint32_t *slot_id);
+
+/** @internal Read a dual-domain Tx timestamp by slot handle. */
+typedef int (*eth_timesync_tx_slot_read_t)(struct rte_eth_dev *dev,
+		uint32_t slot_id,
+		struct rte_eth_timesync_dual_domain_timestamp *timestamp);
+
+/** @internal Release a previously allocated Tx timestamp slot handle. */
+typedef int (*eth_timesync_tx_slot_release_t)(struct rte_eth_dev *dev,
+		uint32_t slot_id);
+
+extern int rte_eth_timesync_tx_slot_dynfield_offset;
+extern uint64_t rte_eth_timesync_tx_slot_dynflag;
+
 /** @internal Function used to adjust the device clock. */
 typedef int (*eth_timesync_adjust_time)(struct rte_eth_dev *dev, int64_t);
 
@@ -1561,6 +1581,14 @@ struct eth_dev_ops {
 	eth_timesync_read_rx_timestamp_t timesync_read_rx_timestamp;
 	/** Read the IEEE1588/802.1AS Tx timestamp */
 	eth_timesync_read_tx_timestamp_t timesync_read_tx_timestamp;
+	/** Query Tx timestamp hardware capability (single-reg vs per-packet) */
+	eth_timesync_tx_slot_get_caps_t timesync_tx_slot_get_caps;
+	/** Allocate a Tx timestamp slot handle */
+	eth_timesync_tx_slot_alloc_t timesync_tx_slot_alloc;
+	/** Read a Tx timestamp using a slot handle */
+	eth_timesync_tx_slot_read_t timesync_tx_slot_read;
+	/** Release a Tx timestamp slot handle */
+	eth_timesync_tx_slot_release_t timesync_tx_slot_release;
 	/** Adjust the device clock */
 	eth_timesync_adjust_time   timesync_adjust_time;
 	/** Adjust the clock frequency */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..570e3d7c24 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -21,6 +21,7 @@
 #include <rte_mempool.h>
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
+#include <rte_mbuf_dyn.h>
 #include <rte_errno.h>
 #include <rte_spinlock.h>
 #include <rte_string_fns.h>
@@ -6118,7 +6119,6 @@ rte_eth_dev_rx_intr_disable(uint16_t port_id,
 	return ret;
 }
 
-
 RTE_EXPORT_SYMBOL(rte_eth_add_rx_callback)
 const struct rte_eth_rxtx_callback *
 rte_eth_add_rx_callback(uint16_t port_id, uint16_t queue_id,
@@ -6603,6 +6603,11 @@ rte_eth_dev_set_mc_addr_list(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_offset)
+int rte_eth_timesync_tx_slot_dynfield_offset = -1;
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_timesync_tx_slot_dynflag)
+uint64_t rte_eth_timesync_tx_slot_dynflag;
+
 RTE_EXPORT_SYMBOL(rte_eth_timesync_enable)
 int
 rte_eth_timesync_enable(uint16_t port_id)
@@ -6683,7 +6688,7 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 
 	if (timestamp == NULL) {
 		RTE_ETHDEV_LOG_LINE(ERR,
-			"Cannot read ethdev port %u Tx timestamp to NULL",
+			"Cannot read Tx timestamp for ethdev port %u: timestamp is NULL",
 			port_id);
 		return -EINVAL;
 	}
@@ -6699,6 +6704,148 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_alloc, 26.11)
+int rte_eth_timesync_tx_slot_alloc(uint16_t port_id, uint32_t *slot_id)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (slot_id == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Cannot allocate Tx timestamp slot for ethdev port %u: slot_id is NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->timesync_tx_slot_alloc == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_tx_slot_alloc(dev, slot_id));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_caps, 26.11)
+int
+rte_eth_timesync_tx_slot_caps(uint16_t port_id,
+		struct rte_eth_timesync_tx_slot_caps *caps)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (caps == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Cannot get Tx timestamp capabilities for ethdev port %u: caps is NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->timesync_tx_slot_get_caps == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_tx_slot_get_caps(dev, caps));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_read, 26.11)
+int
+rte_eth_timesync_tx_slot_read(uint16_t port_id,
+					uint32_t slot_id,
+					struct rte_eth_timesync_dual_domain_timestamp *timestamp)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (timestamp == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Cannot read Tx timestamp slot for ethdev port %u: timestamp is NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->timesync_tx_slot_read == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_tx_slot_read(dev,
+				slot_id, timestamp));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_release, 26.11)
+int rte_eth_timesync_tx_slot_release(uint16_t port_id, uint32_t slot_id)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (dev->dev_ops->timesync_tx_slot_release == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_tx_slot_release(dev,
+				slot_id));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_register, 26.11)
+int rte_eth_timesync_tx_slot_dynfield_register(void)
+{
+	const struct rte_mbuf_dynfield slot_dynfield = {
+		.name  = RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME,
+		.size  = sizeof(uint32_t),
+		.align = alignof(uint32_t),
+	};
+	int flag_bit;
+
+	if (rte_eth_timesync_tx_slot_dynfield_offset >= 0 &&
+	    rte_eth_timesync_tx_slot_dynflag != 0)
+		return 0;
+
+	if (rte_eth_timesync_tx_slot_dynfield_offset < 0) {
+		rte_eth_timesync_tx_slot_dynfield_offset =
+				rte_mbuf_dynfield_register(&slot_dynfield);
+		if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
+			rte_eth_timesync_tx_slot_dynfield_offset =
+					rte_mbuf_dynfield_lookup(
+						RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME, NULL);
+	}
+	if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
+		return -ENOTSUP;
+
+	if (rte_eth_timesync_tx_slot_dynflag == 0) {
+		flag_bit = rte_mbuf_dynflag_register(
+			&(const struct rte_mbuf_dynflag){
+				.name = RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME});
+		if (flag_bit < 0)
+			flag_bit = rte_mbuf_dynflag_lookup(
+				RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME, NULL);
+		if (flag_bit < 0)
+			return -ENOTSUP;
+		rte_eth_timesync_tx_slot_dynflag = RTE_BIT64(flag_bit);
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_stamp, 26.11)
+int rte_eth_timesync_tx_slot_stamp(uint32_t slot_id, struct rte_mbuf *m)
+{
+	if (unlikely(m == NULL))
+		return -EINVAL;
+	if (unlikely(rte_eth_timesync_tx_slot_dynfield_offset < 0 ||
+		     rte_eth_timesync_tx_slot_dynflag == 0))
+		return -ENOTSUP;
+	*RTE_MBUF_DYNFIELD(m, rte_eth_timesync_tx_slot_dynfield_offset,
+			   uint32_t *) = slot_id;
+	m->ol_flags |= rte_eth_timesync_tx_slot_dynflag;
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_time)
 int
 rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..8bdb099567 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5478,6 +5478,10 @@ int rte_eth_timesync_enable(uint16_t port_id);
 /**
  * Disable IEEE1588/802.1AS timestamping for an Ethernet device.
  *
+ * The caller must ensure no Tx timestamp operations are in flight before
+ * calling this function, unless the PMD explicitly supports that concurrency.
+ * This function does not make the PMD hardware lifecycle safe by itself.
+ *
  * @param port_id
  *   The port identifier of the Ethernet device.
  *
@@ -5513,6 +5517,10 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t port_id,
 /**
  * Read an IEEE1588/802.1AS Tx timestamp from an Ethernet device.
  *
+ * This API reads the transmit timestamp reported by the device.
+ * The supported Tx timestamp mechanism can be queried with
+ * rte_eth_timesync_tx_slot_caps().
+ *
  * @param port_id
  *   The port identifier of the Ethernet device.
  * @param timestamp
@@ -5528,6 +5536,218 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t port_id,
 int rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 		struct timespec *timestamp);
 
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.adjusted_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID	RTE_BIT32(0)
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.raw_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_RAW_VALID	RTE_BIT32(1)
+
+/**
+ * Dual-domain Tx timestamp payload in nanoseconds.
+ *
+ * `adjusted_ns` is the synchronized/adjusted domain.
+ * `raw_ns` is the free-running raw hardware clock domain.
+ *
+ * Scalar `int64_t` nanoseconds are used (instead of `struct timespec`) to
+ * keep both domains compact in one payload and to avoid extra split/merge
+ * conversions when processing per-packet timestamp correlation data.
+ */
+struct rte_eth_timesync_dual_domain_timestamp {
+	int64_t adjusted_ns;
+	int64_t raw_ns;
+	uint32_t valid_mask;
+	uint32_t reserved; /**< Reserved for future use, must be zero. */
+};
+
+/** Tx timestamp retrieval mechanism supported by a port. */
+enum rte_eth_timesync_tx_slot_type {
+	RTE_ETH_TIMESYNC_TX_SLOT_NONE       = 0, /**< not supported */
+	/** One hardware latch register shared across all packets. */
+	RTE_ETH_TIMESYNC_TX_SLOT_SINGLE_REG = 1,
+	/** Per-packet slot bank supports concurrent in-flight correlation. */
+	RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET = 2,
+};
+
+/**
+ * Tx timestamp capabilities returned by
+ * rte_eth_timesync_tx_slot_caps().
+ */
+struct rte_eth_timesync_tx_slot_caps {
+	enum rte_eth_timesync_tx_slot_type type; /**< mechanism supported by this port */
+	uint32_t max_slots; /**< concurrent slots available; valid only for PER_PACKET */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Query the Tx timestamp capability of a port.
+ *
+ * Reports whether the hardware uses a single shared latch register
+ * (RTE_ETH_TIMESYNC_TX_SLOT_SINGLE_REG) or a per-packet slot bank
+ * (RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET), and how many concurrent slots exist.
+ *
+ * Applications use this to select the mechanism supported by the port:
+ *   - Per-packet slots: rte_eth_timesync_tx_slot_alloc() +
+ *     rte_eth_timesync_tx_slot_read()
+ *   - Single register: rte_eth_timesync_read_tx_timestamp()
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param caps
+ *   Output Tx timestamp capability structure.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_slot_caps(uint16_t port_id,
+		struct rte_eth_timesync_tx_slot_caps *caps);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Allocate a Tx timestamp slot handle for per-packet timestamp correlation.
+ *
+ * Intended for PTP/event timestamping rates.
+ *
+ * Slots are allocated from a port-global pool and can be used across any
+ * Tx queue on the port. The application stamps an mbuf with the slot handle
+ * using rte_eth_timesync_tx_slot_stamp() before transmission.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Output opaque handle identifying the allocated slot.
+ *   The value is meaningful only to the PMD that produced it; the application
+ *   must not interpret, modify, or fabricate slot handles.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENOSPC: No free slots are available.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_slot_alloc(uint16_t port_id, uint32_t *slot_id);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Read a per-packet Tx timestamp using a previously allocated slot handle.
+ *
+ * Intended for PTP/event timestamping rates.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Opaque slot handle returned by rte_eth_timesync_tx_slot_alloc().
+ *   Passing a handle not returned by alloc, or one that has already been
+ *   released, is undefined behaviour — PMDs should return -EINVAL.
+ * @param timestamp
+ *   Output dual-domain timestamp payload.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -EAGAIN: Timestamp is not ready yet.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters or unrecognised slot handle.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_slot_read(uint16_t port_id,
+		uint32_t slot_id,
+		struct rte_eth_timesync_dual_domain_timestamp *timestamp);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Release a previously allocated Tx timestamp slot handle.
+ *
+ * After release, the handle must not be reused for read or stamp_mbuf.
+ * Releasing an already-released or invalid handle is undefined behaviour —
+ * PMDs should return -EINVAL.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Opaque slot handle to release.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_slot_release(uint16_t port_id, uint32_t slot_id);
+
+/** Mbuf dynfield name for the Tx timestamp slot handle. */
+#define RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME "rte_eth_timesync_tx_slot"
+/** Mbuf dynflag name indicating Tx timestamp slot handle is present. */
+#define RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME "rte_eth_timesync_tx_slot_flag"
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Register the per-packet Tx timestamp slot dynfield and dynflag in the mbuf
+ * layout.
+ *
+ * Must be called before the first rte_pktmbuf_pool_create() when the
+ * application intends to use rte_eth_timesync_tx_slot_stamp() for
+ * per-packet Tx timestamp correlation. Calling it after pool creation may
+ * still succeed if the default dynfield area has not been exhausted.
+ *
+ * This must be called explicitly by the application; it is not called
+ * automatically by rte_eth_timesync_enable(). It may be called before or
+ * after rte_eth_timesync_enable().
+ *
+ * Note: dynfields and dynflags cannot be unregistered in DPDK. Once
+ * registered they remain allocated for the lifetime of the process, whether
+ * or not the application ultimately uses per-packet slot correlation.
+ *
+ * @return
+ *   - 0: Success (or already registered).
+ *   - -ENOTSUP: Registration and lookup both failed (no dynfield space).
+ */
+__rte_experimental
+int rte_eth_timesync_tx_slot_dynfield_register(void);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Set Tx timestamp slot metadata in an mbuf so the Tx path steers the
+ * NIC to capture the timestamp in the correct per-packet slot.
+ *
+ * rte_eth_timesync_tx_slot_dynfield_register() must be called before this
+ * function. This function must be called after
+ * rte_eth_timesync_tx_slot_alloc() and before rte_eth_tx_burst().
+ * It is safe for concurrent callers that stamp separate mbufs. Applications
+ * must use this function only for ports that report
+ * RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET from rte_eth_timesync_tx_slot_caps().
+ *
+ * @param slot_id  Opaque slot handle from rte_eth_timesync_tx_slot_alloc().
+ * @param m        Mbuf to stamp.
+ * @return
+ *   - 0: Success.
+ *   - -EINVAL: Invalid parameters.
+ *   - -ENOTSUP: The dynfield is not registered.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_slot_stamp(uint32_t slot_id, struct rte_mbuf *m);
+
 /**
  * Adjust the timesync clock on an Ethernet device.
  *
-- 
2.55.0


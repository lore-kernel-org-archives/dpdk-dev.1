Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF9EC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 19:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4F7540655;
	Mon, 17 Aug 2026 21:24:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B383640608
 for <dev@dpdk.org>; Mon, 17 Aug 2026 21:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786994667; x=1818530667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E/1T6Uh/1KAsnLx3xdV7g41vKi94MZb3zpkLrRAtNC8=;
 b=mv59JF5WE3o+HOZwzhNsQG1mKNy4ubZJn26ftmRqpq1zySXnhimb9Z1D
 7A8x+s6iKMk/1nyQ7G74gbxEy0zip0NaKb5XZL/wUB/uAai3tWBgOeZuU
 Z6i7aMHfV3vk1MITMZ3tiHvlprR46CBcsVoGAMUg9wSkZsagCMx2gZOce
 DgdKTFT2OcIUxEGGc6kpe41t1yhVKqkUtHvyAdP1lVCHFHqGjKNEBuPgl
 RyKsk9P1DynYP8FDzg2KhzFROtNS/4MJuDfMx05JkkhCWh0eCE+RGaZLn
 5Kp4tt6bknuRx19s9Bv9IqcBBDwLy85I+oKmLBVn8BC82591qnsfSRUm+ w==;
X-CSE-ConnectionGUID: Ia9P+VkvTBW3fH/Q9nc6bg==
X-CSE-MsgGUID: lw1Tm+BBSyCZVdM8bh9TOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113020429"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="113020429"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 12:24:26 -0700
X-CSE-ConnectionGUID: OxgWIPDNTxW6BYMt+xQcbg==
X-CSE-MsgGUID: y7AmtHV2RdOjaXHwnJ6z3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="266977749"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa004.fm.intel.com with ESMTP; 17 Aug 2026 12:24:24 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC 1/1] ethdev: add per-packet Tx timestamp slot APIs
Date: Tue, 18 Aug 2026 00:54:15 +0530
Message-ID: <20260817192417.3009990-2-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
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

Add ethdev public and driver-facing APIs for per-packet Tx
hardware timestamp slot management.

The existing `rte_eth_timesync_read_tx_timestamp()` exposes a
single shared latch, making it unreliable when multiple Tx
timestamps are outstanding concurrently. PMDs with per-packet
slot hardware cannot be exploited through this interface.

Introduce a slot lifecycle API:
- `rte_eth_timesync_tx_timestamp_slot_alloc()`: reserve a
  hardware slot before transmit
- `rte_eth_timesync_tx_timestamp_stamp_mbuf()`: embed slot
  handle into mbuf dynfield for per-packet NIC steering
- `rte_eth_timesync_read_tx_timestamp_slot()`: poll slot for
  a captured timestamp; returns -EAGAIN if not ready
- `rte_eth_timesync_tx_timestamp_slot_release()`: return slot
  to PMD after readback or timeout

Introduce `rte_eth_timesync_dual_domain_timestamp` to carry
both the adjusted PHC time (`adjusted_ns`) and free-running
cycles-domain time (`cycles_ns`), each with an individual
validity bit in `valid_mask`.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 lib/ethdev/ethdev_driver.h |  19 ++++++
 lib/ethdev/rte_ethdev.c    | 121 +++++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h    | 108 +++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..61dadcea49 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -795,6 +795,19 @@ typedef int (*eth_timesync_read_rx_timestamp_t)(struct rte_eth_dev *dev,
 typedef int (*eth_timesync_read_tx_timestamp_t)(struct rte_eth_dev *dev,
 						struct timespec *timestamp);
 
+/** @internal Allocate a per-packet TX timestamp slot handle. */
+typedef int (*eth_timesync_tx_timestamp_slot_alloc_t)(struct rte_eth_dev *dev,
+		uint16_t tx_queue_id, uint32_t *slot_id);
+
+/** @internal Read TX timestamp by slot handle. */
+typedef int (*eth_timesync_read_tx_timestamp_slot_t)(struct rte_eth_dev *dev,
+		uint32_t slot_id,
+		struct rte_eth_timesync_dual_domain_timestamp *timestamp);
+
+/** @internal Release a previously allocated TX timestamp slot handle. */
+typedef int (*eth_timesync_tx_timestamp_slot_release_t)(struct rte_eth_dev *dev,
+		uint32_t slot_id);
+
 /** @internal Function used to adjust the device clock. */
 typedef int (*eth_timesync_adjust_time)(struct rte_eth_dev *dev, int64_t);
 
@@ -1561,6 +1574,12 @@ struct eth_dev_ops {
 	eth_timesync_read_rx_timestamp_t timesync_read_rx_timestamp;
 	/** Read the IEEE1588/802.1AS Tx timestamp */
 	eth_timesync_read_tx_timestamp_t timesync_read_tx_timestamp;
+	/** Allocate a TX timestamp slot handle */
+	eth_timesync_tx_timestamp_slot_alloc_t timesync_tx_timestamp_slot_alloc;
+	/** Read a TX timestamp using a slot handle */
+	eth_timesync_read_tx_timestamp_slot_t timesync_read_tx_timestamp_slot;
+	/** Release a TX timestamp slot handle */
+	eth_timesync_tx_timestamp_slot_release_t timesync_tx_timestamp_slot_release;
 	/** Adjust the device clock */
 	eth_timesync_adjust_time   timesync_adjust_time;
 	/** Adjust the clock frequency */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..b955784594 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6699,6 +6699,127 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_alloc, 26.11)
+int
+rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
+					 uint16_t tx_queue_id,
+					 uint32_t *slot_id)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (slot_id == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Cannot allocate ethdev port %u Tx timestamp slot to NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->timesync_tx_timestamp_slot_alloc == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_tx_timestamp_slot_alloc(dev,
+				tx_queue_id, slot_id));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_read_tx_timestamp_slot, 26.11)
+int
+rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,
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
+			"Cannot read ethdev port %u Tx timestamp slot to NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->timesync_read_tx_timestamp_slot == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_read_tx_timestamp_slot(dev,
+				slot_id, timestamp));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_release, 26.11)
+int
+rte_eth_timesync_tx_timestamp_slot_release(uint16_t port_id, uint32_t slot_id)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (dev->dev_ops->timesync_tx_timestamp_slot_release == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_tx_timestamp_slot_release(dev,
+				slot_id));
+}
+
+static int rte_eth_timesync_tx_slot_dynfield_offset = -1;
+static uint64_t rte_eth_timesync_tx_slot_dynflag;
+
+static int
+rte_eth_timesync_tx_slot_dynfield_register(void)
+{
+	const struct rte_mbuf_dynfield slot_dynfield = {
+		.name  = RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME,
+		.size  = sizeof(uint32_t),
+		.align = alignof(uint32_t),
+	};
+
+	if (rte_eth_timesync_tx_slot_dynfield_offset >= 0)
+		return 0;
+
+	rte_eth_timesync_tx_slot_dynfield_offset =
+			rte_mbuf_dynfield_register(&slot_dynfield);
+	if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
+		rte_eth_timesync_tx_slot_dynfield_offset =
+				rte_mbuf_dynfield_lookup(
+					RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME, NULL);
+	if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
+		return -ENOTSUP;
+
+	{
+		int flag_bit = rte_mbuf_dynflag_register(
+			&(const struct rte_mbuf_dynflag){
+				.name = RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME "_flag"});
+		if (flag_bit < 0)
+			flag_bit = rte_mbuf_dynflag_lookup(
+				RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME "_flag", NULL);
+		if (flag_bit >= 0)
+			rte_eth_timesync_tx_slot_dynflag = RTE_BIT64(flag_bit);
+	}
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_stamp_mbuf, 26.11)
+int
+rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id __rte_unused,
+					 uint32_t slot_id, struct rte_mbuf *m)
+{
+	if (m == NULL)
+		return -EINVAL;
+	if (rte_eth_timesync_tx_slot_dynfield_register() != 0)
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
index ee400b386f..339c39fcdd 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5528,6 +5528,114 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t port_id,
 int rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 		struct timespec *timestamp);
 
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.adjusted_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID	RTE_BIT32(0)
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.cycles_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_CYCLES_VALID	RTE_BIT32(1)
+
+/**
+ * Dual-domain TX timestamp payload.
+ */
+struct rte_eth_timesync_dual_domain_timestamp {
+	int64_t adjusted_ns;
+	int64_t cycles_ns;
+	uint32_t valid_mask;
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Allocate a TX timestamp slot handle for per-packet correlation.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param tx_queue_id
+ *   TX queue used by the packet to be transmitted.
+ * @param slot_id
+ *   Output handle identifying the allocated slot.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
+		uint16_t tx_queue_id, uint32_t *slot_id);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Read a per-packet TX timestamp using a previously allocated slot handle.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Slot handle returned by rte_eth_timesync_tx_timestamp_slot_alloc().
+ * @param timestamp
+ *   Output dual-domain timestamp payload.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -EAGAIN: Timestamp is not ready yet.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,
+		uint32_t slot_id,
+		struct rte_eth_timesync_dual_domain_timestamp *timestamp);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Release a previously allocated TX timestamp slot handle.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Slot handle to release.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_slot_release(uint16_t port_id,
+		uint32_t slot_id);
+
+/** Mbuf dynfield name for the TX timestamp slot handle. */
+#define RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME "rte_eth_timesync_tx_slot"
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Stamp an mbuf with a TX timestamp slot handle so the TX path steers the
+ * NIC to capture the timestamp in the correct per-packet slot.
+ *
+ * Must be called after rte_eth_timesync_tx_timestamp_slot_alloc() and before
+ * rte_eth_tx_burst(). Safe for concurrent callers — slot is stored per-mbuf.
+ *
+ * @param port_id  The port identifier (unused; reserved for future PMD use).
+ * @param slot_id  Slot handle from rte_eth_timesync_tx_timestamp_slot_alloc().
+ * @param m        Mbuf to stamp.
+ * @return 0 on success, -ENOTSUP if dynfield registration failed.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
+		uint32_t slot_id, struct rte_mbuf *m);
+
 /**
  * Adjust the timesync clock on an Ethernet device.
  *
-- 
2.54.0


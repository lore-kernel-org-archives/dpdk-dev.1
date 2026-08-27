Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54036C61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 12:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E3840280;
	Thu, 27 Aug 2026 14:13:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DC0A84003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787832829; x=1819368829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BZY72Y8nLRlotCGmV4jyiCKxlYw6/97wH7wJ34owdFc=;
 b=lUN+CvNT4Ft/l4frorSfG2/B+3C8G37U7ydQm9xudFE9bdxanfMQtNvF
 OqtnHnzPm7Y6741kfq8PoHTT7edKqNfHw2cBu69kELtAYfuOUE6Gnm+wd
 MxBgmQdOozRWjCUzgJgM4KLrT3Y5ZvCzvLfww0pgMvm7fhs8kvw8o7zGO
 +WFiklevz3tBNhMCsbmh4IzvKuPjmo0UOTZ/rFwFskUXt5eW9q70XJsi6
 NP1ilEX30Rwc9Ic2xnDUE1BfNQrfsdtcq2CGLF89i/G13lVjRmIIwoWkD
 ukuZS2WDFJRhdiLx9vS2j9uuschNhqx8aU20+P1ufGJpAuo7DhhM6WruY w==;
X-CSE-ConnectionGUID: F17R1jqiTZmWcpPTy6/KBw==
X-CSE-MsgGUID: nh9Y47JzTn2d28p+i4FHpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="92015891"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="92015891"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 05:13:48 -0700
X-CSE-ConnectionGUID: Oa5foUYlSZaMQqMBTYFAOg==
X-CSE-MsgGUID: n7lI4i3uSjeZ8l0UJPG0hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="264083473"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by fmviesa010.fm.intel.com with ESMTP; 27 Aug 2026 05:13:45 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v3 1/1] ethdev: add Tx timestamp slot management APIs
Date: Thu, 27 Aug 2026 17:43:36 +0530
Message-ID: <20260827121337.338720-2-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827121337.338720-1-rajesh3.kumar@intel.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
 <20260827121337.338720-1-rajesh3.kumar@intel.com>
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

Keep the legacy Tx timestamp API for shared-register hardware and provide
a compatibility alias for the mbuf stamping helper.

Document the timestamp capability model, slot lifecycle, and application
workflow.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/nics/features.rst              |  16 +-
 doc/guides/prog_guide/ethdev/index.rst    |   1 +
 doc/guides/prog_guide/ethdev/timesync.rst | 217 +++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst    |   7 +
 lib/ethdev/ethdev_driver.h                |  25 +++
 lib/ethdev/rte_ethdev.c                   | 158 ++++++++++++++
 lib/ethdev/rte_ethdev.h                   | 242 ++++++++++++++++++++++
 7 files changed, 662 insertions(+), 4 deletions(-)
 create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 0b0c69e7cd..040a996156 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -692,14 +692,22 @@ Timesync
 
 Supports IEEE1588/802.1AS timestamping.
 
-* **[implements] eth_dev_ops**: ``timesync_enable``, ``timesync_disable``
+* **[implements] eth_dev_ops**: ``timesync_enable``, ``timesync_disable``,
   ``timesync_read_rx_timestamp``, ``timesync_read_tx_timestamp``,
+  ``timesync_tx_ts_get_capabilities``, ``timesync_tx_timestamp_slot_alloc``,
+  ``timesync_read_tx_timestamp_slot``, ``timesync_tx_timestamp_slot_release``,
   ``timesync_adjust_time``, ``timesync_adjust_freq``,
   ``timesync_read_time``, ``timesync_write_time``.
 * **[related]    API**: ``rte_eth_timesync_enable()``, ``rte_eth_timesync_disable()``,
-  ``rte_eth_timesync_read_rx_timestamp()``,
-  ``rte_eth_timesync_read_tx_timestamp``, ``rte_eth_timesync_adjust_time()``,
-  ``rte_eth_timesync_adjust_freq()``,
+  ``rte_eth_timesync_read_rx_timestamp()``, ``rte_eth_timesync_read_tx_timestamp()``,
+  ``rte_eth_timesync_tx_timestamp_slot_get_capabilities()``,
+  ``rte_eth_timesync_tx_timestamp_slot_alloc()``,
+  ``rte_eth_timesync_read_tx_timestamp_slot()``,
+  ``rte_eth_timesync_tx_timestamp_slot_release()``,
+  ``rte_eth_timesync_tx_slot_dynfield_register()``,
+  ``rte_eth_timesync_tx_slot_dynfield_unregister()``,
+  ``rte_eth_timesync_tx_timestamp_stamp_mbuf()``,
+  ``rte_eth_timesync_adjust_time()``, ``rte_eth_timesync_adjust_freq()``,
   ``rte_eth_timesync_read_time()``, ``rte_eth_timesync_write_time()``.
 
 
diff --git a/doc/guides/prog_guide/ethdev/index.rst b/doc/guides/prog_guide/ethdev/index.rst
index 392ced0a2e..bc21f28091 100644
--- a/doc/guides/prog_guide/ethdev/index.rst
+++ b/doc/guides/prog_guide/ethdev/index.rst
@@ -13,3 +13,4 @@ Ethernet Device Library
     traffic_metering_and_policing
     traffic_management
     qos_framework
+    timesync
diff --git a/doc/guides/prog_guide/ethdev/timesync.rst b/doc/guides/prog_guide/ethdev/timesync.rst
new file mode 100644
index 0000000000..73ca771248
--- /dev/null
+++ b/doc/guides/prog_guide/ethdev/timesync.rst
@@ -0,0 +1,217 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation.
+
+IEEE 1588 / PTP Timesync API
+============================
+
+Overview
+--------
+
+The DPDK IEEE 1588 / Precision Time Protocol (PTP) Timesync API provides
+a standardized framework for managing PTP Hardware Clocks (PHCs) and retrieving
+precise hardware transmit (Tx) and receive (Rx) timestamps.
+
+The Timesync framework encompasses three core capabilities:
+
+1. **Clock Control & Adjustment**: Enabling/disabling hardware timestamping, reading/setting clock time, and adjusting phase/frequency.
+2. **Receive Timestamping**: Hardware capture of incoming PTP packet arrival timestamps.
+3. **Transmit Timestamping**: Hardware capture of outbound PTP packet departure timestamps.
+
+
+Clock Management & Control
+--------------------------
+
+To initialize and discipline a port's PTP Hardware Clock (PHC), the API provides:
+
+* **Enable / Disable**:
+  ``rte_eth_timesync_enable(port_id)`` enables hardware timestamping on the specified port.
+  ``rte_eth_timesync_disable(port_id)`` disables timesync offloads.
+
+* **Clock Time Read / Write**:
+  ``rte_eth_timesync_read_time(port_id, &ts)`` reads the current PHC wall-clock time as a ``struct timespec``.
+  ``rte_eth_timesync_write_time(port_id, &ts)`` sets the PHC wall-clock time.
+
+* **Clock Adjustments**:
+  ``rte_eth_timesync_adjust_time(port_id, delta_ns)`` adjusts the clock phase by a delta offset in nanoseconds.
+  ``rte_eth_timesync_adjust_freq(port_id, scaled_ppm)`` adjusts the clock frequency in scaled parts-per-million (1 ppm = 1 << 16).
+
+
+Receive (Rx) Timestamping
+-------------------------
+
+When receive timestamping is enabled, the hardware identifies incoming PTP packets (e.g. IEEE 1588 EtherType ``0x88F7`` or UDP destination ports 319/320) and latches their arrival time.
+
+Rx Timestamp Extraction Workflow
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. On packet reception via ``rte_eth_rx_burst()``, the PMD checks if the received mbuf represents a PTP packet.
+2. The PMD sets the ``RTE_MBUF_F_RX_IEEE1588_PTP`` flag in ``mbuf->ol_flags``.
+3. Depending on the PMD and hardware capability, the Rx timestamp is either:
+   * **Extracted via API**: Application calls ``rte_eth_timesync_read_rx_timestamp(port_id, &ts, flags)``.
+   * **Inlined in Mbuf**: Stored in a registered mbuf dynamic field (e.g. ``rte_mbuf_dyn_rx_timestamp_register()``).
+
+
+Transmit (Tx) Timestamping Architectures
+----------------------------------------
+
+The framework supports two hardware transmit timestamping architectures:
+
+* **Single Shared Register** (``RTE_ETH_TIMESYNC_TX_TS_SINGLE_REG``):
+  The hardware contains a single shared transmit timestamp latch register.
+  Only one outbound packet can be timestamped at a time across the entire port.
+  The application calls ``rte_eth_timesync_read_tx_timestamp(port_id, &ts)`` to retrieve the departure time.
+
+* **Per-Packet Slot Bank** (``RTE_ETH_TIMESYNC_TX_TS_PER_PACKET``):
+  The hardware provides a bank of independent transmit timestamp slots or
+  descriptors. Multiple outbound PTP packets can be timestamped concurrently and
+  correlated asynchronously on a per-packet basis using slot handles.
+
+
+Dual-Domain Timestamps
+~~~~~~~~~~~~~~~~~~~~~~
+
+When retrieving transmit timestamps using slot handles, the API returns
+a dual-domain timestamp structure:
+
+.. code-block:: c
+
+    struct rte_eth_timesync_dual_domain_timestamp {
+        int64_t adjusted_ns; /**< PHC adjusted time (wall-clock nanoseconds) */
+        int64_t raw_ns;      /**< Free-running hardware cycle counter or raw nanoseconds */
+        uint32_t valid_mask; /**< Validity bits for the adjusted/raw domains */
+    };
+
+* **Adjusted Domain** (``RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID``):
+  Represents the wall-clock time after frequency adjustments (``rte_eth_timesync_adjust_freq``)
+  or phase steps (``rte_eth_timesync_adjust_time``) have been applied.
+
+* **Raw Domain** (``RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_RAW_VALID``):
+  Represents the unadjusted free-running hardware cycle counter or raw timestamp.
+  This domain is required when correlating adjusted wall-clock time with the
+  underlying hardware timebase or when performing cross-timestamp analysis.
+
+
+Per-Packet Tx Timestamp Workflow
+--------------------------------
+
+To use per-packet transmit timestamping, applications follow this sequence:
+
+1. **Query Port Capabilities**
+   Determine whether the PMD supports slot-based per-packet timestamping:
+
+   .. code-block:: c
+
+       struct rte_eth_timesync_tx_ts_caps caps;
+
+       ret = rte_eth_timesync_tx_timestamp_slot_get_capabilities(port_id, &caps);
+       if (ret == 0 && caps.type == RTE_ETH_TIMESYNC_TX_TS_PER_PACKET) {
+           printf("Port %u supports per-packet timestamping with %u max slots\n",
+                  port_id, caps.max_slots);
+       }
+
+2. **Register Mbuf Dynamic Fields**
+   Register the dynamic field and dynamic flag used to pass slot handles to the Tx datapath:
+
+   .. code-block:: c
+
+       ret = rte_eth_timesync_tx_slot_dynfield_register();
+       if (ret < 0) {
+           /* Dynamic field space exhausted or registration failed */
+       }
+
+   .. note::
+
+      ``rte_eth_timesync_enable()`` registers the dynamic field automatically.
+      Call ``rte_eth_timesync_tx_slot_dynfield_register()`` explicitly only if creating
+      mempools before enabling timesync on the port.
+
+3. **Allocate a Timestamp Slot**
+   Before transmitting a PTP packet requiring a transmit timestamp, allocate a slot handle:
+
+   .. code-block:: c
+
+       uint32_t slot_id;
+
+       ret = rte_eth_timesync_tx_timestamp_slot_alloc(port_id, &slot_id);
+       if (ret != 0) {
+           /* Handle allocation error (e.g. -ENOSPC if all slots are in flight) */
+       }
+
+4. **Stamp the Mbuf**
+   Attach the allocated slot handle to the mbuf:
+
+   .. code-block:: c
+
+       rte_eth_timesync_tx_timestamp_stamp_mbuf(port_id, slot_id, mbuf);
+       mbuf->ol_flags |= RTE_MBUF_F_TX_IEEE1588_TMST;
+
+5. **Transmit the Packet**
+   Send the packet via ``rte_eth_tx_burst()`` as usual.
+
+6. **Poll for Timestamp Completion**
+   Read the captured timestamp using the allocated slot handle:
+
+   .. code-block:: c
+
+       struct rte_eth_timesync_dual_domain_timestamp ts;
+
+       ret = rte_eth_timesync_read_tx_timestamp_slot(port_id, slot_id, &ts);
+       if (ret == 0) {
+           /* Timestamp is ready */
+           if (ts.valid_mask & RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID) {
+               /* Process ts.adjusted_ns */
+           }
+       } else if (ret == -EAGAIN) {
+           /* Timestamp hardware processing is still pending; retry later */
+       }
+
+7. **Release the Slot**
+   After successfully reading the timestamp or timing out, release the slot handle:
+
+   .. code-block:: c
+
+       rte_eth_timesync_tx_timestamp_slot_release(port_id, slot_id);
+
+8. **Unregister Dynfield State on Shutdown (Optional)**
+   When shutting down timesync offloads, the application can unregister the cached dynfield state:
+
+   .. code-block:: c
+
+       rte_eth_timesync_tx_slot_dynfield_unregister();
+
+   .. note::
+
+      This resets process-local dynfield state so subsequent
+      ``rte_eth_timesync_tx_timestamp_stamp_mbuf()`` calls return ``-ENOTSUP``
+      and PMD Tx datapaths fall back to port-level legacy mode.
+      Note that underlying mbuf dynfield bytes remain allocated in DPDK layout as DPDK does not
+      support dynamic field deallocation.
+
+
+PMD Implementation Requirements
+-------------------------------
+
+To support full timesync capabilities, a Poll Mode Driver (PMD) implements the following driver contract:
+
+1. **Clock Operations** (``timesync_enable``, ``timesync_disable``, ``timesync_read_time``, ``timesync_write_time``, ``timesync_adjust_time``, ``timesync_adjust_freq``)
+   * Controls hardware timestamp generation and disciplines the hardware clock registers.
+
+2. **Rx Timestamping** (``timesync_read_rx_timestamp``)
+   * Configures Rx filters to latch incoming PTP arrival times and flags received mbufs with ``RTE_MBUF_F_RX_IEEE1588_PTP``.
+
+3. **Tx Slot Capability Reporting** (``timesync_tx_ts_get_capabilities``)
+   * Reports ``RTE_ETH_TIMESYNC_TX_TS_SINGLE_REG`` or ``RTE_ETH_TIMESYNC_TX_TS_PER_PACKET`` in `caps->type` and sets `caps->max_slots`.
+
+4. **Slot Allocation & Release** (``timesync_tx_timestamp_slot_alloc`` / ``timesync_tx_timestamp_slot_release``)
+   * Maintains a port-global pool or bitmap of hardware timestamp slots.
+   * `timesync_tx_timestamp_slot_alloc` returns a port-unique slot identifier and returns ``-ENOSPC`` when no slots are free.
+   * `timesync_tx_timestamp_slot_release` clears hardware slot state and returns the slot handle to the free pool.
+
+5. **Tx Datapath Integration**
+   * Checks if ``RTE_MBUF_F_TX_IEEE1588_TMST`` is set on `mbuf->ol_flags`.
+   * For per-packet slot mode, retrieves `slot_id` from mbuf dynamic field via ``*RTE_MBUF_DYNFIELD(m, dynfield_offset, uint32_t *)``.
+   * Configures hardware Tx descriptors to capture departure timestamps into the specified slot.
+
+6. **Tx Slot Timestamp Retrieval** (``timesync_read_tx_timestamp_slot``)
+   * Queries hardware slot or descriptor completion ring corresponding to `slot_id`.
+   * Populates ``struct rte_eth_timesync_dual_domain_timestamp`` and returns ``0`` when ready, or ``-EAGAIN`` if pending.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..122d44afeb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **ethdev: Added experimental per-packet Tx timestamp slot APIs.**
+
+  Added slot-based TX timestamp allocation, mbuf stamping, and per-packet
+  timestamp reads for timesync-capable Ethernet devices. The new APIs support
+  both shared-register and slot-bank usage models through the
+  ``rte_eth_timesync_tx_timestamp_slot_*`` interface family.
+
 
 Removed Items
 -------------
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..9d981995ea 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -795,6 +795,23 @@ typedef int (*eth_timesync_read_rx_timestamp_t)(struct rte_eth_dev *dev,
 typedef int (*eth_timesync_read_tx_timestamp_t)(struct rte_eth_dev *dev,
 						struct timespec *timestamp);
 
+/** @internal Query TX timestamp hardware capability (single-register vs per-packet slot bank). */
+typedef int (*eth_timesync_tx_ts_get_caps_t)(struct rte_eth_dev *dev,
+		struct rte_eth_timesync_tx_ts_caps *caps);
+
+/** @internal Allocate a per-packet TX timestamp slot handle. */
+typedef int (*eth_timesync_tx_timestamp_slot_alloc_t)(struct rte_eth_dev *dev,
+		uint32_t *slot_id);
+
+/** @internal Read a dual-domain TX timestamp by slot handle. */
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
 
@@ -1561,6 +1578,14 @@ struct eth_dev_ops {
 	eth_timesync_read_rx_timestamp_t timesync_read_rx_timestamp;
 	/** Read the IEEE1588/802.1AS Tx timestamp */
 	eth_timesync_read_tx_timestamp_t timesync_read_tx_timestamp;
+	/** Allocate a TX timestamp slot handle */
+	eth_timesync_tx_timestamp_slot_alloc_t timesync_tx_timestamp_slot_alloc;
+	/** Query TX timestamp hardware capability (single-reg vs per-packet) */
+	eth_timesync_tx_ts_get_caps_t timesync_tx_ts_get_capabilities;
+	/** Read a TX timestamp using a slot handle */
+	eth_timesync_read_tx_timestamp_slot_t timesync_read_tx_timestamp_slot;
+	/** Release a TX timestamp slot handle */
+	eth_timesync_tx_timestamp_slot_release_t timesync_tx_timestamp_slot_release;
 	/** Adjust the device clock */
 	eth_timesync_adjust_time   timesync_adjust_time;
 	/** Adjust the clock frequency */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..22bebb6e3d 100644
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
@@ -6699,6 +6700,163 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_alloc, 26.11)
+int
+rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
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
+			dev->dev_ops->timesync_tx_timestamp_slot_alloc(dev, slot_id));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_get_capabilities, 26.11)
+int
+rte_eth_timesync_tx_timestamp_slot_get_capabilities(uint16_t port_id,
+		struct rte_eth_timesync_tx_ts_caps *caps)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (caps == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Cannot get ethdev port %u Tx timestamp capabilities to NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	if (dev->dev_ops->timesync_tx_ts_get_capabilities == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+			dev->dev_ops->timesync_tx_ts_get_capabilities(dev, caps));
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
+/* Internal process-local cache for Tx timestamp slot mbuf metadata. */
+static int rte_eth_timesync_tx_slot_dynfield_offset = -1;
+static uint64_t rte_eth_timesync_tx_slot_dynflag;
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_register, 26.11)
+int
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
+				.name = RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME});
+		if (flag_bit < 0)
+			flag_bit = rte_mbuf_dynflag_lookup(
+				RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME, NULL);
+		if (flag_bit < 0)
+			return -ENOTSUP;
+		rte_eth_timesync_tx_slot_dynflag = RTE_BIT64(flag_bit);
+	}
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_unregister, 26.11)
+int
+rte_eth_timesync_tx_slot_dynfield_unregister(void)
+{
+	/* Reset cached state without freeing dynamic-field bytes. */
+	rte_eth_timesync_tx_slot_dynfield_offset = -1;
+	rte_eth_timesync_tx_slot_dynflag = 0;
+	return 0;
+}
+
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_stamp_mbuf, 26.11)
+int
+rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
+						 uint32_t slot_id, struct rte_mbuf *m)
+{
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
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
index ee400b386f..c7af668718 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5513,6 +5513,19 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t port_id,
 /**
  * Read an IEEE1588/802.1AS Tx timestamp from an Ethernet device.
  *
+ * This is the legacy Tx timestamp API and is intended for register-based
+ * timestamp reads. It does not provide per-packet correlation.
+ *
+ * Applications requiring per-packet Tx timestamp correlation should use the
+ * slot-based APIs:
+ * - Setup: rte_eth_timesync_tx_slot_dynfield_register()
+ * - Runtime per-packet loop:
+ *   - rte_eth_timesync_tx_timestamp_slot_alloc()
+ *   - rte_eth_timesync_tx_timestamp_stamp_mbuf()
+ *   - rte_eth_timesync_read_tx_timestamp_slot()
+ *   - rte_eth_timesync_tx_timestamp_slot_release()
+ * - Teardown: rte_eth_timesync_tx_slot_dynfield_unregister()
+ *
  * @param port_id
  *   The port identifier of the Ethernet device.
  * @param timestamp
@@ -5528,6 +5541,235 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t port_id,
 int rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 		struct timespec *timestamp);
 
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.adjusted_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID	RTE_BIT32(0)
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.raw_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_RAW_VALID	RTE_BIT32(1)
+
+/**
+ * Dual-domain TX timestamp payload in nanoseconds.
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
+};
+
+/** Valid bit for rte_eth_timesync_tx_timestamp_slot_info.max_slots. */
+#define RTE_ETH_TIMESYNC_TX_TIMESTAMP_SLOT_INFO_MAX_VALID	RTE_BIT32(0)
+/** Valid bit for rte_eth_timesync_tx_timestamp_slot_info.free_slots. */
+#define RTE_ETH_TIMESYNC_TX_TIMESTAMP_SLOT_INFO_FREE_VALID	RTE_BIT32(1)
+
+/** TX timestamp retrieval mechanism supported by a port. */
+enum rte_eth_timesync_tx_ts_type {
+	RTE_ETH_TIMESYNC_TX_TS_NONE       = 0, /**< not supported */
+	/** One hardware latch register shared across all packets. */
+	RTE_ETH_TIMESYNC_TX_TS_SINGLE_REG = 1,
+	/** Per-packet slot bank supports concurrent in-flight correlation. */
+	RTE_ETH_TIMESYNC_TX_TS_PER_PACKET = 2,
+};
+
+/**
+ * TX timestamp capabilities returned by
+ * rte_eth_timesync_tx_timestamp_slot_get_capabilities().
+ */
+struct rte_eth_timesync_tx_ts_caps {
+	enum rte_eth_timesync_tx_ts_type type; /**< mechanism supported by this port */
+	uint32_t max_slots; /**< concurrent slots available; valid only for PER_PACKET */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Query the TX timestamp capability of a port.
+ *
+ * Reports whether the hardware uses a single shared latch register
+ * (RTE_ETH_TIMESYNC_TX_TS_SINGLE_REG) or a per-packet slot bank
+ * (RTE_ETH_TIMESYNC_TX_TS_PER_PACKET), and how many concurrent slots exist.
+ *
+ * Use this to choose between:
+ *   - Slot-based: rte_eth_timesync_tx_timestamp_slot_alloc() +
+ *     rte_eth_timesync_read_tx_timestamp_slot()
+ *   - Legacy:     rte_eth_timesync_read_tx_timestamp()
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param caps
+ *   Output TX timestamp capability structure.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_slot_get_capabilities(uint16_t port_id,
+		struct rte_eth_timesync_tx_ts_caps *caps);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Allocate a TX timestamp slot handle for per-packet timestamp correlation.
+ *
+ * Intended for PTP/event timestamping rates.
+ *
+ * Slots are allocated from a port-global pool and can be used across any
+ * TX queue on the port. The application stamps an mbuf with the slot handle
+ * using rte_eth_timesync_tx_timestamp_stamp_mbuf() before transmission.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Output handle identifying the allocated slot (port-global scope).
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
+int rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
+		uint32_t *slot_id);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Read a per-packet TX timestamp using a previously allocated slot handle.
+ *
+ * Intended for PTP/event timestamping rates.
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
+ * Intended for PTP/event timestamping rates.
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
+/** Mbuf dynflag name indicating TX timestamp slot handle is present. */
+#define RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME "rte_eth_timesync_tx_slot_flag"
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Register the per-packet TX timestamp slot dynfield and dynflag in the mbuf
+ * layout.
+ *
+ * Must be called before the first rte_pktmbuf_pool_create() when the
+ * application intends to use rte_eth_timesync_tx_timestamp_stamp_mbuf()
+ * for per-packet TX timestamp correlation. Calling it after pool creation
+ * may still succeed if the default dynfield area has not been exhausted.
+ *
+ * rte_eth_timesync_enable() calls this automatically, so explicit calls are
+ * only needed when the application creates pools before enabling timesync.
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
+ * Disable per-packet TX timestamp slot correlation for this process.
+ *
+ * Resets the cached dynfield offset and dynflag to their unregistered state.
+ * After this call rte_eth_timesync_tx_timestamp_stamp_mbuf() returns
+ * -ENOTSUP and the PMD TX path falls back to the port-level ptp_tx_index
+ * (legacy mode).
+ *
+ * The underlying DPDK dynfield bytes are NOT freed — DPDK provides no dynfield
+ * deallocation. The 4 bytes per mbuf remain allocated but dormant.
+ *
+ * @return   Always 0.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_slot_dynfield_unregister(void);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Set TX timestamp slot metadata in an mbuf so the TX path steers the
+ * NIC to capture the timestamp in the correct per-packet slot.
+ *
+ * Must be called after rte_eth_timesync_tx_timestamp_slot_alloc() and before
+ * rte_eth_tx_burst(). Safe for concurrent callers — slot is stored per-mbuf.
+ *
+ * @param port_id  The port identifier of the Ethernet device.
+ * @param slot_id  Slot handle from rte_eth_timesync_tx_timestamp_slot_alloc().
+ * @param m        Mbuf to stamp.
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EINVAL: Invalid parameters.
+ *   - -ENOTSUP: Registration/lookup failed.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
+		uint32_t slot_id, struct rte_mbuf *m);
+
 /**
  * Adjust the timesync clock on an Ethernet device.
  *
-- 
2.55.0


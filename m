Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF5C79FA0
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0164440DF5;
	Tue,  8 Sep 2026 09:32:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 34EA94026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788852758; x=1820388758;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A9bJN/3Z6WIiIh47dK8AyGaWfZufTCo2TumuhtzoiAE=;
 b=L8goRs1bRdYFwRJy3Tm2NLO0q47R52OndhIVjcbACeWmzaoSQxq9BG9A
 4/+P1/PJDZZT5aXiGzA95xNWXW29absT+mAxlOVgtk6Yuyk/AFqFCvrrs
 uxCGbk7X2jYb61+k6DKig3E6apVrgsxY5iBTk9tcZRbMULqBA/bx6gWuF
 ylNgzHQAQ/u0fIv7q9mkFCwm66vCaGKHF9R+/WMm0766q/1rrSrYEXQUQ
 2/KCKHFYMcoe1O0YusDABzdtc3TCPLITaxohGFCX+1e3Pe1TnjDDif4o0
 Z8McU45sLUlRbLT11YpIUFVaiJxb4I4Gn8xlVgTxaVWQuwj8vNczxhIea g==;
X-CSE-ConnectionGUID: 5vQ3dBlsRqqCWH1ge59DeQ==
X-CSE-MsgGUID: gY5e7mYcTWiTfvu80iW3vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89290191"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89290191"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:32:37 -0700
X-CSE-ConnectionGUID: o/oKNGm+RcuIO5UYlhgrdQ==
X-CSE-MsgGUID: l+D8tFyKQjqvyw1AwlonyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="275057068"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 00:32:35 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v5 3/5] doc: describe ethdev Tx timestamp slot API
Date: Tue,  8 Sep 2026 13:02:04 +0530
Message-ID: <20260908073206.1236372-4-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908073206.1236372-1-rajesh3.kumar@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260908073206.1236372-1-rajesh3.kumar@intel.com>
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

Document the Tx timestamp capability model, the per-packet slot
lifecycle, and the application workflow introduced for slot-based
transmit timestamping.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/prog_guide/ethdev/timesync.rst | 147 ++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/doc/guides/prog_guide/ethdev/timesync.rst b/doc/guides/prog_guide/ethdev/timesync.rst
index 59d660eba8..f11eaf0557 100644
--- a/doc/guides/prog_guide/ethdev/timesync.rst
+++ b/doc/guides/prog_guide/ethdev/timesync.rst
@@ -57,6 +57,129 @@ Rx Timestamp Extraction Workflow
       Stored in a registered mbuf dynamic field (e.g. ``rte_mbuf_dyn_rx_timestamp_register()``).
 
 
+Transmit (Tx) Timestamping Architectures
+----------------------------------------
+
+The framework supports two hardware transmit timestamping architectures:
+
+* **Single Shared Register** (``RTE_ETH_TIMESYNC_TX_SLOT_SINGLE_REG``):
+  The hardware contains a single shared transmit timestamp latch register.
+  Only one outbound packet can be timestamped at a time across the entire port.
+  The application calls ``rte_eth_timesync_read_tx_timestamp(port_id, &ts)`` to retrieve the departure time.
+
+* **Per-Packet Slot Bank** (``RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET``):
+  The hardware provides a bank of independent transmit timestamp slots or descriptors.
+  Multiple outbound PTP packets can be timestamped concurrently and correlated asynchronously on a per-packet basis using slot handles.
+
+
+Dual-Domain Timestamps
+~~~~~~~~~~~~~~~~~~~~~~
+
+When retrieving transmit timestamps using slot handles, the API returns a dual-domain timestamp structure:
+
+.. code-block:: c
+
+    struct rte_eth_timesync_dual_domain_timestamp {
+        int64_t adjusted_ns; /**< PHC adjusted time (wall-clock nanoseconds) */
+        int64_t raw_ns;      /**< Free-running hardware cycle counter or raw nanoseconds */
+        uint32_t valid_mask; /**< Validity bits for the adjusted/raw domains */
+        uint32_t reserved;   /**< Reserved for future use, must be zero */
+    };
+
+* **Adjusted Domain** (``RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID``):
+  Represents the wall-clock time after frequency adjustments (``rte_eth_timesync_adjust_freq``) or phase steps (``rte_eth_timesync_adjust_time``) have been applied.
+
+* **Raw Domain** (``RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_RAW_VALID``):
+  Represents the unadjusted free-running hardware cycle counter or raw timestamp.
+  This domain is required when correlating adjusted wall-clock time with the underlying hardware timebase or when performing cross-timestamp analysis.
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
+          struct rte_eth_timesync_tx_slot_caps caps;
+
+          ret = rte_eth_timesync_tx_slot_caps(port_id, &caps);
+          if (ret == 0 && caps.type == RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET) {
+                printf("Port %u supports per-packet timestamping with %u max slots\n",
+                           port_id, caps.max_slots);
+          }
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
+      ``rte_eth_timesync_tx_slot_dynfield_register()`` must be called explicitly before ``rte_pktmbuf_pool_create()``.
+      It is **not** called automatically by ``rte_eth_timesync_enable()``.
+      Dynamic fields and flags remain registered until process shutdown; DPDK does not support unregistering them.
+
+3. **Allocate a Timestamp Slot**
+   Before transmitting a PTP packet requiring a transmit timestamp, allocate a slot handle:
+
+   .. code-block:: c
+
+       uint32_t slot_id;
+
+       ret = rte_eth_timesync_tx_slot_alloc(port_id, &slot_id);
+       if (ret != 0) {
+           /* Handle allocation error (e.g. -ENOSPC if all slots are in flight) */
+       }
+
+4. **Stamp the Mbuf**
+   Attach the allocated slot handle to the mbuf:
+
+   .. code-block:: c
+
+         ret = rte_eth_timesync_tx_slot_stamp(slot_id, mbuf);
+         if (ret != 0) {
+            rte_eth_timesync_tx_slot_release(port_id, slot_id);
+            /* The dynfield setup was not completed or an argument is invalid */
+         } else {
+            mbuf->ol_flags |= RTE_MBUF_F_TX_IEEE1588_TMST;
+         }
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
+       ret = rte_eth_timesync_tx_slot_read(port_id, slot_id, &ts);
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
+          rte_eth_timesync_tx_slot_release(port_id, slot_id);
+
 PMD Implementation Requirements
 -------------------------------
 
@@ -70,3 +193,27 @@ To support full timesync capabilities, a Poll Mode Driver (PMD) implements the f
 2. Rx Timestamping (``timesync_read_rx_timestamp``)
 
    Configures Rx filters to latch incoming PTP arrival times and flags received mbufs with ``RTE_MBUF_F_RX_IEEE1588_PTP``.
+
+3. Tx Slot Capability Reporting (``timesync_tx_slot_get_caps``)
+
+   Reports ``RTE_ETH_TIMESYNC_TX_SLOT_SINGLE_REG`` or ``RTE_ETH_TIMESYNC_TX_SLOT_PER_PACKET`` in ``caps->type`` and sets ``caps->max_slots``.
+
+4. Slot Allocation & Release
+   (``timesync_tx_slot_alloc`` / ``timesync_tx_slot_release``)
+
+   Maintains a port-global pool or bitmap of hardware timestamp slots.
+   ``timesync_tx_slot_alloc`` returns an opaque port-unique slot handle and returns ``-ENOSPC`` when no slots are free.
+   ``timesync_tx_slot_release`` clears hardware slot state and returns the handle to the free pool.
+   Passing an invalid or already-released handle should return ``-EINVAL``.
+
+5. Tx Datapath Integration
+
+   Checks if ``RTE_MBUF_F_TX_IEEE1588_TMST`` is set on ``mbuf->ol_flags``.
+   For per-packet slot mode, retrieves ``slot_id`` from mbuf dynamic field via ``*RTE_MBUF_DYNFIELD(m, dynfield_offset, uint32_t *)``.
+   Configures hardware Tx descriptors to capture departure timestamps into the specified slot.
+
+6. Tx Slot Timestamp Retrieval
+   (``timesync_tx_slot_read``)
+
+   Queries hardware slot or descriptor completion ring corresponding to ``slot_id``.
+   Populates ``struct rte_eth_timesync_dual_domain_timestamp`` and returns ``0`` when ready, or ``-EAGAIN`` if pending.
-- 
2.55.0


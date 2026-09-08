Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3919C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:32:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4C3340E01;
	Tue,  8 Sep 2026 09:32:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B88A640DF5
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:32:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788852755; x=1820388755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N4eFz6drkY1KdLKW4BpKAiCtvrYll2M3z6Wu87AWD3E=;
 b=kgDpDo+YeRpMtlFLZjf10a9iLVHR6WSW1sGY1wvpbcGCUsb3j91EYTlc
 rYbdCYIt5s7la6zzhBaHY4IzhDte/+UjTVPdOM7RSRfMq6VJX6+QXhqN9
 smE8MUUlWB9K+Uxivp36NIMOF4COoqy7DqG8jny4Mxob0pyy7Kj32sE3H
 8+FVSBBX1xUuOVFd5NaDF9b065PQov7aB5sE/5bz1dagBSl8B6XT46+To
 6QG6EoSN1KPIts5SOylhNHyya6S6JBp680fyTuyg+RIEUwGvLIEMeeulY
 BZ45yYPPvyAvEYh51Xpq1VcPAbRLbJ7E8ST++vO1OOTAAcvdj9RiWpHpz Q==;
X-CSE-ConnectionGUID: YjUgPj0/R3mAX1zWFybW2w==
X-CSE-MsgGUID: bGFZPVDaQk2OtF1kOOEZ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89290181"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89290181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:32:34 -0700
X-CSE-ConnectionGUID: hYPWiGpBTladU78n2EGxSQ==
X-CSE-MsgGUID: aUIaQM08RlyI5FWUx7zegw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="275057047"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 00:32:31 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v5 2/5] doc: describe ethdev timesync clock and Rx
 timestamp API
Date: Tue,  8 Sep 2026 13:02:03 +0530
Message-ID: <20260908073206.1236372-3-rajesh3.kumar@intel.com>
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

Add a programming guide page for the ethdev IEEE 1588 / PTP timesync
API, covering PHC clock management and receive timestamp extraction.

This describes existing, previously undocumented API and does not
introduce any new functionality.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/prog_guide/ethdev/index.rst    |  1 +
 doc/guides/prog_guide/ethdev/timesync.rst | 72 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst

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
index 0000000000..59d660eba8
--- /dev/null
+++ b/doc/guides/prog_guide/ethdev/timesync.rst
@@ -0,0 +1,72 @@
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
+Enable / Disable
+   ``rte_eth_timesync_enable(port_id)`` enables hardware timestamping on the specified port.
+   ``rte_eth_timesync_disable(port_id)`` disables timesync offloads.
+   The application must ensure no Tx timestamp operations are in flight before disabling timesync, unless the PMD explicitly supports concurrent disable and Tx timestamp operations.
+   This does not make the PMD hardware lifecycle safe by itself.
+
+Clock Time Read / Write
+   ``rte_eth_timesync_read_time(port_id, &ts)`` reads the current PHC wall-clock time as a ``struct timespec``.
+   ``rte_eth_timesync_write_time(port_id, &ts)`` sets the PHC wall-clock time.
+
+Clock Adjustments
+   ``rte_eth_timesync_adjust_time(port_id, delta_ns)`` adjusts the clock phase by a delta offset in nanoseconds.
+   ``rte_eth_timesync_adjust_freq(port_id, scaled_ppm)`` adjusts the clock frequency in scaled parts-per-million (1 ppm = 1 << 16).
+
+
+Receive (Rx) Timestamping
+-------------------------
+
+When receive timestamping is enabled, the hardware identifies incoming PTP packets and latches their arrival time.
+
+Rx Timestamp Extraction Workflow
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. On packet reception via ``rte_eth_rx_burst()``, the PMD checks if the received mbuf represents a PTP packet.
+2. The PMD sets the ``RTE_MBUF_F_RX_IEEE1588_PTP`` flag in ``mbuf->ol_flags``.
+3. Depending on the PMD and hardware capability, the Rx timestamp is either:
+
+   Extracted via API
+      Application calls ``rte_eth_timesync_read_rx_timestamp(port_id, &ts, flags)``.
+
+   Inlined in Mbuf
+      Stored in a registered mbuf dynamic field (e.g. ``rte_mbuf_dyn_rx_timestamp_register()``).
+
+
+PMD Implementation Requirements
+-------------------------------
+
+To support full timesync capabilities, a Poll Mode Driver (PMD) implements the following driver contract:
+
+1. Clock Operations
+   (``timesync_enable``, ``timesync_disable``, ``timesync_read_time``, ``timesync_write_time``, ``timesync_adjust_time``, ``timesync_adjust_freq``)
+
+   Controls hardware timestamp generation and disciplines the hardware clock registers.
+
+2. Rx Timestamping (``timesync_read_rx_timestamp``)
+
+   Configures Rx filters to latch incoming PTP arrival times and flags received mbufs with ``RTE_MBUF_F_RX_IEEE1588_PTP``.
-- 
2.55.0


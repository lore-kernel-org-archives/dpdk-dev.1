Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D26CD3436
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 10:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BDDD4069D;
	Wed,  6 May 2026 12:16:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AF18C4066A
 for <dev@dpdk.org>; Wed,  6 May 2026 12:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778062567; x=1809598567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OUtdOXKWYW+OHDVqpV9r5z5z4Xop1NAhvk7niuKAvjQ=;
 b=mZwg2LWxa/Fw90zQgfMkruLVmLV5tedj5eK33Kg2Z3dlCQTytBjEOakF
 XcyEhIDNAtAQbhDAMF+lRo6bcBSZF1Jb3vYODFgilXMnkVcyfv41pX42r
 r+N2jXCzOaB86/THFEoakMRrKJM1gjrtrNeVSvR0dEffMEOVUvAMIrpLV
 J+Az+NHQv0lJeOBYy2Jmb+fXZBMP1BCXLvhuhbbllC1gi9XyAJcGyK8QX
 bTfRbnECzjESLtaq7JTQNe6+fRrO7TiIJ3OAiHxXDc/mojpMQ0Z7AdKjN
 wUcI7eQUk8QCh5go+aBubLvfI1S6rcCsDsVExIzB5UV7hlxKDMQyophTw A==;
X-CSE-ConnectionGUID: hnnT3Yj7SqmrIZ4bZd1KFQ==
X-CSE-MsgGUID: +j4xIzORS5OEvHCPALFrTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82595122"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="82595122"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:16:06 -0700
X-CSE-ConnectionGUID: cQ9YHM7LTVelDonhwfa+Ag==
X-CSE-MsgGUID: 1l1iF4hyQeGSMEmwnc85gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="233444904"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2026 03:16:04 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC v5 4/6] doc: add PTP software relay sample app guide
Date: Wed,  6 May 2026 21:11:26 +0530
Message-ID: <20260506154131.2496072-5-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506154131.2496072-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260506154131.2496072-1-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Add a sample application user guide for the ptp_tap_relay_sw example.
The guide covers the application topology, packet flow, compilation,
command-line options, and a code walkthrough explaining the two-pass
relay burst design and CLOCK_MONOTONIC_RAW timestamp source selection.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/sample_app_ug/index.rst            |   1 +
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst | 212 ++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst

diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/index.rst
index e895f692f9..f12623bb66 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -51,6 +51,7 @@ Sample Applications User Guides
     dist_app
     vm_power_management
     ptpclient
+    ptp_tap_relay_sw
     fips_validation
     ipsec_secgw
     bbdev_app
diff --git a/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst b/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
new file mode 100644
index 0000000000..1af2601fdb
--- /dev/null
+++ b/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
@@ -0,0 +1,212 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation.
+
+PTP Software Relay Sample Application
+======================================
+
+The PTP Software Relay sample application demonstrates how to use the
+DPDK ``lib/ptp`` library to build a minimal PTP Transparent Clock relay
+between a DPDK-bound physical NIC and a kernel TAP interface using
+**software timestamps only**.
+
+No patched kernel modules or custom TAP PMD changes are required.
+The application works with an unmodified Linux kernel and stock DPDK.
+
+For background on PTP see:
+`Precision Time Protocol
+<https://en.wikipedia.org/wiki/Precision_Time_Protocol>`_.
+
+
+Limitations
+-----------
+
+* Tested with L2 PTP (EtherType 0x88F7) on the wire.
+   The underlying PTP library also classifies VLAN/QinQ and UDP/IPv4/IPv6.
+* Only PTP v2 messages are processed.
+* Software timestamps have microsecond-class jitter; sub-microsecond
+  precision depends on system load and NIC-to-TAP forwarding latency.
+* The PTP time transmitter must be reachable on the physical NIC's L2 network.
+* Only one physical port and one TAP port are supported.
+
+
+How the Application Works
+-------------------------
+
+Topology
+~~~~~~~~
+
+::
+
+    PTP Time Transmitter  Physical NIC             TAP (kernel)
+    (ptp4l -H)  ──L2──  (DPDK vfio-pci)  ──────  dtap0
+                              │                      │
+                        ptp_tap_relay_sw            ptp4l -S
+                     (correctionField +=        (SW timestamps,
+                      residence time)           adjusts CLOCK_REALTIME)
+
+The relay sits between a DPDK-owned physical NIC and a kernel TAP
+virtual interface.  ``ptp4l`` runs on the TAP interface in software
+timestamp mode (``-S``) as a PTP time receiver.
+
+Packet Flow
+~~~~~~~~~~~
+
+1. The physical NIC receives PTP (and non-PTP) packets via DPDK RX.
+2. A software RX timestamp is recorded using
+   ``clock_gettime(CLOCK_MONOTONIC)``.
+3. Each packet is classified with ``rte_ptp_classify()``.
+4. For PTP **event** messages (Sync, Delay_Req, PDelay_Req, PDelay_Resp),
+   a TX software timestamp is taken just before transmission.
+5. The residence time (``tx_ts − rx_ts``) is added to the PTP
+   ``correctionField`` via ``rte_ptp_add_correction()`` — standard
+   IEEE 1588-2019 Transparent Clock behaviour (§10.2).
+6. Packets are forwarded bidirectionally:
+
+   * PHY → TAP  (network → ptp4l)
+   * TAP → PHY  (ptp4l → network)
+
+A two-pass design is used: first all packets are classified and PTP
+header pointers saved, then a single TX timestamp is taken immediately
+before applying corrections and calling ``rte_eth_tx_burst()``.
+This minimises the gap between the measured timestamp and the actual
+wire egress.
+
+
+Compiling the Application
+-------------------------
+
+To compile the sample application see :doc:`compiling`.
+
+The application is located in the ``ptp_tap_relay_sw`` sub-directory.
+
+.. note::
+
+   The application depends on the ``ptp`` library.
+   Ensure that ``lib/ptp`` is built (it is built by default).
+
+
+Running the Application
+-----------------------
+
+Prerequisites
+~~~~~~~~~~~~~
+
+* A PTP-capable physical NIC bound to DPDK (e.g. via ``vfio-pci``).
+* ``linuxptp`` (``ptp4l``) installed on the system.
+* A PTP time transmitter reachable on the same L2 network.
+
+Start the relay
+~~~~~~~~~~~~~~~~
+
+.. code-block:: console
+
+   ./<build_dir>/examples/dpdk-ptp_tap_relay_sw \
+       -l 18-19 -a 0000:cc:00.1 --vdev=net_tap0,iface=dtap0 -- \
+       -p 0 -t 1 -T 10
+
+Command-line Options
+~~~~~~~~~~~~~~~~~~~~
+
+* ``-p PORT`` — Physical NIC port ID (default: 0).
+* ``-t PORT`` — TAP port ID (default: 1).
+* ``-T SECS`` — Statistics print interval in seconds (default: 10).
+
+Start PTP time transmitter
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+On a separate terminal or remote host, start ``ptp4l`` as time
+transmitter with hardware timestamps on the physical NIC:
+
+.. code-block:: console
+
+   ptp4l -i <iface> -m -2 -H --serverOnly=1 \
+       --logSyncInterval=-4 --logMinDelayReqInterval=-4
+
+Start PTP time receiver
+~~~~~~~~~~~~~~~~~~~~~~~
+
+On the TAP interface, start ``ptp4l`` in software timestamp mode:
+
+.. code-block:: console
+
+   ptp4l -i dtap0 -m -2 -s -S \
+       --delay_filter=moving_median --delay_filter_length=10
+
+The time receiver will enter UNCALIBRATED state for approximately 60
+seconds while the PI servo estimates the frequency offset, then step
+the clock and enter time-receiver (synchronized) state.
+Steady-state RMS offset of 500–1000 ns is typical on a lightly loaded
+system with a hardware-timestamped time transmitter.
+
+Example Output
+~~~~~~~~~~~~~~
+
+Relay statistics printed every ``-T`` seconds:
+
+::
+
+   [PTP-SW] === Statistics ===
+   [PTP-SW]   PHY RX total:   5646
+   [PTP-SW]   PHY RX PTP:     5598
+   [PTP-SW]   TAP TX:         5646
+   [PTP-SW]   TAP RX total:   1800
+   [PTP-SW]   TAP RX PTP:     1788
+   [PTP-SW]   PHY TX:         1800
+   [PTP-SW]   Corrections:    3635
+
+Time receiver ``ptp4l`` output after convergence:
+
+::
+
+   ptp4l[451534.520]: rms  630 max 1166 freq -44365 +/- 100 delay 37668 +/-  71
+   ptp4l[451539.525]: rms  602 max 1177 freq -44339 +/- 119 delay 37517 +/-  43
+   ptp4l[451544.530]: rms  535 max 1194 freq -44345 +/- 103 delay 37410 +/-  81
+
+
+Code Explanation
+----------------
+
+The following sections explain the main components of the application.
+
+Relay Burst Function
+~~~~~~~~~~~~~~~~~~~~
+
+The core relay logic is in ``relay_burst()``, which handles one direction
+(PHY→TAP or TAP→PHY) per call:
+
+**Pass 1 — Classify:**
+
+For each received packet, ``rte_ptp_classify()`` determines if it is a
+PTP message.  For event messages, ``rte_ptp_hdr_get()`` retrieves a
+pointer to the PTP header, which is saved for the second pass.
+
+**Pass 2 — Timestamp and correct:**
+
+A single software TX timestamp is taken via
+``clock_gettime(CLOCK_MONOTONIC)``.  The residence time
+(``tx_ts − rx_ts``) is added to each saved PTP header's
+``correctionField`` using ``rte_ptp_add_correction()``.
+The burst is then transmitted with ``rte_eth_tx_burst()``.
+
+Main Loop
+~~~~~~~~~
+
+The ``relay_loop()`` function polls both directions in a tight loop:
+
+.. code-block:: c
+
+   while (!force_quit) {
+       relay_burst(phy_port, tap_port, ...);   /* PHY → TAP */
+       relay_burst(tap_port, phy_port, ...);   /* TAP → PHY */
+   }
+
+Statistics are printed at the interval specified by ``-T``.
+
+Timestamp Source
+~~~~~~~~~~~~~~~~
+
+``CLOCK_MONOTONIC`` is used rather than ``CLOCK_REALTIME`` because
+the PTP time receiver's servo continuously adjusts ``CLOCK_REALTIME``.
+Using ``CLOCK_REALTIME`` would corrupt residence time measurements
+during clock stepping or frequency slewing.  ``CLOCK_MONOTONIC`` is
+portable across Linux and FreeBSD.
-- 
2.53.0


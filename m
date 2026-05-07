Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED98CCD3442
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 08:20:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFB5440664;
	Thu,  7 May 2026 10:20:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id ABD1D40652
 for <dev@dpdk.org>; Thu,  7 May 2026 10:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778142003; x=1809678003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1R5PCaneohTlZq+WY13TVUNsU6qVu6mHUc00Opy5RbU=;
 b=YhMr7GWlTaWLQHDFbyLOS9D34EyDwH9HDvJCmVdDBZkP4XAEYkA4Fciy
 +TvTXKjO9PPqchgOtyMI/hkdIJURjZPaVVpAiIggF/lA3+59hUk+zlZ59
 6us7gPVq+QwL+9AbMjYGF9VoEK53lyaja/UMkClOSr61nQeMrlHlN7PNt
 d+5V5EKug79TDF1zabjpB5pZW4BHzVFQslvukt61w9C/kx1NN+DHrXPJd
 jLWq2eU4NoMP95UaoR3ZbS1WYYkbBIXeTxxQ/d2cr8IqVDkg4hzmfMopb
 KRmex5O3k0NF/OgKCmJolKTA/zphGLA8lC7/jiYvkLbt9SVk4xrjIKWFt A==;
X-CSE-ConnectionGUID: +QqjMP3lRV2ucvp+hTQ2EQ==
X-CSE-MsgGUID: RPbaOkKOTAGR6/wen1KuqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79075747"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79075747"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 01:20:02 -0700
X-CSE-ConnectionGUID: mo2a7bswRZ2GiDY6XulVjA==
X-CSE-MsgGUID: MAJEwv1GRIWDW59+b/UyRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="236313780"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa008.jf.intel.com with ESMTP; 07 May 2026 01:20:00 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v7 2/4] examples/ptp_tap_relay_sw: add PTP software
 transparent clock relay
Date: Thu,  7 May 2026 19:15:27 +0530
Message-ID: <20260507134529.2573300-3-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507134529.2573300-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260507134529.2573300-1-rajesh3.kumar@intel.com>
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

Add a new example application demonstrating a software PTP Transparent
Clock relay between a DPDK-bound physical NIC and a Linux kernel TAP
virtual interface.

The relay uses software timestamps (CLOCK_MONOTONIC) to measure residence
time and accumulates it into the PTP correctionField per IEEE 1588-2019
§10.2, enabling synchronized time distribution via standard linuxptp
(ptp4l) on both sides.

Features:
  - Handles L2, VLAN/QinQ, and UDP/IPv4/IPv6 PTP encapsulations
  - Supports PTP v2 event messages (Sync, Delay_Req, PDelay_Req,
    PDelay_Resp)
  - Two-pass burst processing: classify before TX, timestamp before
    relay
  - Unmodified Linux kernel and stock DPDK (no kernel patches required)
  - Bidirectional relay: PHY ↔ TAP

Includes:
  - ptp_tap_relay_sw.c: Main relay logic with burst processing
  - ptp_parse.h: Local DPI parser for PTP classification
    (not a library API)
  - Sample app guide with topology, command-line options, and
    example output

Uses lib/net/rte_ptp.h inline helpers for correctionField manipulation
and header parsing.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/sample_app_ug/index.rst            |   1 +
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst | 212 +++++++++
 examples/ptp_tap_relay_sw/Makefile            |  41 ++
 examples/ptp_tap_relay_sw/meson.build         |  13 +
 examples/ptp_tap_relay_sw/ptp_parse.h         | 211 +++++++++
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  | 432 ++++++++++++++++++
 6 files changed, 910 insertions(+)
 create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
 create mode 100644 examples/ptp_tap_relay_sw/Makefile
 create mode 100644 examples/ptp_tap_relay_sw/meson.build
 create mode 100644 examples/ptp_tap_relay_sw/ptp_parse.h
 create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c

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
index 0000000000..15727383c1
--- /dev/null
+++ b/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
@@ -0,0 +1,212 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation.
+
+PTP Software Relay Sample Application
+======================================
+
+The PTP Software Relay sample application demonstrates how to build a
+minimal PTP Transparent Clock relay between a DPDK-bound physical NIC
+and a kernel TAP interface using **software timestamps only**.  It uses
+the PTP definitions from ``rte_ptp.h`` (in ``lib/net/``) together with a
+local packet parser.
+
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
+   The local parser also classifies VLAN/QinQ and UDP/IPv4/IPv6.
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
+3. Each packet is parsed to locate the PTP header.
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
+   The application uses ``rte_ptp.h`` from ``lib/net/`` (built by default)
+   and a local ``ptp_parse.h`` header for packet classification.
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
+For each received packet, ``ptp_hdr_find()`` locates the PTP header
+(if present).  For event messages, the header pointer is saved for the
+second pass.
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
diff --git a/examples/ptp_tap_relay_sw/Makefile b/examples/ptp_tap_relay_sw/Makefile
new file mode 100644
index 0000000000..fd178f46ae
--- /dev/null
+++ b/examples/ptp_tap_relay_sw/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+# binary name
+APP = dpdk-ptp_tap_relay_sw
+
+# all source are stored in SRCS-y
+SRCS-y := ptp_tap_relay_sw.c
+
+PKGCONF ?= pkg-config
+
+# Build using pkg-config variables if possible
+ifneq ($(shell $(PKGCONF) --exists libdpdk && echo 0),0)
+$(error "no installation of DPDK found")
+endif
+
+all: shared
+.PHONY: shared static
+shared: build/$(APP)-shared
+	ln -sf $(APP)-shared build/$(APP)
+static: build/$(APP)-static
+	ln -sf $(APP)-static build/$(APP)
+
+PC_FILE := $(shell $(PKGCONF) --path libdpdk 2>/dev/null)
+CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
+LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
+LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
+
+build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
+	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
+
+build/$(APP)-static: $(SRCS-y) Makefile $(PC_FILE) | build
+	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_STATIC)
+
+build:
+	@mkdir -p $@
+
+.PHONY: clean
+clean:
+	rm -f build/$(APP) build/$(APP)-static build/$(APP)-shared
+	test -d build && rmdir -p build || true
diff --git a/examples/ptp_tap_relay_sw/meson.build b/examples/ptp_tap_relay_sw/meson.build
new file mode 100644
index 0000000000..34a4d86439
--- /dev/null
+++ b/examples/ptp_tap_relay_sw/meson.build
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+# meson file, for building this example as part of a main DPDK build.
+#
+# To build this example as a standalone application with an already-installed
+# DPDK instance, use 'make'
+
+sources = files(
+        'ptp_tap_relay_sw.c',
+)
+deps += ['net']
+cflags += no_shadow_cflag
diff --git a/examples/ptp_tap_relay_sw/ptp_parse.h b/examples/ptp_tap_relay_sw/ptp_parse.h
new file mode 100644
index 0000000000..db0dcfe5c1
--- /dev/null
+++ b/examples/ptp_tap_relay_sw/ptp_parse.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ *
+ * PTP packet parser — locates PTP headers through L2, VLAN, and UDP
+ * encapsulations. This is a DPI helper for use within example
+ * applications; it does not belong in the core library.
+ */
+
+#ifndef _PTP_PARSE_H_
+#define _PTP_PARSE_H_
+
+#include <rte_mbuf.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_ptp.h>
+
+/** Not a PTP packet. */
+#define PTP_MSGTYPE_INVALID  (-1)
+
+/**
+ * Locate the PTP header within a packet.
+ *
+ * Handles L2 (EtherType 0x88F7), VLAN-tagged L2 (single/double,
+ * TPIDs 0x8100/0x88A8), PTP over UDP/IPv4, PTP over UDP/IPv6,
+ * and VLAN-tagged UDP variants.
+ *
+ * @param m
+ *   Pointer to the mbuf.
+ * @return
+ *   Pointer to the PTP header, or NULL if not a PTP packet.
+ */
+static inline struct rte_ptp_hdr *
+ptp_hdr_find(const struct rte_mbuf *m)
+{
+	const struct rte_ether_hdr *eth;
+	uint16_t ether_type;
+	uint32_t offset;
+
+	if (rte_pktmbuf_data_len(m) < sizeof(struct rte_ether_hdr))
+		return NULL;
+
+	eth = rte_pktmbuf_mtod(m, const struct rte_ether_hdr *);
+	ether_type = rte_be_to_cpu_16(eth->ether_type);
+	offset = sizeof(struct rte_ether_hdr);
+
+	/* Strip VLAN / QinQ tags */
+	if (ether_type == RTE_ETHER_TYPE_VLAN ||
+	    ether_type == RTE_ETHER_TYPE_QINQ) {
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_vlan_hdr))
+			return NULL;
+		const struct rte_vlan_hdr *vlan =
+			rte_pktmbuf_mtod_offset(m,
+				const struct rte_vlan_hdr *, offset);
+		ether_type = rte_be_to_cpu_16(vlan->eth_proto);
+		offset += sizeof(struct rte_vlan_hdr);
+
+		/* Second tag (QinQ inner or stacked VLAN) */
+		if (ether_type == RTE_ETHER_TYPE_VLAN ||
+		    ether_type == RTE_ETHER_TYPE_QINQ) {
+			if (rte_pktmbuf_data_len(m) <
+			    offset + sizeof(struct rte_vlan_hdr))
+				return NULL;
+			vlan = rte_pktmbuf_mtod_offset(m,
+				const struct rte_vlan_hdr *, offset);
+			ether_type = rte_be_to_cpu_16(vlan->eth_proto);
+			offset += sizeof(struct rte_vlan_hdr);
+		}
+	}
+
+	/* L2 PTP: EtherType 0x88F7 */
+	if (ether_type == RTE_ETHER_TYPE_1588) {
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ptp_hdr))
+			return NULL;
+		return rte_pktmbuf_mtod_offset(m,
+			struct rte_ptp_hdr *, offset);
+	}
+
+	/* PTP over UDP/IPv4 */
+	if (ether_type == RTE_ETHER_TYPE_IPV4) {
+		const struct rte_ipv4_hdr *iph;
+		uint16_t ihl;
+
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ipv4_hdr))
+			return NULL;
+
+		iph = rte_pktmbuf_mtod_offset(m,
+			const struct rte_ipv4_hdr *, offset);
+		if (iph->next_proto_id != IPPROTO_UDP)
+			return NULL;
+
+		ihl = (iph->version_ihl & 0x0F) * 4;
+		if (ihl < 20)
+			return NULL;
+		offset += ihl;
+
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_udp_hdr))
+			return NULL;
+
+		const struct rte_udp_hdr *udp =
+			rte_pktmbuf_mtod_offset(m,
+				const struct rte_udp_hdr *, offset);
+		uint16_t dst_port = rte_be_to_cpu_16(udp->dst_port);
+
+		if (dst_port != RTE_PTP_EVENT_PORT &&
+		    dst_port != RTE_PTP_GENERAL_PORT)
+			return NULL;
+
+		offset += sizeof(struct rte_udp_hdr);
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ptp_hdr))
+			return NULL;
+
+		return rte_pktmbuf_mtod_offset(m,
+			struct rte_ptp_hdr *, offset);
+	}
+
+	/* PTP over UDP/IPv6 */
+	if (ether_type == RTE_ETHER_TYPE_IPV6) {
+		const struct rte_ipv6_hdr *ip6h;
+
+		if (rte_pktmbuf_data_len(m) <
+		    offset + sizeof(struct rte_ipv6_hdr))
+			return NULL;
+
+		ip6h = rte_pktmbuf_mtod_offset(m,
+			const struct rte_ipv6_hdr *, offset);
+		if (ip6h->proto != IPPROTO_UDP)
+			return NULL;
+
+		offset += sizeof(struct rte_ipv6_hdr);
+
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_udp_hdr))
+			return NULL;
+
+		const struct rte_udp_hdr *udp =
+			rte_pktmbuf_mtod_offset(m,
+				const struct rte_udp_hdr *, offset);
+		uint16_t dst_port = rte_be_to_cpu_16(udp->dst_port);
+
+		if (dst_port != RTE_PTP_EVENT_PORT &&
+		    dst_port != RTE_PTP_GENERAL_PORT)
+			return NULL;
+
+		offset += sizeof(struct rte_udp_hdr);
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ptp_hdr))
+			return NULL;
+
+		return rte_pktmbuf_mtod_offset(m,
+			struct rte_ptp_hdr *, offset);
+	}
+
+	return NULL;
+}
+
+/**
+ * Classify a packet as PTP and return the message type.
+ *
+ * @param m
+ *   Pointer to the mbuf to classify.
+ * @return
+ *   PTP message type (0x0-0xF) on success, PTP_MSGTYPE_INVALID (-1)
+ *   if the packet is not PTP.
+ */
+static inline int
+ptp_classify(const struct rte_mbuf *m)
+{
+	struct rte_ptp_hdr *hdr = ptp_hdr_find(m);
+
+	if (hdr == NULL)
+		return PTP_MSGTYPE_INVALID;
+
+	return rte_ptp_msg_type(hdr);
+}
+
+/** PTP message type name table. */
+static const char * const ptp_msg_names[] = {
+	[RTE_PTP_MSGTYPE_SYNC]           = "Sync",
+	[RTE_PTP_MSGTYPE_DELAY_REQ]      = "Delay_Req",
+	[RTE_PTP_MSGTYPE_PDELAY_REQ]     = "PDelay_Req",
+	[RTE_PTP_MSGTYPE_PDELAY_RESP]    = "PDelay_Resp",
+	[0x4]                            = "Reserved_4",
+	[0x5]                            = "Reserved_5",
+	[0x6]                            = "Reserved_6",
+	[0x7]                            = "Reserved_7",
+	[RTE_PTP_MSGTYPE_FOLLOW_UP]      = "Follow_Up",
+	[RTE_PTP_MSGTYPE_DELAY_RESP]     = "Delay_Resp",
+	[RTE_PTP_MSGTYPE_PDELAY_RESP_FU] = "PDelay_Resp_Follow_Up",
+	[RTE_PTP_MSGTYPE_ANNOUNCE]       = "Announce",
+	[RTE_PTP_MSGTYPE_SIGNALING]      = "Signaling",
+	[RTE_PTP_MSGTYPE_MANAGEMENT]     = "Management",
+	[0xE]                            = "Reserved_E",
+	[0xF]                            = "Reserved_F",
+};
+
+/**
+ * Get a human-readable name for a PTP message type.
+ *
+ * @param msg_type
+ *   PTP message type (0x0-0xF or PTP_MSGTYPE_INVALID).
+ * @return
+ *   Static string with the message type name.
+ */
+static inline const char *
+ptp_msg_type_str(int msg_type)
+{
+	if (msg_type < 0 || msg_type > 0xF)
+		return "Not_PTP";
+	return ptp_msg_names[msg_type];
+}
+
+#endif /* _PTP_PARSE_H_ */
diff --git a/examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c b/examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
new file mode 100644
index 0000000000..998df2ac3b
--- /dev/null
+++ b/examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
@@ -0,0 +1,432 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+/*
+ * PTP Software Relay
+ *
+ * A minimal PTP relay between a DPDK-bound physical NIC and a kernel
+ * TAP interface using software timestamps only.
+ *
+ * How it works:
+ *   1. Physical NIC receives PTP (and non-PTP) packets via DPDK RX.
+ *   2. For PTP event messages (Sync, Delay_Req, PDelay_Req, PDelay_Resp)
+ *      the relay records an RX software timestamp (clock_gettime).
+ *   3. Just before TX on the other side it records a TX software timestamp.
+ *   4. The relay residence time (tx_ts − rx_ts) is added to the PTP
+ *      correctionField via rte_ptp_add_correction() — standard
+ *      Transparent Clock behaviour (IEEE 1588-2019 §10.2).
+ *   5. Packets are forwarded bi-directionally:
+ *        PHY → TAP   (network → ptp4l)
+ *        TAP → PHY   (ptp4l → network)
+ *
+ * ptp4l runs in software-timestamping mode on the TAP interface:
+ *
+ *   ptp4l -i dtap0 -m -s -S   # -S = software timestamps
+ *
+ * Topology:
+ *
+ *   Time Transmitter (remote) ──L2── Physical NIC (DPDK)
+ *                                      │
+ *                                PTP SW Relay  ← correctionField update
+ *                                      │
+ *                                TAP (kernel) ── ptp4l -S (time receiver)
+ *
+ * Usage:
+ *   dpdk-ptp_tap_relay_sw -l 0-1 --vdev=net_tap0,iface=dtap0 -- \
+ *       -p 0 -t 1
+ *
+ * Parameters:
+ *   -p PORT    Physical NIC port ID (default: 0)
+ *   -t PORT    TAP port ID (default: 1)
+ *   -T SECS    Stats print interval in seconds (default: 10)
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <getopt.h>
+#include <time.h>
+
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_mbuf.h>
+#include <rte_cycles.h>
+#include <rte_lcore.h>
+
+#include "ptp_parse.h"
+
+/* Ring sizes */
+#define RX_RING_SIZE  1024
+#define TX_RING_SIZE  1024
+
+/* Mempool */
+#define NUM_MBUFS     8191
+#define MBUF_CACHE    250
+#define BURST_SIZE    32
+
+#define NSEC_PER_SEC  1000000000ULL
+
+/* Logging helpers */
+#define LOG_INFO(fmt, ...) \
+	fprintf(stdout, "[PTP-SW] " fmt "\n", ##__VA_ARGS__)
+#define LOG_ERR(fmt, ...) \
+	fprintf(stderr, "[PTP-SW ERROR] " fmt "\n", ##__VA_ARGS__)
+
+static volatile bool force_quit;
+
+/* Port IDs */
+static uint16_t phy_port;
+static uint16_t tap_port = 1;
+static unsigned int stats_interval = 10;  /* seconds */
+
+/* Statistics */
+static struct {
+	uint64_t phy_rx;        /* total packets from PHY */
+	uint64_t phy_rx_ptp;    /* PTP packets from PHY */
+	uint64_t tap_tx;        /* packets forwarded to TAP */
+	uint64_t tap_rx;        /* total packets from TAP */
+	uint64_t tap_rx_ptp;    /* PTP packets from TAP */
+	uint64_t phy_tx;        /* packets forwarded to PHY */
+	uint64_t corrections;   /* correctionField updates */
+} stats;
+
+static void
+signal_handler(int signum)
+{
+	if (signum == SIGINT || signum == SIGTERM) {
+		LOG_INFO("Signal %d received, shutting down...", signum);
+		force_quit = true;
+	}
+}
+
+/* Helpers */
+
+/* Read monotonic clock in nanoseconds (for residence time). */
+static inline uint64_t
+sw_timestamp_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (uint64_t)ts.tv_sec * NSEC_PER_SEC + (uint64_t)ts.tv_nsec;
+}
+
+/* Port Init */
+
+static int
+port_init(uint16_t port, struct rte_mempool *mp)
+{
+	struct rte_eth_conf port_conf;
+	struct rte_eth_dev_info dev_info;
+	uint16_t nb_rxd = RX_RING_SIZE;
+	uint16_t nb_txd = TX_RING_SIZE;
+	int ret;
+
+	memset(&port_conf, 0, sizeof(port_conf));
+
+	ret = rte_eth_dev_info_get(port, &dev_info);
+	if (ret != 0) {
+		LOG_ERR("rte_eth_dev_info_get(port %u) failed: %d", port, ret);
+		return ret;
+	}
+
+	if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+		port_conf.txmode.offloads |=
+			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+
+	ret = rte_eth_dev_configure(port, 1, 1, &port_conf);
+	if (ret != 0)
+		return ret;
+
+	ret = rte_eth_dev_adjust_nb_rx_tx_desc(port, &nb_rxd, &nb_txd);
+	if (ret != 0)
+		return ret;
+
+	ret = rte_eth_rx_queue_setup(port, 0, nb_rxd,
+			rte_eth_dev_socket_id(port), NULL, mp);
+	if (ret < 0)
+		return ret;
+
+	ret = rte_eth_tx_queue_setup(port, 0, nb_txd,
+			rte_eth_dev_socket_id(port), NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = rte_eth_dev_start(port);
+	if (ret < 0)
+		return ret;
+
+	ret = rte_eth_promiscuous_enable(port);
+	if (ret != 0) {
+		LOG_ERR("Failed to enable promiscuous on port %u: %s",
+			port, rte_strerror(-ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Relay one direction */
+
+/*
+ * Forward packets from src_port to dst_port.
+ * For PTP event messages, record SW timestamps around the
+ * relay path and add the residence time to the correctionField.
+ *
+ * This implements a Transparent Clock (IEEE 1588-2019 §10.2):
+ *   correctionField += (t_egress − t_ingress)
+ *
+ * Note: a single rx_ts / tx_ts pair is used for the entire burst.
+ * At typical PTP rates (logSyncInterval >= -4, i.e. <= 16 pkt/s)
+ * bursts contain at most one packet, so this is exact.  At higher
+ * rates, early packets in a burst are slightly under-corrected and
+ * late ones over-corrected by up to one poll-loop iteration.
+ */
+static void
+relay_burst(uint16_t src_port, uint16_t dst_port,
+	    uint64_t *rx_cnt, uint64_t *rx_ptp_cnt,
+	    uint64_t *tx_cnt, uint64_t *corr_cnt)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	struct rte_ptp_hdr *ptp_hdrs[BURST_SIZE];
+	uint64_t rx_ts;
+	uint16_t nb_rx, nb_tx, i;
+
+	nb_rx = rte_eth_rx_burst(src_port, 0, bufs, BURST_SIZE);
+	if (nb_rx == 0)
+		return;
+
+	/* Record a single RX software timestamp for the whole burst.
+	 * All packets in one burst arrived at essentially the same instant
+	 * from rte_eth_rx_burst()'s perspective.
+	 */
+	rx_ts = sw_timestamp_ns();
+
+	*rx_cnt += nb_rx;
+
+	/*
+	 * Pass 1: Parse each packet once and remember PTP event headers.
+	 * This avoids taking the TX timestamp too early — we want it as
+	 * close to the actual rte_eth_tx_burst() call as possible.
+	 */
+	memset(ptp_hdrs, 0, sizeof(ptp_hdrs[0]) * nb_rx);
+	for (i = 0; i < nb_rx; i++) {
+		struct rte_ptp_hdr *hdr = ptp_hdr_find(bufs[i]);
+
+		if (hdr == NULL)
+			continue;
+
+		(*rx_ptp_cnt)++;
+
+		/* Only event messages carry timestamps that need correction */
+		if (!rte_ptp_is_event(rte_ptp_msg_type(hdr)))
+			continue;
+
+		ptp_hdrs[i] = hdr;
+	}
+
+	/*
+	 * Pass 2: Take a single TX timestamp right before transmission.
+	 * This minimises the gap between the measured tx_ts and the
+	 * actual kernel write inside rte_eth_tx_burst(), giving the
+	 * most accurate residence time we can achieve with SW timestamps.
+	 *
+	 * residence_time = tx_ts − rx_ts
+	 *
+	 * Remaining untracked delays:
+	 *   - Pre-RX:  NIC DMA → rx_burst return  (~1-5 µs, unavoidable)
+	 *   - Post-TX:  tx_ts → kernel TAP write   (~1-2 µs)
+	 * Both are symmetric for Sync and Delay_Req so they largely
+	 * cancel in the ptp4l offset calculation.
+	 */
+	uint64_t tx_ts = sw_timestamp_ns();
+	int64_t residence_ns = (int64_t)(tx_ts - rx_ts);
+
+	for (i = 0; i < nb_rx; i++) {
+		if (ptp_hdrs[i] == NULL)
+			continue;
+		rte_ptp_add_correction(ptp_hdrs[i], residence_ns);
+		(*corr_cnt)++;
+	}
+
+	/* Forward the burst */
+	nb_tx = rte_eth_tx_burst(dst_port, 0, bufs, nb_rx);
+	*tx_cnt += nb_tx;
+
+	/* Free any unsent packets */
+	for (i = nb_tx; i < nb_rx; i++)
+		rte_pktmbuf_free(bufs[i]);
+}
+
+/* Print statistics */
+
+static void
+print_stats(void)
+{
+	LOG_INFO("=== Statistics ===");
+	LOG_INFO("  PHY RX total:   %"PRIu64, stats.phy_rx);
+	LOG_INFO("  PHY RX PTP:     %"PRIu64, stats.phy_rx_ptp);
+	LOG_INFO("  TAP TX:         %"PRIu64, stats.tap_tx);
+	LOG_INFO("  TAP RX total:   %"PRIu64, stats.tap_rx);
+	LOG_INFO("  TAP RX PTP:     %"PRIu64, stats.tap_rx_ptp);
+	LOG_INFO("  PHY TX:         %"PRIu64, stats.phy_tx);
+	LOG_INFO("  Corrections:    %"PRIu64, stats.corrections);
+}
+
+/* Main relay loop */
+
+static int
+relay_loop(__rte_unused void *arg)
+{
+	uint64_t last_stats = rte_rdtsc();
+	uint64_t stats_tsc = rte_get_tsc_hz() * stats_interval;
+
+	LOG_INFO("Relay loop started on lcore %u", rte_lcore_id());
+	LOG_INFO("  PHY port %u  <-->  TAP port %u", phy_port, tap_port);
+	LOG_INFO("  Correction field updates: enabled for event messages");
+
+	while (!force_quit) {
+		/* PHY → TAP */
+		relay_burst(phy_port, tap_port,
+			    &stats.phy_rx, &stats.phy_rx_ptp,
+			    &stats.tap_tx, &stats.corrections);
+
+		/* TAP → PHY */
+		relay_burst(tap_port, phy_port,
+			    &stats.tap_rx, &stats.tap_rx_ptp,
+			    &stats.phy_tx, &stats.corrections);
+
+		/* Periodic stats */
+		if (rte_rdtsc() - last_stats > stats_tsc) {
+			print_stats();
+			last_stats = rte_rdtsc();
+		}
+	}
+
+	print_stats();
+	return 0;
+}
+
+/* Argument parsing */
+
+static void
+usage(const char *prog)
+{
+	fprintf(stderr,
+		"Usage: %s [EAL options] -- [options]\n"
+		"  -p PORT   Physical NIC port ID (default: 0)\n"
+		"  -t PORT   TAP port ID (default: 1)\n"
+		"  -T SECS   Stats interval in seconds (default: 10)\n"
+		"\n"
+		"Example:\n"
+		"  %s -l 0-1 --vdev=net_tap0,iface=dtap0 -- -p 0 -t 1\n"
+		"\n"
+		"Then run ptp4l with software timestamps:\n"
+		"  ptp4l -i dtap0 -m -s -S\n",
+		prog, prog);
+}
+
+static int
+parse_args(int argc, char **argv)
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "p:t:T:h")) != -1) {
+		switch (opt) {
+		case 'p':
+			phy_port = (uint16_t)atoi(optarg);
+			break;
+		case 't':
+			tap_port = (uint16_t)atoi(optarg);
+			break;
+		case 'T':
+			stats_interval = (unsigned int)atoi(optarg);
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* Main */
+
+int
+main(int argc, char **argv)
+{
+	struct rte_mempool *mp;
+	uint16_t nb_ports;
+	int ret;
+
+	/* EAL init */
+	ret = rte_eal_init(argc, argv);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "EAL init failed\n");
+	argc -= ret;
+	argv += ret;
+
+	/* App args */
+	ret = parse_args(argc, argv);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "Invalid arguments\n");
+
+	signal(SIGINT, signal_handler);
+	signal(SIGTERM, signal_handler);
+
+	nb_ports = rte_eth_dev_count_avail();
+	if (nb_ports < 2)
+		rte_exit(EXIT_FAILURE,
+			 "Need at least 2 ports (PHY + TAP).\n"
+			 "Use --vdev=net_tap0,iface=dtap0\n");
+
+	if (!rte_eth_dev_is_valid_port(phy_port))
+		rte_exit(EXIT_FAILURE, "Invalid PHY port %u\n", phy_port);
+	if (!rte_eth_dev_is_valid_port(tap_port))
+		rte_exit(EXIT_FAILURE, "Invalid TAP port %u\n", tap_port);
+
+	mp = rte_pktmbuf_pool_create("MBUF_POOL", NUM_MBUFS * nb_ports,
+				     MBUF_CACHE, 0,
+				     RTE_MBUF_DEFAULT_BUF_SIZE,
+				     rte_socket_id());
+	if (mp == NULL)
+		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
+
+	LOG_INFO("Initializing PHY port %u...", phy_port);
+	ret = port_init(phy_port, mp);
+	if (ret != 0)
+		rte_exit(EXIT_FAILURE, "Cannot init PHY port %u (%d)\n",
+			 phy_port, ret);
+
+	LOG_INFO("Initializing TAP port %u...", tap_port);
+	ret = port_init(tap_port, mp);
+	if (ret != 0)
+		rte_exit(EXIT_FAILURE, "Cannot init TAP port %u (%d)\n",
+			 tap_port, ret);
+
+	LOG_INFO("PTP Software Relay ready");
+	LOG_INFO("  PHY port:     %u", phy_port);
+	LOG_INFO("  TAP port:     %u", tap_port);
+	LOG_INFO("  Stats every:  %u seconds", stats_interval);
+	LOG_INFO("  Correction:   Transparent Clock (SW timestamps)");
+	LOG_INFO("");
+	LOG_INFO("Run ptp4l:  ptp4l -i dtap0 -m -s -S");
+
+	/* Run relay on main lcore */
+	relay_loop(NULL);
+
+	/* Cleanup */
+	LOG_INFO("Stopping ports...");
+	rte_eth_dev_stop(phy_port);
+	rte_eth_dev_stop(tap_port);
+	rte_eth_dev_close(phy_port);
+	rte_eth_dev_close(tap_port);
+	rte_eal_cleanup();
+
+	return 0;
+}
-- 
2.53.0


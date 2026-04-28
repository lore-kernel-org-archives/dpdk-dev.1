Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15AFF886D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 19:35:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D311D40670;
	Mon, 27 Apr 2026 21:35:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 978744066A
 for <dev@dpdk.org>; Mon, 27 Apr 2026 21:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777318538; x=1808854538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tdvcu7VFGC2eOdHRguGDpz2oAZ9YQUBkRE3mpY/Ik9s=;
 b=CRe4AEHkNjX1KJIg/tc236EgF9jVWsp264CznGWu/yjLa0fodF0hM4DM
 YFkI0DVyavqm36E1St2RACsjYhSYR6a9H6uGnC+KVjeXKmpWYLn3BaN4G
 sarsWJ593rPtJ9tRUv5go0Lxj1mia9NK3CXO0xDoXwex4hv2svlQDvArb
 jFVGmUJV8kEddxSjD1Lfq0KRnQLvRFPPi+MFKu6ZEBjftUHo5vD882ks8
 /+qye8xC+vg5ONoeGLgQFdW7dXsiSRMiIw1LPQfIjd1Z18ukPWd8cxUyj
 kYf6ulGH3Bht4Ew6jVHQENjnCnxb53GmwwrPjJqQdPUvVNPy2FhKwXCIg Q==;
X-CSE-ConnectionGUID: 1D73gjgPRFaMzudvmwNwjw==
X-CSE-MsgGUID: diD2w8kLQIytfCziysxvbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="81826672"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="81826672"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 12:35:37 -0700
X-CSE-ConnectionGUID: wEoVmQFCQTazE9yDpQsUtQ==
X-CSE-MsgGUID: YHz0mgkpRAue/meJY72kmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="227210669"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa009.fm.intel.com with ESMTP; 27 Apr 2026 12:35:35 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 rajesh3.kumar@intel.com
Subject: [RFC v1 3/4] examples/ptp_tap_relay_sw: add software PTP relay example
Date: Tue, 28 Apr 2026 06:31:05 +0530
Message-ID: <20260428010117.692626-4-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428010117.692626-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
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

Add a minimal PTP Transparent Clock relay that bridges PTP packets
between a DPDK-bound physical NIC and a kernel TAP interface using
software timestamps only.

The relay uses the rte_ptp library for packet classification and
correctionField manipulation. For each PTP event message, it records
software timestamps (CLOCK_MONOTONIC_RAW) at ingress and egress,
then adds the residence time to the correctionField per IEEE 1588-2019
section 10.2.

A two-pass design is used: first all packets are classified and PTP
header pointers saved, then a single TX timestamp is taken immediately
before applying corrections and calling rte_eth_tx_burst(). This
minimises the gap between the measured timestamp and actual wire
egress.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 MAINTAINERS                                  |   2 +
 examples/meson.build                         |   1 +
 examples/ptp_tap_relay_sw/Makefile           |  41 ++
 examples/ptp_tap_relay_sw/meson.build        |  14 +
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c | 424 +++++++++++++++++++
 5 files changed, 482 insertions(+)
 create mode 100644 examples/ptp_tap_relay_sw/Makefile
 create mode 100644 examples/ptp_tap_relay_sw/meson.build
 create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f2b47acfc3..665e08dc90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1669,6 +1669,8 @@ PTP - EXPERIMENTAL
 M: Rajesh Kumar <rajesh3.kumar@intel.com>
 F: lib/ptp/
 F: doc/guides/prog_guide/ptp_lib.rst
+F: examples/ptp_tap_relay_sw/
+F: doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
 
 PDCP - EXPERIMENTAL
 M: Anoob Joseph <anoobj@marvell.com>
diff --git a/examples/meson.build b/examples/meson.build
index 25d9c88457..ab82cf5fbd 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -43,6 +43,7 @@ all_examples = [
         'packet_ordering',
         'pipeline',
         'ptpclient',
+        'ptp_tap_relay_sw',
         'qos_meter',
         'qos_sched',
         'rxtx_callbacks',
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
index 0000000000..56abad02ed
--- /dev/null
+++ b/examples/ptp_tap_relay_sw/meson.build
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+# meson file, for building this example as part of a main DPDK build.
+#
+# To build this example as a standalone application with an already-installed
+# DPDK instance, use 'make'
+
+allow_experimental_apis = true
+sources = files(
+        'ptp_tap_relay_sw.c',
+)
+deps += ['net', 'ptp']
+cflags += no_shadow_cflag
diff --git a/examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c b/examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
new file mode 100644
index 0000000000..9db85bb382
--- /dev/null
+++ b/examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
@@ -0,0 +1,424 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+/*
+ * PTP Software Relay — lib/ptp usage example
+ *
+ * A minimal PTP relay between a DPDK-bound physical NIC and a kernel
+ * TAP interface using software timestamps only.  No patched TUN driver
+ * or ptp_proxy kernel module is required.
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
+ *   PTP Master (remote)  ──L2──  Physical NIC (DPDK)
+ *                                      │
+ *                                PTP SW Relay  ← correctionField update
+ *                                      │
+ *                                TAP (kernel) ── ptp4l -S (slave)
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
+#include <stdio.h>
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
+#include <rte_ptp.h>
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
+	clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
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
+	if (ret != 0)
+		LOG_ERR("Failed to enable promiscuous on port %u", port);
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
+ */
+static void
+relay_burst(uint16_t src_port, uint16_t dst_port,
+	    uint64_t *rx_cnt, uint64_t *rx_ptp_cnt,
+	    uint64_t *tx_cnt)
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
+	 * Pass 1: Classify packets and remember PTP event header pointers.
+	 * This avoids taking the TX timestamp too early — we want it as
+	 * close to the actual rte_eth_tx_burst() call as possible.
+	 */
+	memset(ptp_hdrs, 0, sizeof(ptp_hdrs[0]) * nb_rx);
+	for (i = 0; i < nb_rx; i++) {
+		int ptp_type = rte_ptp_classify(bufs[i]);
+
+		if (ptp_type == RTE_PTP_MSGTYPE_INVALID)
+			continue;
+
+		(*rx_ptp_cnt)++;
+
+		/* Only event messages carry timestamps that need correction */
+		if (!rte_ptp_is_event((uint8_t)ptp_type))
+			continue;
+
+		ptp_hdrs[i] = rte_ptp_hdr_get(bufs[i]);
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
+		stats.corrections++;
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
+			    &stats.tap_tx);
+
+		/* TAP → PHY */
+		relay_burst(tap_port, phy_port,
+			    &stats.tap_rx, &stats.tap_rx_ptp,
+			    &stats.phy_tx);
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
2.52.0


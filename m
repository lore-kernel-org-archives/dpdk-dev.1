Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DA8CE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:48:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D53040B9D;
	Tue,  6 Jan 2026 17:48:24 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id E2E1C40B9D
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:48:22 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso7232815e9.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767718102;
 x=1768322902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k468DKpCVg89ls4p+khg8qKhrxkbj47SW6uVz+3i7Lo=;
 b=20gT1dupdLayFTYFSptidS7d9W/NsUT/gsPLfypSKmpdd6BOCOf/eSpgOsFnUBFipX
 esx7kf8kFhazmlc1e1e3DJPcQPeqNK3zO9u9x/SAkREDMMF6TcEhUKrJrcf1zATlsmgl
 n/EGhWXegmxBartcfh6Ch+4d2mzeEdjGlO63DTYxZsqk86lwSgfjcgeCIFQQdwM8iY+E
 tOKk/AZlze1VZM/Ac4KiuVbNrdewUMHvdN3SjPk6AoQdEq4TJgo5QSbsXzjUNwCEda5G
 6uodLmFp4V6/VpyrM2YTTOcBKKAILkbA9F8e2/9TYSkqKjmTnCTyf2g3HNSPBpMgYC9B
 HS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767718102; x=1768322902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k468DKpCVg89ls4p+khg8qKhrxkbj47SW6uVz+3i7Lo=;
 b=aTyCj0DhNZfvNzJHNqtutdQooP1ReniCjaPGc+v7/H/oLV6lz8EYHCAvk/j5M19a5K
 kt5nxfgz6Ck7Ptt2b9IdBcpMJ+Yn0kc1Ws0nlINJCg+ZchDm+iX1FVhhNSXvqnsgyyrB
 1d9z9VzmEqr/73gRAthJlh0vAsUmJ/NTptPP5hsqR6j5zP3B4OFCSr0J4NNwimQ7cwb/
 YH1pUJxCanV7/r+xC4D9uaQx8msVhiZdFGpribvAjLDG0JJXxLm/YJDiIxqQ4bxzGGZW
 +owbjj9dqKqMaRJgBCK0VCmCTc/hNF8Th34jDRN9I9AN4jpj+07mTYs+E9S/c9X0778g
 fqYA==
X-Gm-Message-State: AOJu0YykSTDEiOGo5Bpp6Siq7VCILO6q2VEbFqxOQjzcPLWGCNdoNXe7
 eSGjjeHhrNOyKFZ4VYGREQ1OJUhCn869AM4MkCQdZ7vNw7MF9r96+tJUqoHmpxgsn8dopkI5zsj
 DfBe+HqY=
X-Gm-Gg: AY/fxX7U6pFBi9NfxWU3yt5kY2NO8mnsyDF6Fc8Pe92SUSx+20hAiSacuNeAlavU9ey
 AJo9bR9ySGOPSeIlJ5hXoUoSyU79XU/uGhtaufgNmtZlU05V1PFIIs8zGtv6PzzFKnwEiDN8Ltm
 vocLk4woiJMIeLb4l4Nz3SumiXH7TliRIoqyRxg/59+1tjnnvSk4uibM+Z4G6RpNYxV2vnkw/d/
 8CDqY5Cya85DBD/mxMTe/NTGrxJI49Uc3pXMIsNqONBdOdzoOzIhiBWnAO+iPB0gSmBoFziYq1V
 vHk/dIbrqE2Q5mPn8PqXLlCbrs4hsNi9HZrTUX1PTPjzZPqsIIdMAe+L1y3WsaUHlhBkc/mfyDO
 uxUtGEvPpzfHF+JBtp8nfTAgigAbDiev/wnJwcYiXLaaddXJxpQyOdGzgv+dLpxSEoASsUcGRxf
 1JiMzb9j1cFesTcmx7P5/pFcLHba8qtWAEVdk3goUOfohU1NoyOg==
X-Google-Smtp-Source: AGHT+IHZVVrpFjTze1tdQ0JzBByAB7Nkp8XwcxBo9wKwmWEJcw2LQCWUlRpm2dwQU10LL5EUext20w==
X-Received: by 2002:a05:600c:8b68:b0:479:3a88:de60 with SMTP id
 5b1f17b1804b1-47d7f0a932cmr32215655e9.37.1767718102367; 
 Tue, 06 Jan 2026 08:48:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm5197001f8f.19.2026.01.06.08.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 08:48:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/2] test: add a test for null PMD
Date: Tue,  6 Jan 2026 08:47:14 -0800
Message-ID: <20260106164815.158430-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106164815.158430-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260106164815.158430-1-stephen@networkplumber.org>
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

Add a test for null PMD.
This test was generated with Claude AI based off of existing
test_pmd_ring.c with some cleanup afterwards.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build     |   1 +
 app/test/test_pmd_null.c | 802 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 803 insertions(+)
 create mode 100644 app/test/test_pmd_null.c

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..a45991ec34 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -141,6 +141,7 @@ source_file_deps = {
     'test_per_lcore.c': [],
     'test_pflock.c': [],
     'test_pie.c': ['sched'],
+    'test_pmd_null.c': ['net_ring', 'ethdev', 'bus_vdev'],
     'test_pmd_perf.c': ['ethdev', 'net'] + packet_burst_generator_deps,
     'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
     'test_pmd_ring_perf.c': ['ethdev', 'net_ring', 'bus_vdev'],
diff --git a/app/test/test_pmd_null.c b/app/test/test_pmd_null.c
new file mode 100644
index 0000000000..c6a8bba701
--- /dev/null
+++ b/app/test/test_pmd_null.c
@@ -0,0 +1,802 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include <rte_bus_vdev.h>
+#include <rte_cycles.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_lcore.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_random.h>
+
+#include "test.h"
+
+#define NUM_MBUFS 256
+#define MBUF_CACHE_SIZE 32
+#define BURST_SIZE 32
+#define RING_SIZE 512
+#define PACKET_SIZE 64
+
+/* Test device names */
+#define NULL_DEV_NAME "net_null_test"
+
+static struct rte_mempool *mp;
+static uint16_t port_id = RTE_MAX_ETHPORTS;
+
+static int
+create_null_port(const char *name, const char *args, uint16_t *out_port_id)
+{
+	int ret;
+
+	ret = rte_vdev_init(name, args);
+	if (ret != 0) {
+		printf("Failed to create null device '%s': %d\n", name, ret);
+		return ret;
+	}
+
+	ret = rte_eth_dev_get_port_by_name(name, out_port_id);
+	if (ret != 0) {
+		printf("Failed to get port id for '%s': %d\n", name, ret);
+		rte_vdev_uninit(name);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+configure_null_port(uint16_t pid)
+{
+	struct rte_eth_conf port_conf = {0};
+	struct rte_eth_dev_info dev_info;
+	int ret;
+
+	ret = rte_eth_dev_info_get(pid, &dev_info);
+	if (ret != 0) {
+		printf("Failed to get device info for port %u: %d\n", pid, ret);
+		return ret;
+	}
+
+	ret = rte_eth_dev_configure(pid, 1, 1, &port_conf);
+	if (ret != 0) {
+		printf("Failed to configure port %u: %d\n", pid, ret);
+		return ret;
+	}
+
+	ret = rte_eth_rx_queue_setup(pid, 0, RING_SIZE,
+				     rte_eth_dev_socket_id(pid),
+				     NULL, mp);
+	if (ret != 0) {
+		printf("Failed to setup RX queue for port %u: %d\n", pid, ret);
+		return ret;
+	}
+
+	ret = rte_eth_tx_queue_setup(pid, 0, RING_SIZE,
+				     rte_eth_dev_socket_id(pid),
+				     NULL);
+	if (ret != 0) {
+		printf("Failed to setup TX queue for port %u: %d\n", pid, ret);
+		return ret;
+	}
+
+	ret = rte_eth_dev_start(pid);
+	if (ret != 0) {
+		printf("Failed to start port %u: %d\n", pid, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+test_null_setup(void)
+{
+	/* Create mempool for mbufs */
+	mp = rte_pktmbuf_pool_create("null_test_pool", NUM_MBUFS,
+				     MBUF_CACHE_SIZE, 0,
+				     RTE_MBUF_DEFAULT_BUF_SIZE,
+				     rte_socket_id());
+	if (mp == NULL) {
+		printf("Failed to create mempool\n");
+		return -1;
+	}
+
+	/* Create and configure null port */
+	if (create_null_port(NULL_DEV_NAME, NULL, &port_id) != 0) {
+		printf("Failed to create null port\n");
+		return -1;
+	}
+
+	if (configure_null_port(port_id) != 0) {
+		printf("Failed to configure null port\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void
+test_null_teardown(void)
+{
+	/* Stop and close test port */
+	rte_eth_dev_stop(port_id);
+	rte_eth_dev_close(port_id);
+	rte_vdev_uninit(NULL_DEV_NAME);
+	port_id = RTE_MAX_ETHPORTS;
+
+	rte_mempool_free(mp);
+	mp = NULL;
+}
+
+/*
+ * Test: Basic RX - should return empty packets
+ */
+static int
+test_null_rx_basic(void)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t nb_rx;
+	unsigned int i;
+
+	/* RX should return requested number of empty packets */
+	nb_rx = rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
+	TEST_ASSERT(nb_rx == BURST_SIZE,
+		    "Expected %u packets, got %u", BURST_SIZE, nb_rx);
+
+	/* Verify packets have expected properties */
+	for (i = 0; i < nb_rx; i++) {
+		TEST_ASSERT(bufs[i] != NULL, "Received NULL mbuf");
+		TEST_ASSERT(bufs[i]->port == port_id,
+			    "Unexpected port id in mbuf: %u", bufs[i]->port);
+
+		/* Default packet size is 64 bytes */
+		TEST_ASSERT(bufs[i]->pkt_len == PACKET_SIZE,
+			    "Unexpected pkt_len: %u", bufs[i]->pkt_len);
+		TEST_ASSERT(bufs[i]->data_len == PACKET_SIZE,
+			    "Unexpected data_len: %u", bufs[i]->data_len);
+	}
+
+	/* Free received mbufs */
+	rte_pktmbuf_free_bulk(bufs, nb_rx);
+
+	return TEST_SUCCESS;
+}
+
+/* Create random valid ethernet packets */
+static int
+test_mbuf_setup_burst(struct rte_mbuf **bufs, unsigned int burst_size)
+{
+	unsigned int i;
+
+	if (rte_pktmbuf_alloc_bulk(mp, bufs, burst_size) != 0)
+		return -1;
+
+	for (i = 0; i < burst_size; i++) {
+		struct rte_mbuf *m = bufs[i];
+		uint16_t len;
+
+		/* Choose random length between ether min and available space */
+		len = rte_rand_max(rte_pktmbuf_tailroom(m) - RTE_ETHER_MIN_LEN)
+			+ RTE_ETHER_MIN_LEN;
+		m->data_len = len;
+		m->buf_len = len;
+	}
+	return 0;
+}
+
+/*
+ * Test: Basic TX - should free all packets
+ */
+static int
+test_null_tx_basic(void)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t nb_tx;
+	unsigned int pool_count_before, pool_count_after;
+
+	/* Allocate mbufs for TX */
+	TEST_ASSERT(test_mbuf_setup_burst(bufs, BURST_SIZE) == 0,
+		    "Could not allocate mbufs");
+
+	pool_count_before = rte_mempool_avail_count(mp);
+
+	/* TX should accept and free all packets */
+	nb_tx = rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
+	TEST_ASSERT(nb_tx == BURST_SIZE,
+		    "Expected to TX %u packets, but sent %u", BURST_SIZE, nb_tx);
+
+	pool_count_after = rte_mempool_avail_count(mp);
+
+	/* Verify mbufs were freed - pool should have same count */
+	TEST_ASSERT(pool_count_after >= pool_count_before,
+		    "Mbufs not freed: before=%u, after=%u",
+		    pool_count_before, pool_count_after);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Statistics verification
+ */
+static int
+test_null_stats(void)
+{
+	struct rte_eth_stats stats;
+	struct rte_mbuf *rx_bufs[BURST_SIZE];
+	struct rte_mbuf *tx_bufs[BURST_SIZE];
+	uint16_t nb_rx, nb_tx;
+	int ret;
+
+	/* Reset stats */
+	ret = rte_eth_stats_reset(port_id);
+	TEST_ASSERT(ret == 0, "Failed to reset stats");
+
+	/* Get initial stats */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats");
+	TEST_ASSERT(stats.ipackets == 0, "Initial ipackets not zero");
+	TEST_ASSERT(stats.opackets == 0, "Initial opackets not zero");
+
+	/* Perform RX */
+	nb_rx = rte_eth_rx_burst(port_id, 0, rx_bufs, BURST_SIZE);
+	TEST_ASSERT(nb_rx == BURST_SIZE, "RX burst failed");
+
+	/* Allocate and perform TX */
+	TEST_ASSERT(test_mbuf_setup_burst(tx_bufs, BURST_SIZE) == 0,
+		    "Could not allocate tx mbufs");
+
+	nb_tx = rte_eth_tx_burst(port_id, 0, tx_bufs, BURST_SIZE);
+	TEST_ASSERT(nb_tx == BURST_SIZE, "TX burst failed");
+
+	/* Get updated stats */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats after RX/TX");
+
+	/* Verify stats */
+	TEST_ASSERT(stats.ipackets == BURST_SIZE,
+		    "Expected ipackets=%u, got %"PRIu64,
+		    BURST_SIZE, stats.ipackets);
+	TEST_ASSERT(stats.opackets == BURST_SIZE,
+		    "Expected opackets=%u, got %"PRIu64,
+		    BURST_SIZE, stats.opackets);
+
+	rte_pktmbuf_free_bulk(rx_bufs, nb_rx);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Custom packet size
+ */
+static int
+test_null_custom_size(void)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t custom_port;
+	uint16_t nb_rx;
+	unsigned int i;
+	const unsigned int custom_size = 256;
+	int ret;
+
+	/* Create null device with custom size */
+	ret = create_null_port("net_null_size_test", "size=256", &custom_port);
+	TEST_ASSERT(ret == 0, "Failed to create null port with custom size");
+
+	ret = configure_null_port(custom_port);
+	TEST_ASSERT(ret == 0, "Failed to configure null port");
+
+	/* RX should return packets with custom size */
+	nb_rx = rte_eth_rx_burst(custom_port, 0, bufs, BURST_SIZE);
+	TEST_ASSERT(nb_rx == BURST_SIZE, "RX burst failed");
+
+	/* Verify custom packet size */
+	for (i = 0; i < nb_rx; i++) {
+		TEST_ASSERT(bufs[i]->pkt_len == custom_size,
+			    "Expected pkt_len=%u, got %u",
+			    custom_size, bufs[i]->pkt_len);
+		TEST_ASSERT(bufs[i]->data_len == custom_size,
+			    "Expected data_len=%u, got %u",
+			    custom_size, bufs[i]->data_len);
+	}
+	rte_pktmbuf_free_bulk(bufs, nb_rx);
+
+	/* Cleanup custom port */
+	rte_eth_dev_stop(custom_port);
+	rte_eth_dev_close(custom_port);
+	rte_vdev_uninit("net_null_size_test");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Copy mode
+ */
+static int
+test_null_copy_mode(void)
+{
+	struct rte_mbuf *rx_bufs[BURST_SIZE];
+	uint16_t copy_port, nb_rx;
+	int ret;
+
+	/* Create null device with copy enabled */
+	ret = create_null_port("net_null_copy_test", "copy=1", &copy_port);
+	TEST_ASSERT(ret == 0, "Failed to create null port with copy mode");
+
+	ret = configure_null_port(copy_port);
+	TEST_ASSERT(ret == 0, "Failed to configure null port");
+
+	/* RX in copy mode should work */
+	nb_rx = rte_eth_rx_burst(copy_port, 0, rx_bufs, BURST_SIZE);
+	TEST_ASSERT(nb_rx == BURST_SIZE, "RX burst in copy mode failed");
+
+	/* Free RX mbufs */
+	rte_pktmbuf_free_bulk(rx_bufs, nb_rx);
+
+	/* Cleanup */
+	rte_eth_dev_stop(copy_port);
+	rte_eth_dev_close(copy_port);
+	rte_vdev_uninit("net_null_copy_test");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: No-RX mode
+ */
+static int
+test_null_no_rx_mode(void)
+{
+	struct rte_mbuf *rx_bufs[BURST_SIZE];
+	struct rte_mbuf *tx_bufs[BURST_SIZE];
+	uint16_t norx_port, nb_rx, nb_tx;
+	int ret;
+
+	/* Create null device with no-rx enabled */
+	ret = create_null_port("net_null_norx_test", "no-rx=1", &norx_port);
+	TEST_ASSERT(ret == 0, "Failed to create null port with no-rx mode");
+
+	ret = configure_null_port(norx_port);
+	TEST_ASSERT(ret == 0, "Failed to configure null port");
+
+	/* RX in no-rx mode should return 0 packets */
+	nb_rx = rte_eth_rx_burst(norx_port, 0, rx_bufs, BURST_SIZE);
+	TEST_ASSERT(nb_rx == 0,
+		    "Expected 0 packets in no-rx mode, got %u", nb_rx);
+
+	/* TX in no-rx mode should still work (frees packets) */
+	TEST_ASSERT(test_mbuf_setup_burst(tx_bufs, BURST_SIZE) == 0,
+		    "Could not allocate tx mbufs");
+
+	nb_tx = rte_eth_tx_burst(norx_port, 0, tx_bufs, BURST_SIZE);
+	TEST_ASSERT(nb_tx == BURST_SIZE, "TX burst in no-rx mode failed");
+
+	/* Cleanup */
+	rte_eth_dev_stop(norx_port);
+	rte_eth_dev_close(norx_port);
+	rte_vdev_uninit("net_null_norx_test");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Link status
+ */
+static int
+test_null_link_status(void)
+{
+	struct rte_eth_link link;
+	int ret;
+
+	ret = rte_eth_link_get_nowait(port_id, &link);
+	TEST_ASSERT(ret == 0, "Failed to get link status");
+
+	/* After start, link should be UP */
+	TEST_ASSERT(link.link_status == RTE_ETH_LINK_UP,
+		    "Expected link UP after start");
+	TEST_ASSERT(link.link_speed == RTE_ETH_SPEED_NUM_10G,
+		    "Expected 10G link speed");
+	TEST_ASSERT(link.link_duplex == RTE_ETH_LINK_FULL_DUPLEX,
+		    "Expected full duplex");
+
+	/* Stop the device */
+	ret = rte_eth_dev_stop(port_id);
+	TEST_ASSERT(ret == 0, "Failed to stop device");
+
+	ret = rte_eth_link_get_nowait(port_id, &link);
+	TEST_ASSERT(ret == 0, "Failed to get link status after stop");
+
+	/* After stop, link should be DOWN */
+	TEST_ASSERT(link.link_status == RTE_ETH_LINK_DOWN,
+		    "Expected link DOWN after stop");
+
+	/* Restart for subsequent tests */
+	ret = rte_eth_dev_start(port_id);
+	TEST_ASSERT(ret == 0, "Failed to restart device");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Device info
+ */
+static int
+test_null_dev_info(void)
+{
+	struct rte_eth_dev_info dev_info;
+	int ret;
+
+	ret = rte_eth_dev_info_get(port_id, &dev_info);
+	TEST_ASSERT(ret == 0, "Failed to get device info");
+
+	/* Verify expected device info values */
+	TEST_ASSERT(dev_info.max_mac_addrs == 1,
+		    "Expected max_mac_addrs=1, got %u", dev_info.max_mac_addrs);
+	TEST_ASSERT(dev_info.max_rx_pktlen == UINT32_MAX,
+		    "Unexpected max_rx_pktlen");
+	TEST_ASSERT(dev_info.min_rx_bufsize == 0,
+		    "Expected min_rx_bufsize=0, got %u", dev_info.min_rx_bufsize);
+
+	/* Check TX offload capabilities */
+	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MULTI_SEGS,
+		    "Expected MULTI_SEGS TX offload capability");
+	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE,
+		    "Expected MT_LOCKFREE TX offload capability");
+
+	/* Check RSS capabilities */
+	TEST_ASSERT(dev_info.reta_size > 0, "Expected non-zero reta_size");
+	TEST_ASSERT(dev_info.hash_key_size == 40,
+		    "Expected hash_key_size=40, got %u", dev_info.hash_key_size);
+	TEST_ASSERT(dev_info.flow_type_rss_offloads != 0,
+		    "Expected RSS offloads to be set");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Multiple RX/TX bursts
+ */
+static int
+test_null_multiple_bursts(void)
+{
+	struct rte_eth_stats stats;
+	uint16_t nb_rx, nb_tx;
+	unsigned int burst;
+	const unsigned int num_bursts = 10;
+	int ret;
+
+	/* Reset stats */
+	ret = rte_eth_stats_reset(port_id);
+	TEST_ASSERT(ret == 0, "Failed to reset stats");
+
+	/* Perform multiple RX bursts */
+	for (burst = 0; burst < num_bursts; burst++) {
+		struct rte_mbuf *bufs[BURST_SIZE];
+
+		nb_rx = rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
+		TEST_ASSERT(nb_rx == BURST_SIZE,
+			    "Burst %u: Expected %u packets, got %u",
+			    burst, BURST_SIZE, nb_rx);
+
+		rte_pktmbuf_free_bulk(bufs, nb_rx);
+	}
+
+	/* Perform multiple TX bursts */
+	for (burst = 0; burst < num_bursts; burst++) {
+		struct rte_mbuf *bufs[BURST_SIZE];
+
+		TEST_ASSERT(test_mbuf_setup_burst(bufs, BURST_SIZE) == 0,
+			    "Could not allocate tx mbufs");
+
+		nb_tx = rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
+		TEST_ASSERT(nb_tx == BURST_SIZE,
+			    "Burst %u: Expected to TX %u, sent %u",
+			    burst, BURST_SIZE, nb_tx);
+	}
+
+	/* Verify total stats */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats");
+
+	TEST_ASSERT(stats.ipackets == num_bursts * BURST_SIZE,
+		    "Expected ipackets=%u, got %"PRIu64,
+		    num_bursts * BURST_SIZE, stats.ipackets);
+	TEST_ASSERT(stats.opackets == num_bursts * BURST_SIZE,
+		    "Expected opackets=%u, got %"PRIu64,
+		    num_bursts * BURST_SIZE, stats.opackets);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: RSS configuration
+ * Note: RSS requires multi-queue configuration
+ */
+static int
+test_null_rss_config(void)
+{
+	struct rte_eth_dev_info dev_info;
+	struct rte_eth_rss_conf rss_conf;
+	struct rte_eth_conf port_conf = {0};
+	uint8_t rss_key[40];
+	uint16_t rss_port;
+	const uint16_t num_queues = 2;
+	uint16_t q;
+	int ret;
+
+	/* Create a new null device for RSS testing with multiple queues */
+	ret = create_null_port("net_null_rss_test", NULL, &rss_port);
+	TEST_ASSERT(ret == 0, "Failed to create null port for RSS test");
+
+	ret = rte_eth_dev_info_get(rss_port, &dev_info);
+	TEST_ASSERT(ret == 0, "Failed to get device info");
+
+	/* Configure with RSS enabled and multiple queues */
+	port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
+	port_conf.rx_adv_conf.rss_conf.rss_hf = dev_info.flow_type_rss_offloads;
+
+	ret = rte_eth_dev_configure(rss_port, num_queues, num_queues, &port_conf);
+	TEST_ASSERT(ret == 0, "Failed to configure RSS port");
+
+	for (q = 0; q < num_queues; q++) {
+		ret = rte_eth_rx_queue_setup(rss_port, q, RING_SIZE,
+					     rte_eth_dev_socket_id(rss_port),
+					     NULL, mp);
+		TEST_ASSERT(ret == 0, "Failed to setup RX queue %u", q);
+
+		ret = rte_eth_tx_queue_setup(rss_port, q, RING_SIZE,
+					     rte_eth_dev_socket_id(rss_port),
+					     NULL);
+		TEST_ASSERT(ret == 0, "Failed to setup TX queue %u", q);
+	}
+
+	ret = rte_eth_dev_start(rss_port);
+	TEST_ASSERT(ret == 0, "Failed to start RSS port");
+
+	/* Get current RSS config */
+	memset(&rss_conf, 0, sizeof(rss_conf));
+	rss_conf.rss_key = rss_key;
+	rss_conf.rss_key_len = sizeof(rss_key);
+
+	ret = rte_eth_dev_rss_hash_conf_get(rss_port, &rss_conf);
+	TEST_ASSERT(ret == 0, "Failed to get RSS hash config");
+
+	/* Update RSS config with new key */
+	memset(rss_key, 0x55, sizeof(rss_key));
+	rss_conf.rss_key = rss_key;
+	rss_conf.rss_key_len = sizeof(rss_key);
+	rss_conf.rss_hf = dev_info.flow_type_rss_offloads;
+
+	ret = rte_eth_dev_rss_hash_update(rss_port, &rss_conf);
+	TEST_ASSERT(ret == 0, "Failed to update RSS hash config");
+
+	/* Verify the update */
+	memset(rss_key, 0, sizeof(rss_key));
+	rss_conf.rss_key = rss_key;
+
+	ret = rte_eth_dev_rss_hash_conf_get(rss_port, &rss_conf);
+	TEST_ASSERT(ret == 0, "Failed to get RSS hash config after update");
+
+	/* Verify key was updated */
+	for (unsigned int i = 0; i < sizeof(rss_key); i++) {
+		TEST_ASSERT(rss_key[i] == 0x55,
+			    "RSS key not updated at byte %u", i);
+	}
+
+	/* Cleanup */
+	rte_eth_dev_stop(rss_port);
+	rte_eth_dev_close(rss_port);
+	rte_vdev_uninit("net_null_rss_test");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: RETA (Redirection Table) configuration
+ * Note: RETA requires multi-queue RSS configuration
+ */
+static int
+test_null_reta_config(void)
+{
+	struct rte_eth_dev_info dev_info;
+	struct rte_eth_rss_reta_entry64 reta_conf[RTE_ETH_RSS_RETA_SIZE_128 /
+						 RTE_ETH_RETA_GROUP_SIZE];
+	struct rte_eth_conf port_conf = {0};
+	uint16_t reta_port;
+	const uint16_t num_queues = 2;
+	unsigned int i, j, nreta;
+	uint16_t q;
+	int ret;
+
+	/* Create a new null device for RETA testing with multiple queues */
+	ret = create_null_port("net_null_reta_test", NULL, &reta_port);
+	TEST_ASSERT(ret == 0, "Failed to create null port for RETA test");
+
+	ret = rte_eth_dev_info_get(reta_port, &dev_info);
+	TEST_ASSERT(ret == 0, "Failed to get device info");
+
+	TEST_ASSERT(dev_info.reta_size > 0, "RETA size is zero");
+
+	/* Configure with RSS enabled and multiple queues */
+	port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
+	port_conf.rx_adv_conf.rss_conf.rss_hf = dev_info.flow_type_rss_offloads;
+
+	ret = rte_eth_dev_configure(reta_port, num_queues, num_queues, &port_conf);
+	TEST_ASSERT(ret == 0, "Failed to configure RETA port");
+
+	for (q = 0; q < num_queues; q++) {
+		ret = rte_eth_rx_queue_setup(reta_port, q, RING_SIZE,
+					     rte_eth_dev_socket_id(reta_port),
+					     NULL, mp);
+		TEST_ASSERT(ret == 0, "Failed to setup RX queue %u", q);
+
+		ret = rte_eth_tx_queue_setup(reta_port, q, RING_SIZE,
+					     rte_eth_dev_socket_id(reta_port),
+					     NULL);
+		TEST_ASSERT(ret == 0, "Failed to setup TX queue %u", q);
+	}
+
+	ret = rte_eth_dev_start(reta_port);
+	TEST_ASSERT(ret == 0, "Failed to start RETA port");
+
+	/* Initialize RETA config */
+	memset(reta_conf, 0, sizeof(reta_conf));
+	nreta = dev_info.reta_size / RTE_ETH_RETA_GROUP_SIZE;
+	for (i = 0; i < nreta; i++) {
+		reta_conf[i].mask = UINT64_MAX;
+		for (j = 0; j < RTE_ETH_RETA_GROUP_SIZE; j++)
+			reta_conf[i].reta[j] = j % num_queues;
+	}
+
+	/* Update RETA */
+	ret = rte_eth_dev_rss_reta_update(reta_port, reta_conf, dev_info.reta_size);
+	TEST_ASSERT(ret == 0, "Failed to update RETA");
+
+	/* Query RETA */
+	memset(reta_conf, 0, sizeof(reta_conf));
+	for (i = 0; i < nreta; i++)
+		reta_conf[i].mask = UINT64_MAX;
+
+	ret = rte_eth_dev_rss_reta_query(reta_port, reta_conf, dev_info.reta_size);
+	TEST_ASSERT(ret == 0, "Failed to query RETA");
+
+	/* Verify RETA values */
+	for (i = 0; i < nreta; i++) {
+		for (j = 0; j < RTE_ETH_RETA_GROUP_SIZE; j++) {
+			TEST_ASSERT(reta_conf[i].reta[j] == j % num_queues,
+				    "RETA mismatch at [%u][%u]", i, j);
+		}
+	}
+
+	/* Cleanup */
+	rte_eth_dev_stop(reta_port);
+	rte_eth_dev_close(reta_port);
+	rte_vdev_uninit("net_null_reta_test");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Stats reset
+ */
+static int
+test_null_stats_reset(void)
+{
+	struct rte_eth_stats stats;
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t nb_rx;
+	int ret;
+
+	/* Generate some traffic */
+	nb_rx = rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
+	TEST_ASSERT(nb_rx > 0, "Failed to receive packets");
+
+	rte_pktmbuf_free_bulk(bufs, nb_rx);
+
+	/* Verify stats are non-zero */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats");
+	TEST_ASSERT(stats.ipackets > 0, "Expected non-zero ipackets");
+
+	/* Reset stats */
+	ret = rte_eth_stats_reset(port_id);
+	TEST_ASSERT(ret == 0, "Failed to reset stats");
+
+	/* Verify stats are zero */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats after reset");
+	TEST_ASSERT(stats.ipackets == 0,
+		    "Expected ipackets=0 after reset, got %"PRIu64,
+		    stats.ipackets);
+	TEST_ASSERT(stats.opackets == 0,
+		    "Expected opackets=0 after reset, got %"PRIu64,
+		    stats.opackets);
+	TEST_ASSERT(stats.ibytes == 0,
+		    "Expected ibytes=0 after reset, got %"PRIu64,
+		    stats.ibytes);
+	TEST_ASSERT(stats.obytes == 0,
+		    "Expected obytes=0 after reset, got %"PRIu64,
+		    stats.obytes);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: MAC address operations
+ */
+static int
+test_null_mac_addr(void)
+{
+	struct rte_ether_addr mac_addr;
+	struct rte_ether_addr new_mac = {
+		.addr_bytes = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55}
+	};
+	int ret;
+
+	/* Get current MAC address */
+	ret = rte_eth_macaddr_get(port_id, &mac_addr);
+	TEST_ASSERT(ret == 0, "Failed to get MAC address");
+
+	/* Set new MAC address */
+	ret = rte_eth_dev_default_mac_addr_set(port_id, &new_mac);
+	TEST_ASSERT(ret == 0, "Failed to set MAC address");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Promiscuous and allmulticast modes
+ */
+static int
+test_null_promisc_allmulti(void)
+{
+	int ret;
+
+	/* Test promiscuous mode - null PMD starts with promiscuous enabled */
+	ret = rte_eth_promiscuous_get(port_id);
+	TEST_ASSERT(ret == 1, "Expected promiscuous mode enabled");
+
+	/* Test allmulticast mode - null PMD starts with allmulti enabled */
+	ret = rte_eth_allmulticast_get(port_id);
+	TEST_ASSERT(ret == 1, "Expected allmulticast mode enabled");
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite null_pmd_test_suite = {
+	.suite_name = "Null PMD Unit Test Suite",
+	.setup = test_null_setup,
+	.teardown = test_null_teardown,
+	.unit_test_cases = {
+		TEST_CASE(test_null_rx_basic),
+		TEST_CASE(test_null_tx_basic),
+		TEST_CASE(test_null_stats),
+		TEST_CASE(test_null_custom_size),
+		TEST_CASE(test_null_copy_mode),
+		TEST_CASE(test_null_no_rx_mode),
+		TEST_CASE(test_null_link_status),
+		TEST_CASE(test_null_dev_info),
+		TEST_CASE(test_null_multiple_bursts),
+		TEST_CASE(test_null_rss_config),
+		TEST_CASE(test_null_reta_config),
+		TEST_CASE(test_null_stats_reset),
+		TEST_CASE(test_null_mac_addr),
+		TEST_CASE(test_null_promisc_allmulti),
+
+		TEST_CASES_END() /**< NULL terminate unit test array */
+	}
+};
+
+static int
+test_pmd_null(void)
+{
+	return unit_test_suite_runner(&null_pmd_test_suite);
+}
+
+REGISTER_FAST_TEST(null_pmd_autotest, true, true, test_pmd_null);
-- 
2.51.0


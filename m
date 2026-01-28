Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A82D46BE2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:31:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0B5B4065B;
	Wed, 28 Jan 2026 18:31:47 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 9B25640655
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:31:46 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-480706554beso937455e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769621506;
 x=1770226306; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yg19fVGt6PTJKr81xR6B0JC/5N1lZMs2uDvINPYria4=;
 b=AFTkT5C9BJFFsenm1OyCNiCWnwGpEAUxxNHjPdzyhicGza1bixpWr7JEYU72yZQkaw
 Z9PrHEiVMibDMbgYOL5TMDfVUYmu3294KJZoUUsvKcgOVEe6Ah3PfwvDtmjJrCgnaJS5
 aRwU9yO59z8iDAGk0rmd8z8wehWiMy8G/Cq8A3/BGiryxhbO1SSNdx+SPHjdKQbyaKXQ
 yN7RcO8OSur0fJUMt7uZ7+pbI7/JjteJJRpB2ix560EcEX/CycCfV2Ka7mEijKjhgENM
 deVWXpRhMFS12SuxzBa0f7BAUFmDvQbQOJvXw+roiBVv81Yj2jtRt3aLkMhh3LsQSKT0
 Elig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621506; x=1770226306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yg19fVGt6PTJKr81xR6B0JC/5N1lZMs2uDvINPYria4=;
 b=ZUb+nyn1Uv9WWYympFLgrKsC1vd9FEML3kwDE/e0/9IymIYwxOFRH7AHeKA/TcNL7R
 7yh3O9m47FzDFbGpNpsBI/pYIyM10up8t/jNKSOj33DXOWjpz2AUZzFvM8o87mNEGt6U
 7NyfM1tn0j9v8sLqFDk+K65pE1ayfrZW4HYm1zGOKk8LgVUT/KvkV+uHNlusYnCYP8cz
 MwwQCRp+EXUqTwKrJ5MmSahuct56D61PttpxD6lFP7li+Cgr/mkCvwP1l7jPCFQ46HKj
 MFVe6LW2PJ40Mx7Qf0YjGQBXWh3Wl1LzN8u4KH0Q8iv/Ff6SuDx5O5iovNQZ+uif6rYW
 CUMA==
X-Gm-Message-State: AOJu0YwiUqfIkBTMpMuQ5mp2POsWnIDltbEIpCuwPOCZu9937uk8zmYx
 Trd1GeFvVWcLUYasMCkLugeO58fVxOMnnoEF0JdGOST7NErk1Jd6PUTLjMDxHXGcBCzHzRuDP1+
 mqtgx
X-Gm-Gg: AZuq6aLzBl9k1OPb2+5/Q5z6L0lFhXgeLrfJ17P+TZltvMIQGQRtQFHICQP1jeN3s02
 b4Y8sRAxzuMMFv9LvuDCXvCuGALsnmc6kXVf6u6KGuRN0Po+HBYVusd/Oenfq996EjDFTlwGSmC
 GIO+TzwDuVnky8KszcD0xrVlRMQ9QkM4JeJ2OrZhjusYOT6pYtFekSczYEoI+Y75lsfw1SReHK3
 suAvhXf8Se4KiDp1NGLUiZ/wQ8V6q+ot4nz9HaMZ0c/ChhWyIUJ6hogrYpNmpdFMlbvvjGye7Zk
 kPWxUZ54U+t3ymDCLhdL6nGhC2rIgViFKsjOM7GmnuxCmQf5JCuz9TKI5tpxgAZ0uTVOtm7Sdfy
 ViR/CVfF+Vni3oghDRkMlO0wG+Jp5cE9LGWleeurc0noXXd7D1/AlBsR3uB/dUlutKXio/2lZam
 OPTy/FcA2k8UbDbZWRHVmW6tPuk2Zv6e+bnVZmM83cYzm4ZOFBn4KFvw2l4Fbj
X-Received: by 2002:a05:600c:37cd:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-48069c73ca4mr73108445e9.32.1769621506045; 
 Wed, 28 Jan 2026 09:31:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm133732875e9.7.2026.01.28.09.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:31:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 2/4] test: add test for af_packet
Date: Wed, 28 Jan 2026 09:30:18 -0800
Message-ID: <20260128173138.151837-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128173138.151837-1-stephen@networkplumber.org>
References: <20260128173138.151837-1-stephen@networkplumber.org>
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

Add a test for AF_PACKET PMD.
This test was generated with Claude AI based off of existing
test_pmd_ring.c with some cleanup afterwards.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build          |   1 +
 app/test/test_pmd_af_packet.c | 875 ++++++++++++++++++++++++++++++++++
 2 files changed, 876 insertions(+)
 create mode 100644 app/test/test_pmd_af_packet.c

diff --git a/app/test/meson.build b/app/test/meson.build
index f4d04a6e42..9fb7067b4b 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -141,6 +141,7 @@ source_file_deps = {
     'test_per_lcore.c': [],
     'test_pflock.c': [],
     'test_pie.c': ['sched'],
+    'test_pmd_af_packet.c': ['net_af_packet', 'ethdev', 'bus_vdev'],
     'test_pmd_perf.c': ['ethdev', 'net'] + packet_burst_generator_deps,
     'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
     'test_pmd_ring_perf.c': ['ethdev', 'net_ring', 'bus_vdev'],
diff --git a/app/test/test_pmd_af_packet.c b/app/test/test_pmd_af_packet.c
new file mode 100644
index 0000000000..e6426adf0c
--- /dev/null
+++ b/app/test/test_pmd_af_packet.c
@@ -0,0 +1,875 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <linux/sockios.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#include <rte_bus_vdev.h>
+#include <rte_config.h>
+#include <rte_cycles.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_lcore.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+
+#include "test.h"
+
+#ifndef RTE_EXEC_ENV_LINUX
+static int
+test_pmd_af_packet(void)
+{
+	printf("af_packet only supported on Linux, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+#else
+
+#define NUM_MBUFS 512
+#define MBUF_CACHE_SIZE 32
+#define BURST_SIZE 32
+#define RING_SIZE 256
+
+/* Test device names */
+#define AF_PACKET_DEV_NAME "net_af_packet_test"
+#define TAP_DEV_NAME "dpdkafptest"
+
+static struct rte_mempool *mp;
+static uint16_t port_id = RTE_MAX_ETHPORTS;
+static int tap_fd = -1;
+static bool tap_created;
+static bool port_created;
+static bool port_started;
+
+/*
+ * Create a TAP interface for testing.
+ * Returns fd on success, -1 on failure.
+ */
+static int
+create_tap_interface(const char *name)
+{
+	struct ifreq ifr;
+	int fd, ret;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0) {
+		printf("Cannot open /dev/net/tun: %s\n", strerror(errno));
+		printf("(Are you running as root?)\n");
+		return -1;
+	}
+
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
+	snprintf(ifr.ifr_name, IFNAMSIZ, "%s", name);
+
+	ret = ioctl(fd, TUNSETIFF, &ifr);
+	if (ret < 0) {
+		printf("Cannot create TAP interface '%s': %s\n",
+		       name, strerror(errno));
+		close(fd);
+		return -1;
+	}
+
+	/* Bring the interface up */
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock >= 0) {
+		memset(&ifr, 0, sizeof(ifr));
+		snprintf(ifr.ifr_name, IFNAMSIZ, "%s", name);
+
+		/* Get current flags */
+		if (ioctl(sock, SIOCGIFFLAGS, &ifr) == 0) {
+			ifr.ifr_flags |= IFF_UP;
+			ioctl(sock, SIOCSIFFLAGS, &ifr);
+		}
+		close(sock);
+	}
+
+	printf("Created TAP interface '%s'\n", name);
+	return fd;
+}
+
+static void
+destroy_tap_interface(int fd)
+{
+	if (fd >= 0)
+		close(fd);
+}
+
+static int
+create_af_packet_port(const char *name, const char *args, uint16_t *out_port_id)
+{
+	int ret;
+
+	ret = rte_vdev_init(name, args);
+	if (ret != 0) {
+		printf("Failed to create af_packet device '%s': %d\n", name, ret);
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
+configure_af_packet_port(uint16_t pid, uint16_t nb_rx_q, uint16_t nb_tx_q)
+{
+	struct rte_eth_conf port_conf = {0};
+	struct rte_eth_dev_info dev_info;
+	int ret;
+	uint16_t q;
+
+	ret = rte_eth_dev_info_get(pid, &dev_info);
+	if (ret != 0) {
+		printf("Failed to get device info for port %u: %d\n", pid, ret);
+		return ret;
+	}
+
+	ret = rte_eth_dev_configure(pid, nb_rx_q, nb_tx_q, &port_conf);
+	if (ret != 0) {
+		printf("Failed to configure port %u: %d\n", pid, ret);
+		return ret;
+	}
+
+	for (q = 0; q < nb_rx_q; q++) {
+		ret = rte_eth_rx_queue_setup(pid, q, RING_SIZE,
+					     rte_eth_dev_socket_id(pid),
+					     NULL, mp);
+		if (ret != 0) {
+			printf("Failed to setup RX queue %u for port %u: %d\n",
+			       q, pid, ret);
+			return ret;
+		}
+	}
+
+	for (q = 0; q < nb_tx_q; q++) {
+		ret = rte_eth_tx_queue_setup(pid, q, RING_SIZE,
+					     rte_eth_dev_socket_id(pid),
+					     NULL);
+		if (ret != 0) {
+			printf("Failed to setup TX queue %u for port %u: %d\n",
+			       q, pid, ret);
+			return ret;
+		}
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
+test_af_packet_setup(void)
+{
+	char devargs[256];
+	int ret;
+
+	/* Create mempool for mbufs */
+	mp = rte_pktmbuf_pool_create("af_packet_test_pool", NUM_MBUFS,
+				     MBUF_CACHE_SIZE, 0,
+				     RTE_MBUF_DEFAULT_BUF_SIZE,
+				     rte_socket_id());
+	if (mp == NULL) {
+		printf("Failed to create mempool\n");
+		return -1;
+	}
+
+	/* Create TAP interface for testing */
+	tap_fd = create_tap_interface(TAP_DEV_NAME);
+	if (tap_fd >= 0)
+		tap_created = true;
+	else {
+		printf("TAP interface creation failed - tests will be skipped\n");
+		return 0; /* Return success to allow skipped tests */
+	}
+
+	/* Create and configure af_packet port */
+	snprintf(devargs, sizeof(devargs), "iface=%s", TAP_DEV_NAME);
+	ret = create_af_packet_port(AF_PACKET_DEV_NAME, devargs, &port_id);
+	if (ret != 0) {
+		printf("Failed to create af_packet port\n");
+		return -1;
+	}
+	port_created = true;
+
+	ret = configure_af_packet_port(port_id, 1, 1);
+	if (ret != 0) {
+		printf("Failed to configure af_packet port\n");
+		return -1;
+	}
+	port_started = true;
+
+	return 0;
+}
+
+static void
+test_af_packet_teardown(void)
+{
+	/* Stop and close test port */
+	if (port_started) {
+		rte_eth_dev_stop(port_id);
+		port_started = false;
+	}
+
+	if (port_created) {
+		rte_eth_dev_close(port_id);
+		rte_vdev_uninit(AF_PACKET_DEV_NAME);
+		port_id = RTE_MAX_ETHPORTS;
+		port_created = false;
+	}
+
+	/* Destroy TAP interface */
+	if (tap_created) {
+		destroy_tap_interface(tap_fd);
+		tap_fd = -1;
+		tap_created = false;
+	}
+
+	if (mp != NULL) {
+		rte_mempool_free(mp);
+		mp = NULL;
+	}
+}
+
+/*
+ * Test: Device info verification
+ */
+static int
+test_af_packet_dev_info(void)
+{
+	struct rte_eth_dev_info dev_info;
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_eth_dev_info_get(port_id, &dev_info);
+	TEST_ASSERT(ret == 0, "Failed to get device info");
+
+	/* Verify expected device info values */
+	TEST_ASSERT(dev_info.max_mac_addrs == 1,
+		    "Expected max_mac_addrs=1, got %u", dev_info.max_mac_addrs);
+	TEST_ASSERT(dev_info.max_rx_pktlen == RTE_ETHER_MAX_LEN,
+		    "Unexpected max_rx_pktlen: %u", dev_info.max_rx_pktlen);
+	TEST_ASSERT(dev_info.min_rx_bufsize == 0,
+		    "Expected min_rx_bufsize=0, got %u", dev_info.min_rx_bufsize);
+	TEST_ASSERT(dev_info.max_rx_queues >= 1, "No RX queues available");
+	TEST_ASSERT(dev_info.max_tx_queues >= 1, "No TX queues available");
+	TEST_ASSERT(dev_info.if_index > 0, "Invalid interface index");
+
+	/* Check TX offload capabilities */
+	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MULTI_SEGS,
+		    "Expected MULTI_SEGS TX offload capability");
+	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_VLAN_INSERT,
+		    "Expected VLAN_INSERT TX offload capability");
+
+	/* Check RX offload capabilities */
+	TEST_ASSERT(dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_VLAN_STRIP,
+		    "Expected VLAN_STRIP RX offload capability");
+	TEST_ASSERT(dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_TIMESTAMP,
+		    "Expected TIMESTAMP RX offload capability");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Link status
+ * Note: af_packet PMD link status reflects the underlying interface state,
+ * not the DPDK device start/stop state.
+ */
+static int
+test_af_packet_link_status(void)
+{
+	struct rte_eth_link link;
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_eth_link_get_nowait(port_id, &link);
+	TEST_ASSERT(ret == 0, "Failed to get link status");
+
+	/* TAP interface was brought up during setup, so link should be UP */
+	TEST_ASSERT(link.link_status == RTE_ETH_LINK_UP,
+		    "Expected link UP (TAP interface is up)");
+	TEST_ASSERT(link.link_speed == RTE_ETH_SPEED_NUM_10G,
+		    "Expected 10G link speed");
+	TEST_ASSERT(link.link_duplex == RTE_ETH_LINK_FULL_DUPLEX,
+		    "Expected full duplex");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Statistics initial state
+ */
+static int
+test_af_packet_stats_init(void)
+{
+	struct rte_eth_stats stats;
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Reset stats */
+	ret = rte_eth_stats_reset(port_id);
+	TEST_ASSERT(ret == 0, "Failed to reset stats");
+
+	/* Get initial stats */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats");
+
+	/* After reset, stats should be zero */
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
+ * Test: TX packets (packets will be sent to TAP interface)
+ */
+static int
+test_af_packet_tx(void)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	struct rte_eth_stats stats;
+	uint16_t nb_tx;
+	unsigned int i;
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Reset stats */
+	ret = rte_eth_stats_reset(port_id);
+	TEST_ASSERT(ret == 0, "Failed to reset stats");
+
+	/* Allocate and prepare mbufs for TX */
+	for (i = 0; i < BURST_SIZE; i++) {
+		bufs[i] = rte_pktmbuf_alloc(mp);
+		TEST_ASSERT(bufs[i] != NULL, "Failed to allocate mbuf");
+
+		/* Create a minimal Ethernet frame */
+		struct rte_ether_hdr *eth_hdr;
+		eth_hdr = (struct rte_ether_hdr *)rte_pktmbuf_append(bufs[i],
+				sizeof(struct rte_ether_hdr) + 46);
+		TEST_ASSERT(eth_hdr != NULL, "Failed to append data to mbuf");
+
+		/* Set destination and source MAC */
+		memset(&eth_hdr->dst_addr, 0xFF, RTE_ETHER_ADDR_LEN);
+		memset(&eth_hdr->src_addr, 0x00, RTE_ETHER_ADDR_LEN);
+		eth_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+	}
+
+	/* TX burst */
+	nb_tx = rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
+
+	/* Free any unsent mbufs */
+	for (i = nb_tx; i < BURST_SIZE; i++)
+		rte_pktmbuf_free(bufs[i]);
+
+	/* Small delay to allow stats update */
+	rte_delay_us_block(1000);
+
+	/* Get stats */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats");
+
+	/* Verify some packets were sent */
+	if (nb_tx > 0) {
+		TEST_ASSERT(stats.opackets > 0,
+			    "Expected opackets > 0 after TX");
+	}
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: RX packets (non-blocking, may not receive anything)
+ */
+static int
+test_af_packet_rx(void)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t nb_rx;
+	unsigned int i;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Try to receive packets (non-blocking) */
+	nb_rx = rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
+
+	/* Free any received mbufs */
+	for (i = 0; i < nb_rx; i++)
+		rte_pktmbuf_free(bufs[i]);
+
+	/* RX from tap interface without external traffic will return 0 */
+	/* This test just verifies the RX path doesn't crash */
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Promiscuous mode
+ */
+static int
+test_af_packet_promiscuous(void)
+{
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Enable promiscuous mode */
+	ret = rte_eth_promiscuous_enable(port_id);
+	TEST_ASSERT(ret == 0, "Failed to enable promiscuous mode");
+
+	ret = rte_eth_promiscuous_get(port_id);
+	TEST_ASSERT(ret == 1, "Expected promiscuous mode enabled");
+
+	/* Disable promiscuous mode */
+	ret = rte_eth_promiscuous_disable(port_id);
+	TEST_ASSERT(ret == 0, "Failed to disable promiscuous mode");
+
+	ret = rte_eth_promiscuous_get(port_id);
+	TEST_ASSERT(ret == 0, "Expected promiscuous mode disabled");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: MAC address operations
+ */
+static int
+test_af_packet_mac_addr(void)
+{
+	struct rte_ether_addr mac_addr;
+	struct rte_ether_addr new_mac = {
+		.addr_bytes = {0x02, 0x11, 0x22, 0x33, 0x44, 0x55}
+	};
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Get current MAC address */
+	ret = rte_eth_macaddr_get(port_id, &mac_addr);
+	TEST_ASSERT(ret == 0, "Failed to get MAC address");
+
+	/* Set new MAC address (use locally administered address) */
+	ret = rte_eth_dev_default_mac_addr_set(port_id, &new_mac);
+	TEST_ASSERT(ret == 0, "Failed to set MAC address");
+
+	/* Verify MAC was set */
+	ret = rte_eth_macaddr_get(port_id, &mac_addr);
+	TEST_ASSERT(ret == 0, "Failed to get MAC address after set");
+
+	TEST_ASSERT(memcmp(&mac_addr, &new_mac, sizeof(mac_addr)) == 0,
+		    "MAC address mismatch after set");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: MTU operations
+ */
+static int
+test_af_packet_mtu(void)
+{
+	uint16_t mtu;
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Get current MTU */
+	ret = rte_eth_dev_get_mtu(port_id, &mtu);
+	TEST_ASSERT(ret == 0, "Failed to get MTU");
+
+	/* Try to set a smaller MTU */
+	ret = rte_eth_dev_set_mtu(port_id, 1400);
+	if (ret == 0) {
+		ret = rte_eth_dev_get_mtu(port_id, &mtu);
+		TEST_ASSERT(ret == 0, "Failed to get MTU after set");
+
+		/* Restore original MTU */
+		rte_eth_dev_set_mtu(port_id, 1500);
+	}
+	/* MTU set may fail depending on permissions, that's OK */
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Stats reset verification
+ */
+static int
+test_af_packet_stats_reset(void)
+{
+	struct rte_eth_stats stats;
+	struct rte_mbuf *bufs[BURST_SIZE / 2];
+	uint16_t nb_tx;
+	unsigned int i;
+	int ret;
+
+	if (!tap_created || port_id >= RTE_MAX_ETHPORTS) {
+		printf("SKIPPED: Port not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Generate some TX traffic */
+	for (i = 0; i < BURST_SIZE / 2; i++) {
+		bufs[i] = rte_pktmbuf_alloc(mp);
+		if (bufs[i] == NULL)
+			break;
+
+		struct rte_ether_hdr *eth_hdr;
+		eth_hdr = (struct rte_ether_hdr *)rte_pktmbuf_append(bufs[i],
+				sizeof(struct rte_ether_hdr) + 46);
+		if (eth_hdr == NULL) {
+			rte_pktmbuf_free(bufs[i]);
+			break;
+		}
+
+		memset(&eth_hdr->dst_addr, 0xFF, RTE_ETHER_ADDR_LEN);
+		memset(&eth_hdr->src_addr, 0x00, RTE_ETHER_ADDR_LEN);
+		eth_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+	}
+
+	nb_tx = rte_eth_tx_burst(port_id, 0, bufs, i);
+	for (; nb_tx < i; nb_tx++)
+		rte_pktmbuf_free(bufs[nb_tx]);
+
+	/* Small delay */
+	rte_delay_us_block(1000);
+
+	/* Reset stats */
+	ret = rte_eth_stats_reset(port_id);
+	TEST_ASSERT(ret == 0, "Failed to reset stats");
+
+	/* Verify stats are zero */
+	ret = rte_eth_stats_get(port_id, &stats);
+	TEST_ASSERT(ret == 0, "Failed to get stats after reset");
+
+	TEST_ASSERT(stats.ipackets == 0,
+		    "Expected ipackets=0, got %"PRIu64, stats.ipackets);
+	TEST_ASSERT(stats.opackets == 0,
+		    "Expected opackets=0, got %"PRIu64, stats.opackets);
+	TEST_ASSERT(stats.ibytes == 0,
+		    "Expected ibytes=0, got %"PRIu64, stats.ibytes);
+	TEST_ASSERT(stats.obytes == 0,
+		    "Expected obytes=0, got %"PRIu64, stats.obytes);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Invalid configuration handling - missing iface
+ */
+static int
+test_af_packet_invalid_no_iface(void)
+{
+	int ret;
+
+	/* Test without iface argument (should fail) */
+	ret = rte_vdev_init("net_af_packet_invalid1", "");
+	TEST_ASSERT(ret != 0, "Expected failure without iface argument");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Invalid configuration handling - non-existent interface
+ */
+static int
+test_af_packet_invalid_bad_iface(void)
+{
+	int ret;
+
+	/* Test with non-existent interface (should fail) */
+	ret = rte_vdev_init("net_af_packet_invalid2",
+			    "iface=nonexistent_iface_12345");
+	TEST_ASSERT(ret != 0, "Expected failure with non-existent interface");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Invalid configuration handling - invalid qpairs
+ */
+static int
+test_af_packet_invalid_qpairs(void)
+{
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Test with invalid qpairs (should fail) */
+	ret = rte_vdev_init("net_af_packet_invalid3",
+			    "iface=" TAP_DEV_NAME ",qpairs=0");
+	TEST_ASSERT(ret != 0, "Expected failure with qpairs=0");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Custom frame size configuration
+ */
+static int
+test_af_packet_frame_config(void)
+{
+	struct rte_eth_dev_info dev_info;
+	uint16_t test_port;
+	char devargs[256];
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Create with custom frame parameters */
+	snprintf(devargs, sizeof(devargs),
+		 "iface=%s,blocksz=4096,framesz=2048,framecnt=256",
+		 TAP_DEV_NAME);
+
+	ret = rte_vdev_init("net_af_packet_frame_test", devargs);
+	if (ret != 0) {
+		printf("SKIPPED: Could not create port with custom frame config\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_eth_dev_get_port_by_name("net_af_packet_frame_test",
+					   &test_port);
+	TEST_ASSERT(ret == 0, "Failed to get port id");
+
+	ret = rte_eth_dev_info_get(test_port, &dev_info);
+	TEST_ASSERT(ret == 0, "Failed to get device info");
+
+	/* Cleanup */
+	rte_eth_dev_close(test_port);
+	rte_vdev_uninit("net_af_packet_frame_test");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Qdisc bypass configuration
+ */
+static int
+test_af_packet_qdisc_bypass(void)
+{
+	uint16_t test_port;
+	char devargs[256];
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Create with qdisc_bypass enabled */
+	snprintf(devargs, sizeof(devargs), "iface=%s,qdisc_bypass=1",
+		 TAP_DEV_NAME);
+
+	ret = rte_vdev_init("net_af_packet_qdisc_test", devargs);
+	if (ret != 0) {
+		printf("SKIPPED: qdisc_bypass may not be supported\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_eth_dev_get_port_by_name("net_af_packet_qdisc_test",
+					   &test_port);
+	TEST_ASSERT(ret == 0, "Failed to get port id");
+
+	/* Cleanup */
+	rte_eth_dev_close(test_port);
+	rte_vdev_uninit("net_af_packet_qdisc_test");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Multiple queue pairs
+ */
+static int
+test_af_packet_multi_queue(void)
+{
+	struct rte_eth_dev_info dev_info;
+	struct rte_eth_conf port_conf = {0};
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t test_port;
+	char devargs[256];
+	const uint16_t num_queues = 2;
+	uint16_t nb_tx;
+	unsigned int i, q;
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	snprintf(devargs, sizeof(devargs), "iface=%s,qpairs=%u",
+		 TAP_DEV_NAME, num_queues);
+	ret = rte_vdev_init("net_af_packet_multi_q", devargs);
+	if (ret != 0) {
+		printf("SKIPPED: Could not create multi-queue port\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_eth_dev_get_port_by_name("net_af_packet_multi_q", &test_port);
+	TEST_ASSERT(ret == 0, "Failed to get port id for multi-queue port");
+
+	ret = rte_eth_dev_info_get(test_port, &dev_info);
+	TEST_ASSERT(ret == 0, "Failed to get device info");
+
+	TEST_ASSERT(dev_info.max_rx_queues >= num_queues,
+		    "Expected at least %u RX queues, got %u",
+		    num_queues, dev_info.max_rx_queues);
+	TEST_ASSERT(dev_info.max_tx_queues >= num_queues,
+		    "Expected at least %u TX queues, got %u",
+		    num_queues, dev_info.max_tx_queues);
+
+	/* Configure the port */
+	ret = rte_eth_dev_configure(test_port, num_queues, num_queues, &port_conf);
+	TEST_ASSERT(ret == 0, "Failed to configure multi-queue port");
+
+	for (q = 0; q < num_queues; q++) {
+		ret = rte_eth_rx_queue_setup(test_port, q, RING_SIZE,
+					     rte_eth_dev_socket_id(test_port),
+					     NULL, mp);
+		TEST_ASSERT(ret == 0, "Failed to setup RX queue %u", q);
+
+		ret = rte_eth_tx_queue_setup(test_port, q, RING_SIZE,
+					     rte_eth_dev_socket_id(test_port),
+					     NULL);
+		TEST_ASSERT(ret == 0, "Failed to setup TX queue %u", q);
+	}
+
+	ret = rte_eth_dev_start(test_port);
+	TEST_ASSERT(ret == 0, "Failed to start multi-queue port");
+
+	/* Test TX on different queues */
+	for (q = 0; q < num_queues; q++) {
+		for (i = 0; i < BURST_SIZE / 2; i++) {
+			bufs[i] = rte_pktmbuf_alloc(mp);
+			if (bufs[i] == NULL)
+				break;
+
+			struct rte_ether_hdr *eth_hdr;
+			eth_hdr = (struct rte_ether_hdr *)rte_pktmbuf_append(
+					bufs[i], sizeof(struct rte_ether_hdr) + 46);
+			if (eth_hdr == NULL) {
+				rte_pktmbuf_free(bufs[i]);
+				break;
+			}
+
+			memset(&eth_hdr->dst_addr, 0xFF, RTE_ETHER_ADDR_LEN);
+			memset(&eth_hdr->src_addr, 0x00, RTE_ETHER_ADDR_LEN);
+			eth_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+		}
+
+		nb_tx = rte_eth_tx_burst(test_port, q, bufs, i);
+
+		/* Free unsent mbufs */
+		for (; nb_tx < i; nb_tx++)
+			rte_pktmbuf_free(bufs[nb_tx]);
+	}
+
+	/* Cleanup */
+	rte_eth_dev_stop(test_port);
+	rte_eth_dev_close(test_port);
+	rte_vdev_uninit("net_af_packet_multi_q");
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite af_packet_test_suite = {
+	.suite_name = "AF_PACKET PMD Unit Test Suite",
+	.setup = test_af_packet_setup,
+	.teardown = test_af_packet_teardown,
+	.unit_test_cases = {
+		/* Tests that don't modify device state */
+		TEST_CASE(test_af_packet_dev_info),
+		TEST_CASE(test_af_packet_link_status),
+		TEST_CASE(test_af_packet_stats_init),
+		TEST_CASE(test_af_packet_tx),
+		TEST_CASE(test_af_packet_rx),
+		TEST_CASE(test_af_packet_promiscuous),
+		TEST_CASE(test_af_packet_mac_addr),
+		TEST_CASE(test_af_packet_mtu),
+		TEST_CASE(test_af_packet_stats_reset),
+
+		/* Tests that create their own devices */
+		TEST_CASE(test_af_packet_invalid_no_iface),
+		TEST_CASE(test_af_packet_invalid_bad_iface),
+		TEST_CASE(test_af_packet_invalid_qpairs),
+		TEST_CASE(test_af_packet_frame_config),
+		TEST_CASE(test_af_packet_qdisc_bypass),
+		TEST_CASE(test_af_packet_multi_queue),
+
+		TEST_CASES_END() /**< NULL terminate unit test array */
+	}
+};
+
+static int
+test_pmd_af_packet(void)
+{
+	return unit_test_suite_runner(&af_packet_test_suite);
+}
+#endif
+
+REGISTER_FAST_TEST(af_packet_pmd_autotest, NOHUGE_OK, ASAN_OK, test_pmd_af_packet);
-- 
2.51.0


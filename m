Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F64C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 409BB40671;
	Thu,  7 Aug 2025 19:35:07 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id EE2DE40695
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:35:05 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-459d40d16bdso8628945e9.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588105;
 x=1755192905; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N94AIOdAA9Q+NuSu/QSb2m+552NqufsxethOUnlw8w8=;
 b=eGo1YP9TFboMtB0Yf8HrRDm1THXi7W7/KQBmBq6wO7gr9grIZD4Y73sIuVAZZXl/cl
 SvPlrWNPF9G7pXAdr6iDyh5NL4J9AB7GVqS2ts5C7qFXJ5F2QyfbiNJUsAHLXiKrp50S
 Vwd3+/hoQHWgiPeQ3lIp0fETBW6cRof3NBRiNLKMCK7UAnCKLX7blKzCdr9aImq9vYEb
 YH53PR38GGycJuZE7aCe9jUDh+s62shLL8WaUaR2Tyvd1+jb2Ji+jSMS1aNlFGixbYXG
 lVCGgnUZ5MufO5+b0ZMVLIWevEnTNBmmekoWCWk6xBqLNlZy2YgW57eC06Ko1Nz0K8w6
 vaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588105; x=1755192905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N94AIOdAA9Q+NuSu/QSb2m+552NqufsxethOUnlw8w8=;
 b=WIA6ERqXaQcFZBzgeb0WvH+h6r6I8Q+U510HGNkTWTJgQeaMuMJO/vEQyRs6pxwB8m
 zhactfDn7FZwXOE6E64knAtE8NsAGXSIiQ/sbqvwvn6Oiwt+AwG/QWutr2oZQmd0GA7C
 w9dsdDobJtAvsBYzm7NyKT3tsdMTKfUhGZZ0jQS88hHWcIIB2KGM3KfLr45x1B+sOqV/
 XuKVo5bu9/86HcZwG4WJiyLYMtxeGeMfHdGupWY8Q9gGrNSyfb9b2SHD5/fk4yBz7bmh
 5kGp6sRSz416G6tNcgtRYU61xZR6px0sZWHREtueVhO6Fbezh8FrKtHZAIZ+ywJwxDad
 qN+w==
X-Gm-Message-State: AOJu0YwQoyC+nTWgbVxoWbL6EHlUMKCny00AONQ720T7Uh/RXSEd8g0J
 rZ8TzypF4fMxMXfG12kiRUHVkHCT/2CvRGI2EyXB5lWSiCE40IftmKgZVlBlGFQBKhzMMbj6cFN
 jJxhJ
X-Gm-Gg: ASbGncupCH8+NQ1E9piqG6tpT0XnmCoirsB6+tkkzENt2WElToIFxyhVyHeE5hLRT42
 bHeekk6y6M34k1STGwqH1uabUHNKt7LXLd8iKfRHNTLDx8YgVUJrIKFQ8/AvzOcPli9A97zVUbD
 B5L/hxG+w9DYng6Bfwtm1wfH3vbZx34q7fWtQricXaweBsBghnt+qLFuEHIZ1FvZjS/FphX5u4a
 wBBEzW0ylgWczr8kBIARjQ8tU5cw5Ku2MGR265WsDfgE8vJnBJauyEuSZ6950vBB5/gK5KbCnlE
 Ttl6WVk601EhqyiDo+TOs93uozt8r+SkAPgOSAytCM1vvMGmaNOXOVXx8gcURvZ5Mv/Cu0OpHyK
 QsBcJxSU2PvUM8SlLD9NSjhgeS32Nl0lHLbtGvoHIUd8PaPGXFGzsex2qY1AiSdOnBPK9qr/+
X-Google-Smtp-Source: AGHT+IH97ieZ7xEInE23w8thDdf1E9k4ssR/Sgb71Zh6O2smJ9nXF3WHmhj+jL3gC6J4Nz4+k6ggFA==
X-Received: by 2002:a05:6000:2f84:b0:3b7:9dc1:74a9 with SMTP id
 ffacd0b85a97d-3b900b7aea4mr45460f8f.42.1754588105289; 
 Thu, 07 Aug 2025 10:35:05 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:35:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v10 09/14] ethdev: add port mirroring feature
Date: Thu,  7 Aug 2025 10:33:23 -0700
Message-ID: <20250807173437.11442-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

This adds new feature port mirroring to the ethdev layer.
And standalone tests for those features.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build             |   1 +
 app/test/test_ethdev_mirror.c    | 325 ++++++++++++++++++++
 config/rte_config.h              |   1 +
 lib/ethdev/ethdev_driver.h       |   6 +
 lib/ethdev/ethdev_private.c      |  58 +++-
 lib/ethdev/ethdev_private.h      |   3 +
 lib/ethdev/ethdev_trace.h        |  17 ++
 lib/ethdev/ethdev_trace_points.c |   6 +
 lib/ethdev/meson.build           |   2 +
 lib/ethdev/rte_ethdev.c          |  17 +-
 lib/ethdev/rte_ethdev.h          |  23 +-
 lib/ethdev/rte_ethdev_core.h     |  12 +-
 lib/ethdev/rte_mirror.c          | 501 +++++++++++++++++++++++++++++++
 lib/ethdev/rte_mirror.h          | 147 +++++++++
 14 files changed, 1101 insertions(+), 18 deletions(-)
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

diff --git a/app/test/meson.build b/app/test/meson.build
index f3ea3e2b74..87219b869e 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -73,6 +73,7 @@ source_file_deps = {
     'test_errno.c': [],
     'test_ethdev_api.c': ['ethdev'],
     'test_ethdev_link.c': ['ethdev'],
+    'test_ethdev_mirror.c': ['net_ring', 'ethdev', 'bus_vdev'],
     'test_event_crypto_adapter.c': ['cryptodev', 'eventdev', 'bus_vdev'],
     'test_event_dma_adapter.c': ['dmadev', 'eventdev', 'bus_vdev'],
     'test_event_eth_rx_adapter.c': ['ethdev', 'eventdev', 'bus_vdev'],
diff --git a/app/test/test_ethdev_mirror.c b/app/test/test_ethdev_mirror.c
new file mode 100644
index 0000000000..bbff1ff6a7
--- /dev/null
+++ b/app/test/test_ethdev_mirror.c
@@ -0,0 +1,325 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+#include "test.h"
+
+#include <stdio.h>
+
+#include <rte_eth_ring.h>
+#include <rte_ethdev.h>
+#include <rte_bus_vdev.h>
+
+#define SOCKET0 0
+#define RING_SIZE 256
+#define BURST_SZ 64
+#define NB_MBUF 512
+
+static struct rte_mempool *mirror_pool;
+static const uint32_t pkt_len = 200;
+
+static struct rte_ring *rxtx_ring;
+static const char ring_dev[] = "net_ring0";
+static uint16_t ring_port;
+static const char null_dev[] = "net_null0";
+static uint16_t null_port;
+
+static int
+configure_port(uint16_t port, const char *name)
+{
+	struct rte_eth_conf eth_conf = { 0 };
+
+	if (rte_eth_dev_configure(port, 1, 1, &eth_conf) < 0) {
+		fprintf(stderr, "Configure failed for port %u: %s\n", port, name);
+		return -1;
+	}
+
+	/* only single queue */
+	if (rte_eth_tx_queue_setup(port, 0, RING_SIZE, SOCKET0, NULL) < 0) {
+		fprintf(stderr, "TX queue setup failed port %u: %s\n", port, name);
+		return -1;
+	}
+
+	if (rte_eth_rx_queue_setup(port, 0, RING_SIZE, SOCKET0, NULL, mirror_pool) < 0) {
+		fprintf(stderr, "RX queue setup failed port %u: %s\n", port, name);
+		return -1;
+	}
+
+	if (rte_eth_dev_start(port) < 0) {
+		fprintf(stderr, "Error starting port %u:%s\n", port, name);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void
+test_cleanup(void)
+{
+	rte_ring_free(rxtx_ring);
+
+	rte_vdev_uninit("net_ring");
+	rte_vdev_uninit("net_null");
+
+	rte_mempool_free(mirror_pool);
+}
+
+/* Make two virtual devices ring and null */
+static int
+test_setup(void)
+{
+	char null_name[] = "net_null0";
+	int ret;
+
+	/* ring must support multiple enqueue for mirror to work */
+	rxtx_ring = rte_ring_create("R0", RING_SIZE, SOCKET0, RING_F_MP_RTS_ENQ | RING_F_SC_DEQ);
+	if (rxtx_ring == NULL) {
+		fprintf(stderr, "rte_ring_create R0 failed\n");
+		goto fail;
+	}
+	ret = rte_eth_from_rings(ring_dev, &rxtx_ring, 1, &rxtx_ring, 1, SOCKET0);
+	if (ret < 0) {
+		fprintf(stderr, "rte_eth_from_rings failed\n");
+		goto fail;
+	}
+	ring_port = ret;
+
+	/* Make a dummy null device to snoop on */
+	if (rte_vdev_init(null_dev, NULL) != 0) {
+		fprintf(stderr, "Failed to create vdev '%s'\n", null_dev);
+		goto fail;
+	}
+	if (rte_eth_dev_get_port_by_name(null_dev, &null_port) != 0) {
+		fprintf(stderr, "cannot find added vdev %s\n", null_name);
+		goto fail;
+	}
+
+	mirror_pool = rte_pktmbuf_pool_create("mirror_pool", NB_MBUF, 32,
+					      0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+	if (mirror_pool == NULL) {
+		fprintf(stderr, "rte_pktmbuf_pool_create failed\n");
+		goto fail;
+	}
+
+	ret = configure_port(ring_port, ring_dev);
+	if (ret < 0)
+		goto fail;
+
+	ret = configure_port(null_port, null_dev);
+	if (ret < 0)
+		goto fail;
+
+	return 0;
+fail:
+	test_cleanup();
+	return -1;
+}
+
+/* Make sure mirror API checks args */
+static int32_t
+ethdev_mirror_api(void)
+{
+	struct rte_eth_mirror_conf conf = {
+		.mp = mirror_pool,
+		.flags = RTE_ETH_MIRROR_DIRECTION_EGRESS,
+	};
+	struct rte_eth_mirror_stats stats;
+	uint16_t invalid_port = RTE_MAX_ETHPORTS;
+	int ret;
+
+	conf.target = null_port;
+	ret = rte_eth_add_mirror(invalid_port, &conf);
+	TEST_ASSERT(ret != 0, "Created mirror from invalid port");
+
+	conf.target = invalid_port;
+	ret = rte_eth_add_mirror(null_port, &conf);
+	TEST_ASSERT(ret != 0, "Created mirror to invalid port");
+
+	conf.flags = 0;
+	conf.target = ring_port;
+	ret = rte_eth_add_mirror(null_port, &conf);
+	TEST_ASSERT(ret != 0, "Created mirror with invalid flags");
+
+	conf.flags = RTE_ETH_MIRROR_DIRECTION_INGRESS;
+	conf.target = ring_port;
+	ret = rte_eth_add_mirror(ring_port, &conf);
+	TEST_ASSERT(ret != 0, "Created mirror to self");
+
+	ret = rte_eth_mirror_stats_get(invalid_port, null_port, &stats);
+	TEST_ASSERT(ret != 0, "Able to gets mirror stats from invalid port");
+
+	ret = rte_eth_mirror_stats_get(null_port, invalid_port, &stats);
+	TEST_ASSERT(ret != 0, "Able to gets mirror stats from invalid target");
+
+	conf.target = null_port;
+	ret = rte_eth_add_mirror(ring_port, &conf);
+	TEST_ASSERT(ret == 0, "Could not create mirror from ring to null");
+
+	ret = rte_eth_add_mirror(ring_port, &conf);
+	TEST_ASSERT(ret != 0, "Able to create duplicate mirror");
+
+	ret = rte_eth_mirror_stats_get(ring_port, null_port, NULL);
+	TEST_ASSERT(ret == -EINVAL, "Able to get status with NULL");
+
+	ret = rte_eth_mirror_stats_get(null_port, ring_port, &stats);
+	TEST_ASSERT(ret != 0, "Able to get stats with swapped ports");
+
+	ret = rte_eth_mirror_stats_get(ring_port, null_port, &stats);
+	TEST_ASSERT(ret == 0, "Could not get stats");
+
+	ret = rte_eth_remove_mirror(ring_port, null_port);
+	TEST_ASSERT(ret == 0, "Unable to delete mirror");
+
+	ret = rte_eth_remove_mirror(ring_port, null_port);
+	TEST_ASSERT(ret != 0, "Able to delete port without mirror");
+
+	return 0;
+}
+
+static int
+init_mbuf(struct rte_mbuf *m, uint16_t id)
+{
+	struct {
+		struct rte_ether_hdr eth;
+		struct rte_ipv4_hdr ip;
+		struct rte_udp_hdr udp;
+	} hdrs = {
+		.eth = {
+			.dst_addr.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
+			.ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
+		},
+		.ip = {
+			.version_ihl = RTE_IPV4_VHL_DEF,
+			.time_to_live = 1,
+			.next_proto_id = IPPROTO_UDP,
+			.src_addr = rte_cpu_to_be_32(RTE_IPV4_LOOPBACK),
+			.dst_addr = rte_cpu_to_be_32(RTE_IPV4_BROADCAST),
+		},
+		.udp = {
+			.dst_port = rte_cpu_to_be_16(9), /* Discard port */
+		},
+	};
+
+	rte_eth_random_addr(hdrs.eth.src_addr.addr_bytes);
+	uint16_t plen = pkt_len - sizeof(struct rte_ether_hdr);
+
+	hdrs.ip.packet_id = rte_cpu_to_be_16(id);
+	hdrs.ip.total_length = rte_cpu_to_be_16(plen);
+	hdrs.ip.hdr_checksum = rte_ipv4_cksum(&hdrs.ip);
+
+	plen -= sizeof(struct rte_ipv4_hdr);
+	hdrs.udp.src_port = rte_rand();
+	hdrs.udp.dgram_len = rte_cpu_to_be_16(plen);
+
+	void *data = rte_pktmbuf_append(m, pkt_len);
+	TEST_ASSERT(data != NULL, "could not add header");
+
+	memcpy(data, &hdrs, sizeof(hdrs));
+	return 0;
+}
+
+static int
+init_burst(struct rte_mbuf *pkts[], unsigned int n)
+{
+	for (unsigned int i = 0; i < n; i++) {
+		if (init_mbuf(pkts[i], i) < 0)
+			return -1;
+	}
+	return 0;
+}
+
+static int
+validate_burst(struct rte_mbuf *pkts[], unsigned int n)
+{
+	for (unsigned int i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+
+		rte_mbuf_sanity_check(m, 1);
+		TEST_ASSERT(m->pkt_len == pkt_len,
+			    "mirror packet len %u not right len %u",
+			    m->pkt_len, pkt_len);
+
+		const struct rte_ether_hdr *eh
+			= rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+		TEST_ASSERT(rte_is_broadcast_ether_addr(&eh->dst_addr),
+			    "mirrored packet is not broadcast");
+
+	}
+	return 0;
+}
+
+static int32_t
+ethdev_mirror_packets(void)
+{
+	struct rte_eth_mirror_conf conf = {
+		.mp = mirror_pool,
+		.target = ring_port,
+		.flags = RTE_ETH_MIRROR_DIRECTION_EGRESS,
+	};
+	struct rte_eth_mirror_stats stats;
+	struct rte_mbuf *tx_pkts[BURST_SZ], *rx_pkts[BURST_SZ];
+	uint16_t nb_tx, nb_rx;
+	int ret;
+
+	ret = rte_pktmbuf_alloc_bulk(mirror_pool, tx_pkts, BURST_SZ);
+	TEST_ASSERT(ret == 0, "Could not allocate mbufs");
+
+	ret = init_burst(tx_pkts, BURST_SZ);
+	TEST_ASSERT(ret == 0, "Init mbufs failed");
+
+	ret = rte_eth_add_mirror(null_port, &conf);
+	TEST_ASSERT(ret == 0, "Could not create mirror from ring to null");
+
+	nb_tx = rte_eth_tx_burst(null_port, 0, tx_pkts, BURST_SZ);
+	TEST_ASSERT(nb_tx == BURST_SZ, "Only sent %u burst to null (vs %u)",
+		    nb_tx, BURST_SZ);
+
+	nb_rx = rte_eth_rx_burst(ring_port, 0, rx_pkts, BURST_SZ);
+	TEST_ASSERT(nb_rx == BURST_SZ, "Only received %u of %u packets",
+		    nb_rx, BURST_SZ);
+
+	validate_burst(rx_pkts, nb_rx);
+	rte_pktmbuf_free_bulk(rx_pkts, nb_rx);
+
+	ret = rte_eth_mirror_stats_get(null_port, ring_port, &stats);
+	TEST_ASSERT(ret == 0, "Could not get stats: %d", ret);
+
+	TEST_ASSERT(stats.packets == BURST_SZ, "Stats reports %"PRIu64" of %u packets",
+		    stats.packets, BURST_SZ);
+	TEST_ASSERT(stats.nombuf == 0, "Stats: no mbufs %"PRIu64, stats.nombuf);
+	TEST_ASSERT(stats.full == 0, "Stats: transmit was full %"PRIu64, stats.full);
+
+	ret = rte_eth_mirror_stats_reset(null_port, ring_port);
+	TEST_ASSERT(ret == 0, "Could not get stats: %d", ret);
+
+	ret = rte_eth_mirror_stats_get(null_port, ring_port, &stats);
+	TEST_ASSERT(ret == 0, "Could not get stats after reset: %d", ret);
+
+	TEST_ASSERT(stats.packets == 0, "Stats reports %"PRIu64" after reset", stats.packets);
+
+	ret = rte_eth_remove_mirror(null_port, ring_port);
+	TEST_ASSERT(ret == 0, "Could not remove mirror");
+
+	return 0;
+}
+
+static struct unit_test_suite ethdev_mirror_suite = {
+	.suite_name = "port mirroring",
+	.setup = test_setup,
+	.teardown = test_cleanup,
+	.unit_test_cases = {
+		TEST_CASE(ethdev_mirror_api),
+		TEST_CASE(ethdev_mirror_packets),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_ethdev_mirror(void)
+{
+#ifndef RTE_ETHDEV_MIRROR
+	return TEST_SKIPPED;
+#endif
+	return unit_test_suite_runner(&ethdev_mirror_suite);
+}
+
+REGISTER_FAST_TEST(ethdev_mirror, true, true, test_ethdev_mirror);
diff --git a/config/rte_config.h b/config/rte_config.h
index 05344e2619..76eb2aa417 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -69,6 +69,7 @@
 #define RTE_MAX_QUEUES_PER_PORT 1024
 #define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
 #define RTE_ETHDEV_RXTX_CALLBACKS 1
+#define RTE_ETHDEV_MIRROR 1
 #define RTE_MAX_MULTI_HOST_CTRLS 4
 
 /* cryptodev defines */
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..e6aad6d30a 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -91,6 +91,12 @@ struct __rte_cache_aligned rte_eth_dev {
 	 */
 	RTE_ATOMIC(struct rte_eth_rxtx_callback *) pre_tx_burst_cbs[RTE_MAX_QUEUES_PER_PORT];
 
+	/** Receive mirrors */
+	RTE_ATOMIC(struct rte_eth_mirror *) rx_mirror;
+
+	/** Transmit mirrors */
+	RTE_ATOMIC(struct rte_eth_mirror *) tx_mirror;
+
 	enum rte_eth_dev_state state; /**< Flag indicating the port state */
 	void *security_ctx; /**< Context for security ops */
 };
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 000b8372d8..e702acc874 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -289,6 +289,8 @@ eth_dev_fp_ops_setup(struct rte_eth_fp_ops *fpo,
 	fpo->tx_descriptor_status = dev->tx_descriptor_status;
 	fpo->recycle_tx_mbufs_reuse = dev->recycle_tx_mbufs_reuse;
 	fpo->recycle_rx_descriptors_refill = dev->recycle_rx_descriptors_refill;
+	fpo->rx_mirror = (struct rte_eth_mirror * __rte_atomic *)(uintptr_t)&dev->rx_mirror;
+	fpo->tx_mirror = (struct rte_eth_mirror * __rte_atomic *)(uintptr_t)&dev->tx_mirror;
 
 	fpo->rxq.data = dev->data->rx_queues;
 	fpo->rxq.clbk = (void * __rte_atomic *)(uintptr_t)dev->post_rx_burst_cbs;
@@ -490,17 +492,53 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)
 }
 
 static int
-ethdev_handle_request(const struct ethdev_mp_request *req)
+ethdev_handle_request(const struct ethdev_mp_request *req, size_t len)
 {
+	len -= sizeof(*req);
+
 	switch (req->operation) {
 	case ETH_REQ_START:
+		if (len != 0)
+			return -EINVAL;
+
 		return rte_eth_dev_start(req->port_id);
 
 	case ETH_REQ_STOP:
+		if (len != 0)
+			return -EINVAL;
 		return rte_eth_dev_stop(req->port_id);
 
+	case ETH_REQ_RESET:
+		if (len != 0)
+			return -EINVAL;
+		return rte_eth_dev_reset(req->port_id);
+
+	case ETH_REQ_ADD_MIRROR:
+		if (len != sizeof(struct rte_eth_mirror_conf)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "add mirror conf wrong size %zu", len);
+			return -EINVAL;
+		}
+
+		const struct rte_eth_mirror_conf *conf
+			= (const struct rte_eth_mirror_conf *) req->config;
+
+		return rte_eth_add_mirror(req->port_id, conf);
+
+	case ETH_REQ_REMOVE_MIRROR:
+		if (len != sizeof(uint16_t)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "mirror remove wrong size %zu", len);
+			return -EINVAL;
+		}
+
+		uint16_t target = *(const uint16_t *) req->config;
+		return rte_eth_remove_mirror(req->port_id, target);
+
 	default:
-		return -EINVAL;
+		RTE_ETHDEV_LOG_LINE(ERR,
+			    "Unknown mp request operation %u", req->operation);
+		return -ENOTSUP;
 	}
 }
 
@@ -513,23 +551,25 @@ static_assert(sizeof(struct ethdev_mp_response) <= RTE_MP_MAX_PARAM_LEN,
 int
 ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)
 {
-	const struct ethdev_mp_request *req
-		= (const struct ethdev_mp_request *)mp_msg->param;
-
 	struct rte_mp_msg mp_resp = {
 		.name = ETHDEV_MP,
 	};
 	struct ethdev_mp_response *resp;
+	const struct ethdev_mp_request *req;
 
 	resp = (struct ethdev_mp_response *)mp_resp.param;
 	mp_resp.len_param = sizeof(*resp);
-	resp->res_op = req->operation;
 
 	/* recv client requests */
-	if (mp_msg->len_param != sizeof(*req))
+	if (mp_msg->len_param < (int)sizeof(*req)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "invalid request from secondary");
 		resp->err_value = -EINVAL;
-	else
-		resp->err_value = ethdev_handle_request(req);
+	} else {
+		req = (const struct ethdev_mp_request *)mp_msg->param;
+		resp->res_op = req->operation;
+		resp->err_value = ethdev_handle_request(req, mp_msg->len_param);
+
+	}
 
 	return rte_mp_reply(&mp_resp, peer);
 }
diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index f58f161871..d2fdc20057 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -85,6 +85,9 @@ int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues);
 enum ethdev_mp_operation {
 	ETH_REQ_START,
 	ETH_REQ_STOP,
+	ETH_REQ_RESET,
+	ETH_REQ_ADD_MIRROR,
+	ETH_REQ_REMOVE_MIRROR,
 };
 
 struct ethdev_mp_request {
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 482befc209..e137afcbf7 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -1035,6 +1035,23 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_eth_trace_add_mirror,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id,
+			     const struct rte_eth_mirror_conf *conf, int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u16(conf->target);
+	rte_trace_point_emit_int(ret);
+)
+
+RTE_TRACE_POINT(
+	rte_eth_trace_remove_mirror,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t target_id, int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u16(target_id);
+	rte_trace_point_emit_int(ret);
+)
+
 RTE_TRACE_POINT(
 	rte_eth_trace_rx_queue_info_get,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_id,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..fa1fd21809 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -389,6 +389,12 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_rx_callback,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_tx_callback,
 	lib.ethdev.remove_tx_callback)
 
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_add_mirror,
+	lib.ethdev.add_mirror)
+
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_mirror,
+	lib.ethdev.remove_mirror)
+
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_rx_queue_info_get,
 	lib.ethdev.rx_queue_info_get)
 
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 5d2dc240fd..2c7110a199 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -11,6 +11,7 @@ sources = files(
         'rte_ethdev_cman.c',
         'rte_ethdev_telemetry.c',
         'rte_flow.c',
+        'rte_mirror.c',
         'rte_mtr.c',
         'rte_tm.c',
         'sff_telemetry.c',
@@ -27,6 +28,7 @@ headers = files(
         'rte_dev_info.h',
         'rte_flow.h',
         'rte_flow_driver.h',
+        'rte_mirror.h',
         'rte_mtr.h',
         'rte_mtr_driver.h',
         'rte_tm.h',
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index adeec575be..ac889c220a 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -14,6 +14,8 @@
 #include <bus_driver.h>
 #include <eal_export.h>
 #include <rte_log.h>
+#include <rte_cycles.h>
+#include <rte_alarm.h>
 #include <rte_interrupts.h>
 #include <rte_kvargs.h>
 #include <rte_memcpy.h>
@@ -2041,13 +2043,16 @@ rte_eth_dev_reset(uint16_t port_id)
 	if (dev->dev_ops->dev_reset == NULL)
 		return -ENOTSUP;
 
-	ret = rte_eth_dev_stop(port_id);
-	if (ret != 0) {
-		RTE_ETHDEV_LOG_LINE(ERR,
-			"Failed to stop device (port %u) before reset: %s - ignore",
-			port_id, rte_strerror(-ret));
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		ret = rte_eth_dev_stop(port_id);
+		if (ret != 0)
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "Failed to stop device (port %u) before reset: %s - ignore",
+				    port_id, rte_strerror(-ret));
+		ret = eth_err(port_id, dev->dev_ops->dev_reset(dev));
+	} else {
+		ret = ethdev_request(port_id, ETH_REQ_STOP, NULL, 0);
 	}
-	ret = eth_err(port_id, dev->dev_ops->dev_reset(dev));
 
 	rte_ethdev_trace_reset(port_id, ret);
 
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..84801a1123 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -170,6 +170,7 @@
 
 #include "rte_ethdev_trace_fp.h"
 #include "rte_dev_info.h"
+#include "rte_mirror.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -1466,7 +1467,6 @@ enum rte_eth_tunnel_type {
 	RTE_ETH_TUNNEL_TYPE_ECPRI,
 	RTE_ETH_TUNNEL_TYPE_MAX,
 };
-
 #ifdef __cplusplus
 }
 #endif
@@ -6334,6 +6334,17 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id,
 
 	nb_rx = p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
 
+#ifdef RTE_ETHDEV_MIRROR
+	{
+		struct rte_eth_mirror *mirror
+			= rte_atomic_load_explicit(p->rx_mirror, rte_memory_order_relaxed);
+
+		if (unlikely(mirror != NULL))
+			rte_eth_mirror_burst(port_id, queue_id, RTE_ETH_MIRROR_DIRECTION_INGRESS,
+					     rx_pkts, nb_rx, mirror);
+	}
+#endif
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6692,6 +6703,16 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+#ifdef RTE_ETHDEV_MIRROR
+	{
+		struct rte_eth_mirror *mirror;
+
+		mirror = rte_atomic_load_explicit(p->tx_mirror, rte_memory_order_relaxed);
+		if (unlikely(mirror != NULL))
+			rte_eth_mirror_burst(port_id, queue_id, RTE_ETH_MIRROR_DIRECTION_EGRESS,
+					     tx_pkts, nb_pkts, mirror);
+	}
+#endif
 	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
 
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h
index e55fb42996..2ca1beb239 100644
--- a/lib/ethdev/rte_ethdev_core.h
+++ b/lib/ethdev/rte_ethdev_core.h
@@ -22,6 +22,12 @@ RTE_TAILQ_HEAD(rte_eth_dev_cb_list, rte_eth_dev_callback);
 
 struct rte_eth_dev;
 
+struct rte_eth_mirror;
+
+void rte_eth_mirror_burst(uint16_t port_id, uint16_t quque_id, uint8_t dir,
+			  struct rte_mbuf **pkts, uint16_t nb_pkts,
+			  struct rte_eth_mirror *mirror);
+
 /**
  * @internal Retrieve input packets from a receive queue of an Ethernet device.
  */
@@ -101,7 +107,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
 	eth_rx_descriptor_status_t rx_descriptor_status;
 	/** Refill Rx descriptors with the recycling mbufs. */
 	eth_recycle_rx_descriptors_refill_t recycle_rx_descriptors_refill;
-	uintptr_t reserved1[2];
+	uintptr_t reserved1;
+	RTE_ATOMIC(struct rte_eth_mirror *) *rx_mirror;
 	/**@}*/
 
 	/**@{*/
@@ -121,7 +128,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
 	eth_recycle_tx_mbufs_reuse_t recycle_tx_mbufs_reuse;
 	/** Get the number of used Tx descriptors. */
 	eth_tx_queue_count_t tx_queue_count;
-	uintptr_t reserved2[1];
+	RTE_ATOMIC(struct rte_eth_mirror *) *tx_mirror;
+	uintptr_t reserved2;
 	/**@}*/
 
 };
diff --git a/lib/ethdev/rte_mirror.c b/lib/ethdev/rte_mirror.c
new file mode 100644
index 0000000000..73585d4c40
--- /dev/null
+++ b/lib/ethdev/rte_mirror.c
@@ -0,0 +1,501 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_alarm.h>
+#include <rte_bitops.h>
+#include <rte_common.h>
+#include <rte_config.h>
+#include <rte_cycles.h>
+#include <rte_eal.h>
+#include <rte_ether.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <eal_export.h>
+
+#include "rte_ethdev.h"
+#include "rte_mirror.h"
+#include "ethdev_driver.h"
+#include "ethdev_private.h"
+#include "ethdev_trace.h"
+
+/* Upper bound of packet bursts redirected */
+#define RTE_MIRROR_BURST_SIZE 64
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+#include <rte_bpf.h>
+#endif
+
+/**
+ * Structure used to hold information mirror port mirrors for a
+ * queue on Rx and Tx.
+ */
+struct rte_eth_mirror {
+	RTE_ATOMIC(struct rte_eth_mirror *) next;
+	struct rte_mempool *mp;
+	struct rte_bpf *bpf;
+	uint32_t snaplen;
+	uint32_t flags;
+	uint16_t target;
+	struct rte_eth_mirror_stats stats;
+};
+
+/* spinlock for setting up mirror ports */
+static rte_spinlock_t mirror_port_lock = RTE_SPINLOCK_INITIALIZER;
+
+/* dynamically assigned offload flag to indicate ingress vs egress */
+static uint64_t mirror_origin_flag;
+static int mirror_origin_offset = -1;
+static uint64_t mirror_ingress_flag;
+static uint64_t mirror_egress_flag;
+
+static uint64_t mbuf_timestamp_dynflag;
+static int mbuf_timestamp_offset = -1;
+
+/* register dynamic mbuf fields, done on first mirror creation */
+static int
+ethdev_dyn_mirror_register(void)
+{
+	const struct rte_mbuf_dynfield field_desc = {
+		.name = RTE_MBUF_DYNFIELD_MIRROR_ORIGIN,
+		.size = sizeof(rte_mbuf_origin_t),
+		.align = sizeof(rte_mbuf_origin_t),
+	};
+	struct rte_mbuf_dynflag flag_desc = {
+		.name = RTE_MBUF_DYNFLAG_MIRROR_ORIGIN,
+	};
+	int offset;
+
+	if (rte_mbuf_dyn_tx_timestamp_register(&mbuf_timestamp_offset,
+					       &mbuf_timestamp_dynflag) < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register timestamp flag");
+		return -1;
+	}
+
+	offset = rte_mbuf_dynfield_register(&field_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf origin field");
+		return -1;
+	}
+	mirror_origin_offset = offset;
+
+	offset = rte_mbuf_dynflag_register(&flag_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf origin flag");
+		return -1;
+	}
+	mirror_origin_flag = RTE_BIT64(offset);
+
+	strlcpy(flag_desc.name, RTE_MBUF_DYNFLAG_MIRROR_INGRESS, sizeof(flag_desc.name));
+	offset = rte_mbuf_dynflag_register(&flag_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf ingress flag");
+		return -1;
+	}
+	mirror_ingress_flag = RTE_BIT64(offset);
+
+	strlcpy(flag_desc.name, RTE_MBUF_DYNFLAG_MIRROR_EGRESS,
+		sizeof(flag_desc.name));
+	offset = rte_mbuf_dynflag_register(&flag_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf egress flag");
+		return -1;
+	}
+	mirror_egress_flag = RTE_BIT64(offset);
+
+	return 0;
+}
+
+/* Add a new mirror entry to the list. */
+static int
+ethdev_insert_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *top,
+		   const struct rte_eth_mirror_conf *conf)
+{
+	struct rte_eth_mirror *mirror;
+	ssize_t filter_len = 0;
+
+	/* Don't allow multiple mirrors from same source to target */
+	while ((mirror = *top) != NULL) {
+		if (mirror->target == conf->target) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "Mirror to port %u already exists", conf->target);
+			return -EEXIST;
+		}
+	}
+
+	if (conf->filter) {
+#ifdef RTE_LIB_BPF
+		filter_len = rte_bpf_buf_size(conf->filter);
+		if (filter_len < 0) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Invalid BPF filter: %s",
+					    rte_strerror(rte_errno));
+			return -EINVAL;
+		}
+#else
+		RTE_ETHDEV_LOG_LINE(ERR, "BPF filter not supported");
+		return -ENOTSUP;
+#endif
+	}
+
+	/*
+	 * Allocate space for both fast path mirror structure
+	 * and filter bpf code (if any).
+	 */
+	mirror = rte_zmalloc(NULL, sizeof(*mirror) + filter_len, 0);
+	if (mirror == NULL)
+		return -ENOMEM;
+
+	mirror->mp = conf->mp;
+	mirror->target = conf->target;
+	mirror->flags = conf->flags;
+
+	if (conf->snaplen == 0) /* specifying 0 implies the full packet */
+		mirror->snaplen = UINT32_MAX;
+	else
+		mirror->snaplen = conf->snaplen;
+
+#ifdef RTE_LIB_BPF
+	if (filter_len > 0) {
+		/* reserved space for BPF is after mirror structure */
+		void *buf = (uint8_t *)mirror + sizeof(*mirror);
+
+		/*
+		 * Copy filter internal representation into space
+		 * allocated in huge pages to allow access from any process.
+		 */
+		mirror->bpf = rte_bpf_buf_load(conf->filter, buf, filter_len);
+		if (mirror->bpf == NULL) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Failed to load BPF filter: %s",
+					    rte_strerror(rte_errno));
+			rte_free(mirror);
+			return -EINVAL;
+		}
+
+	}
+#endif
+
+	mirror->next = *top;
+
+	rte_atomic_store_explicit(top, mirror, rte_memory_order_relaxed);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_add_mirror, 25.11)
+int
+rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *conf)
+{
+#ifndef RTE_ETHDEV_MIRROR
+	return -ENOTSUP;
+#endif
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+	struct rte_eth_dev_info dev_info;
+
+	if (conf == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Missing configuration information");
+		return -EINVAL;
+	}
+
+	if (conf->mp == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "not a valid mempool");
+		return -EINVAL;
+	}
+
+	if (conf->flags & ~(RTE_ETH_MIRROR_DIRECTION_MASK | RTE_ETH_MIRROR_FLAG_MASK)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "unsupported flags");
+		return -EINVAL;
+	}
+
+	if ((conf->flags & RTE_ETH_MIRROR_DIRECTION_MASK) == 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "missing direction ingress or egress");
+		return -EINVAL;
+	}
+
+	/* Checks that target exists */
+	int ret = rte_eth_dev_info_get(conf->target, &dev_info);
+	if (ret != 0)
+		return ret;
+
+	/* Loopback mirror could create packet storm */
+	if (conf->target == port_id) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot mirror port to self");
+		return -EINVAL;
+	}
+
+	/*
+	 * Multiple directions and multiple queues can be mirrored to a single port.
+	 * This will cause multiple threads to be transmitting on the same queue.
+	 * Therefore device needs to support lockfree transmit.
+	 */
+	if (!(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Mirror needs lockfree transmit");
+		return -ENOTSUP;
+	}
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		/* Register dynamic fields once */
+		if (mirror_origin_offset < 0) {
+			ret = ethdev_dyn_mirror_register();
+			if (ret < 0)
+				return ret;
+		}
+
+		rte_spinlock_lock(&mirror_port_lock);
+		ret = 0;
+
+		if (conf->flags & RTE_ETH_MIRROR_DIRECTION_INGRESS)
+			ret = ethdev_insert_mirror(&dev->rx_mirror, conf);
+		if (ret == 0 && (conf->flags & RTE_ETH_MIRROR_DIRECTION_EGRESS))
+			ret = ethdev_insert_mirror(&dev->tx_mirror, conf);
+		rte_spinlock_unlock(&mirror_port_lock);
+	} else {
+		/* in secondary, proxy to primary */
+		ret = ethdev_request(port_id, ETH_REQ_ADD_MIRROR, conf, sizeof(*conf));
+		if (ret != 0)
+			return ret;
+	}
+
+	rte_eth_trace_add_mirror(port_id, conf, ret);
+	return ret;
+}
+
+static struct rte_eth_mirror *
+ethdev_find_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint16_t target_id)
+{
+
+	for (;;) {
+		struct rte_eth_mirror *mirror
+			= rte_atomic_load_explicit(head, rte_memory_order_relaxed);
+		if (mirror == NULL)
+			return NULL;	/* reached end of list */
+
+		if (mirror->target == target_id)
+			return mirror;
+
+		head = &mirror->next;
+	}
+}
+
+static bool
+ethdev_delete_mirror(RTE_ATOMIC(struct rte_eth_mirror *) *top, uint16_t target_id)
+{
+	struct rte_eth_mirror *mirror;
+
+	mirror = ethdev_find_mirror(top, target_id);
+	if (mirror == NULL)
+		return false;
+
+	/* unlink from list */
+	rte_atomic_store_explicit(top, mirror->next, rte_memory_order_relaxed);
+
+	/*
+	 * Defer freeing the mirror until after one second to allow for active threads
+	 * that are using it. Assumes no PMD takes more than one second to transmit a burst.
+	 * Alternative would be RCU, but RCU in DPDK is optional and requires application changes.
+	 */
+	rte_eal_alarm_set(US_PER_S, rte_free, mirror);
+	return true;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_remove_mirror, 25.11)
+int
+rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id)
+{
+#ifndef RTE_ETHDEV_MIRROR
+	return -ENOTSUP;
+#endif
+	int ret = 0;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
+
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		bool found;
+
+		rte_spinlock_lock(&mirror_port_lock);
+		found = ethdev_delete_mirror(&dev->rx_mirror, target_id);
+		found |= ethdev_delete_mirror(&dev->tx_mirror, target_id);
+		rte_spinlock_unlock(&mirror_port_lock);
+		if (!found)
+			ret = -ENOENT; /* no mirror present */
+	} else {
+		ret = ethdev_request(port_id, ETH_REQ_REMOVE_MIRROR,
+				     &target_id, sizeof(target_id));
+	}
+
+	rte_eth_trace_remove_mirror(port_id, target_id, ret);
+	return ret;
+}
+
+static inline void
+eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,
+	       struct rte_mbuf **pkts, uint16_t nb_pkts,
+	       struct rte_eth_mirror *mirror)
+{
+	struct rte_mbuf *tosend[RTE_MIRROR_BURST_SIZE];
+	unsigned int count = 0;
+
+#ifdef RTE_LIB_BPF
+	uint64_t rcs[RTE_MIRROR_BURST_SIZE];
+	if (mirror->bpf)
+		rte_bpf_exec_burst(mirror->bpf, (void **)pkts, rcs, nb_pkts);
+#endif
+
+	for (unsigned int i = 0; i < nb_pkts; i++) {
+#ifdef RTE_LIB_BPF
+		/*
+		 * This uses same BPF return value convention as socket filter
+		 * and pcap_offline_filter. If program returns zero
+		 * then packet doesn't match the filter (will be ignored).
+		 */
+		if (mirror->bpf && rcs[i] == 0) {
+			++mirror->stats.filtered;
+			continue;
+		}
+#endif
+
+		struct rte_mbuf *m = pkts[i];
+		struct rte_mbuf *mc = rte_pktmbuf_copy(m, mirror->mp, 0, mirror->snaplen);
+		if (unlikely(mc == NULL)) {
+			++mirror->stats.nombuf;
+			continue;
+		}
+
+		/* Put info about origin of the packet */
+		if (mirror->flags & RTE_ETH_MIRROR_ORIGIN_FLAG) {
+			struct rte_mbuf_origin *origin
+				= RTE_MBUF_DYNFIELD(mc, mirror_origin_offset, rte_mbuf_origin_t *);
+			origin->original_len = m->pkt_len;
+			origin->port_id = port_id;
+			origin->queue_id = queue_id;
+			mc->ol_flags |= mirror_origin_flag;
+		}
+
+		/* Insert timestamp into packet */
+		if (mirror->flags & RTE_ETH_MIRROR_TIMESTAMP_FLAG) {
+			*RTE_MBUF_DYNFIELD(m, mbuf_timestamp_offset, rte_mbuf_timestamp_t *)
+				= rte_get_tsc_cycles();
+			mc->ol_flags |= mbuf_timestamp_dynflag;
+		}
+
+		mc->ol_flags &= ~(mirror_ingress_flag | mirror_egress_flag);
+		if (direction & RTE_ETH_MIRROR_DIRECTION_INGRESS)
+			mc->ol_flags |= mirror_ingress_flag;
+		else if (direction & RTE_ETH_MIRROR_DIRECTION_EGRESS)
+			mc->ol_flags |= mirror_egress_flag;
+
+		tosend[count++] = mc;
+	}
+
+	uint16_t nsent = rte_eth_tx_burst(mirror->target, 0, tosend, count);
+	mirror->stats.packets += nsent;
+
+	if (unlikely(nsent < count)) {
+		uint16_t drop = count - nsent;
+
+		mirror->stats.full += drop;
+		rte_pktmbuf_free_bulk(pkts + nsent, drop);
+	}
+}
+
+/* This function is really internal but used from inline */
+RTE_EXPORT_SYMBOL(rte_eth_mirror_burst)
+void
+rte_eth_mirror_burst(uint16_t port_id, uint16_t queue_id, uint8_t direction,
+		     struct rte_mbuf **pkts, uint16_t nb_pkts,
+		     struct rte_eth_mirror *mirror)
+{
+
+	while (mirror != NULL) {
+		for (uint16_t i = 0; i < nb_pkts; i += RTE_MIRROR_BURST_SIZE) {
+			uint16_t burst = RTE_MIN(nb_pkts - i, RTE_MIRROR_BURST_SIZE);
+
+			eth_dev_mirror(port_id, queue_id, direction,
+				       pkts + i, burst, mirror);
+		}
+
+		mirror = rte_atomic_load_explicit(&mirror->next, rte_memory_order_relaxed);
+	}
+}
+
+static int
+ethdev_mirror_stats_get(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint16_t target_id,
+			struct rte_eth_mirror_stats *stats)
+{
+	const struct rte_eth_mirror *mirror;
+
+	mirror = ethdev_find_mirror(head, target_id);
+	if (mirror == NULL)
+		return -1;
+
+	stats->packets += mirror->stats.packets;
+	stats->nombuf += mirror->stats.nombuf;
+	stats->full += mirror->stats.full;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_mirror_stats_get, 25.11)
+int
+rte_eth_mirror_stats_get(uint16_t port_id, uint16_t target_id,
+			 struct rte_eth_mirror_stats *stats)
+{
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
+
+	if (stats == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Mirror port stats is NULL");
+		return -EINVAL;
+	}
+
+	memset(stats, 0, sizeof(*stats));
+
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+	int rx_ret = ethdev_mirror_stats_get(&dev->rx_mirror, target_id, stats);
+	int tx_ret = ethdev_mirror_stats_get(&dev->tx_mirror, target_id, stats);
+
+	/* if rx or tx mirror is valid return 0 */
+	return (tx_ret == 0 || rx_ret == 0) ? 0 : -ENOENT;
+}
+
+static int
+ethdev_mirror_stats_reset(RTE_ATOMIC(struct rte_eth_mirror *) *head, uint16_t target_id)
+{
+	struct rte_eth_mirror *mirror;
+
+	mirror = ethdev_find_mirror(head, target_id);
+	if (mirror == NULL)
+		return -1;
+
+	memset(&mirror->stats, 0, sizeof(struct rte_eth_mirror_stats));
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_mirror_stats_reset, 25.11)
+int
+rte_eth_mirror_stats_reset(uint16_t port_id, uint16_t target_id)
+{
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
+
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+	int rx_ret = ethdev_mirror_stats_reset(&dev->rx_mirror, target_id);
+	int tx_ret = ethdev_mirror_stats_reset(&dev->tx_mirror, target_id);
+
+	/* if rx or tx mirror is valid return 0 */
+	return (tx_ret == 0 || rx_ret == 0) ? 0 : -ENOENT;
+
+}
diff --git a/lib/ethdev/rte_mirror.h b/lib/ethdev/rte_mirror.h
new file mode 100644
index 0000000000..91bc2f9348
--- /dev/null
+++ b/lib/ethdev/rte_mirror.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#ifndef RTE_MIRROR_H_
+#define RTE_MIRROR_H_
+
+/**
+ * @file
+ * Ethdev port mirroring
+ *
+ * This interface provides the ability to duplicate packets to another port.
+ */
+
+#include <stdint.h>
+
+#include <rte_compat.h>
+#include <rte_mbuf.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* Definitions for ethdev mirror flags */
+#define RTE_ETH_MIRROR_DIRECTION_INGRESS 1
+#define RTE_ETH_MIRROR_DIRECTION_EGRESS 2
+#define RTE_ETH_MIRROR_DIRECTION_MASK (RTE_ETH_MIRROR_DIRECTION_INGRESS | \
+				       RTE_ETH_MIRROR_DIRECTION_EGRESS)
+
+#define RTE_ETH_MIRROR_TIMESTAMP_FLAG 4	/**< insert timestamp into mirrored packet */
+#define RTE_ETH_MIRROR_ORIGIN_FLAG    8	/**< insert rte_mbuf_origin into mirrored packet */
+
+#define RTE_ETH_MIRROR_FLAG_MASK      (RTE_ETH_MIRROR_TIMESTAMP_FLAG | \
+				       RTE_ETH_MIRROR_ORIGIN_FLAG)
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ *
+ * This dynamic field is added to mbuf's when they are copied to
+ * the port mirror.
+ */
+typedef struct rte_mbuf_origin {
+	uint32_t original_len;	/**< Packet length before copy */
+	uint16_t port_id;	/**< Port where packet originated */
+	uint16_t queue_id;      /**< Queue used for Tx or Rx */
+} rte_mbuf_origin_t;
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ *
+ * Structure used to configure ethdev Switched Port Analyzer (MIRROR)
+ */
+struct rte_bpf_prm;
+struct rte_eth_mirror_conf {
+	struct rte_mempool *mp;	/**< Memory pool for copies, If NULL then cloned. */
+	struct rte_bpf_prm *filter; /**< Optional packet filter */
+	uint32_t snaplen;	/**< Upper limit on number of bytes to copy */
+	uint32_t flags;		/**< bitmask of RTE_ETH_MIRROR_XXX_FLAG's */
+	uint16_t target;	/**< Destination port */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ *
+ * Structure returned by rte_mirror_stats.
+ */
+struct rte_eth_mirror_stats {
+	uint64_t packets;	/**< Number of mirrored packets. */
+	uint64_t filtered;	/**< Packets filtered by BPF program */
+	uint64_t nombuf;	/**< Rx mbuf allocation failures. */
+	uint64_t full;		/**< Target port transmit full. */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Create a Switched Port Analyzer (MIRROR) instance.
+ *
+ * @param port_id
+ *   The port identifier of the source Ethernet device.
+ * @param conf
+ *   Settings for this MIRROR instance.
+ * @return
+ *   Negative errno value on error, 0 on success.
+ */
+__rte_experimental
+int
+rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *conf);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Break port existing port mirroring.
+ * After this call no more packets will be sent from origin port to the target port.
+ *
+ * @param port_id
+ *   The port identifier of the source Ethernet device.
+ * @param target_id
+ *   The identifier of the destination port.
+ * @return
+ *   Negative errno value on error, 0 on success.
+ */
+__rte_experimental
+int rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Query statistics for a mirror.
+ *
+ * @param port_id
+ *   The port identifier of the source Ethernet device.
+ * @param target_id
+ *   The identifier of the destination port.
+ * @param stats
+ *   A pointer to a structure of type *rte_eth_mirror_stats* to be filled.
+ *
+ * @return
+ *   Negative errno value on error, 0 on success.
+ */
+__rte_experimental
+int rte_eth_mirror_stats_get(uint16_t port_id, uint16_t target_id,
+			     struct rte_eth_mirror_stats *stats);
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Reset statistics for mirror.
+ *
+ * @param port_id
+ *   The port identifier of the source Ethernet device.
+ * @param target_id
+ *   The identifier of the destination port.
+ */
+__rte_experimental
+int rte_eth_mirror_stats_reset(uint16_t port_id, uint16_t target_id);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* RTE_MIRROR_H_ */
-- 
2.47.2


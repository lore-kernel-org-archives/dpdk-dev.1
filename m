Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0AC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:37:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CED740A89;
	Tue, 22 Jul 2025 19:36:13 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8403E40B92
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:10 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7e623a12701so128139185a.2
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205770;
 x=1753810570; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWY4ubhRzBh5wU/02jAu9d3rkqTUzYRq201RRvrDv60=;
 b=QYJ7LBdS5Vdrf7XNI79VBNhfauP3DpMu7dSXoReyy5dXeMLngSQk5xg/fpdCuKk80P
 hA3hx8zxhGKip0c9kG05ruk0v895d76C3psY+A5U+RkoAiewwXDbtu1bGCDuKwR7zbz2
 ZefpIZ8wlRzqHWC3ApmCz+vtTk4aW6f3xx1Wi407pMrKigSXwrQYT0SiQqV2HkmLAOoT
 jIq3/ijlypRwSUe/UIMi+cnq5AbuFpNASssmzEej90H9qq/HumGE9wAW/0gpNiTsktXj
 /RbV9nYZZptHF0uzbkk8ZtQU2BjyRVXtCnmmRcKo/luA26E9vTDl54jWM7E6BQfeq0xF
 ZcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205770; x=1753810570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWY4ubhRzBh5wU/02jAu9d3rkqTUzYRq201RRvrDv60=;
 b=EesC/k/iYeFu9MRTPE2t7oThCgQZAMKtYP90rebcivOqoQRdf/x7wgcLWlj1O1gWAH
 zhcj4CJ6JYBw3NdGbGqQK4+kNbX/VmCBtNeVXv6wg+bCS0wUOZYwoYSQcqZ9Veme+IeC
 7rStb+GC06UvS0xf0v3W43DUZqr5aCgdx6+VemXIxP52fl7CckKtpxQLGMtKnxhxiL2x
 ngrzpVqpClJPoeepKiyQx1rEUOm0TQnb5Avupp5bbbmZ3W3H64XxutNNf/JPuVOItCDy
 yo2D0MfyZ47a3C2WrFlH0vmjUyyglJt8flnd68XPYEm6XwJO+t1N1IPYJr+fO2b7Tczc
 1csg==
X-Gm-Message-State: AOJu0Yx0OE+xWzbiTG4/BzvNVAFrQUdBLP6IMgMGXLqMGHqF8ZSLB5VX
 r3nTTqrtWtVK3DA6+4ttrOaOfWI5oBJU/5r/7htbnCaAd24YR4RNKsEB9sriATBPSTolYmhr5w/
 XRIBb
X-Gm-Gg: ASbGncv6fxjTExJpK6qrQrYkcKhCGJSOi0onPCZE183f8O/Go3gKZB1CVpOSM4kubrJ
 ajEqXRK4Bp5BBLPxW4Np61aBT3DvQaihQrngRkPxQYHXRX5y9mvrjdn8VZjJQw//Rx8fKrOWSNx
 c+N2DcrxpxpJFJQd737E7RPt197F2PoUhERN1HH9B/UJXDG666D5KIFwN6wIglryBh/AAbwUZFO
 zuEMyGPixt7OQ9yRLMwV2+JNwW6t3h/eWjRREBNFvn7HlP7XBKQw9Oj38lYjcKRZYx/la5mTkaA
 s4mWBw0jpcSHJtUFnCmJuHBYwe+Iafxrb7T76zOZgLLQhQTS7qhFQpeXP8GmyePBiKhlbCYH2yD
 8A0Gnk6EGzvGbPt54DY6GJht2W6laXCYTrDpBnPOEDgL2+YcN1J9rKkgGoLrgNqN/o2srlEqYeT
 u6WRwHzj0=
X-Google-Smtp-Source: AGHT+IGGG62eB18utv6rU8s8dkEMAtuIFj0l8o/Z0KGWigfhh2duF87ei9CYtgR/2b5fy9u2vU9rrw==
X-Received: by 2002:a05:620a:7001:b0:7e3:4416:1035 with SMTP id
 af79cd13be357-7e62a1a1cf7mr13130485a.62.1753205769664; 
 Tue, 22 Jul 2025 10:36:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:36:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v6 10/13] test: add tests for ethdev mirror
Date: Tue, 22 Jul 2025 10:34:41 -0700
Message-ID: <20250722173552.184141-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
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

Simple API and packet mirroring standalone tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build          |   1 +
 app/test/test_ethdev_mirror.c | 286 ++++++++++++++++++++++++++++++++++
 2 files changed, 287 insertions(+)
 create mode 100644 app/test/test_ethdev_mirror.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d38f51918..07bc00148d 100644
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
index 0000000000..2833e25d66
--- /dev/null
+++ b/app/test/test_ethdev_mirror.c
@@ -0,0 +1,286 @@
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
+		.direction = RTE_ETH_MIRROR_DIRECTION_EGRESS,
+	};
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
+	conf.direction = 0;
+	conf.target = ring_port;
+	ret = rte_eth_add_mirror(null_port, &conf);
+	TEST_ASSERT(ret != 0, "Created mirror with invalid direction");
+
+	conf.direction = RTE_ETH_MIRROR_DIRECTION_INGRESS;
+	conf.target = ring_port;
+	ret = rte_eth_add_mirror(ring_port, &conf);
+	TEST_ASSERT(ret != 0, "Created mirror to self");
+
+	conf.target = null_port;
+	ret = rte_eth_add_mirror(ring_port, &conf);
+	TEST_ASSERT(ret == 0, "Could not create mirror from ring to null");
+
+	ret = rte_eth_add_mirror(ring_port, &conf);
+	TEST_ASSERT(ret != 0, "Able to create duplicate mirror");
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
+		.direction = RTE_ETH_MIRROR_DIRECTION_EGRESS,
+	};
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
+	return unit_test_suite_runner(&ethdev_mirror_suite);
+}
+
+REGISTER_FAST_TEST(ethdev_mirror, true, true, test_ethdev_mirror);
-- 
2.47.2


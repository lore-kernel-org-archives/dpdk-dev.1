Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4394CCFA00
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 16:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3D7F40668;
	Fri, 31 Oct 2025 17:44:27 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5D25440661
 for <dev@dpdk.org>; Fri, 31 Oct 2025 17:44:25 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so31235145ad.0
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761929064;
 x=1762533864; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcVZLwygaXhiI+anj2MjuHkbYgEhWXW+OFSDWMCMaTw=;
 b=hRbLBXDIgb/cT4FZUJ5yxvsm4QOPlXmGWYsswzr0nPapyjRjQREi3UmHLmm0g0IVbq
 B7FYPxd6OZ0DnrmRXobVRxoh79vuEN+2/RNB82Wprvx3e1qUwSm/rxje6c/jWovQsarp
 aAbUqMh2ZPwEHQfsnHjNXkNqUil+j2U6IKMushnwCqZS9TeIkpZG+EAXHn4JaMI4Tphf
 +nvETMZJuzQpp7597iuwviHAkwDxyocIoZyV/miCD8ds1teFdcT6kw9WdtYPHvn187jr
 s142oZZD0PquxyUSMKrOmmUVmppH9LeOeyxnTI2/DFZJRKS9izDXpySUP2ldsiQWGClL
 Ygvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929064; x=1762533864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcVZLwygaXhiI+anj2MjuHkbYgEhWXW+OFSDWMCMaTw=;
 b=C7vLU5mBW6Gtk9nzhg3BSlzGB3Hiu7VCuhUEmPUuGojdqHZT+KaT3VWTV0fJD8Xphc
 MHjGuJTUcjai0TBqufEioP0Klwf2lV72+3jUVv//CLqlcno0l3r6Jye3YLeS6lToXILz
 L0RaaRa2hs/LroYN276y63ZgnKPlgYsmLQm6JM3Mqij7iIT1dOIOfdr6/+CFum2Dn4M2
 mk2gqHBMoHDmpyteCR25BQDKN9P1Q6lTCytoLRXr54zio2FLe83d0/9kKt+avbi0xRXo
 LAkgkncCT+uMMpYG83JEQKHUxcP927wamBqS0qBCH9e7kBVK+kVBIulB/aa50x4b46IO
 oV2g==
X-Gm-Message-State: AOJu0YwbeafrPbQ9u3NHWtMan+hMR5tQna/jnRxv1KUFf0ifpgvHUolN
 nG8zAKQfHweiLsUrBLlo/Yfj/RUJ80zLXn9lHPqdWm5/YmDsSXLKHmdEtweNjDNorOmpRNVz7cQ
 m38jq
X-Gm-Gg: ASbGncvuSDzXFHidYMNoeUThigpj7EBXV66JG3FHGVJHof+3xzXtkVgec9+EvSuQHY0
 50IUWWKGeic5tEmWOh1xUzF7qZycZ57/7ellfGwpf4MlZV90RPRI4j/VTgNPK25d5Fe9k0Hrspd
 tnGPpuEt0Q3Tc1tuRl7ZjU1oFgbgtEHrx55DzfVIK+3APRtqCwJrb2T0KbDI3sB7AAUsnlgK+bz
 U7BDzZiJA0OQQ2Uo/nypzxojqqFh/6Tg5xpslo5Lh9uhx0mBxMSwuHOoSm1FrvEt2b7nKlun+Y+
 7Pg2Gy/JjPu/V+Qqa3/Yw+o4QwrXWTBPD5D/fJXV4TpKZ+79Xlp41nKZFTSh5/3FxFUYajyrjZC
 h/d2NeGJPhfncYzbjpDGRjojuw6XJwoF1S2MAjwolrsqvx7bH/cBv1667jxzvSqFcSSmxPRU5yH
 LfriItNxSFRMlOixyFLJ9+7mjABxhXyMrKuVLpWQM=
X-Google-Smtp-Source: AGHT+IF5hKbPzpPbmkV2tR63ztXaXnv6D39UulPif8biYWCBJcLK6UpnLYHxFap8O0TitgsLD25GQQ==
X-Received: by 2002:a17:903:24f:b0:295:24c3:8b49 with SMTP id
 d9443c01a7336-29524c38fcdmr39355535ad.46.1761929064399; 
 Fri, 31 Oct 2025 09:44:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269a8ddcsm28391845ad.91.2025.10.31.09.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:44:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 4/5] bpf: add test for Rx and Tx filtering
Date: Fri, 31 Oct 2025 09:41:48 -0700
Message-ID: <20251031164417.14166-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031164417.14166-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251031164417.14166-1-stephen@networkplumber.org>
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

New test using null device to test filtering with BPF.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Note: the BPF source will generate some false positives from checkpatch
because it is not regular DPDK source, and must not use DPDK macros.

 app/test/bpf/meson.build       |   3 +-
 app/test/bpf/test_bpf_filter.c |  53 ++++++
 app/test/test_bpf.c            | 306 +++++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 app/test/bpf/test_bpf_filter.c

diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
index 2b944f5ea9..be7c643b41 100644
--- a/app/test/bpf/meson.build
+++ b/app/test/bpf/meson.build
@@ -31,7 +31,8 @@ cflags += '-DTEST_BPF_ELF_LOAD'
 
 # BPF sources to compile
 test_bpf_progs = [
-    'test_bpf_load'
+    'test_bpf_load',
+    'test_bpf_filter',
 ]
 
 foreach test_name : test_bpf_progs
diff --git a/app/test/bpf/test_bpf_filter.c b/app/test/bpf/test_bpf_filter.c
new file mode 100644
index 0000000000..d47233a47a
--- /dev/null
+++ b/app/test/bpf/test_bpf_filter.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * BPF TX filter program for testing rte_bpf_eth_tx_elf_load
+ */
+
+typedef unsigned char uint8_t;
+typedef unsigned short uint16_t;
+typedef unsigned int uint32_t;
+typedef unsigned long uint64_t;
+
+/*
+ * Simple TX filter that accepts TCP packets
+ *
+ * BPF TX programs receive pointer to data and should return:
+ *   0 = drop packet
+ *   non-zero = rx/tx packet
+ *
+ * This filter checks:
+ * 1. Packet is IPv4
+ * 2. Protocol is TCP (IPPROTO_TCP = 6)
+ */
+__attribute__((section("filter"), used))
+uint64_t
+test_filter(void *pkt)
+{
+	uint8_t *data = pkt;
+
+	/* Read version and IHL (first byte of IP header) */
+	uint8_t version_ihl = data[14];
+
+	/* Check IPv4 version (upper 4 bits should be 4) */
+	if ((version_ihl >> 4) != 4)
+		return 0;
+
+	/* Protocol field (byte 9 of IP header) must be TCP (6) */
+	uint8_t proto = data[14 + 9];
+	return (proto == 6);
+}
+
+__attribute__((section("drop"), used))
+uint64_t
+test_drop(void *pkt)
+{
+	(void)pkt;
+	return 0;
+}
+
+__attribute__((section("allow"), used))
+uint64_t
+test_allow(void *pkt)
+{
+	(void)pkt;
+	return 1;
+}
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 855fdc8ad1..2b34f4986d 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -16,6 +16,12 @@
 #include <rte_byteorder.h>
 #include <rte_errno.h>
 #include <rte_bpf.h>
+#include <rte_ethdev.h>
+#include <rte_bpf_ethdev.h>
+#include <rte_bus_vdev.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_tcp.h>
 
 #include "test.h"
 
@@ -3411,6 +3417,290 @@ test_bpf_elf_load(void)
 	printf("%s: ELF load test passed\n", __func__);
 	return TEST_SUCCESS;
 }
+
+#include "test_bpf_filter.h"
+
+#define BPF_TEST_BURST		128
+#define BPF_TEST_POOLSIZE	256 /* at least 2x burst */
+#define BPF_TEST_PKT_LEN	64 /* Ether + IP + TCP */
+
+static int null_vdev_setup(const char *name, uint16_t *port, struct rte_mempool *pool)
+{
+	int ret;
+
+	/* Make a null device */
+	ret = rte_vdev_init(name, NULL);
+	TEST_ASSERT(ret == 0, "rte_vdev_init(%s) failed: %d", name, ret);
+
+	ret = rte_eth_dev_get_port_by_name(name, port);
+	TEST_ASSERT(ret == 0, "failed to get port id for %s: %d", name, ret);
+
+	struct rte_eth_conf conf = { };
+	ret = rte_eth_dev_configure(*port, 1, 1, &conf);
+	TEST_ASSERT(ret == 0, "failed to configure port %u: %d", *port, ret);
+
+	struct rte_eth_txconf txconf = { };
+	ret = rte_eth_tx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY, &txconf);
+	TEST_ASSERT(ret == 0, "failed to setup tx queue port %u: %d", *port, ret);
+
+	struct rte_eth_rxconf rxconf = { };
+	ret = rte_eth_rx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY,
+				     &rxconf, pool);
+	TEST_ASSERT(ret == 0, "failed to setup rx queue port %u: %d", *port, ret);
+
+	ret = rte_eth_dev_start(*port);
+	TEST_ASSERT(ret == 0, "failed to start port %u: %d", *port, ret);
+
+	return 0;
+}
+
+static unsigned int
+setup_mbufs(struct rte_mbuf *burst[], unsigned int n)
+{
+	struct rte_ether_hdr eh = {
+		.ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
+	};
+	const struct rte_ipv4_hdr iph = {
+		.version_ihl = RTE_IPV4_VHL_DEF,
+		.total_length = rte_cpu_to_be_16(BPF_TEST_PKT_LEN - sizeof(eh)),
+		.time_to_live = IPDEFTTL,
+		.src_addr = rte_cpu_to_be_32(ip_src_addr),
+		.dst_addr = rte_cpu_to_be_32(ip_dst_addr),
+	};
+	unsigned int tcp_count = 0;
+
+	rte_eth_random_addr(eh.dst_addr.addr_bytes);
+
+	for (unsigned int i = 0; i < n; i++) {
+		struct rte_mbuf *mb = burst[i];
+
+		/* Setup Ethernet header */
+		*rte_pktmbuf_mtod(mb, struct rte_ether_hdr *) = eh;
+
+		/* Setup IP header */
+		struct rte_ipv4_hdr *ip
+			= rte_pktmbuf_mtod_offset(mb, struct rte_ipv4_hdr *, sizeof(eh));
+		*ip = iph;
+
+		if (rte_rand() & 1) {
+			struct rte_udp_hdr *udp
+				= rte_pktmbuf_mtod_offset(mb, struct rte_udp_hdr *,
+							  sizeof(eh) + sizeof(iph));
+
+			ip->next_proto_id = IPPROTO_UDP;
+			*udp = (struct rte_udp_hdr) {
+				.src_port = rte_cpu_to_be_16(9),	/* discard */
+				.dst_port = rte_cpu_to_be_16(9),	/* discard */
+				.dgram_len = BPF_TEST_PKT_LEN - sizeof(eh) - sizeof(iph),
+			};
+
+		} else {
+			struct rte_tcp_hdr *tcp
+				= rte_pktmbuf_mtod_offset(mb, struct rte_tcp_hdr *,
+							  sizeof(eh) + sizeof(iph));
+
+			ip->next_proto_id = IPPROTO_TCP;
+			*tcp = (struct rte_tcp_hdr) {
+				.src_port = rte_cpu_to_be_16(9),	/* discard */
+				.dst_port = rte_cpu_to_be_16(9),	/* discard */
+				.tcp_flags = RTE_TCP_RST_FLAG,
+			};
+			++tcp_count;
+		}
+	}
+
+	return tcp_count;
+}
+
+static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_mempool *pool,
+		       const char *fname, uint32_t flags)
+{
+	const struct rte_bpf_prm prm = {
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR,
+			.size = sizeof(struct rte_mbuf),
+		},
+	};
+	int ret;
+
+	struct rte_mbuf *pkts[BPF_TEST_BURST] = { };
+	ret = rte_pktmbuf_alloc_bulk(pool, pkts, BPF_TEST_BURST);
+	TEST_ASSERT(ret == 0, "failed to allocate mbufs");
+
+	uint16_t expect = setup_mbufs(pkts, BPF_TEST_BURST);
+
+	/* Try to load BPF TX program from temp file */
+	ret = rte_bpf_eth_tx_elf_load(port, 0, &prm, tmpfile, fname, flags);
+	TEST_ASSERT(ret == 0, "failed to load BPF filter from temp file %s: %d",
+		    tmpfile, ret);
+
+	uint16_t sent = rte_eth_tx_burst(port, 0, pkts, BPF_TEST_BURST);
+	TEST_ASSERT_EQUAL(sent, expect, "rte_eth_tx_burst returned: %u expected %u",
+			  sent, expect);
+
+	/* The unsent packets should be dropped */
+	rte_pktmbuf_free_bulk(pkts + sent, BPF_TEST_BURST - sent);
+
+	/* Pool should have same number of packets avail */
+	unsigned int avail = rte_mempool_avail_count(pool);
+	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
+			  "Mempool available %u != %u leaks?", avail, BPF_TEST_POOLSIZE);
+
+	rte_bpf_eth_tx_unload(port, 0);
+	return TEST_SUCCESS;
+}
+
+static int
+test_bpf_elf_tx_load(void)
+{
+	static const char null_dev[] = "net_null_bpf0";
+	char *tmpfile = NULL;
+	struct rte_mempool *mb_pool = NULL;
+	uint16_t port = UINT16_MAX;
+	int ret;
+
+	printf("%s start\n", __func__);
+
+	/* Make a pool for packets */
+	mb_pool = rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSIZE,
+					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
+					  SOCKET_ID_ANY);
+
+	ret = null_vdev_setup(null_dev, &port, mb_pool);
+	if (ret != 0)
+		goto fail;
+
+	/* Create temp file from embedded BPF object */
+	tmpfile = create_temp_bpf_file(test_bpf_filter_data,
+				       test_bpf_filter_data_len, "tx");
+	if (tmpfile == NULL)
+		goto fail;
+
+	/* Do test with VM */
+	ret = bpf_tx_test(port, tmpfile, mb_pool, "filter", 0);
+	if (ret != 0)
+		goto fail;
+
+	/* Repeat with JIT */
+	ret = bpf_tx_test(port, tmpfile, mb_pool, "filter", RTE_BPF_ETH_F_JIT);
+	if (ret == 0)
+		printf("%s: TX ELF load test passed\n", __func__);
+
+fail:
+	if (tmpfile) {
+		unlink(tmpfile);
+		free(tmpfile);
+	}
+
+	if (port != UINT16_MAX)
+		rte_vdev_uninit(null_dev);
+
+	rte_mempool_free(mb_pool);
+
+	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
+}
+
+static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_mempool *pool,
+		       const char *fname, uint32_t flags, uint16_t expected)
+{
+	struct rte_mbuf *pkts[BPF_TEST_BURST];
+	const struct rte_bpf_prm prm = {
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR,
+			.size = sizeof(struct rte_mbuf),
+		},
+	};
+	int ret;
+
+	/* Load BPF program to drop all packets */
+	ret = rte_bpf_eth_rx_elf_load(port, 0, &prm, tmpfile, fname, flags);
+	TEST_ASSERT(ret == 0, "failed to load BPF filter from temp file %s: %d",
+		    tmpfile, ret);
+
+	uint16_t rcvd = rte_eth_rx_burst(port, 0, pkts, BPF_TEST_BURST);
+	TEST_ASSERT_EQUAL(rcvd, expected,
+			  "rte_eth_rx_burst returned: %u expect: %u", rcvd, expected);
+
+	/* Drop the received packets */
+	rte_pktmbuf_free_bulk(pkts, rcvd);
+
+	rte_bpf_eth_rx_unload(port, 0);
+
+	/* Pool should now be full */
+	unsigned int avail = rte_mempool_avail_count(pool);
+	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
+			  "Mempool available %u != %u leaks?", avail, BPF_TEST_POOLSIZE);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_bpf_elf_rx_load(void)
+{
+	static const char null_dev[] = "net_null_bpf0";
+	struct rte_mempool *pool = NULL;
+	char *tmpfile = NULL;
+	uint16_t port;
+	int ret;
+
+	printf("%s start\n", __func__);
+
+	/* Make a pool for packets */
+	pool = rte_pktmbuf_pool_create("bpf_rx_test_pool", 2 * BPF_TEST_BURST,
+					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
+					  SOCKET_ID_ANY);
+	TEST_ASSERT(pool != NULL, "failed to create mempool");
+
+	ret = null_vdev_setup(null_dev, &port, pool);
+	if (ret != 0)
+		goto fail;
+
+	/* Create temp file from embedded BPF object */
+	tmpfile = create_temp_bpf_file(test_bpf_filter_data,
+				       test_bpf_filter_data_len, "tx");
+	if (tmpfile == NULL)
+		goto fail;
+
+	/* Do test with VM */
+	ret = bpf_rx_test(port, tmpfile, pool, "drop", 0, 0);
+	if (ret != 0)
+		goto fail;
+
+	/* Repeat with JIT */
+	ret = bpf_rx_test(port, tmpfile, pool, "drop", RTE_BPF_ETH_F_JIT, 0);
+	if (ret != 0)
+		goto fail;
+
+	/* Repeat with allow all */
+	ret = bpf_rx_test(port, tmpfile, pool, "allow", 0, BPF_TEST_BURST);
+	if (ret != 0)
+		goto fail;
+
+	/* Repeat with JIT */
+	ret = bpf_rx_test(port, tmpfile, pool, "allow", RTE_BPF_ETH_F_JIT, BPF_TEST_BURST);
+	if (ret != 0)
+		goto fail;
+
+	printf("%s: RX ELF load test passed\n", __func__);
+
+	/* The filter should free the mbufs */
+	unsigned int avail = rte_mempool_avail_count(pool);
+	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
+			  "Mempool available %u != %u leaks?", avail, BPF_TEST_POOLSIZE);
+
+fail:
+	if (tmpfile) {
+		unlink(tmpfile);
+		free(tmpfile);
+	}
+
+	if (port != UINT16_MAX)
+		rte_vdev_uninit(null_dev);
+
+	rte_mempool_free(pool);
+
+	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
+}
 #else
 
 static int
@@ -3420,9 +3710,25 @@ test_bpf_elf_load(void)
 	return TEST_SKIPPED;
 }
 
+static int
+test_bpf_elf_tx_load(void)
+{
+	printf("BPF compile not supported, skipping Tx test\n");
+	return TEST_SKIPPED;
+}
+
+static int
+test_bpf_elf_rx_load(void)
+{
+	printf("BPF compile not supported, skipping Tx test\n");
+	return TEST_SKIPPED;
+}
+
 #endif /* !TEST_BPF_ELF_LOAD */
 
 REGISTER_FAST_TEST(bpf_elf_load_autotest, true, true, test_bpf_elf_load);
+REGISTER_FAST_TEST(bpf_eth_tx_elf_load_autotest, true, true, test_bpf_elf_tx_load);
+REGISTER_FAST_TEST(bpf_eth_rx_elf_load_autotest, true, true, test_bpf_elf_rx_load);
 
 #ifndef RTE_HAS_LIBPCAP
 
-- 
2.51.0


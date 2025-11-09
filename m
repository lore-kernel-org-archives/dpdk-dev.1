Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11751CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 20:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5524D40608;
	Sun,  9 Nov 2025 21:09:07 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 49F18402DC
 for <dev@dpdk.org>; Sun,  9 Nov 2025 21:09:05 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3437af8444cso631376a91.2
 for <dev@dpdk.org>; Sun, 09 Nov 2025 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762718944;
 x=1763323744; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUfRZeD8cJCjyldSiMXoRP5z0KtPMV3AuoWU3gUDikw=;
 b=FMRmXqak4cyiLaQb8X3mjgz/KaOx8VYWUiVOmTxHA+Xa2xi0b5+My/94+NMOaGh8aU
 eI+cXR8qvvy1XqB/JS3u32xq6pPsu0c6KCKtBjHMeYa6rJGRNfQ9T5QkJygKxba0g/xQ
 tGOGGcWlX55CJAtNOv7wEtbujJj1sn9mF14qSyz4EsXut76bhjwunhB/uMgFRuKf1tMJ
 Us2enGi+gdgVjl+h38tOF71b6vur2hiFi8tL4PvFKw8KQayvgUIy5hwp2YkwmEH6VySF
 HRgRGKKC/NDj+9RivGueUo7KZD0r6YiEu2giOYw1SQZxEDdbhl+H2JRe47XcB6cJwCqs
 Os5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762718944; x=1763323744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WUfRZeD8cJCjyldSiMXoRP5z0KtPMV3AuoWU3gUDikw=;
 b=JjE7Kzf1CWR+w1nn6hyyV9Jqnu+mR3WIFt7eIeVbNbWPa03xYv0CtGxb+FAlJXkYJU
 onXuJQYb/LTodqYWwEhHDiwcSUj5fmHx64SlTU/ijJLVQOFR9hhgl+xsC7FSKQ6saC/J
 VYmC5GoZkhxvjPZr7N16dm/OUPyToLFQVbThA+kntMKz46Rmg/Hz87zlwFU+h40sMC6z
 fp2+zZEFGYUc5BZ5VSfTu96qLAhptZ88nYoBVtXMsZCNyl+K5yLKz+1vgM/Q070J1LzQ
 Ytg1iikR3e2tiqDQ56CqD+OI6KJcKceCLnnaTMIWLfHjuWFeLnC5lx5lfAvUTCrpj5wG
 spcQ==
X-Gm-Message-State: AOJu0YzR5vOCFJHbkKViE2e881qLbPrql3r3kcNFcvBwtdyrgD2wEXQN
 Bo0p1XOEh5QeVlBhn957yofiv51NolJffne35bO2ZHJGBEUNJbPL3JzytFEpcFzvjUXJugPcr7N
 +/lCnwwY=
X-Gm-Gg: ASbGncumpDxuKOB93yStopARaC0iAwlaVlYVs2bMiLB4DVl8fmgmooYsj9LdWxnU8fv
 I7upbPRbKPWOHyu8tded9tE5tujgKuPr1sBXaI+0UpF4A47EGU2UtOpwo7OJGgvc5MkyxLWXg7l
 A7aNYv1OL4MiKepbAqqoOBul23SJnppOI6rkvoOc6Eh0o779/NBGJWAvrN5E6QhkXJeXvsKOHs9
 rL2f6hU0B8ZBcA37+qRBdJkiSmJ5szG12JjYDxNxn4Blr2iewCDXLoUvXqoG5ExtB7pk0SrdqU7
 jnGO/d9mPZGUqHcir3stkZIFpg7OdpBhwQvI2nb7Luorq9GYyVBv9An4d+qJW4xOoGW8ktvwTTH
 WcYJ1y7DbI7JvsLlDxicsVx2OsKnCziisB9LDoTrbXeCWIkiG8QfBBJb257ZEi8EVW92lxFT+2r
 7pgrLWwwqqrt53AbMkUA0RLrOsNeIs9cZ5ay204Gf+qj1ZoOR59A==
X-Google-Smtp-Source: AGHT+IEIRerXzVfF8qjYNyC95tVcKIRkNQDHIIAt/tNyGyMgfqUL0TGTnZxf7lHeN+R16XLk6/LXNw==
X-Received: by 2002:a17:90b:564c:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-3436cd0ef06mr7948016a91.36.1762718944211; 
 Sun, 09 Nov 2025 12:09:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a699d6dfsm15396648a91.16.2025.11.09.12.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 12:09:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v5 4/5] bpf: add test for Rx and Tx filtering
Date: Sun,  9 Nov 2025 12:07:37 -0800
Message-ID: <20251109200854.45942-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109200854.45942-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
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
 app/test/bpf/filter.c    |  53 +++++++
 app/test/bpf/meson.build |   1 +
 app/test/test_bpf.c      | 307 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 app/test/bpf/filter.c

diff --git a/app/test/bpf/filter.c b/app/test/bpf/filter.c
new file mode 100644
index 0000000000..d47233a47a
--- /dev/null
+++ b/app/test/bpf/filter.c
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
diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
index b4f54aa976..19fec05521 100644
--- a/app/test/bpf/meson.build
+++ b/app/test/bpf/meson.build
@@ -32,6 +32,7 @@ cflags += '-DTEST_BPF_ELF_LOAD'
 # BPF sources to compile
 bpf_progs = {
     'load' : 'test_bpf_load',
+    'filter' : 'test_bpf_filter',
 }
 
 foreach bpf_src, bpf_hdr : bpf_progs
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index a80f41a543..24d18f9d33 100644
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
 
@@ -3421,6 +3427,291 @@ test_bpf_elf_load(void)
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
+		       const char *section, uint32_t flags)
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
+	ret = rte_bpf_eth_tx_elf_load(port, 0, &prm, tmpfile, section, flags);
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
+/* Test loading a transmit filter which only allows IPv4 packets */
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
+	tmpfile = create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "tx");
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
+/* Test loading a receive filter */
+static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_mempool *pool,
+		       const char *section, uint32_t flags, uint16_t expected)
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
+	ret = rte_bpf_eth_rx_elf_load(port, 0, &prm, tmpfile, section, flags);
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
+/* Test loading a receive filters, first with drop all and then with allow all packets */
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
+	tmpfile = create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "rx");
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
@@ -3430,9 +3721,25 @@ test_bpf_elf_load(void)
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


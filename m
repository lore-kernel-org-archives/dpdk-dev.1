Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB86D6CFA3
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 19:39:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37F44402D3;
	Thu, 22 Jan 2026 20:39:32 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 0A628402D3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:39:30 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso15788015e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769110770;
 x=1769715570; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c35tgyDyAMaIVt8IPejJ9n6/DlE86OJoc30Rwpq8+Ac=;
 b=DXLt3BPkWQfWZQRBVjmHLuguDBdQZ2EFJVLm6/SixC1ds4VmIwcwfcW05juynlKEgZ
 3Cz+Gb2KDkFP9myfzrKcggShhnyfSmmObRAU2U1jg8m728U3U/SbMTXxHOv7Cq5swQPz
 j8uG7aSLGbl9G3FFx1qqVhcwHCVFn+JLzW5YOsAwdUcvap8Rn+nzmXwDnZVTCsqLAzgp
 dt1JdYQ6nDcf6TMqv5YfHd+t5RyMR+hqmH9n3ORKqmF5FV6RZnB4ShmE+tlZKR2MSlPp
 fzPpk9KS998VmxdAggI7nn2+KNBMFeracOCCDpI9DVQnh678zLGn5vlUScfrhF86EamF
 VJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769110770; x=1769715570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c35tgyDyAMaIVt8IPejJ9n6/DlE86OJoc30Rwpq8+Ac=;
 b=u8s8eh6HbmbKOkRuGlhQnvtqJ1iRDWXH3T6kwvZ7EvROAxFtOu0AzUnAKrg6y+o9Cp
 XbnClxH49xZIFkjh2T93CwMqQSVEPl1R8OE+Q0Gs44c5BBgApvW8stq1RQDlT7queiV6
 JStsZyvq3rlO/lVxQwji/AFcY9pDOoIYByT9iRUfdS7+YoPY6VODQlNHHWkap6Ygu4ab
 26qLcN57hya7ySjfcDoeVSTVPXBYdnso1RqFS2gZdDAC3bmzo+RtCmdgf/zsUjdcemlx
 nJCHztnzv5TDufa5dmncufmbeB1wDFFSgk15WB8CyF1xeIwYhN4RG8LY9IGXMH1Yxqb2
 ExCg==
X-Gm-Message-State: AOJu0YwBJT6cfiTU/c6s2X5RufCIaa4AUknKx3K3UQ5ksuNS3yjUdXgw
 X1j/M/tQeqctbU45tGZJkgO9QgtQG8ASw8CnFNVbCnL5r4kbLg/Gq/I74xmnErpO49al24goLGp
 0Lnvn
X-Gm-Gg: AZuq6aJINuZ7TwO2Wrayw+8WToCAoZm+IfBY7JS6BPNEg1HhgBtRJ+0KwyCr9xnkCc5
 PlG3+JKpqTd9GgNJn3EJ5JX8+HnuWa4mFiAiGIeVCAtGsk7B5PpSB++/qTYPuKVD2WQZEco/6as
 dGniqpVanynyLsytz1DyvC0rSDBy8CPb6ojlP2VfFXpBKSCxEcsC+OLfoF+CAIr56ce0P62Faxo
 e/RQ8ZkCxiMxD0o9qRvDOJYk9ZU/PtogcNc7r3oOBFdqv3AVmDF4dt1ElWXOJr/pWD+2lUVNwFQ
 2IjP8GhOzwrIgGJ38jdova9hJ6i1VqmzeO8ICgR2nhiveCxzZSsikyoYCdDMbJBHlOQFJFaeFTd
 b5iRSlFQ4Q1HiT2w23o/8sZYGfO71dOhxclnohIVRMVj8X/lzeqHLQjEYSmda8f63NFWz4XyEGY
 Ak9VguIfCxvq8GVlT5WhJfsQmhbMKccO0lABSiFRn06suCNMfUjQ==
X-Received: by 2002:a05:600d:640f:10b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-4804d60ac94mr5194985e9.25.1769110770086; 
 Thu, 22 Jan 2026 11:39:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470474cbsm87508095e9.8.2026.01.22.11.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 11:39:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] test: split up BPF tests
Date: Thu, 22 Jan 2026 11:39:23 -0800
Message-ID: <20260122193923.49253-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The BPF tests have two sections. One is doing tests of the
BPF interpreter and the other is for testing the ELF load part.
The latter requires the null PMD to work, so only build it
present.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build    |   1 +
 app/test/test_bpf.c     | 475 ----------------------------------
 app/test/test_bpf_elf.c | 560 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 561 insertions(+), 475 deletions(-)
 create mode 100644 app/test/test_bpf_elf.c

diff --git a/app/test/meson.build b/app/test/meson.build
index f4d04a6e42..e01afeab8d 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -35,6 +35,7 @@ source_file_deps = {
     'test_bitset.c': [],
     'test_bitratestats.c': ['metrics', 'bitratestats', 'ethdev'] + sample_packet_forward_deps,
     'test_bpf.c': ['bpf', 'net'],
+    'test_bpf_elf.c': ['bpf', 'net_null'],
     'test_byteorder.c': [],
     'test_cfgfile.c': ['cfgfile'],
     'test_cksum.c': ['net'],
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index a7d56f8d86..6251a356d9 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -8,8 +8,6 @@
 #include <inttypes.h>
 #include <unistd.h>
 
-#include <rte_memory.h>
-#include <rte_debug.h>
 #include <rte_hexdump.h>
 #include <rte_malloc.h>
 #include <rte_random.h>
@@ -3280,479 +3278,6 @@ test_bpf(void)
 
 REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
 
-#ifdef TEST_BPF_ELF_LOAD
-
-/*
- * Helper function to write BPF object data to temporary file.
- * Returns temp file path on success, NULL on failure.
- * Caller must free the returned path and unlink the file.
- */
-static char *
-create_temp_bpf_file(const uint8_t *data, size_t size, const char *name)
-{
-	char *tmpfile = NULL;
-	int fd;
-	ssize_t written;
-
-	if (asprintf(&tmpfile, "/tmp/dpdk_bpf_%s_XXXXXX.o", name) < 0) {
-		printf("%s@%d: asprintf failed: %s\n",
-		       __func__, __LINE__, strerror(errno));
-		return NULL;
-	}
-
-	/* Create and open temp file */
-	fd = mkstemps(tmpfile, strlen(".o"));
-	if (fd < 0) {
-		printf("%s@%d: mkstemps(%s) failed: %s\n",
-		       __func__, __LINE__, tmpfile, strerror(errno));
-		free(tmpfile);
-		return NULL;
-	}
-
-	/* Write BPF object data */
-	written = write(fd, data, size);
-	close(fd);
-
-	if (written != (ssize_t)size) {
-		printf("%s@%d: write failed: %s\n",
-		       __func__, __LINE__, strerror(errno));
-		unlink(tmpfile);
-		free(tmpfile);
-		return NULL;
-	}
-
-	return tmpfile;
-}
-
-#include "test_bpf_load.h"
-
-/*
- * Test loading BPF program from an object file.
- * This test uses same arguments as previous test_call1 example.
- */
-static int
-test_bpf_elf_load(void)
-{
-	static const char test_section[] = "call1";
-	uint8_t tbuf[sizeof(struct dummy_vect8)];
-	const struct rte_bpf_xsym xsym[] = {
-		{
-			.name = RTE_STR(dummy_func1),
-			.type = RTE_BPF_XTYPE_FUNC,
-			.func = {
-				.val = (void *)dummy_func1,
-				.nb_args = 3,
-				.args = {
-					[0] = {
-						.type = RTE_BPF_ARG_PTR,
-						.size = sizeof(struct dummy_offset),
-					},
-					[1] = {
-						.type = RTE_BPF_ARG_PTR,
-						.size = sizeof(uint32_t),
-					},
-					[2] = {
-						.type = RTE_BPF_ARG_PTR,
-						.size = sizeof(uint64_t),
-					},
-				},
-			},
-		},
-	};
-	int ret;
-
-	/* Create temp file from embedded BPF object */
-	char *tmpfile = create_temp_bpf_file(app_test_bpf_load_o,
-					     app_test_bpf_load_o_len,
-					     "load");
-	if (tmpfile == NULL)
-		return -1;
-
-	/* Try to load BPF program from temp file */
-	const struct rte_bpf_prm prm = {
-		.xsym = xsym,
-		.nb_xsym = RTE_DIM(xsym),
-		.prog_arg = {
-			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(tbuf),
-		},
-	};
-
-	struct rte_bpf *bpf = rte_bpf_elf_load(&prm, tmpfile, test_section);
-	unlink(tmpfile);
-	free(tmpfile);
-
-	/* If libelf support is not available */
-	if (bpf == NULL && rte_errno == ENOTSUP)
-		return TEST_SKIPPED;
-
-	TEST_ASSERT(bpf != NULL, "failed to load BPF %d:%s", rte_errno, strerror(rte_errno));
-
-	/* Prepare test data */
-	struct dummy_vect8 *dv = (struct dummy_vect8 *)tbuf;
-
-	memset(dv, 0, sizeof(*dv));
-	dv->in[0].u64 = (int32_t)TEST_FILL_1;
-	dv->in[0].u32 = dv->in[0].u64;
-	dv->in[0].u16 = dv->in[0].u64;
-	dv->in[0].u8 = dv->in[0].u64;
-
-	/* Execute loaded BPF program */
-	uint64_t rc = rte_bpf_exec(bpf, tbuf);
-	ret = test_call1_check(rc, tbuf);
-	TEST_ASSERT(ret == 0, "test_call1_check failed: %d", ret);
-
-	/* Test JIT if available */
-	struct rte_bpf_jit jit;
-	ret = rte_bpf_get_jit(bpf, &jit);
-	TEST_ASSERT(ret == 0, "rte_bpf_get_jit failed: %d", ret);
-
-	if (jit.func != NULL) {
-		memset(dv, 0, sizeof(*dv));
-		dv->in[0].u64 = (int32_t)TEST_FILL_1;
-		dv->in[0].u32 = dv->in[0].u64;
-		dv->in[0].u16 = dv->in[0].u64;
-		dv->in[0].u8 = dv->in[0].u64;
-
-		rc = jit.func(tbuf);
-		ret = test_call1_check(rc, tbuf);
-		TEST_ASSERT(ret == 0, "jit test_call1_check failed: %d", ret);
-	}
-
-	rte_bpf_destroy(bpf);
-
-	printf("%s: ELF load test passed\n", __func__);
-	return TEST_SUCCESS;
-}
-
-#include <rte_ethdev.h>
-#include <rte_bpf_ethdev.h>
-#include <rte_bus_vdev.h>
-
-#include "test_bpf_filter.h"
-
-#define BPF_TEST_BURST		128
-#define BPF_TEST_POOLSIZE	256 /* at least 2x burst */
-#define BPF_TEST_PKT_LEN	64 /* Ether + IP + TCP */
-
-static int null_vdev_setup(const char *name, uint16_t *port, struct rte_mempool *pool)
-{
-	int ret;
-
-	/* Make a null device */
-	ret = rte_vdev_init(name, NULL);
-	TEST_ASSERT(ret == 0, "rte_vdev_init(%s) failed: %d", name, ret);
-
-	ret = rte_eth_dev_get_port_by_name(name, port);
-	TEST_ASSERT(ret == 0, "failed to get port id for %s: %d", name, ret);
-
-	struct rte_eth_conf conf = { };
-	ret = rte_eth_dev_configure(*port, 1, 1, &conf);
-	TEST_ASSERT(ret == 0, "failed to configure port %u: %d", *port, ret);
-
-	struct rte_eth_txconf txconf = { };
-	ret = rte_eth_tx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY, &txconf);
-	TEST_ASSERT(ret == 0, "failed to setup tx queue port %u: %d", *port, ret);
-
-	struct rte_eth_rxconf rxconf = { };
-	ret = rte_eth_rx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY,
-				     &rxconf, pool);
-	TEST_ASSERT(ret == 0, "failed to setup rx queue port %u: %d", *port, ret);
-
-	ret = rte_eth_dev_start(*port);
-	TEST_ASSERT(ret == 0, "failed to start port %u: %d", *port, ret);
-
-	return 0;
-}
-
-static unsigned int
-setup_mbufs(struct rte_mbuf *burst[], unsigned int n)
-{
-	struct rte_ether_hdr eh = {
-		.ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
-	};
-	const struct rte_ipv4_hdr iph = {
-		.version_ihl = RTE_IPV4_VHL_DEF,
-		.total_length = rte_cpu_to_be_16(BPF_TEST_PKT_LEN - sizeof(eh)),
-		.time_to_live = IPDEFTTL,
-		.src_addr = rte_cpu_to_be_32(ip_src_addr),
-		.dst_addr = rte_cpu_to_be_32(ip_dst_addr),
-	};
-	unsigned int tcp_count = 0;
-
-	rte_eth_random_addr(eh.dst_addr.addr_bytes);
-
-	for (unsigned int i = 0; i < n; i++) {
-		struct rte_mbuf *mb = burst[i];
-
-		/* Setup Ethernet header */
-		*rte_pktmbuf_mtod(mb, struct rte_ether_hdr *) = eh;
-
-		/* Setup IP header */
-		struct rte_ipv4_hdr *ip
-			= rte_pktmbuf_mtod_offset(mb, struct rte_ipv4_hdr *, sizeof(eh));
-		*ip = iph;
-
-		if (rte_rand() & 1) {
-			struct rte_udp_hdr *udp
-				= rte_pktmbuf_mtod_offset(mb, struct rte_udp_hdr *,
-							  sizeof(eh) + sizeof(iph));
-
-			ip->next_proto_id = IPPROTO_UDP;
-			*udp = (struct rte_udp_hdr) {
-				.src_port = rte_cpu_to_be_16(9),	/* discard */
-				.dst_port = rte_cpu_to_be_16(9),	/* discard */
-				.dgram_len = BPF_TEST_PKT_LEN - sizeof(eh) - sizeof(iph),
-			};
-
-		} else {
-			struct rte_tcp_hdr *tcp
-				= rte_pktmbuf_mtod_offset(mb, struct rte_tcp_hdr *,
-							  sizeof(eh) + sizeof(iph));
-
-			ip->next_proto_id = IPPROTO_TCP;
-			*tcp = (struct rte_tcp_hdr) {
-				.src_port = rte_cpu_to_be_16(9),	/* discard */
-				.dst_port = rte_cpu_to_be_16(9),	/* discard */
-				.tcp_flags = RTE_TCP_RST_FLAG,
-			};
-			++tcp_count;
-		}
-	}
-
-	return tcp_count;
-}
-
-static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_mempool *pool,
-		       const char *section, uint32_t flags)
-{
-	const struct rte_bpf_prm prm = {
-		.prog_arg = {
-			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct rte_mbuf),
-		},
-	};
-	int ret;
-
-	/* Try to load BPF TX program from temp file */
-	ret = rte_bpf_eth_tx_elf_load(port, 0, &prm, tmpfile, section, flags);
-	if (ret != 0) {
-		printf("%s@%d: failed to load BPF filter from file=%s error=%d:(%s)\n",
-		       __func__, __LINE__, tmpfile, rte_errno, rte_strerror(rte_errno));
-		return ret;
-	}
-
-	struct rte_mbuf *pkts[BPF_TEST_BURST] = { };
-	ret = rte_pktmbuf_alloc_bulk(pool, pkts, BPF_TEST_BURST);
-	TEST_ASSERT(ret == 0, "failed to allocate mbufs");
-
-	uint16_t expect = setup_mbufs(pkts, BPF_TEST_BURST);
-
-	uint16_t sent = rte_eth_tx_burst(port, 0, pkts, BPF_TEST_BURST);
-	TEST_ASSERT_EQUAL(sent, expect, "rte_eth_tx_burst returned: %u expected %u",
-			  sent, expect);
-
-	/* The unsent packets should be dropped */
-	rte_pktmbuf_free_bulk(pkts + sent, BPF_TEST_BURST - sent);
-
-	/* Pool should have same number of packets avail */
-	unsigned int avail = rte_mempool_avail_count(pool);
-	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
-			  "Mempool available %u != %u leaks?", avail, BPF_TEST_POOLSIZE);
-
-	rte_bpf_eth_tx_unload(port, 0);
-	return TEST_SUCCESS;
-}
-
-/* Test loading a transmit filter which only allows IPv4 packets */
-static int
-test_bpf_elf_tx_load(void)
-{
-	static const char null_dev[] = "net_null_bpf0";
-	char *tmpfile = NULL;
-	struct rte_mempool *mb_pool = NULL;
-	uint16_t port = UINT16_MAX;
-	int ret;
-
-	printf("%s start\n", __func__);
-
-	/* Make a pool for packets */
-	mb_pool = rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSIZE,
-					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-					  SOCKET_ID_ANY);
-
-	ret = null_vdev_setup(null_dev, &port, mb_pool);
-	if (ret != 0)
-		goto fail;
-
-	/* Create temp file from embedded BPF object */
-	tmpfile = create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "tx");
-	if (tmpfile == NULL)
-		goto fail;
-
-	/* Do test with VM */
-	ret = bpf_tx_test(port, tmpfile, mb_pool, "filter", 0);
-	if (ret != 0)
-		goto fail;
-
-	/* Repeat with JIT */
-	ret = bpf_tx_test(port, tmpfile, mb_pool, "filter", RTE_BPF_ETH_F_JIT);
-	if (ret == 0)
-		printf("%s: TX ELF load test passed\n", __func__);
-
-fail:
-	if (tmpfile) {
-		unlink(tmpfile);
-		free(tmpfile);
-	}
-
-	if (port != UINT16_MAX)
-		rte_vdev_uninit(null_dev);
-
-	rte_mempool_free(mb_pool);
-
-	if (ret == 0)
-		return TEST_SUCCESS;
-	else if (ret == -ENOTSUP)
-		return TEST_SKIPPED;
-	else
-		return TEST_FAILED;
-}
-
-/* Test loading a receive filter */
-static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_mempool *pool,
-		       const char *section, uint32_t flags, uint16_t expected)
-{
-	struct rte_mbuf *pkts[BPF_TEST_BURST];
-	const struct rte_bpf_prm prm = {
-		.prog_arg = {
-			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct rte_mbuf),
-		},
-	};
-	int ret;
-
-	/* Load BPF program to drop all packets */
-	ret = rte_bpf_eth_rx_elf_load(port, 0, &prm, tmpfile, section, flags);
-	if (ret != 0) {
-		printf("%s@%d: failed to load BPF filter from file=%s error=%d:(%s)\n",
-		       __func__, __LINE__, tmpfile, rte_errno, rte_strerror(rte_errno));
-		return ret;
-	}
-
-	uint16_t rcvd = rte_eth_rx_burst(port, 0, pkts, BPF_TEST_BURST);
-	TEST_ASSERT_EQUAL(rcvd, expected,
-			  "rte_eth_rx_burst returned: %u expect: %u", rcvd, expected);
-
-	/* Drop the received packets */
-	rte_pktmbuf_free_bulk(pkts, rcvd);
-
-	rte_bpf_eth_rx_unload(port, 0);
-
-	/* Pool should now be full */
-	unsigned int avail = rte_mempool_avail_count(pool);
-	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
-			  "Mempool available %u != %u leaks?", avail, BPF_TEST_POOLSIZE);
-
-	return TEST_SUCCESS;
-}
-
-/* Test loading a receive filters, first with drop all and then with allow all packets */
-static int
-test_bpf_elf_rx_load(void)
-{
-	static const char null_dev[] = "net_null_bpf0";
-	struct rte_mempool *pool = NULL;
-	char *tmpfile = NULL;
-	uint16_t port;
-	int ret;
-
-	printf("%s start\n", __func__);
-
-	/* Make a pool for packets */
-	pool = rte_pktmbuf_pool_create("bpf_rx_test_pool", 2 * BPF_TEST_BURST,
-					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-					  SOCKET_ID_ANY);
-	TEST_ASSERT(pool != NULL, "failed to create mempool");
-
-	ret = null_vdev_setup(null_dev, &port, pool);
-	if (ret != 0)
-		goto fail;
-
-	/* Create temp file from embedded BPF object */
-	tmpfile = create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "rx");
-	if (tmpfile == NULL)
-		goto fail;
-
-	/* Do test with VM */
-	ret = bpf_rx_test(port, tmpfile, pool, "drop", 0, 0);
-	if (ret != 0)
-		goto fail;
-
-	/* Repeat with JIT */
-	ret = bpf_rx_test(port, tmpfile, pool, "drop", RTE_BPF_ETH_F_JIT, 0);
-	if (ret != 0)
-		goto fail;
-
-	/* Repeat with allow all */
-	ret = bpf_rx_test(port, tmpfile, pool, "allow", 0, BPF_TEST_BURST);
-	if (ret != 0)
-		goto fail;
-
-	/* Repeat with JIT */
-	ret = bpf_rx_test(port, tmpfile, pool, "allow", RTE_BPF_ETH_F_JIT, BPF_TEST_BURST);
-	if (ret != 0)
-		goto fail;
-
-	printf("%s: RX ELF load test passed\n", __func__);
-
-	/* The filter should free the mbufs */
-	unsigned int avail = rte_mempool_avail_count(pool);
-	TEST_ASSERT_EQUAL(avail, BPF_TEST_POOLSIZE,
-			  "Mempool available %u != %u leaks?", avail, BPF_TEST_POOLSIZE);
-
-fail:
-	if (tmpfile) {
-		unlink(tmpfile);
-		free(tmpfile);
-	}
-
-	if (port != UINT16_MAX)
-		rte_vdev_uninit(null_dev);
-
-	rte_mempool_free(pool);
-
-	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
-}
-
-
-static int
-test_bpf_elf(void)
-{
-	int ret;
-
-	ret = test_bpf_elf_load();
-	if (ret == TEST_SUCCESS)
-		ret = test_bpf_elf_tx_load();
-	if (ret == TEST_SUCCESS)
-		ret = test_bpf_elf_rx_load();
-
-	return ret;
-}
-
-#else
-
-static int
-test_bpf_elf(void)
-{
-	printf("BPF compile not supported, skipping test\n");
-	return TEST_SKIPPED;
-}
-
-#endif /* !TEST_BPF_ELF_LOAD */
-
-REGISTER_FAST_TEST(bpf_elf_autotest, NOHUGE_OK, ASAN_OK, test_bpf_elf);
-
 #ifndef RTE_HAS_LIBPCAP
 
 static int
diff --git a/app/test/test_bpf_elf.c b/app/test/test_bpf_elf.c
new file mode 100644
index 0000000000..c23fe35119
--- /dev/null
+++ b/app/test/test_bpf_elf.c
@@ -0,0 +1,560 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2024 Red Hat, Inc.
+ */
+
+/*
+ * BPF ELF loading tests.
+ * These tests require the null PMD for TX/RX filter testing.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include <rte_random.h>
+#include <rte_errno.h>
+
+#include "test.h"
+
+#ifndef TEST_BPF_ELF_LOAD
+
+static int
+test_bpf_elf(void)
+{
+	printf("BPF ELF load not supported, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+#else /* TEST_BPF_ELF_LOAD */
+
+#include <rte_bpf.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_ethdev.h>
+#include <rte_bpf_ethdev.h>
+#include <rte_bus_vdev.h>
+
+/*
+ * Structures shared with test_bpf.c interpreter tests.
+ * These are duplicated here to keep the ELF tests self-contained.
+ */
+struct dummy_offset {
+	RTE_ATOMIC(uint64_t) u64;
+	RTE_ATOMIC(uint32_t) u32;
+	uint16_t u16;
+	uint8_t  u8;
+};
+
+struct dummy_vect8 {
+	struct dummy_offset in[8];
+	struct dummy_offset out[8];
+};
+
+#define	TEST_FILL_1	0xDEADBEEF
+
+static uint32_t ip_src_addr = (172U << 24) | (168U << 16) | (2 << 8) | 1;
+static uint32_t ip_dst_addr = (172U << 24) | (168U << 16) | (2 << 8) | 2;
+
+/*
+ * External function used by BPF programs loaded from ELF.
+ * Must match the signature expected by the BPF code in test_bpf_load.h.
+ */
+static uint64_t
+dummy_func1(const struct dummy_offset *dofs, uint32_t *u32_p, uint64_t *u64_p)
+{
+	*u32_p = dofs->u16;
+	*u64_p = dofs->u32;
+	return dofs->u64;
+}
+
+/*
+ * Check function for call1 test - validates the BPF program output.
+ */
+static int
+test_call1_check(uint64_t rc, const void *arg)
+{
+	uint64_t v;
+	const struct dummy_vect8 *dvt = arg;
+	struct dummy_vect8 dve;
+
+	memset(&dve, 0, sizeof(dve));
+
+	dve.in[0].u64 = dvt->in[0].u64;
+	dve.in[0].u32 = dvt->in[0].u32;
+	dve.in[0].u16 = dvt->in[0].u16;
+	dve.in[0].u8 = dvt->in[0].u8;
+
+	v = dummy_func1(dve.in, &dve.out[0].u32, &dve.out[0].u64);
+	dve.out[1].u64 = v;
+
+	if (memcmp(dve.out, dvt->out, sizeof(dve.out)) != 0) {
+		printf("%s: invalid value\n", __func__);
+		return -1;
+	}
+
+	return (rc == v) ? 0 : -1;
+}
+
+/*
+ * Helper function to write BPF object data to temporary file.
+ * Returns temp file path on success, NULL on failure.
+ * Caller must free the returned path and unlink the file.
+ */
+static char *
+create_temp_bpf_file(const uint8_t *data, size_t size, const char *name)
+{
+	char *tmpfile = NULL;
+	int fd;
+	ssize_t written;
+
+	if (asprintf(&tmpfile, "/tmp/dpdk_bpf_%s_XXXXXX.o", name) < 0) {
+		printf("%s@%d: asprintf failed: %s\n",
+		       __func__, __LINE__, strerror(errno));
+		return NULL;
+	}
+
+	/* Create and open temp file */
+	fd = mkstemps(tmpfile, strlen(".o"));
+	if (fd < 0) {
+		printf("%s@%d: mkstemps(%s) failed: %s\n",
+		       __func__, __LINE__, tmpfile, strerror(errno));
+		free(tmpfile);
+		return NULL;
+	}
+
+	/* Write BPF object data */
+	written = write(fd, data, size);
+	close(fd);
+
+	if (written != (ssize_t)size) {
+		printf("%s@%d: write failed: %s\n",
+		       __func__, __LINE__, strerror(errno));
+		unlink(tmpfile);
+		free(tmpfile);
+		return NULL;
+	}
+
+	return tmpfile;
+}
+
+#include "test_bpf_load.h"
+
+/*
+ * Test loading BPF program from an object file.
+ * This test uses same arguments as test_call1 example in test_bpf.c.
+ */
+static int
+test_bpf_elf_load(void)
+{
+	static const char test_section[] = "call1";
+	uint8_t tbuf[sizeof(struct dummy_vect8)];
+	const struct rte_bpf_xsym xsym[] = {
+		{
+			.name = RTE_STR(dummy_func1),
+			.type = RTE_BPF_XTYPE_FUNC,
+			.func = {
+				.val = (void *)dummy_func1,
+				.nb_args = 3,
+				.args = {
+					[0] = {
+						.type = RTE_BPF_ARG_PTR,
+						.size = sizeof(struct dummy_offset),
+					},
+					[1] = {
+						.type = RTE_BPF_ARG_PTR,
+						.size = sizeof(uint32_t),
+					},
+					[2] = {
+						.type = RTE_BPF_ARG_PTR,
+						.size = sizeof(uint64_t),
+					},
+				},
+			},
+		},
+	};
+	int ret;
+
+	/* Create temp file from embedded BPF object */
+	char *tmpfile = create_temp_bpf_file(app_test_bpf_load_o,
+					     app_test_bpf_load_o_len,
+					     "load");
+	if (tmpfile == NULL)
+		return -1;
+
+	/* Try to load BPF program from temp file */
+	const struct rte_bpf_prm prm = {
+		.xsym = xsym,
+		.nb_xsym = RTE_DIM(xsym),
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR,
+			.size = sizeof(tbuf),
+		},
+	};
+
+	struct rte_bpf *bpf = rte_bpf_elf_load(&prm, tmpfile, test_section);
+	unlink(tmpfile);
+	free(tmpfile);
+
+	/* If libelf support is not available */
+	if (bpf == NULL && rte_errno == ENOTSUP)
+		return TEST_SKIPPED;
+
+	TEST_ASSERT(bpf != NULL, "failed to load BPF %d:%s", rte_errno, strerror(rte_errno));
+
+	/* Prepare test data */
+	struct dummy_vect8 *dv = (struct dummy_vect8 *)tbuf;
+
+	memset(dv, 0, sizeof(*dv));
+	dv->in[0].u64 = (int32_t)TEST_FILL_1;
+	dv->in[0].u32 = dv->in[0].u64;
+	dv->in[0].u16 = dv->in[0].u64;
+	dv->in[0].u8 = dv->in[0].u64;
+
+	/* Execute loaded BPF program */
+	uint64_t rc = rte_bpf_exec(bpf, tbuf);
+	ret = test_call1_check(rc, tbuf);
+	TEST_ASSERT(ret == 0, "test_call1_check failed: %d", ret);
+
+	/* Test JIT if available */
+	struct rte_bpf_jit jit;
+	ret = rte_bpf_get_jit(bpf, &jit);
+	TEST_ASSERT(ret == 0, "rte_bpf_get_jit failed: %d", ret);
+
+	if (jit.func != NULL) {
+		memset(dv, 0, sizeof(*dv));
+		dv->in[0].u64 = (int32_t)TEST_FILL_1;
+		dv->in[0].u32 = dv->in[0].u64;
+		dv->in[0].u16 = dv->in[0].u64;
+		dv->in[0].u8 = dv->in[0].u64;
+
+		rc = jit.func(tbuf);
+		ret = test_call1_check(rc, tbuf);
+		TEST_ASSERT(ret == 0, "jit test_call1_check failed: %d", ret);
+	}
+
+	rte_bpf_destroy(bpf);
+
+	printf("%s: ELF load test passed\n", __func__);
+	return TEST_SUCCESS;
+}
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
+	/* Try to load BPF TX program from temp file */
+	ret = rte_bpf_eth_tx_elf_load(port, 0, &prm, tmpfile, section, flags);
+	if (ret != 0) {
+		printf("%s@%d: failed to load BPF filter from file=%s error=%d:(%s)\n",
+		       __func__, __LINE__, tmpfile, rte_errno, rte_strerror(rte_errno));
+		return ret;
+	}
+
+	struct rte_mbuf *pkts[BPF_TEST_BURST] = { };
+	ret = rte_pktmbuf_alloc_bulk(pool, pkts, BPF_TEST_BURST);
+	TEST_ASSERT(ret == 0, "failed to allocate mbufs");
+
+	uint16_t expect = setup_mbufs(pkts, BPF_TEST_BURST);
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
+	if (ret == 0)
+		return TEST_SUCCESS;
+	else if (ret == -ENOTSUP)
+		return TEST_SKIPPED;
+	else
+		return TEST_FAILED;
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
+	if (ret != 0) {
+		printf("%s@%d: failed to load BPF filter from file=%s error=%d:(%s)\n",
+		       __func__, __LINE__, tmpfile, rte_errno, rte_strerror(rte_errno));
+		return ret;
+	}
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
+
+
+static int
+test_bpf_elf(void)
+{
+	int ret;
+
+	ret = test_bpf_elf_load();
+	if (ret == TEST_SUCCESS)
+		ret = test_bpf_elf_tx_load();
+	if (ret == TEST_SUCCESS)
+		ret = test_bpf_elf_rx_load();
+
+	return ret;
+}
+
+#endif /* RTE_LIB_BPF && TEST_BPF_ELF_LOAD */
+
+REGISTER_FAST_TEST(bpf_elf_autotest, NOHUGE_OK, ASAN_OK, test_bpf_elf);
-- 
2.51.0


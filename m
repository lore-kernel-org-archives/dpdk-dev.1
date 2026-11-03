Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0E606A335
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Mx98f28F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D24D42F83;
	Tue,  3 Nov 2026 16:19:51 +0100 (CET)
Received: from mta1.migadu.com (out-141.mta1.migadu.com [95.215.58.141])
 by mails.dpdk.org (Postfix) with ESMTPS id 7DB7842F79
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:50 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=y2G9l9zTMrZCGrgHfEZF+i5WtCtGcNK60YolGrjVCh8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719190; v=1; x=1794323990;
 b=Mx98f28FtKeyv096nJVjuuoi+ffYYw09JKJ/MgBt7yfzhCndT5EHRm67a2btZHWbLyYH8tGs
 rSXFY7M9rIqf1gWG2gZR+h6jPo0Vuag+F4C10wDL4fJkiDN8Iud37e399/k5jvjY6/Y7BlCr3+O
 1T3BGBG7h7Ue4/RW9NxWr0Sk=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id ef20b249abfeb595;
 Tue, 03 Nov 2026 15:19:49 +0000
X-Mizu-Trace-ID: ef20b249abfeb595
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 170/227] test: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:08 +0800
Message-ID: <20261103145306.487255-171-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/sample_packet_forward.c       |  10 +-
 app/test/test_acl.c                    |   8 +-
 app/test/test_bitratestats.c           |   2 +-
 app/test/test_bpf.c                    |   8 +-
 app/test/test_cksum.c                  |   2 +-
 app/test/test_compressdev.c            |  22 ++--
 app/test/test_cryptodev.c              |  50 ++++-----
 app/test/test_cryptodev_asym.c         |   8 +-
 app/test/test_cryptodev_crosscheck.c   |  10 +-
 app/test/test_distributor.c            |  14 +--
 app/test/test_distributor_perf.c       |   6 +-
 app/test/test_dmadev.c                 |   4 +-
 app/test/test_efd.c                    |  64 +++++------
 app/test/test_efd_perf.c               |  22 ++--
 app/test/test_ethdev_api.c             |   6 +-
 app/test/test_event_crypto_adapter.c   |  14 +--
 app/test/test_event_dma_adapter.c      |   6 +-
 app/test/test_event_eth_rx_adapter.c   |   8 +-
 app/test/test_event_eth_tx_adapter.c   |   6 +-
 app/test/test_event_ring.c             |  14 +--
 app/test/test_event_timer_adapter.c    |   6 +-
 app/test/test_event_vector_adapter.c   |   8 +-
 app/test/test_eventdev.c               |  16 +--
 app/test/test_external_mem.c           |  14 +--
 app/test/test_fib.c                    |  48 ++++----
 app/test/test_fib6.c                   |  56 +++++-----
 app/test/test_fib6_perf.c              |   2 +-
 app/test/test_fib_perf.c               |   2 +-
 app/test/test_func_reentrancy.c        |  12 +-
 app/test/test_graph_perf.c             |   6 +-
 app/test/test_hash.c                   |  20 ++--
 app/test/test_ipfrag.c                 |   6 +-
 app/test/test_ipsec.c                  |  12 +-
 app/test/test_ipsec_perf.c             |  12 +-
 app/test/test_latencystats.c           |   2 +-
 app/test/test_link_bonding.c           |  22 ++--
 app/test/test_link_bonding_mode4.c     |  16 +--
 app/test/test_link_bonding_rssconf.c   |   8 +-
 app/test/test_lpm.c                    |  64 +++++------
 app/test/test_lpm6.c                   |  70 ++++++------
 app/test/test_lpm6_perf.c              |   2 +-
 app/test/test_lpm_perf.c               |   4 +-
 app/test/test_malloc.c                 | 146 ++++++++++++-------------
 app/test/test_malloc_perf.c            |   2 +-
 app/test/test_mbuf.c                   |  18 +--
 app/test/test_member_perf.c            |   2 +-
 app/test/test_mempool.c                |  40 +++----
 app/test/test_mempool_perf.c           |  10 +-
 app/test/test_memzone.c                | 119 ++++++++++----------
 app/test/test_metrics.c                |   2 +-
 app/test/test_mp_secondary.c           |   8 +-
 app/test/test_net_ether.c              |   2 +-
 app/test/test_pcapng.c                 |   2 +-
 app/test/test_pdcp.c                   |  14 +--
 app/test/test_pdump.c                  |   2 +-
 app/test/test_per_lcore.c              |   4 +-
 app/test/test_pmd_af_packet.c          |  10 +-
 app/test/test_pmd_memif.c              |   2 +-
 app/test/test_pmd_pcap.c               |   6 +-
 app/test/test_pmd_perf.c               |  72 ++++++------
 app/test/test_pmd_ring.c               |   2 +-
 app/test/test_pmd_ring_perf.c          |   2 +-
 app/test/test_pmd_tap.c                |   6 +-
 app/test/test_reassembly.c             |   4 +-
 app/test/test_reassembly_perf.c        |   4 +-
 app/test/test_reorder.c                |  20 ++--
 app/test/test_rib.c                    |  20 ++--
 app/test/test_rib6.c                   |  20 ++--
 app/test/test_ring.c                   |  28 ++---
 app/test/test_ring.h                   |   6 +-
 app/test/test_ring_perf.c              |  20 ++--
 app/test/test_security.c               |   2 +-
 app/test/test_security_inline_macsec.c |   8 +-
 app/test/test_security_inline_proto.c  |  12 +-
 app/test/test_stack.c                  |  10 +-
 app/test/test_stack_perf.c             |  14 +--
 app/test/test_timer_secondary.c        |   4 +-
 app/test/virtual_pmd.c                 |  32 +++---
 app/test/virtual_pmd.h                 |   2 +-
 79 files changed, 685 insertions(+), 684 deletions(-)

diff --git a/app/test/sample_packet_forward.c b/app/test/sample_packet_forward.c
index aa897274d8..a7be356751 100644
--- a/app/test/sample_packet_forward.c
+++ b/app/test/sample_packet_forward.c
@@ -30,12 +30,12 @@ test_dev_start(uint16_t port, struct rte_mempool *mp)
 	if (rc != 0)
 		return rc;
 
-	rc = rte_eth_rx_queue_setup(port, 0, RING_SIZE, SOCKET_ID_ANY,
+	rc = rte_eth_rx_queue_setup(port, 0, RING_SIZE, RTE_NUMA_ID_ANY,
 		NULL, mp);
 	if (rc != 0)
 		return rc;
 
-	rc = rte_eth_tx_queue_setup(port, 0, RING_SIZE, SOCKET_ID_ANY,
+	rc = rte_eth_tx_queue_setup(port, 0, RING_SIZE, RTE_NUMA_ID_ANY,
 		NULL);
 	if (rc != 0)
 		return rc;
@@ -48,7 +48,7 @@ test_dev_start(uint16_t port, struct rte_mempool *mp)
 int
 test_ring_setup(struct rte_ring **ring, uint16_t *portid)
 {
-	*ring = rte_ring_create("R0", RING_SIZE, rte_socket_id(),
+	*ring = rte_ring_create("R0", RING_SIZE, rte_numa_id(),
 				  RING_F_SP_ENQ | RING_F_SC_DEQ);
 	if (*ring == NULL) {
 		printf("%s() line %u: rte_ring_create R0 failed",
@@ -56,7 +56,7 @@ test_ring_setup(struct rte_ring **ring, uint16_t *portid)
 		return -1;
 	}
 	*portid = rte_eth_from_rings("net_ringa", ring, NUM_QUEUES,
-			ring, NUM_QUEUES, rte_socket_id());
+			ring, NUM_QUEUES, rte_numa_id());
 
 	return 0;
 }
@@ -87,7 +87,7 @@ int
 test_get_mempool(struct rte_mempool **mp, char *poolname)
 {
 	*mp = rte_pktmbuf_pool_create(poolname, NB_MBUF, 32, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (*mp == NULL)
 		return -1;
 	return 0;
diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 5d207c80ca..ed8d0c937b 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -34,7 +34,7 @@ RTE_ACL_RULE_DEF(acl_ipv4vlan_rule, RTE_ACL_IPV4VLAN_NUM_FIELDS);
 
 struct rte_acl_param acl_param = {
 	.name = "acl_ctx",
-	.socket_id = SOCKET_ID_ANY,
+	.numa_id = RTE_NUMA_ID_ANY,
 	.rule_size = RTE_ACL_IPV4VLAN_RULE_SZ,
 	.max_rule_num = 0x30000,
 };
@@ -1407,7 +1407,7 @@ test_invalid_parameters(void)
 	if (rte_eal_has_hugepages()) {
 		/* invalid NUMA node */
 		memcpy(&param, &acl_param, sizeof(param));
-		param.socket_id = RTE_MAX_NUMA_NODES + 1;
+		param.numa_id = RTE_MAX_NUMA_NODES + 1;
 
 		acx = rte_acl_create(&param);
 		if (acx != NULL) {
@@ -1726,11 +1726,11 @@ static struct rte_acl_ctx *acl_ctx;
 
 static void *
 running_alloc(char *name, size_t size,
-		size_t align, int32_t socket_id, void *udata)
+		size_t align, int32_t numa_id, void *udata)
 {
 	size_t aligned_size = RTE_ALIGN_CEIL(size, align);
 	RTE_SET_USED(name);
-	RTE_SET_USED(socket_id);
+	RTE_SET_USED(numa_id);
 
 	if (udata != acl_ctx) {
 		printf("%s#%i udata mismatch!\n",
diff --git a/app/test/test_bitratestats.c b/app/test/test_bitratestats.c
index 45343aa4c6..8ca9aa5b6d 100644
--- a/app/test/test_bitratestats.c
+++ b/app/test/test_bitratestats.c
@@ -59,7 +59,7 @@ test_stats_bitrate_reg(void)
 			"without metrics init, ret:%d", ret);
 
 	/* Metrics initialization */
-	rte_metrics_init(rte_socket_id());
+	rte_metrics_init(rte_numa_id());
 	/* Test to register bit rate after metrics init */
 	ret = rte_stats_bitrate_reg(bitrate_data);
 	TEST_ASSERT((ret >= 0), "Test Failed: rte_stats_bitrate_reg %d", ret);
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 032efc6143..45a6245a54 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4490,11 +4490,11 @@ static int null_vdev_setup(const char *name, uint16_t *port, struct rte_mempool
 	TEST_ASSERT(ret == 0, "failed to configure port %u: %d", *port, ret);
 
 	struct rte_eth_txconf txconf = { };
-	ret = rte_eth_tx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY, &txconf);
+	ret = rte_eth_tx_queue_setup(*port, 0, BPF_TEST_BURST, RTE_NUMA_ID_ANY, &txconf);
 	TEST_ASSERT(ret == 0, "failed to setup tx queue port %u: %d", *port, ret);
 
 	struct rte_eth_rxconf rxconf = { };
-	ret = rte_eth_rx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY,
+	ret = rte_eth_rx_queue_setup(*port, 0, BPF_TEST_BURST, RTE_NUMA_ID_ANY,
 				     &rxconf, pool);
 	TEST_ASSERT(ret == 0, "failed to setup rx queue port %u: %d", *port, ret);
 
@@ -4623,7 +4623,7 @@ test_bpf_elf_tx_load(load_elf_image_t load_elf_image)
 	/* Make a pool for packets */
 	mb_pool = rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSIZE,
 					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-					  SOCKET_ID_ANY);
+					  RTE_NUMA_ID_ANY);
 	TEST_ASSERT(mb_pool != NULL, "failed to create mempool");
 
 	ret = null_vdev_setup(null_dev, &port, mb_pool);
@@ -4712,7 +4712,7 @@ test_bpf_elf_rx_load(load_elf_image_t load_elf_image)
 	/* Make a pool for packets */
 	pool = rte_pktmbuf_pool_create("bpf_rx_test_pool", 2 * BPF_TEST_BURST,
 					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-					  SOCKET_ID_ANY);
+					  RTE_NUMA_ID_ANY);
 	TEST_ASSERT(pool != NULL, "failed to create mempool");
 
 	ret = null_vdev_setup(null_dev, &port, pool);
diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
index d94539820a..6bc9b193b0 100644
--- a/app/test/test_cksum.c
+++ b/app/test/test_cksum.c
@@ -333,7 +333,7 @@ test_cksum(void)
 	/* create pktmbuf pool if it does not exist */
 	pktmbuf_pool = rte_pktmbuf_pool_create("test_cksum_mbuf_pool",
 			NB_MBUF, MEMPOOL_CACHE_SIZE, 0, MBUF_DATA_SIZE,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 
 	if (pktmbuf_pool == NULL)
 		GOTO_FAIL("cannot allocate mbuf pool");
diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
index ed0352a909..36b022d85d 100644
--- a/app/test/test_compressdev.c
+++ b/app/test/test_compressdev.c
@@ -219,7 +219,7 @@ testsuite_setup(void)
 			NUM_LARGE_MBUFS,
 			CACHE_SIZE, 0,
 			max_buf_size + RTE_PKTMBUF_HEADROOM,
-			rte_socket_id());
+			rte_numa_id());
 	if (ts_params->large_mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Large mbuf pool could not be created\n");
 		return TEST_FAILED;
@@ -230,7 +230,7 @@ testsuite_setup(void)
 			NUM_LARGE_MBUFS * MAX_SEGS,
 			CACHE_SIZE, 0,
 			SMALL_SEG_SIZE + RTE_PKTMBUF_HEADROOM,
-			rte_socket_id());
+			rte_numa_id());
 	if (ts_params->small_mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Small mbuf pool could not be created\n");
 		goto exit;
@@ -241,7 +241,7 @@ testsuite_setup(void)
 			NUM_BIG_MBUFS + 1,
 			CACHE_SIZE, 0,
 			MAX_MBUF_SEGMENT_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 	if (ts_params->big_mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Big mbuf pool could not be created\n");
 		goto exit;
@@ -249,7 +249,7 @@ testsuite_setup(void)
 
 	ts_params->op_pool = rte_comp_op_pool_create("op_pool", NUM_OPS,
 				0, sizeof(struct priv_op_data),
-				rte_socket_id());
+				rte_numa_id());
 	if (ts_params->op_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Operation pool could not be created\n");
 		goto exit;
@@ -297,7 +297,7 @@ generic_ut_setup(void)
 {
 	/* Configure compressdev (one device, one queue pair) */
 	struct rte_compressdev_config config = {
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.nb_queue_pairs = 1,
 		.max_nb_priv_xforms = NUM_MAX_XFORMS,
 		.max_nb_streams = 1
@@ -309,7 +309,7 @@ generic_ut_setup(void)
 	}
 
 	if (rte_compressdev_queue_pair_setup(0, 0, NUM_MAX_INFLIGHT_OPS,
-			rte_socket_id()) < 0) {
+			rte_numa_id()) < 0) {
 		RTE_LOG(ERR, USER1, "Queue pair setup failed\n");
 		return -1;
 	}
@@ -335,7 +335,7 @@ test_compressdev_invalid_configuration(void)
 {
 	struct rte_compressdev_config invalid_config;
 	struct rte_compressdev_config valid_config = {
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.nb_queue_pairs = 1,
 		.max_nb_priv_xforms = NUM_MAX_XFORMS,
 		.max_nb_streams = 1
@@ -368,7 +368,7 @@ test_compressdev_invalid_configuration(void)
 
 	/* Invalid queue pair setup, with no number of queue pairs set */
 	TEST_ASSERT_FAIL(rte_compressdev_queue_pair_setup(0, 0,
-				NUM_MAX_INFLIGHT_OPS, rte_socket_id()),
+				NUM_MAX_INFLIGHT_OPS, rte_numa_id()),
 			"Queue pair setup was successful "
 			"with no queue pairs set (invalid)\n");
 
@@ -3065,18 +3065,18 @@ test_compressdev_deflate_stateful_decomp_checksum(void)
 static const struct rte_memzone *
 make_memzone(const char *name, size_t size)
 {
-	unsigned int socket_id = rte_socket_id();
+	unsigned int numa_id = rte_numa_id();
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *memzone;
 
-	snprintf(mz_name, RTE_MEMZONE_NAMESIZE, "%s_%u", name, socket_id);
+	snprintf(mz_name, RTE_MEMZONE_NAMESIZE, "%s_%u", name, numa_id);
 	memzone = rte_memzone_lookup(mz_name);
 	if (memzone != NULL && memzone->len != size) {
 		rte_memzone_free(memzone);
 		memzone = NULL;
 	}
 	if (memzone == NULL) {
-		memzone = rte_memzone_reserve_aligned(mz_name, size, socket_id,
+		memzone = rte_memzone_reserve_aligned(mz_name, size, numa_id,
 				RTE_MEMZONE_IOVA_CONTIG, RTE_CACHE_LINE_SIZE);
 		if (memzone == NULL)
 			RTE_LOG(ERR, USER1, "Can't allocate memory zone %s",
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index aa689b297a..d12a5c704a 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -652,7 +652,7 @@ testsuite_setup(void)
 		ts_params->mbuf_pool = rte_pktmbuf_pool_create(
 				"CRYPTO_MBUFPOOL",
 				NUM_MBUFS, MBUF_CACHE_SIZE, 0, MBUF_SIZE,
-				rte_socket_id());
+				rte_numa_id());
 		if (ts_params->mbuf_pool == NULL) {
 			RTE_LOG(ERR, USER1, "Can't create CRYPTO_MBUFPOOL\n");
 			return TEST_FAILED;
@@ -666,7 +666,7 @@ testsuite_setup(void)
 		ts_params->large_mbuf_pool = rte_pktmbuf_pool_create(
 				"CRYPTO_LARGE_MBUFPOOL",
 				1, 0, 0, LARGE_MBUF_SIZE,
-				rte_socket_id());
+				rte_numa_id());
 		if (ts_params->large_mbuf_pool == NULL) {
 			RTE_LOG(ERR, USER1,
 				"Can't create CRYPTO_LARGE_MBUFPOOL\n");
@@ -681,7 +681,7 @@ testsuite_setup(void)
 			DEFAULT_NUM_XFORMS *
 			sizeof(struct rte_crypto_sym_xform) +
 			MAXIMUM_IV_LENGTH,
-			rte_socket_id());
+			rte_numa_id());
 	if (ts_params->op_mpool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_OP_POOL\n");
 		return TEST_FAILED;
@@ -716,7 +716,7 @@ testsuite_setup(void)
 	rte_cryptodev_info_get(dev_id, &info);
 
 	ts_params->conf.nb_queue_pairs = info.max_nb_queue_pairs;
-	ts_params->conf.numa_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = RTE_NUMA_ID_ANY;
 	ts_params->conf.ff_disable = RTE_CRYPTODEV_FF_SECURITY;
 
 	unsigned int session_size =
@@ -742,7 +742,7 @@ testsuite_setup(void)
 
 	ts_params->session_mpool = rte_cryptodev_sym_session_pool_create(
 			"test_sess_mp", MAX_NB_SESSIONS, session_size, 0, 0,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 	TEST_ASSERT_NOT_NULL(ts_params->session_mpool,
 			"session mempool allocation failed");
 
@@ -757,7 +757,7 @@ testsuite_setup(void)
 	for (qp_id = 0; qp_id < info.max_nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 			dev_id, qp_id, &ts_params->qp_conf,
-			rte_cryptodev_socket_id(dev_id)),
+			rte_cryptodev_numa_id(dev_id)),
 			"Failed to setup queue pair %u on cryptodev %u",
 			qp_id, dev_id);
 	}
@@ -1512,7 +1512,7 @@ dev_configure_and_start(uint64_t ff_disable)
 	memset(ut_params, 0, sizeof(*ut_params));
 
 	/* Reconfigure device to default parameters */
-	ts_params->conf.numa_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = RTE_NUMA_ID_ANY;
 	ts_params->conf.ff_disable = ff_disable;
 	ts_params->qp_conf.nb_descriptors = MAX_NUM_OPS_INFLIGHT;
 	ts_params->qp_conf.mp_session = ts_params->session_mpool;
@@ -1526,7 +1526,7 @@ dev_configure_and_start(uint64_t ff_disable)
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 			ts_params->valid_devs[0], qp_id,
 			&ts_params->qp_conf,
-			rte_cryptodev_socket_id(ts_params->valid_devs[0])),
+			rte_cryptodev_numa_id(ts_params->valid_devs[0])),
 			"Failed to setup queue pair %u on cryptodev %u",
 			qp_id, ts_params->valid_devs[0]);
 	}
@@ -1614,7 +1614,7 @@ ut_setup_security_rx_inject(void)
 	ret = rte_eth_rx_queue_setup(0 /* port_id */,
 				     0 /* rx_queue_id */,
 				     1024 /* nb_rx_desc */,
-				     SOCKET_ID_ANY,
+				     RTE_NUMA_ID_ANY,
 				     &rx_conf,
 				     mbuf_pool);
 	if (ret) {
@@ -1711,7 +1711,7 @@ ext_mbuf_create(struct rte_mempool *mbuf_pool, int pkt_len,
 			memzone = NULL;
 		}
 		if (memzone == NULL) {
-			memzone = rte_memzone_reserve_aligned(mz_name, buf_len, SOCKET_ID_ANY,
+			memzone = rte_memzone_reserve_aligned(mz_name, buf_len, RTE_NUMA_ID_ANY,
 				RTE_MEMZONE_IOVA_CONTIG, RTE_CACHE_LINE_SIZE);
 			if (memzone == NULL) {
 				printf("Can't allocate memory zone %s\n", mz_name);
@@ -1981,7 +1981,7 @@ test_queue_pair_descriptor_setup(void)
 	for (qp_id = 0; qp_id < ts_params->conf.nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 				ts_params->valid_devs[0], qp_id, &qp_conf,
-				rte_cryptodev_socket_id(
+				rte_cryptodev_numa_id(
 						ts_params->valid_devs[0])),
 				"Failed test for "
 				"rte_cryptodev_queue_pair_setup: num_inflights "
@@ -1995,7 +1995,7 @@ test_queue_pair_descriptor_setup(void)
 	for (qp_id = 0; qp_id < ts_params->conf.nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 				ts_params->valid_devs[0], qp_id, &qp_conf,
-				rte_cryptodev_socket_id(
+				rte_cryptodev_numa_id(
 						ts_params->valid_devs[0])),
 				"Failed test for"
 				" rte_cryptodev_queue_pair_setup: num_inflights"
@@ -2009,7 +2009,7 @@ test_queue_pair_descriptor_setup(void)
 	for (qp_id = 0; qp_id < ts_params->conf.nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 				ts_params->valid_devs[0], qp_id, &qp_conf,
-				rte_cryptodev_socket_id(
+				rte_cryptodev_numa_id(
 						ts_params->valid_devs[0])),
 				"Failed test for "
 				"rte_cryptodev_queue_pair_setup: num_inflights"
@@ -2023,7 +2023,7 @@ test_queue_pair_descriptor_setup(void)
 	for (qp_id = 0; qp_id < ts_params->conf.nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 				ts_params->valid_devs[0], qp_id, &qp_conf,
-				rte_cryptodev_socket_id(
+				rte_cryptodev_numa_id(
 						ts_params->valid_devs[0])),
 				"Failed test for"
 				" rte_cryptodev_queue_pair_setup:"
@@ -2040,7 +2040,7 @@ test_queue_pair_descriptor_setup(void)
 	TEST_ASSERT_FAIL(rte_cryptodev_queue_pair_setup(
 			ts_params->valid_devs[0],
 			qp_id, &qp_conf,
-			rte_cryptodev_socket_id(ts_params->valid_devs[0])),
+			rte_cryptodev_numa_id(ts_params->valid_devs[0])),
 			"Failed test for rte_cryptodev_queue_pair_setup:"
 			"invalid qp %u on cryptodev %u",
 			qp_id, ts_params->valid_devs[0]);
@@ -2050,7 +2050,7 @@ test_queue_pair_descriptor_setup(void)
 	TEST_ASSERT_FAIL(rte_cryptodev_queue_pair_setup(
 			ts_params->valid_devs[0],
 			qp_id, &qp_conf,
-			rte_cryptodev_socket_id(ts_params->valid_devs[0])),
+			rte_cryptodev_numa_id(ts_params->valid_devs[0])),
 			"Failed test for rte_cryptodev_queue_pair_setup:"
 			"invalid qp %u on cryptodev %u",
 			qp_id, ts_params->valid_devs[0]);
@@ -14497,7 +14497,7 @@ test_device_reconfigure(void)
 	for (qp_id = 0; qp_id < ts_params->conf.nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 				ts_params->valid_devs[0], qp_id, &qp_conf,
-				rte_cryptodev_socket_id(
+				rte_cryptodev_numa_id(
 						ts_params->valid_devs[0])),
 				"Failed test for "
 				"rte_cryptodev_queue_pair_setup: num_inflights "
@@ -14519,7 +14519,7 @@ test_device_reconfigure(void)
 	for (qp_id = 0; qp_id < ts_params->conf.nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 				ts_params->valid_devs[0], qp_id, &qp_conf,
-				rte_cryptodev_socket_id(
+				rte_cryptodev_numa_id(
 						ts_params->valid_devs[0])),
 				"Failed test for "
 				"rte_cryptodev_queue_pair_setup: num_inflights "
@@ -15277,7 +15277,7 @@ test_enq_callback_setup(void)
 
 	TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 			ts_params->valid_devs[0], qp_id, &qp_conf,
-			rte_cryptodev_socket_id(ts_params->valid_devs[0])),
+			rte_cryptodev_numa_id(ts_params->valid_devs[0])),
 			"Failed test for "
 			"rte_cryptodev_queue_pair_setup: num_inflights "
 			"%u on qp %u on cryptodev %u",
@@ -15402,7 +15402,7 @@ test_deq_callback_setup(void)
 
 	TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 			ts_params->valid_devs[0], qp_id, &qp_conf,
-			rte_cryptodev_socket_id(ts_params->valid_devs[0])),
+			rte_cryptodev_numa_id(ts_params->valid_devs[0])),
 			"Failed test for "
 			"rte_cryptodev_queue_pair_setup: num_inflights "
 			"%u on qp %u on cryptodev %u",
@@ -17712,7 +17712,7 @@ scheduler_testsuite_setup(void)
 	char temp_str[VDEV_ARGS_SIZE] = {"mode=multi-core,"
 		"ordering=enable,name=cryptodev_test_scheduler,corelist="};
 	uint16_t worker_core_count = 0;
-	uint16_t socket_id = 0;
+	uint16_t numa_id = 0;
 
 	if (gbl_driver_id == rte_cryptodev_driver_id_get(
 			RTE_STR(CRYPTODEV_NAME_SCHEDULER_PMD))) {
@@ -17735,7 +17735,7 @@ scheduler_testsuite_setup(void)
 			strcpy(temp_str, vdev_args);
 			strlcat(temp_str, ";", sizeof(temp_str));
 			worker_core_count++;
-			socket_id = rte_lcore_to_socket_id(i);
+			numa_id = rte_lcore_to_numa_id(i);
 		}
 		if (worker_core_count != 2) {
 			RTE_LOG(ERR, USER1,
@@ -17745,8 +17745,8 @@ scheduler_testsuite_setup(void)
 			return TEST_FAILED;
 		}
 		strcpy(temp_str, vdev_args);
-		ret = snprintf(vdev_args, sizeof(vdev_args), "%s,socket_id=%d", temp_str,
-			socket_id);
+		ret = snprintf(vdev_args, sizeof(vdev_args), "%s,numa_id=%d", temp_str,
+			numa_id);
 		if (ret >= VDEV_ARGS_SIZE) {
 			RTE_LOG(ERR, USER1,
 				"Cryptodev scheduler test vdev arg size exceeded\n");
@@ -17835,7 +17835,7 @@ test_scheduler_attach_worker_op(void)
 				rte_cryptodev_sym_session_pool_create(
 						"test_sess_mp",
 						MAX_NB_SESSIONS, session_size,
-						0, 0, SOCKET_ID_ANY);
+						0, 0, RTE_NUMA_ID_ANY);
 			TEST_ASSERT_NOT_NULL(ts_params->session_mpool,
 					"session mempool allocation failed");
 		}
diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index d68fe84cde..e1d63521ac 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -1130,7 +1130,7 @@ testsuite_setup(void)
 			RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
 			TEST_NUM_BUFS, 0,
 			0,
-			rte_socket_id());
+			rte_numa_id());
 	if (ts_params->op_mpool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create ASYM_CRYPTO_OP_POOL\n");
 		return TEST_FAILED;
@@ -1199,14 +1199,14 @@ testsuite_setup(void)
 	for (qp_id = 0; qp_id < info.max_nb_queue_pairs; qp_id++) {
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 			dev_id, qp_id, &ts_params->qp_conf,
-			rte_cryptodev_socket_id(dev_id)),
+			rte_cryptodev_numa_id(dev_id)),
 			"Failed to setup queue pair %u on cryptodev %u ASYM",
 			qp_id, dev_id);
 	}
 
 	ts_params->session_mpool = rte_cryptodev_asym_session_pool_create(
 			"test_asym_sess_mp", TEST_NUM_SESSIONS, 0, 0,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 
 	TEST_ASSERT_NOT_NULL(ts_params->session_mpool,
 			"session mempool allocation failed");
@@ -1262,7 +1262,7 @@ ut_setup_asym(void)
 		TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 			ts_params->valid_devs[0], qp_id,
 			&ts_params->qp_conf,
-			rte_cryptodev_socket_id(ts_params->valid_devs[0])),
+			rte_cryptodev_numa_id(ts_params->valid_devs[0])),
 			"Failed to setup queue pair %u on cryptodev %u",
 			qp_id, ts_params->valid_devs[0]);
 	}
diff --git a/app/test/test_cryptodev_crosscheck.c b/app/test/test_cryptodev_crosscheck.c
index d0ff3e0b35..f5eb20d1b3 100644
--- a/app/test/test_cryptodev_crosscheck.c
+++ b/app/test/test_cryptodev_crosscheck.c
@@ -403,7 +403,7 @@ crosscheck_init(void)
 
 	/* Create pools for mbufs, crypto operations and sessions */
 	ts_params->mbuf_pool = rte_pktmbuf_pool_create("CRYPTO_MBUFPOOL", NUM_MBUFS,
-			MBUF_CACHE_SIZE, 0, MBUF_SIZE, rte_socket_id());
+			MBUF_CACHE_SIZE, 0, MBUF_SIZE, rte_numa_id());
 	if (ts_params->mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_MBUFPOOL\n");
 		return TEST_FAILED;
@@ -412,7 +412,7 @@ crosscheck_init(void)
 	ts_params->op_mpool = rte_crypto_op_pool_create("MBUF_CRYPTO_SYM_OP_POOL",
 			RTE_CRYPTO_OP_TYPE_SYMMETRIC, NUM_MBUFS, MBUF_CACHE_SIZE,
 			DEFAULT_NUM_XFORMS * sizeof(struct rte_crypto_sym_xform) +
-			MAXIMUM_IV_LENGTH, rte_socket_id());
+			MAXIMUM_IV_LENGTH, rte_numa_id());
 
 	if (ts_params->op_mpool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_OP_POOL\n");
@@ -420,12 +420,12 @@ crosscheck_init(void)
 	}
 
 	ts_params->session_mpool = rte_cryptodev_sym_session_pool_create("test_sess_mp",
-			MAX_NB_SESSIONS, session_priv_size, 0, 0, SOCKET_ID_ANY);
+			MAX_NB_SESSIONS, session_priv_size, 0, 0, RTE_NUMA_ID_ANY);
 	TEST_ASSERT_NOT_NULL(ts_params->session_mpool, "session mempool allocation failed");
 
 	/* Setup queue pair conf params */
 	ts_params->conf.nb_queue_pairs = nb_queue_pairs;
-	ts_params->conf.numa_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = RTE_NUMA_ID_ANY;
 	ts_params->conf.ff_disable = RTE_CRYPTODEV_FF_SECURITY;
 	ts_params->qp_conf.nb_descriptors = MAX_NUM_OPS_INFLIGHT;
 	ts_params->qp_conf.mp_session = ts_params->session_mpool;
@@ -525,7 +525,7 @@ dev_configure_and_start(uint64_t ff_disable)
 		for (qp_id = 0; qp_id < ts_params->conf.nb_queue_pairs; qp_id++) {
 			TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 				dev_id, qp_id, &ts_params->qp_conf,
-				rte_cryptodev_socket_id(dev_id)),
+				rte_cryptodev_numa_id(dev_id)),
 				"Failed to setup queue pair %u on cryptodev %u",
 				qp_id, dev_id);
 		}
diff --git a/app/test/test_distributor.c b/app/test/test_distributor.c
index da0a21ea83..705a6cd06f 100644
--- a/app/test/test_distributor.c
+++ b/app/test/test_distributor.c
@@ -736,7 +736,7 @@ int test_error_distributor_create_name(void)
 	struct rte_distributor *db = NULL;
 	char *name = NULL;
 
-	d = rte_distributor_create(name, rte_socket_id(),
+	d = rte_distributor_create(name, rte_numa_id(),
 			rte_lcore_count() - 1,
 			RTE_DIST_ALG_SINGLE);
 	if (d != NULL || rte_errno != EINVAL) {
@@ -744,7 +744,7 @@ int test_error_distributor_create_name(void)
 		return -1;
 	}
 
-	db = rte_distributor_create(name, rte_socket_id(),
+	db = rte_distributor_create(name, rte_numa_id(),
 			rte_lcore_count() - 1,
 			RTE_DIST_ALG_BURST);
 	if (db != NULL || rte_errno != EINVAL) {
@@ -762,7 +762,7 @@ int test_error_distributor_create_numworkers(void)
 	struct rte_distributor *ds = NULL;
 	struct rte_distributor *db = NULL;
 
-	ds = rte_distributor_create("test_numworkers", rte_socket_id(),
+	ds = rte_distributor_create("test_numworkers", rte_numa_id(),
 			RTE_MAX_LCORE + 10,
 			RTE_DIST_ALG_SINGLE);
 	if (ds != NULL || rte_errno != EINVAL) {
@@ -770,7 +770,7 @@ int test_error_distributor_create_numworkers(void)
 		return -1;
 	}
 
-	db = rte_distributor_create("test_numworkers", rte_socket_id(),
+	db = rte_distributor_create("test_numworkers", rte_numa_id(),
 			RTE_MAX_LCORE + 10,
 			RTE_DIST_ALG_BURST);
 	if (db != NULL || rte_errno != EINVAL) {
@@ -847,7 +847,7 @@ test_distributor(void)
 	}
 
 	if (db == NULL) {
-		db = rte_distributor_create("Test_dist_burst", rte_socket_id(),
+		db = rte_distributor_create("Test_dist_burst", rte_numa_id(),
 				rte_lcore_count() - 1,
 				RTE_DIST_ALG_BURST);
 		if (db == NULL) {
@@ -861,7 +861,7 @@ test_distributor(void)
 
 	if (ds == NULL) {
 		ds = rte_distributor_create("Test_dist_single",
-				rte_socket_id(),
+				rte_numa_id(),
 				rte_lcore_count() - 1,
 			RTE_DIST_ALG_SINGLE);
 		if (ds == NULL) {
@@ -877,7 +877,7 @@ test_distributor(void)
 			(BIG_BATCH * 2) - 1 : (511 * rte_lcore_count());
 	if (p == NULL) {
 		p = rte_pktmbuf_pool_create("DT_MBUF_POOL", nb_bufs, BURST,
-			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 		if (p == NULL) {
 			printf("Error creating mempool\n");
 			return -1;
diff --git a/app/test/test_distributor_perf.c b/app/test/test_distributor_perf.c
index e678aecf77..e56297c4c0 100644
--- a/app/test/test_distributor_perf.c
+++ b/app/test/test_distributor_perf.c
@@ -226,7 +226,7 @@ test_distributor_perf(void)
 	time_cache_line_switch();
 
 	if (ds == NULL) {
-		ds = rte_distributor_create("Test_perf", rte_socket_id(),
+		ds = rte_distributor_create("Test_perf", rte_numa_id(),
 				rte_lcore_count() - 1,
 				RTE_DIST_ALG_SINGLE);
 		if (ds == NULL) {
@@ -238,7 +238,7 @@ test_distributor_perf(void)
 	}
 
 	if (db == NULL) {
-		db = rte_distributor_create("Test_burst", rte_socket_id(),
+		db = rte_distributor_create("Test_burst", rte_numa_id(),
 				rte_lcore_count() - 1,
 				RTE_DIST_ALG_BURST);
 		if (db == NULL) {
@@ -253,7 +253,7 @@ test_distributor_perf(void)
 			(BIG_BATCH * 2) - 1 : (511 * rte_lcore_count());
 	if (p == NULL) {
 		p = rte_pktmbuf_pool_create("DPT_MBUF_POOL", nb_bufs, BURST,
-			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 		if (p == NULL) {
 			printf("Error creating mempool\n");
 			return -1;
diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 1cfa8c1e10..246c99cc05 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -1132,13 +1132,13 @@ test_enq_deq_ops(int16_t dev_id, uint16_t vchan)
 		ERR_RETURN("Error with rte_dma_info_get()\n");
 
 	pkt_pool = rte_pktmbuf_pool_create("pkt_pool", info.max_desc * 2, 0, 0,
-					   CPY_LEN + RTE_PKTMBUF_HEADROOM, rte_socket_id());
+					   CPY_LEN + RTE_PKTMBUF_HEADROOM, rte_numa_id());
 	if (pkt_pool == NULL)
 		ERR_RETURN("Error creating pkt pool\n");
 
 	ops_pool = rte_mempool_create("ops_pool", info.max_desc,
 				      sizeof(struct rte_dma_op) + (sizeof(struct rte_dma_sge) * 2),
-				      0, 0, NULL, NULL, NULL, NULL, rte_socket_id(), 0);
+				      0, 0, NULL, NULL, NULL, NULL, rte_numa_id(), 0);
 	if (ops_pool == NULL)
 		ERR_RETURN("Error creating ops pool\n");
 
diff --git a/app/test/test_efd.c b/app/test/test_efd.c
index 4a4379c563..3a754b19a3 100644
--- a/app/test/test_efd.c
+++ b/app/test/test_efd.c
@@ -30,7 +30,7 @@ test_efd(void)
 #else
 #define VALUE_BITMASK ((1 << RTE_EFD_VALUE_NUM_BITS) - 1)
 #endif
-static unsigned int test_socket_id;
+static unsigned int test_numa_id;
 
 /* 5-tuple key type */
 struct __rte_packed_begin flow_key {
@@ -100,18 +100,18 @@ static struct flow_key keys[5] = {
 /* Array to store the data */
 static efd_value_t data[5];
 
-static inline uint64_t efd_get_all_sockets_bitmask(void)
+static inline uint64_t efd_get_all_numas_bitmask(void)
 {
-	uint64_t all_cpu_sockets_bitmask = 0;
+	uint64_t all_cpu_numas_bitmask = 0;
 	unsigned int i;
 	unsigned int next_lcore = rte_get_main_lcore();
 	const int val_true = 1, val_false = 0;
 	for (i = 0; i < rte_lcore_count(); i++) {
-		all_cpu_sockets_bitmask |= 1ULL << rte_lcore_to_socket_id(next_lcore);
+		all_cpu_numas_bitmask |= 1ULL << rte_lcore_to_numa_id(next_lcore);
 		next_lcore = rte_get_next_lcore(next_lcore, val_false, val_true);
 	}
 
-	return all_cpu_sockets_bitmask;
+	return all_cpu_numas_bitmask;
 }
 
 /*
@@ -130,20 +130,20 @@ static int test_add_delete(void)
 
 	handle = rte_efd_create("test_add_delete",
 			TABLE_SIZE, sizeof(struct flow_key),
-			efd_get_all_sockets_bitmask(), test_socket_id);
+			efd_get_all_numas_bitmask(), test_numa_id);
 	TEST_ASSERT_NOT_NULL(handle, "Error creating the EFD table\n");
 
 	data[0] = mrand48() & VALUE_BITMASK;
-	TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_socket_id, &keys[0],
+	TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_numa_id, &keys[0],
 			data[0]),
 			"Error inserting the key");
 	print_key_info("Add", &keys[0], data[0]);
 
-	TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_socket_id, &keys[0]),
+	TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_numa_id, &keys[0]),
 			data[0],
 			"failed to find key");
 
-	TEST_ASSERT_SUCCESS(rte_efd_delete(handle, test_socket_id, &keys[0],
+	TEST_ASSERT_SUCCESS(rte_efd_delete(handle, test_numa_id, &keys[0],
 			&prev_value),
 			"failed to delete key");
 	TEST_ASSERT_EQUAL(prev_value, data[0],
@@ -174,27 +174,27 @@ static int test_add_update_delete(void)
 
 	handle = rte_efd_create("test_add_update_delete", TABLE_SIZE,
 			sizeof(struct flow_key),
-			efd_get_all_sockets_bitmask(), test_socket_id);
+			efd_get_all_numas_bitmask(), test_numa_id);
 	TEST_ASSERT_NOT_NULL(handle, "Error creating the efd table\n");
 
-	TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_socket_id, &keys[1],
+	TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_numa_id, &keys[1],
 			data[1]), "Error inserting the key");
 	print_key_info("Add", &keys[1], data[1]);
 
-	TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_socket_id, &keys[1]),
+	TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_numa_id, &keys[1]),
 			data[1], "failed to find key");
 	print_key_info("Lkp", &keys[1], data[1]);
 
 	data[1] = data[1] + 1;
-	TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_socket_id, &keys[1],
+	TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_numa_id, &keys[1],
 			data[1]), "Error re-inserting the key");
 	print_key_info("Add", &keys[1], data[1]);
 
-	TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_socket_id, &keys[1]),
+	TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_numa_id, &keys[1]),
 			data[1], "failed to find key");
 	print_key_info("Lkp", &keys[1], data[1]);
 
-	TEST_ASSERT_SUCCESS(rte_efd_delete(handle, test_socket_id, &keys[1],
+	TEST_ASSERT_SUCCESS(rte_efd_delete(handle, test_numa_id, &keys[1],
 			&prev_value), "failed to delete key");
 	TEST_ASSERT_EQUAL(prev_value, data[1],
 			"failed to delete the expected value, got %d, "
@@ -223,7 +223,7 @@ static int test_efd_find_existing(void)
 	/* Create EFD table. */
 	handle = rte_efd_create("efd_find_existing", TABLE_SIZE,
 			sizeof(struct flow_key),
-			efd_get_all_sockets_bitmask(), test_socket_id);
+			efd_get_all_numas_bitmask(), test_numa_id);
 	TEST_ASSERT_NOT_NULL(handle, "Error creating the efd table\n");
 
 	/* Try to find existing EFD table */
@@ -259,7 +259,7 @@ static int test_five_keys(void)
 
 	handle = rte_efd_create("test_five_keys", TABLE_SIZE,
 			sizeof(struct flow_key),
-			efd_get_all_sockets_bitmask(), test_socket_id);
+			efd_get_all_numas_bitmask(), test_numa_id);
 	TEST_ASSERT_NOT_NULL(handle, "Error creating the efd table\n");
 
 	/* Setup data */
@@ -268,7 +268,7 @@ static int test_five_keys(void)
 
 	/* Add */
 	for (i = 0; i < 5; i++) {
-		TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_socket_id,
+		TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_numa_id,
 				&keys[i], data[i]),
 				"Error inserting the key");
 		print_key_info("Add", &keys[i], data[i]);
@@ -278,7 +278,7 @@ static int test_five_keys(void)
 	for (i = 0; i < 5; i++)
 		key_array[i] = &keys[i];
 
-	rte_efd_lookup_bulk(handle, test_socket_id, 5,
+	rte_efd_lookup_bulk(handle, test_numa_id, 5,
 			(void *) &key_array, result);
 
 	for (i = 0; i < 5; i++) {
@@ -294,7 +294,7 @@ static int test_five_keys(void)
 
 	/* Add - update */
 	for (i = 0; i < 5; i++) {
-		TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_socket_id,
+		TEST_ASSERT_SUCCESS(rte_efd_update(handle, test_numa_id,
 				&keys[i], data[i]),
 				"Error inserting the key");
 		print_key_info("Add", &keys[i], data[i]);
@@ -302,7 +302,7 @@ static int test_five_keys(void)
 
 	/* Lookup */
 	for (i = 0; i < 5; i++) {
-		TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_socket_id,
+		TEST_ASSERT_EQUAL(rte_efd_lookup(handle, test_numa_id,
 				&keys[i]), data[i],
 				"failed to find key");
 		print_key_info("Lkp", &keys[i], data[i]);
@@ -310,7 +310,7 @@ static int test_five_keys(void)
 
 	/* Delete */
 	for (i = 0; i < 5; i++) {
-		TEST_ASSERT_SUCCESS(rte_efd_delete(handle, test_socket_id,
+		TEST_ASSERT_SUCCESS(rte_efd_delete(handle, test_numa_id,
 				&keys[i], &prev_value),
 				"failed to delete key");
 		TEST_ASSERT_EQUAL(prev_value, data[i],
@@ -342,8 +342,8 @@ static int test_average_table_utilization(void)
 
 	for (j = 0; j < ITERATIONS; j++) {
 		handle = rte_efd_create("test_efd", num_rules_in,
-				EFD_TEST_KEY_LEN, efd_get_all_sockets_bitmask(),
-				test_socket_id);
+				EFD_TEST_KEY_LEN, efd_get_all_numas_bitmask(),
+				test_numa_id);
 		if (handle == NULL) {
 			printf("efd table creation failed\n");
 			return -1;
@@ -360,10 +360,10 @@ static int test_average_table_utilization(void)
 
 			efd_value_t val = simple_key[0];
 
-			if (rte_efd_update(handle, test_socket_id, simple_key,
+			if (rte_efd_update(handle, test_numa_id, simple_key,
 						val))
 				break; /* continue;*/
-			if (rte_efd_lookup(handle, test_socket_id, simple_key)
+			if (rte_efd_lookup(handle, test_numa_id, simple_key)
 					!= val)
 				lost_keys++;
 			else
@@ -399,7 +399,7 @@ static int test_efd_creation_with_bad_parameters(void)
 	printf("Entering %s, **Errors are expected **\n", __func__);
 
 	handle = rte_efd_create("creation_with_bad_parameters_0", TABLE_SIZE, 0,
-			efd_get_all_sockets_bitmask(), test_socket_id);
+			efd_get_all_numas_bitmask(), test_numa_id);
 	if (handle != NULL) {
 		rte_efd_free(handle);
 		printf("Impossible creating EFD table successfully "
@@ -408,7 +408,7 @@ static int test_efd_creation_with_bad_parameters(void)
 	}
 
 	handle = rte_efd_create("creation_with_bad_parameters_1", TABLE_SIZE,
-			sizeof(struct flow_key), 0, test_socket_id);
+			sizeof(struct flow_key), 0, test_numa_id);
 	if (handle != NULL) {
 		rte_efd_free(handle);
 		printf("Impossible creating EFD table successfully "
@@ -417,7 +417,7 @@ static int test_efd_creation_with_bad_parameters(void)
 	}
 
 	handle = rte_efd_create("creation_with_bad_parameters_2", TABLE_SIZE,
-			sizeof(struct flow_key), efd_get_all_sockets_bitmask(),
+			sizeof(struct flow_key), efd_get_all_numas_bitmask(),
 			255);
 	if (handle != NULL) {
 		rte_efd_free(handle);
@@ -429,13 +429,13 @@ static int test_efd_creation_with_bad_parameters(void)
 	/* test with same name should fail */
 	handle = rte_efd_create("same_name", TABLE_SIZE,
 			sizeof(struct flow_key),
-			efd_get_all_sockets_bitmask(), 0);
+			efd_get_all_numas_bitmask(), 0);
 	if (handle == NULL) {
 		printf("Cannot create first EFD table with 'same_name'\n");
 		return -1;
 	}
 	tmp = rte_efd_create("same_name", TABLE_SIZE, sizeof(struct flow_key),
-			efd_get_all_sockets_bitmask(), 0);
+			efd_get_all_numas_bitmask(), 0);
 	if (tmp != NULL) {
 		printf("Creation of EFD table with same name should fail\n");
 		rte_efd_free(handle);
@@ -452,7 +452,7 @@ static int test_efd_creation_with_bad_parameters(void)
 static int
 test_efd(void)
 {
-	test_socket_id = rte_socket_id();
+	test_numa_id = rte_numa_id();
 
 	/* Unit tests */
 	if (test_add_delete() < 0)
diff --git a/app/test/test_efd_perf.c b/app/test/test_efd_perf.c
index b212e96767..acda25e01e 100644
--- a/app/test/test_efd_perf.c
+++ b/app/test/test_efd_perf.c
@@ -37,20 +37,20 @@ test_efd_perf(void)
 #else
 #define VALUE_BITMASK ((1 << RTE_EFD_VALUE_NUM_BITS) - 1)
 #endif
-static unsigned int test_socket_id;
+static unsigned int test_numa_id;
 
-static inline uint64_t efd_get_all_sockets_bitmask(void)
+static inline uint64_t efd_get_all_numas_bitmask(void)
 {
-	uint64_t all_cpu_sockets_bitmask = 0;
+	uint64_t all_cpu_numas_bitmask = 0;
 	unsigned int i;
 	unsigned int next_lcore = rte_get_main_lcore();
 	const int val_true = 1, val_false = 0;
 	for (i = 0; i < rte_lcore_count(); i++) {
-		all_cpu_sockets_bitmask |= 1 << rte_lcore_to_socket_id(next_lcore);
+		all_cpu_numas_bitmask |= 1 << rte_lcore_to_numa_id(next_lcore);
 		next_lcore = rte_get_next_lcore(next_lcore, val_false, val_true);
 	}
 
-	return all_cpu_sockets_bitmask;
+	return all_cpu_numas_bitmask;
 }
 
 enum operations {
@@ -168,7 +168,7 @@ setup_keys_and_data(struct efd_perf_params *params, unsigned int cycle)
 
 	params->efd_table = rte_efd_create("test_efd_perf",
 			MAX_ENTRIES, params->key_size,
-			efd_get_all_sockets_bitmask(), test_socket_id);
+			efd_get_all_numas_bitmask(), test_numa_id);
 	TEST_ASSERT_NOT_NULL(params->efd_table, "Error creating the efd table\n");
 
 	return 0;
@@ -182,7 +182,7 @@ timed_adds(struct efd_perf_params *params)
 	int32_t ret;
 
 	for (i = 0; i < KEYS_TO_ADD; i++) {
-		ret = rte_efd_update(params->efd_table, test_socket_id, keys[i],
+		ret = rte_efd_update(params->efd_table, test_numa_id, keys[i],
 				data[i]);
 		if (ret != 0) {
 			printf("Error %d in rte_efd_update - key=0x", ret);
@@ -211,7 +211,7 @@ timed_lookups(struct efd_perf_params *params)
 	for (i = 0; i < NUM_LOOKUPS / KEYS_TO_ADD; i++) {
 		for (j = 0; j < KEYS_TO_ADD; j++) {
 			ret_data = rte_efd_lookup(params->efd_table,
-					test_socket_id, keys[j]);
+					test_numa_id, keys[j]);
 			if (ret_data != data[j]) {
 				printf("Value mismatch using rte_efd_lookup: "
 						"key #%d (0x", i);
@@ -248,7 +248,7 @@ timed_lookups_multi(struct efd_perf_params *params)
 			for (k = 0; k < RTE_EFD_BURST_MAX; k++)
 				keys_burst[k] = keys[j * RTE_EFD_BURST_MAX + k];
 
-			rte_efd_lookup_bulk(params->efd_table, test_socket_id,
+			rte_efd_lookup_bulk(params->efd_table, test_numa_id,
 					RTE_EFD_BURST_MAX,
 					keys_burst, result);
 
@@ -287,7 +287,7 @@ timed_deletes(struct efd_perf_params *params)
 	int32_t ret;
 
 	for (i = 0; i < KEYS_TO_ADD; i++) {
-		ret = rte_efd_delete(params->efd_table, test_socket_id, keys[i],
+		ret = rte_efd_delete(params->efd_table, test_numa_id, keys[i],
 				NULL);
 
 		if (ret != 0) {
@@ -337,7 +337,7 @@ run_all_tbl_perf_tests(void)
 	printf("Measuring performance, please wait\n");
 	fflush(stdout);
 
-	test_socket_id = rte_socket_id();
+	test_numa_id = rte_numa_id();
 
 	for (i = 0; i < NUM_KEYSIZES; i++) {
 
diff --git a/app/test/test_ethdev_api.c b/app/test/test_ethdev_api.c
index 76afd0345c..4396ab5d4b 100644
--- a/app/test/test_ethdev_api.c
+++ b/app/test/test_ethdev_api.c
@@ -30,7 +30,7 @@ ethdev_api_queue_status(void)
 		return TEST_SKIPPED;
 
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", NUM_MBUF, MBUF_CACHE_SIZE, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 
 	RTE_ETH_FOREACH_DEV(port_id) {
 		memset(&eth_conf, 0, sizeof(eth_conf));
@@ -41,7 +41,7 @@ ethdev_api_queue_status(void)
 		/* RxQ setup */
 		for (uint16_t queue_id = 0; queue_id < NUM_RXQ; queue_id++) {
 			ret = rte_eth_rx_queue_setup(port_id, queue_id, NUM_RXD,
-				rte_socket_id(), NULL,  mbuf_pool);
+				rte_numa_id(), NULL,  mbuf_pool);
 			TEST_ASSERT(ret == 0,
 				"Port(%u), queue(%u) failed to setup RxQ.\n",
 				port_id, queue_id);
@@ -50,7 +50,7 @@ ethdev_api_queue_status(void)
 		/* TxQ setup */
 		for (uint16_t queue_id = 0; queue_id < NUM_TXQ; queue_id++) {
 			ret = rte_eth_tx_queue_setup(port_id, queue_id, NUM_TXD,
-				rte_socket_id(), NULL);
+				rte_numa_id(), NULL);
 			TEST_ASSERT(ret == 0,
 				"Port(%u), queue(%u) failed to setup TxQ.\n",
 				port_id, queue_id);
diff --git a/app/test/test_event_crypto_adapter.c b/app/test/test_event_crypto_adapter.c
index cac1584f40..aaf7d1b29d 100644
--- a/app/test/test_event_crypto_adapter.c
+++ b/app/test/test_event_crypto_adapter.c
@@ -1052,7 +1052,7 @@ configure_cryptodev(void)
 	params.mbuf_pool = rte_pktmbuf_pool_create(
 			"CRYPTO_ADAPTER_MBUFPOOL",
 			NUM_MBUFS, MBUF_CACHE_SIZE, 0, MBUF_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 	if (params.mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_MBUFPOOL\n");
 		return TEST_FAILED;
@@ -1066,7 +1066,7 @@ configure_cryptodev(void)
 			sizeof(struct rte_crypto_sym_xform) +
 			MAXIMUM_IV_LENGTH +
 			sizeof(union rte_event_crypto_metadata),
-			rte_socket_id());
+			rte_numa_id());
 	if (params.op_mpool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_OP_POOL\n");
 		return TEST_FAILED;
@@ -1100,7 +1100,7 @@ configure_cryptodev(void)
 			"CRYPTO_ADAPTER_SESSION_MP",
 			MAX_NB_SESSIONS, session_size, 0,
 			sizeof(union rte_event_crypto_metadata),
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 	TEST_ASSERT_NOT_NULL(params.session_mpool,
 			"session mempool allocation failed\n");
 
@@ -1116,7 +1116,7 @@ configure_cryptodev(void)
 				(DEFAULT_NUM_XFORMS *
 				sizeof(struct rte_crypto_asym_xform)) +
 				sizeof(union rte_event_crypto_metadata),
-				rte_socket_id());
+				rte_numa_id());
 			TEST_ASSERT_NOT_NULL(params.asym_op_mpool,
 					"Can't create CRYPTO_ASYM_OP_POOL\n");
 
@@ -1125,7 +1125,7 @@ configure_cryptodev(void)
 					"CRYPTO_AD_ASYM_SESS_MP",
 					MAX_NB_SESSIONS, 0,
 					sizeof(union rte_event_crypto_metadata),
-					SOCKET_ID_ANY);
+					RTE_NUMA_ID_ANY);
 			TEST_ASSERT_NOT_NULL(params.asym_sess_mpool,
 				"asym session mempool allocation failed\n");
 			break;
@@ -1133,7 +1133,7 @@ configure_cryptodev(void)
 	}
 
 	conf.nb_queue_pairs = info.max_nb_queue_pairs;
-	conf.socket_id = SOCKET_ID_ANY;
+	conf.numa_id = RTE_NUMA_ID_ANY;
 	conf.ff_disable = RTE_CRYPTODEV_FF_SECURITY;
 
 	TEST_ASSERT_SUCCESS(rte_cryptodev_configure(TEST_CDEV_ID, &conf),
@@ -1145,7 +1145,7 @@ configure_cryptodev(void)
 
 	TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 			TEST_CDEV_ID, TEST_CDEV_QP_ID, &qp_conf,
-			rte_cryptodev_socket_id(TEST_CDEV_ID)),
+			rte_cryptodev_numa_id(TEST_CDEV_ID)),
 			"Failed to setup queue pair %u on cryptodev %u\n",
 			TEST_CDEV_QP_ID, TEST_CDEV_ID);
 
diff --git a/app/test/test_event_dma_adapter.c b/app/test/test_event_dma_adapter.c
index be1e05af5b..7d1b2f9905 100644
--- a/app/test/test_event_dma_adapter.c
+++ b/app/test/test_event_dma_adapter.c
@@ -389,17 +389,17 @@ configure_dmadev(void)
 
 	params.src_mbuf_pool = rte_pktmbuf_pool_create("DMA_ADAPTER_SRC_MBUFPOOL", NUM_MBUFS,
 						       MBUF_CACHE_SIZE, 0, MBUF_SIZE,
-						       rte_socket_id());
+						       rte_numa_id());
 	RTE_TEST_ASSERT_NOT_NULL(params.src_mbuf_pool, "Can't create DMA_SRC_MBUFPOOL\n");
 
 	params.dst_mbuf_pool = rte_pktmbuf_pool_create("DMA_ADAPTER_DST_MBUFPOOL", NUM_MBUFS,
 						       MBUF_CACHE_SIZE, 0, MBUF_SIZE,
-						       rte_socket_id());
+						       rte_numa_id());
 	RTE_TEST_ASSERT_NOT_NULL(params.dst_mbuf_pool, "Can't create DMA_DST_MBUFPOOL\n");
 
 	elt_size = sizeof(struct rte_dma_op) + (sizeof(struct rte_dma_sge) * 2);
 	params.op_mpool = rte_mempool_create("EVENT_DMA_OP_POOL", DMA_OP_POOL_SIZE, elt_size, 0,
-					     0, NULL, NULL, NULL, NULL, rte_socket_id(), 0);
+					     0, NULL, NULL, NULL, NULL, rte_numa_id(), 0);
 	RTE_TEST_ASSERT_NOT_NULL(params.op_mpool, "Can't create DMA_OP_POOL\n");
 
 	return TEST_SUCCESS;
diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index 7b38935bec..6894093e15 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -86,7 +86,7 @@ port_init_common(uint16_t port, const struct rte_eth_conf *port_conf,
 
 		for (q = 0; q < default_params.rx_rings; q++) {
 			retval = rte_eth_rx_queue_setup(port, q, rx_ring_size,
-					rte_eth_dev_socket_id(port), NULL, mp);
+					rte_eth_dev_numa_id(port), NULL, mp);
 			if (retval < 0)
 				return retval;
 		}
@@ -94,7 +94,7 @@ port_init_common(uint16_t port, const struct rte_eth_conf *port_conf,
 		/* Allocate and set up 1 TX queue per Ethernet port. */
 		for (q = 0; q < default_params.tx_rings; q++) {
 			retval = rte_eth_tx_queue_setup(port, q, tx_ring_size,
-					rte_eth_dev_socket_id(port), NULL);
+					rte_eth_dev_numa_id(port), NULL);
 			if (retval < 0)
 				return retval;
 		}
@@ -170,7 +170,7 @@ init_port_rx_intr(int num_ports)
 						   MBUF_CACHE_SIZE,
 						   MBUF_PRIV_SIZE,
 						   RTE_MBUF_DEFAULT_BUF_SIZE,
-						   rte_socket_id());
+						   rte_numa_id());
 	if (!default_params.mp)
 		return -ENOMEM;
 
@@ -209,7 +209,7 @@ init_ports(int num_ports)
 						MBUF_CACHE_SIZE,
 						MBUF_PRIV_SIZE,
 						RTE_MBUF_DEFAULT_BUF_SIZE,
-						rte_socket_id());
+						rte_numa_id());
 	else
 		default_params.mp = ptr;
 
diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
index 0c161897ce..24b47e46f4 100644
--- a/app/test/test_event_eth_tx_adapter.c
+++ b/app/test/test_event_eth_tx_adapter.c
@@ -79,14 +79,14 @@ port_init_common(uint16_t port, const struct rte_eth_conf *port_conf,
 
 	for (q = 0; q < default_params.rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, rx_ring_size,
-				rte_eth_dev_socket_id(port), NULL, mp);
+				rte_eth_dev_numa_id(port), NULL, mp);
 		if (retval < 0)
 			return retval;
 	}
 
 	for (q = 0; q < default_params.tx_rings; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, tx_ring_size,
-				rte_eth_dev_socket_id(port), NULL);
+				rte_eth_dev_numa_id(port), NULL);
 		if (retval < 0)
 			return retval;
 	}
@@ -135,7 +135,7 @@ init_ports(void)
 	if (!default_params.mp)
 		default_params.mp = rte_pktmbuf_pool_create("mbuf_pool",
 			NB_MBUF, 32,
-			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 
 	if (!default_params.mp)
 		return -ENOMEM;
diff --git a/app/test/test_event_ring.c b/app/test/test_event_ring.c
index 596faa4e30..b9f9e99118 100644
--- a/app/test/test_event_ring.c
+++ b/app/test/test_event_ring.c
@@ -42,13 +42,13 @@ test_event_ring_creation_with_wrong_size(void)
 
 	/* Test if ring size is not power of 2 */
 	rp = rte_event_ring_create("test_bad_ring_size", RING_SIZE + 1,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	if (rp != NULL)
 		return -1;
 
 	/* Test if ring size is exceeding the limit */
 	rp = rte_event_ring_create("test_bad_ring_size", (RTE_RING_SZ_MASK + 1),
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	if (rp != NULL)
 		return -1;
 	return 0;
@@ -62,7 +62,7 @@ static int
 test_create_count_odd(void)
 {
 	struct rte_event_ring *r = rte_event_ring_create("test_event_ring_count",
-			4097, SOCKET_ID_ANY, 0);
+			4097, RTE_NUMA_ID_ANY, 0);
 	if (r != NULL)
 		return -1;
 	return 0;
@@ -87,7 +87,7 @@ test_basic_event_enqueue_dequeue(void)
 	uint16_t ret, free_count, used_count;
 
 	memset(evs, 0, sizeof(evs));
-	sr = rte_event_ring_create("spsc_ring", 32, rte_socket_id(),
+	sr = rte_event_ring_create("spsc_ring", 32, rte_numa_id(),
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 	if (sr == NULL) {
 		printf("Failed to create sp/sc ring\n");
@@ -151,14 +151,14 @@ test_event_ring_with_exact_size(void)
 	static const unsigned int ring_sz = RTE_DIM(ev_array);
 	unsigned int i;
 
-	std_ring = rte_event_ring_create("std", ring_sz, rte_socket_id(),
+	std_ring = rte_event_ring_create("std", ring_sz, rte_numa_id(),
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 	if (std_ring == NULL) {
 		printf("%s: error, can't create std ring\n", __func__);
 		return -1;
 	}
 	exact_sz_ring = rte_event_ring_create("exact sz",
-			ring_sz, rte_socket_id(),
+			ring_sz, rte_numa_id(),
 			RING_F_SP_ENQ | RING_F_SC_DEQ | RING_F_EXACT_SZ);
 	if (exact_sz_ring == NULL) {
 		printf("%s: error, can't create exact size ring\n", __func__);
@@ -218,7 +218,7 @@ test_event_ring(void)
 {
 	if (r == NULL)
 		r = rte_event_ring_create("ev_test", RING_SIZE,
-				SOCKET_ID_ANY, 0);
+				RTE_NUMA_ID_ANY, 0);
 	if (r == NULL)
 		return -1;
 
diff --git a/app/test/test_event_timer_adapter.c b/app/test/test_event_timer_adapter.c
index bf5ff56bed..af12bc19e1 100644
--- a/app/test/test_event_timer_adapter.c
+++ b/app/test/test_event_timer_adapter.c
@@ -338,7 +338,7 @@ _timdev_setup(uint64_t max_tmo_ns, uint64_t bkt_tck_ns, uint64_t flags)
 			sizeof(struct rte_event_timer), /* element size*/
 			0, /* cache size*/
 			0, NULL, NULL, NULL, NULL,
-			rte_socket_id(), 0);
+			rte_numa_id(), 0);
 	if (!eventdev_test_mempool) {
 		printf("ERROR creating mempool\n");
 		return TEST_FAILED;
@@ -995,7 +995,7 @@ test_timer_cancel_multicore(void)
 {
 	arm_done = 0;
 	timer_producer_ring = rte_ring_create("timer_cancel_queue",
-			MAX_TIMERS * 2, rte_socket_id(), 0);
+			MAX_TIMERS * 2, rte_numa_id(), 0);
 	TEST_ASSERT_NOT_NULL(timer_producer_ring,
 			"Unable to reserve memory for ring");
 
@@ -1021,7 +1021,7 @@ test_timer_cancel_burst_multicore(void)
 {
 	arm_done = 0;
 	timer_producer_ring = rte_ring_create("timer_cancel_queue",
-			MAX_TIMERS * 2, rte_socket_id(), 0);
+			MAX_TIMERS * 2, rte_numa_id(), 0);
 	TEST_ASSERT_NOT_NULL(timer_producer_ring,
 			"Unable to reserve memory for ring");
 
diff --git a/app/test/test_event_vector_adapter.c b/app/test/test_event_vector_adapter.c
index c6d694421b..606db8105c 100644
--- a/app/test/test_event_vector_adapter.c
+++ b/app/test/test_event_vector_adapter.c
@@ -86,12 +86,12 @@ test_event_vector_adapter_create_multi(void)
 	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
 
 	vector_mp = rte_event_vector_pool_create("vector_mp", MAX_EVENTS, 0, MAX_VECTOR_SIZE,
-						 rte_socket_id());
+						 rte_numa_id());
 
 	TEST_ASSERT(vector_mp != NULL, "Failed to create mempool");
 
 	conf.event_dev_id = evdev;
-	conf.socket_id = rte_socket_id();
+	conf.numa_id = rte_numa_id();
 	conf.vector_sz = RTE_MIN(MAX_VECTOR_SIZE, info.max_vector_sz);
 	conf.vector_timeout_ns = info.max_vector_timeout_ns;
 	conf.vector_mp = vector_mp;
@@ -140,11 +140,11 @@ test_event_vector_adapter_create(void)
 	TEST_ASSERT_SUCCESS(ret, "Failed to get event vector adapter info");
 
 	vector_mp = rte_event_vector_pool_create("vector_mp", MAX_EVENTS, 0, MAX_VECTOR_SIZE,
-						 rte_socket_id());
+						 rte_numa_id());
 	TEST_ASSERT(vector_mp != NULL, "Failed to create mempool");
 
 	conf.event_dev_id = evdev;
-	conf.socket_id = rte_socket_id();
+	conf.numa_id = rte_numa_id();
 	conf.vector_sz = RTE_MIN(MAX_VECTOR_SIZE, info.max_vector_sz);
 	conf.vector_timeout_ns = RTE_MIN(1E6, info.max_vector_timeout_ns);
 	conf.vector_mp = vector_mp;
diff --git a/app/test/test_eventdev.c b/app/test/test_eventdev.c
index 1241da38cb..af7e0a773f 100644
--- a/app/test/test_eventdev.c
+++ b/app/test/test_eventdev.c
@@ -70,14 +70,14 @@ test_eventdev_get_dev_id(void)
 }
 
 static int
-test_eventdev_socket_id(void)
+test_eventdev_numa_id(void)
 {
-	int socket_id;
-	socket_id = rte_event_dev_socket_id(TEST_DEV_ID);
-	TEST_ASSERT(socket_id != -EINVAL, "Failed to get socket_id %d",
-				socket_id);
-	socket_id = rte_event_dev_socket_id(RTE_EVENT_MAX_DEVS);
-	TEST_ASSERT(socket_id == -EINVAL, "Expected -EINVAL %d", socket_id);
+	int numa_id;
+	numa_id = rte_event_dev_numa_id(TEST_DEV_ID);
+	TEST_ASSERT(numa_id != -EINVAL, "Failed to get numa_id %d",
+				numa_id);
+	numa_id = rte_event_dev_numa_id(RTE_EVENT_MAX_DEVS);
+	TEST_ASSERT(numa_id == -EINVAL, "Expected -EINVAL %d", numa_id);
 
 	return TEST_SUCCESS;
 }
@@ -1407,7 +1407,7 @@ static struct unit_test_suite eventdev_common_testsuite  = {
 		TEST_CASE_ST(NULL, NULL,
 			test_eventdev_get_dev_id),
 		TEST_CASE_ST(NULL, NULL,
-			test_eventdev_socket_id),
+			test_eventdev_numa_id),
 		TEST_CASE_ST(NULL, NULL,
 			test_eventdev_info_get),
 		TEST_CASE_ST(NULL, NULL,
diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index 8e6313f4e9..5ee1e05c6f 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -285,7 +285,7 @@ test_malloc_basic(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 {
 	const char *heap_name = "heap";
 	void *ptr = NULL;
-	int socket_id;
+	int numa_id;
 	const struct rte_memzone *mz = NULL, *contig_mz = NULL;
 
 	/* create heap */
@@ -296,15 +296,15 @@ test_malloc_basic(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 	}
 
 	/* get socket ID corresponding to this heap */
-	socket_id = rte_malloc_heap_get_numa_id(heap_name);
-	if (socket_id < 0) {
+	numa_id = rte_malloc_heap_get_numa_id(heap_name);
+	if (numa_id < 0) {
 		printf("%s():%i: cannot find socket for external heap\n",
 			__func__, __LINE__);
 		goto fail;
 	}
 
 	/* heap is empty, so any allocation should fail */
-	ptr = rte_malloc_socket("EXTMEM", 64, 0, socket_id);
+	ptr = rte_malloc_numa("EXTMEM", 64, 0, numa_id);
 	if (ptr != NULL) {
 		printf("%s():%i: Allocated from empty heap\n", __func__,
 			__LINE__);
@@ -324,7 +324,7 @@ test_malloc_basic(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 		goto fail;
 
 	/* allocate - this now should succeed */
-	ptr = rte_malloc_socket("EXTMEM", 64, 0, socket_id);
+	ptr = rte_malloc_numa("EXTMEM", 64, 0, numa_id);
 	if (ptr == NULL) {
 		printf("%s():%i: Failed to allocate from external heap\n",
 			__func__, __LINE__);
@@ -352,7 +352,7 @@ test_malloc_basic(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 	}
 
 	/* try allocating a memzone */
-	mz = rte_memzone_reserve("heap_test", pgsz * 2, socket_id, 0);
+	mz = rte_memzone_reserve("heap_test", pgsz * 2, numa_id, 0);
 	if (mz == NULL) {
 		printf("%s():%i: Failed to reserve memzone\n",
 			__func__, __LINE__);
@@ -361,7 +361,7 @@ test_malloc_basic(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 	/* try allocating an IOVA-contiguous memzone - this should succeed
 	 * if we've set up a contiguous IOVA table, and fail if we haven't.
 	 */
-	contig_mz = rte_memzone_reserve("heap_test_contig", pgsz * 2, socket_id,
+	contig_mz = rte_memzone_reserve("heap_test_contig", pgsz * 2, numa_id,
 			RTE_MEMZONE_IOVA_CONTIG);
 	if ((iova == NULL) != (contig_mz == NULL)) {
 		printf("%s():%i: Failed to reserve memzone\n",
diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bd73399d56..f87e3942ca 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -44,29 +44,29 @@ test_create_invalid(void)
 	config.type = RTE_FIB_DUMMY;
 
 	/* rte_fib_create: fib name == NULL */
-	fib = rte_fib_create(NULL, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(NULL, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib_create: config == NULL */
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, NULL);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, NULL);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
-	/* socket_id < -1 is invalid */
+	/* numa_id < -1 is invalid */
 	fib = rte_fib_create(__func__, -2, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib_create: max_routes = 0 */
 	config.max_routes = 0;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.max_routes = MAX_ROUTES;
 
 	config.type = RTE_FIB_DIR24_8 + 1;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -74,13 +74,13 @@ test_create_invalid(void)
 	config.dir24_8.num_tbl8 = MAX_TBL8;
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B + 1;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
 
 	config.dir24_8.num_tbl8 = 0;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -104,7 +104,7 @@ test_multiple_create(void)
 
 	for (i = 0; i < 100; i++) {
 		config.max_routes = MAX_ROUTES - i;
-		fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+		fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 		RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 		rte_fib_free(fib);
 	}
@@ -129,7 +129,7 @@ test_free_null(void)
 	config.default_nh = 0;
 	config.type = RTE_FIB_DUMMY;
 
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	rte_fib_free(fib);
@@ -167,7 +167,7 @@ test_add_del_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/*Create valid fib to use in rest of test. */
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* rte_fib_add: depth > RTE_FIB_MAXDEPTH */
@@ -331,7 +331,7 @@ test_lookup(void)
 	config.default_nh = def_nh;
 	config.type = RTE_FIB_DUMMY;
 
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -342,7 +342,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_1B;
 	config.dir24_8.num_tbl8 = 127;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -351,7 +351,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_2B;
 	config.dir24_8.num_tbl8 = MAX_TBL8 - 1;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -360,7 +360,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	config.dir24_8.num_tbl8 = MAX_TBL8;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -369,7 +369,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
 	config.dir24_8.num_tbl8 = MAX_TBL8;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -401,13 +401,13 @@ test_invalid_rcu(void)
 	config.rib_ext_sz = 0;
 	config.default_nh = def_nh;
 
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
-	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
-		SOCKET_ID_ANY);
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz, RTE_CACHE_LINE_SIZE,
+		RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
 
 	status = rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE);
@@ -426,7 +426,7 @@ test_invalid_rcu(void)
 	config.type = RTE_FIB_DIR24_8;
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	config.dir24_8.num_tbl8 = MAX_TBL8;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Call rte_fib_rcu_qsbr_add without fib or config */
@@ -447,8 +447,8 @@ test_invalid_rcu(void)
 	RTE_TEST_ASSERT(status == 0, "Can not attach RCU to FIB\n");
 
 	/* Create and attach another RCU QSBR to FIB table */
-	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
-		SOCKET_ID_ANY);
+	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz, RTE_CACHE_LINE_SIZE,
+		RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(qsv2 != NULL, "Can not allocate memory for RCU\n");
 
 	rcu_cfg.v = qsv2;
@@ -532,13 +532,13 @@ test_fib_rcu_sync_rw(void)
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	config.dir24_8.num_tbl8 = 1;
 
-	g_fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	g_fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(g_fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(1);
-	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
-		SOCKET_ID_ANY);
+	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz, RTE_CACHE_LINE_SIZE,
+		RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(g_v != NULL, "Can not allocate memory for RCU\n");
 
 	status = rte_rcu_qsbr_init(g_v, 1);
diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index d33226d016..a9ee82c1dd 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -54,29 +54,29 @@ test_create_invalid(void)
 	config.type = RTE_FIB6_DUMMY;
 
 	/* rte_fib6_create: fib name == NULL */
-	fib = rte_fib6_create(NULL, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(NULL, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib6_create: config == NULL */
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, NULL);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, NULL);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
-	/* socket_id < -1 is invalid */
+	/* numa_id < -1 is invalid */
 	fib = rte_fib6_create(__func__, -2, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib6_create: max_routes = 0 */
 	config.max_routes = 0;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.max_routes = MAX_ROUTES;
 
 	config.type = RTE_FIB6_TRIE + 1;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -84,13 +84,13 @@ test_create_invalid(void)
 	config.trie.num_tbl8 = MAX_TBL8;
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_8B + 1;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.trie.nh_sz = RTE_FIB6_TRIE_8B;
 
 	config.trie.num_tbl8 = 0;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -114,7 +114,7 @@ test_multiple_create(void)
 
 	for (i = 0; i < 100; i++) {
 		config.max_routes = MAX_ROUTES - i;
-		fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+		fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 		RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 		rte_fib6_free(fib);
 	}
@@ -139,7 +139,7 @@ test_free_null(void)
 	config.default_nh = 0;
 	config.type = RTE_FIB6_DUMMY;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	rte_fib6_free(fib);
@@ -178,7 +178,7 @@ test_add_del_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/*Create valid fib to use in rest of test. */
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* rte_fib6_add: depth > RTE_IPV6_MAX_DEPTH */
@@ -359,7 +359,7 @@ test_lookup(void)
 	config.default_nh = def_nh;
 	config.type = RTE_FIB6_DUMMY;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -370,7 +370,7 @@ test_lookup(void)
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = MAX_TBL8 - 1;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -379,7 +379,7 @@ test_lookup(void)
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
 	config.trie.num_tbl8 = MAX_TBL8;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -388,7 +388,7 @@ test_lookup(void)
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_8B;
 	config.trie.num_tbl8 = MAX_TBL8;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -420,13 +420,13 @@ test_invalid_rcu(void)
 	config.rib_ext_sz = 0;
 	config.default_nh = def_nh;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
-	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
-		SOCKET_ID_ANY);
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz, RTE_CACHE_LINE_SIZE,
+		RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
 
 	status = rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE);
@@ -445,7 +445,7 @@ test_invalid_rcu(void)
 	config.type = RTE_FIB6_TRIE;
 	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
 	config.trie.num_tbl8 = MAX_TBL8;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Call rte_fib6_rcu_qsbr_add without fib or config */
@@ -466,8 +466,8 @@ test_invalid_rcu(void)
 	RTE_TEST_ASSERT(status == 0, "Can not attach RCU to FIB\n");
 
 	/* Create and attach another RCU QSBR to FIB table */
-	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
-		SOCKET_ID_ANY);
+	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz, RTE_CACHE_LINE_SIZE,
+		RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(qsv2 != NULL, "Can not allocate memory for RCU\n");
 
 	rcu_cfg.v = qsv2;
@@ -551,13 +551,13 @@ test_fib_rcu_sync_rw(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
 	config.trie.num_tbl8 = 1;
 
-	g_fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	g_fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(g_fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(1);
-	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
-		SOCKET_ID_ANY);
+	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz, RTE_CACHE_LINE_SIZE,
+		RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(g_v != NULL, "Can not allocate memory for RCU\n");
 
 	status = rte_rcu_qsbr_init(g_v, 1);
@@ -645,7 +645,7 @@ test_drift(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	ret = rte_fib6_add(fib, &parent, 28, 0xa);
@@ -709,7 +709,7 @@ test_drift_compression(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Compressed: child shares the parent's nh, modify_dp is skipped */
@@ -770,7 +770,7 @@ test_drift_multilevel(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	ret = rte_fib6_add(fib, &grand, 28, 1);
@@ -834,7 +834,7 @@ test_drift_stress(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	for (i = 0; i < 2000; i++) {
@@ -905,7 +905,7 @@ test_drift_tight_pool(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 3;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	ret = rte_fib6_add(fib, &parent, 28, 1);
diff --git a/app/test/test_fib6_perf.c b/app/test/test_fib6_perf.c
index 246bc2d509..f0b65e7886 100644
--- a/app/test/test_fib6_perf.c
+++ b/app/test/test_fib6_perf.c
@@ -100,7 +100,7 @@ test_fib6_perf(void)
 	 */
 	generate_large_ips_table(0);
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &conf);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &conf);
 	TEST_FIB_ASSERT(fib != NULL);
 
 	/* Measure add. */
diff --git a/app/test/test_fib_perf.c b/app/test/test_fib_perf.c
index 1b2ad04854..bf190d7541 100644
--- a/app/test/test_fib_perf.c
+++ b/app/test/test_fib_perf.c
@@ -341,7 +341,7 @@ test_fib_perf(void)
 	print_route_distribution(large_route_table,
 		(uint32_t) NUM_ROUTE_ENTRIES);
 
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_FIB_ASSERT(fib != NULL);
 
 	/* Measure add. */
diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index ee65422054..212e682a7c 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -115,7 +115,7 @@ ring_create_lookup(__rte_unused void *arg)
 
 	/* create the same ring simultaneously on all threads */
 	for (i = 0; i < MAX_ITER_ONCE; i++) {
-		rp = rte_ring_create("fr_test_once", 4096, SOCKET_ID_ANY, 0);
+		rp = rte_ring_create("fr_test_once", 4096, RTE_NUMA_ID_ANY, 0);
 		if (rp != NULL)
 			rte_atomic_fetch_add_explicit(&obj_count, 1, rte_memory_order_relaxed);
 	}
@@ -123,7 +123,7 @@ ring_create_lookup(__rte_unused void *arg)
 	/* create/lookup new ring several times */
 	for (i = 0; i < MAX_ITER_MULTI; i++) {
 		snprintf(ring_name, sizeof(ring_name), "fr_test_%d_%d", lcore_self, i);
-		rp = rte_ring_create(ring_name, 4096, SOCKET_ID_ANY, 0);
+		rp = rte_ring_create(ring_name, 4096, RTE_NUMA_ID_ANY, 0);
 		if (NULL == rp)
 			return -1;
 		if (rte_ring_lookup(ring_name) != rp)
@@ -180,7 +180,7 @@ mempool_create_lookup(__rte_unused void *arg)
 					MEMPOOL_ELT_SIZE, 0, 0,
 					NULL, NULL,
 					my_obj_init, NULL,
-					SOCKET_ID_ANY, 0);
+					RTE_NUMA_ID_ANY, 0);
 		if (mp != NULL)
 			rte_atomic_fetch_add_explicit(&obj_count, 1, rte_memory_order_relaxed);
 	}
@@ -192,7 +192,7 @@ mempool_create_lookup(__rte_unused void *arg)
 						MEMPOOL_ELT_SIZE, 0, 0,
 						NULL, NULL,
 						my_obj_init, NULL,
-						SOCKET_ID_ANY, 0);
+						RTE_NUMA_ID_ANY, 0);
 		if (NULL == mp)
 			return -1;
 		if (rte_mempool_lookup(mempool_name) != mp)
@@ -378,7 +378,7 @@ lpm_create_free(__rte_unused void *arg)
 
 	/* create the same lpm simultaneously on all threads */
 	for (i = 0; i < MAX_ITER_ONCE; i++) {
-		lpm = rte_lpm_create("fr_test_once",  SOCKET_ID_ANY, &config);
+		lpm = rte_lpm_create("fr_test_once",  RTE_NUMA_ID_ANY, &config);
 		if (lpm != NULL)
 			rte_atomic_fetch_add_explicit(&obj_count, 1, rte_memory_order_relaxed);
 	}
@@ -386,7 +386,7 @@ lpm_create_free(__rte_unused void *arg)
 	/* create multiple fbk tables simultaneously */
 	for (i = 0; i < MAX_LPM_ITER_TIMES; i++) {
 		snprintf(lpm_name, sizeof(lpm_name), "fr_test_%d_%d", lcore_self, i);
-		lpm = rte_lpm_create(lpm_name, SOCKET_ID_ANY, &config);
+		lpm = rte_lpm_create(lpm_name, RTE_NUMA_ID_ANY, &config);
 		if (NULL == lpm)
 			return -1;
 
diff --git a/app/test/test_graph_perf.c b/app/test/test_graph_perf.c
index 8801714453..ec695a4b0d 100644
--- a/app/test/test_graph_perf.c
+++ b/app/test/test_graph_perf.c
@@ -572,7 +572,7 @@ graph_init(const char *gname, uint8_t nb_srcs, uint8_t nb_sinks,
 	}
 
 	/* Create a Graph */
-	gconf.socket_id = SOCKET_ID_ANY;
+	gconf.numa_id = RTE_NUMA_ID_ANY;
 	gconf.nb_node_patterns = graph_data->nb_nodes;
 	gconf.node_patterns = (const char **)(uintptr_t)node_patterns;
 
@@ -646,7 +646,7 @@ measure_perf_get(rte_graph_t graph_id)
 	if (rte_graph_has_stats_feature()) {
 		memset(&param, 0, sizeof(param));
 		param.f = stdout;
-		param.socket_id = SOCKET_ID_ANY;
+		param.numa_id = RTE_NUMA_ID_ANY;
 		param.graph_patterns = &pattern;
 		param.nb_graph_patterns = 1;
 
@@ -1143,7 +1143,7 @@ graph_init_diamond(void)
 	node_patterns[3] = rte_node_id_to_name(branch);
 	node_patterns[4] = rte_node_id_to_name(snk);
 
-	gconf.socket_id = SOCKET_ID_ANY;
+	gconf.numa_id = RTE_NUMA_ID_ANY;
 	gconf.nb_node_patterns = 5;
 	gconf.node_patterns = (const char **)(uintptr_t)node_patterns;
 
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index de7fc414e3..0cb1fb9741 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -2012,8 +2012,8 @@ test_hash_rcu_qsbr_add(void)
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
-	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	RETURN_IF_ERROR_RCU_QSBR(g_qsv == NULL,
 				 "RCU QSBR variable creation failed");
 
@@ -2034,8 +2034,8 @@ test_hash_rcu_qsbr_add(void)
 				 "Attach RCU QSBR to hash table failed");
 
 	/* Create and attach another RCU QSBR to hash table */
-	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	RETURN_IF_ERROR_RCU_QSBR(qsv2 == NULL,
 				 "RCU QSBR variable creation failed");
 
@@ -2116,8 +2116,8 @@ test_hash_rcu_qsbr_dq_mode(uint8_t ext_bkt)
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
-	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	RETURN_IF_ERROR_RCU_QSBR(g_qsv == NULL,
 				 "RCU QSBR variable creation failed");
 
@@ -2286,8 +2286,8 @@ test_hash_rcu_qsbr_sync_mode(uint8_t ext_bkt)
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
-	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	RETURN_IF_ERROR_RCU_QSBR(g_qsv == NULL,
 				 "RCU QSBR variable creation failed");
 
@@ -2376,8 +2376,8 @@ test_hash_rcu_qsbr_dq_reclaim(void)
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
-	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(
-			NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	g_qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(
+			NULL, sz, RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	RETURN_IF_ERROR_RCU_QSBR(g_qsv == NULL, "RCU QSBR variable creation failed");
 
 	status = rte_rcu_qsbr_init(g_qsv, RTE_MAX_LCORE);
diff --git a/app/test/test_ipfrag.c b/app/test/test_ipfrag.c
index 247575d6c5..801f91691b 100644
--- a/app/test/test_ipfrag.c
+++ b/app/test/test_ipfrag.c
@@ -65,7 +65,7 @@ setup_buf_pool(void)
 	pkt_pool = rte_pktmbuf_pool_create("FRAG_MBUF_POOL",
 					   NUM_MBUFS, BURST, 0,
 					   RTE_MBUF_DEFAULT_BUF_SIZE,
-					   SOCKET_ID_ANY);
+					   RTE_NUMA_ID_ANY);
 	if (pkt_pool == NULL) {
 		printf("%s: Error creating pkt mempool\n", __func__);
 		goto bad_setup;
@@ -74,7 +74,7 @@ setup_buf_pool(void)
 	direct_pool = rte_pktmbuf_pool_create("FRAG_D_MBUF_POOL",
 					      NUM_MBUFS, BURST, 0,
 					      RTE_MBUF_DEFAULT_BUF_SIZE,
-					      SOCKET_ID_ANY);
+					      RTE_NUMA_ID_ANY);
 	if (direct_pool == NULL) {
 		printf("%s: Error creating direct mempool\n", __func__);
 		goto bad_setup;
@@ -82,7 +82,7 @@ setup_buf_pool(void)
 
 	indirect_pool = rte_pktmbuf_pool_create("FRAG_I_MBUF_POOL",
 						NUM_MBUFS, BURST, 0,
-						0, SOCKET_ID_ANY);
+						0, RTE_NUMA_ID_ANY);
 	if (indirect_pool == NULL) {
 		printf("%s: Error creating indirect mempool\n", __func__);
 		goto bad_setup;
diff --git a/app/test/test_ipsec.c b/app/test/test_ipsec.c
index b5a430996d..7596eed159 100644
--- a/app/test/test_ipsec.c
+++ b/app/test/test_ipsec.c
@@ -329,7 +329,7 @@ testsuite_setup(void)
 	ts_params->mbuf_pool = rte_pktmbuf_pool_create(
 			"CRYPTO_MBUFPOOL",
 			NUM_MBUFS, MBUF_CACHE_SIZE, 0, MBUF_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 	if (ts_params->mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_MBUFPOOL\n");
 		return TEST_FAILED;
@@ -342,7 +342,7 @@ testsuite_setup(void)
 			DEFAULT_NUM_XFORMS *
 			sizeof(struct rte_crypto_sym_xform) +
 			MAXIMUM_IV_LENGTH,
-			rte_socket_id());
+			rte_numa_id());
 	if (ts_params->cop_mpool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_OP_POOL\n");
 		return TEST_FAILED;
@@ -354,7 +354,7 @@ testsuite_setup(void)
 	rte_cryptodev_info_get(dev_id, &info);
 
 	ts_params->conf.nb_queue_pairs = info.max_nb_queue_pairs;
-	ts_params->conf.socket_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = RTE_NUMA_ID_ANY;
 	ts_params->conf.ff_disable = RTE_CRYPTODEV_FF_ASYMMETRIC_CRYPTO;
 
 	sess_sz = rte_cryptodev_sym_get_private_session_size(dev_id);
@@ -373,7 +373,7 @@ testsuite_setup(void)
 
 	ts_params->qp_conf.mp_session =
 		rte_cryptodev_sym_session_pool_create("test_sess_mp",
-			MAX_NB_SESSIONS, sess_sz, 0, 0, SOCKET_ID_ANY);
+			MAX_NB_SESSIONS, sess_sz, 0, 0, RTE_NUMA_ID_ANY);
 
 	TEST_ASSERT_NOT_NULL(ts_params->qp_conf.mp_session,
 			"session mempool allocation failed");
@@ -387,7 +387,7 @@ testsuite_setup(void)
 
 	TEST_ASSERT_SUCCESS(rte_cryptodev_queue_pair_setup(
 		dev_id, 0, &ts_params->qp_conf,
-		rte_cryptodev_socket_id(dev_id)),
+		rte_cryptodev_numa_id(dev_id)),
 		"Failed to setup queue pair %u on cryptodev %u",
 		0, dev_id);
 
@@ -430,7 +430,7 @@ ut_setup_ipsec(void)
 	memset(ut_params, 0, sizeof(*ut_params));
 
 	/* Reconfigure device to default parameters */
-	ts_params->conf.socket_id = SOCKET_ID_ANY;
+	ts_params->conf.numa_id = RTE_NUMA_ID_ANY;
 
 	/* Start the device */
 	TEST_ASSERT_SUCCESS(rte_cryptodev_start(ts_params->valid_dev),
diff --git a/app/test/test_ipsec_perf.c b/app/test/test_ipsec_perf.c
index a32a2086e9..28e533a760 100644
--- a/app/test/test_ipsec_perf.c
+++ b/app/test/test_ipsec_perf.c
@@ -452,7 +452,7 @@ testsuite_setup(void)
 
 	mbuf_pool = rte_pktmbuf_pool_create("IPSEC_PERF_MBUFPOOL",
 			NUM_MBUFS, MBUF_CACHE_SIZE, 0, MBUF_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 	if (mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create MBUFPOOL\n");
 		return TEST_FAILED;
@@ -465,29 +465,29 @@ testsuite_setup(void)
 			DEFAULT_NUM_XFORMS *
 			sizeof(struct rte_crypto_sym_xform) +
 			MAXIMUM_IV_LENGTH,
-			rte_socket_id());
+			rte_numa_id());
 	if (cop_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Can't create CRYPTO_OP_POOL\n");
 		return TEST_FAILED;
 	}
 
 	ring_inb_prepare = rte_ring_create("ipsec_test_ring_inb_prepare",
-					   RING_SIZE, SOCKET_ID_ANY, 0);
+					   RING_SIZE, RTE_NUMA_ID_ANY, 0);
 	if (ring_inb_prepare == NULL)
 		return TEST_FAILED;
 
 	ring_inb_process = rte_ring_create("ipsec_test_ring_inb_process",
-					   RING_SIZE, SOCKET_ID_ANY, 0);
+					   RING_SIZE, RTE_NUMA_ID_ANY, 0);
 	if (ring_inb_process == NULL)
 		return TEST_FAILED;
 
 	ring_outb_prepare = rte_ring_create("ipsec_test_ring_outb_prepare",
-					    RING_SIZE, SOCKET_ID_ANY, 0);
+					    RING_SIZE, RTE_NUMA_ID_ANY, 0);
 	if (ring_outb_prepare == NULL)
 		return TEST_FAILED;
 
 	ring_outb_process = rte_ring_create("ipsec_test_ring_outb_process",
-					    RING_SIZE, SOCKET_ID_ANY, 0);
+					    RING_SIZE, RTE_NUMA_ID_ANY, 0);
 	if (ring_outb_process == NULL)
 		return TEST_FAILED;
 
diff --git a/app/test/test_latencystats.c b/app/test/test_latencystats.c
index 76498b66b4..19819736c0 100644
--- a/app/test/test_latencystats.c
+++ b/app/test/test_latencystats.c
@@ -39,7 +39,7 @@ static int test_latency_init(void)
 	int ret = 0;
 
 	/* Metrics Initialization */
-	rte_metrics_init(rte_socket_id());
+	rte_metrics_init(rte_numa_id());
 
 	ret = rte_latencystats_init(1, NULL);
 	TEST_ASSERT(ret >= 0, "Test Failed: rte_latencystats_init failed");
diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index b9c6718e36..6a4aa332df 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -187,13 +187,13 @@ configure_ethdev(uint16_t port_id, uint8_t start, uint8_t en_isr)
 
 	for (q_id = 0; q_id < test_params->nb_rx_q; q_id++)
 		TEST_ASSERT_SUCCESS(rte_eth_rx_queue_setup(port_id, q_id, RX_RING_SIZE,
-				rte_eth_dev_socket_id(port_id), &rx_conf_default,
+				rte_eth_dev_numa_id(port_id), &rx_conf_default,
 				test_params->mbuf_pool) ,
 				"rte_eth_rx_queue_setup for port %d failed", port_id);
 
 	for (q_id = 0; q_id < test_params->nb_tx_q; q_id++)
 		TEST_ASSERT_SUCCESS(rte_eth_tx_queue_setup(port_id, q_id, TX_RING_SIZE,
-				rte_eth_dev_socket_id(port_id), &tx_conf_default),
+				rte_eth_dev_numa_id(port_id), &tx_conf_default),
 				"rte_eth_tx_queue_setup for port %d failed", port_id);
 
 	if (start)
@@ -230,7 +230,7 @@ test_setup(void)
 	if (test_params->mbuf_pool == NULL) {
 		test_params->mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL",
 			nb_mbuf_per_pool, MBUF_CACHE_SIZE, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 		TEST_ASSERT_NOT_NULL(test_params->mbuf_pool,
 				"rte_mempool_create failed");
 	}
@@ -245,7 +245,7 @@ test_setup(void)
 			snprintf(pmd_name, RTE_ETH_NAME_MAX_LEN, "eth_virt_%d", i);
 
 			test_params->member_port_ids[i] = virtual_ethdev_create(pmd_name,
-					mac_addr, rte_socket_id(), 1);
+					mac_addr, rte_numa_id(), 1);
 			TEST_ASSERT(test_params->member_port_ids[i] >= 0,
 					"Failed to create virtual virtual ethdev %s", pmd_name);
 
@@ -269,7 +269,7 @@ test_create_bonding_device(void)
 	/* Don't try to recreate bonding device if re-running test suite*/
 	if (test_params->bonding_port_id == -1) {
 		test_params->bonding_port_id = rte_eth_bond_create(BONDING_DEV_NAME,
-				test_params->bonding_mode, rte_socket_id());
+				test_params->bonding_mode, rte_numa_id());
 
 		TEST_ASSERT(test_params->bonding_port_id >= 0,
 				"Failed to create bonding ethdev %s", BONDING_DEV_NAME);
@@ -309,14 +309,14 @@ test_create_bonding_device_with_invalid_params(void)
 
 	/* Invalid name */
 	port_id = rte_eth_bond_create(NULL, test_params->bonding_mode,
-			rte_socket_id());
+			rte_numa_id());
 	TEST_ASSERT(port_id < 0, "Created bonding device unexpectedly");
 
 	test_params->bonding_mode = INVALID_BONDING_MODE;
 
 	/* Invalid bonding mode */
 	port_id = rte_eth_bond_create(BONDING_DEV_NAME, test_params->bonding_mode,
-			rte_socket_id());
+			rte_numa_id());
 	TEST_ASSERT(port_id < 0, "Created bonding device unexpectedly.");
 
 	test_params->bonding_mode = BONDING_MODE_ROUND_ROBIN;
@@ -460,7 +460,7 @@ test_add_already_bonding_member_to_bonding_device(void)
 	snprintf(pmd_name, RTE_ETH_NAME_MAX_LEN, "%s_%d", BONDING_DEV_NAME, ++bonding_id);
 
 	port_id = rte_eth_bond_create(pmd_name, test_params->bonding_mode,
-			rte_socket_id());
+			rte_numa_id());
 	TEST_ASSERT(port_id >= 0, "Failed to create bonding device.");
 
 	TEST_ASSERT(rte_eth_bond_member_add(port_id,
@@ -928,7 +928,7 @@ test_set_bonding_port_initialization_mac_assignment(void)
 	 */
 	if (bonding_port_id == -1) {
 		bonding_port_id = rte_eth_bond_create("net_bonding_mac_ass_test",
-				BONDING_MODE_ACTIVE_BACKUP, rte_socket_id());
+				BONDING_MODE_ACTIVE_BACKUP, rte_numa_id());
 		TEST_ASSERT(bonding_port_id > 0, "failed to create bonding device");
 
 		TEST_ASSERT_SUCCESS(configure_ethdev(bonding_port_id, 0, 0),
@@ -946,7 +946,7 @@ test_set_bonding_port_initialization_mac_assignment(void)
 				"eth_member_%d", i);
 
 			member_port_ids[i] = virtual_ethdev_create(pmd_name,
-					&member_mac_addr, rte_socket_id(), 1);
+					&member_mac_addr, rte_numa_id(), 1);
 
 			TEST_ASSERT(member_port_ids[i] >= 0,
 					"Failed to create member ethdev %s",
@@ -2062,7 +2062,7 @@ test_roundrobin_verify_polling_member_link_status_change(void)
 		/* Create member devices with no ISR Support */
 		if (polling_test_members[i] == -1) {
 			polling_test_members[i] = virtual_ethdev_create(member_name, mac_addr,
-					rte_socket_id(), 0);
+					rte_numa_id(), 0);
 			TEST_ASSERT(polling_test_members[i] >= 0,
 					"Failed to create virtual ethdev %s\n", member_name);
 
diff --git a/app/test/test_link_bonding_mode4.c b/app/test/test_link_bonding_mode4.c
index ff13dbed93..aa63fde27e 100644
--- a/app/test/test_link_bonding_mode4.c
+++ b/app/test/test_link_bonding_mode4.c
@@ -204,11 +204,11 @@ configure_ethdev(uint16_t port_id, uint8_t start)
 		"Failed to configure device %u", port_id);
 
 	TEST_ASSERT(rte_eth_rx_queue_setup(port_id, 0, RX_RING_SIZE,
-		rte_eth_dev_socket_id(port_id), NULL, test_params.mbuf_pool) == 0,
+		rte_eth_dev_numa_id(port_id), NULL, test_params.mbuf_pool) == 0,
 		"Failed to setup rx queue.");
 
 	TEST_ASSERT(rte_eth_tx_queue_setup(port_id, 0, TX_RING_SIZE,
-		rte_eth_dev_socket_id(port_id), NULL) == 0,
+		rte_eth_dev_numa_id(port_id), NULL) == 0,
 		"Failed to setup tx queue.");
 
 	if (start) {
@@ -384,7 +384,7 @@ test_setup(void)
 	int retval, nb_mbuf_per_pool;
 	char name[RTE_ETH_NAME_MAX_LEN];
 	struct member_conf *port;
-	const uint8_t socket_id = rte_socket_id();
+	const uint8_t numa_id = rte_numa_id();
 	uint16_t i;
 
 	if (test_params.mbuf_pool == NULL) {
@@ -392,7 +392,7 @@ test_setup(void)
 					TEST_TX_DESC_MAX + MAX_PKT_BURST;
 		test_params.mbuf_pool = rte_pktmbuf_pool_create("TEST_MODE4",
 			nb_mbuf_per_pool, MBUF_CACHE_SIZE, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, socket_id);
+			RTE_MBUF_DEFAULT_BUF_SIZE, numa_id);
 
 		TEST_ASSERT(test_params.mbuf_pool != NULL,
 			"rte_mempool_create failed\n");
@@ -405,7 +405,7 @@ test_setup(void)
 		if (port->rx_queue == NULL) {
 			retval = snprintf(name, RTE_DIM(name), MEMBER_RX_QUEUE_FMT, i);
 			TEST_ASSERT(retval <= (int)RTE_DIM(name) - 1, "Name too long");
-			port->rx_queue = rte_ring_create(name, RX_RING_SIZE, socket_id, 0);
+			port->rx_queue = rte_ring_create(name, RX_RING_SIZE, numa_id, 0);
 			TEST_ASSERT(port->rx_queue != NULL,
 				"Failed to allocate rx ring '%s': %s", name,
 				rte_strerror(rte_errno));
@@ -414,7 +414,7 @@ test_setup(void)
 		if (port->tx_queue == NULL) {
 			retval = snprintf(name, RTE_DIM(name), MEMBER_TX_QUEUE_FMT, i);
 			TEST_ASSERT(retval <= (int)RTE_DIM(name) - 1, "Name too long");
-			port->tx_queue = rte_ring_create(name, TX_RING_SIZE, socket_id, 0);
+			port->tx_queue = rte_ring_create(name, TX_RING_SIZE, numa_id, 0);
 			TEST_ASSERT_NOT_NULL(port->tx_queue,
 				"Failed to allocate tx ring '%s': %s", name,
 				rte_strerror(rte_errno));
@@ -424,7 +424,7 @@ test_setup(void)
 			retval = snprintf(name, RTE_DIM(name), MEMBER_DEV_NAME_FMT, i);
 			TEST_ASSERT(retval < (int)RTE_DIM(name) - 1, "Name too long");
 			retval = rte_eth_from_rings(name, &port->rx_queue, 1,
-					&port->tx_queue, 1, socket_id);
+					&port->tx_queue, 1, numa_id);
 			TEST_ASSERT(retval >= 0,
 				"Failed to create ring ethdev '%s'\n", name);
 
@@ -438,7 +438,7 @@ test_setup(void)
 
 	if (test_params.bonding_port_id == INVALID_PORT_ID) {
 		retval = rte_eth_bond_create(BONDING_DEV_NAME, BONDING_MODE_8023AD,
-				socket_id);
+				numa_id);
 
 		TEST_ASSERT(retval >= 0, "Failed to create bonding ethdev %s",
 				BONDING_DEV_NAME);
diff --git a/app/test/test_link_bonding_rssconf.c b/app/test/test_link_bonding_rssconf.c
index 693b0ccd12..f646bae49b 100644
--- a/app/test/test_link_bonding_rssconf.c
+++ b/app/test/test_link_bonding_rssconf.c
@@ -132,13 +132,13 @@ configure_ethdev(uint16_t port_id, struct rte_eth_conf *eth_conf,
 
 	for (rxq = 0; rxq < RXTX_QUEUE_COUNT; rxq++) {
 		TEST_ASSERT(rte_eth_rx_queue_setup(port_id, rxq, RXTX_RING_SIZE,
-				rte_eth_dev_socket_id(port_id), NULL,
+				rte_eth_dev_numa_id(port_id), NULL,
 				test_params.mbuf_pool) == 0, "Failed to setup rx queue.");
 	}
 
 	for (txq = 0; txq < RXTX_QUEUE_COUNT; txq++) {
 		TEST_ASSERT(rte_eth_tx_queue_setup(port_id, txq, RXTX_RING_SIZE,
-				rte_eth_dev_socket_id(port_id), NULL) == 0,
+				rte_eth_dev_numa_id(port_id), NULL) == 0,
 				"Failed to setup tx queue.");
 	}
 
@@ -586,7 +586,7 @@ test_setup(void)
 
 		test_params.mbuf_pool = rte_pktmbuf_pool_create(
 			"RSS_MBUF_POOL", NUM_MBUFS * MEMBER_COUNT,
-			MBUF_CACHE_SIZE, 0, MBUF_SIZE, rte_socket_id());
+			MBUF_CACHE_SIZE, 0, MBUF_SIZE, rte_numa_id());
 
 		TEST_ASSERT(test_params.mbuf_pool != NULL,
 				"rte_pktmbuf_pool_create failed\n");
@@ -623,7 +623,7 @@ test_setup(void)
 	}
 
 	if (test_params.bond_port_id == INVALID_PORT_ID) {
-		retval = rte_eth_bond_create(BONDING_DEV_NAME, 0, rte_socket_id());
+		retval = rte_eth_bond_create(BONDING_DEV_NAME, 0, rte_numa_id());
 
 		TEST_ASSERT(retval >= 0, "Failed to create bonding ethdev %s",
 				BONDING_DEV_NAME);
diff --git a/app/test/test_lpm.c b/app/test/test_lpm.c
index f4a8031062..52eb109703 100644
--- a/app/test/test_lpm.c
+++ b/app/test/test_lpm.c
@@ -91,16 +91,16 @@ test0(void)
 	config.flags = 0;
 
 	/* rte_lpm_create: lpm name == NULL */
-	lpm = rte_lpm_create(NULL, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(NULL, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm == NULL);
 
 	/* rte_lpm_create: max_rules = 0 */
 	/* Note: __func__ inserts the function name, in this case "test0". */
 	config.max_rules = 0;
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm == NULL);
 
-	/* socket_id < -1 is invalid */
+	/* numa_id < -1 is invalid */
 	config.max_rules = MAX_RULES;
 	lpm = rte_lpm_create(__func__, -2, &config);
 	TEST_LPM_ASSERT(lpm == NULL);
@@ -125,7 +125,7 @@ test1(void)
 	/* rte_lpm_free: Free NULL */
 	for (i = 0; i < 100; i++) {
 		config.max_rules = MAX_RULES - i;
-		lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+		lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 		TEST_LPM_ASSERT(lpm != NULL);
 
 		rte_lpm_free(lpm);
@@ -151,7 +151,7 @@ test2(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	rte_lpm_free(lpm);
@@ -180,7 +180,7 @@ test3(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm_add: depth < 1 */
@@ -218,7 +218,7 @@ test4(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm_delete: depth < 1 */
@@ -256,7 +256,7 @@ test5(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm_lookup: depth < 1 */
@@ -286,7 +286,7 @@ test6(void)
 	uint8_t depth = 24;
 	int32_t status = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm_add(lpm, ip, depth, next_hop_add);
@@ -325,7 +325,7 @@ test7(void)
 	uint8_t depth = 32;
 	int32_t status = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm_add(lpm, ip, depth, next_hop_add);
@@ -377,7 +377,7 @@ test8(void)
 	uint8_t depth;
 	int32_t status = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Loop with rte_lpm_add. */
@@ -467,7 +467,7 @@ test9(void)
 	depth = 24;
 	next_hop_add = 100;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm_add(lpm, ip, depth, next_hop_add);
@@ -632,7 +632,7 @@ test10(void)
 
 	/* Add rule that covers a TBL24 range previously invalid & lookup
 	 * (& delete & lookup) */
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = RTE_IPV4(128, 0, 0, 0);
@@ -821,7 +821,7 @@ test11(void)
 	uint8_t depth;
 	int32_t status = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = RTE_IPV4(128, 0, 0, 0);
@@ -892,7 +892,7 @@ test12(void)
 	uint8_t depth;
 	int32_t status = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = RTE_IPV4(128, 0, 0, 0);
@@ -947,7 +947,7 @@ test13(void)
 	uint8_t depth;
 	int32_t status = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = RTE_IPV4(128, 0, 0, 0);
@@ -1017,7 +1017,7 @@ test14(void)
 	uint32_t hop[4];
 
 	/* Add enough space for 256 rules for every depth */
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	depth = 32;
@@ -1073,7 +1073,7 @@ test15(void)
 	config.flags = 0;
 
 	/* Create lpm  */
-	lpm = rte_lpm_create("lpm_find_existing", SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create("lpm_find_existing", RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Try to find existing lpm */
@@ -1104,7 +1104,7 @@ test16(void)
 	config.max_rules = 256 * 32;
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
-	struct rte_lpm *lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	struct rte_lpm *lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 
 	/* ip loops through all possibilities for top 24 bits of address */
 	for (ip = 0; ip < 0xFFFFFF; ip++) {
@@ -1152,7 +1152,7 @@ test17(void)
 	uint32_t next_hop_return = 0;
 	int32_t status = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	if ((status = rte_lpm_add(lpm, ip_10_32, d_ip_10_32,
@@ -1233,7 +1233,7 @@ test18(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = RTE_IPV4(192, 168, 100, 100);
@@ -1302,13 +1302,13 @@ test19(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
-	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	TEST_LPM_ASSERT(qsv != NULL);
 
 	status = rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE);
@@ -1326,8 +1326,8 @@ test19(void)
 	TEST_LPM_ASSERT(status == 0);
 
 	/* Create and attach another RCU QSBR to LPM table */
-	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	TEST_LPM_ASSERT(qsv2 != NULL);
 
 	rcu_cfg.v = qsv2;
@@ -1373,13 +1373,13 @@ test20(void)
 	config.number_tbl8s = 1;
 	config.flags = 0;
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(1);
-	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+				RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	TEST_LPM_ASSERT(qsv != NULL);
 
 	status = rte_rcu_qsbr_init(qsv, 1);
@@ -1504,13 +1504,13 @@ test21(void)
 	config.number_tbl8s = 1;
 	config.flags = 0;
 
-	g_lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	g_lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(g_lpm != NULL);
 
 	/* Create RCU QSBR variable */
 	sz = rte_rcu_qsbr_get_memsize(1);
-	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
-				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_numa(NULL, sz,
+				RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	TEST_LPM_ASSERT(g_v != NULL);
 
 	status = rte_rcu_qsbr_init(g_v, 1);
diff --git a/app/test/test_lpm6.c b/app/test/test_lpm6.c
index 7340331848..f8e59b35e1 100644
--- a/app/test/test_lpm6.c
+++ b/app/test/test_lpm6.c
@@ -107,27 +107,27 @@ test0(void)
 	config.flags = 0;
 
 	/* rte_lpm6_create: lpm name == NULL */
-	lpm = rte_lpm6_create(NULL, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(NULL, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm == NULL);
 
 	/* rte_lpm6_create: max_rules = 0 */
 	/* Note: __func__ inserts the function name, in this case "test0". */
 	config.max_rules = 0;
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm == NULL);
 
-	/* socket_id < -1 is invalid */
+	/* numa_id < -1 is invalid */
 	config.max_rules = MAX_RULES;
 	lpm = rte_lpm6_create(__func__, -2, &config);
 	TEST_LPM_ASSERT(lpm == NULL);
 
 	/* rte_lpm6_create: number_tbl8s is bigger than the maximum */
 	config.number_tbl8s = MAX_NUM_TBL8S + 1;
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm == NULL);
 
 	/* rte_lpm6_create: config = NULL */
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, NULL);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, NULL);
 	TEST_LPM_ASSERT(lpm == NULL);
 
 	return PASS;
@@ -149,15 +149,15 @@ test1(void)
 	config.flags = 0;
 
 	/* rte_lpm6_create: lpm name == LPM1 */
-	lpm1 = rte_lpm6_create("LPM1", SOCKET_ID_ANY, &config);
+	lpm1 = rte_lpm6_create("LPM1", RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm1 != NULL);
 
 	/* rte_lpm6_create: lpm name == LPM2 */
-	lpm2 = rte_lpm6_create("LPM2", SOCKET_ID_ANY, &config);
+	lpm2 = rte_lpm6_create("LPM2", RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm2 != NULL);
 
 	/* rte_lpm6_create: lpm name == LPM2 */
-	lpm3 = rte_lpm6_create("LPM1", SOCKET_ID_ANY, &config);
+	lpm3 = rte_lpm6_create("LPM1", RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm3 == NULL);
 
 	rte_lpm6_free(lpm1);
@@ -183,7 +183,7 @@ test2(void)
 	/* rte_lpm6_free: Free NULL */
 	for (i = 0; i < 20; i++) {
 		config.max_rules = MAX_RULES - i;
-		lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+		lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 		TEST_LPM_ASSERT(lpm != NULL);
 
 		rte_lpm6_free(lpm);
@@ -209,7 +209,7 @@ test3(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	rte_lpm6_free(lpm);
@@ -239,7 +239,7 @@ test4(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm6_add: depth < 1 */
@@ -277,7 +277,7 @@ test5(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm_delete: depth < 1 */
@@ -315,7 +315,7 @@ test6(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm6_lookup: ip = NULL */
@@ -353,7 +353,7 @@ test7(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm6_lookup: ip = NULL */
@@ -391,7 +391,7 @@ test8(void)
 	TEST_LPM_ASSERT(status < 0);
 
 	/*Create valid lpm to use in rest of test. */
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* rte_lpm6_delete: ip = NULL */
@@ -427,7 +427,7 @@ test9(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm6_add(lpm, &ip, depth, next_hop_add);
@@ -472,7 +472,7 @@ test10(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	for (i = 1; i < 128; i++) {
@@ -516,7 +516,7 @@ test11(void)
 	config.number_tbl8s = 16;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	depth = 128;
@@ -577,7 +577,7 @@ test12(void)
 	config.number_tbl8s = 16;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	depth = 128;
@@ -616,7 +616,7 @@ test13(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	depth = 1;
@@ -665,7 +665,7 @@ test14(void)
 	config.number_tbl8s = 256;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	for (i = 0; i < 256; i++) {
@@ -711,7 +711,7 @@ test15(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm6_add(lpm, &ip, depth, next_hop_add);
@@ -748,7 +748,7 @@ test16(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm6_add(lpm, &ip, depth, next_hop_add);
@@ -793,7 +793,7 @@ test17(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Loop with rte_lpm6_add. */
@@ -865,7 +865,7 @@ test18(void)
 	depth = 24;
 	next_hop_add = 100;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm6_add(lpm, &ip, depth, next_hop_add);
@@ -1025,7 +1025,7 @@ test19(void)
 	/* Add rule that covers a TBL24 range previously invalid & lookup
 	 * (& delete & lookup)
 	 */
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
@@ -1221,7 +1221,7 @@ test20(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
@@ -1290,7 +1290,7 @@ test21(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip_batch[0] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0001, 0, 0, 0, 0, 0);
@@ -1349,7 +1349,7 @@ test22(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Adds 5 rules and look them up */
@@ -1466,7 +1466,7 @@ test23(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
@@ -1511,7 +1511,7 @@ test24(void)
 	config.flags = 0;
 
 	/* Create lpm  */
-	lpm = rte_lpm6_create("lpm_find_existing", SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create("lpm_find_existing", RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Try to find existing lpm */
@@ -1551,7 +1551,7 @@ test25(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	for (i = 0; i < 1000; i++) {
@@ -1607,7 +1607,7 @@ test26(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm6_add(lpm, &ip_10_32, d_ip_10_32, next_hop_ip_10_32);
@@ -1679,7 +1679,7 @@ test27(void)
 		config.number_tbl8s = NUMBER_TBL8S;
 		config.flags = 0;
 
-		lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+		lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 		TEST_LPM_ASSERT(lpm != NULL);
 
 		depth = 128;
@@ -1729,7 +1729,7 @@ test28(void)
 	config.number_tbl8s = NUMBER_TBL8S;
 	config.flags = 0;
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	status = rte_lpm6_add(lpm, &ip, depth, next_hop_add);
diff --git a/app/test/test_lpm6_perf.c b/app/test/test_lpm6_perf.c
index 1860a99ed6..f32cf4f7b8 100644
--- a/app/test/test_lpm6_perf.c
+++ b/app/test/test_lpm6_perf.c
@@ -75,7 +75,7 @@ test_lpm6_perf(void)
 	 */
 	generate_large_ips_table(0);
 
-	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Measure add. */
diff --git a/app/test/test_lpm_perf.c b/app/test/test_lpm_perf.c
index bc4bdded64..b3249c80c7 100644
--- a/app/test/test_lpm_perf.c
+++ b/app/test/test_lpm_perf.c
@@ -518,7 +518,7 @@ test_lpm_rcu_perf_multi_writer(uint8_t use_rcu)
 		config.max_rules = NUM_LDEPTH_ROUTE_ENTRIES;
 		config.number_tbl8s = NUM_LDEPTH_ROUTE_ENTRIES;
 		config.flags = 0;
-		lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+		lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 		TEST_LPM_ASSERT(lpm != NULL);
 
 		/* Init RCU variable */
@@ -611,7 +611,7 @@ test_lpm_perf(void)
 
 	print_route_distribution(large_route_table, (uint32_t) NUM_ROUTE_ENTRIES);
 
-	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	lpm = rte_lpm_create(__func__, RTE_NUMA_ID_ANY, &config);
 	TEST_LPM_ASSERT(lpm != NULL);
 
 	/* Measure add. */
diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index 3674dc3f7f..ae6f8a979e 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -33,7 +33,7 @@
 #define N 10000
 
 static int
-is_mem_on_socket(int32_t socket);
+is_mem_on_socket(int32_t numa_id);
 
 static int32_t
 addr_to_socket(void *addr);
@@ -277,7 +277,7 @@ static int
 test_multi_alloc_statistics(void)
 {
 	int ret = -1;  /* default return is error, cleared at end on success */
-	int socket = 0;
+	int numa_id = 0;
 	struct rte_malloc_numa_stats pre_stats, post_stats, first_stats, second_stats;
 	size_t size = 2048;
 	int align = 1024;
@@ -313,22 +313,22 @@ test_multi_alloc_statistics(void)
 		printf("Failed to add memory to heap\n");
 		goto cleanup_allocated_memory;
 	}
-	socket = rte_malloc_heap_get_numa_id(__func__);
-	if (socket < 0) {
-		printf("Failed to get socket for test malloc heap.\n");
+	numa_id = rte_malloc_heap_get_numa_id(__func__);
+	if (numa_id < 0) {
+		printf("Failed to get numa_id for test malloc heap.\n");
 		goto cleanup_all;
 	}
 
 	/* Dynamically calculate the overhead by allocating one cacheline and
 	 * then comparing what was allocated from the heap.
 	 */
-	rte_malloc_get_numa_stats(socket, &pre_stats);
+	rte_malloc_get_numa_stats(numa_id, &pre_stats);
 
-	void *dummy = rte_malloc_socket(NULL, RTE_CACHE_LINE_SIZE, 0, socket);
+	void *dummy = rte_malloc_numa(NULL, RTE_CACHE_LINE_SIZE, 0, numa_id);
 	if (dummy == NULL)
 		goto cleanup_all;
 
-	rte_malloc_get_numa_stats(socket, &post_stats);
+	rte_malloc_get_numa_stats(numa_id, &post_stats);
 
 	/* after subtracting cache line, remainder is overhead */
 	overhead = post_stats.heap_allocsz_bytes - pre_stats.heap_allocsz_bytes;
@@ -337,16 +337,16 @@ test_multi_alloc_statistics(void)
 	rte_free(dummy);
 
 	/* Now start the real tests */
-	rte_malloc_get_numa_stats(socket, &pre_stats);
+	rte_malloc_get_numa_stats(numa_id, &pre_stats);
 
-	void *p1 = rte_malloc_socket("stats", size , align, socket);
+	void *p1 = rte_malloc_numa("stats", size, align, numa_id);
 	if (!p1)
 		goto cleanup_all;
 
 	rte_free(p1);
 	rte_malloc_dump_stats(stdout, "stats");
 
-	rte_malloc_get_numa_stats(socket, &post_stats);
+	rte_malloc_get_numa_stats(numa_id, &post_stats);
 	/* Check statistics reported are correct */
 	/* All post stats should be equal to pre stats after alloc freed */
 	if ((post_stats.heap_totalsz_bytes != pre_stats.heap_totalsz_bytes) ||
@@ -360,23 +360,23 @@ test_multi_alloc_statistics(void)
 	/* Check two consecutive allocations */
 	size = 1024;
 	align = 0;
-	rte_malloc_get_numa_stats(socket, &pre_stats);
-	void *p2 = rte_malloc_socket("add", size ,align, socket);
+	rte_malloc_get_numa_stats(numa_id, &pre_stats);
+	void *p2 = rte_malloc_numa("add", size, align, numa_id);
 	if (!p2)
 		goto cleanup_all;
-	rte_malloc_get_numa_stats(socket, &first_stats);
+	rte_malloc_get_numa_stats(numa_id, &first_stats);
 
-	void *p3 = rte_malloc_socket("add2", size,align, socket);
+	void *p3 = rte_malloc_numa("add2", size, align, numa_id);
 	if (!p3)
 		goto cleanup_all;
 
-	rte_malloc_get_numa_stats(socket, &second_stats);
+	rte_malloc_get_numa_stats(numa_id, &second_stats);
 
 	rte_free(p2);
 	rte_free(p3);
 
 	/* After freeing both allocations check stats return to original */
-	rte_malloc_get_numa_stats(socket, &post_stats);
+	rte_malloc_get_numa_stats(numa_id, &post_stats);
 
 	if(second_stats.heap_totalsz_bytes != first_stats.heap_totalsz_bytes) {
 		printf("Incorrect heap statistics: Total size \n");
@@ -442,7 +442,7 @@ test_realloc(void)
 #else
 
 static int
-test_realloc_socket(int socket)
+test_realloc_socket(int numa_id)
 {
 	const char hello_str[] = "Hello, world!";
 	const unsigned size1 = 1024;
@@ -451,15 +451,15 @@ test_realloc_socket(int socket)
 	const unsigned size4 = size3 + 1024;
 
 	/* test data is the same even if element is moved*/
-	char *ptr1 = rte_zmalloc_socket(
-			NULL, size1, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr1 = rte_zmalloc_numa(
+			NULL, size1, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr1){
 		printf("NULL pointer returned from rte_zmalloc\n");
 		return -1;
 	}
 	strlcpy(ptr1, hello_str, size1);
-	char *ptr2 = rte_realloc_socket(
-			ptr1, size2, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr2 = rte_realloc_numa(
+			ptr1, size2, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr2){
 		rte_free(ptr1);
 		printf("NULL pointer returned from rte_realloc\n");
@@ -483,8 +483,8 @@ test_realloc_socket(int socket)
 	/* now allocate third element, free the second
 	 * and resize third. It should not move. (ptr1 is now invalid)
 	 */
-	char *ptr3 = rte_zmalloc_socket(
-			NULL, size3, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr3 = rte_zmalloc_numa(
+			NULL, size3, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr3){
 		printf("NULL pointer returned from rte_zmalloc\n");
 		rte_free(ptr2);
@@ -499,8 +499,8 @@ test_realloc_socket(int socket)
 		}
 	rte_free(ptr2);
 	/* first resize to half the size of the freed block */
-	char *ptr4 = rte_realloc_socket(
-			ptr3, size4, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr4 = rte_realloc_numa(
+			ptr3, size4, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr4){
 		printf("NULL pointer returned from rte_realloc\n");
 		rte_free(ptr3);
@@ -512,8 +512,8 @@ test_realloc_socket(int socket)
 		return -1;
 	}
 	/* now resize again to the full size of the freed block */
-	ptr4 = rte_realloc_socket(ptr3, size3 + size2 + size1,
-			RTE_CACHE_LINE_SIZE, socket);
+	ptr4 = rte_realloc_numa(ptr3, size3 + size2 + size1,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (ptr3 != ptr4){
 		printf("Unexpected - ptr4 != ptr3 on second resize\n");
 		rte_free(ptr4);
@@ -524,14 +524,14 @@ test_realloc_socket(int socket)
 	/* now try a resize to a smaller size, see if it works */
 	const unsigned size5 = 1024;
 	const unsigned size6 = size5 / 2;
-	char *ptr5 = rte_malloc_socket(
-			NULL, size5, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr5 = rte_malloc_numa(
+			NULL, size5, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr5){
 		printf("NULL pointer returned from rte_malloc\n");
 		return -1;
 	}
-	char *ptr6 = rte_realloc_socket(
-			ptr5, size6, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr6 = rte_realloc_numa(
+			ptr5, size6, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr6){
 		printf("NULL pointer returned from rte_realloc\n");
 		rte_free(ptr5);
@@ -548,7 +548,7 @@ test_realloc_socket(int socket)
 	const unsigned size7 = 1024;
 	const unsigned orig_align = RTE_CACHE_LINE_SIZE;
 	unsigned new_align = RTE_CACHE_LINE_SIZE * 2;
-	char *ptr7 = rte_malloc_socket(NULL, size7, orig_align, socket);
+	char *ptr7 = rte_malloc_numa(NULL, size7, orig_align, numa_id);
 	if (!ptr7){
 		printf("NULL pointer returned from rte_malloc\n");
 		return -1;
@@ -556,7 +556,7 @@ test_realloc_socket(int socket)
 	/* calc an alignment we don't already have */
 	while(RTE_PTR_ALIGN(ptr7, new_align) == ptr7)
 		new_align *= 2;
-	char *ptr8 = rte_realloc_socket(ptr7, size7, new_align, socket);
+	char *ptr8 = rte_realloc_numa(ptr7, size7, new_align, numa_id);
 	if (!ptr8){
 		printf("NULL pointer returned from rte_realloc\n");
 		rte_free(ptr7);
@@ -574,21 +574,21 @@ test_realloc_socket(int socket)
 	 */
 	unsigned size9 = 1024, size10 = 1024;
 	unsigned size11 = size9 + size10 + 256;
-	char *ptr9 = rte_malloc_socket(
-			NULL, size9, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr9 = rte_malloc_numa(
+			NULL, size9, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr9){
 		printf("NULL pointer returned from rte_malloc\n");
 		return -1;
 	}
-	char *ptr10 = rte_malloc_socket(
-			NULL, size10, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr10 = rte_malloc_numa(
+			NULL, size10, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr10){
 		printf("NULL pointer returned from rte_malloc\n");
 		return -1;
 	}
 	rte_free(ptr9);
-	char *ptr11 = rte_realloc_socket(
-			ptr10, size11, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr11 = rte_realloc_numa(
+			ptr10, size11, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr11){
 		printf("NULL pointer returned from rte_realloc\n");
 		rte_free(ptr10);
@@ -605,8 +605,8 @@ test_realloc_socket(int socket)
 	 * We should get a malloc of the size requested*/
 	const size_t size12 = 1024;
 	size_t size12_check;
-	char *ptr12 = rte_realloc_socket(
-			NULL, size12, RTE_CACHE_LINE_SIZE, socket);
+	char *ptr12 = rte_realloc_numa(
+			NULL, size12, RTE_CACHE_LINE_SIZE, numa_id);
 	if (!ptr12){
 		printf("NULL pointer returned from rte_realloc\n");
 		return -1;
@@ -638,32 +638,32 @@ static int
 test_realloc_numa(void)
 {
 	/* check realloc_socket part */
-	int32_t socket_count = 0, socket_allocated, socket;
+	int32_t socket_count = 0, socket_allocated, numa_id;
 	void *ptr1, *ptr2;
 	int ret = -1;
 	size_t size = 1024;
 
 	ptr1 = NULL;
-	for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++) {
-		if (is_mem_on_socket(socket)) {
+	for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES; numa_id++) {
+		if (is_mem_on_socket(numa_id)) {
 			int j = 2;
 
 			socket_count++;
 			while (j--) {
 				/* j == 1 -> resizing */
-				ptr2 = rte_realloc_socket(ptr1, size,
+				ptr2 = rte_realloc_numa(ptr1, size,
 							  RTE_CACHE_LINE_SIZE,
-							  socket);
+							  numa_id);
 				if (ptr2 == NULL) {
-					printf("NULL pointer returned from rte_realloc_socket\n");
+					printf("NULL pointer returned from rte_realloc_numa\n");
 					goto end;
 				}
 
 				ptr1 = ptr2;
 				socket_allocated = addr_to_socket(ptr2);
-				if (socket_allocated != socket) {
-					printf("Requested socket (%d) doesn't mach allocated one (%d)\n",
-					       socket, socket_allocated);
+				if (socket_allocated != numa_id) {
+					printf("Requested numa_id (%d) doesn't mach allocated one (%d)\n",
+					       numa_id, socket_allocated);
 					goto end;
 				}
 				size += RTE_CACHE_LINE_SIZE;
@@ -671,7 +671,7 @@ test_realloc_numa(void)
 		}
 	}
 
-	/* Print warning if only a single socket, but don't fail the test */
+	/* Print warning if only a single numa_id, but don't fail the test */
 	if (socket_count < 2)
 		printf("WARNING: realloc_socket test needs memory on multiple sockets!\n");
 
@@ -721,7 +721,7 @@ test_realloc(void)
 		goto mem_free;
 	}
 
-	/* run the socket-bound tests */
+	/* run the numa_id-bound tests */
 	ret = test_realloc_socket(realloc_heap_socket);
 	if (ret != 0)
 		goto mem_remove;
@@ -957,24 +957,24 @@ test_malloc_bad_params(void)
 static int
 check_socket_mem(const struct rte_memseg_list *msl, void *arg)
 {
-	int32_t *socket = arg;
+	int32_t *numa_id = arg;
 
 	if (msl->external)
 		return 0;
 
-	return *socket == msl->socket_id;
+	return *numa_id == msl->socket_id;
 }
 
-/* Check if memory is available on a specific socket */
+/* Check if memory is available on a specific numa_id */
 static int
-is_mem_on_socket(int32_t socket)
+is_mem_on_socket(int32_t numa_id)
 {
-	return rte_memseg_list_walk(check_socket_mem, &socket);
+	return rte_memseg_list_walk(check_socket_mem, &numa_id);
 }
 
 
 /*
- * Find what socket a memory address is on. Only works for addresses within
+ * Find what numa_id a memory address is on. Only works for addresses within
  * memsegs, not heap or stack...
  */
 static int32_t
@@ -985,19 +985,19 @@ addr_to_socket(void * addr)
 
 }
 
-/* Test using rte_[c|m|zm]alloc_socket() on a specific socket */
+/* Test using rte_[c|m|zm]alloc_socket() on a specific numa_id */
 static int
-test_alloc_single_socket(int32_t socket)
+test_alloc_single_socket(int32_t numa_id)
 {
 	const char *type = NULL;
 	const size_t size = 10;
 	const unsigned align = 0;
 	char *mem = NULL;
-	int32_t desired_socket = (socket == SOCKET_ID_ANY) ?
-			(int32_t)rte_socket_id() : socket;
+	int32_t desired_socket = (numa_id == RTE_NUMA_ID_ANY) ?
+			(int32_t)rte_numa_id() : numa_id;
 
-	/* Test rte_calloc_socket() */
-	mem = rte_calloc_socket(type, size, sizeof(char), align, socket);
+	/* Test rte_calloc_numa() */
+	mem = rte_calloc_numa(type, size, sizeof(char), align, numa_id);
 	if (mem == NULL)
 		return -1;
 	if (addr_to_socket(mem) != desired_socket) {
@@ -1006,8 +1006,8 @@ test_alloc_single_socket(int32_t socket)
 	}
 	rte_free(mem);
 
-	/* Test rte_malloc_socket() */
-	mem = rte_malloc_socket(type, size, align, socket);
+	/* Test rte_malloc_numa() */
+	mem = rte_malloc_numa(type, size, align, numa_id);
 	if (mem == NULL)
 		return -1;
 	if (addr_to_socket(mem) != desired_socket) {
@@ -1016,8 +1016,8 @@ test_alloc_single_socket(int32_t socket)
 	}
 	rte_free(mem);
 
-	/* Test rte_zmalloc_socket() */
-	mem = rte_zmalloc_socket(type, size, align, socket);
+	/* Test rte_zmalloc_numa() */
+	mem = rte_zmalloc_numa(type, size, align, numa_id);
 	if (mem == NULL)
 		return -1;
 	if (addr_to_socket(mem) != desired_socket) {
@@ -1035,28 +1035,28 @@ test_alloc_socket(void)
 	unsigned socket_count = 0;
 	unsigned i;
 
-	if (test_alloc_single_socket(SOCKET_ID_ANY) < 0)
+	if (test_alloc_single_socket(RTE_NUMA_ID_ANY) < 0)
 		return -1;
 
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
 		if (is_mem_on_socket(i)) {
 			socket_count++;
 			if (test_alloc_single_socket(i) < 0) {
-				printf("Fail: rte_malloc_socket(..., %u) did not succeed\n",
+				printf("Fail: rte_malloc_numa(..., %u) did not succeed\n",
 						i);
 				return -1;
 			}
 		}
 		else {
 			if (test_alloc_single_socket(i) == 0) {
-				printf("Fail: rte_malloc_socket(..., %u) succeeded\n",
+				printf("Fail: rte_malloc_numa(..., %u) succeeded\n",
 						i);
 				return -1;
 			}
 		}
 	}
 
-	/* Print warning if only a single socket, but don't fail the test */
+	/* Print warning if only a single numa_id, but don't fail the test */
 	if (socket_count < 2) {
 		printf("WARNING: alloc_socket test needs memory on multiple sockets!\n");
 	}
diff --git a/app/test/test_malloc_perf.c b/app/test/test_malloc_perf.c
index a99bfd8531..3a54100588 100644
--- a/app/test/test_malloc_perf.c
+++ b/app/test/test_malloc_perf.c
@@ -136,7 +136,7 @@ memzone_alloc(const char *name __rte_unused, size_t size, unsigned int align)
 	char gen_name[RTE_MEMZONE_NAMESIZE];
 
 	snprintf(gen_name, sizeof(gen_name), "test-mz-%"PRIx64, rte_rdtsc());
-	mz = rte_memzone_reserve_aligned(gen_name, size, SOCKET_ID_ANY,
+	mz = rte_memzone_reserve_aligned(gen_name, size, RTE_NUMA_ID_ANY,
 			RTE_MEMZONE_1GB | RTE_MEMZONE_SIZE_HINT_ONLY, align);
 	return (void *)(uintptr_t)mz;
 }
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..2289d27ac1 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -758,14 +758,14 @@ test_pktmbuf_pool_bulk(void)
 	 */
 	printf("Create mbuf pools for bulk allocation.\n");
 	pool = rte_pktmbuf_pool_create("test_pktmbuf_bulk",
-			NB_MBUF, 0, 0, MBUF_DATA_SIZE, SOCKET_ID_ANY);
+			NB_MBUF, 0, 0, MBUF_DATA_SIZE, RTE_NUMA_ID_ANY);
 	if (pool == NULL) {
 		printf("rte_pktmbuf_pool_create() failed. rte_errno %d\n",
 		       rte_errno);
 		goto err;
 	}
 	pool2 = rte_pktmbuf_pool_create("test_pktmbuf_bulk2",
-			NB_MBUF, 0, 0, MBUF_DATA_SIZE, SOCKET_ID_ANY);
+			NB_MBUF, 0, 0, MBUF_DATA_SIZE, RTE_NUMA_ID_ANY);
 	if (pool2 == NULL) {
 		printf("rte_pktmbuf_pool_create() failed. rte_errno %d\n",
 		       rte_errno);
@@ -1130,7 +1130,7 @@ test_refcnt_mbuf(void)
 
 	refcnt_pool = rte_pktmbuf_pool_create(MAKE_STRING(refcnt_pool),
 					      REFCNT_MBUF_NUM, 0, 0, 0,
-					      SOCKET_ID_ANY);
+					      RTE_NUMA_ID_ANY);
 	if (refcnt_pool == NULL) {
 		printf("%s: cannot allocate " MAKE_STRING(refcnt_pool) "\n",
 		       __func__);
@@ -1138,7 +1138,7 @@ test_refcnt_mbuf(void)
 	}
 
 	refcnt_mbuf_ring = rte_ring_create("refcnt_mbuf_ring",
-					   rte_align32pow2(REFCNT_RING_SIZE), SOCKET_ID_ANY,
+					   rte_align32pow2(REFCNT_RING_SIZE), RTE_NUMA_ID_ANY,
 					   RING_F_SP_ENQ);
 	if (refcnt_mbuf_ring == NULL) {
 		printf("%s: cannot allocate " MAKE_STRING(refcnt_mbuf_ring)
@@ -2451,7 +2451,7 @@ test_pktmbuf_ext_pinned_buffer(struct rte_mempool *std_pool)
 	/* Allocate memzone for the external data buffer */
 	mz = rte_memzone_reserve("pinned_pool",
 				 NB_MBUF * MBUF_DATA_SIZE,
-				 SOCKET_ID_ANY,
+				 RTE_NUMA_ID_ANY,
 				 RTE_MEMZONE_2MB | RTE_MEMZONE_SIZE_HINT_ONLY);
 	if (mz == NULL)
 		GOTO_FAIL("%s: Memzone allocation failed\n", __func__);
@@ -2464,7 +2464,7 @@ test_pktmbuf_ext_pinned_buffer(struct rte_mempool *std_pool)
 
 	pinned_pool = rte_pktmbuf_pool_create_extbuf("test_pinned_pool",
 				NB_MBUF, MEMPOOL_CACHE_SIZE, 0,
-				MBUF_DATA_SIZE,	SOCKET_ID_ANY,
+				MBUF_DATA_SIZE,	RTE_NUMA_ID_ANY,
 				&ext_mem, 1);
 	if (pinned_pool == NULL)
 		GOTO_FAIL("%s: Mbuf pool with pinned external"
@@ -2712,7 +2712,7 @@ test_nb_segs_and_next_reset(void)
 	struct rte_mempool *pool = NULL;
 
 	pool = rte_pktmbuf_pool_create("test_mbuf_reset",
-			3, 0, 0, MBUF_DATA_SIZE, SOCKET_ID_ANY);
+			3, 0, 0, MBUF_DATA_SIZE, RTE_NUMA_ID_ANY);
 	if (pool == NULL)
 		GOTO_FAIL("Failed to create mbuf pool");
 
@@ -2782,7 +2782,7 @@ test_mbuf(void)
 	/* create pktmbuf pool if it does not exist */
 	pktmbuf_pool = rte_pktmbuf_pool_create("test_pktmbuf_pool",
 			NB_MBUF, MEMPOOL_CACHE_SIZE, 0, MBUF_DATA_SIZE,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 
 	if (pktmbuf_pool == NULL) {
 		printf("cannot allocate mbuf pool\n");
@@ -2799,7 +2799,7 @@ test_mbuf(void)
 	 * room size */
 	pktmbuf_pool2 = rte_pktmbuf_pool_create("test_pktmbuf_pool2",
 			NB_MBUF, MEMPOOL_CACHE_SIZE, MBUF2_PRIV_SIZE, 0,
-			SOCKET_ID_ANY);
+			RTE_NUMA_ID_ANY);
 
 	if (pktmbuf_pool2 == NULL) {
 		printf("cannot allocate mbuf pool\n");
diff --git a/app/test/test_member_perf.c b/app/test/test_member_perf.c
index 5bf75bf8d4..2b32a8b17c 100644
--- a/app/test/test_member_perf.c
+++ b/app/test/test_member_perf.c
@@ -658,7 +658,7 @@ run_all_tbl_perf_tests(void)
 	printf("Measuring performance, please wait\n");
 	fflush(stdout);
 
-	test_socket_id = rte_socket_id();
+	test_socket_id = rte_numa_id();
 
 	for (i = 0; i < NUM_KEYSIZES; i++) {
 		if (setup_keys_and_data(&params, i, 0) < 0) {
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 0a4d794346..dee785a10b 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -90,7 +90,7 @@ test_mempool_basic(struct rte_mempool *mp, int use_external_cache)
 	if (use_external_cache) {
 		/* Create a user-owned mempool cache. */
 		cache = rte_mempool_cache_create(RTE_MEMPOOL_CACHE_MAX_SIZE,
-						 SOCKET_ID_ANY);
+						 RTE_NUMA_ID_ANY);
 		if (cache == NULL)
 			RET_ERR();
 	} else {
@@ -198,7 +198,7 @@ static int test_mempool_creation_with_exceeded_cache_size(void)
 		MEMPOOL_SIZE + 32, 0,
 		NULL, NULL,
 		my_obj_init, NULL,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_cov != NULL) {
 		rte_mempool_free(mp_cov);
@@ -216,7 +216,7 @@ static int test_mempool_creation_with_invalid_flags(void)
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
-		SOCKET_ID_ANY, ~RTE_MEMPOOL_VALID_USER_FLAGS);
+		RTE_NUMA_ID_ANY, ~RTE_MEMPOOL_VALID_USER_FLAGS);
 
 	if (mp_cov != NULL) {
 		rte_mempool_free(mp_cov);
@@ -338,7 +338,7 @@ test_mempool_sp_sc(void)
 			MEMPOOL_ELT_SIZE, 0, 0,
 			my_mp_init, NULL,
 			my_obj_init, NULL,
-			SOCKET_ID_ANY,
+			RTE_NUMA_ID_ANY,
 			RTE_MEMPOOL_F_NO_CACHE_ALIGN | RTE_MEMPOOL_F_SP_PUT |
 			RTE_MEMPOOL_F_SC_GET);
 		if (mp_spsc == NULL)
@@ -445,7 +445,7 @@ test_mempool_same_name_twice_creation(void)
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_tc == NULL)
 		RET_ERR();
@@ -454,7 +454,7 @@ test_mempool_same_name_twice_creation(void)
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_tc2 != NULL) {
 		rte_mempool_free(mp_tc);
@@ -547,7 +547,7 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 	strcpy(name, "empty0");
 	mp[0] = rte_mempool_create_empty(name, mempool_size,
 					 mempool_elt_size, 0, 0,
-					 SOCKET_ID_ANY, 0);
+					 RTE_NUMA_ID_ANY, 0);
 	RTE_TEST_ASSERT_NOT_NULL(mp[0], "Cannot create mempool %s: %s",
 				 name, rte_strerror(rte_errno));
 	for (j = 0; j < CALLBACK_NUM; j++)
@@ -580,7 +580,7 @@ test_mempool_events(int (*populate)(struct rte_mempool *mp))
 	strcpy(name, "empty1");
 	mp[1] = rte_mempool_create_empty(name, mempool_size,
 					 mempool_elt_size, 0, 0,
-					 SOCKET_ID_ANY, 0);
+					 RTE_NUMA_ID_ANY, 0);
 	RTE_TEST_ASSERT_NOT_NULL(mp[1], "Cannot create mempool %s: %s",
 				 name, rte_strerror(rte_errno));
 	rte_mempool_set_ops_byname(mp[1], rte_mbuf_best_mempool_ops(), NULL);
@@ -689,7 +689,7 @@ test_mempool_events_safety(void)
 
 	mp = rte_mempool_create_empty("empty", MEMPOOL_SIZE,
 				      MEMPOOL_ELT_SIZE, 0, 0,
-				      SOCKET_ID_ANY, 0);
+				      RTE_NUMA_ID_ANY, 0);
 	RTE_TEST_ASSERT_NOT_NULL(mp, "Cannot create mempool: %s",
 				 rte_strerror(rte_errno));
 	memset(&data, 0, sizeof(data));
@@ -751,13 +751,13 @@ test_mempool_flag_non_io_set_when_no_iova_contig_set(void)
 	struct rte_mempool *mp = NULL;
 	int ret;
 
-	mz = rte_memzone_reserve("test_mempool", size, SOCKET_ID_ANY, 0);
+	mz = rte_memzone_reserve("test_mempool", size, RTE_NUMA_ID_ANY, 0);
 	RTE_TEST_ASSERT_NOT_NULL(mz, "Cannot allocate memory");
 	virt = mz->addr;
 	iova = mz->iova;
 	mp = rte_mempool_create_empty("empty", MEMPOOL_SIZE,
 				      MEMPOOL_ELT_SIZE, 0, 0,
-				      SOCKET_ID_ANY, RTE_MEMPOOL_F_NO_IOVA_CONTIG);
+				      RTE_NUMA_ID_ANY, RTE_MEMPOOL_F_NO_IOVA_CONTIG);
 	RTE_TEST_ASSERT_NOT_NULL(mp, "Cannot create mempool: %s",
 				 rte_strerror(rte_errno));
 	rte_mempool_set_ops_byname(mp, rte_mbuf_best_mempool_ops(), NULL);
@@ -797,13 +797,13 @@ test_mempool_flag_non_io_unset_when_populated_with_valid_iova(void)
 	 * we don't care for contiguous IOVA, on the other hand,
 	 * requiring it could cause spurious test failures.
 	 */
-	mz = rte_memzone_reserve("test_mempool", total_size, SOCKET_ID_ANY, 0);
+	mz = rte_memzone_reserve("test_mempool", total_size, RTE_NUMA_ID_ANY, 0);
 	RTE_TEST_ASSERT_NOT_NULL(mz, "Cannot allocate memory");
 	virt = mz->addr;
 	iova = mz->iova;
 	mp = rte_mempool_create_empty("empty", MEMPOOL_SIZE,
 				      MEMPOOL_ELT_SIZE, 0, 0,
-				      SOCKET_ID_ANY, 0);
+				      RTE_NUMA_ID_ANY, 0);
 	RTE_TEST_ASSERT_NOT_NULL(mp, "Cannot create mempool: %s",
 				 rte_strerror(rte_errno));
 
@@ -866,7 +866,7 @@ test_mempool(void)
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		my_obj_init, NULL,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_nocache == NULL) {
 		printf("cannot allocate mp_nocache mempool\n");
@@ -879,7 +879,7 @@ test_mempool(void)
 		RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
 		NULL, NULL,
 		my_obj_init, NULL,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_cache == NULL) {
 		printf("cannot allocate mp_cache mempool\n");
@@ -891,7 +891,7 @@ test_mempool(void)
 		MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE,
 		RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_anon == NULL)
 		GOTO_ERR(ret, err);
@@ -914,7 +914,7 @@ test_mempool(void)
 		RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
 		NULL, NULL,
 		my_obj_init, NULL,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_mempool_iter == NULL)
 		GOTO_ERR(ret, err);
@@ -936,7 +936,7 @@ test_mempool(void)
 		MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE,
 		RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
-		SOCKET_ID_ANY, 0);
+		RTE_NUMA_ID_ANY, 0);
 
 	if (mp_stack == NULL) {
 		printf("cannot allocate mp_stack mempool\n");
@@ -959,7 +959,7 @@ test_mempool(void)
 						MEMPOOL_SIZE,
 						MEMPOOL_ELT_SIZE,
 						RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
-						SOCKET_ID_ANY, 0);
+						RTE_NUMA_ID_ANY, 0);
 
 	if (default_pool == NULL) {
 		printf("cannot allocate default mempool\n");
@@ -1006,7 +1006,7 @@ test_mempool(void)
 	mp_alignment = rte_mempool_create("test_alignment",
 		1, 8, /* the small size guarantees single memory chunk */
 		0, 0, NULL, NULL, my_obj_init, NULL,
-		SOCKET_ID_ANY, RTE_MEMPOOL_F_NO_CACHE_ALIGN);
+		RTE_NUMA_ID_ANY, RTE_MEMPOOL_F_NO_CACHE_ALIGN);
 
 	if (mp_alignment == NULL) {
 		printf("cannot allocate mempool with "
diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index e164eca788..d278285e0c 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -231,7 +231,7 @@ per_lcore_mempool_test(void *arg)
 	if (use_external_cache) {
 		/* Create a user-owned mempool cache. */
 		cache = rte_mempool_cache_create(external_cache_size,
-						 SOCKET_ID_ANY);
+						 RTE_NUMA_ID_ANY);
 		if (cache == NULL)
 			RET_ERR();
 	} else {
@@ -456,7 +456,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 					MEMPOOL_ELT_SIZE, 0, 0,
 					NULL, NULL,
 					my_obj_init, NULL,
-					SOCKET_ID_ANY, 0);
+					RTE_NUMA_ID_ANY, 0);
 	if (mp_nocache == NULL) {
 		printf("cannot allocate mempool (without cache)\n");
 		goto err;
@@ -469,7 +469,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 				      RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
 				      NULL, NULL,
 				      my_obj_init, NULL,
-				      SOCKET_ID_ANY, 0);
+				      RTE_NUMA_ID_ANY, 0);
 	if (mp_cache == NULL) {
 		printf("cannot allocate mempool (with cache)\n");
 		goto err;
@@ -483,7 +483,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 			MEMPOOL_SIZE,
 			MEMPOOL_ELT_SIZE,
 			0, 0,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	if (default_pool_nocache == NULL) {
 		printf("cannot allocate %s mempool (without cache)\n", default_pool_ops);
 		goto err;
@@ -503,7 +503,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 			MEMPOOL_SIZE,
 			MEMPOOL_ELT_SIZE,
 			RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	if (default_pool_cache == NULL) {
 		printf("cannot allocate %s mempool (with cache)\n", default_pool_ops);
 		goto err;
diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 1b6555df55..b3e76b6e4f 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -29,9 +29,9 @@
  *
  * - Search for three reserved zones or reserve them if they do not exist:
  *
- *   - One is on any socket id.
- *   - The second is on socket 0.
- *   - The last one is on socket 1 (if socket 1 exists).
+ *   - One is on any NUMA node id.
+ *   - The second is on NUMA node 0.
+ *   - The last one is on NUMA node 1 (if NUMA node 1 exists).
  *
  * - Check that the zones exist.
  *
@@ -39,7 +39,7 @@
  *
  * - Check that zones do not overlap.
  *
- * - Check that the zones are on the correct socket id.
+ * - Check that the zones are on the correct NUMA node id.
  *
  * - Check that a lookup of the first zone returns the same pointer.
  *
@@ -74,7 +74,7 @@ test_memzone_invalid_alignment(void)
 	}
 
 	mz = rte_memzone_reserve_aligned(TEST_MEMZONE_NAME("invalid_alignment"),
-					 100, SOCKET_ID_ANY, 0, 100);
+					 100, RTE_NUMA_ID_ANY, 0, 100);
 	if (mz != NULL) {
 		printf("Zone with invalid alignment has been reserved\n");
 		return -1;
@@ -94,7 +94,7 @@ test_memzone_invalid_flags(void)
 	}
 
 	mz = rte_memzone_reserve(TEST_MEMZONE_NAME("invalid_flags"),
-		100, SOCKET_ID_ANY, RTE_MEMZONE_IOVA_CONTIG << 1);
+		100, RTE_NUMA_ID_ANY, RTE_MEMZONE_IOVA_CONTIG << 1);
 	if (mz != NULL) {
 		printf("Zone with invalid flags has been reserved\n");
 		return -1;
@@ -116,7 +116,7 @@ test_memzone_reserving_zone_size_bigger_than_the_maximum(void)
 
 	mz = rte_memzone_reserve(
 			TEST_MEMZONE_NAME("zone_size_bigger_than_the_maximum"),
-			(size_t)-1, SOCKET_ID_ANY, 0);
+			(size_t)-1, RTE_NUMA_ID_ANY, 0);
 	if (mz != NULL) {
 		printf("It is impossible to reserve such big a memzone\n");
 		return -1;
@@ -186,7 +186,7 @@ test_memzone_reserve_flags(void)
 	 */
 	if (hugepage_2MB_avail) {
 		mz = rte_memzone_reserve(TEST_MEMZONE_NAME("flag_zone_2M"),
-				size, SOCKET_ID_ANY, RTE_MEMZONE_2MB);
+				size, RTE_NUMA_ID_ANY, RTE_MEMZONE_2MB);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 2MB\n");
 			return -1;
@@ -201,7 +201,7 @@ test_memzone_reserve_flags(void)
 		}
 
 		mz = rte_memzone_reserve(TEST_MEMZONE_NAME("flag_zone_2M_HINT"),
-				size, SOCKET_ID_ANY,
+				size, RTE_NUMA_ID_ANY,
 				RTE_MEMZONE_2MB|RTE_MEMZONE_SIZE_HINT_ONLY);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 2MB\n");
@@ -222,7 +222,7 @@ test_memzone_reserve_flags(void)
 		if (!hugepage_1GB_avail) {
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_1G_HINT"),
-					size, SOCKET_ID_ANY,
+					size, RTE_NUMA_ID_ANY,
 					RTE_MEMZONE_1GB|RTE_MEMZONE_SIZE_HINT_ONLY);
 			if (mz == NULL) {
 				printf("MEMZONE FLAG 1GB & HINT\n");
@@ -239,7 +239,7 @@ test_memzone_reserve_flags(void)
 
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_1G"), size,
-					SOCKET_ID_ANY, RTE_MEMZONE_1GB);
+					RTE_NUMA_ID_ANY, RTE_MEMZONE_1GB);
 			if (mz != NULL) {
 				printf("MEMZONE FLAG 1GB\n");
 				return -1;
@@ -250,7 +250,7 @@ test_memzone_reserve_flags(void)
 	/*As with 2MB tests above for 1GB huge page requests*/
 	if (hugepage_1GB_avail) {
 		mz = rte_memzone_reserve(TEST_MEMZONE_NAME("flag_zone_1G"),
-				size, SOCKET_ID_ANY, RTE_MEMZONE_1GB);
+				size, RTE_NUMA_ID_ANY, RTE_MEMZONE_1GB);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 1GB\n");
 			return -1;
@@ -265,7 +265,7 @@ test_memzone_reserve_flags(void)
 		}
 
 		mz = rte_memzone_reserve(TEST_MEMZONE_NAME("flag_zone_1G_HINT"),
-				size, SOCKET_ID_ANY,
+				size, RTE_NUMA_ID_ANY,
 				RTE_MEMZONE_1GB|RTE_MEMZONE_SIZE_HINT_ONLY);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 1GB\n");
@@ -286,7 +286,7 @@ test_memzone_reserve_flags(void)
 		if (!hugepage_2MB_avail) {
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_2M_HINT"),
-					size, SOCKET_ID_ANY,
+					size, RTE_NUMA_ID_ANY,
 					RTE_MEMZONE_2MB|RTE_MEMZONE_SIZE_HINT_ONLY);
 			if (mz == NULL){
 				printf("MEMZONE FLAG 2MB & HINT\n");
@@ -302,7 +302,7 @@ test_memzone_reserve_flags(void)
 			}
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_2M"), size,
-					SOCKET_ID_ANY, RTE_MEMZONE_2MB);
+					RTE_NUMA_ID_ANY, RTE_MEMZONE_2MB);
 			if (mz != NULL) {
 				printf("MEMZONE FLAG 2MB\n");
 				return -1;
@@ -312,7 +312,7 @@ test_memzone_reserve_flags(void)
 		if (hugepage_2MB_avail && hugepage_1GB_avail) {
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_2M_HINT"),
-					size, SOCKET_ID_ANY,
+					size, RTE_NUMA_ID_ANY,
 					RTE_MEMZONE_2MB|RTE_MEMZONE_1GB);
 			if (mz == NULL) {
 				printf("BOTH SIZES SET\n");
@@ -338,7 +338,7 @@ test_memzone_reserve_flags(void)
 	 */
 	if (hugepage_16MB_avail) {
 		mz = rte_memzone_reserve(TEST_MEMZONE_NAME("flag_zone_16M"),
-				size, SOCKET_ID_ANY, RTE_MEMZONE_16MB);
+				size, RTE_NUMA_ID_ANY, RTE_MEMZONE_16MB);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 16MB\n");
 			return -1;
@@ -354,7 +354,7 @@ test_memzone_reserve_flags(void)
 
 		mz = rte_memzone_reserve(
 				TEST_MEMZONE_NAME("flag_zone_16M_HINT"), size,
-				SOCKET_ID_ANY,
+				RTE_NUMA_ID_ANY,
 				RTE_MEMZONE_16MB|RTE_MEMZONE_SIZE_HINT_ONLY);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 16MB\n");
@@ -375,7 +375,7 @@ test_memzone_reserve_flags(void)
 		if (!hugepage_16GB_avail) {
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_16G_HINT"),
-					size, SOCKET_ID_ANY,
+					size, RTE_NUMA_ID_ANY,
 					RTE_MEMZONE_16GB |
 					RTE_MEMZONE_SIZE_HINT_ONLY);
 			if (mz == NULL) {
@@ -394,7 +394,7 @@ test_memzone_reserve_flags(void)
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_16G"),
 					size,
-					SOCKET_ID_ANY, RTE_MEMZONE_16GB);
+					RTE_NUMA_ID_ANY, RTE_MEMZONE_16GB);
 			if (mz != NULL) {
 				printf("MEMZONE FLAG 16GB\n");
 				return -1;
@@ -404,7 +404,7 @@ test_memzone_reserve_flags(void)
 	/*As with 16MB tests above for 16GB huge page requests*/
 	if (hugepage_16GB_avail) {
 		mz = rte_memzone_reserve(TEST_MEMZONE_NAME("flag_zone_16G"),
-				size, SOCKET_ID_ANY, RTE_MEMZONE_16GB);
+				size, RTE_NUMA_ID_ANY, RTE_MEMZONE_16GB);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 16GB\n");
 			return -1;
@@ -420,7 +420,7 @@ test_memzone_reserve_flags(void)
 
 		mz = rte_memzone_reserve(
 				TEST_MEMZONE_NAME("flag_zone_16G_HINT"), size,
-				SOCKET_ID_ANY,
+				RTE_NUMA_ID_ANY,
 				RTE_MEMZONE_16GB|RTE_MEMZONE_SIZE_HINT_ONLY);
 		if (mz == NULL) {
 			printf("MEMZONE FLAG 16GB\n");
@@ -441,7 +441,7 @@ test_memzone_reserve_flags(void)
 		if (!hugepage_16MB_avail) {
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_16M_HINT"),
-					size, SOCKET_ID_ANY,
+					size, RTE_NUMA_ID_ANY,
 					RTE_MEMZONE_16MB |
 					RTE_MEMZONE_SIZE_HINT_ONLY);
 			if (mz == NULL) {
@@ -458,7 +458,7 @@ test_memzone_reserve_flags(void)
 			}
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_16M"),
-					size, SOCKET_ID_ANY, RTE_MEMZONE_16MB);
+					size, RTE_NUMA_ID_ANY, RTE_MEMZONE_16MB);
 			if (mz != NULL) {
 				printf("MEMZONE FLAG 16MB\n");
 				return -1;
@@ -468,7 +468,7 @@ test_memzone_reserve_flags(void)
 		if (hugepage_16MB_avail && hugepage_16GB_avail) {
 			mz = rte_memzone_reserve(
 					TEST_MEMZONE_NAME("flag_zone_16M_HINT"),
-					size, SOCKET_ID_ANY,
+					size, RTE_NUMA_ID_ANY,
 					RTE_MEMZONE_16MB|RTE_MEMZONE_16GB);
 			if (mz == NULL) {
 				printf("BOTH SIZES SET\n");
@@ -491,12 +491,12 @@ test_memzone_reserve_flags(void)
 
 /* Find the heap with the greatest free block size */
 static size_t
-find_max_block_free_size(unsigned int align, unsigned int socket_id)
+find_max_block_free_size(unsigned int align, unsigned int numa_id)
 {
 	struct rte_malloc_numa_stats stats;
 	size_t len, overhead;
 
-	if (rte_malloc_get_numa_stats(socket_id, &stats) < 0)
+	if (rte_malloc_get_numa_stats(numa_id, &stats) < 0)
 		return 0;
 
 	len = stats.greatest_free_size;
@@ -519,13 +519,13 @@ test_memzone_reserve_max(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < rte_socket_count(); i++) {
+	for (i = 0; i < rte_numa_count(); i++) {
 		const struct rte_memzone *mz;
 		size_t maxlen;
-		int socket;
+		int numa_id;
 
-		socket = rte_socket_id_by_idx(i);
-		maxlen = find_max_block_free_size(0, socket);
+		numa_id = rte_numa_id_by_idx(i);
+		maxlen = find_max_block_free_size(0, numa_id);
 
 		if (maxlen == 0) {
 			printf("There is no space left!\n");
@@ -533,7 +533,7 @@ test_memzone_reserve_max(void)
 		}
 
 		mz = rte_memzone_reserve(TEST_MEMZONE_NAME("max_zone"), 0,
-				socket, 0);
+				numa_id, 0);
 		if (mz == NULL) {
 			printf("Failed to reserve a big chunk of memory - %s\n",
 					rte_strerror(rte_errno));
@@ -565,19 +565,19 @@ test_memzone_reserve_max_aligned(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < rte_socket_count(); i++) {
+	for (i = 0; i < rte_numa_count(); i++) {
 		const struct rte_memzone *mz;
 		size_t maxlen, minlen = 0;
-		int socket;
+		int numa_id;
 
-		socket = rte_socket_id_by_idx(i);
+		numa_id = rte_numa_id_by_idx(i);
 
 		/* random alignment */
 		const unsigned int align = 1 << ((rte_rand() % 8) + 5); /* from 128 up to 4k alignment */
 
 		/* memzone size may be between size and size - align */
-		minlen = find_max_block_free_size(align, socket);
-		maxlen = find_max_block_free_size(0, socket);
+		minlen = find_max_block_free_size(align, numa_id);
+		maxlen = find_max_block_free_size(0, numa_id);
 
 		if (minlen == 0 || maxlen == 0) {
 			printf("There is no space left for biggest %u-aligned memzone!\n",
@@ -587,7 +587,7 @@ test_memzone_reserve_max_aligned(void)
 
 		mz = rte_memzone_reserve_aligned(
 				TEST_MEMZONE_NAME("max_zone_aligned"),
-				0, socket, 0, align);
+				0, numa_id, 0, align);
 		if (mz == NULL) {
 			printf("Failed to reserve a big chunk of memory - %s\n",
 					rte_strerror(rte_errno));
@@ -632,27 +632,27 @@ test_memzone_aligned(void)
 
 	/* memzone that should automatically be adjusted to align on 64 bytes */
 	memzone_aligned_32 = rte_memzone_reserve_aligned(
-			TEST_MEMZONE_NAME("aligned_32"), 100, SOCKET_ID_ANY, 0,
+			TEST_MEMZONE_NAME("aligned_32"), 100, RTE_NUMA_ID_ANY, 0,
 			32);
 
 	/* memzone that is supposed to be aligned on a 128 byte boundary */
 	memzone_aligned_128 = rte_memzone_reserve_aligned(
-			TEST_MEMZONE_NAME("aligned_128"), 100, SOCKET_ID_ANY, 0,
+			TEST_MEMZONE_NAME("aligned_128"), 100, RTE_NUMA_ID_ANY, 0,
 			128);
 
 	/* memzone that is supposed to be aligned on a 256 byte boundary */
 	memzone_aligned_256 = rte_memzone_reserve_aligned(
-			TEST_MEMZONE_NAME("aligned_256"), 100, SOCKET_ID_ANY, 0,
+			TEST_MEMZONE_NAME("aligned_256"), 100, RTE_NUMA_ID_ANY, 0,
 			256);
 
 	/* memzone that is supposed to be aligned on a 512 byte boundary */
 	memzone_aligned_512 = rte_memzone_reserve_aligned(
-			TEST_MEMZONE_NAME("aligned_512"), 100, SOCKET_ID_ANY, 0,
+			TEST_MEMZONE_NAME("aligned_512"), 100, RTE_NUMA_ID_ANY, 0,
 			512);
 
 	/* memzone that is supposed to be aligned on a 1024 byte boundary */
 	memzone_aligned_1024 = rte_memzone_reserve_aligned(
-			TEST_MEMZONE_NAME("aligned_1024"), 100, SOCKET_ID_ANY,
+			TEST_MEMZONE_NAME("aligned_1024"), 100, RTE_NUMA_ID_ANY,
 			0, 1024);
 
 	printf("check alignments and lengths\n");
@@ -777,8 +777,9 @@ check_memzone_bounded(const char *name, uint32_t len,  uint32_t align,
 
 	bmask = ~((rte_iova_t)bound - 1);
 
-	if ((mz = rte_memzone_reserve_bounded(name, len, SOCKET_ID_ANY, 0,
-			align, bound)) == NULL) {
+	mz = rte_memzone_reserve_bounded(name, len, RTE_NUMA_ID_ANY, 0,
+			align, bound);
+	if (mz == NULL) {
 		printf("%s(%s): memzone creation failed\n",
 			__func__, name);
 		return -1;
@@ -827,7 +828,7 @@ test_memzone_bounded(void)
 	/* should fail as boundary is not power of two */
 	memzone_err = rte_memzone_reserve_bounded(
 			TEST_MEMZONE_NAME("bounded_error_31"), 100,
-			SOCKET_ID_ANY, 0, 32, UINT32_MAX);
+			RTE_NUMA_ID_ANY, 0, 32, UINT32_MAX);
 	if (memzone_err != NULL) {
 		printf("%s(%s)created a memzone with invalid boundary "
 			"conditions\n", __func__, memzone_err->name);
@@ -837,7 +838,7 @@ test_memzone_bounded(void)
 	/* should fail as len is greater then boundary */
 	memzone_err = rte_memzone_reserve_bounded(
 			TEST_MEMZONE_NAME("bounded_error_32"), 100,
-			SOCKET_ID_ANY, 0, 32, 32);
+			RTE_NUMA_ID_ANY, 0, 32, 32);
 	if (memzone_err != NULL) {
 		printf("%s(%s)created a memzone with invalid boundary "
 			"conditions\n", __func__, memzone_err->name);
@@ -883,9 +884,9 @@ test_memzone_free(void)
 	}
 
 	mz[0] = rte_memzone_reserve(TEST_MEMZONE_NAME("tempzone0"), 2000,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	mz[1] = rte_memzone_reserve(TEST_MEMZONE_NAME("tempzone1"), 4000,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 
 	if (mz[0] > mz[1])
 		goto exit_test;
@@ -903,7 +904,7 @@ test_memzone_free(void)
 		goto exit_test;
 	}
 	mz[2] = rte_memzone_reserve(TEST_MEMZONE_NAME("tempzone2"), 2000,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 
 	if (mz[2] > mz[1]) {
 		printf("tempzone2 should have gotten the free entry from tempzone0\n");
@@ -930,7 +931,7 @@ test_memzone_free(void)
 	do {
 		snprintf(name, sizeof(name), TEST_MEMZONE_NAME("tempzone%u"),
 				i);
-		mz[i] = rte_memzone_reserve(name, 1, SOCKET_ID_ANY, 0);
+		mz[i] = rte_memzone_reserve(name, 1, RTE_NUMA_ID_ANY, 0);
 	} while (mz[i++] != NULL);
 
 	if (rte_memzone_free(mz[0])) {
@@ -938,7 +939,7 @@ test_memzone_free(void)
 		goto exit_test;
 	}
 	mz[0] = rte_memzone_reserve(TEST_MEMZONE_NAME("tempzone0new"), 0,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 
 	if (mz[0] == NULL) {
 		printf("Fail to create memzone - tempzone0new - when MAX memzones were "
@@ -987,7 +988,7 @@ test_memzone_basic(void)
 	memzone_cnt_before = memzone_walk_cnt;
 
 	memzone1 = rte_memzone_reserve(TEST_MEMZONE_NAME("testzone1"), 100,
-				SOCKET_ID_ANY, 0);
+				RTE_NUMA_ID_ANY, 0);
 
 	memzone2 = rte_memzone_reserve(TEST_MEMZONE_NAME("testzone2"), 1000,
 				0, 0);
@@ -996,7 +997,7 @@ test_memzone_basic(void)
 				1, 0);
 
 	memzone4 = rte_memzone_reserve(TEST_MEMZONE_NAME("testzone4"), 1024,
-				SOCKET_ID_ANY, 0);
+				RTE_NUMA_ID_ANY, 0);
 
 	/* memzone3 may be NULL if we don't have NUMA */
 	if (memzone1 == NULL || memzone2 == NULL || memzone4 == NULL)
@@ -1052,12 +1053,12 @@ test_memzone_basic(void)
 					memzone3->iova, memzone3->len))
 		return -1;
 
-	printf("check socket ID\n");
+	printf("check numa_id ID\n");
 
-	/* memzone2 must be on socket id 0 and memzone3 on socket 1 */
-	if (memzone2->socket_id != 0)
+	/* memzone2 must be on numa_id id 0 and memzone3 on numa_id 1 */
+	if (memzone2->numa_id != 0)
 		return -1;
-	if (memzone3 != NULL && memzone3->socket_id != 1)
+	if (memzone3 != NULL && memzone3->numa_id != 1)
 		return -1;
 
 	printf("test zone lookup\n");
@@ -1067,7 +1068,7 @@ test_memzone_basic(void)
 
 	printf("test duplicate zone name\n");
 	mz = rte_memzone_reserve(TEST_MEMZONE_NAME("testzone1"), 100,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	if (mz != NULL)
 		return -1;
 
diff --git a/app/test/test_metrics.c b/app/test/test_metrics.c
index b1c7694b41..68e9d13436 100644
--- a/app/test/test_metrics.c
+++ b/app/test/test_metrics.c
@@ -23,7 +23,7 @@
 static int
 test_metrics_init(void)
 {
-	rte_metrics_init(rte_socket_id());
+	rte_metrics_init(rte_numa_id());
 	return TEST_SUCCESS;
 }
 
diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index d89419c253..0ec9666b6c 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -132,7 +132,7 @@ run_object_creation_tests(void)
 	printf("### Testing object creation - expect lots of mz reserve errors!\n");
 
 	rte_errno = 0;
-	if ((rte_memzone_reserve("test_mz", size, rte_socket_id(),
+	if ((rte_memzone_reserve("test_mz", size, rte_numa_id(),
 				 flags) == NULL) &&
 	    (rte_memzone_lookup("test_mz") == NULL)) {
 		printf("Error: unexpected return value from rte_memzone_reserve\n");
@@ -142,7 +142,7 @@ run_object_creation_tests(void)
 
 	rte_errno = 0;
 	if ((rte_ring_create(
-		     "test_ring", size, rte_socket_id(), flags) == NULL) &&
+		     "test_ring", size, rte_numa_id(), flags) == NULL) &&
 		    (rte_ring_lookup("test_ring") == NULL)){
 		printf("Error: unexpected return value from rte_ring_create()\n");
 		return -1;
@@ -152,7 +152,7 @@ run_object_creation_tests(void)
 	rte_errno = 0;
 	if ((rte_mempool_create("test_mp", size, elt_size, cache_size,
 				priv_data_size, NULL, NULL, NULL, NULL,
-				rte_socket_id(), flags) == NULL) &&
+				rte_numa_id(), flags) == NULL) &&
 	     (rte_mempool_lookup("test_mp") == NULL)){
 		printf("Error: unexpected return value from rte_mempool_create()\n");
 		return -1;
@@ -183,7 +183,7 @@ run_object_creation_tests(void)
 	rte_errno=0;
 	struct rte_lpm_config config;
 
-	config.max_rules = rte_socket_id();
+	config.max_rules = rte_numa_id();
 	config.number_tbl8s = 256;
 	config.flags = 0;
 	if ((rte_lpm_create("test_lpm", size, &config) != NULL) &&
diff --git a/app/test/test_net_ether.c b/app/test/test_net_ether.c
index a1ead2eba8..1b5d8904f7 100644
--- a/app/test/test_net_ether.c
+++ b/app/test/test_net_ether.c
@@ -257,7 +257,7 @@ static int
 net_ether_testsuite_setup(void)
 {
 	net_ether_test_pool = rte_pktmbuf_pool_create("net_ether_test_pool", 64, 0, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, SOCKET_ID_ANY);
+			RTE_MBUF_DEFAULT_BUF_SIZE, RTE_NUMA_ID_ANY);
 	TEST_ASSERT_NOT_NULL(net_ether_test_pool, "Failed to create mempool");
 
 	return TEST_SUCCESS;
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 688b58794e..8c1336b324 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -231,7 +231,7 @@ test_setup(void)
 	mp = rte_pktmbuf_pool_create_by_ops("pcapng_test_pool",
 					    MAX_BURST * 32, 0, 0,
 					    rte_pcapng_mbuf_size(MAX_DATA_SIZE),
-					    SOCKET_ID_ANY, "ring_mp_sc");
+					    RTE_NUMA_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
 		printf("Cannot create mempool\n");
 		goto fail;
diff --git a/app/test/test_pdcp.c b/app/test/test_pdcp.c
index af525cf73a..805b39a80f 100644
--- a/app/test/test_pdcp.c
+++ b/app/test/test_pdcp.c
@@ -275,7 +275,7 @@ cryptodev_init(int dev_id)
 	struct rte_cryptodev_qp_conf qp_conf;
 	struct rte_cryptodev_info dev_info;
 	struct rte_cryptodev_config config;
-	int ret, socket_id;
+	int ret, numa_id;
 
 	/* Check if device was already initialized */
 	if (ts_params->cdevs_used[dev_id])
@@ -288,11 +288,11 @@ cryptodev_init(int dev_id)
 		return -ENODEV;
 	}
 
-	socket_id = rte_socket_id();
+	numa_id = rte_numa_id();
 
 	memset(&config, 0, sizeof(config));
 	config.nb_queue_pairs = 1;
-	config.socket_id = socket_id;
+	config.numa_id = numa_id;
 
 	ret = rte_cryptodev_configure(dev_id, &config);
 	if (ret < 0) {
@@ -303,7 +303,7 @@ cryptodev_init(int dev_id)
 	memset(&qp_conf, 0, sizeof(qp_conf));
 	qp_conf.nb_descriptors = NB_DESC;
 
-	ret = rte_cryptodev_queue_pair_setup(dev_id, 0, &qp_conf, socket_id);
+	ret = rte_cryptodev_queue_pair_setup(dev_id, 0, &qp_conf, numa_id);
 	if (ret < 0) {
 		RTE_LOG(ERR, USER1, "Could not configure queue pair\n");
 		return -ENODEV;
@@ -369,7 +369,7 @@ testsuite_setup(void)
 	memset(ts_params, 0, sizeof(*ts_params));
 
 	ts_params->mbuf_pool = rte_pktmbuf_pool_create("mbuf_pool", NUM_MBUFS, MBUF_CACHE_SIZE, 0,
-						       PDCP_MBUF_SIZE, SOCKET_ID_ANY);
+						       PDCP_MBUF_SIZE, RTE_NUMA_ID_ANY);
 	if (ts_params->mbuf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Could not create mbuf pool\n");
 		return TEST_FAILED;
@@ -377,7 +377,7 @@ testsuite_setup(void)
 
 	ts_params->cop_pool = rte_crypto_op_pool_create("cop_pool", RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 							 NUM_MBUFS, MBUF_CACHE_SIZE,
-							 2 * MAXIMUM_IV_LENGTH, SOCKET_ID_ANY);
+							 2 * MAXIMUM_IV_LENGTH, RTE_NUMA_ID_ANY);
 	if (ts_params->cop_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Could not create crypto_op pool\n");
 		goto mbuf_pool_free;
@@ -389,7 +389,7 @@ testsuite_setup(void)
 	ts_params->sess_pool = rte_cryptodev_sym_session_pool_create("sess_pool", nb_sess,
 								     sess_priv_size,
 								     RTE_MEMPOOL_CACHE_MAX_SIZE,
-								     0, SOCKET_ID_ANY);
+								     0, RTE_NUMA_ID_ANY);
 	if (ts_params->sess_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Could not create session pool\n");
 		goto cop_pool_free;
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index f1c9bd9d7e..0d575161d2 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -60,7 +60,7 @@ run_pdump_client_tests(void)
 	if (ret < 0)
 		return -1;
 	mp->flags = 0x0000;
-	ring_client = rte_ring_create("SR0", RING_SIZE, rte_socket_id(), 0);
+	ring_client = rte_ring_create("SR0", RING_SIZE, rte_numa_id(), 0);
 	if (ring_client == NULL) {
 		printf("rte_ring_create SR0 failed");
 		return -1;
diff --git a/app/test/test_per_lcore.c b/app/test/test_per_lcore.c
index 6e7ba072fd..3b536d332a 100644
--- a/app/test/test_per_lcore.c
+++ b/app/test/test_per_lcore.c
@@ -48,9 +48,9 @@ display_vars(__rte_unused void *arg)
 {
 	unsigned lcore_id = rte_lcore_id();
 	unsigned var = RTE_PER_LCORE(test);
-	unsigned socket_id = rte_lcore_to_socket_id(lcore_id);
+	unsigned int numa_id = rte_lcore_to_numa_id(lcore_id);
 
-	printf("on socket %u, on core %u, variable is %u\n", socket_id, lcore_id, var);
+	printf("on socket %u, on core %u, variable is %u\n", numa_id, lcore_id, var);
 	if (lcore_id != var)
 		return -1;
 
diff --git a/app/test/test_pmd_af_packet.c b/app/test/test_pmd_af_packet.c
index 42456c1d96..774046570a 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -181,7 +181,7 @@ configure_af_packet_port(uint16_t pid, uint16_t nb_rx_q, uint16_t nb_tx_q)
 
 	for (q = 0; q < nb_rx_q; q++) {
 		ret = rte_eth_rx_queue_setup(pid, q, RING_SIZE,
-					     rte_eth_dev_socket_id(pid),
+					     rte_eth_dev_numa_id(pid),
 					     NULL, mp);
 		if (ret != 0) {
 			printf("Failed to setup RX queue %u for port %u: %d\n",
@@ -192,7 +192,7 @@ configure_af_packet_port(uint16_t pid, uint16_t nb_rx_q, uint16_t nb_tx_q)
 
 	for (q = 0; q < nb_tx_q; q++) {
 		ret = rte_eth_tx_queue_setup(pid, q, RING_SIZE,
-					     rte_eth_dev_socket_id(pid),
+					     rte_eth_dev_numa_id(pid),
 					     NULL);
 		if (ret != 0) {
 			printf("Failed to setup TX queue %u for port %u: %d\n",
@@ -392,7 +392,7 @@ test_af_packet_setup(void)
 	mp = rte_pktmbuf_pool_create("af_packet_test_pool", NUM_MBUFS,
 				     MBUF_CACHE_SIZE, 0,
 				     RTE_MBUF_DEFAULT_BUF_SIZE,
-				     rte_socket_id());
+				     rte_numa_id());
 	if (mp == NULL) {
 		printf("Failed to create mempool\n");
 		return -1;
@@ -1059,12 +1059,12 @@ test_af_packet_multi_queue(void)
 
 	for (q = 0; q < num_queues; q++) {
 		ret = rte_eth_rx_queue_setup(test_port, q, RING_SIZE,
-					     rte_eth_dev_socket_id(test_port),
+					     rte_eth_dev_numa_id(test_port),
 					     NULL, mp);
 		TEST_ASSERT(ret == 0, "Failed to setup RX queue %u", q);
 
 		ret = rte_eth_tx_queue_setup(test_port, q, RING_SIZE,
-					     rte_eth_dev_socket_id(test_port),
+					     rte_eth_dev_numa_id(test_port),
 					     NULL);
 		TEST_ASSERT(ret == 0, "Failed to setup TX queue %u", q);
 	}
diff --git a/app/test/test_pmd_memif.c b/app/test/test_pmd_memif.c
index 840ba4bf96..9693765edd 100644
--- a/app/test/test_pmd_memif.c
+++ b/app/test/test_pmd_memif.c
@@ -668,7 +668,7 @@ test_memif_setup(void)
 	int ret;
 
 	mp = rte_pktmbuf_pool_create("memif_test_pool", NB_MBUF, 32, 0,
-				     RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+				     RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mp == NULL) {
 		printf("Error: failed to create mempool: %s\n",
 		       rte_strerror(rte_errno));
diff --git a/app/test/test_pmd_pcap.c b/app/test/test_pmd_pcap.c
index 4fb0f69f3a..27282b60a3 100644
--- a/app/test/test_pmd_pcap.c
+++ b/app/test/test_pmd_pcap.c
@@ -2304,7 +2304,7 @@ test_multi_tx_queue(void)
 	memset(&tx_conf, 0, sizeof(tx_conf));
 	for (q = 0; q < MULTI_QUEUE_NUM_QUEUES; q++) {
 		ret = rte_eth_tx_queue_setup(port_id, q, RING_SIZE,
-					     rte_eth_dev_socket_id(port_id), &tx_conf);
+					     rte_eth_dev_numa_id(port_id), &tx_conf);
 		TEST_ASSERT_SUCCESS(ret, "Failed to setup TX queue %u: %s", q, rte_strerror(-ret));
 	}
 
@@ -2423,7 +2423,7 @@ test_multi_rx_queue_same_file(void)
 	memset(&rx_conf, 0, sizeof(rx_conf));
 	for (q = 0; q < MULTI_QUEUE_NUM_QUEUES; q++) {
 		ret = rte_eth_rx_queue_setup(port_id, q, RING_SIZE,
-					     rte_eth_dev_socket_id(port_id), &rx_conf, mp);
+					     rte_eth_dev_numa_id(port_id), &rx_conf, mp);
 		TEST_ASSERT_SUCCESS(ret, "Failed to setup RX queue %u: %s", q, rte_strerror(-ret));
 	}
 
@@ -2923,7 +2923,7 @@ test_setup(void)
 
 	mp = rte_pktmbuf_pool_create("pcap_test_pool", NB_MBUF, 32, 0,
 				     RTE_MBUF_DEFAULT_BUF_SIZE,
-				     rte_socket_id());
+				     rte_numa_id());
 	TEST_ASSERT_NOT_NULL(mp, "Failed to create mempool");
 
 	return 0;
diff --git a/app/test/test_pmd_perf.c b/app/test/test_pmd_perf.c
index 995b0a6f20..e4ff8bfde9 100644
--- a/app/test/test_pmd_perf.c
+++ b/app/test/test_pmd_perf.c
@@ -15,7 +15,7 @@
 #include "test.h"
 
 #define NB_ETHPORTS_USED                (1)
-#define NB_SOCKETS                      (2)
+#define NB_NUMAS                      (2)
 #define MEMPOOL_CACHE_SIZE 250
 #define MAX_PKT_BURST                   (32)
 #define RX_DESC_DEFAULT        (1024)
@@ -55,7 +55,7 @@
 			(unsigned)8192)
 
 
-static struct rte_mempool *mbufpool[NB_SOCKETS];
+static struct rte_mempool *mbufpool[NB_NUMAS];
 /* ethernet addresses of ports */
 static struct rte_ether_addr ports_eth_addr[RTE_MAX_ETHPORTS];
 
@@ -96,7 +96,7 @@ enum {
 
 struct __rte_cache_aligned lcore_conf {
 	uint8_t status;
-	uint8_t socketid;
+	uint8_t numaid;
 	uint16_t nb_ports;
 	uint16_t portlist[RTE_MAX_ETHPORTS];
 };
@@ -218,8 +218,8 @@ init_lcores(void)
 	unsigned lcore_id;
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		lcore_conf[lcore_id].socketid =
-			rte_lcore_to_socket_id(lcore_id);
+		lcore_conf[lcore_id].numaid =
+			rte_lcore_to_numa_id(lcore_id);
 		if (rte_lcore_is_enabled(lcore_id) == 0) {
 			lcore_conf[lcore_id].status = LCORE_INVALID;
 			continue;
@@ -232,7 +232,7 @@ init_lcores(void)
 static int
 init_mbufpool(unsigned nb_mbuf)
 {
-	int socketid;
+	int numaid;
 	unsigned lcore_id;
 	char s[64];
 
@@ -240,39 +240,39 @@ init_mbufpool(unsigned nb_mbuf)
 		if (rte_lcore_is_enabled(lcore_id) == 0)
 			continue;
 
-		socketid = rte_lcore_to_socket_id(lcore_id);
-		if (socketid >= NB_SOCKETS) {
+		numaid = rte_lcore_to_numa_id(lcore_id);
+		if (numaid >= NB_NUMAS) {
 			rte_exit(EXIT_FAILURE,
 				"Socket %d of lcore %u is out of range %d\n",
-				socketid, lcore_id, NB_SOCKETS);
+				numaid, lcore_id, NB_NUMAS);
 		}
-		if (mbufpool[socketid] == NULL) {
-			snprintf(s, sizeof(s), "mbuf_pool_%d", socketid);
-			mbufpool[socketid] =
+		if (mbufpool[numaid] == NULL) {
+			snprintf(s, sizeof(s), "mbuf_pool_%d", numaid);
+			mbufpool[numaid] =
 				rte_pktmbuf_pool_create(s, nb_mbuf,
 					MEMPOOL_CACHE_SIZE, 0,
-					RTE_MBUF_DEFAULT_BUF_SIZE, socketid);
-			if (mbufpool[socketid] == NULL)
+					RTE_MBUF_DEFAULT_BUF_SIZE, numaid);
+			if (mbufpool[numaid] == NULL)
 				rte_exit(EXIT_FAILURE,
 					"Cannot init mbuf pool on socket %d\n",
-					socketid);
+					numaid);
 			else
 				printf("Allocated mbuf pool on socket %d\n",
-					socketid);
+					numaid);
 		}
 	}
 	return 0;
 }
 
 static uint16_t
-alloc_lcore(int socketid)
+alloc_lcore(int numaid)
 {
 	unsigned lcore_id;
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (LCORE_AVAIL != lcore_conf[lcore_id].status ||
-		    (socketid != SOCKET_ID_ANY &&
-		     lcore_conf[lcore_id].socketid != socketid) ||
+		    (numaid != RTE_NUMA_ID_ANY &&
+		     lcore_conf[lcore_id].numaid != numaid) ||
 		    lcore_id == rte_get_main_lcore())
 			continue;
 		lcore_conf[lcore_id].status = LCORE_USED;
@@ -563,9 +563,9 @@ poll_burst(void *args)
 	printf("start to receive total expect %"PRIu64"\n", total);
 
 	pkts_burst = (struct rte_mbuf **)
-		rte_calloc_socket("poll_burst",
+		rte_calloc_numa("poll_burst",
 				  total, sizeof(void *),
-				  RTE_CACHE_LINE_SIZE, conf->socketid);
+				  RTE_CACHE_LINE_SIZE, conf->numaid);
 	if (!pkts_burst)
 		return -1;
 
@@ -677,7 +677,7 @@ test_pmd_perf(void)
 	uint16_t nb_txd = MAX_TRAFFIC_BURST;
 	uint16_t portid;
 	uint16_t nb_rx_queue = 1, nb_tx_queue = 1;
-	int socketid = -1;
+	int numaid = -1;
 	int ret;
 
 	printf("Start PMD RXTX cycles cost test.\n");
@@ -710,19 +710,19 @@ test_pmd_perf(void)
 	reset_count();
 	num = 0;
 	RTE_ETH_FOREACH_DEV(portid) {
-		if (socketid == -1) {
-			worker_id = alloc_lcore(rte_eth_dev_socket_id(portid));
+		if (numaid == -1) {
+			worker_id = alloc_lcore(rte_eth_dev_numa_id(portid));
 			if (worker_id == (uint16_t)-1) {
 				printf("No avail lcore to run test\n");
 				return -1;
 			}
-			socketid = rte_lcore_to_socket_id(worker_id);
+			numaid = rte_lcore_to_numa_id(worker_id);
 			printf("Performance test runs on lcore %u socket %u\n",
-			       worker_id, socketid);
+			       worker_id, numaid);
 		}
 
-		if (socketid != rte_eth_dev_socket_id(portid) &&
-		    rte_eth_dev_socket_id(portid) != SOCKET_ID_ANY) {
+		if (numaid != rte_eth_dev_numa_id(portid) &&
+		    rte_eth_dev_numa_id(portid) != RTE_NUMA_ID_ANY) {
 			printf("Skip port %d\n", portid);
 			continue;
 		}
@@ -747,7 +747,7 @@ test_pmd_perf(void)
 
 		/* tx queue setup */
 		ret = rte_eth_tx_queue_setup(portid, 0, nb_txd,
-					     socketid, &tx_conf);
+					     numaid, &tx_conf);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE,
 				"rte_eth_tx_queue_setup: err=%d, "
@@ -755,8 +755,8 @@ test_pmd_perf(void)
 
 		/* rx queue steup */
 		ret = rte_eth_rx_queue_setup(portid, 0, nb_rxd,
-						socketid, &rx_conf,
-						mbufpool[socketid]);
+						numaid, &rx_conf,
+						mbufpool[numaid]);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE, "rte_eth_rx_queue_setup: err=%d,"
 				 "port=%d\n", ret, portid);
@@ -783,19 +783,19 @@ test_pmd_perf(void)
 
 	if (tx_burst == NULL) {
 		tx_burst = (struct rte_mbuf **)
-			rte_calloc_socket("tx_buff",
+			rte_calloc_numa("tx_buff",
 					  MAX_TRAFFIC_BURST * nb_ports,
 					  sizeof(void *),
-					  RTE_CACHE_LINE_SIZE, socketid);
+					  RTE_CACHE_LINE_SIZE, numaid);
 		if (!tx_burst)
 			return -1;
 	}
 
-	init_traffic(mbufpool[socketid],
+	init_traffic(mbufpool[numaid],
 		     tx_burst, MAX_TRAFFIC_BURST * nb_ports);
 
 	printf("Generate %d packets @socket %d\n",
-	       MAX_TRAFFIC_BURST * nb_ports, socketid);
+	       MAX_TRAFFIC_BURST * nb_ports, numaid);
 
 	if (sc_flag == SC_CONTINUOUS) {
 		/* do both rxtx by default */
@@ -813,7 +813,7 @@ test_pmd_perf(void)
 
 	/* port tear down */
 	RTE_ETH_FOREACH_DEV(portid) {
-		if (socketid != rte_eth_dev_socket_id(portid))
+		if (numaid != rte_eth_dev_numa_id(portid))
 			continue;
 
 		ret = rte_eth_dev_stop(portid);
diff --git a/app/test/test_pmd_ring.c b/app/test/test_pmd_ring.c
index 1f245f5ad5..e87d0aedf8 100644
--- a/app/test/test_pmd_ring.c
+++ b/app/test/test_pmd_ring.c
@@ -497,7 +497,7 @@ test_pmd_ringcreate_setup(void)
 	}
 
 	mp = rte_pktmbuf_pool_create("mbuf_pool", NB_MBUF, 32,
-			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mp == NULL)
 		return -1;
 
diff --git a/app/test/test_pmd_ring_perf.c b/app/test/test_pmd_ring_perf.c
index 3636df5c73..3d36428862 100644
--- a/app/test/test_pmd_ring_perf.c
+++ b/app/test/test_pmd_ring_perf.c
@@ -138,7 +138,7 @@ test_ring_pmd_perf(void)
 {
 	char name[RTE_ETH_NAME_MAX_LEN];
 
-	r = rte_ring_create(RING_NAME, RING_SIZE, rte_socket_id(),
+	r = rte_ring_create(RING_NAME, RING_SIZE, rte_numa_id(),
 			RING_F_SP_ENQ|RING_F_SC_DEQ);
 	if (r == NULL && (r = rte_ring_lookup(RING_NAME)) == NULL)
 		return -1;
diff --git a/app/test/test_pmd_tap.c b/app/test/test_pmd_tap.c
index 6d0e8b4f54..5e6c4982c8 100644
--- a/app/test/test_pmd_tap.c
+++ b/app/test/test_pmd_tap.c
@@ -574,7 +574,7 @@ test_tap_multi_queue(void)
 	/* Create a separate mempool for multi-queue test */
 	struct rte_mempool *mq_mp
 		= rte_pktmbuf_pool_create("tap_mq_pool", NB_MBUF, 32, 0,
-					  RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+					  RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mq_mp == NULL) {
 		printf("Warning: failed to create mempool for multi-queue test: %s\n",
 		       rte_strerror(rte_errno));
@@ -708,7 +708,7 @@ test_tap_setup(void)
 
 	/* Create mempool */
 	mp = rte_pktmbuf_pool_create("tap_test_pool", NB_MBUF, 32, 0,
-				     RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+				     RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mp == NULL) {
 		printf("Error: failed to create mempool: %s\n",
 		       rte_strerror(rte_errno));
@@ -836,7 +836,7 @@ test_tap_rx_queue_setup(void)
 	 */
 	printf("  Test: mempool with no usable data room\n");
 	tiny_mp = rte_pktmbuf_pool_create("tap_tiny_pool", 64, 0, 0,
-					  RTE_PKTMBUF_HEADROOM, rte_socket_id());
+					  RTE_PKTMBUF_HEADROOM, rte_numa_id());
 	if (tiny_mp == NULL) {
 		printf("Warning: could not create tiny mempool: %s\n",
 		       rte_strerror(rte_errno));
diff --git a/app/test/test_reassembly.c b/app/test/test_reassembly.c
index 480de8d1dd..5bc1804513 100644
--- a/app/test/test_reassembly.c
+++ b/app/test/test_reassembly.c
@@ -82,7 +82,7 @@ testsuite_setup(void)
 	rte_log_set_level_pattern("lib.ip_frag", RTE_LOG_NOTICE);
 
 	pkt_pool = rte_pktmbuf_pool_create("REASM_POOL", NB_MBUF, MBUF_CACHE,
-					   0, MBUF_DATA, SOCKET_ID_ANY);
+					   0, MBUF_DATA, RTE_NUMA_ID_ANY);
 	return pkt_pool == NULL ? TEST_FAILED : TEST_SUCCESS;
 }
 
@@ -111,7 +111,7 @@ static struct rte_ip_frag_tbl *
 tbl_new(uint64_t max_cycles)
 {
 	return rte_ip_frag_table_create(16, MAX_FRAG, 16, max_cycles,
-					rte_socket_id());
+					rte_numa_id());
 }
 
 /* Build one fragment with a position-dependent payload. */
diff --git a/app/test/test_reassembly_perf.c b/app/test/test_reassembly_perf.c
index 7d3c692547..9fa088758b 100644
--- a/app/test/test_reassembly_perf.c
+++ b/app/test/test_reassembly_perf.c
@@ -58,14 +58,14 @@ reassembly_test_setup(void)
 
 	frag_tbl = rte_ip_frag_table_create(MAX_BKTS, MAX_ENTRIES_PER_BKT,
 					    MAX_BKTS * MAX_ENTRIES_PER_BKT, max_ttl_cyc,
-					    rte_socket_id());
+					    rte_numa_id());
 	if (frag_tbl == NULL)
 		return TEST_FAILED;
 
 	rte_mbuf_set_user_mempool_ops("ring_mp_mc");
 	pkt_pool = rte_pktmbuf_pool_create(
 		"reassembly_perf_pool", MAX_FLOWS * MAX_FRAGMENTS, 0, 0,
-		RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (pkt_pool == NULL) {
 		printf("[%s] Failed to create pkt pool\n", __func__);
 		rte_ip_frag_table_destroy(frag_tbl);
diff --git a/app/test/test_reorder.c b/app/test/test_reorder.c
index 8c68e00869..b2df54b404 100644
--- a/app/test/test_reorder.c
+++ b/app/test/test_reorder.c
@@ -37,15 +37,15 @@ test_reorder_create(void)
 {
 	struct rte_reorder_buffer *b = NULL;
 
-	b = rte_reorder_create(NULL, rte_socket_id(), REORDER_BUFFER_SIZE);
+	b = rte_reorder_create(NULL, rte_numa_id(), REORDER_BUFFER_SIZE);
 	TEST_ASSERT((b == NULL) && (rte_errno == EINVAL),
 			"No error on create() with NULL name");
 
-	b = rte_reorder_create("PKT", rte_socket_id(), REORDER_BUFFER_SIZE_INVALID);
+	b = rte_reorder_create("PKT", rte_numa_id(), REORDER_BUFFER_SIZE_INVALID);
 	TEST_ASSERT((b == NULL) && (rte_errno == EINVAL),
 			"No error on create() with invalid buffer size param.");
 
-	b = rte_reorder_create("PKT_RO1", rte_socket_id(), REORDER_BUFFER_SIZE);
+	b = rte_reorder_create("PKT_RO1", rte_numa_id(), REORDER_BUFFER_SIZE);
 	TEST_ASSERT_EQUAL(b, test_params->b,
 			"New reorder instance created with already existing name");
 
@@ -112,7 +112,7 @@ test_reorder_free(void)
 	struct rte_reorder_buffer *b1 = NULL, *b2 = NULL;
 	const char *name = "test_free";
 
-	b1 = rte_reorder_create(name, rte_socket_id(), 8);
+	b1 = rte_reorder_create(name, rte_numa_id(), 8);
 	TEST_ASSERT_NOT_NULL(b1, "Failed to create reorder buffer.");
 
 	b2 = rte_reorder_find_existing(name);
@@ -144,7 +144,7 @@ test_reorder_insert(void)
 	 * ready_buf: RB[size] = {NULL, NULL, NULL, NULL}
 	 * order_buf: OB[size] = {NULL, NULL, NULL, NULL}
 	 */
-	b = rte_reorder_create("test_insert", rte_socket_id(), size);
+	b = rte_reorder_create("test_insert", rte_numa_id(), size);
 	TEST_ASSERT_NOT_NULL(b, "Failed to create reorder buffer");
 
 	for (i = 0; i < INSERT_NUM_BUFS; i++) {
@@ -236,7 +236,7 @@ test_reorder_drain(void)
 	 * ready_buf: RB[size] = {NULL, NULL, NULL, NULL}
 	 * order_buf: OB[size] = {NULL, NULL, NULL, NULL}
 	 */
-	b = rte_reorder_create("test_drain", rte_socket_id(), size);
+	b = rte_reorder_create("test_drain", rte_numa_id(), size);
 	TEST_ASSERT_NOT_NULL(b, "Failed to create reorder buffer");
 
 	/* Check no drained packets if reorder is empty */
@@ -358,7 +358,7 @@ test_reorder_drain_up_to_seqn(void)
 	 * ready_buf: RB[size] = {NULL, NULL, NULL, NULL}
 	 * order_buf: OB[size] = {NULL, NULL, NULL, NULL}
 	 */
-	b = rte_reorder_create("test_drain_up_to_seqn", rte_socket_id(), size);
+	b = rte_reorder_create("test_drain_up_to_seqn", rte_numa_id(), size);
 	TEST_ASSERT_NOT_NULL(b, "Failed to create reorder buffer");
 
 	for (i = 0; i < DRAIN_TO_NUM_BUFS; i++) {
@@ -438,7 +438,7 @@ test_reorder_set_seqn(void)
 	 * ready_buf: RB[size] = {NULL, NULL, NULL, NULL}
 	 * order_buf: OB[size] = {NULL, NULL, NULL, NULL}
 	 */
-	b = rte_reorder_create("test_min_seqn_set", rte_socket_id(), size);
+	b = rte_reorder_create("test_min_seqn_set", rte_numa_id(), size);
 	TEST_ASSERT_NOT_NULL(b, "Failed to create reorder buffer");
 
 	for (i = 0; i < SET_SEQN_NUM_BUFS; i++) {
@@ -494,7 +494,7 @@ test_setup(void)
 {
 	/* reorder buffer instance creation */
 	if (test_params->b == NULL) {
-		test_params->b = rte_reorder_create("PKT_RO1", rte_socket_id(),
+		test_params->b = rte_reorder_create("PKT_RO1", rte_numa_id(),
 							REORDER_BUFFER_SIZE);
 		if (test_params->b == NULL) {
 			printf("%s: Error creating reorder buffer instance b\n",
@@ -508,7 +508,7 @@ test_setup(void)
 	if (test_params->p == NULL) {
 		test_params->p = rte_pktmbuf_pool_create("RO_MBUF_POOL",
 			NUM_MBUFS, BURST, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 		if (test_params->p == NULL) {
 			printf("%s: Error creating mempool\n", __func__);
 			return -1;
diff --git a/app/test/test_rib.c b/app/test/test_rib.c
index a4a683140d..0fe5c89a05 100644
--- a/app/test/test_rib.c
+++ b/app/test/test_rib.c
@@ -39,23 +39,23 @@ test_create_invalid(void)
 	config.ext_sz = 0;
 
 	/* rte_rib_create: rib name == NULL */
-	rib = rte_rib_create(NULL, SOCKET_ID_ANY, &config);
+	rib = rte_rib_create(NULL, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_rib_create: config == NULL */
-	rib = rte_rib_create(__func__, SOCKET_ID_ANY, NULL);
+	rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, NULL);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 
-	/* socket_id < -1 is invalid */
+	/* numa_id < -1 is invalid */
 	rib = rte_rib_create(__func__, -2, &config);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_rib_create: max_nodes = 0 */
 	config.max_nodes = 0;
-	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.max_nodes = MAX_RULES;
@@ -78,7 +78,7 @@ test_multiple_create(void)
 
 	for (i = 0; i < 100; i++) {
 		config.max_nodes = MAX_RULES - i;
-		rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+		rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, &config);
 		RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 		rte_rib_free(rib);
 	}
@@ -101,7 +101,7 @@ test_free_null(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	rte_rib_free(rib);
@@ -130,7 +130,7 @@ test_insert_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/*Create valid rib to use in rest of test. */
-	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	/* rte_rib_insert: depth > MAX_DEPTH */
@@ -173,7 +173,7 @@ test_get_fn(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	node = rte_rib_insert(rib, ip, depth);
@@ -251,7 +251,7 @@ test_basic(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	node = rte_rib_insert(rib, ip, depth);
@@ -304,7 +304,7 @@ test_tree_traversal(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	node = rte_rib_insert(rib, ip1, depth);
diff --git a/app/test/test_rib6.c b/app/test/test_rib6.c
index 0295a9640c..f1762bc7d4 100644
--- a/app/test/test_rib6.c
+++ b/app/test/test_rib6.c
@@ -38,23 +38,23 @@ test_create_invalid(void)
 	config.ext_sz = 0;
 
 	/* rte_rib6_create: rib name == NULL */
-	rib = rte_rib6_create(NULL, SOCKET_ID_ANY, &config);
+	rib = rte_rib6_create(NULL, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_rib6_create: config == NULL */
-	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, NULL);
+	rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, NULL);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 
-	/* socket_id < -1 is invalid */
+	/* numa_id < -1 is invalid */
 	rib = rte_rib6_create(__func__, -2, &config);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_rib6_create: max_nodes = 0 */
 	config.max_nodes = 0;
-	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.max_nodes = MAX_RULES;
@@ -77,7 +77,7 @@ test_multiple_create(void)
 
 	for (i = 0; i < 100; i++) {
 		config.max_nodes = MAX_RULES - i;
-		rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+		rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 		RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 		rte_rib6_free(rib);
 	}
@@ -100,7 +100,7 @@ test_free_null(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	rte_rib6_free(rib);
@@ -130,7 +130,7 @@ test_insert_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/*Create valid rib to use in rest of test. */
-	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	/* rte_rib6_insert: depth > MAX_DEPTH */
@@ -173,7 +173,7 @@ test_get_fn(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	node = rte_rib6_insert(rib, &ip, depth);
@@ -251,7 +251,7 @@ test_basic(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	node = rte_rib6_insert(rib, &ip, depth);
@@ -305,7 +305,7 @@ test_tree_traversal(void)
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
 
-	rib = rte_rib6_create(__func__, SOCKET_ID_ANY, &config);
+	rib = rte_rib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
 
 	node = rte_rib6_insert(rib, &ip1, depth);
diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index 015623659f..cba18d6206 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -506,7 +506,7 @@ test_ring_negative_tests(void)
 	unsigned int i;
 
 	/* Test zero size ring */
-	rp = test_ring_create("test_zero_size_ring", -1, 0, SOCKET_ID_ANY, 0);
+	rp = test_ring_create("test_zero_size_ring", -1, 0, RTE_NUMA_ID_ANY, 0);
 	if (rp != NULL) {
 		printf("Test failed to detect zero size ring\n");
 		goto test_fail;
@@ -514,7 +514,7 @@ test_ring_negative_tests(void)
 
 	/* Test with esize not a multiple of 4 */
 	rp = test_ring_create("test_bad_element_size", 23,
-				RING_SIZE + 1, SOCKET_ID_ANY, 0);
+				RING_SIZE + 1, RTE_NUMA_ID_ANY, 0);
 	if (rp != NULL) {
 		printf("Test failed to detect invalid element size\n");
 		goto test_fail;
@@ -524,7 +524,7 @@ test_ring_negative_tests(void)
 	for (i = 0; i < RTE_DIM(esize); i++) {
 		/* Test if ring size is not power of 2 */
 		rp = test_ring_create("test_bad_ring_size", esize[i],
-					RING_SIZE + 1, SOCKET_ID_ANY, 0);
+					RING_SIZE + 1, RTE_NUMA_ID_ANY, 0);
 		if (rp != NULL) {
 			printf("Test failed to detect odd count\n");
 			goto test_fail;
@@ -532,7 +532,7 @@ test_ring_negative_tests(void)
 
 		/* Test if ring size is exceeding the limit */
 		rp = test_ring_create("test_bad_ring_size", esize[i],
-					RTE_RING_SZ_MASK + 1, SOCKET_ID_ANY, 0);
+					RTE_RING_SZ_MASK + 1, RTE_NUMA_ID_ANY, 0);
 		if (rp != NULL) {
 			printf("Test failed to detect limits\n");
 			goto test_fail;
@@ -549,12 +549,12 @@ test_ring_negative_tests(void)
 		 * function to fail correctly
 		 */
 		rp = test_ring_create("test_ring_count", esize[i], 4097,
-					SOCKET_ID_ANY, 0);
+					RTE_NUMA_ID_ANY, 0);
 		if (rp != NULL)
 			goto test_fail;
 
 		rp = test_ring_create("test_ring_negative", esize[i], RING_SIZE,
-					SOCKET_ID_ANY,
+					RTE_NUMA_ID_ANY,
 					RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (rp == NULL) {
 			printf("test_ring_negative fail to create ring\n");
@@ -570,7 +570,7 @@ test_ring_negative_tests(void)
 		 * ring name.
 		 */
 		rt = test_ring_create("test_ring_negative", esize[i], RING_SIZE,
-					SOCKET_ID_ANY, 0);
+					RTE_NUMA_ID_ANY, 0);
 		if (rt != NULL)
 			goto test_fail;
 
@@ -606,7 +606,7 @@ test_ring_burst_bulk_tests1(unsigned int test_idx)
 
 		/* Create the ring */
 		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
-				RING_SIZE, SOCKET_ID_ANY,
+				RING_SIZE, RTE_NUMA_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
@@ -701,7 +701,7 @@ test_ring_burst_bulk_tests2(unsigned int test_idx)
 
 		/* Create the ring */
 		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
-				RING_SIZE, SOCKET_ID_ANY,
+				RING_SIZE, RTE_NUMA_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
@@ -788,7 +788,7 @@ test_ring_burst_bulk_tests3(unsigned int test_idx)
 
 		/* Create the ring */
 		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
-				RING_SIZE, SOCKET_ID_ANY,
+				RING_SIZE, RTE_NUMA_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
@@ -862,7 +862,7 @@ test_ring_burst_bulk_tests4(unsigned int test_idx)
 
 		/* Create the ring */
 		r = test_ring_create("test_ring_burst_bulk_tests", esize[i],
-				RING_SIZE, SOCKET_ID_ANY,
+				RING_SIZE, RTE_NUMA_ID_ANY,
 				test_enqdeq_impl[test_idx].create_flags);
 
 		/* alloc dummy object pointers */
@@ -975,7 +975,7 @@ test_ring_basic_ex(void)
 
 	for (i = 0; i < RTE_DIM(esize); i++) {
 		rp = test_ring_create("test_ring_basic_ex", esize[i], RING_SIZE,
-					SOCKET_ID_ANY,
+					RTE_NUMA_ID_ANY,
 					RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (rp == NULL) {
 			printf("%s: failed to create ring\n", __func__);
@@ -1102,14 +1102,14 @@ test_ring_with_exact_size(void)
 				esize[i]);
 
 		std_r = test_ring_create("std", esize[i], ring_sz,
-					rte_socket_id(),
+					rte_numa_id(),
 					RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (std_r == NULL) {
 			printf("%s: error, can't create std ring\n", __func__);
 			goto test_fail;
 		}
 		exact_sz_r = test_ring_create("exact sz", esize[i], ring_sz,
-				rte_socket_id(),
+				rte_numa_id(),
 				RING_F_SP_ENQ | RING_F_SC_DEQ |
 				RING_F_EXACT_SZ);
 		if (exact_sz_r == NULL) {
diff --git a/app/test/test_ring.h b/app/test/test_ring.h
index 2e0ff9c1d6..ce1f1ca990 100644
--- a/app/test/test_ring.h
+++ b/app/test/test_ring.h
@@ -38,14 +38,14 @@
  */
 static inline struct rte_ring*
 test_ring_create(const char *name, int esize, unsigned int count,
-		int socket_id, unsigned int flags)
+		int numa_id, unsigned int flags)
 {
 	/* Legacy queue APIs? */
 	if (esize == -1)
-		return rte_ring_create(name, count, socket_id, flags);
+		return rte_ring_create(name, count, numa_id, flags);
 	else
 		return rte_ring_create_elem(name, esize, count,
-						socket_id, flags);
+						numa_id, flags);
 }
 
 static inline void*
diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
index 9a2a481458..28b9c43022 100644
--- a/app/test/test_ring_perf.c
+++ b/app/test/test_ring_perf.c
@@ -86,8 +86,8 @@ get_two_hyperthreads(struct lcore_pair *lcp)
 
 			c1 = rte_lcore_to_cpu_id(id1);
 			c2 = rte_lcore_to_cpu_id(id2);
-			s1 = rte_lcore_to_socket_id(id1);
-			s2 = rte_lcore_to_socket_id(id2);
+			s1 = rte_lcore_to_numa_id(id1);
+			s2 = rte_lcore_to_numa_id(id2);
 			if ((c1 == c2) && (s1 == s2)){
 				lcp->c1 = id1;
 				lcp->c2 = id2;
@@ -110,8 +110,8 @@ get_two_cores(struct lcore_pair *lcp)
 
 			c1 = rte_lcore_to_cpu_id(id1);
 			c2 = rte_lcore_to_cpu_id(id2);
-			s1 = rte_lcore_to_socket_id(id1);
-			s2 = rte_lcore_to_socket_id(id2);
+			s1 = rte_lcore_to_numa_id(id1);
+			s2 = rte_lcore_to_numa_id(id2);
 			if ((c1 != c2) && (s1 == s2)){
 				lcp->c1 = id1;
 				lcp->c2 = id2;
@@ -131,8 +131,8 @@ get_two_sockets(struct lcore_pair *lcp)
 		RTE_LCORE_FOREACH(id2) {
 			if (id1 == id2)
 				continue;
-			s1 = rte_lcore_to_socket_id(id1);
-			s2 = rte_lcore_to_socket_id(id2);
+			s1 = rte_lcore_to_numa_id(id1);
+			s2 = rte_lcore_to_numa_id(id2);
 			if (s1 != s2){
 				lcp->c1 = id1;
 				lcp->c2 = id2;
@@ -509,7 +509,7 @@ test_ring_perf_esize(const int esize)
 	 * Performance test for legacy/_elem APIs
 	 * SP-SC/MP-MC, single
 	 */
-	r = test_ring_create(RING_NAME, esize, RING_SIZE, rte_socket_id(), 0);
+	r = test_ring_create(RING_NAME, esize, RING_SIZE, rte_numa_id(), 0);
 	if (r == NULL)
 		goto test_fail;
 
@@ -587,7 +587,7 @@ test_ring_perf_compression(void)
 
 	ring_params.r = rte_ring_create_elem(
 			RING_NAME, sizeof(void *),
-			RING_SIZE, rte_socket_id(),
+			RING_SIZE, rte_numa_id(),
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 
 	if (ring_params.r == NULL)
@@ -610,7 +610,7 @@ test_ring_perf_compression(void)
 	 */
 	ring_params.r = rte_ring_create_elem(
 			RING_NAME, sizeof(uint32_t),
-			RING_SIZE / 2, rte_socket_id(),
+			RING_SIZE / 2, rte_numa_id(),
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 
 	if (ring_params.r == NULL)
@@ -633,7 +633,7 @@ test_ring_perf_compression(void)
 
 	ring_params.r = rte_ring_create_elem(
 			RING_NAME, sizeof(uint32_t),
-			RING_SIZE, rte_socket_id(),
+			RING_SIZE, rte_numa_id(),
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 
 	if (ring_params.r == NULL)
diff --git a/app/test/test_security.c b/app/test/test_security.c
index be8427b28d..bb6ba5370d 100644
--- a/app/test/test_security.c
+++ b/app/test/test_security.c
@@ -506,7 +506,7 @@ testsuite_setup(void)
 			SECURITY_TEST_MEMPOOL_SIZE,
 			SECURITY_TEST_SESSION_OBJ_SZ,
 			0, 0, NULL, NULL, NULL, NULL,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	TEST_ASSERT_NOT_NULL(ts_params->session_mpool,
 			"Cannot create mempool %s\n", rte_strerror(rte_errno));
 
diff --git a/app/test/test_security_inline_macsec.c b/app/test/test_security_inline_macsec.c
index a929ff5326..5f1df06bbd 100644
--- a/app/test/test_security_inline_macsec.c
+++ b/app/test/test_security_inline_macsec.c
@@ -145,7 +145,7 @@ init_mempools(unsigned int nb_mbuf)
 		snprintf(s, sizeof(s), "mbuf_pool");
 		mbufpool = rte_pktmbuf_pool_create(s, nb_mbuf,
 				MEMPOOL_CACHE_SIZE, 0,
-				RTE_MBUF_DEFAULT_BUF_SIZE, SOCKET_ID_ANY);
+				RTE_MBUF_DEFAULT_BUF_SIZE, RTE_NUMA_ID_ANY);
 		if (mbufpool == NULL) {
 			printf("Cannot init mbuf pool\n");
 			return TEST_FAILED;
@@ -164,7 +164,7 @@ init_mempools(unsigned int nb_mbuf)
 		sess_pool = rte_mempool_create(s, nb_sess, sess_sz,
 				MEMPOOL_CACHE_SIZE, 0,
 				NULL, NULL, NULL, NULL,
-				SOCKET_ID_ANY, 0);
+				RTE_NUMA_ID_ANY, 0);
 		if (sess_pool == NULL) {
 			printf("Cannot init sess pool\n");
 			return TEST_FAILED;
@@ -2434,14 +2434,14 @@ inline_macsec_testsuite_setup(void)
 
 	/* tx queue setup */
 	ret = rte_eth_tx_queue_setup(port_id, 0, nb_txd,
-				     SOCKET_ID_ANY, &tx_conf);
+				     RTE_NUMA_ID_ANY, &tx_conf);
 	if (ret < 0) {
 		printf("rte_eth_tx_queue_setup: err=%d, port=%d\n",
 				ret, port_id);
 		return ret;
 	}
 	/* rx queue steup */
-	ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd, SOCKET_ID_ANY,
+	ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd, RTE_NUMA_ID_ANY,
 				     &rx_conf, mbufpool);
 	if (ret < 0) {
 		printf("rte_eth_rx_queue_setup: err=%d, port=%d\n",
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 0b1f7fbbab..07c6c62715 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -512,7 +512,7 @@ init_mempools(unsigned int nb_mbuf)
 		snprintf(s, sizeof(s), "mbuf_pool");
 		mbufpool = rte_pktmbuf_pool_create(s, nb_mbuf,
 				MEMPOOL_CACHE_SIZE, RTE_CACHE_LINE_SIZE,
-				RTE_MBUF_DEFAULT_BUF_SIZE, SOCKET_ID_ANY);
+				RTE_MBUF_DEFAULT_BUF_SIZE, RTE_NUMA_ID_ANY);
 		if (mbufpool == NULL) {
 			printf("Cannot init mbuf pool\n");
 			return TEST_FAILED;
@@ -531,7 +531,7 @@ init_mempools(unsigned int nb_mbuf)
 		sess_pool = rte_mempool_create(s, nb_sess, sess_sz,
 				MEMPOOL_CACHE_SIZE, 0,
 				NULL, NULL, NULL, NULL,
-				SOCKET_ID_ANY, 0);
+				RTE_NUMA_ID_ANY, 0);
 		if (sess_pool == NULL) {
 			printf("Cannot init sess pool\n");
 			return TEST_FAILED;
@@ -2119,14 +2119,14 @@ inline_ipsec_testsuite_setup(void)
 
 	/* tx queue setup */
 	ret = rte_eth_tx_queue_setup(port_id, 0, nb_txd,
-				     SOCKET_ID_ANY, &tx_conf);
+				     RTE_NUMA_ID_ANY, &tx_conf);
 	if (ret < 0) {
 		printf("rte_eth_tx_queue_setup: err=%d, port=%d\n",
 				ret, port_id);
 		return ret;
 	}
 	/* rx queue steup */
-	ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd, SOCKET_ID_ANY,
+	ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd, RTE_NUMA_ID_ANY,
 				     &rx_conf, mbufpool);
 	if (ret < 0) {
 		printf("rte_eth_rx_queue_setup: err=%d, port=%d\n",
@@ -2268,7 +2268,7 @@ event_inline_ipsec_testsuite_setup(void)
 
 	/* Tx queue setup */
 	ret = rte_eth_tx_queue_setup(port_id, 0, nb_txd,
-				     SOCKET_ID_ANY, &tx_conf);
+				     RTE_NUMA_ID_ANY, &tx_conf);
 	if (ret < 0) {
 		printf("rte_eth_tx_queue_setup: err=%d, port=%d\n",
 				ret, port_id);
@@ -2276,7 +2276,7 @@ event_inline_ipsec_testsuite_setup(void)
 	}
 
 	/* rx queue steup */
-	ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd, SOCKET_ID_ANY,
+	ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd, RTE_NUMA_ID_ANY,
 				     &rx_conf, mbufpool);
 	if (ret < 0) {
 		printf("rte_eth_rx_queue_setup: err=%d, port=%d\n",
diff --git a/app/test/test_stack.c b/app/test/test_stack.c
index a3150c1673..4fbf2185ca 100644
--- a/app/test/test_stack.c
+++ b/app/test/test_stack.c
@@ -322,7 +322,7 @@ test_stack_basic(uint32_t flags)
 	for (i = 0; i < STACK_SIZE; i++)
 		obj_table[i] = (void *)(uintptr_t)i;
 
-	s = rte_stack_create(__func__, STACK_SIZE, rte_socket_id(), flags);
+	s = rte_stack_create(__func__, STACK_SIZE, rte_numa_id(), flags);
 	if (s == NULL) {
 		printf("[%s():%u] failed to create a stack\n",
 		       __func__, __LINE__);
@@ -421,14 +421,14 @@ test_stack_name_reuse(uint32_t flags)
 {
 	struct rte_stack *s[2];
 
-	s[0] = rte_stack_create("test", STACK_SIZE, rte_socket_id(), flags);
+	s[0] = rte_stack_create("test", STACK_SIZE, rte_numa_id(), flags);
 	if (s[0] == NULL) {
 		printf("[%s():%u] Failed to create a stack\n",
 		       __func__, __LINE__);
 		return -1;
 	}
 
-	s[1] = rte_stack_create("test", STACK_SIZE, rte_socket_id(), flags);
+	s[1] = rte_stack_create("test", STACK_SIZE, rte_numa_id(), flags);
 	if (s[1] != NULL) {
 		printf("[%s():%u] Failed to detect re-used name\n",
 		       __func__, __LINE__);
@@ -449,7 +449,7 @@ test_stack_name_length(uint32_t flags)
 	memset(name, 's', sizeof(name));
 	name[RTE_STACK_NAMESIZE] = '\0';
 
-	s = rte_stack_create(name, STACK_SIZE, rte_socket_id(), flags);
+	s = rte_stack_create(name, STACK_SIZE, rte_numa_id(), flags);
 	if (s != NULL) {
 		printf("[%s():%u] Failed to prevent long name\n",
 		       __func__, __LINE__);
@@ -562,7 +562,7 @@ test_stack_multithreaded(uint32_t flags)
 	printf("[%s():%u] Running with %u lcores\n",
 	       __func__, __LINE__, rte_lcore_count());
 
-	s = rte_stack_create("test", MAX_BULK * rte_lcore_count(), rte_socket_id(), flags);
+	s = rte_stack_create("test", MAX_BULK * rte_lcore_count(), rte_numa_id(), flags);
 	if (s == NULL) {
 		printf("[%s():%u] Failed to create a stack\n",
 		       __func__, __LINE__);
diff --git a/app/test/test_stack_perf.c b/app/test/test_stack_perf.c
index e46251d687..d5433e904a 100644
--- a/app/test/test_stack_perf.c
+++ b/app/test/test_stack_perf.c
@@ -43,8 +43,8 @@ get_two_hyperthreads(struct lcore_pair *lcp)
 				continue;
 			core[0] = rte_lcore_to_cpu_id(id[0]);
 			core[1] = rte_lcore_to_cpu_id(id[1]);
-			socket[0] = rte_lcore_to_socket_id(id[0]);
-			socket[1] = rte_lcore_to_socket_id(id[1]);
+			socket[0] = rte_lcore_to_numa_id(id[0]);
+			socket[1] = rte_lcore_to_numa_id(id[1]);
 			if ((core[0] == core[1]) && (socket[0] == socket[1])) {
 				lcp->c1 = id[0];
 				lcp->c2 = id[1];
@@ -69,8 +69,8 @@ get_two_cores(struct lcore_pair *lcp)
 				continue;
 			core[0] = rte_lcore_to_cpu_id(id[0]);
 			core[1] = rte_lcore_to_cpu_id(id[1]);
-			socket[0] = rte_lcore_to_socket_id(id[0]);
-			socket[1] = rte_lcore_to_socket_id(id[1]);
+			socket[0] = rte_lcore_to_numa_id(id[0]);
+			socket[1] = rte_lcore_to_numa_id(id[1]);
 			if ((core[0] != core[1]) && (socket[0] == socket[1])) {
 				lcp->c1 = id[0];
 				lcp->c2 = id[1];
@@ -92,8 +92,8 @@ get_two_sockets(struct lcore_pair *lcp)
 		RTE_LCORE_FOREACH(id[1]) {
 			if (id[0] == id[1])
 				continue;
-			socket[0] = rte_lcore_to_socket_id(id[0]);
-			socket[1] = rte_lcore_to_socket_id(id[1]);
+			socket[0] = rte_lcore_to_numa_id(id[0]);
+			socket[1] = rte_lcore_to_numa_id(id[1]);
 			if (socket[0] != socket[1]) {
 				lcp->c1 = id[0];
 				lcp->c2 = id[1];
@@ -302,7 +302,7 @@ __test_stack_perf(uint32_t flags)
 
 	rte_atomic_store_explicit(&lcore_barrier, 0, rte_memory_order_relaxed);
 
-	s = rte_stack_create(STACK_NAME, STACK_SIZE, rte_socket_id(), flags);
+	s = rte_stack_create(STACK_NAME, STACK_SIZE, rte_numa_id(), flags);
 	if (s == NULL) {
 		printf("[%s():%u] failed to create a stack\n",
 		       __func__, __LINE__);
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 774751c0f5..871fbcd0f5 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -141,7 +141,7 @@ test_timer_secondary(void)
 
 	if (proc_type == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve(TEST_INFO_MZ_NAME, sizeof(*test_info),
-					 SOCKET_ID_ANY, 0);
+					 RTE_NUMA_ID_ANY, 0);
 		TEST_ASSERT_NOT_NULL(mz, "Couldn't allocate memory for "
 				     "test data");
 		test_info = mz->addr;
@@ -150,7 +150,7 @@ test_timer_secondary(void)
 
 		test_info->tim_mempool = rte_mempool_create("test_timer_mp",
 				test_info->num_timers, sizeof(struct rte_timer), 0, 0,
-				NULL, NULL, NULL, NULL, rte_socket_id(), 0);
+				NULL, NULL, NULL, NULL, rte_numa_id(), 0);
 
 		ret = rte_timer_data_alloc(&test_info->timer_data_id);
 		TEST_ASSERT_SUCCESS(ret, "Failed to allocate timer data "
diff --git a/app/test/virtual_pmd.c b/app/test/virtual_pmd.c
index 74bb3516ab..f0b6ce8187 100644
--- a/app/test/virtual_pmd.c
+++ b/app/test/virtual_pmd.c
@@ -104,14 +104,14 @@ virtual_ethdev_info_get(struct rte_eth_dev *dev __rte_unused,
 static int
 virtual_ethdev_rx_queue_setup_success(struct rte_eth_dev *dev,
 		uint16_t rx_queue_id, uint16_t nb_rx_desc __rte_unused,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_rxconf *rx_conf __rte_unused,
 		struct rte_mempool *mb_pool __rte_unused)
 {
 	struct virtual_ethdev_queue *rx_q;
 
-	rx_q = (struct virtual_ethdev_queue *)rte_zmalloc_socket(NULL,
-			sizeof(struct virtual_ethdev_queue), 0, socket_id);
+	rx_q = (struct virtual_ethdev_queue *)rte_zmalloc_numa(NULL,
+			sizeof(struct virtual_ethdev_queue), 0, numa_id);
 
 	if (rx_q == NULL)
 		return -1;
@@ -127,7 +127,7 @@ virtual_ethdev_rx_queue_setup_success(struct rte_eth_dev *dev,
 static int
 virtual_ethdev_rx_queue_setup_fail(struct rte_eth_dev *dev __rte_unused,
 		uint16_t rx_queue_id __rte_unused, uint16_t nb_rx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int numa_id __rte_unused,
 		const struct rte_eth_rxconf *rx_conf __rte_unused,
 		struct rte_mempool *mb_pool __rte_unused)
 {
@@ -137,13 +137,13 @@ virtual_ethdev_rx_queue_setup_fail(struct rte_eth_dev *dev __rte_unused,
 static int
 virtual_ethdev_tx_queue_setup_success(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id, uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id,
+		unsigned int numa_id,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct virtual_ethdev_queue *tx_q;
 
-	tx_q = (struct virtual_ethdev_queue *)rte_zmalloc_socket(NULL,
-			sizeof(struct virtual_ethdev_queue), 0, socket_id);
+	tx_q = (struct virtual_ethdev_queue *)rte_zmalloc_numa(NULL,
+			sizeof(struct virtual_ethdev_queue), 0, numa_id);
 
 	if (tx_q == NULL)
 		return -1;
@@ -159,7 +159,7 @@ virtual_ethdev_tx_queue_setup_success(struct rte_eth_dev *dev,
 static int
 virtual_ethdev_tx_queue_setup_fail(struct rte_eth_dev *dev __rte_unused,
 		uint16_t tx_queue_id __rte_unused, uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int numa_id __rte_unused,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	return -1;
@@ -504,7 +504,7 @@ virtual_ethdev_get_mbufs_from_tx_queue(uint16_t port_id,
 
 int
 virtual_ethdev_create(const char *name, struct rte_ether_addr *mac_addr,
-		uint8_t socket_id, uint8_t isr_support)
+		uint8_t numa_id, uint8_t isr_support)
 {
 	struct rte_pci_device *pci_dev = NULL;
 	struct rte_eth_dev *eth_dev = NULL;
@@ -518,31 +518,31 @@ virtual_ethdev_create(const char *name, struct rte_ether_addr *mac_addr,
 	 * and internal (dev_private) data
 	 */
 
-	pci_dev = rte_zmalloc_socket(name, sizeof(*pci_dev), 0, socket_id);
+	pci_dev = rte_zmalloc_numa(name, sizeof(*pci_dev), 0, numa_id);
 	if (pci_dev == NULL)
 		goto err;
 
-	pci_drv = rte_zmalloc_socket(name, sizeof(*pci_drv), 0, socket_id);
+	pci_drv = rte_zmalloc_numa(name, sizeof(*pci_drv), 0, numa_id);
 	if (pci_drv == NULL)
 		goto err;
 
-	id_table = rte_zmalloc_socket(name, sizeof(*id_table), 0, socket_id);
+	id_table = rte_zmalloc_numa(name, sizeof(*id_table), 0, numa_id);
 	if (id_table == NULL)
 		goto err;
 	id_table->device_id = 0xBEEF;
 
-	dev_private = rte_zmalloc_socket(name, sizeof(*dev_private), 0, socket_id);
+	dev_private = rte_zmalloc_numa(name, sizeof(*dev_private), 0, numa_id);
 	if (dev_private == NULL)
 		goto err;
 
 	snprintf(name_buf, sizeof(name_buf), "%s_rxQ", name);
-	dev_private->rx_queue = rte_ring_create(name_buf, MAX_PKT_BURST, socket_id,
+	dev_private->rx_queue = rte_ring_create(name_buf, MAX_PKT_BURST, numa_id,
 			0);
 	if (dev_private->rx_queue == NULL)
 		goto err;
 
 	snprintf(name_buf, sizeof(name_buf), "%s_txQ", name);
-	dev_private->tx_queue = rte_ring_create(name_buf, MAX_PKT_BURST, socket_id,
+	dev_private->tx_queue = rte_ring_create(name_buf, MAX_PKT_BURST, numa_id,
 			0);
 	if (dev_private->tx_queue == NULL)
 		goto err;
@@ -552,7 +552,7 @@ virtual_ethdev_create(const char *name, struct rte_ether_addr *mac_addr,
 	if (eth_dev == NULL)
 		goto err;
 
-	pci_dev->device.numa_node = socket_id;
+	pci_dev->device.numa_node = numa_id;
 	pci_dev->device.name = eth_dev->data->name;
 	pci_drv->driver.name = virtual_ethdev_driver_name;
 	pci_drv->id_table = id_table;
diff --git a/app/test/virtual_pmd.h b/app/test/virtual_pmd.h
index a5a71d7cb4..4032fd91a7 100644
--- a/app/test/virtual_pmd.h
+++ b/app/test/virtual_pmd.h
@@ -16,7 +16,7 @@ virtual_ethdev_init(void);
 
 int
 virtual_ethdev_create(const char *name, struct rte_ether_addr *mac_addr,
-		uint8_t socket_id, uint8_t isr_support);
+		uint8_t numa_id, uint8_t isr_support);
 
 void
 virtual_ethdev_set_link_status(uint16_t port_id, uint8_t link_status);
-- 
2.55.0


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A4606B272
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Im1uwomJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C71943262;
	Tue,  3 Nov 2026 16:23:42 +0100 (CET)
Received: from mta1.migadu.com (out-92.mta1.migadu.com [95.215.58.92])
 by mails.dpdk.org (Postfix) with ESMTPS id B4D0B43252
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:23:40 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=0VJ8KUMeWUh+kfJqMTHBgZqBYqNNBS0ts5XCgH8tBU4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719420; v=1; x=1794324220;
 b=Im1uwomJMILP53mRBFbpJf7QhlbPLyQh2m6R1U0/kv0rMtG18FL2x9sMVFQ8d1UStBZUr0Lw
 b0mtd23vYWpWFDAJDzTh+Z66vxYbTPmR0ihiXari7RHSDnv7SxeMAEJRRn/BIWE+T5Ok7YKnEPW
 0fooV+ChMgSGmVydWILZdPIM=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 7b91cc0c39450e4c;
 Tue, 03 Nov 2026 15:23:40 +0000
X-Mizu-Trace-ID: 7b91cc0c39450e4c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 194/227] examples/ipsec-secgw: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:32 +0800
Message-ID: <20261103145306.487255-195-chengwen.feng@linux.dev>
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
 examples/ipsec-secgw/event_helper.c |  14 +--
 examples/ipsec-secgw/ipsec-secgw.c  | 132 ++++++++++++++--------------
 examples/ipsec-secgw/ipsec.h        |   8 +-
 examples/ipsec-secgw/ipsec_worker.c |  56 ++++++------
 examples/ipsec-secgw/rt.c           |  22 ++---
 examples/ipsec-secgw/sa.c           |  30 +++----
 examples/ipsec-secgw/sad.c          |  12 +--
 examples/ipsec-secgw/sad.h          |   2 +-
 examples/ipsec-secgw/sp4.c          |  12 +--
 examples/ipsec-secgw/sp6.c          |  12 +--
 10 files changed, 150 insertions(+), 150 deletions(-)

diff --git a/examples/ipsec-secgw/event_helper.c b/examples/ipsec-secgw/event_helper.c
index fc9fa1b000..a1c3e29787 100644
--- a/examples/ipsec-secgw/event_helper.c
+++ b/examples/ipsec-secgw/event_helper.c
@@ -806,7 +806,7 @@ eh_initialize_crypto_adapter(struct eventmode_conf *em_conf)
 	const uint8_t nb_qp_per_cdev = 1;
 	uint8_t eventdev_id, cdev_id, n;
 	uint32_t cap, nb_elem;
-	int ret, socket_id;
+	int ret, numa_id;
 
 	if (!em_conf->enable_event_crypto_adapter)
 		return 0;
@@ -874,12 +874,12 @@ eh_initialize_crypto_adapter(struct eventmode_conf *em_conf)
 			 */
 			nb_elem = (qp_desc_nb / queue_conf.vector_sz) + 1;
 			nb_elem *= nb_qp_per_cdev;
-			socket_id = rte_cryptodev_socket_id(cdev_id);
+			numa_id = rte_cryptodev_numa_id(cdev_id);
 			snprintf(mp_name, RTE_MEMPOOL_NAMESIZE,
-					"QP_VEC_%u_%u", socket_id, cdev_id);
+					"QP_VEC_%u_%u", numa_id, cdev_id);
 			queue_conf.vector_mp = rte_event_vector_pool_create(
 					mp_name, nb_elem, 0,
-					queue_conf.vector_sz, socket_id);
+					queue_conf.vector_sz, numa_id);
 			if (queue_conf.vector_mp == NULL) {
 				EH_LOG_ERR("failed to create event vector pool");
 				return -ENOMEM;
@@ -990,7 +990,7 @@ eh_rx_adapter_configure(struct eventmode_conf *em_conf,
 	struct rte_event_dev_info evdev_default_conf = {0};
 	struct rte_event_port_conf port_conf = {0};
 	struct rx_adapter_connection_info *conn;
-	uint32_t service_id, socket_id, nb_elem;
+	uint32_t service_id, numa_id, nb_elem;
 	struct rte_mempool *vector_pool = NULL;
 	uint32_t lcore_id = rte_lcore_id();
 	int ret, portid, nb_ports = 0;
@@ -1012,7 +1012,7 @@ eh_rx_adapter_configure(struct eventmode_conf *em_conf,
 			nb_ports++;
 
 	if (em_conf->ext_params.event_vector) {
-		socket_id = rte_lcore_to_socket_id(lcore_id);
+		numa_id = rte_lcore_to_numa_id(lcore_id);
 
 		if (em_conf->vector_pool_sz) {
 			nb_elem = em_conf->vector_pool_sz;
@@ -1026,7 +1026,7 @@ eh_rx_adapter_configure(struct eventmode_conf *em_conf,
 		nb_elem += rte_lcore_count() * 32;
 		vector_pool = rte_event_vector_pool_create(
 			"vector_pool", nb_elem, 32,
-			em_conf->ext_params.vector_size, socket_id);
+			em_conf->ext_params.vector_size, numa_id);
 		if (vector_pool == NULL) {
 			EH_LOG_ERR("failed to create event vector pool");
 			return -ENOMEM;
diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index 2741faf04e..e0fc6fb77e 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -251,7 +251,7 @@ static struct rte_eth_conf port_conf = {
 	},
 };
 
-struct socket_ctx socket_ctx[NB_SOCKETS];
+struct socket_ctx socket_ctx[NB_NUMAS];
 
 bool per_port_pool;
 
@@ -699,7 +699,7 @@ ipsec_poll_mode_worker(void)
 	uint64_t prev_tsc, diff_tsc, cur_tsc;
 	uint16_t i, nb_rx, portid, queueid;
 	struct lcore_conf *qconf;
-	int32_t rc, socket_id;
+	int32_t rc, numa_id;
 	const uint64_t drain_tsc = (rte_get_tsc_hz() + US_PER_S - 1)
 			/ US_PER_S * BURST_TX_DRAIN_US;
 	struct lcore_rx_queue *rxql;
@@ -708,21 +708,21 @@ ipsec_poll_mode_worker(void)
 	lcore_id = rte_lcore_id();
 	qconf = &lcore_conf[lcore_id];
 	rxql = qconf->rx_queue_list;
-	socket_id = rte_lcore_to_socket_id(lcore_id);
+	numa_id = rte_lcore_to_numa_id(lcore_id);
 
-	qconf->rt4_ctx = socket_ctx[socket_id].rt_ip4;
-	qconf->rt6_ctx = socket_ctx[socket_id].rt_ip6;
-	qconf->inbound.sp4_ctx = socket_ctx[socket_id].sp_ip4_in;
-	qconf->inbound.sp6_ctx = socket_ctx[socket_id].sp_ip6_in;
-	qconf->inbound.sa_ctx = socket_ctx[socket_id].sa_in;
+	qconf->rt4_ctx = socket_ctx[numa_id].rt_ip4;
+	qconf->rt6_ctx = socket_ctx[numa_id].rt_ip6;
+	qconf->inbound.sp4_ctx = socket_ctx[numa_id].sp_ip4_in;
+	qconf->inbound.sp6_ctx = socket_ctx[numa_id].sp_ip6_in;
+	qconf->inbound.sa_ctx = socket_ctx[numa_id].sa_in;
 	qconf->inbound.cdev_map = cdev_map_in;
 	qconf->inbound.lcore_id = lcore_id;
-	qconf->outbound.sp4_ctx = socket_ctx[socket_id].sp_ip4_out;
-	qconf->outbound.sp6_ctx = socket_ctx[socket_id].sp_ip6_out;
-	qconf->outbound.sa_ctx = socket_ctx[socket_id].sa_out;
+	qconf->outbound.sp4_ctx = socket_ctx[numa_id].sp_ip4_out;
+	qconf->outbound.sp6_ctx = socket_ctx[numa_id].sp_ip6_out;
+	qconf->outbound.sa_ctx = socket_ctx[numa_id].sa_out;
 	qconf->outbound.cdev_map = cdev_map_out;
 	qconf->outbound.lcore_id = lcore_id;
-	qconf->frag.pool_indir = socket_ctx[socket_id].mbuf_pool_indir;
+	qconf->frag.pool_indir = socket_ctx[numa_id].mbuf_pool_indir;
 
 	rc = ipsec_sad_lcore_cache_init(app_sa_prm.cache_sz);
 	if (rc != 0) {
@@ -812,7 +812,7 @@ check_poll_mode_params(struct eh_conf *eh_conf)
 	uint32_t lcore;
 	uint16_t portid;
 	uint16_t i;
-	int32_t socket_id;
+	int32_t numa_id;
 
 	if (!eh_conf)
 		return -EINVAL;
@@ -832,11 +832,11 @@ check_poll_mode_params(struct eh_conf *eh_conf)
 				"lcore mask\n", lcore);
 			return -1;
 		}
-		socket_id = rte_lcore_to_socket_id(lcore);
-		if (socket_id != 0 && numa_on == 0) {
+		numa_id = rte_lcore_to_numa_id(lcore);
+		if (numa_id != 0 && numa_on == 0) {
 			printf("warning: lcore %u is on socket %d "
 				"with numa off\n",
-				lcore, socket_id);
+				lcore, numa_id);
 		}
 		portid = lcore_params[i].port_id;
 		if ((enabled_port_mask & (1 << portid)) == 0) {
@@ -1701,7 +1701,7 @@ cryptodevs_init(enum eh_pkt_transfer_mode mode)
 	params.key_len = sizeof(struct cdev_key);
 	params.hash_func = rte_jhash;
 	params.hash_func_init_val = 0;
-	params.socket_id = rte_socket_id();
+	params.numa_id = rte_numa_id();
 
 	params.name = "cdev_map_in";
 	cdev_map_in = rte_hash_create(&params);
@@ -1739,10 +1739,10 @@ cryptodevs_init(enum eh_pkt_transfer_mode mode)
 			continue;
 
 		total_nb_qps += qp;
-		dev_conf.socket_id = rte_cryptodev_socket_id(cdev_id);
-		/* Use the first socket if SOCKET_ID_ANY is returned. */
-		if (dev_conf.socket_id == SOCKET_ID_ANY)
-			dev_conf.socket_id = 0;
+		dev_conf.numa_id = rte_cryptodev_numa_id(cdev_id);
+		/* Use the first socket if RTE_NUMA_ID_ANY is returned. */
+		if (dev_conf.numa_id == RTE_NUMA_ID_ANY)
+			dev_conf.numa_id = 0;
 		dev_conf.nb_queue_pairs = qp;
 		dev_conf.ff_disable = RTE_CRYPTODEV_FF_ASYMMETRIC_CRYPTO;
 
@@ -1759,10 +1759,10 @@ cryptodevs_init(enum eh_pkt_transfer_mode mode)
 
 		qp_conf.nb_descriptors = qp_desc_nb;
 		qp_conf.mp_session =
-			socket_ctx[dev_conf.socket_id].session_pool;
+			socket_ctx[dev_conf.numa_id].session_pool;
 		for (qp = 0; qp < dev_conf.nb_queue_pairs; qp++)
 			if (rte_cryptodev_queue_pair_setup(cdev_id, qp,
-					&qp_conf, dev_conf.socket_id))
+					&qp_conf, dev_conf.numa_id))
 				rte_panic("Failed to setup queue %u for "
 						"cdev_id %u\n",	0, cdev_id);
 
@@ -1926,7 +1926,7 @@ port_init(uint16_t portid, uint64_t req_rx_offloads, uint64_t req_tx_offloads,
 	uint16_t nb_tx_queue, nb_rx_queue;
 	uint16_t tx_queueid, rx_queueid, queue;
 	uint32_t lcore_id;
-	int32_t ret, socket_id;
+	int32_t ret, numa_id;
 	struct lcore_conf *qconf;
 	struct rte_ether_addr ethaddr;
 	struct rte_eth_conf local_port_conf = port_conf;
@@ -2050,18 +2050,18 @@ port_init(uint16_t portid, uint64_t req_rx_offloads, uint64_t req_tx_offloads,
 			continue;
 
 		if (numa_on)
-			socket_id = (uint8_t)rte_lcore_to_socket_id(lcore_id);
+			numa_id = (uint8_t)rte_lcore_to_numa_id(lcore_id);
 		else
-			socket_id = 0;
+			numa_id = 0;
 
 		/* init TX queue */
-		printf("Setup txq=%u,%d,%d\n", lcore_id, tx_queueid, socket_id);
+		printf("Setup txq=%u,%d,%d\n", lcore_id, tx_queueid, numa_id);
 
 		txconf = &dev_info.default_txconf;
 		txconf->offloads = local_port_conf.txmode.offloads;
 
 		ret = rte_eth_tx_queue_setup(portid, tx_queueid, nb_txd,
-				socket_id, txconf);
+				numa_id, txconf);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE, "rte_eth_tx_queue_setup: "
 					"err=%d, port=%d\n", ret, portid);
@@ -2082,18 +2082,18 @@ port_init(uint16_t portid, uint64_t req_rx_offloads, uint64_t req_tx_offloads,
 			rx_queueid = qconf->rx_queue_list[queue].queue_id;
 
 			printf("Setup rxq=%d,%d,%d\n", portid, rx_queueid,
-					socket_id);
+					numa_id);
 
 			rxq_conf = dev_info.default_rxconf;
 			rxq_conf.offloads = local_port_conf.rxmode.offloads;
 
 			if (per_port_pool)
-				pool = socket_ctx[socket_id].mbuf_pool[portid];
+				pool = socket_ctx[numa_id].mbuf_pool[portid];
 			else
-				pool = socket_ctx[socket_id].mbuf_pool[0];
+				pool = socket_ctx[numa_id].mbuf_pool[0];
 
 			ret = rte_eth_rx_queue_setup(portid, rx_queueid,
-					nb_rxd,	socket_id, &rxq_conf, pool);
+					nb_rxd,	numa_id, &rxq_conf, pool);
 			if (ret < 0)
 				rte_exit(EXIT_FAILURE,
 					"rte_eth_rx_queue_setup: err=%d, "
@@ -2165,32 +2165,32 @@ max_session_size(void)
 }
 
 static void
-session_pool_init(struct socket_ctx *ctx, int32_t socket_id, size_t sess_sz)
+session_pool_init(struct socket_ctx *ctx, int32_t numa_id, size_t sess_sz)
 {
 	char mp_name[RTE_MEMPOOL_NAMESIZE];
 	struct rte_mempool *sess_mp;
 	uint32_t nb_sess;
 
 	snprintf(mp_name, RTE_MEMPOOL_NAMESIZE,
-			"sess_mp_%u", socket_id);
+			"sess_mp_%u", numa_id);
 	nb_sess = (get_nb_crypto_sessions() + CDEV_MP_CACHE_SZ *
 		rte_lcore_count());
 	nb_sess = RTE_MAX(nb_sess, CDEV_MP_CACHE_SZ *
 			CDEV_MP_CACHE_MULTIPLIER);
 	sess_mp = rte_cryptodev_sym_session_pool_create(
 			mp_name, nb_sess, sess_sz, CDEV_MP_CACHE_SZ,
-			0, socket_id);
+			0, numa_id);
 	ctx->session_pool = sess_mp;
 
 	if (ctx->session_pool == NULL)
 		rte_exit(EXIT_FAILURE,
-			"Cannot init session pool on socket %d\n", socket_id);
+			"Cannot init session pool on socket %d\n", numa_id);
 	else
-		printf("Allocated session pool on socket %d\n",	socket_id);
+		printf("Allocated session pool on socket %d\n",	numa_id);
 }
 
 static void
-pool_init(struct socket_ctx *ctx, int32_t socket_id, int portid,
+pool_init(struct socket_ctx *ctx, int32_t numa_id, int portid,
 	  uint32_t nb_mbuf)
 {
 	char s[64];
@@ -2198,15 +2198,15 @@ pool_init(struct socket_ctx *ctx, int32_t socket_id, int portid,
 
 
 	/* mbuf_pool is initialised by the pool_init() function*/
-	if (socket_ctx[socket_id].mbuf_pool[portid])
+	if (socket_ctx[numa_id].mbuf_pool[portid])
 		return;
 
-	snprintf(s, sizeof(s), "mbuf_pool_%d_%d", socket_id, portid);
+	snprintf(s, sizeof(s), "mbuf_pool_%d_%d", numa_id, portid);
 	ctx->mbuf_pool[portid] = rte_pktmbuf_pool_create(s, nb_mbuf,
 							 MEMPOOL_CACHE_SIZE,
 							 ipsec_metadata_size(),
 							 frame_buf_size,
-							 socket_id);
+							 numa_id);
 
 	/*
 	 * if multi-segment support is enabled, then create a pool
@@ -2214,17 +2214,17 @@ pool_init(struct socket_ctx *ctx, int32_t socket_id, int portid,
 	 */
 	ms = multi_seg_required();
 	if (ms != 0 && !ctx->mbuf_pool_indir) {
-		snprintf(s, sizeof(s), "mbuf_pool_indir_%d", socket_id);
+		snprintf(s, sizeof(s), "mbuf_pool_indir_%d", numa_id);
 		ctx->mbuf_pool_indir = rte_pktmbuf_pool_create(s, nb_mbuf,
-			MEMPOOL_CACHE_SIZE, 0, 0, socket_id);
+			MEMPOOL_CACHE_SIZE, 0, 0, numa_id);
 	}
 
 	if (ctx->mbuf_pool[portid] == NULL ||
 	    (ms != 0 && ctx->mbuf_pool_indir == NULL))
 		rte_exit(EXIT_FAILURE, "Cannot init mbuf pool on socket %d\n",
-				socket_id);
+				numa_id);
 	else
-		printf("Allocated mbuf pool on socket %d\n", socket_id);
+		printf("Allocated mbuf pool on socket %d\n", numa_id);
 }
 
 static int
@@ -2357,7 +2357,7 @@ reassemble_lcore_init(struct lcore_conf *lc, uint32_t cid)
 	const struct rte_eth_rxtx_callback *cb;
 
 	/* create fragment table */
-	sid = rte_lcore_to_socket_id(cid);
+	sid = rte_lcore_to_numa_id(cid);
 	frag_cycles = (rte_get_tsc_hz() + NS_PER_S - 1) /
 		NS_PER_S * frag_ttl_ns;
 
@@ -2929,7 +2929,7 @@ main(int32_t argc, char **argv)
 	uint32_t lcore_id, nb_txq, nb_rxq = 0;
 	uint32_t cdev_id;
 	uint32_t i;
-	uint8_t socket_id;
+	uint8_t numa_id;
 	uint16_t portid, nb_crypto_qp, nb_ports = 0;
 	uint64_t req_rx_offloads[RTE_MAX_ETHPORTS];
 	uint64_t req_tx_offloads[RTE_MAX_ETHPORTS];
@@ -3014,27 +3014,27 @@ main(int32_t argc, char **argv)
 			continue;
 
 		if (numa_on)
-			socket_id = (uint8_t)rte_lcore_to_socket_id(lcore_id);
+			numa_id = (uint8_t)rte_lcore_to_numa_id(lcore_id);
 		else
-			socket_id = 0;
+			numa_id = 0;
 
 		if (per_port_pool) {
 			RTE_ETH_FOREACH_DEV(portid) {
 				if ((enabled_port_mask & (1 << portid)) == 0)
 					continue;
 
-				pool_init(&socket_ctx[socket_id], socket_id,
+				pool_init(&socket_ctx[numa_id], numa_id,
 					  portid, nb_bufs_in_pool);
 			}
 		} else {
-			pool_init(&socket_ctx[socket_id], socket_id, 0,
+			pool_init(&socket_ctx[numa_id], numa_id, 0,
 				  nb_bufs_in_pool);
 		}
 
-		if (socket_ctx[socket_id].session_pool)
+		if (socket_ctx[numa_id].session_pool)
 			continue;
 
-		session_pool_init(&socket_ctx[socket_id], socket_id, sess_sz);
+		session_pool_init(&socket_ctx[numa_id], numa_id, sess_sz);
 	}
 	printf("Number of mbufs in packet pool %d\n", nb_bufs_in_pool);
 
@@ -3117,15 +3117,15 @@ main(int32_t argc, char **argv)
 	}
 
 	/* Replicate each context per socket */
-	for (i = 0; i < NB_SOCKETS && i < rte_socket_count(); i++) {
-		socket_id = rte_socket_id_by_idx(i);
-		if ((socket_ctx[socket_id].session_pool != NULL) &&
-			(socket_ctx[socket_id].sa_in == NULL) &&
-			(socket_ctx[socket_id].sa_out == NULL)) {
-			sa_init(&socket_ctx[socket_id], socket_id, eh_conf->mode_params);
-			sp4_init(&socket_ctx[socket_id], socket_id);
-			sp6_init(&socket_ctx[socket_id], socket_id);
-			rt_init(&socket_ctx[socket_id], socket_id);
+	for (i = 0; i < NB_NUMAS && i < rte_numa_count(); i++) {
+		numa_id = rte_numa_id_by_idx(i);
+		if ((socket_ctx[numa_id].session_pool != NULL) &&
+			(socket_ctx[numa_id].sa_in == NULL) &&
+			(socket_ctx[numa_id].sa_out == NULL)) {
+			sa_init(&socket_ctx[numa_id], numa_id, eh_conf->mode_params);
+			sp4_init(&socket_ctx[numa_id], numa_id);
+			sp6_init(&socket_ctx[numa_id], numa_id);
+			rt_init(&socket_ctx[numa_id], numa_id);
 		}
 	}
 
@@ -3170,10 +3170,10 @@ main(int32_t argc, char **argv)
 	eh_conf_uninit(eh_conf);
 
 	/* Destroy inbound and outbound sessions */
-	for (i = 0; i < NB_SOCKETS && i < rte_socket_count(); i++) {
-		socket_id = rte_socket_id_by_idx(i);
-		sessions_free(socket_ctx[socket_id].sa_in);
-		sessions_free(socket_ctx[socket_id].sa_out);
+	for (i = 0; i < NB_NUMAS && i < rte_numa_count(); i++) {
+		numa_id = rte_numa_id_by_idx(i);
+		sessions_free(socket_ctx[numa_id].sa_in);
+		sessions_free(socket_ctx[numa_id].sa_out);
 	}
 
 	for (cdev_id = 0; cdev_id < rte_cryptodev_count(); cdev_id++) {
diff --git a/examples/ipsec-secgw/ipsec.h b/examples/ipsec-secgw/ipsec.h
index 20757eeba1..bdd607fbdd 100644
--- a/examples/ipsec-secgw/ipsec.h
+++ b/examples/ipsec-secgw/ipsec.h
@@ -412,10 +412,10 @@ outbound_sa_lookup(struct sa_ctx *sa_ctx, uint32_t sa_idx[],
 		void *sa[], uint16_t nb_pkts);
 
 void
-sp4_init(struct socket_ctx *ctx, int32_t socket_id);
+sp4_init(struct socket_ctx *ctx, int32_t numa_id);
 
 void
-sp6_init(struct socket_ctx *ctx, int32_t socket_id);
+sp6_init(struct socket_ctx *ctx, int32_t numa_id);
 
 /*
  * Search through SP rules for given SPI.
@@ -438,11 +438,11 @@ int
 sa_spi_present(struct sa_ctx *sa_ctx, uint32_t spi, int inbound);
 
 void
-sa_init(struct socket_ctx *ctx, int32_t socket_id,
+sa_init(struct socket_ctx *ctx, int32_t numa_id,
 	const struct eventmode_conf *em_conf);
 
 void
-rt_init(struct socket_ctx *ctx, int32_t socket_id);
+rt_init(struct socket_ctx *ctx, int32_t numa_id);
 
 int
 sa_check_offloads(uint16_t port_id, uint64_t *rx_offloads,
diff --git a/examples/ipsec-secgw/ipsec_worker.c b/examples/ipsec-secgw/ipsec_worker.c
index 1dd4696e6a..637017ffbc 100644
--- a/examples/ipsec-secgw/ipsec_worker.c
+++ b/examples/ipsec-secgw/ipsec_worker.c
@@ -1199,7 +1199,7 @@ ipsec_wrkr_non_burst_int_port_drv_mode(struct eh_event_link_info *links,
 	struct rte_mbuf *pkt;
 	struct rte_event ev;
 	uint32_t lcore_id;
-	int32_t socket_id;
+	int32_t numa_id;
 	int16_t port_id;
 
 	/* Check if we have links registered for this lcore */
@@ -1214,13 +1214,13 @@ ipsec_wrkr_non_burst_int_port_drv_mode(struct eh_event_link_info *links,
 	lcore_id = rte_lcore_id();
 
 	/* Get socket ID */
-	socket_id = rte_lcore_to_socket_id(lcore_id);
+	numa_id = rte_lcore_to_numa_id(lcore_id);
 
 	/*
 	 * Prepare security sessions table. In outbound driver mode
 	 * we always use first session configured for a given port
 	 */
-	prepare_out_sessions_tbl(socket_ctx[socket_id].sa_out, data,
+	prepare_out_sessions_tbl(socket_ctx[numa_id].sa_out, data,
 				 RTE_MAX_ETHPORTS);
 
 	RTE_LOG(INFO, IPSEC,
@@ -1324,7 +1324,7 @@ ipsec_wrkr_non_burst_int_port_app_mode(struct eh_event_link_info *links,
 	unsigned int nb_rx = 0, nb_tx;
 	struct rte_event ev;
 	uint32_t lcore_id;
-	int32_t socket_id;
+	int32_t numa_id;
 	int ret;
 
 	/* Check if we have links registered for this lcore */
@@ -1339,18 +1339,18 @@ ipsec_wrkr_non_burst_int_port_app_mode(struct eh_event_link_info *links,
 	lcore_id = rte_lcore_id();
 
 	/* Get socket ID */
-	socket_id = rte_lcore_to_socket_id(lcore_id);
+	numa_id = rte_lcore_to_numa_id(lcore_id);
 
 	/* Save routing table */
-	lconf.rt.rt4_ctx = socket_ctx[socket_id].rt_ip4;
-	lconf.rt.rt6_ctx = socket_ctx[socket_id].rt_ip6;
-	lconf.inbound.sp4_ctx = socket_ctx[socket_id].sp_ip4_in;
-	lconf.inbound.sp6_ctx = socket_ctx[socket_id].sp_ip6_in;
-	lconf.inbound.sa_ctx = socket_ctx[socket_id].sa_in;
+	lconf.rt.rt4_ctx = socket_ctx[numa_id].rt_ip4;
+	lconf.rt.rt6_ctx = socket_ctx[numa_id].rt_ip6;
+	lconf.inbound.sp4_ctx = socket_ctx[numa_id].sp_ip4_in;
+	lconf.inbound.sp6_ctx = socket_ctx[numa_id].sp_ip6_in;
+	lconf.inbound.sa_ctx = socket_ctx[numa_id].sa_in;
 	lconf.inbound.lcore_id = lcore_id;
-	lconf.outbound.sp4_ctx = socket_ctx[socket_id].sp_ip4_out;
-	lconf.outbound.sp6_ctx = socket_ctx[socket_id].sp_ip6_out;
-	lconf.outbound.sa_ctx = socket_ctx[socket_id].sa_out;
+	lconf.outbound.sp4_ctx = socket_ctx[numa_id].sp_ip4_out;
+	lconf.outbound.sp6_ctx = socket_ctx[numa_id].sp_ip6_out;
+	lconf.outbound.sa_ctx = socket_ctx[numa_id].sa_out;
 	lconf.outbound.ipv4_offloads = tx_offloads.ipv4_offloads;
 	lconf.outbound.ipv6_offloads = tx_offloads.ipv6_offloads;
 	lconf.outbound.lcore_id = lcore_id;
@@ -1604,7 +1604,7 @@ ipsec_poll_mode_wrkr_inl_pr(void)
 	struct ipsec_traffic trf;
 	struct lcore_conf *qconf;
 	uint16_t v4_num, v6_num;
-	int32_t socket_id;
+	int32_t numa_id;
 	uint32_t lcore_id;
 	int32_t i, nb_rx;
 	uint16_t portid, queueid;
@@ -1613,21 +1613,21 @@ ipsec_poll_mode_wrkr_inl_pr(void)
 	lcore_id = rte_lcore_id();
 	qconf = &lcore_conf[lcore_id];
 	rxql = qconf->rx_queue_list;
-	socket_id = rte_lcore_to_socket_id(lcore_id);
+	numa_id = rte_lcore_to_numa_id(lcore_id);
 	stats = &core_statistics[lcore_id];
 
-	rt4_ctx = socket_ctx[socket_id].rt_ip4;
-	rt6_ctx = socket_ctx[socket_id].rt_ip6;
+	rt4_ctx = socket_ctx[numa_id].rt_ip4;
+	rt6_ctx = socket_ctx[numa_id].rt_ip6;
 
-	sp4_in = socket_ctx[socket_id].sp_ip4_in;
-	sp6_in = socket_ctx[socket_id].sp_ip6_in;
-	in_ctx = socket_ctx[socket_id].sa_in;
+	sp4_in = socket_ctx[numa_id].sp_ip4_in;
+	sp6_in = socket_ctx[numa_id].sp_ip6_in;
+	in_ctx = socket_ctx[numa_id].sa_in;
 
-	sp4_out = socket_ctx[socket_id].sp_ip4_out;
-	sp6_out = socket_ctx[socket_id].sp_ip6_out;
-	out_ctx = socket_ctx[socket_id].sa_out;
+	sp4_out = socket_ctx[numa_id].sp_ip4_out;
+	sp6_out = socket_ctx[numa_id].sp_ip6_out;
+	out_ctx = socket_ctx[numa_id].sa_out;
 
-	qconf->frag.pool_indir = socket_ctx[socket_id].mbuf_pool_indir;
+	qconf->frag.pool_indir = socket_ctx[numa_id].mbuf_pool_indir;
 
 	if (qconf->nb_rx_queue == 0) {
 		RTE_LOG(DEBUG, IPSEC, "lcore %u has nothing to do\n",
@@ -1735,7 +1735,7 @@ ipsec_poll_mode_wrkr_inl_pr_ss(void)
 	struct lcore_conf *qconf;
 	struct sa_ctx *out_ctx;
 	uint32_t i, nb_rx, j;
-	int32_t socket_id;
+	int32_t numa_id;
 	uint32_t lcore_id;
 	uint16_t portid, queueid;
 
@@ -1743,10 +1743,10 @@ ipsec_poll_mode_wrkr_inl_pr_ss(void)
 	lcore_id = rte_lcore_id();
 	qconf = &lcore_conf[lcore_id];
 	rxql = qconf->rx_queue_list;
-	socket_id = rte_lcore_to_socket_id(lcore_id);
+	numa_id = rte_lcore_to_numa_id(lcore_id);
 
 	/* Get SA info */
-	out_ctx = socket_ctx[socket_id].sa_out;
+	out_ctx = socket_ctx[numa_id].sa_out;
 	if (out_ctx && single_sa_idx < out_ctx->nb_sa) {
 		sa = &out_ctx->sa[single_sa_idx];
 		ips = ipsec_get_primary_session(sa);
@@ -1757,7 +1757,7 @@ ipsec_poll_mode_wrkr_inl_pr_ss(void)
 			sa_out_proto = IPPROTO_IP;
 	}
 
-	qconf->frag.pool_indir = socket_ctx[socket_id].mbuf_pool_indir;
+	qconf->frag.pool_indir = socket_ctx[numa_id].mbuf_pool_indir;
 
 	if (qconf->nb_rx_queue == 0) {
 		RTE_LOG(DEBUG, IPSEC, "lcore %u has nothing to do\n",
diff --git a/examples/ipsec-secgw/rt.c b/examples/ipsec-secgw/rt.c
index 132e200adb..8a68526acc 100644
--- a/examples/ipsec-secgw/rt.c
+++ b/examples/ipsec-secgw/rt.c
@@ -122,7 +122,7 @@ parse_rt_tokens(char **tokens, uint32_t n_tokens,
 }
 
 void
-rt_init(struct socket_ctx *ctx, int32_t socket_id)
+rt_init(struct socket_ctx *ctx, int32_t numa_id)
 {
 	char name[PATH_MAX];
 	uint32_t i;
@@ -138,11 +138,11 @@ rt_init(struct socket_ctx *ctx, int32_t socket_id)
 
 	if (ctx->rt_ip4 != NULL)
 		rte_exit(EXIT_FAILURE, "IPv4 Routing Table for socket %u "
-			"already initialized\n", socket_id);
+			"already initialized\n", numa_id);
 
 	if (ctx->rt_ip6 != NULL)
 		rte_exit(EXIT_FAILURE, "IPv6 Routing Table for socket %u "
-			"already initialized\n", socket_id);
+			"already initialized\n", numa_id);
 
 	if (nb_rt_ip4 == 0 && nb_rt_ip6 == 0)
 		RTE_LOG(WARNING, IPSEC, "No Routing rule specified\n");
@@ -151,13 +151,13 @@ rt_init(struct socket_ctx *ctx, int32_t socket_id)
 			RT_IPV4_MAX_RULES);
 
 	/* create the LPM table */
-	snprintf(name, sizeof(name), "%s_%u", "rt_ip4", socket_id);
+	snprintf(name, sizeof(name), "%s_%u", "rt_ip4", numa_id);
 	conf.max_rules = RT_IPV4_MAX_RULES;
 	conf.number_tbl8s = RTE_LPM_TBL8_NUM_ENTRIES;
-	lpm = rte_lpm_create(name, socket_id, &conf);
+	lpm = rte_lpm_create(name, numa_id, &conf);
 	if (lpm == NULL)
 		rte_exit(EXIT_FAILURE, "Unable to create %s LPM table "
-			"on socket %d\n", name, socket_id);
+			"on socket %d\n", name, numa_id);
 
 	/* populate the LPM table */
 	for (i = 0; i < nb_rt_ip4; i++) {
@@ -165,7 +165,7 @@ rt_init(struct socket_ctx *ctx, int32_t socket_id)
 			rt_ip4[i].if_out);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE, "Fail to add entry num %u to %s "
-				"LPM table on socket %d\n", i, name, socket_id);
+				"LPM table on socket %d\n", i, name, numa_id);
 
 		uint32_t_to_char(rt_ip4[i].ip, &a, &b, &c, &d);
 		printf("LPM: Adding route %hhu.%hhu.%hhu.%hhu/%hhu (%hhu)\n",
@@ -173,13 +173,13 @@ rt_init(struct socket_ctx *ctx, int32_t socket_id)
 				rt_ip4[i].if_out);
 	}
 
-	snprintf(name, sizeof(name), "%s_%u", "rt_ip6", socket_id);
+	snprintf(name, sizeof(name), "%s_%u", "rt_ip6", numa_id);
 	conf6.max_rules = RT_IPV6_MAX_RULES;
 	conf6.number_tbl8s = RTE_LPM_TBL8_NUM_ENTRIES;
-	lpm6 = rte_lpm6_create(name, socket_id, &conf6);
+	lpm6 = rte_lpm6_create(name, numa_id, &conf6);
 	if (lpm6 == NULL)
 		rte_exit(EXIT_FAILURE, "Unable to create %s LPM table "
-			"on socket %d\n", name, socket_id);
+			"on socket %d\n", name, numa_id);
 
 	/* populate the LPM table */
 	for (i = 0; i < nb_rt_ip6; i++) {
@@ -187,7 +187,7 @@ rt_init(struct socket_ctx *ctx, int32_t socket_id)
 				rt_ip6[i].if_out);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE, "Fail to add entry num %u to %s "
-				"LPM table on socket %d\n", i, name, socket_id);
+				"LPM table on socket %d\n", i, name, numa_id);
 
 		printf("LPM6: Adding route "
 			" %hx:%hx:%hx:%hx:%hx:%hx:%hx:%hx/%hhx (%hhx)\n",
diff --git a/examples/ipsec-secgw/sa.c b/examples/ipsec-secgw/sa.c
index b5068765b6..3c1b5f4023 100644
--- a/examples/ipsec-secgw/sa.c
+++ b/examples/ipsec-secgw/sa.c
@@ -1077,21 +1077,21 @@ print_one_sa_rule(const struct ipsec_sa *sa, int inbound)
 }
 
 static struct sa_ctx *
-sa_create(const char *name, int32_t socket_id, uint32_t nb_sa)
+sa_create(const char *name, int32_t numa_id, uint32_t nb_sa)
 {
 	char s[PATH_MAX];
 	struct sa_ctx *sa_ctx;
 	uint32_t mz_size;
 	const struct rte_memzone *mz;
 
-	snprintf(s, sizeof(s), "%s_%u", name, socket_id);
+	snprintf(s, sizeof(s), "%s_%u", name, numa_id);
 
 	/* Create SA context */
 	printf("Creating SA context with %u maximum entries on socket %d\n",
-			nb_sa, socket_id);
+			nb_sa, numa_id);
 
 	mz_size = sizeof(struct ipsec_xf) * nb_sa;
-	mz = rte_memzone_reserve(s, mz_size, socket_id,
+	mz = rte_memzone_reserve(s, mz_size, numa_id,
 			RTE_MEMZONE_1GB | RTE_MEMZONE_SIZE_HINT_ONLY);
 	if (mz == NULL) {
 		printf("Failed to allocate SA XFORM memory\n");
@@ -1637,7 +1637,7 @@ ipsec_satbl_init(struct sa_ctx *ctx, uint32_t nb_ent, int32_t socket,
 
 	tsz = sz * nb_ent;
 
-	ctx->satbl = rte_zmalloc_socket(NULL, tsz, RTE_CACHE_LINE_SIZE, socket);
+	ctx->satbl = rte_zmalloc_numa(NULL, tsz, RTE_CACHE_LINE_SIZE, socket);
 	if (ctx->satbl == NULL) {
 		RTE_LOG(ERR, IPSEC,
 			"%s(%p, %u, %d): failed to allocate %zu bytes\n",
@@ -1695,7 +1695,7 @@ sa_spi_present(struct sa_ctx *sa_ctx, uint32_t spi, int inbound)
 }
 
 void
-sa_init(struct socket_ctx *ctx, int32_t socket_id,
+sa_init(struct socket_ctx *ctx, int32_t numa_id,
 	const struct eventmode_conf *em_conf)
 {
 	int32_t rc;
@@ -1708,21 +1708,21 @@ sa_init(struct socket_ctx *ctx, int32_t socket_id,
 
 	if (ctx->sa_in != NULL)
 		rte_exit(EXIT_FAILURE, "Inbound SA DB for socket %u already "
-				"initialized\n", socket_id);
+				"initialized\n", numa_id);
 
 	if (ctx->sa_out != NULL)
 		rte_exit(EXIT_FAILURE, "Outbound SA DB for socket %u already "
-				"initialized\n", socket_id);
+				"initialized\n", numa_id);
 
 	if (nb_sa_in > 0) {
 		name = "sa_in";
-		ctx->sa_in = sa_create(name, socket_id, nb_sa_in);
+		ctx->sa_in = sa_create(name, numa_id, nb_sa_in);
 		if (ctx->sa_in == NULL)
 			rte_exit(EXIT_FAILURE, "Error [%d] creating SA "
 				"context %s in socket %d\n", rte_errno,
-				name, socket_id);
+				name, numa_id);
 
-		rc = ipsec_sad_create(name, &ctx->sa_in->sad, socket_id,
+		rc = ipsec_sad_create(name, &ctx->sa_in->sad, numa_id,
 				&sa_in_cnt);
 		if (rc != 0)
 			rte_exit(EXIT_FAILURE, "failed to init SAD\n");
@@ -1732,7 +1732,7 @@ sa_init(struct socket_ctx *ctx, int32_t socket_id,
 
 		if (app_sa_prm.enable != 0) {
 			rc = ipsec_satbl_init(ctx->sa_in, nb_sa_in,
-				socket_id, ctx, ipsec_ctx, em_conf);
+				numa_id, ctx, ipsec_ctx, em_conf);
 			if (rc != 0)
 				rte_exit(EXIT_FAILURE,
 					"failed to init inbound SAs\n");
@@ -1742,11 +1742,11 @@ sa_init(struct socket_ctx *ctx, int32_t socket_id,
 
 	if (nb_sa_out > 0) {
 		name = "sa_out";
-		ctx->sa_out = sa_create(name, socket_id, nb_sa_out);
+		ctx->sa_out = sa_create(name, numa_id, nb_sa_out);
 		if (ctx->sa_out == NULL)
 			rte_exit(EXIT_FAILURE, "Error [%d] creating SA "
 				"context %s in socket %d\n", rte_errno,
-				name, socket_id);
+				name, numa_id);
 
 		RTE_LCORE_FOREACH(lcore_id)
 			ipsec_ctx[lcore_id] = &lcore_conf[lcore_id].outbound;
@@ -1754,7 +1754,7 @@ sa_init(struct socket_ctx *ctx, int32_t socket_id,
 
 		if (app_sa_prm.enable != 0) {
 			rc = ipsec_satbl_init(ctx->sa_out, nb_sa_out,
-				socket_id, ctx, ipsec_ctx, em_conf);
+				numa_id, ctx, ipsec_ctx, em_conf);
 			if (rc != 0)
 				rte_exit(EXIT_FAILURE,
 					"failed to init outbound SAs\n");
diff --git a/examples/ipsec-secgw/sad.c b/examples/ipsec-secgw/sad.c
index 5b2c0e6792..38619e61be 100644
--- a/examples/ipsec-secgw/sad.c
+++ b/examples/ipsec-secgw/sad.c
@@ -89,13 +89,13 @@ ipsec_sad_lcore_cache_init(uint32_t nb_cache_ent)
 	cache_mem_sz = sizeof(struct ipsec_sa *) * cache_elem;
 
 	if (cache_mem_sz != 0) {
-		cache->v4 = rte_zmalloc_socket(NULL, cache_mem_sz,
-			RTE_CACHE_LINE_SIZE, rte_socket_id());
+		cache->v4 = rte_zmalloc_numa(NULL, cache_mem_sz,
+			RTE_CACHE_LINE_SIZE, rte_numa_id());
 		if (cache->v4 == NULL)
 			return -rte_errno;
 
-		cache->v6 = rte_zmalloc_socket(NULL, cache_mem_sz,
-			RTE_CACHE_LINE_SIZE, rte_socket_id());
+		cache->v6 = rte_zmalloc_numa(NULL, cache_mem_sz,
+			RTE_CACHE_LINE_SIZE, rte_numa_id());
 		if (cache->v6 == NULL)
 			return -rte_errno;
 
@@ -107,7 +107,7 @@ ipsec_sad_lcore_cache_init(uint32_t nb_cache_ent)
 
 int
 ipsec_sad_create(const char *name, struct ipsec_sad *sad,
-	int socket_id, struct ipsec_sa_cnt *sa_cnt)
+	int numa_id, struct ipsec_sa_cnt *sa_cnt)
 {
 	int ret;
 	struct rte_ipsec_sad_conf sad_conf;
@@ -120,7 +120,7 @@ ipsec_sad_create(const char *name, struct ipsec_sad *sad,
 	if (ret < 0 || ret >= RTE_IPSEC_SAD_NAMESIZE)
 		return -ENAMETOOLONG;
 
-	sad_conf.socket_id = socket_id;
+	sad_conf.numa_id = numa_id;
 	sad_conf.flags = 0;
 	/* Make SAD have extra 25% of required number of entries */
 	sad_conf.max_sa[RTE_IPSEC_SAD_SPI_ONLY] = sa_cnt->nb_v4 * 5 / 4;
diff --git a/examples/ipsec-secgw/sad.h b/examples/ipsec-secgw/sad.h
index 328729b58c..f53a06139f 100644
--- a/examples/ipsec-secgw/sad.h
+++ b/examples/ipsec-secgw/sad.h
@@ -22,7 +22,7 @@ struct ipsec_sad_cache {
 RTE_DECLARE_PER_LCORE(struct ipsec_sad_cache, sad_cache);
 
 int ipsec_sad_create(const char *name, struct ipsec_sad *sad,
-	int socket_id, struct ipsec_sa_cnt *sa_cnt);
+	int numa_id, struct ipsec_sa_cnt *sa_cnt);
 
 int ipsec_sad_add(struct ipsec_sad *sad, struct ipsec_sa *sa);
 
diff --git a/examples/ipsec-secgw/sp4.c b/examples/ipsec-secgw/sp4.c
index 9c0badd062..6ab4fdb3c7 100644
--- a/examples/ipsec-secgw/sp4.c
+++ b/examples/ipsec-secgw/sp4.c
@@ -488,7 +488,7 @@ acl4_init(const char *name, int32_t socketid, const struct acl4_rules *rules,
 	dump_ip4_rules(rules, rules_nb, 1);
 
 	acl_param.name = s;
-	acl_param.socket_id = socketid;
+	acl_param.numa_id = socketid;
 	acl_param.rule_size = RTE_ACL_RULE_SZ(RTE_DIM(ip4_defs));
 	acl_param.max_rule_num = rules_nb;
 
@@ -552,7 +552,7 @@ check_spi_value(struct sa_ctx *sa_ctx, int inbound)
 }
 
 void
-sp4_init(struct socket_ctx *ctx, int32_t socket_id)
+sp4_init(struct socket_ctx *ctx, int32_t numa_id)
 {
 	const char *name;
 
@@ -561,11 +561,11 @@ sp4_init(struct socket_ctx *ctx, int32_t socket_id)
 
 	if (ctx->sp_ip4_in != NULL)
 		rte_exit(EXIT_FAILURE, "Inbound SP DB for socket %u already "
-				"initialized\n", socket_id);
+				"initialized\n", numa_id);
 
 	if (ctx->sp_ip4_out != NULL)
 		rte_exit(EXIT_FAILURE, "Outbound SP DB for socket %u already "
-				"initialized\n", socket_id);
+				"initialized\n", numa_id);
 
 	if (check_spi_value(ctx->sa_in, 1) < 0)
 		rte_exit(EXIT_FAILURE,
@@ -578,7 +578,7 @@ sp4_init(struct socket_ctx *ctx, int32_t socket_id)
 	if (nb_acl4_rules_in > 0) {
 		name = "sp_ip4_in";
 		ctx->sp_ip4_in = (struct sp_ctx *)acl4_init(name,
-			socket_id, acl4_rules_in, nb_acl4_rules_in);
+			numa_id, acl4_rules_in, nb_acl4_rules_in);
 	} else
 		RTE_LOG(WARNING, IPSEC, "No IPv4 SP Inbound rule "
 			"specified\n");
@@ -586,7 +586,7 @@ sp4_init(struct socket_ctx *ctx, int32_t socket_id)
 	if (nb_acl4_rules_out > 0) {
 		name = "sp_ip4_out";
 		ctx->sp_ip4_out = (struct sp_ctx *)acl4_init(name,
-			socket_id, acl4_rules_out, nb_acl4_rules_out);
+			numa_id, acl4_rules_out, nb_acl4_rules_out);
 	} else
 		RTE_LOG(WARNING, IPSEC, "No IPv4 SP Outbound rule "
 			"specified\n");
diff --git a/examples/ipsec-secgw/sp6.c b/examples/ipsec-secgw/sp6.c
index 8aff843812..90a869bddf 100644
--- a/examples/ipsec-secgw/sp6.c
+++ b/examples/ipsec-secgw/sp6.c
@@ -633,7 +633,7 @@ acl6_init(const char *name, int32_t socketid, const struct acl6_rules *rules,
 	dump_ip6_rules(rules, rules_nb, 1);
 
 	acl_param.name = s;
-	acl_param.socket_id = socketid;
+	acl_param.numa_id = socketid;
 	acl_param.rule_size = RTE_ACL_RULE_SZ(RTE_DIM(ip6_defs));
 	acl_param.max_rule_num = rules_nb;
 
@@ -697,7 +697,7 @@ check_spi_value(struct sa_ctx *sa_ctx, int inbound)
 }
 
 void
-sp6_init(struct socket_ctx *ctx, int32_t socket_id)
+sp6_init(struct socket_ctx *ctx, int32_t numa_id)
 {
 	const char *name;
 
@@ -706,11 +706,11 @@ sp6_init(struct socket_ctx *ctx, int32_t socket_id)
 
 	if (ctx->sp_ip6_in != NULL)
 		rte_exit(EXIT_FAILURE, "Inbound IPv6 SP DB for socket %u "
-				"already initialized\n", socket_id);
+				"already initialized\n", numa_id);
 
 	if (ctx->sp_ip6_out != NULL)
 		rte_exit(EXIT_FAILURE, "Outbound IPv6 SP DB for socket %u "
-				"already initialized\n", socket_id);
+				"already initialized\n", numa_id);
 
 	if (check_spi_value(ctx->sa_in, 1) < 0)
 		rte_exit(EXIT_FAILURE,
@@ -723,7 +723,7 @@ sp6_init(struct socket_ctx *ctx, int32_t socket_id)
 	if (nb_acl6_rules_in > 0) {
 		name = "sp_ip6_in";
 		ctx->sp_ip6_in = (struct sp_ctx *)acl6_init(name,
-			socket_id, acl6_rules_in, nb_acl6_rules_in);
+			numa_id, acl6_rules_in, nb_acl6_rules_in);
 	} else
 		RTE_LOG(WARNING, IPSEC, "No IPv6 SP Inbound rule "
 			"specified\n");
@@ -731,7 +731,7 @@ sp6_init(struct socket_ctx *ctx, int32_t socket_id)
 	if (nb_acl6_rules_out > 0) {
 		name = "sp_ip6_out";
 		ctx->sp_ip6_out = (struct sp_ctx *)acl6_init(name,
-			socket_id, acl6_rules_out, nb_acl6_rules_out);
+			numa_id, acl6_rules_out, nb_acl6_rules_out);
 	} else
 		RTE_LOG(WARNING, IPSEC, "No IPv6 SP Outbound rule "
 			"specified\n");
-- 
2.55.0


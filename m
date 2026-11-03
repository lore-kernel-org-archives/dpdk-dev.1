Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DD606A7A0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LlgehJex
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE8CD42FE7;
	Tue,  3 Nov 2026 16:22:30 +0100 (CET)
Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
 by mails.dpdk.org (Postfix) with ESMTPS id 87A6942FF1
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:22:29 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=m6d3a39iobbNiAa6HWiy/9WJGxGPzSed8YzvYhCf4h0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719349; v=1; x=1794324149;
 b=LlgehJexbgAQDHntLVpIFukYfuUC+vKfR3aNqBgEHFTL8Is03jL7YsZfJCZ4gyOM7pFMm6q5
 6/x4XfDEM48zQ9cOQFRI1JRhpLmHEy4dBFeqEEAG+SxjNO9DMxKtPCKKYM9m6acL4yVz87rrkYz
 HGD43yMyih0o3DDu8CCejGvk=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 448dde78b198ebe6;
 Tue, 03 Nov 2026 15:22:29 +0000
X-Mizu-Trace-ID: 448dde78b198ebe6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 186/227] examples/distributor: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:24 +0800
Message-ID: <20261103145306.487255-187-chengwen.feng@linux.dev>
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
 examples/distributor/main.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/examples/distributor/main.c b/examples/distributor/main.c
index 344da03814..a81e09b6ef 100644
--- a/examples/distributor/main.c
+++ b/examples/distributor/main.c
@@ -156,7 +156,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 
 	for (q = 0; q < rxRings; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
-						rte_eth_dev_socket_id(port),
+						rte_eth_dev_numa_id(port),
 						NULL, mbuf_pool);
 		if (retval < 0)
 			return retval;
@@ -166,7 +166,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	txconf.offloads = port_conf.txmode.offloads;
 	for (q = 0; q < txRings; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, nb_txd,
-						rte_eth_dev_socket_id(port),
+						rte_eth_dev_numa_id(port),
 						&txconf);
 		if (retval < 0)
 			return retval;
@@ -226,7 +226,7 @@ static int
 lcore_rx(struct lcore_params *p)
 {
 	const uint16_t nb_ports = rte_eth_dev_count_avail();
-	const int socket_id = rte_socket_id();
+	const int numa_id = rte_numa_id();
 	uint16_t port;
 	struct rte_mbuf *bufs[BURST_SIZE*2];
 
@@ -235,8 +235,8 @@ lcore_rx(struct lcore_params *p)
 		if ((enabled_port_mask & (1 << port)) == 0)
 			continue;
 
-		if (rte_eth_dev_socket_id(port) >= 0 &&
-				rte_eth_dev_socket_id(port) != socket_id)
+		if (rte_eth_dev_numa_id(port) >= 0 &&
+				rte_eth_dev_numa_id(port) != numa_id)
 			printf("WARNING, port %u is on remote NUMA node to "
 					"RX thread.\n\tPerformance will not "
 					"be optimal.\n", port);
@@ -295,7 +295,7 @@ lcore_rx_and_distributor(struct lcore_params *p)
 {
 	struct rte_distributor *d = p->d;
 	const uint16_t nb_ports = rte_eth_dev_count_avail();
-	const int socket_id = rte_socket_id();
+	const int numa_id = rte_numa_id();
 	uint16_t port;
 	struct rte_mbuf *bufs[BURST_SIZE*2];
 
@@ -304,8 +304,8 @@ lcore_rx_and_distributor(struct lcore_params *p)
 		if ((enabled_port_mask & (1 << port)) == 0)
 			continue;
 
-		if (rte_eth_dev_socket_id(port) > 0 &&
-				rte_eth_dev_socket_id(port) != socket_id)
+		if (rte_eth_dev_numa_id(port) > 0 &&
+				rte_eth_dev_numa_id(port) != numa_id)
 			printf("WARNING, port %u is on remote NUMA node to "
 					"RX thread.\n\tPerformance will not "
 					"be optimal.\n", port);
@@ -465,7 +465,7 @@ static int
 lcore_tx(struct rte_ring *in_r)
 {
 	static struct output_buffer tx_buffers[RTE_MAX_ETHPORTS];
-	const int socket_id = rte_socket_id();
+	const int numa_id = rte_numa_id();
 	uint16_t port;
 
 	RTE_ETH_FOREACH_DEV(port) {
@@ -473,8 +473,8 @@ lcore_tx(struct rte_ring *in_r)
 		if ((enabled_port_mask & (1 << port)) == 0)
 			continue;
 
-		if (rte_eth_dev_socket_id(port) >= 0 &&
-				rte_eth_dev_socket_id(port) != socket_id)
+		if (rte_eth_dev_numa_id(port) >= 0 &&
+				rte_eth_dev_numa_id(port) != numa_id)
 			printf("WARNING, port %u is on remote NUMA node to "
 					"TX thread.\n\tPerformance will not "
 					"be optimal.\n", port);
@@ -828,7 +828,7 @@ main(int argc, char *argv[])
 
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL",
 		NUM_MBUFS * nb_ports, MBUF_CACHE_SIZE, 0,
-		RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
 	nb_ports_available = nb_ports;
@@ -854,7 +854,7 @@ main(int argc, char *argv[])
 				"All available ports are disabled. Please set portmask.\n");
 	}
 
-	d = rte_distributor_create("PKT_DIST", rte_socket_id(),
+	d = rte_distributor_create("PKT_DIST", rte_numa_id(),
 			num_workers,
 			RTE_DIST_ALG_BURST);
 	if (d == NULL)
@@ -865,12 +865,12 @@ main(int argc, char *argv[])
 	 * by scheduler core
 	 */
 	dist_tx_ring = rte_ring_create("Output_ring", SCHED_TX_RING_SZ,
-			rte_socket_id(), RING_F_SC_DEQ | RING_F_SP_ENQ);
+			rte_numa_id(), RING_F_SC_DEQ | RING_F_SP_ENQ);
 	if (dist_tx_ring == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create output ring\n");
 
 	rx_dist_ring = rte_ring_create("Input_ring", SCHED_RX_RING_SZ,
-			rte_socket_id(), RING_F_SC_DEQ | RING_F_SP_ENQ);
+			rte_numa_id(), RING_F_SC_DEQ | RING_F_SP_ENQ);
 	if (rx_dist_ring == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create output ring\n");
 
-- 
2.55.0


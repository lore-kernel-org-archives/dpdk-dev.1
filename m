Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11FD606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jsalsXKr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87D3F432B4;
	Tue,  3 Nov 2026 16:26:00 +0100 (CET)
Received: from mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
 by mails.dpdk.org (Postfix) with ESMTPS id CA1A4432A6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:25:57 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=KPWH5AOcJ+sXqd+I1yYxPTIln9TzpEaLAPP0FG3vwms=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719557; v=1; x=1794324357;
 b=jsalsXKrfKnio+Vdiltyt8ewBBFU3+UBbZgVAL8EQmAqGKsuRyA7TblU6yXKXE0/kzq7TuiT
 t0c2SHRnAIYXHwrUaBO6UYMHkXhFaQP1n7U7wyJRWU54aCN0F2M/mzeSseyGt/mIXbmD/3xioSl
 56SCNJtljS0aXYzlWSN254ho=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 98840c174f0b08e5;
 Tue, 03 Nov 2026 15:25:57 +0000
X-Mizu-Trace-ID: 98840c174f0b08e5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 207/227] examples/multi_process: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:45 +0800
Message-ID: <20261103145306.487255-208-chengwen.feng@linux.dev>
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
 .../client_server_mp/mp_client/client.c            |  4 ++--
 .../client_server_mp/mp_server/init.c              | 14 +++++++-------
 examples/multi_process/simple_mp/main.c            |  6 +++---
 examples/multi_process/symmetric_mp/main.c         |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/examples/multi_process/client_server_mp/mp_client/client.c b/examples/multi_process/client_server_mp/mp_client/client.c
index 087c38ef73..8f6f5bfd5e 100644
--- a/examples/multi_process/client_server_mp/mp_client/client.c
+++ b/examples/multi_process/client_server_mp/mp_client/client.c
@@ -135,9 +135,9 @@ configure_tx_buffer(uint16_t port_id, uint16_t size)
 	int ret;
 
 	/* Initialize TX buffers */
-	tx_buffer[port_id] = rte_zmalloc_socket("tx_buffer",
+	tx_buffer[port_id] = rte_zmalloc_numa("tx_buffer",
 			RTE_ETH_TX_BUFFER_SIZE(size), 0,
-			rte_eth_dev_socket_id(port_id));
+			rte_eth_dev_numa_id(port_id));
 	if (tx_buffer[port_id] == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot allocate buffer for tx on port %u\n",
 			 port_id);
diff --git a/examples/multi_process/client_server_mp/mp_server/init.c b/examples/multi_process/client_server_mp/mp_server/init.c
index 09cb363ab8..ed00540bdb 100644
--- a/examples/multi_process/client_server_mp/mp_server/init.c
+++ b/examples/multi_process/client_server_mp/mp_server/init.c
@@ -75,7 +75,7 @@ init_mbuf_pools(void)
 	printf("Creating mbuf pool '%s' [%u mbufs] ...\n",
 			PKTMBUF_POOL_NAME, num_mbufs);
 	pktmbuf_pool = rte_pktmbuf_pool_create(PKTMBUF_POOL_NAME, num_mbufs,
-		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 
 	return pktmbuf_pool == NULL; /* 0  on success */
 }
@@ -127,14 +127,14 @@ init_port(uint16_t port_num)
 
 	for (q = 0; q < rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port_num, q, rx_ring_size,
-				rte_eth_dev_socket_id(port_num),
+				rte_eth_dev_numa_id(port_num),
 				NULL, pktmbuf_pool);
 		if (retval < 0) return retval;
 	}
 
 	for ( q = 0; q < tx_rings; q ++ ) {
 		retval = rte_eth_tx_queue_setup(port_num, q, tx_ring_size,
-				rte_eth_dev_socket_id(port_num),
+				rte_eth_dev_numa_id(port_num),
 				NULL);
 		if (retval < 0) return retval;
 	}
@@ -160,7 +160,7 @@ static int
 init_shm_rings(void)
 {
 	unsigned i;
-	unsigned socket_id;
+unsigned int numa_id
 	const char * q_name;
 	const unsigned ringsize = CLIENT_QUEUE_RINGSIZE;
 
@@ -171,10 +171,10 @@ init_shm_rings(void)
 
 	for (i = 0; i < num_clients; i++) {
 		/* Create an RX queue for each client */
-		socket_id = rte_socket_id();
+		numa_id = rte_numa_id();
 		q_name = get_rx_queue_name(i);
 		clients[i].rx_q = rte_ring_create(q_name,
-				ringsize, socket_id,
+				ringsize, numa_id,
 				RING_F_SP_ENQ | RING_F_SC_DEQ ); /* single prod, single cons */
 		if (clients[i].rx_q == NULL)
 			rte_exit(EXIT_FAILURE, "Cannot create rx ring queue for client %u\n", i);
@@ -263,7 +263,7 @@ init(int argc, char *argv[])
 
 	/* set up array for port data */
 	mz = rte_memzone_reserve(MZ_PORT_INFO, sizeof(*ports),
-				rte_socket_id(), NO_FLAGS);
+				rte_numa_id(), NO_FLAGS);
 	if (mz == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot reserve memory zone for port information\n");
 	memset(mz->addr, 0, sizeof(*ports));
diff --git a/examples/multi_process/simple_mp/main.c b/examples/multi_process/simple_mp/main.c
index d73d1358ff..7378e1677e 100644
--- a/examples/multi_process/simple_mp/main.c
+++ b/examples/multi_process/simple_mp/main.c
@@ -89,12 +89,12 @@ main(int argc, char **argv)
 
 	/* Start of ring structure. 8< */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY){
-		send_ring = rte_ring_create(_PRI_2_SEC, ring_size, rte_socket_id(), flags);
-		recv_ring = rte_ring_create(_SEC_2_PRI, ring_size, rte_socket_id(), flags);
+		send_ring = rte_ring_create(_PRI_2_SEC, ring_size, rte_numa_id(), flags);
+		recv_ring = rte_ring_create(_SEC_2_PRI, ring_size, rte_numa_id(), flags);
 		message_pool = rte_mempool_create(_MSG_POOL, pool_size,
 				STR_TOKEN_SIZE, pool_cache, priv_data_sz,
 				NULL, NULL, NULL, NULL,
-				rte_socket_id(), flags);
+				rte_numa_id(), flags);
 	} else {
 		recv_ring = rte_ring_lookup(_PRI_2_SEC);
 		send_ring = rte_ring_lookup(_SEC_2_PRI);
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index 19347b403c..0207a92aae 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -263,7 +263,7 @@ smp_port_init(uint16_t port, struct rte_mempool *mbuf_pool,
 	rxq_conf.offloads = port_conf.rxmode.offloads;
 	for (q = 0; q < rx_rings; q ++) {
 		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
-				rte_eth_dev_socket_id(port),
+				rte_eth_dev_numa_id(port),
 				&rxq_conf,
 				mbuf_pool);
 		if (retval < 0)
@@ -274,7 +274,7 @@ smp_port_init(uint16_t port, struct rte_mempool *mbuf_pool,
 	txq_conf.offloads = port_conf.txmode.offloads;
 	for (q = 0; q < tx_rings; q ++) {
 		retval = rte_eth_tx_queue_setup(port, q, nb_txd,
-				rte_eth_dev_socket_id(port),
+				rte_eth_dev_numa_id(port),
 				&txq_conf);
 		if (retval < 0)
 			return retval;
@@ -470,7 +470,7 @@ main(int argc, char **argv)
 			rte_mempool_lookup(_SMP_MBUF_POOL) :
 			rte_pktmbuf_pool_create(_SMP_MBUF_POOL, NB_MBUFS,
 				MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-				rte_socket_id());
+				rte_numa_id());
 	if (mp == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot get memory pool for buffers\n");
 
-- 
2.55.0


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AE606A32D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HRb36G26
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6347432F8;
	Tue,  3 Nov 2026 16:27:07 +0100 (CET)
Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 11C92432F6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:27:07 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=6hcVNAbKHbYJaaD2bEokTabJ9stTYFjytfndmj8zDgM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719626; v=1; x=1794324426;
 b=HRb36G26Ig+dwjMTZbSyHGZRshjdjp5aUzeXmC0ttKrF6avmx9CWSTro4b7o0LUulL/Z6AeJ
 GfwNuGr6HriDrYBkFOzmoXMiING1jCNBD9TGUruxD2UfB8s7qQWLU6wuTrH6RGlUXwwuHZSu2dg
 3OVboB2BKMdvMRynOLxqf/CQ=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id e5701cf74fd14a1c;
 Tue, 03 Nov 2026 15:27:06 +0000
X-Mizu-Trace-ID: e5701cf74fd14a1c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 216/227] examples/server_node_efd: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:54 +0800
Message-ID: <20261103145306.487255-217-chengwen.feng@linux.dev>
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
 examples/server_node_efd/efd_node/node.c   |  6 +++---
 examples/server_node_efd/efd_server/init.c | 22 +++++++++++-----------
 examples/server_node_efd/efd_server/main.c |  8 ++++----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/examples/server_node_efd/efd_node/node.c b/examples/server_node_efd/efd_node/node.c
index fc2aa5ffef..2eaf1ad692 100644
--- a/examples/server_node_efd/efd_node/node.c
+++ b/examples/server_node_efd/efd_node/node.c
@@ -139,9 +139,9 @@ configure_tx_buffer(uint16_t port_id, uint16_t size)
 	int ret;
 
 	/* Initialize TX buffers */
-	tx_buffer[port_id] = rte_zmalloc_socket("tx_buffer",
+	tx_buffer[port_id] = rte_zmalloc_numa("tx_buffer",
 			RTE_ETH_TX_BUFFER_SIZE(size), 0,
-			rte_eth_dev_socket_id(port_id));
+			rte_eth_dev_numa_id(port_id));
 	if (tx_buffer[port_id] == NULL)
 		rte_exit(EXIT_FAILURE,
 			"Cannot allocate buffer for tx on port %u\n", port_id);
@@ -201,7 +201,7 @@ create_hash_table(const struct shared_info *info)
 	struct rte_hash_parameters hash_params = {
 		.entries = num_flows_node * 2, /* table load = 50% */
 		.key_len = sizeof(uint32_t), /* Store IPv4 dest IP address */
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.hash_func_init_val = 0,
 	};
 
diff --git a/examples/server_node_efd/efd_server/init.c b/examples/server_node_efd/efd_server/init.c
index 9644627219..633c7b0bb2 100644
--- a/examples/server_node_efd/efd_server/init.c
+++ b/examples/server_node_efd/efd_server/init.c
@@ -77,7 +77,7 @@ init_mbuf_pools(void)
 	printf("Creating mbuf pool '%s' [%u mbufs] ...\n",
 			PKTMBUF_POOL_NAME, num_mbufs);
 	pktmbuf_pool = rte_pktmbuf_pool_create(PKTMBUF_POOL_NAME, num_mbufs,
-		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 
 	return pktmbuf_pool == NULL; /* 0  on success */
 }
@@ -136,7 +136,7 @@ init_port(uint16_t port_num)
 
 	for (q = 0; q < rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port_num, q, rx_ring_size,
-				rte_eth_dev_socket_id(port_num),
+				rte_eth_dev_numa_id(port_num),
 				NULL, pktmbuf_pool);
 		if (retval < 0)
 			return retval;
@@ -146,7 +146,7 @@ init_port(uint16_t port_num)
 	txconf.offloads = port_conf.txmode.offloads;
 	for (q = 0; q < tx_rings; q++) {
 		retval = rte_eth_tx_queue_setup(port_num, q, tx_ring_size,
-				rte_eth_dev_socket_id(port_num),
+				rte_eth_dev_numa_id(port_num),
 				&txconf);
 		if (retval < 0)
 			return retval;
@@ -174,7 +174,7 @@ static int
 init_shm_rings(void)
 {
 	unsigned int i;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	const char *q_name;
 	const unsigned int ringsize = NODE_QUEUE_RINGSIZE;
 
@@ -186,10 +186,10 @@ init_shm_rings(void)
 
 	for (i = 0; i < num_nodes; i++) {
 		/* Create an RX queue for each node */
-		socket_id = rte_socket_id();
+		numa_id = rte_numa_id();
 		q_name = get_rx_queue_name(i);
 		nodes[i].rx_q = rte_ring_create(q_name,
-				ringsize, socket_id,
+				ringsize, numa_id,
 				RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (nodes[i].rx_q == NULL)
 			rte_exit(EXIT_FAILURE, "Cannot create rx ring queue "
@@ -207,11 +207,11 @@ init_shm_rings(void)
 static void
 create_efd_table(void)
 {
-	uint8_t socket_id = rte_socket_id();
+	uint8_t numa_id = rte_numa_id();
 
 	/* create table */
 	efd_table = rte_efd_create("flow table", num_flows * 2, sizeof(uint32_t),
-			1 << socket_id,	socket_id);
+			1 << numa_id,	numa_id);
 
 	if (efd_table == NULL)
 		rte_exit(EXIT_FAILURE, "Problem creating the flow table\n");
@@ -223,7 +223,7 @@ populate_efd_table(void)
 	unsigned int i;
 	int32_t ret;
 	uint32_t ip_dst;
-	uint8_t socket_id = rte_socket_id();
+	uint8_t numa_id = rte_numa_id();
 	uint64_t node_id;
 
 	/* Add flows in table */
@@ -231,7 +231,7 @@ populate_efd_table(void)
 		node_id = i % num_nodes;
 
 		ip_dst = rte_cpu_to_be_32(i);
-		ret = rte_efd_update(efd_table, socket_id,
+		ret = rte_efd_update(efd_table, numa_id,
 				(void *)&ip_dst, (efd_value_t)node_id);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE, "Unable to add entry %u in "
@@ -325,7 +325,7 @@ init(int argc, char *argv[])
 
 	/* set up array for port data */
 	mz = rte_memzone_reserve(MZ_SHARED_INFO, sizeof(*info),
-				rte_socket_id(), NO_FLAGS);
+				rte_numa_id(), NO_FLAGS);
 	if (mz == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot reserve memory zone "
 				"for port information\n");
diff --git a/examples/server_node_efd/efd_server/main.c b/examples/server_node_efd/efd_server/main.c
index 70a7372d4a..88af8eed1b 100644
--- a/examples/server_node_efd/efd_server/main.c
+++ b/examples/server_node_efd/efd_server/main.c
@@ -255,7 +255,7 @@ enqueue_rx_packet(uint8_t node, struct rte_mbuf *buf)
 /* Processing packets. 8< */
 static void
 process_packets(uint32_t port_num __rte_unused, struct rte_mbuf *pkts[],
-		uint16_t rx_count, unsigned int socket_id)
+		uint16_t rx_count, unsigned int numa_id)
 {
 	uint16_t i;
 	uint8_t node;
@@ -273,7 +273,7 @@ process_packets(uint32_t port_num __rte_unused, struct rte_mbuf *pkts[],
 		key_ptrs[i] = (void *)&ipv4_dst_ip[i];
 	}
 
-	rte_efd_lookup_bulk(efd_table, socket_id, rx_count,
+	rte_efd_lookup_bulk(efd_table, numa_id, rx_count,
 				(const void **) key_ptrs, data);
 	for (i = 0; i < rx_count; i++) {
 		node = (uint8_t) ((uintptr_t)data[i]);
@@ -303,7 +303,7 @@ static void
 do_packet_forwarding(void)
 {
 	unsigned int port_num = 0; /* indexes the port[] array */
-	unsigned int socket_id = rte_socket_id();
+	unsigned int numa_id = rte_numa_id();
 
 	for (;;) {
 		struct rte_mbuf *buf[PACKET_READ_SIZE];
@@ -316,7 +316,7 @@ do_packet_forwarding(void)
 
 		/* Now process the NIC packets read */
 		if (likely(rx_count > 0))
-			process_packets(port_num, buf, rx_count, socket_id);
+			process_packets(port_num, buf, rx_count, numa_id);
 
 		/* move to next port */
 		if (++port_num == info->num_ports)
-- 
2.55.0


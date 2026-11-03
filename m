Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FF606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mz2OMOS3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA0A442F7B;
	Tue,  3 Nov 2026 16:19:58 +0100 (CET)
Received: from mta1.migadu.com (out-147.mta1.migadu.com [95.215.58.147])
 by mails.dpdk.org (Postfix) with ESMTPS id 577EC42F67
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:57 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=+AgdZ6mTDXy56WoFb1ukGB9zTY/5gJeqMyxGqBS2N+w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719197; v=1; x=1794323997;
 b=mz2OMOS3XBJmWSJStmHP5nZf/98QOaCGTahpQ+kbzS/49V/luD1GnUaiICj59HlOYe6dA1Dd
 hruB5E6sovTOxQ29kwb0+1nj2RvhhD3mRh6p6qBhkguBNKvu6JjjcDXLS+pDeOxauPssUzyb+NC
 aQ93Xn6DwPdXz5KcwJ8dMPpI=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 89904aede6b61ae7;
 Tue, 03 Nov 2026 15:19:56 +0000
X-Mizu-Trace-ID: 89904aede6b61ae7
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 171/227] app/testpmd: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:09 +0800
Message-ID: <20261103145306.487255-172-chengwen.feng@linux.dev>
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
 app/test-pmd/cmdline.c    |  22 +++----
 app/test-pmd/config.c     |  10 ++--
 app/test-pmd/noisy_vnf.c  |   2 +-
 app/test-pmd/parameters.c |  46 +++++++--------
 app/test-pmd/testpmd.c    | 118 +++++++++++++++++++-------------------
 app/test-pmd/testpmd.h    |  20 +++----
 6 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index cdf73540ec..5de7c2f113 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3038,7 +3038,7 @@ cmd_setup_rxtx_queue_parsed(
 	struct cmd_setup_rxtx_queue *res = parsed_result;
 	struct rte_port *port;
 	struct rte_mempool *mp;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	uint8_t isrx = 0;
 	int ret;
 
@@ -3069,32 +3069,32 @@ cmd_setup_rxtx_queue_parsed(
 
 	port = &ports[res->portid];
 	if (isrx) {
-		socket_id = rxring_numa[res->portid];
-		if (!numa_support || socket_id == NUMA_NO_CONFIG)
-			socket_id = port->socket_id;
+		numa_id = rxring_numa[res->portid];
+		if (!numa_support || numa_id == NUMA_NO_CONFIG)
+			numa_id = port->numa_id;
 
-		mp = mbuf_pool_find_first(socket_id);
+		mp = mbuf_pool_find_first(numa_id);
 		if (mp == NULL) {
 			char buf[16];
 
 			fprintf(stderr,
 				"Failed to setup RX queue: No mempool allocation on the socket %s\n",
-				socket_id_str(socket_id, buf, sizeof(buf)));
+				socket_id_str(numa_id, buf, sizeof(buf)));
 			return;
 		}
 		ret = rx_queue_setup(res->portid,
 				     res->qid,
 				     port->nb_rx_desc[res->qid],
-				     socket_id,
+				     numa_id,
 				     &port->rxq[res->qid].conf,
 				     mp);
 		if (ret)
 			fprintf(stderr, "Failed to setup RX queue: %s\n",
 				rte_strerror(-ret));
 	} else {
-		socket_id = txring_numa[res->portid];
-		if (!numa_support || socket_id == NUMA_NO_CONFIG)
-			socket_id = port->socket_id;
+		numa_id = txring_numa[res->portid];
+		if (!numa_support || numa_id == NUMA_NO_CONFIG)
+			numa_id = port->numa_id;
 
 		if (port->nb_tx_desc[res->qid] < tx_pkt_nb_segs) {
 			fprintf(stderr,
@@ -3104,7 +3104,7 @@ cmd_setup_rxtx_queue_parsed(
 		ret = rte_eth_tx_queue_setup(res->portid,
 					     res->qid,
 					     port->nb_tx_desc[res->qid],
-					     socket_id,
+					     numa_id,
 					     &port->txq[res->qid].conf);
 		if (ret)
 			fprintf(stderr, "Failed to setup TX queue: %s\n",
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index ec348cf854..5f26e7f392 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -843,7 +843,7 @@ port_infos_display(portid_t port_id)
 	if (rte_dev_devargs(dev_info.device) && rte_dev_devargs(dev_info.device)->args)
 		printf("\nDevargs: %s", rte_dev_devargs(dev_info.device)->args);
 	printf("\nConnect to socket: %s",
-	       socket_id_str(port->socket_id, buf, sizeof(buf)));
+	       socket_id_str(port->numa_id, buf, sizeof(buf)));
 
 	if (port_numa[port_id] != NUMA_NO_CONFIG) {
 		mp = mbuf_pool_find(port_numa[port_id], 0);
@@ -852,7 +852,7 @@ port_infos_display(portid_t port_id)
 							port_numa[port_id]);
 	} else
 		printf("\nmemory allocation on the socket: %s",
-		       socket_id_str(port->socket_id, buf, sizeof(buf)));
+		       socket_id_str(port->numa_id, buf, sizeof(buf)));
 
 	printf("\nLink status: %s\n", (link.link_status) ? ("up") : ("down"));
 	printf("Link speed: %s\n", rte_eth_link_speed_to_str(link.link_speed));
@@ -5725,17 +5725,17 @@ pkt_fwd_config_display(struct fwd_config *cfg)
 		printf("Logical Core %u (socket %u) forwards packets on "
 		       "%d streams:",
 		       fwd_lcores_cpuids[lc_id],
-		       rte_lcore_to_socket_id(fwd_lcores_cpuids[lc_id]),
+		       rte_lcore_to_numa_id(fwd_lcores_cpuids[lc_id]),
 		       fwd_lcores[lc_id]->stream_nb);
 		for (sm_id = 0; sm_id < fwd_lcores[lc_id]->stream_nb; sm_id++) {
 			fs = fwd_streams[fwd_lcores[lc_id]->stream_idx + sm_id];
 			printf("\n  RX P=%d/Q=%d (socket %s) -> ",
 			       fs->rx_port, fs->rx_queue,
-			       socket_id_str(ports[fs->rx_port].socket_id,
+			       socket_id_str(ports[fs->rx_port].numa_id,
 					     buf, sizeof(buf)));
 			printf("TX P=%d/Q=%d (socket %s) ",
 			       fs->tx_port, fs->tx_queue,
-			       socket_id_str(ports[fs->tx_port].socket_id,
+			       socket_id_str(ports[fs->tx_port].numa_id,
 					     buf, sizeof(buf)));
 			print_ethaddr("peer=",
 				      &peer_eth_addrs[fs->peer_addr]);
diff --git a/app/test-pmd/noisy_vnf.c b/app/test-pmd/noisy_vnf.c
index 81d1187cfe..e5c8caeccb 100644
--- a/app/test-pmd/noisy_vnf.c
+++ b/app/test-pmd/noisy_vnf.c
@@ -273,7 +273,7 @@ noisy_fwd_begin(portid_t pi)
 	if (n->do_buffering) {
 		snprintf(name, NOISY_STRSIZE, NOISY_RING, pi);
 		n->f = rte_ring_create(name, noisy_tx_sw_bufsz,
-				rte_socket_id(), 0);
+				rte_numa_id(), 0);
 		if (!n->f)
 			rte_exit(EXIT_FAILURE,
 				 "rte_ring_create(%d), size %d) failed\n",
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 833b14eda4..c110e956f5 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -632,14 +632,14 @@ parse_fwd_portmask(const char *portmask)
 }
 
 static void
-print_invalid_socket_id_error(void)
+print_invalid_numa_id_error(void)
 {
 	unsigned int i = 0;
 
 	fprintf(stderr, "Invalid socket id, options are: ");
-	for (i = 0; i < num_sockets; i++) {
-		fprintf(stderr, "%u%s", socket_ids[i],
-			(i == num_sockets - 1) ? "\n" : ",");
+	for (i = 0; i < num_numas; i++) {
+		fprintf(stderr, "%u%s", numa_ids[i],
+			(i == num_numas - 1) ? "\n" : ",");
 	}
 }
 
@@ -649,7 +649,7 @@ parse_portnuma_config(const char *q_arg)
 	char s[256];
 	const char *p, *p0 = q_arg;
 	char *end;
-	uint8_t i, socket_id;
+	uint8_t i, numa_id;
 	portid_t port_id;
 	unsigned size;
 	enum fieldnames {
@@ -685,15 +685,15 @@ parse_portnuma_config(const char *q_arg)
 			print_valid_ports();
 			return -1;
 		}
-		socket_id = (uint8_t)int_fld[FLD_SOCKET];
-		if (new_socket_id(socket_id)) {
-			if (num_sockets >= RTE_MAX_NUMA_NODES) {
-				print_invalid_socket_id_error();
+		numa_id = (uint8_t)int_fld[FLD_SOCKET];
+		if (new_numa_id(numa_id)) {
+			if (num_numas >= RTE_MAX_NUMA_NODES) {
+				print_invalid_numa_id_error();
 				return -1;
 			}
-			socket_ids[num_sockets++] = socket_id;
+			numa_ids[num_numas++] = numa_id;
 		}
-		port_numa[port_id] = socket_id;
+		port_numa[port_id] = numa_id;
 	}
 
 	return 0;
@@ -705,7 +705,7 @@ parse_ringnuma_config(const char *q_arg)
 	char s[256];
 	const char *p, *p0 = q_arg;
 	char *end;
-	uint8_t i, ring_flag, socket_id;
+	uint8_t i, ring_flag, numa_id;
 	portid_t port_id;
 	unsigned size;
 	enum fieldnames {
@@ -745,13 +745,13 @@ parse_ringnuma_config(const char *q_arg)
 			print_valid_ports();
 			return -1;
 		}
-		socket_id = (uint8_t)int_fld[FLD_SOCKET];
-		if (new_socket_id(socket_id)) {
-			if (num_sockets >= RTE_MAX_NUMA_NODES) {
-				print_invalid_socket_id_error();
+		numa_id = (uint8_t)int_fld[FLD_SOCKET];
+		if (new_numa_id(numa_id)) {
+			if (num_numas >= RTE_MAX_NUMA_NODES) {
+				print_invalid_numa_id_error();
 				return -1;
 			}
-			socket_ids[num_sockets++] = socket_id;
+			numa_ids[num_numas++] = numa_id;
 		}
 		ring_flag = (uint8_t)int_fld[FLD_FLAG];
 		if ((ring_flag < RX_RING_ONLY) || (ring_flag > RXTX_RING)) {
@@ -763,14 +763,14 @@ parse_ringnuma_config(const char *q_arg)
 
 		switch (ring_flag & RXTX_RING) {
 		case RX_RING_ONLY:
-			rxring_numa[port_id] = socket_id;
+			rxring_numa[port_id] = numa_id;
 			break;
 		case TX_RING_ONLY:
-			txring_numa[port_id] = socket_id;
+			txring_numa[port_id] = numa_id;
 			break;
 		case RXTX_RING:
-			rxring_numa[port_id] = socket_id;
-			txring_numa[port_id] = socket_id;
+			rxring_numa[port_id] = numa_id;
+			txring_numa[port_id] = numa_id;
 			break;
 		default:
 			fprintf(stderr,
@@ -1187,10 +1187,10 @@ launch_args_parse(int argc, char** argv)
 			break;
 		case TESTPMD_OPT_SOCKET_NUM_NUM:
 			n = atoi(optarg);
-			if (!new_socket_id((uint8_t)n)) {
+			if (!new_numa_id((uint8_t)n)) {
 				socket_num = (uint8_t)n;
 			} else {
-				print_invalid_socket_id_error();
+				print_invalid_numa_id_error();
 				rte_exit(EXIT_FAILURE,
 					"Invalid socket id");
 			}
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bbef4a8580..aca57655c0 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -557,8 +557,8 @@ struct share_group_slot {
 
 static struct share_group_slot share_group_slots[RTE_MAX_ETHPORTS];
 
-unsigned int num_sockets = 0;
-unsigned int socket_ids[RTE_MAX_NUMA_NODES];
+unsigned int num_numas = 0;
+unsigned int numa_ids[RTE_MAX_NUMA_NODES];
 
 #ifdef RTE_LIB_BITRATESTATS
 /* Bitrate statistics */
@@ -824,12 +824,12 @@ char dynf_names[64][RTE_MBUF_DYN_NAMESIZE];
  * If yes, return positive value. If not, return zero.
  */
 int
-new_socket_id(unsigned int socket_id)
+new_numa_id(unsigned int numa_id)
 {
 	unsigned int i;
 
-	for (i = 0; i < num_sockets; i++) {
-		if (socket_ids[i] == socket_id)
+	for (i = 0; i < num_numas; i++) {
+		if (numa_ids[i] == numa_id)
 			return 0;
 	}
 	return 1;
@@ -849,14 +849,14 @@ set_default_fwd_lcores_config(void)
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		if (!rte_lcore_is_enabled(i))
 			continue;
-		sock_num = rte_lcore_to_socket_id(i);
-		if (new_socket_id(sock_num)) {
-			if (num_sockets >= RTE_MAX_NUMA_NODES) {
+		sock_num = rte_lcore_to_numa_id(i);
+		if (new_numa_id(sock_num)) {
+			if (num_numas >= RTE_MAX_NUMA_NODES) {
 				rte_exit(EXIT_FAILURE,
 					 "Total sockets greater than %u\n",
 					 RTE_MAX_NUMA_NODES);
 			}
-			socket_ids[num_sockets++] = sock_num;
+			numa_ids[num_numas++] = sock_num;
 		}
 		if (i == rte_get_main_lcore())
 			continue;
@@ -888,14 +888,14 @@ set_default_fwd_ports_config(void)
 		fwd_ports_ids[i++] = pt_id;
 
 		/* Update sockets info according to the attached device */
-		int socket_id = rte_eth_dev_socket_id(pt_id);
-		if (socket_id >= 0 && new_socket_id(socket_id)) {
-			if (num_sockets >= RTE_MAX_NUMA_NODES) {
+		int numa_id = rte_eth_dev_numa_id(pt_id);
+		if (numa_id >= 0 && new_numa_id(numa_id)) {
+			if (num_numas >= RTE_MAX_NUMA_NODES) {
 				rte_exit(EXIT_FAILURE,
 					 "Total sockets greater than %u\n",
 					 RTE_MAX_NUMA_NODES);
 			}
-			socket_ids[num_sockets++] = socket_id;
+			numa_ids[num_numas++] = numa_id;
 		}
 	}
 
@@ -1081,13 +1081,13 @@ static int
 setup_extmem(uint32_t nb_mbufs, uint32_t mbuf_sz, bool huge)
 {
 	struct extmem_param param;
-	int socket_id, ret;
+	int numa_id, ret;
 
 	memset(&param, 0, sizeof(param));
 
 	/* check if our heap exists */
-	socket_id = rte_malloc_heap_get_numa_id(EXTMEM_HEAP_NAME);
-	if (socket_id < 0) {
+	numa_id = rte_malloc_heap_get_numa_id(EXTMEM_HEAP_NAME);
+	if (numa_id < 0) {
 		/* create our heap */
 		ret = rte_malloc_heap_create(EXTMEM_HEAP_NAME);
 		if (ret < 0) {
@@ -1197,7 +1197,7 @@ dma_map_cb(struct rte_mempool *mp __rte_unused, void *opaque __rte_unused,
 #endif
 
 static unsigned int
-setup_extbuf(uint32_t nb_mbufs, uint16_t mbuf_sz, unsigned int socket_id,
+setup_extbuf(uint32_t nb_mbufs, uint16_t mbuf_sz, unsigned int numa_id,
 	    char *pool_name, struct rte_pktmbuf_extmem **ext_mem)
 {
 	struct rte_pktmbuf_extmem *xmem;
@@ -1229,7 +1229,7 @@ setup_extbuf(uint32_t nb_mbufs, uint16_t mbuf_sz, unsigned int socket_id,
 			break;
 		}
 		mz = rte_memzone_reserve(mz_name, EXTBUF_ZONE_SIZE,
-					 socket_id,
+					 numa_id,
 					 RTE_MEMZONE_IOVA_CONTIG |
 					 RTE_MEMZONE_1GB |
 					 RTE_MEMZONE_SIZE_HINT_ONLY);
@@ -1260,7 +1260,7 @@ setup_extbuf(uint32_t nb_mbufs, uint16_t mbuf_sz, unsigned int socket_id,
  */
 static struct rte_mempool *
 mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
-		 unsigned int socket_id, uint16_t size_idx)
+		 unsigned int numa_id, uint16_t size_idx)
 {
 	char pool_name[RTE_MEMPOOL_NAMESIZE];
 	char sock_str[16];
@@ -1270,13 +1270,13 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 
 	mb_size = sizeof(struct rte_mbuf) + mbuf_seg_size;
 #endif
-	mbuf_poolname_build(socket_id, pool_name, sizeof(pool_name), size_idx);
+	mbuf_poolname_build(numa_id, pool_name, sizeof(pool_name), size_idx);
 	if (!is_proc_primary()) {
 		rte_mp = rte_mempool_lookup(pool_name);
 		if (rte_mp == NULL)
 			rte_exit(EXIT_FAILURE,
 				"Get mbuf pool for socket %s failed: %s\n",
-				socket_id_str(socket_id, sock_str,
+				socket_id_str(numa_id, sock_str,
 					      sizeof(sock_str)),
 				rte_strerror(rte_errno));
 		return rte_mp;
@@ -1285,7 +1285,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 	TESTPMD_LOG(INFO,
 		"create a new mbuf pool <%s>: n=%u, size=%u, socket=%s\n",
 		pool_name, nb_mbuf, mbuf_seg_size,
-		socket_id_str(socket_id, sock_str, sizeof(sock_str)));
+		socket_id_str(numa_id, sock_str, sizeof(sock_str)));
 
 	switch (mp_alloc_type) {
 	case MP_ALLOC_NATIVE:
@@ -1294,7 +1294,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 			TESTPMD_LOG(INFO, "preferred mempool ops selected: %s\n",
 					rte_mbuf_best_mempool_ops());
 			rte_mp = rte_pktmbuf_pool_create(pool_name, nb_mbuf,
-				mb_mempool_cache, 0, mbuf_seg_size, socket_id);
+				mb_mempool_cache, 0, mbuf_seg_size, numa_id);
 			break;
 		}
 #ifndef RTE_EXEC_ENV_WINDOWS
@@ -1303,7 +1303,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 			rte_mp = rte_mempool_create_empty(pool_name, nb_mbuf,
 				mb_size, (unsigned int) mb_mempool_cache,
 				sizeof(struct rte_pktmbuf_pool_private),
-				socket_id, mempool_flags);
+				numa_id, mempool_flags);
 			if (rte_mp == NULL)
 				goto err;
 
@@ -1345,7 +1345,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 			unsigned int ext_num;
 
 			ext_num = setup_extbuf(nb_mbuf,	mbuf_seg_size,
-					       socket_id, pool_name, &ext_mem);
+					       numa_id, pool_name, &ext_mem);
 			if (ext_num == 0)
 				rte_exit(EXIT_FAILURE,
 					 "Can't create pinned data buffers\n");
@@ -1354,7 +1354,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 					rte_mbuf_best_mempool_ops());
 			rte_mp = rte_pktmbuf_pool_create_extbuf
 					(pool_name, nb_mbuf, mb_mempool_cache,
-					 0, mbuf_seg_size, socket_id,
+					 0, mbuf_seg_size, numa_id,
 					 ext_mem, ext_num);
 			free(ext_mem);
 			break;
@@ -1371,7 +1371,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 	if (rte_mp == NULL) {
 		rte_exit(EXIT_FAILURE,
 			"Creation of mbuf pool for socket %s failed: %s\n",
-			socket_id_str(socket_id, sock_str, sizeof(sock_str)),
+			socket_id_str(numa_id, sock_str, sizeof(sock_str)),
 			rte_strerror(rte_errno));
 	} else if (verbose_level > 0) {
 		rte_mempool_dump(stdout, rte_mp);
@@ -1384,11 +1384,11 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
  * if valid, return 0, else return -1
  */
 static int
-check_socket_id(const unsigned int socket_id)
+check_socket_id(const unsigned int numa_id)
 {
 	static int warning_once = 0;
 
-	if (new_socket_id(socket_id)) {
+	if (new_numa_id(numa_id)) {
 		if (!warning_once && numa_support)
 			fprintf(stderr,
 				"Warning: NUMA should be configured manually by using --port-numa-config and --ring-numa-config parameters along with --numa.\n");
@@ -1671,7 +1671,7 @@ get_eth_overhead(struct rte_eth_dev_info *dev_info)
 }
 
 static void
-init_config_port_offloads(portid_t pid, uint32_t socket_id)
+init_config_port_offloads(portid_t pid, uint32_t numa_id)
 {
 	struct rte_port *port = &ports[pid];
 	int ret;
@@ -1707,7 +1707,7 @@ init_config_port_offloads(portid_t pid, uint32_t socket_id)
 	/* set flag to initialize port/queue */
 	port->need_reconfig = 1;
 	port->need_reconfig_queues = 1;
-	port->socket_id = socket_id;
+	port->numa_id = numa_id;
 	port->tx_metadata = 0;
 
 	/*
@@ -1736,13 +1736,13 @@ init_config_port_offloads(portid_t pid, uint32_t socket_id)
 
 /*
  * Socket id that mbuf pools are created (and named) with when NUMA
- * support is disabled: --socket-num if given, otherwise SOCKET_ID_ANY.
+ * support is disabled: --socket-num if given, otherwise RTE_NUMA_ID_ANY.
  */
 static unsigned int
 uma_socket_id(void)
 {
 	return socket_num == UMA_NO_CONFIG ?
-	       (unsigned int)SOCKET_ID_ANY : socket_num;
+	       (unsigned int)RTE_NUMA_ID_ANY : socket_num;
 }
 
 /*
@@ -1752,22 +1752,22 @@ uma_socket_id(void)
 static unsigned int
 port_socket_id(portid_t pid)
 {
-	unsigned int socket_id;
+	unsigned int numa_id;
 
 	if (!numa_support)
 		return uma_socket_id();
 
-	socket_id = port_numa[pid];
-	if (socket_id == NUMA_NO_CONFIG) {
-		socket_id = rte_eth_dev_socket_id(pid);
+	numa_id = port_numa[pid];
+	if (numa_id == NUMA_NO_CONFIG) {
+		numa_id = rte_eth_dev_numa_id(pid);
 		/*
-		 * If socket_id is invalid,
+		 * If numa_id is invalid,
 		 * set to the first available socket.
 		 */
-		if (check_socket_id(socket_id) < 0)
-			socket_id = socket_ids[0];
+		if (check_socket_id(numa_id) < 0)
+			numa_id = numa_ids[0];
 	}
-	return socket_id;
+	return numa_id;
 }
 
 static void
@@ -1828,14 +1828,14 @@ init_config(void)
 	if (numa_support) {
 		uint8_t i, j;
 
-		for (i = 0; i < num_sockets; i++)
+		for (i = 0; i < num_numas; i++)
 			for (j = 0; j < mbuf_data_size_n; j++) {
 				if (mbuf_data_size[j] == 0)
 					continue;
 				mempools[i * MAX_SEGS_BUFFER_SPLIT + j] =
 					mbuf_pool_create(mbuf_data_size[j],
 							  nb_mbuf_per_pool,
-							  socket_ids[i], j);
+							  numa_ids[i], j);
 			}
 	} else {
 		uint8_t i;
@@ -1861,7 +1861,7 @@ init_config(void)
 	 */
 	for (lc_id = 0; lc_id < nb_lcores; lc_id++) {
 		mbp = mbuf_pool_find_first(
-			rte_lcore_to_socket_id(fwd_lcores_cpuids[lc_id]));
+			rte_lcore_to_numa_id(fwd_lcores_cpuids[lc_id]));
 
 		if (mbp == NULL)
 			mbp = mbuf_pool_find_first(numa_support ?
@@ -1899,10 +1899,10 @@ init_config(void)
 
 
 void
-reconfig(portid_t new_port_id, unsigned socket_id)
+reconfig(portid_t new_port_id, unsigned int numa_id)
 {
 	/* Reconfiguration of Ethernet ports. */
-	init_config_port_offloads(new_port_id, socket_id);
+	init_config_port_offloads(new_port_id, numa_id);
 	init_port_config();
 }
 
@@ -1929,7 +1929,7 @@ init_fwd_streams(void)
 				nb_txq, port->dev_info.max_tx_queues);
 			return -1;
 		}
-		port->socket_id = port_socket_id(pid);
+		port->numa_id = port_socket_id(pid);
 	}
 
 	q = RTE_MAX(nb_rxq, nb_txq);
@@ -2745,7 +2745,7 @@ port_is_started(portid_t port_id)
 /* Configure the Rx with optional split. */
 int
 rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
-	       uint16_t nb_rx_desc, unsigned int socket_id,
+	       uint16_t nb_rx_desc, unsigned int numa_id,
 	       struct rte_eth_rxconf *rx_conf, struct rte_mempool *mp)
 {
 	union rte_eth_rxseg rx_useg[MAX_SEGS_BUFFER_SPLIT] = {};
@@ -2771,7 +2771,7 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			if (mbuf_data_size[mp_n] == 0) {
 				rx_seg->mp = NULL;
 			} else {
-				mpx = mbuf_pool_find(socket_id, mp_n);
+				mpx = mbuf_pool_find(numa_id, mp_n);
 				rx_seg->mp = mpx ? mpx : mp;
 			}
 			if (rx_pkt_hdr_protos[i] != 0 && rx_pkt_seg_lengths[i] == 0) {
@@ -2787,7 +2787,7 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		rx_conf->rx_mempools = NULL;
 		rx_conf->rx_nmempool = 0;
 		ret = rte_eth_rx_queue_setup(port_id, rx_queue_id, nb_rx_desc,
-				    socket_id, rx_conf, NULL);
+				    numa_id, rx_conf, NULL);
 		rx_conf->rx_seg = NULL;
 		rx_conf->rx_nseg = 0;
 	} else if (multi_rx_mempool == 1) {
@@ -2809,7 +2809,7 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			return -ENOTSUP;
 		}
 		for (i = 0; i < mbuf_data_size_n; i++) {
-			mpx = mbuf_pool_find(socket_id, i);
+			mpx = mbuf_pool_find(numa_id, i);
 			rx_mempool[i] = mpx ? mpx : mp;
 		}
 		rx_conf->rx_mempools = rx_mempool;
@@ -2817,7 +2817,7 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		rx_conf->rx_seg = NULL;
 		rx_conf->rx_nseg = 0;
 		ret = rte_eth_rx_queue_setup(port_id, rx_queue_id, nb_rx_desc,
-				    socket_id, rx_conf, NULL);
+				    numa_id, rx_conf, NULL);
 		rx_conf->rx_mempools = NULL;
 		rx_conf->rx_nmempool = 0;
 	} else {
@@ -2827,7 +2827,7 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		rx_conf->rx_mempools = NULL;
 		rx_conf->rx_nmempool = 0;
 		ret = rte_eth_rx_queue_setup(port_id, rx_queue_id, nb_rx_desc,
-				    socket_id, rx_conf, mp);
+				    numa_id, rx_conf, mp);
 	}
 
 	ports[port_id].rxq[rx_queue_id].state = rx_conf->rx_deferred_start ?
@@ -3033,7 +3033,7 @@ start_port(portid_t pid)
 			}
 			configure_rxtx_dump_callbacks(0);
 			printf("Configuring Port %d (socket %s)\n", pi,
-					socket_id_str(port->socket_id,
+					socket_id_str(port->numa_id,
 						buf, sizeof(buf)));
 			if (nb_hairpinq > 0 &&
 			    rte_eth_dev_hairpin_capability_get(pi, &cap)) {
@@ -3112,7 +3112,7 @@ start_port(portid_t pid)
 				else
 					diag = rte_eth_tx_queue_setup(pi, qi,
 						port->nb_tx_desc[qi],
-						port->socket_id,
+						port->numa_id,
 						&(port->txq[qi].conf));
 
 				if (diag == 0) {
@@ -3159,17 +3159,17 @@ start_port(portid_t pid)
 				} else {
 					struct rte_mempool *mp =
 						mbuf_pool_find_first
-							(port->socket_id);
+							(port->numa_id);
 					if (mp == NULL) {
 						fprintf(stderr,
 							"Failed to setup RX queue: No mempool allocation on the socket %s\n",
-							socket_id_str(port->socket_id,
+							socket_id_str(port->numa_id,
 								buf, sizeof(buf)));
 						return -1;
 					}
 					diag = rx_queue_setup(pi, qi,
 					     port->nb_rx_desc[qi],
-					     port->socket_id,
+					     port->numa_id,
 					     &(port->rxq[qi].conf),
 					     mp);
 				}
@@ -4677,7 +4677,7 @@ main(int argc, char** argv)
 
 #ifdef RTE_LIB_METRICS
 	/* Init metrics library */
-	rte_metrics_init(SOCKET_ID_ANY);
+	rte_metrics_init(RTE_NUMA_ID_ANY);
 #endif
 
 #ifdef RTE_LIB_LATENCYSTATS
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 2ca4aaf086..664feb0f34 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -342,7 +342,7 @@ struct rte_port {
 	struct rte_eth_conf     dev_conf;   /**< Port configuration. */
 	struct rte_ether_addr       eth_addr;   /**< Port ethernet address */
 	struct rte_eth_stats    stats;      /**< Last port statistics */
-	unsigned int            socket_id;  /**< For NUMA support */
+	unsigned int            numa_id;  /**< For NUMA support */
 	uint16_t		parse_tunnel:1; /**< Parse internal headers */
 	uint16_t                tso_segsz;  /**< Segmentation offload MSS for non-tunneled packets. */
 	uint16_t                tunnel_tso_segsz; /**< Segmentation offload MSS for tunneled pkts. */
@@ -576,8 +576,8 @@ extern lcoreid_t nb_lcores; /**< Number of logical cores probed at init time. */
 extern lcoreid_t nb_cfg_lcores; /**< Number of configured logical cores. */
 extern lcoreid_t nb_fwd_lcores; /**< Number of forwarding logical cores. */
 extern unsigned int fwd_lcores_cpuids[RTE_MAX_LCORE];
-extern unsigned int num_sockets;
-extern unsigned int socket_ids[RTE_MAX_NUMA_NODES];
+extern unsigned int num_numas;
+extern unsigned int numa_ids[RTE_MAX_NUMA_NODES];
 
 /*
  * Configuration of Ethernet ports:
@@ -873,14 +873,14 @@ current_fwd_lcore(void)
 void
 parse_fwd_portlist(const char *port);
 
-/* Format a socket id for display, SOCKET_ID_ANY as "any". */
+/* Format a socket id for display, RTE_NUMA_ID_ANY as "any". */
 static inline const char *
-socket_id_str(unsigned int socket_id, char *buf, size_t size)
+socket_id_str(unsigned int numa_id, char *buf, size_t size)
 {
-	if (socket_id == (unsigned int)SOCKET_ID_ANY)
+	if (numa_id == (unsigned int)RTE_NUMA_ID_ANY)
 		snprintf(buf, size, "any");
 	else
-		snprintf(buf, size, "%u", socket_id);
+		snprintf(buf, size, "%u", numa_id);
 	return buf;
 }
 
@@ -1000,7 +1000,7 @@ void pkt_fwd_config_display(struct fwd_config *cfg);
 void rxtx_config_display(void);
 void fwd_config_setup(void);
 void set_def_fwd_config(void);
-void reconfig(portid_t new_port_id, unsigned socket_id);
+void reconfig(portid_t new_port_id, unsigned int numa_id);
 int init_fwd_streams(void);
 void update_fwd_ports(portid_t new_pid);
 
@@ -1222,7 +1222,7 @@ void set_vf_traffic(portid_t port_id, uint8_t is_rx, uint16_t vf, uint8_t on);
 
 int
 rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
-	       uint16_t nb_rx_desc, unsigned int socket_id,
+	       uint16_t nb_rx_desc, unsigned int numa_id,
 	       struct rte_eth_rxconf *rx_conf, struct rte_mempool *mp);
 
 int set_queue_rate_limit(portid_t port_id, uint16_t queue_idx, uint32_t rate);
@@ -1275,7 +1275,7 @@ enum print_warning {
 };
 int port_id_is_invalid(portid_t port_id, enum print_warning warning);
 void print_valid_ports(void);
-int new_socket_id(unsigned int socket_id);
+int new_numa_id(unsigned int numa_id);
 
 queueid_t get_allowed_max_nb_rxq(portid_t *pid);
 int check_nb_rxq(queueid_t rxq);
-- 
2.55.0


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F857606B277
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uToJheC/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A7E24161A;
	Tue,  3 Nov 2026 15:56:53 +0100 (CET)
Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 51DC342795
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:56:51 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=oV2vq8sI9KDwQHG4DVTBlTucUy47hM+TpdjFFnLDgMg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717811; v=1; x=1794322611;
 b=uToJheC/dgqRv2iYWF4yhght57Cv78G8eFt/UZgDCCzHZWOZ4Otgy0es3fCzUzk/ztyg1oWr
 EspSgVUDBJchDOr38k9Opkvj7eQz/Hr+E3+n8fo+hLcae8mhBDzluD31iG46GWYwKOwO5JFslM7
 XNjwHXw3Ri/hG9B64+vW4KX8=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id fdfa9732af9b8842;
 Tue, 03 Nov 2026 14:56:50 +0000
X-Mizu-Trace-ID: fdfa9732af9b8842
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 022/227] node: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:40 +0800
Message-ID: <20261103145306.487255-23-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/node/ip4_lookup.c         |  4 ++--
 lib/node/ip4_lookup_fib.c     | 10 +++++-----
 lib/node/ip6_lookup.c         |  4 ++--
 lib/node/ip6_lookup_fib.c     | 10 +++++-----
 lib/node/kernel_rx.c          |  4 ++--
 lib/node/node_mbuf_dynfield.c |  2 +-
 lib/node/udp4_input.c         |  4 ++--
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
index 42db993142..d3a1a59f7b 100644
--- a/lib/node/ip4_lookup.c
+++ b/lib/node/ip4_lookup.c
@@ -194,7 +194,7 @@ ip4_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)
 		/* Setup LPM tables for all sockets */
 		RTE_LCORE_FOREACH(lcore_id)
 		{
-			socket = rte_lcore_to_socket_id(lcore_id);
+			socket = rte_lcore_to_numa_id(lcore_id);
 			rc = setup_lpm(&ip4_lookup_nm, socket);
 			if (rc) {
 				node_err("ip4_lookup",
@@ -207,7 +207,7 @@ ip4_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)
 	}
 
 	/* Update socket's LPM and mbuf dyn priv1 offset in node ctx */
-	IP4_LOOKUP_NODE_LPM(node->ctx) = ip4_lookup_nm.lpm_tbl[graph->socket];
+	IP4_LOOKUP_NODE_LPM(node->ctx) = ip4_lookup_nm.lpm_tbl[graph->numa_id];
 	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) = dyn;
 
 #if defined(__ARM_NEON) || defined(RTE_ARCH_X86) || \
diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 0857d889fc..7ff190abb7 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -225,7 +225,7 @@ rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
 	uint32_t val;
 	int ret;
 
-	nb_sockets = rte_socket_count();
+	nb_sockets = rte_numa_count();
 	in.s_addr = htonl(ip);
 	inet_ntop(AF_INET, &in, abuf, sizeof(abuf));
 	/* Embedded next node id into 24 bit next hop */
@@ -288,15 +288,15 @@ ip4_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)
 		return -rte_errno;
 	}
 
-	rc = setup_fib(graph->socket);
+	rc = setup_fib(graph->numa_id);
 	if (rc) {
-		node_err("ip4_lookup_fib", "Failed to setup fib for sock %u, rc=%d",
-				graph->socket, rc);
+		node_err("ip4_lookup_fib", "Failed to setup fib for numa %u, rc=%d",
+				graph->numa_id, rc);
 		return rc;
 	}
 
 	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
-	IP4_LOOKUP_NODE_FIB(node->ctx) = ip4_lookup_fib_nm.fib[graph->socket];
+	IP4_LOOKUP_NODE_FIB(node->ctx) = ip4_lookup_fib_nm.fib[graph->numa_id];
 	IP4_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = dyn;
 
 	node_dbg("ip4_lookup_fib", "Initialized ip4_lookup_fib node");
diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
index 83c0500c76..934488c5e7 100644
--- a/lib/node/ip6_lookup.c
+++ b/lib/node/ip6_lookup.c
@@ -331,7 +331,7 @@ ip6_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)
 		/* Setup LPM tables for all sockets */
 		RTE_LCORE_FOREACH(lcore_id)
 		{
-			socket = rte_lcore_to_socket_id(lcore_id);
+			socket = rte_lcore_to_numa_id(lcore_id);
 			rc = setup_lpm6(&ip6_lookup_nm, socket);
 			if (rc) {
 				node_err("ip6_lookup",
@@ -344,7 +344,7 @@ ip6_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)
 	}
 
 	/* Update socket's LPM and mbuf dyn priv1 offset in node ctx */
-	IP6_LOOKUP_NODE_LPM(node->ctx) = ip6_lookup_nm.lpm_tbl[graph->socket];
+	IP6_LOOKUP_NODE_LPM(node->ctx) = ip6_lookup_nm.lpm_tbl[graph->numa_id];
 	IP6_LOOKUP_NODE_PRIV1_OFF(node->ctx) = dyn;
 
 	node_dbg("ip6_lookup", "Initialized ip6_lookup node");
diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 40c5c753df..a471081d29 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -218,7 +218,7 @@ rte_node_ip6_fib_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16
 	uint32_t val;
 	int ret;
 
-	nb_sockets = rte_socket_count();
+	nb_sockets = rte_numa_count();
 	inet_ntop(AF_INET6, ip, abuf, sizeof(abuf));
 	/* Embedded next node id into 24 bit next hop */
 	val = ((next_node << 16) | next_hop) & ((1ull << 24) - 1);
@@ -279,15 +279,15 @@ ip6_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)
 		return -rte_errno;
 	}
 
-	rc = setup_fib6(graph->socket);
+	rc = setup_fib6(graph->numa_id);
 	if (rc) {
-		node_err("ip6_lookup_fib", "Failed to setup fib6 for sock %u, rc=%d",
-				graph->socket, rc);
+		node_err("ip6_lookup_fib", "Failed to setup fib6 for numa %u, rc=%d",
+				graph->numa_id, rc);
 		return rc;
 	}
 
 	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
-	IP6_LOOKUP_FIB_NODE(node->ctx) = ip6_lookup_fib_nm.fib6[graph->socket];
+	IP6_LOOKUP_FIB_NODE(node->ctx) = ip6_lookup_fib_nm.fib6[graph->numa_id];
 	IP6_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = dyn;
 
 	node_dbg("ip6_lookup_fib", "Initialized ip6_lookup_fib node");
diff --git a/lib/node/kernel_rx.c b/lib/node/kernel_rx.c
index 461330414f..5dff10139c 100644
--- a/lib/node/kernel_rx.c
+++ b/lib/node/kernel_rx.c
@@ -211,8 +211,8 @@ kernel_rx_node_init(const struct rte_graph *graph, struct rte_node *node)
 		return -EINVAL;
 	}
 
-	recv_info = rte_zmalloc_socket("kernel_rx_info", sizeof(kernel_rx_info_t),
-				       RTE_CACHE_LINE_SIZE, graph->socket);
+	recv_info = rte_zmalloc_numa("kernel_rx_info", sizeof(kernel_rx_info_t),
+				       RTE_CACHE_LINE_SIZE, graph->numa_id);
 	if (!recv_info) {
 		node_err("kernel_rx", "Kernel recv_info is NULL");
 		return -ENOMEM;
diff --git a/lib/node/node_mbuf_dynfield.c b/lib/node/node_mbuf_dynfield.c
index 9dbc80f7e5..74229c9b9c 100644
--- a/lib/node/node_mbuf_dynfield.c
+++ b/lib/node/node_mbuf_dynfield.c
@@ -36,7 +36,7 @@ int rte_node_mbuf_dynfield_register(void)
 	if (!mz) {
 		mz = rte_memzone_reserve_aligned(NODE_MBUF_DYNFIELD_MEMZONE_NAME,
 						 sizeof(struct node_mbuf_dynfield_mz),
-						 SOCKET_ID_ANY, 0,
+						 RTE_NUMA_ID_ANY, 0,
 						 RTE_CACHE_LINE_SIZE);
 		if (!mz) {
 			node_err("node_mbuf_dyn", "rte_memzone_reserve_aligned failed");
diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 47aad42022..175bfa290d 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -132,7 +132,7 @@ udp4_input_node_init(const struct rte_graph *graph, struct rte_node *node)
 		/* Setup HASH tables for all sockets */
 		RTE_LCORE_FOREACH(lcore_id)
 		{
-			socket = rte_lcore_to_socket_id(lcore_id);
+			socket = rte_lcore_to_numa_id(lcore_id);
 			rc = setup_udp4_dstprt_hash(&udp4_input_nm, socket);
 			if (rc) {
 				node_err("udp4_lookup",
@@ -144,7 +144,7 @@ udp4_input_node_init(const struct rte_graph *graph, struct rte_node *node)
 		init_once = 1;
 	}
 
-	UDP4_INPUT_NODE_HASH(node->ctx) = udp4_input_nm.hash_tbl[graph->socket];
+	UDP4_INPUT_NODE_HASH(node->ctx) = udp4_input_nm.hash_tbl[graph->numa_id];
 
 	node_dbg("udp4_input", "Initialized udp4_input node");
 	return 0;
-- 
2.55.0


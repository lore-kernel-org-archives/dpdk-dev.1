Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E928606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KY7fhMUx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEAA44334F;
	Tue,  3 Nov 2026 16:29:00 +0100 (CET)
Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F7644332A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:29:00 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=+cG7kI5L4v4IGjkK53GH+m9467jZLgBpQ1iY+lamflY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719739; v=1; x=1794324539;
 b=KY7fhMUxenDXWU5I0HtLuoI2wZMihrLKwsIDekCaZyxQzZslrR4OzeJaDMqqa7Zq59UCd3Yk
 Wj3DkfbcY4bURVvcqBvgf8tdYsskUpfP5Yw7FNpkGvKbhDOHGa+3opJ8urMabMZrC/uwwArjAqs
 uTBPawMXcQ806zuKoWsR78bI=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id db8977560707c35f;
 Tue, 03 Nov 2026 15:28:59 +0000
X-Mizu-Trace-ID: db8977560707c35f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 227/227] examples: fix NUMA node terminology residue
Date: Tue,  3 Nov 2026 22:53:05 +0800
Message-ID: <20261103145306.487255-228-chengwen.feng@linux.dev>
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

Migrate the socket terminology usages that were merged back
from the main tree during the rc1 to rc2 window.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 examples/ipsec-secgw/ipsec-secgw.h                 |  2 +-
 examples/ipsec-secgw/ipsec.h                       |  2 +-
 examples/l3fwd-graph/main.c                        | 10 +++++-----
 examples/l3fwd-power/main.c                        | 14 +++++++-------
 examples/l3fwd/l3fwd.h                             |  2 +-
 examples/l3fwd/l3fwd_acl.c                         |  8 ++++----
 examples/l3fwd/l3fwd_em.c                          |  4 ++--
 examples/l3fwd/l3fwd_event.h                       |  2 +-
 examples/l3fwd/l3fwd_fib.c                         |  4 ++--
 examples/l3fwd/l3fwd_lpm.c                         |  4 ++--
 examples/l3fwd/main.c                              |  8 ++++----
 .../client_server_mp/mp_server/init.c              |  2 +-
 examples/vhost_crypto/main.c                       | 10 +++++-----
 13 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/examples/ipsec-secgw/ipsec-secgw.h b/examples/ipsec-secgw/ipsec-secgw.h
index b4ef4b6d04..bdef95cb6d 100644
--- a/examples/ipsec-secgw/ipsec-secgw.h
+++ b/examples/ipsec-secgw/ipsec-secgw.h
@@ -9,7 +9,7 @@
 
 #define MAX_RX_QUEUE_PER_LCORE 16
 
-#define NB_SOCKETS 4
+#define NB_NUMAS 4
 
 #define MAX_PKT_BURST 32
 #define MAX_PKT_BURST_VEC 256
diff --git a/examples/ipsec-secgw/ipsec.h b/examples/ipsec-secgw/ipsec.h
index bdd607fbdd..59179e9591 100644
--- a/examples/ipsec-secgw/ipsec.h
+++ b/examples/ipsec-secgw/ipsec.h
@@ -310,7 +310,7 @@ struct __rte_cache_aligned lcore_conf {
 extern struct lcore_conf lcore_conf[RTE_MAX_LCORE];
 
 /* Socket ctx */
-extern struct socket_ctx socket_ctx[NB_SOCKETS];
+extern struct socket_ctx socket_ctx[NB_NUMAS];
 
 void
 ipsec_poll_mode_worker(void);
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index fc1603781c..b327216a95 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -55,7 +55,7 @@
 
 #define MAX_LCORE_PARAMS 1024
 
-#define NB_SOCKETS 8
+#define NB_NUMAS 8
 
 /* Graph module */
 #define WORKER_MODEL_RTC "rtc"
@@ -139,7 +139,7 @@ static struct rte_eth_conf port_conf = {
 
 static uint32_t max_pkt_len;
 
-static struct rte_mempool *pktmbuf_pool[RTE_MAX_ETHPORTS][NB_SOCKETS];
+static struct rte_mempool *pktmbuf_pool[RTE_MAX_ETHPORTS][NB_NUMAS];
 
 static struct rte_node_ethdev_config ethdev_conf[RTE_MAX_ETHPORTS];
 
@@ -657,10 +657,10 @@ init_mem(uint16_t portid, uint32_t nb_mbuf)
 		else
 			socketid = 0;
 
-		if (socketid >= NB_SOCKETS) {
+		if (socketid >= NB_NUMAS) {
 			rte_exit(EXIT_FAILURE,
 				 "Socket %d of lcore %u is out of range %d\n",
-				 socketid, lcore_id, NB_SOCKETS);
+				 socketid, lcore_id, NB_NUMAS);
 		}
 
 		if (pktmbuf_pool[portid][socketid] == NULL) {
@@ -1184,7 +1184,7 @@ main(int argc, char **argv)
 
 		else
 			ethdev_conf[nb_conf].mp = pktmbuf_pool[portid];
-		ethdev_conf[nb_conf].mp_count = NB_SOCKETS;
+		ethdev_conf[nb_conf].mp_count = NB_NUMAS;
 
 		nb_conf++;
 		printf("\n");
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 4017722122..9e2689bcbf 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -114,7 +114,7 @@ RTE_LOG_REGISTER(l3fwd_power_logtype, l3fwd.power, INFO);
 
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
-#define NB_SOCKETS 8
+#define NB_NUMAS 8
 
 /* Configure how many packets ahead to prefetch, when reading packets */
 #define PREFETCH_OFFSET	3
@@ -271,7 +271,7 @@ static uint32_t scale_freq_max;
 static int cpu_resume_latency = -1;
 static int resume_latency_bk[RTE_MAX_LCORE];
 
-static struct rte_mempool * pktmbuf_pool[NB_SOCKETS];
+static struct rte_mempool *pktmbuf_pool[NB_NUMAS];
 
 
 #if (APP_LOOKUP_METHOD == APP_LOOKUP_EXACT_MATCH)
@@ -330,8 +330,8 @@ static struct ipv6_l3fwd_route ipv6_l3fwd_route_array[] = {
 };
 
 typedef struct rte_hash lookup_struct_t;
-static lookup_struct_t *ipv4_l3fwd_lookup_struct[NB_SOCKETS];
-static lookup_struct_t *ipv6_l3fwd_lookup_struct[NB_SOCKETS];
+static lookup_struct_t *ipv4_l3fwd_lookup_struct[NB_NUMAS];
+static lookup_struct_t *ipv6_l3fwd_lookup_struct[NB_NUMAS];
 
 #define L3FWD_HASH_ENTRIES	1024
 
@@ -360,7 +360,7 @@ static struct ipv4_l3fwd_route ipv4_l3fwd_route_array[] = {
 #define IPV4_L3FWD_LPM_MAX_RULES     1024
 
 typedef struct rte_lpm lookup_struct_t;
-static lookup_struct_t *ipv4_l3fwd_lookup_struct[NB_SOCKETS];
+static lookup_struct_t *ipv4_l3fwd_lookup_struct[NB_NUMAS];
 #endif
 
 struct __rte_cache_aligned lcore_conf {
@@ -2050,10 +2050,10 @@ init_mem(unsigned nb_mbuf)
 		else
 			socketid = 0;
 
-		if (socketid >= NB_SOCKETS) {
+		if (socketid >= NB_NUMAS) {
 			rte_exit(EXIT_FAILURE, "Socket %d of lcore %u is "
 					"out of range %d\n", socketid,
-						lcore_id, NB_SOCKETS);
+						lcore_id, NB_NUMAS);
 		}
 		if (pktmbuf_pool[socketid] == NULL) {
 			snprintf(s, sizeof(s), "mbuf_pool_%d", socketid);
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..10beefdd4b 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -33,7 +33,7 @@
 #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
 #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
 
-#define NB_SOCKETS        8
+#define NB_NUMAS        8
 
 /* Configure how many packets ahead to prefetch, when reading packets */
 #define PREFETCH_OFFSET	  3
diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
index 54aa3dc9ba..2518ba6a15 100644
--- a/examples/l3fwd/l3fwd_acl.c
+++ b/examples/l3fwd/l3fwd_acl.c
@@ -240,8 +240,8 @@ RTE_ACL_RULE_DEF(acl4_rule, RTE_DIM(ipv4_defs));
 RTE_ACL_RULE_DEF(acl6_rule, RTE_DIM(ipv6_defs));
 
 static struct {
-	struct rte_acl_ctx *acx_ipv4[NB_SOCKETS];
-	struct rte_acl_ctx *acx_ipv6[NB_SOCKETS];
+	struct rte_acl_ctx *acx_ipv4[NB_NUMAS];
+	struct rte_acl_ctx *acx_ipv6[NB_NUMAS];
 #ifdef L3FWDACL_DEBUG
 	struct acl4_rule *rule_ipv4;
 	struct acl6_rule *rule_ipv6;
@@ -955,10 +955,10 @@ setup_acl(const int numa_id)
 	dump_ipv6_rules((struct acl6_rule *)acl_base_ipv6, acl_num_ipv6, 1);
 
 	/* Check sockets a context should be created on */
-	if (numa_id >= NB_SOCKETS) {
+	if (numa_id >= NB_NUMAS) {
 		acl_log("Socket %d is out "
 			"of range %d\n",
-			numa_id, NB_SOCKETS);
+			numa_id, NB_NUMAS);
 		acl_free_routes();
 		return;
 	}
diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index 730ea29d96..2e20bc3078 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -132,8 +132,8 @@ const struct ipv6_l3fwd_em_route ipv6_l3fwd_em_route_array[] = {
 	  {32, 1, 2, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1}, 9, 9, IPPROTO_UDP}, 15},
 };
 
-struct rte_hash *ipv4_l3fwd_em_lookup_struct[NB_SOCKETS];
-struct rte_hash *ipv6_l3fwd_em_lookup_struct[NB_SOCKETS];
+struct rte_hash *ipv4_l3fwd_em_lookup_struct[NB_NUMAS];
+struct rte_hash *ipv6_l3fwd_em_lookup_struct[NB_NUMAS];
 
 static inline uint32_t
 ipv4_hash_crc(const void *data, __rte_unused uint32_t data_len,
diff --git a/examples/l3fwd/l3fwd_event.h b/examples/l3fwd/l3fwd_event.h
index c6a4a89127..108cc86d9b 100644
--- a/examples/l3fwd/l3fwd_event.h
+++ b/examples/l3fwd/l3fwd_event.h
@@ -66,7 +66,7 @@ struct l3fwd_event_resources {
 	struct l3fwd_event_tx_adptr tx_adptr;
 	uint8_t disable_implicit_release;
 	struct l3fwd_event_setup_ops ops;
-	struct rte_mempool * (*pkt_pool)[NB_SOCKETS];
+	struct rte_mempool * (*pkt_pool)[NB_NUMAS];
 	struct rte_mempool **vec_pool;
 	struct l3fwd_event_queues evq;
 	struct l3fwd_event_ports evp;
diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
index 4fc6bf90d5..e937bf8fcd 100644
--- a/examples/l3fwd/l3fwd_fib.c
+++ b/examples/l3fwd/l3fwd_fib.c
@@ -39,8 +39,8 @@
 #define FIB_SEND_MULTI
 #endif
 
-static struct rte_fib *ipv4_l3fwd_fib_lookup_struct[NB_SOCKETS];
-static struct rte_fib6 *ipv6_l3fwd_fib_lookup_struct[NB_SOCKETS];
+static struct rte_fib *ipv4_l3fwd_fib_lookup_struct[NB_NUMAS];
+static struct rte_fib6 *ipv6_l3fwd_fib_lookup_struct[NB_NUMAS];
 
 /* Parse packet type and ip address. */
 static inline void
diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
index 2d2651e750..74180f1810 100644
--- a/examples/l3fwd/l3fwd_lpm.c
+++ b/examples/l3fwd/l3fwd_lpm.c
@@ -38,8 +38,8 @@
 #define IPV6_L3FWD_LPM_MAX_RULES         1024
 #define IPV6_L3FWD_LPM_NUMBER_TBL8S (1 << 16)
 
-static struct rte_lpm *ipv4_l3fwd_lpm_lookup_struct[NB_SOCKETS];
-static struct rte_lpm6 *ipv6_l3fwd_lpm_lookup_struct[NB_SOCKETS];
+static struct rte_lpm *ipv4_l3fwd_lpm_lookup_struct[NB_NUMAS];
+static struct rte_lpm6 *ipv6_l3fwd_lpm_lookup_struct[NB_NUMAS];
 
 /* Performing LPM-based lookups. 8< */
 static inline uint16_t
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 1731aa51e2..9647f5bf74 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -143,8 +143,8 @@ uint32_t max_pkt_len;
 #ifdef RTE_LIB_EVENTDEV
 static struct rte_mempool *vector_pool[RTE_MAX_ETHPORTS];
 #endif
-static struct rte_mempool *pktmbuf_pool[RTE_MAX_ETHPORTS][NB_SOCKETS];
-static uint8_t lkp_per_socket[NB_SOCKETS];
+static struct rte_mempool *pktmbuf_pool[RTE_MAX_ETHPORTS][NB_NUMAS];
+static uint8_t lkp_per_socket[NB_NUMAS];
 
 struct l3fwd_lkp_mode {
 	void  (*read_config_files)(void);
@@ -1137,10 +1137,10 @@ init_mem(uint16_t portid, unsigned int nb_mbuf)
 		else
 			socketid = 0;
 
-		if (socketid >= NB_SOCKETS) {
+		if (socketid >= NB_NUMAS) {
 			rte_exit(EXIT_FAILURE,
 				"Socket %d of lcore %u is out of range %d\n",
-				socketid, lcore_id, NB_SOCKETS);
+				socketid, lcore_id, NB_NUMAS);
 		}
 
 		if (pktmbuf_pool[portid][socketid] == NULL) {
diff --git a/examples/multi_process/client_server_mp/mp_server/init.c b/examples/multi_process/client_server_mp/mp_server/init.c
index ed00540bdb..08816434f1 100644
--- a/examples/multi_process/client_server_mp/mp_server/init.c
+++ b/examples/multi_process/client_server_mp/mp_server/init.c
@@ -160,7 +160,7 @@ static int
 init_shm_rings(void)
 {
 	unsigned i;
-unsigned int numa_id
+	unsigned int numa_id;
 	const char * q_name;
 	const unsigned ringsize = CLIENT_QUEUE_RINGSIZE;
 
diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 7f28d507f1..f4d6a67323 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -31,26 +31,26 @@
 #define SESSION_MAP_ENTRIES		(1024)
 #define REFRESH_TIME_SEC		(3)
 
-#define MAX_NB_SOCKETS			(4)
+#define MAX_NB_NUMAS			(4)
 #define MAX_NB_WORKER_CORES		(16)
 
 struct lcore_option {
 	uint32_t lcore_id;
-	char *socket_files[MAX_NB_SOCKETS];
+	char *socket_files[MAX_NB_NUMAS];
 	uint32_t nb_sockets;
 	uint8_t cid;
 	uint16_t qid;
 };
 
 struct __rte_cache_aligned vhost_crypto_info {
-	int vids[MAX_NB_SOCKETS];
+	int vids[MAX_NB_NUMAS];
 	uint32_t nb_vids;
 	struct rte_mempool *sess_pool;
 	struct rte_mempool *cop_pool;
 	uint8_t cid;
 	uint32_t qid;
 	uint32_t nb_inflight_ops;
-	volatile uint32_t initialized[MAX_NB_SOCKETS];
+	volatile uint32_t initialized[MAX_NB_NUMAS];
 };
 
 struct vhost_crypto_options {
@@ -123,7 +123,7 @@ parse_socket_arg(char *arg)
 
 	nb_sockets = lo->nb_sockets;
 
-	if (nb_sockets >= MAX_NB_SOCKETS) {
+	if (nb_sockets >= MAX_NB_NUMAS) {
 		RTE_LOG(ERR, USER1, "Too many socket files!\n");
 		return -ENOMEM;
 	}
-- 
2.55.0


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91D606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DIUlBfDX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24F4B4329C;
	Tue,  3 Nov 2026 16:25:19 +0100 (CET)
Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
 by mails.dpdk.org (Postfix) with ESMTPS id EEDCB4325B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:25:17 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=1QAlxbbzm6pKbou+IsOqFXNp+VnnSHWIchqvopbLg9M=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719517; v=1; x=1794324317;
 b=DIUlBfDXuf0vpN2QNGcbnZP9SdVdZI8M/GimicLu+AGAoavmXwXirLinCi1Xk9541XBIvb6+
 0LK0Rut7D1Zeev59OKy07nO8z/ddvbI2KFloDFHpAz21Iypiapql7GyzdCr4K80MsB3dZCIbGVq
 MnoHAUWIjnkrZE1ivARREAyA=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 6249f6f209946a50;
 Tue, 03 Nov 2026 15:25:17 +0000
X-Mizu-Trace-ID: 6249f6f209946a50
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 203/227] examples/l3fwd: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:41 +0800
Message-ID: <20261103145306.487255-204-chengwen.feng@linux.dev>
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
 examples/l3fwd/l3fwd_acl.c | 22 +++++++++++-----------
 examples/l3fwd/l3fwd_em.c  |  4 ++--
 examples/l3fwd/main.c      |  8 ++++----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
index 4ee3411d2a..54aa3dc9ba 100644
--- a/examples/l3fwd/l3fwd_acl.c
+++ b/examples/l3fwd/l3fwd_acl.c
@@ -692,7 +692,7 @@ app_acl_init(struct rte_acl_rule *route_base,
 			socketid);
 
 	acl_param.name = name;
-	acl_param.socket_id = socketid;
+	acl_param.numa_id = socketid;
 	acl_param.rule_size = RTE_ACL_RULE_SZ(dim);
 	acl_param.max_rule_num = MAX_ACL_RULE_NUM;
 
@@ -935,7 +935,7 @@ dump_ipv6_rules(struct acl6_rule *rule, int num, int extra)
 
 /* Function to setup acl. */
 void
-setup_acl(const int socket_id)
+setup_acl(const int numa_id)
 {
 	if (check_acl_config() != 0)
 		rte_exit(EXIT_FAILURE, "Failed to get valid ACL options\n");
@@ -955,24 +955,24 @@ setup_acl(const int socket_id)
 	dump_ipv6_rules((struct acl6_rule *)acl_base_ipv6, acl_num_ipv6, 1);
 
 	/* Check sockets a context should be created on */
-	if (socket_id >= NB_SOCKETS) {
+	if (numa_id >= NB_SOCKETS) {
 		acl_log("Socket %d is out "
 			"of range %d\n",
-			socket_id, NB_SOCKETS);
+			numa_id, NB_SOCKETS);
 		acl_free_routes();
 		return;
 	}
 
-	rte_acl_free(acl_config.acx_ipv4[socket_id]);
-	rte_acl_free(acl_config.acx_ipv6[socket_id]);
+	rte_acl_free(acl_config.acx_ipv4[numa_id]);
+	rte_acl_free(acl_config.acx_ipv6[numa_id]);
 
-	acl_config.acx_ipv4[socket_id] = app_acl_init(route_base_ipv4,
+	acl_config.acx_ipv4[numa_id] = app_acl_init(route_base_ipv4,
 		acl_base_ipv4, route_num_ipv4, acl_num_ipv4,
-		0, socket_id);
+		0, numa_id);
 
-	acl_config.acx_ipv6[socket_id] = app_acl_init(route_base_ipv6,
+	acl_config.acx_ipv6[numa_id] = app_acl_init(route_base_ipv6,
 		acl_base_ipv6, route_num_ipv6, acl_num_ipv6,
-		1, socket_id);
+		1, numa_id);
 
 #ifdef L3FWDACL_DEBUG
 	acl_config.rule_ipv4 = (struct acl4_rule *)acl_base_ipv4;
@@ -1091,7 +1091,7 @@ acl_main_loop(__rte_unused void *dummy)
 	prev_tsc = 0;
 	lcore_id = rte_lcore_id();
 	qconf = &lcore_conf[lcore_id];
-	socketid = rte_lcore_to_socket_id(lcore_id);
+	socketid = rte_lcore_to_numa_id(lcore_id);
 
 	if (qconf->n_rx_queue == 0) {
 		RTE_LOG(INFO, L3FWD, "lcore %u has nothing to do\n", lcore_id);
diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index d8748a0edd..730ea29d96 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -991,7 +991,7 @@ setup_hash(const int socketid)
 	/* create ipv4 hash */
 	snprintf(s, sizeof(s), "ipv4_l3fwd_hash_%d", socketid);
 	ipv4_l3fwd_hash_params.name = s;
-	ipv4_l3fwd_hash_params.socket_id = socketid;
+	ipv4_l3fwd_hash_params.numa_id = socketid;
 	ipv4_l3fwd_em_lookup_struct[socketid] =
 		rte_hash_create(&ipv4_l3fwd_hash_params);
 	if (ipv4_l3fwd_em_lookup_struct[socketid] == NULL)
@@ -1002,7 +1002,7 @@ setup_hash(const int socketid)
 	/* create ipv6 hash */
 	snprintf(s, sizeof(s), "ipv6_l3fwd_hash_%d", socketid);
 	ipv6_l3fwd_hash_params.name = s;
-	ipv6_l3fwd_hash_params.socket_id = socketid;
+	ipv6_l3fwd_hash_params.numa_id = socketid;
 	ipv6_l3fwd_em_lookup_struct[socketid] =
 		rte_hash_create(&ipv6_l3fwd_hash_params);
 	if (ipv6_l3fwd_em_lookup_struct[socketid] == NULL)
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 9532150a47..1731aa51e2 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -311,7 +311,7 @@ check_lcore_params(void)
 			return -1;
 		}
 
-		socketid = rte_lcore_to_socket_id(lcore);
+		socketid = rte_lcore_to_numa_id(lcore);
 		if (socketid != 0 && numa_on == 0) {
 			printf("warning: lcore %u is on socket %d with numa off\n",
 				lcore, socketid);
@@ -1133,7 +1133,7 @@ init_mem(uint16_t portid, unsigned int nb_mbuf)
 			continue;
 
 		if (numa_on)
-			socketid = rte_lcore_to_socket_id(lcore_id);
+			socketid = rte_lcore_to_numa_id(lcore_id);
 		else
 			socketid = 0;
 
@@ -1474,7 +1474,7 @@ l3fwd_poll_resource_setup(void)
 
 			if (numa_on)
 				socketid =
-				(uint8_t)rte_lcore_to_socket_id(lcore_id);
+				(uint8_t)rte_lcore_to_numa_id(lcore_id);
 			else
 				socketid = 0;
 
@@ -1516,7 +1516,7 @@ l3fwd_poll_resource_setup(void)
 
 			if (numa_on)
 				socketid =
-				(uint8_t)rte_lcore_to_socket_id(lcore_id);
+				(uint8_t)rte_lcore_to_numa_id(lcore_id);
 			else
 				socketid = 0;
 
-- 
2.55.0


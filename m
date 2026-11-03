Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5E606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lWmnqG82
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4800432AA;
	Tue,  3 Nov 2026 16:25:42 +0100 (CET)
Received: from mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
 by mails.dpdk.org (Postfix) with ESMTPS id B636943291
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:25:41 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=9eSmKTYNLjqtw1czfWQUQPGLlyW/5iKUFWQmsxPNkCI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719541; v=1; x=1794324341;
 b=lWmnqG82l083QJ8ZV570G6iNhQlwnqyokyQ067WB+3JsM5w15xfLC6YXZ8Ao1b3N17jbidXC
 muE98wX0f9gGTsfKNIvFw1fI42Kh0W5lzYCrKsVwBdSTOeIrzYCdjNv3IvxqRPKP7pG/yhQpFD8
 KOvVkV3R0EgWoOH9g6our4N8=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 4479c552e7c087c0;
 Tue, 03 Nov 2026 15:25:41 +0000
X-Mizu-Trace-ID: 4479c552e7c087c0
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 205/227] examples/l3fwd-power: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:43 +0800
Message-ID: <20261103145306.487255-206-chengwen.feng@linux.dev>
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
 examples/l3fwd-power/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 5b4cb9f210..4017722122 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -1414,7 +1414,7 @@ check_lcore_params(void)
 							"mask\n", lcore);
 			return -1;
 		}
-		socketid = rte_lcore_to_socket_id(lcore);
+		socketid = rte_lcore_to_numa_id(lcore);
 		if (socketid != 0 && numa_on == 0) {
 			printf("warning: lcore %u is on socket %d with numa "
 						"off\n", lcore, socketid);
@@ -1944,7 +1944,7 @@ setup_hash(int socketid)
 	/* create ipv4 hash */
 	snprintf(s, sizeof(s), "ipv4_l3fwd_hash_%d", socketid);
 	ipv4_l3fwd_hash_params.name = s;
-	ipv4_l3fwd_hash_params.socket_id = socketid;
+	ipv4_l3fwd_hash_params.numa_id = socketid;
 	ipv4_l3fwd_lookup_struct[socketid] =
 		rte_hash_create(&ipv4_l3fwd_hash_params);
 	if (ipv4_l3fwd_lookup_struct[socketid] == NULL)
@@ -1954,7 +1954,7 @@ setup_hash(int socketid)
 	/* create ipv6 hash */
 	snprintf(s, sizeof(s), "ipv6_l3fwd_hash_%d", socketid);
 	ipv6_l3fwd_hash_params.name = s;
-	ipv6_l3fwd_hash_params.socket_id = socketid;
+	ipv6_l3fwd_hash_params.numa_id = socketid;
 	ipv6_l3fwd_lookup_struct[socketid] =
 		rte_hash_create(&ipv6_l3fwd_hash_params);
 	if (ipv6_l3fwd_lookup_struct[socketid] == NULL)
@@ -2046,7 +2046,7 @@ init_mem(unsigned nb_mbuf)
 			continue;
 
 		if (numa_on)
-			socketid = rte_lcore_to_socket_id(lcore_id);
+			socketid = rte_lcore_to_numa_id(lcore_id);
 		else
 			socketid = 0;
 
@@ -2738,9 +2738,9 @@ main(int argc, char **argv)
 
 			/* Initialize TX buffers */
 			qconf = &lcore_conf[lcore_id];
-			qconf->tx_buffer[portid] = rte_zmalloc_socket("tx_buffer",
+			qconf->tx_buffer[portid] = rte_zmalloc_numa("tx_buffer",
 				RTE_ETH_TX_BUFFER_SIZE(MAX_PKT_BURST), 0,
-				rte_eth_dev_socket_id(portid));
+				rte_eth_dev_numa_id(portid));
 			if (qconf->tx_buffer[portid] == NULL)
 				rte_exit(EXIT_FAILURE, "Can't allocate tx buffer for port %u\n",
 						 portid);
@@ -2759,7 +2759,7 @@ main(int argc, char **argv)
 
 			if (numa_on)
 				socketid = \
-				(uint8_t)rte_lcore_to_socket_id(lcore_id);
+				(uint8_t)rte_lcore_to_numa_id(lcore_id);
 			else
 				socketid = 0;
 
@@ -2811,7 +2811,7 @@ main(int argc, char **argv)
 
 			if (numa_on)
 				socketid = \
-				(uint8_t)rte_lcore_to_socket_id(lcore_id);
+				(uint8_t)rte_lcore_to_numa_id(lcore_id);
 			else
 				socketid = 0;
 
@@ -2918,7 +2918,7 @@ main(int argc, char **argv)
 		unsigned int i;
 
 		/* Init metrics library */
-		rte_metrics_init(rte_socket_id());
+		rte_metrics_init(rte_numa_id());
 		/** Register stats with metrics library */
 		for (i = 0; i < NUM_TELSTATS; i++)
 			ptr_strings[i] = telstats_strings[i].name;
-- 
2.55.0


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F1606A32D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f0t3niNX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB55543293;
	Tue,  3 Nov 2026 16:25:32 +0100 (CET)
Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
 by mails.dpdk.org (Postfix) with ESMTPS id 6749F43291
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:25:31 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=SzXHlR2jP+xk+frbuqEmYHlROCQn8nOpHskeu/HWIR4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719531; v=1; x=1794324331;
 b=f0t3niNXVB+US+hL16r5k308yYnbtAM/bItRLz2a8flt9v/a/6GC2xJAMrihQF+ck2dMR0O3
 93+Y0leCwX2oa9wURavNRaHVadc5007PnoQaz0KtpzY4ROlmZxwbJ4oetO5EWfnGUWL+Gpa0W9y
 B8UUmfr+jvm+DXfNVLbE3rs8=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 1b49ade8bc6d96a5;
 Tue, 03 Nov 2026 15:25:22 +0000
X-Mizu-Trace-ID: 1b49ade8bc6d96a5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 204/227] examples/l3fwd-graph: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:42 +0800
Message-ID: <20261103145306.487255-205-chengwen.feng@linux.dev>
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
 examples/l3fwd-graph/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 08fe177fc2..fc1603781c 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -218,7 +218,7 @@ check_lcore_params(void)
 			printf("Error: lcore %u is main lcore\n", lcore);
 			return -1;
 		}
-		socketid = rte_lcore_to_socket_id(lcore);
+		socketid = rte_lcore_to_numa_id(lcore);
 		if ((socketid != 0) && (numa_on == 0)) {
 			printf("Warning: lcore %u is on socket %d with numa off\n",
 			       lcore, socketid);
@@ -653,7 +653,7 @@ init_mem(uint16_t portid, uint32_t nb_mbuf)
 			continue;
 
 		if (numa_on)
-			socketid = rte_lcore_to_socket_id(lcore_id);
+			socketid = rte_lcore_to_numa_id(lcore_id);
 		else
 			socketid = 0;
 
@@ -769,7 +769,7 @@ print_stats(void)
 	/* Prepare stats object */
 	memset(&s_param, 0, sizeof(s_param));
 	s_param.f = stdout;
-	s_param.socket_id = SOCKET_ID_ANY;
+	s_param.numa_id = RTE_NUMA_ID_ANY;
 	s_param.graph_patterns = &pattern;
 	s_param.nb_graph_patterns = 1;
 
@@ -889,7 +889,7 @@ graph_config_mcore_dispatch(struct rte_graph_param graph_conf)
 	}
 
 	graph_conf.nb_node_patterns = nb_patterns + n_rx_node;
-	graph_conf.socket_id = rte_lcore_to_socket_id(main_lcore_id);
+	graph_conf.numa_id = rte_lcore_to_numa_id(main_lcore_id);
 
 	qconf = &lcore_conf[main_lcore_id];
 	snprintf(qconf->name, sizeof(qconf->name), "worker_%u",
@@ -972,7 +972,7 @@ graph_config_rtc(struct rte_graph_param graph_conf)
 				qconf->rx_queue_list[i].node_name;
 		}
 		graph_conf.nb_node_patterns = nb_patterns + i;
-		graph_conf.socket_id = rte_lcore_to_socket_id(lcore_id);
+		graph_conf.numa_id = rte_lcore_to_numa_id(lcore_id);
 		snprintf(qconf->name, sizeof(qconf->name), "worker_%u",
 			 lcore_id);
 		graph_id = rte_graph_create(qconf->name, &graph_conf);
@@ -1155,7 +1155,7 @@ main(int argc, char **argv)
 			qconf = &lcore_conf[lcore_id];
 
 			if (numa_on)
-				socketid = (uint8_t)rte_lcore_to_socket_id(
+				socketid = (uint8_t)rte_lcore_to_numa_id(
 					lcore_id);
 			else
 				socketid = 0;
@@ -1204,7 +1204,7 @@ main(int argc, char **argv)
 			queueid = qconf->rx_queue_list[queue].queue_id;
 
 			if (numa_on)
-				socketid = (uint8_t)rte_lcore_to_socket_id(
+				socketid = (uint8_t)rte_lcore_to_numa_id(
 					lcore_id);
 			else
 				socketid = 0;
-- 
2.55.0


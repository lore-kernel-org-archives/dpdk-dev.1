Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D130606A7A0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vScHV5Zp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C4A943254;
	Tue,  3 Nov 2026 16:23:32 +0100 (CET)
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
 by mails.dpdk.org (Postfix) with ESMTPS id 8A68C4325A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:23:30 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=a4hmrC0F0Uk8tI/P9Vdh65r67RA5dKhmCnPU2ZAv1co=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719410; v=1; x=1794324210;
 b=vScHV5ZpeGe5x1Kn5ye3tK0IaR2dpVAXTo1IYjsgSFXJ2+qANGOX+Ut4rT9A1SMW+IPo9J0N
 kErOpCSDVa90pblopCuNqarCD1Ws7Pyt0D+aWut0KdLBdn0LZOE0gEiqNTd86JBzwRRLa50LAsL
 1cnKjMRwKi/xqHIORyclBUDk=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id d10eb7254822fe85;
 Tue, 03 Nov 2026 15:23:30 +0000
X-Mizu-Trace-ID: d10eb7254822fe85
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 193/227] examples/ip_reassembly: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:31 +0800
Message-ID: <20261103145306.487255-194-chengwen.feng@linux.dev>
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
 examples/ip_reassembly/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 321a50b1f6..6df7a395c6 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -827,8 +827,8 @@ setup_port_tbl(struct lcore_queue_conf *qconf, uint32_t lcore, int socket,
 	n = RTE_MAX(max_flow_num, 2UL * MAX_PKT_BURST);
 	sz = sizeof (*mtb) + sizeof (mtb->m_table[0]) *  n;
 
-	if ((mtb = rte_zmalloc_socket(__func__, sz, RTE_CACHE_LINE_SIZE,
-			socket)) == NULL) {
+	mtb = rte_zmalloc_numa(__func__, sz, RTE_CACHE_LINE_SIZE, socket);
+	if (mtb == NULL) {
 		RTE_LOG(ERR, IP_RSMBL, "%s() for lcore: %u, port: %u "
 			"failed to allocate %zu bytes\n",
 			__func__, lcore, port, sz);
@@ -849,8 +849,8 @@ setup_queue_tbl(struct rx_queue *rxq, uint32_t lcore, uint32_t queue)
 	uint64_t frag_cycles;
 	char buf[RTE_MEMPOOL_NAMESIZE];
 
-	socket = rte_lcore_to_socket_id(lcore);
-	if (socket == SOCKET_ID_ANY)
+	socket = rte_lcore_to_numa_id(lcore);
+	if (socket == RTE_NUMA_ID_ANY)
 		socket = 0;
 
 	/* Each table entry holds information about packet fragmentation. 8< */
@@ -920,9 +920,9 @@ init_mem(void)
 		if (rte_lcore_is_enabled(lcore_id) == 0)
 			continue;
 
-		socket = rte_lcore_to_socket_id(lcore_id);
+		socket = rte_lcore_to_numa_id(lcore_id);
 
-		if (socket == SOCKET_ID_ANY)
+		if (socket == RTE_NUMA_ID_ANY)
 			socket = 0;
 
 		if (socket_lpm[socket] == NULL) {
@@ -1070,8 +1070,8 @@ main(int argc, char **argv)
 			qconf = &lcore_queue_conf[rx_lcore_id];
 		}
 
-		socket = rte_lcore_to_socket_id(portid);
-		if (socket == SOCKET_ID_ANY)
+		socket = rte_lcore_to_numa_id(portid);
+		if (socket == RTE_NUMA_ID_ANY)
 			socket = 0;
 
 		queueid = qconf->n_rx_queue;
@@ -1152,7 +1152,7 @@ main(int argc, char **argv)
 			if (rte_lcore_is_enabled(lcore_id) == 0)
 				continue;
 
-			socket = (int) rte_lcore_to_socket_id(lcore_id);
+			socket = (int) rte_lcore_to_numa_id(lcore_id);
 
 			printf("txq=%u,%d,%d ", lcore_id, queueid, socket);
 			fflush(stdout);
-- 
2.55.0


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87834606A79C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JL5fyCDr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47E1943249;
	Tue,  3 Nov 2026 16:23:23 +0100 (CET)
Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
 by mails.dpdk.org (Postfix) with ESMTPS id 51C3642EC7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:23:22 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=enEwZpRhMpFB7oGqV7VD1W6Zbt4CrXWhbo9/YvrQ1k4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719400; v=1; x=1794324200;
 b=JL5fyCDr/YWsF5g1UlM8tQhVJY2952yschQW9cI01GaVmd+MPSCdRElK4i0HdYRX2WDC4fUE
 2er4TLrMagRhaID7Gcp1VgedOSMKs+sdnpbW+f7FAIrqTkKOgmb2fZIKlOeUfSh6N3msObIy045
 UKkREu9pMv7vHOwRlVF+RZUA=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 2a6b159f838ae413;
 Tue, 03 Nov 2026 15:23:20 +0000
X-Mizu-Trace-ID: 2a6b159f838ae413
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 192/227] examples/ip_fragmentation: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:30 +0800
Message-ID: <20261103145306.487255-193-chengwen.feng@linux.dev>
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
 examples/ip_fragmentation/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 132550e497..d429f526e1 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -788,9 +788,9 @@ init_mem(void)
 		if (rte_lcore_is_enabled(lcore_id) == 0)
 			continue;
 
-		socket = rte_lcore_to_socket_id(lcore_id);
+		socket = rte_lcore_to_numa_id(lcore_id);
 
-		if (socket == SOCKET_ID_ANY)
+		if (socket == RTE_NUMA_ID_ANY)
 			socket = 0;
 
 		if (socket_direct_pool[socket] == NULL) {
@@ -928,8 +928,8 @@ main(int argc, char **argv)
 			qconf = &lcore_queue_conf[rx_lcore_id];
 		}
 
-		socket = (int) rte_lcore_to_socket_id(rx_lcore_id);
-		if (socket == SOCKET_ID_ANY)
+		socket = (int) rte_lcore_to_numa_id(rx_lcore_id);
+		if (socket == RTE_NUMA_ID_ANY)
 			socket = 0;
 
 		rxq = &qconf->rx_queue_list[qconf->n_rx_queue];
@@ -1011,7 +1011,7 @@ main(int argc, char **argv)
 			if (queueid >= dev_info.nb_tx_queues)
 				break;
 
-			socket = (int) rte_lcore_to_socket_id(lcore_id);
+			socket = (int) rte_lcore_to_numa_id(lcore_id);
 			printf("txq=%u,%d ", lcore_id, queueid);
 			fflush(stdout);
 
-- 
2.55.0


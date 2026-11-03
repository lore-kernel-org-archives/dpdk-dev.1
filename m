Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E767606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ibfk+M09
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7083043270;
	Tue,  3 Nov 2026 16:24:08 +0100 (CET)
Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
 by mails.dpdk.org (Postfix) with ESMTPS id 89E834325E
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:24:06 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=CLr6l36xtGcCVjzphYhUoQFvdpKe4ikmQQkmuQLoM00=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719446; v=1; x=1794324246;
 b=Ibfk+M09z5bHxrf9izADrzc8Zwcz9T89LKa3a/l5Q6ivHruB27inskg8jw997tgIqaoej4P4
 TSgSypt33ws3wCBOsJUOU4W/0pP0KrdOloUTjms15SNCd6grm7QdO4uGgb+13R9niPDvMt0x1NZ
 BnnHoRNFNoeq2X4m2jRCc4ts=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id f164fed2470e6939;
 Tue, 03 Nov 2026 15:24:06 +0000
X-Mizu-Trace-ID: f164fed2470e6939
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 197/227] examples/l2fwd-cat: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:35 +0800
Message-ID: <20261103145306.487255-198-chengwen.feng@linux.dev>
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
 examples/l2fwd-cat/l2fwd-cat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/l2fwd-cat/l2fwd-cat.c b/examples/l2fwd-cat/l2fwd-cat.c
index 6e16705e99..cf5772fac5 100644
--- a/examples/l2fwd-cat/l2fwd-cat.c
+++ b/examples/l2fwd-cat/l2fwd-cat.c
@@ -52,7 +52,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 RX queue per Ethernet port. */
 	for (q = 0; q < rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
-				rte_eth_dev_socket_id(port), NULL, mbuf_pool);
+				rte_eth_dev_numa_id(port), NULL, mbuf_pool);
 		if (retval < 0)
 			return retval;
 	}
@@ -60,7 +60,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 TX queue per Ethernet port. */
 	for (q = 0; q < tx_rings; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, nb_txd,
-				rte_eth_dev_socket_id(port), NULL);
+				rte_eth_dev_numa_id(port), NULL);
 		if (retval < 0)
 			return retval;
 	}
@@ -102,9 +102,9 @@ lcore_main(void)
 	 * for best performance.
 	 */
 	RTE_ETH_FOREACH_DEV(port)
-		if (rte_eth_dev_socket_id(port) >= 0 &&
-				rte_eth_dev_socket_id(port) !=
-						(int)rte_socket_id())
+		if (rte_eth_dev_numa_id(port) >= 0 &&
+				rte_eth_dev_numa_id(port) !=
+						(int)rte_numa_id())
 			printf("WARNING, port %u is on remote NUMA node to "
 					"polling thread.\n\tPerformance will "
 					"not be optimal.\n", port);
@@ -183,7 +183,7 @@ main(int argc, char *argv[])
 
 	/* Creates a new mempool in memory to hold the mbufs. */
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", NUM_MBUFS * nb_ports,
-		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
-- 
2.55.0


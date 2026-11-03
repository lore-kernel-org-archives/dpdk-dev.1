Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BE606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oAuWUvmj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D3E432BC;
	Tue,  3 Nov 2026 16:27:13 +0100 (CET)
Received: from mta0.migadu.com (out-157.mta0.migadu.com [91.218.175.157])
 by mails.dpdk.org (Postfix) with ESMTPS id E6F21432F6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:27:12 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=vGDM4okX5w8NMxRmqWx+AqeE3oaAYLQ5DMAdwKBay2E=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719632; v=1; x=1794324432;
 b=oAuWUvmj3Fce75vwPjRMYYID41LDTspm4BPEwPBQJCcOdTBk7+hvZypiThacxH/9NHvm3cPf
 9AR8vod0XINfuRrUigoK/sNUvLkR4n2uDAKg7Q0HPLT8QiA66nNeITJMm+gp2vCcIwAQ7Cgyi9g
 qVevW1LiCC0xEoyumrrx+/KA=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id d57361fb3f827665;
 Tue, 03 Nov 2026 15:27:12 +0000
X-Mizu-Trace-ID: d57361fb3f827665
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 217/227] examples/skeleton: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:55 +0800
Message-ID: <20261103145306.487255-218-chengwen.feng@linux.dev>
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
 examples/skeleton/basicfwd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
index e8c18d5b87..652d0f10c7 100644
--- a/examples/skeleton/basicfwd.c
+++ b/examples/skeleton/basicfwd.c
@@ -66,7 +66,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 RX queue per Ethernet port. */
 	for (q = 0; q < rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
-				rte_eth_dev_socket_id(port), NULL, mbuf_pool);
+				rte_eth_dev_numa_id(port), NULL, mbuf_pool);
 		if (retval < 0)
 			return retval;
 	}
@@ -76,7 +76,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	/* Allocate and set up 1 TX queue per Ethernet port. */
 	for (q = 0; q < tx_rings; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, nb_txd,
-				rte_eth_dev_socket_id(port), &txconf);
+				rte_eth_dev_numa_id(port), &txconf);
 		if (retval < 0)
 			return retval;
 	}
@@ -123,9 +123,9 @@ lcore_main(void)
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
@@ -194,7 +194,7 @@ main(int argc, char *argv[])
 
 	/* Create and allocate a mempool to hold the mbufs. 8< */
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", NUM_MBUFS * nb_ports,
-		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	/* >8 End of allocating mempool to hold mbuf. */
 
 	if (mbuf_pool == NULL)
-- 
2.55.0


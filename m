Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8F606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vmLvo9N6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB206432EA;
	Tue,  3 Nov 2026 16:26:56 +0100 (CET)
Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
 by mails.dpdk.org (Postfix) with ESMTPS id 7F667432EA
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:26:55 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=C0CI9HJY9YoNtlVjDNLiFn2j15M+YxDtgX4LBFz0FTU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719615; v=1; x=1794324415;
 b=vmLvo9N6U5THERxX5RoVsGMv44dVu6JPK2qMgx42U3IFcec1Wi9us2nXPdBapd2vS09SkniM
 S8KYZ5ACXGpcUpU8mgVrtxA5Jb4T/rLd7b/GBkZWfgQ9mTX6efCdBnpgJcnRN7/WZllAQf+mjfF
 3ElBKgs+xSlUoI2OSxORtFBk=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id ec903c9db2f2829e;
 Tue, 03 Nov 2026 15:26:55 +0000
X-Mizu-Trace-ID: ec903c9db2f2829e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 215/227] examples/rxtx_callbacks: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:53 +0800
Message-ID: <20261103145306.487255-216-chengwen.feng@linux.dev>
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
 examples/rxtx_callbacks/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/rxtx_callbacks/main.c b/examples/rxtx_callbacks/main.c
index 4682921285..02c5c69cd7 100644
--- a/examples/rxtx_callbacks/main.c
+++ b/examples/rxtx_callbacks/main.c
@@ -173,7 +173,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 
 	for (q = 0; q < rx_rings; q++) {
 		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
-			rte_eth_dev_socket_id(port), &rxconf, mbuf_pool);
+			rte_eth_dev_numa_id(port), &rxconf, mbuf_pool);
 		if (retval < 0)
 			return retval;
 	}
@@ -182,7 +182,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 	txconf.offloads = port_conf.txmode.offloads;
 	for (q = 0; q < tx_rings; q++) {
 		retval = rte_eth_tx_queue_setup(port, q, nb_txd,
-				rte_eth_dev_socket_id(port), &txconf);
+				rte_eth_dev_numa_id(port), &txconf);
 		if (retval < 0)
 			return retval;
 	}
@@ -250,9 +250,9 @@ lcore_main(void)
 	uint16_t port;
 
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
@@ -322,7 +322,7 @@ main(int argc, char *argv[])
 
 	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL",
 		NUM_MBUFS * nb_ports, MBUF_CACHE_SIZE, 0,
-		RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+		RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
 
-- 
2.55.0


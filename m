Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA927606A789
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Le4hh1Nx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A13F942FF9;
	Tue,  3 Nov 2026 16:22:41 +0100 (CET)
Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
 by mails.dpdk.org (Postfix) with ESMTPS id 3481642FF9
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:22:41 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=lDqrQBcCQjH+zn6F9XMGA2/dgSL4iI3OTKZtbOCkIwk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719360; v=1; x=1794324160;
 b=Le4hh1NxIAzYGUK/oGj4d7oMTT4WLLzZ2brQzUrXJu8JnOc6IFiXCtEM3noUDxGvhmahHzZr
 /DkoCyxk08gUsTVHqxoNLXQaVkGuZNVF7eeKCD38/KtVhD32RlF5bUsvFXSrM8JxR477Jpmem1a
 j6XKxqIMxtPNVZXbSZGM7T9I=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id a7ddbd6cd70e945f;
 Tue, 03 Nov 2026 15:22:40 +0000
X-Mizu-Trace-ID: a7ddbd6cd70e945f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 187/227] examples/dma: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:25 +0800
Message-ID: <20261103145306.487255-188-chengwen.feng@linux.dev>
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
 examples/dma/dmafwd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index fea1c3e669..12298a5779 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -832,7 +832,7 @@ assign_rings(void)
 		/* Create ring for inter core communication */
 		cfg.ports[i].rx_to_tx_ring = rte_ring_create(
 			ring_name, ring_size,
-			rte_socket_id(), RING_F_SP_ENQ | RING_F_SC_DEQ);
+			rte_numa_id(), RING_F_SP_ENQ | RING_F_SC_DEQ);
 
 		if (cfg.ports[i].rx_to_tx_ring == NULL)
 			rte_exit(EXIT_FAILURE, "Ring create failed: %s\n",
@@ -943,7 +943,7 @@ port_init(uint16_t portid, struct rte_mempool *mbuf_pool)
 	rxq_conf.offloads = local_port_conf.rxmode.offloads;
 	for (i = 0; i < nb_queues; i++) {
 		ret = rte_eth_rx_queue_setup(portid, i, nb_rxd,
-			rte_eth_dev_socket_id(portid), &rxq_conf,
+			rte_eth_dev_numa_id(portid), &rxq_conf,
 			mbuf_pool);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE,
@@ -955,7 +955,7 @@ port_init(uint16_t portid, struct rte_mempool *mbuf_pool)
 	txq_conf = dev_info.default_txconf;
 	txq_conf.offloads = local_port_conf.txmode.offloads;
 	ret = rte_eth_tx_queue_setup(portid, 0, nb_txd,
-			rte_eth_dev_socket_id(portid),
+			rte_eth_dev_numa_id(portid),
 			&txq_conf);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE,
@@ -1047,7 +1047,7 @@ main(int argc, char **argv)
 	sz = max_frame_size + RTE_PKTMBUF_HEADROOM;
 	sz = RTE_MAX(sz, (size_t)RTE_MBUF_DEFAULT_BUF_SIZE);
 	dma_pktmbuf_pool = rte_pktmbuf_pool_create("mbuf_pool", nb_mbufs,
-		MEMPOOL_CACHE_SIZE, 0, sz, rte_socket_id());
+		MEMPOOL_CACHE_SIZE, 0, sz, rte_numa_id());
 	if (dma_pktmbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot init mbuf pool\n");
 	/* >8 End of allocates mempool to hold the mbufs. */
-- 
2.55.0


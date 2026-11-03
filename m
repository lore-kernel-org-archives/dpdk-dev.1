Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F822606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B1+utP5s
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7375D43291;
	Tue,  3 Nov 2026 16:26:13 +0100 (CET)
Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
 by mails.dpdk.org (Postfix) with ESMTPS id A1FAE40B97
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:26:11 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=ize/j0OnsiAeGLVWMnN+9EqN37julAhU6ao2+vFlEIo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719569; v=1; x=1794324369;
 b=B1+utP5srGSohPmwok5pF/2ZhpUYmqwvVbZtCVdZwEmvLiQR2MW6N6e0/cPCq7YDS/T8Pn0T
 eJ8YQOBgmNOMZ7R8kPrvOvVQDnHRRgAeTURlR04oK811T9INKioYSg5aZeyL/YyCiNAskWfHyx9
 IzkA4xcCw3EsFJGE9aKXGyd8=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 107b9db315e909df;
 Tue, 03 Nov 2026 15:26:09 +0000
X-Mizu-Trace-ID: 107b9db315e909df
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 209/227] examples/packet_ordering: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:47 +0800
Message-ID: <20261103145306.487255-210-chengwen.feng@linux.dev>
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
 examples/packet_ordering/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/examples/packet_ordering/main.c b/examples/packet_ordering/main.c
index 0279faf081..b931ab86ae 100644
--- a/examples/packet_ordering/main.c
+++ b/examples/packet_ordering/main.c
@@ -254,9 +254,9 @@ configure_tx_buffers(struct rte_eth_dev_tx_buffer *tx_buffer[])
 			continue;
 
 		/* Initialize TX buffers */
-		tx_buffer[port_id] = rte_zmalloc_socket("tx_buffer",
+		tx_buffer[port_id] = rte_zmalloc_numa("tx_buffer",
 				RTE_ETH_TX_BUFFER_SIZE(MAX_PKTS_BURST), 0,
-				rte_eth_dev_socket_id(port_id));
+				rte_eth_dev_numa_id(port_id));
 		if (tx_buffer[port_id] == NULL)
 			rte_exit(EXIT_FAILURE, "Cannot allocate buffer for tx on port %u\n",
 				 port_id);
@@ -309,7 +309,7 @@ configure_eth_port(uint16_t port_id)
 
 	for (q = 0; q < rxRings; q++) {
 		ret = rte_eth_rx_queue_setup(port_id, q, nb_rxd,
-				rte_eth_dev_socket_id(port_id), NULL,
+				rte_eth_dev_numa_id(port_id), NULL,
 				mbuf_pool);
 		if (ret < 0)
 			return ret;
@@ -319,7 +319,7 @@ configure_eth_port(uint16_t port_id)
 	txconf.offloads = port_conf.txmode.offloads;
 	for (q = 0; q < txRings; q++) {
 		ret = rte_eth_tx_queue_setup(port_id, q, nb_txd,
-				rte_eth_dev_socket_id(port_id), &txconf);
+				rte_eth_dev_numa_id(port_id), &txconf);
 		if (ret < 0)
 			return ret;
 	}
@@ -719,7 +719,7 @@ main(int argc, char **argv)
 
 	mbuf_pool = rte_pktmbuf_pool_create("mbuf_pool", MBUF_PER_POOL,
 			MBUF_POOL_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 	if (mbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "%s\n", rte_strerror(rte_errno));
 
@@ -747,18 +747,18 @@ main(int argc, char **argv)
 	}
 
 	/* Create rings for inter core communication */
-	rx_to_workers = rte_ring_create("rx_to_workers", RING_SIZE, rte_socket_id(),
+	rx_to_workers = rte_ring_create("rx_to_workers", RING_SIZE, rte_numa_id(),
 			RING_F_SP_ENQ);
 	if (rx_to_workers == NULL)
 		rte_exit(EXIT_FAILURE, "%s\n", rte_strerror(rte_errno));
 
-	workers_to_tx = rte_ring_create("workers_to_tx", RING_SIZE, rte_socket_id(),
+	workers_to_tx = rte_ring_create("workers_to_tx", RING_SIZE, rte_numa_id(),
 			RING_F_SC_DEQ);
 	if (workers_to_tx == NULL)
 		rte_exit(EXIT_FAILURE, "%s\n", rte_strerror(rte_errno));
 
 	if (!disable_reorder) {
-		send_args.buffer = rte_reorder_create("PKT_RO", rte_socket_id(),
+		send_args.buffer = rte_reorder_create("PKT_RO", rte_numa_id(),
 				REORDER_BUFFER_SIZE);
 		if (send_args.buffer == NULL)
 			rte_exit(EXIT_FAILURE, "%s\n", rte_strerror(rte_errno));
-- 
2.55.0


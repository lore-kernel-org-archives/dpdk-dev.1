Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8478606A32E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OJHJtYIz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1624B43278;
	Tue,  3 Nov 2026 16:24:17 +0100 (CET)
Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
 by mails.dpdk.org (Postfix) with ESMTPS id B9C784325B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:24:15 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=CZGqdS9e8uNturqTIUMsNugcvec5MROTQNkJj3HRdD8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719455; v=1; x=1794324255;
 b=OJHJtYIzFjrQkl4FATQ0vLrdlPnMUS+9gqwijHMiSrW58CkCM4WfRakKuFN09Qia9PcLyB+l
 GrZAFf3rAGkS446Tn+Ew4H8/dWBQdaNbkPQdaXWK5wL9bLVlS96KyPM6pljBRDDIZf+Qe5KdUJc
 KAO5ZEUux5ZkozVR5sTzW1Vc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id a066a67e2b99cb62;
 Tue, 03 Nov 2026 15:24:15 +0000
X-Mizu-Trace-ID: a066a67e2b99cb62
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 199/227] examples/l2fwd-event: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:37 +0800
Message-ID: <20261103145306.487255-200-chengwen.feng@linux.dev>
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
 examples/l2fwd-event/l2fwd_common.c | 4 ++--
 examples/l2fwd-event/l2fwd_poll.c   | 4 ++--
 examples/l2fwd-event/main.c         | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/l2fwd-event/l2fwd_common.c b/examples/l2fwd-event/l2fwd_common.c
index caacf6cd63..9b636724b7 100644
--- a/examples/l2fwd-event/l2fwd_common.c
+++ b/examples/l2fwd-event/l2fwd_common.c
@@ -83,7 +83,7 @@ l2fwd_event_init_ports(struct l2fwd_resources *rsrc)
 		rxq_conf.offloads = local_port_conf.rxmode.offloads;
 		/* Using lcore to poll one or several ports. 8< */
 		ret = rte_eth_rx_queue_setup(port_id, 0, nb_rxd,
-					     rte_eth_dev_socket_id(port_id),
+					     rte_eth_dev_numa_id(port_id),
 					     &rxq_conf,
 					     rsrc->pktmbuf_pool);
 		if (ret < 0)
@@ -97,7 +97,7 @@ l2fwd_event_init_ports(struct l2fwd_resources *rsrc)
 		txq_conf = dev_info.default_txconf;
 		txq_conf.offloads = local_port_conf.txmode.offloads;
 		ret = rte_eth_tx_queue_setup(port_id, 0, nb_txd,
-				rte_eth_dev_socket_id(port_id),
+				rte_eth_dev_numa_id(port_id),
 				&txq_conf);
 		if (ret < 0)
 			rte_panic("rte_eth_tx_queue_setup:err=%d, port=%u\n",
diff --git a/examples/l2fwd-event/l2fwd_poll.c b/examples/l2fwd-event/l2fwd_poll.c
index 73fefac67b..432d80e311 100644
--- a/examples/l2fwd-event/l2fwd_poll.c
+++ b/examples/l2fwd-event/l2fwd_poll.c
@@ -147,9 +147,9 @@ l2fwd_poll_init_tx_buffers(struct l2fwd_resources *rsrc)
 
 	RTE_ETH_FOREACH_DEV(port_id) {
 		/* Initialize TX buffers */
-		poll_rsrc->tx_buffer[port_id] = rte_zmalloc_socket("tx_buffer",
+		poll_rsrc->tx_buffer[port_id] = rte_zmalloc_numa("tx_buffer",
 				RTE_ETH_TX_BUFFER_SIZE(MAX_PKT_BURST), 0,
-				rte_eth_dev_socket_id(port_id));
+				rte_eth_dev_numa_id(port_id));
 		if (poll_rsrc->tx_buffer[port_id] == NULL)
 			rte_panic("Cannot allocate buffer for tx on port %u\n",
 				  port_id);
diff --git a/examples/l2fwd-event/main.c b/examples/l2fwd-event/main.c
index 6ab59eb4ef..c011ec61db 100644
--- a/examples/l2fwd-event/main.c
+++ b/examples/l2fwd-event/main.c
@@ -664,7 +664,7 @@ main(int argc, char **argv)
 	/* Create the mbuf pool. 8< */
 	rsrc->pktmbuf_pool = rte_pktmbuf_pool_create("mbuf_pool",
 			nb_mbufs, MEMPOOL_CACHE_SIZE, 0,
-			RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (rsrc->pktmbuf_pool == NULL)
 		rte_panic("Cannot init mbuf pool\n");
 	/* >8 End of creation of mbuf pool. */
@@ -677,7 +677,7 @@ main(int argc, char **argv)
 		nb_vec = RTE_MAX(512U, nb_vec);
 		nb_vec += rte_lcore_count() * 32;
 		rsrc->evt_vec_pool = rte_event_vector_pool_create(
-			"vector_pool", nb_vec, 32, vec_size, rte_socket_id());
+			"vector_pool", nb_vec, 32, vec_size, rte_numa_id());
 		if (rsrc->evt_vec_pool == NULL)
 			rte_panic("Cannot init event vector pool\n");
 	}
-- 
2.55.0


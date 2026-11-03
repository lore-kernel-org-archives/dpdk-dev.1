Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA4606EE80
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HfLd38ev
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17B5842EF1;
	Tue,  3 Nov 2026 16:16:37 +0100 (CET)
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
 by mails.dpdk.org (Postfix) with ESMTPS id 6FB08427C7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:16:35 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=E3sclI37zVDYt+liKO10OM1TfT+tpKmM/nMoqoBMseU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718995; v=1; x=1794323795;
 b=HfLd38evQBUZyWap7ArKscoaQB4nd9AJZQm3sZh4Ljk+FuaYcGJ0inm0xEj9/GqpiIEhCllP
 tCMQ7UgXLrg+PfhTYrfwkXIDfs/rxlqNMvFPpS5RkjCPv7MMhchpKzJXqdEz/5c/IVAL1WD/cCh
 jPNn0yvy4F83Ox8DcNS7U5u4=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id c5bac223a27322a5;
 Tue, 03 Nov 2026 15:16:34 +0000
X-Mizu-Trace-ID: c5bac223a27322a5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 150/227] net/thunderx: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:48 +0800
Message-ID: <20261103145306.487255-151-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/thunderx/nicvf_ethdev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 2ed4390522..0671de6691 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -705,7 +705,7 @@ nicvf_qset_rbdr_alloc(struct rte_eth_dev *dev, struct nicvf *nic,
 	uint32_t ring_size;
 
 	assert(nic->rbdr == NULL);
-	rbdr = rte_zmalloc_socket("rbdr", sizeof(struct nicvf_rbdr),
+	rbdr = rte_zmalloc_numa("rbdr", sizeof(struct nicvf_rbdr),
 				  RTE_CACHE_LINE_SIZE, nic->node);
 	if (rbdr == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate mem for rbdr");
@@ -1012,7 +1012,7 @@ nicvf_set_rx_function(struct rte_eth_dev *dev)
 
 static int
 nicvf_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
-			 uint16_t nb_desc, unsigned int socket_id,
+			 uint16_t nb_desc, unsigned int numa_id,
 			 const struct rte_eth_txconf *tx_conf)
 {
 	uint16_t tx_free_thresh;
@@ -1029,9 +1029,9 @@ nicvf_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	qidx = qidx % MAX_SND_QUEUES_PER_QS;
 
 	/* Socket id check */
-	if (socket_id != (unsigned int)SOCKET_ID_ANY && socket_id != nic->node)
-		PMD_DRV_LOG(WARNING, "socket_id expected %d, configured %d",
-		socket_id, nic->node);
+	if (numa_id != (unsigned int)RTE_NUMA_ID_ANY && numa_id != nic->node)
+		PMD_DRV_LOG(WARNING, "numa_id expected %d, configured %d",
+		numa_id, nic->node);
 
 	/* Tx deferred start is not supported */
 	if (tx_conf->tx_deferred_start) {
@@ -1070,7 +1070,7 @@ nicvf_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	}
 
 	/* Allocating tx queue data structure */
-	txq = rte_zmalloc_socket("ethdev TX queue", sizeof(struct nicvf_txq),
+	txq = rte_zmalloc_numa("ethdev TX queue", sizeof(struct nicvf_txq),
 					RTE_CACHE_LINE_SIZE, nic->node);
 	if (txq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate txq=%d",
@@ -1102,7 +1102,7 @@ nicvf_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	dev->data->tx_queues[nicvf_netdev_qidx(nic, qidx)] = txq;
 
 	/* Allocate software ring */
-	txq->txbuffs = rte_zmalloc_socket("txq->txbuffs",
+	txq->txbuffs = rte_zmalloc_numa("txq->txbuffs",
 				nb_desc * sizeof(struct rte_mbuf *),
 				RTE_CACHE_LINE_SIZE, nic->node);
 
@@ -1343,7 +1343,7 @@ nicvf_rxq_mbuf_setup(struct nicvf_rxq *rxq)
 
 static int
 nicvf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
-			 uint16_t nb_desc, unsigned int socket_id,
+			 uint16_t nb_desc, unsigned int numa_id,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -1370,9 +1370,9 @@ nicvf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	qidx = qidx % MAX_RCV_QUEUES_PER_QS;
 
 	/* Socket id check */
-	if (socket_id != (unsigned int)SOCKET_ID_ANY && socket_id != nic->node)
-		PMD_DRV_LOG(WARNING, "socket_id expected %d, configured %d",
-		socket_id, nic->node);
+	if (numa_id != (unsigned int)RTE_NUMA_ID_ANY && numa_id != nic->node)
+		PMD_DRV_LOG(WARNING, "numa_id expected %d, configured %d",
+		numa_id, nic->node);
 
 	/* Mempool memory must be contiguous, so must be one memory segment*/
 	if (mp->nb_mem_chunks != 1) {
@@ -1420,7 +1420,7 @@ nicvf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qidx,
 	}
 
 	/* Allocate rxq memory */
-	rxq = rte_zmalloc_socket("ethdev rx queue", sizeof(struct nicvf_rxq),
+	rxq = rte_zmalloc_numa("ethdev rx queue", sizeof(struct nicvf_rxq),
 					RTE_CACHE_LINE_SIZE, nic->node);
 	if (rxq == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate rxq=%d",
-- 
2.55.0


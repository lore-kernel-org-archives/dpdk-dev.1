Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8B606D2D5
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OoL+BmKc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E94042E50;
	Tue,  3 Nov 2026 16:10:39 +0100 (CET)
Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
 by mails.dpdk.org (Postfix) with ESMTPS id B5CB342E37
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:10:37 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=kZTs6M9odrWZVHKGmHitmrPrRLBVCiDmm1lSQ8KkJks=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718637; v=1; x=1794323437;
 b=OoL+BmKcY5lX4vaZfH7Hw7olCwWpatVDU9eW8F4py8jquAKbhHyULKzqVHx8OiyBnITe+fkG
 peLkstsi39gjlzsQglPw9TTdVBJ9dH6Z4NVVI0ZbF1zeBI5MZaL6zt9hXQaFFaSPpUoeZkm220u
 hTL5q2V3X0A+Ua/bg0V40ITM=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 9b5b7ae29eee0856;
 Tue, 03 Nov 2026 15:10:37 +0000
X-Mizu-Trace-ID: 9b5b7ae29eee0856
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 106/227] net/avp: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:04 +0800
Message-ID: <20261103145306.487255-107-chengwen.feng@linux.dev>
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
 drivers/net/avp/avp_ethdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index d536f764cf..ed6eb1cce8 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -49,14 +49,14 @@ static int avp_dev_promiscuous_disable(struct rte_eth_dev *dev);
 static int avp_dev_rx_queue_setup(struct rte_eth_dev *dev,
 				  uint16_t rx_queue_id,
 				  uint16_t nb_rx_desc,
-				  unsigned int socket_id,
+				  unsigned int numa_id,
 				  const struct rte_eth_rxconf *rx_conf,
 				  struct rte_mempool *pool);
 
 static int avp_dev_tx_queue_setup(struct rte_eth_dev *dev,
 				  uint16_t tx_queue_id,
 				  uint16_t nb_tx_desc,
-				  unsigned int socket_id,
+				  unsigned int numa_id,
 				  const struct rte_eth_txconf *tx_conf);
 
 static uint16_t avp_recv_scattered_pkts(void *rx_queue,
@@ -1093,7 +1093,7 @@ static int
 avp_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		       uint16_t rx_queue_id,
 		       uint16_t nb_rx_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *pool)
 {
@@ -1131,8 +1131,8 @@ avp_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		    avp->guest_mbuf_size);
 
 	/* allocate a queue object */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct avp_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("ethdev RX queue", sizeof(struct avp_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to allocate new Rx queue object");
 		return -ENOMEM;
@@ -1157,7 +1157,7 @@ static int
 avp_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 		       uint16_t tx_queue_id,
 		       uint16_t nb_tx_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf)
 {
 	struct avp_dev *avp = AVP_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
@@ -1170,8 +1170,8 @@ avp_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 	}
 
 	/* allocate a queue object */
-	txq = rte_zmalloc_socket("ethdev TX queue", sizeof(struct avp_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("ethdev TX queue", sizeof(struct avp_queue),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to allocate new Tx queue object");
 		return -ENOMEM;
-- 
2.55.0


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD09606A798
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IGqQC7Qe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08CB2427DD;
	Tue,  3 Nov 2026 16:10:45 +0100 (CET)
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
 by mails.dpdk.org (Postfix) with ESMTPS id A08BB4279D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:10:43 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=MxIiKp4UZ/qd6bLpdMgaRWIj8sGK+FBoskpguWF20gU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718643; v=1; x=1794323443;
 b=IGqQC7Qe8vzk5xX4n4rhB8/pSEb6jDJo7R+Mr+7+JzmJtXWAtCe/boareegjS5twkZ7LiBJp
 6/6XMkMLefFvcOpa49ZFGgPj+EkB9A6QaO+heudGXLogCd6mo77rrW3yaQpfeP7IbE6YJah4rXn
 r5QI2sIBwc9mNR0EtPzSBmz4=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 30b9fc58effd49f3;
 Tue, 03 Nov 2026 15:10:43 +0000
X-Mizu-Trace-ID: 30b9fc58effd49f3
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 107/227] net/axgbe: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:05 +0800
Message-ID: <20261103145306.487255-108-chengwen.feng@linux.dev>
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
 drivers/net/axgbe/axgbe_rxtx.c | 16 ++++++++--------
 drivers/net/axgbe/axgbe_rxtx.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_rxtx.c b/drivers/net/axgbe/axgbe_rxtx.c
index 51a1aeb0b9..47c09399c1 100644
--- a/drivers/net/axgbe/axgbe_rxtx.c
+++ b/drivers/net/axgbe/axgbe_rxtx.c
@@ -36,7 +36,7 @@ void axgbe_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx)
 }
 
 int axgbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			     uint16_t nb_desc, unsigned int socket_id,
+			     uint16_t nb_desc, unsigned int numa_id,
 			     const struct rte_eth_rxconf *rx_conf,
 			     struct rte_mempool *mp)
 {
@@ -55,9 +55,9 @@ int axgbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	    rx_desc > pdata->rx_desc_count)
 		return -EINVAL;
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue",
+	rxq = rte_zmalloc_numa("ethdev RX queue",
 				 sizeof(struct axgbe_rx_queue),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq) {
 		PMD_INIT_LOG(ERR, "rte_zmalloc for rxq failed!");
 		return -ENOMEM;
@@ -90,7 +90,7 @@ int axgbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	/* Allocate RX ring hardware descriptors */
 	size = rxq->nb_desc * sizeof(union axgbe_rx_desc);
 	dma = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size, 128,
-				       socket_id);
+				       numa_id);
 	if (!dma) {
 		PMD_DRV_LOG_LINE(ERR, "ring_dma_zone_reserve for rx_ring failed");
 		axgbe_rx_queue_release(rxq);
@@ -101,9 +101,9 @@ int axgbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	memset((void *)rxq->desc, 0, size);
 	/* Allocate software ring */
 	size = rxq->nb_desc * sizeof(struct rte_mbuf *);
-	rxq->sw_ring = rte_zmalloc_socket("sw_ring", size,
+	rxq->sw_ring = rte_zmalloc_numa("sw_ring", size,
 					  RTE_CACHE_LINE_SIZE,
-					  socket_id);
+					  numa_id);
 	if (!rxq->sw_ring) {
 		PMD_DRV_LOG_LINE(ERR, "rte_zmalloc for sw_ring failed");
 		axgbe_rx_queue_release(rxq);
@@ -544,7 +544,7 @@ void axgbe_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx)
 }
 
 int axgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			     uint16_t nb_desc, unsigned int socket_id,
+			     uint16_t nb_desc, unsigned int numa_id,
 			     const struct rte_eth_txconf *tx_conf)
 {
 	PMD_INIT_FUNC_TRACE();
@@ -593,7 +593,7 @@ int axgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	/* Allocate TX ring hardware descriptors */
 	tsize = txq->nb_desc * sizeof(struct axgbe_tx_desc);
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx,
-				      tsize, AXGBE_DESC_ALIGN, socket_id);
+				      tsize, AXGBE_DESC_ALIGN, numa_id);
 	if (!tz) {
 		axgbe_tx_queue_release(txq);
 		return -ENOMEM;
diff --git a/drivers/net/axgbe/axgbe_rxtx.h b/drivers/net/axgbe/axgbe_rxtx.h
index f5f74a0a39..ca6b4935d4 100644
--- a/drivers/net/axgbe/axgbe_rxtx.h
+++ b/drivers/net/axgbe/axgbe_rxtx.h
@@ -157,7 +157,7 @@ void axgbe_set_rx_function(struct rte_eth_dev *dev);
 
 void axgbe_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
 int  axgbe_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-			      uint16_t nb_tx_desc, unsigned int socket_id,
+			      uint16_t nb_tx_desc, unsigned int numa_id,
 			      const struct rte_eth_txconf *tx_conf);
 void axgbe_dev_enable_tx(struct rte_eth_dev *dev);
 void axgbe_dev_disable_tx(struct rte_eth_dev *dev);
@@ -179,7 +179,7 @@ uint16_t axgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 void axgbe_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
 int  axgbe_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-			      uint16_t nb_rx_desc, unsigned int socket_id,
+			      uint16_t nb_rx_desc, unsigned int numa_id,
 			      const struct rte_eth_rxconf *rx_conf,
 			      struct rte_mempool *mb_pool);
 void axgbe_dev_enable_rx(struct rte_eth_dev *dev);
-- 
2.55.0


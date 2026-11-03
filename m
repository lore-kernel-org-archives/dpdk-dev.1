Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1A606A334
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NIHXypDl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C467442EFF;
	Tue,  3 Nov 2026 16:17:11 +0100 (CET)
Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
 by mails.dpdk.org (Postfix) with ESMTPS id 6857F42EFF
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:10 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=il0xqVSDUazGiUBxEjeCOW9OUAGc1J5aOl5zZvD9y8o=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719030; v=1; x=1794323830;
 b=NIHXypDl7g6nC4fYM31257nPfiW2epwdb4wNN9bbR2rzwGcilemXFzWy/d6Wi/dDV6rc9M2L
 NmHzeCVc8DN9Z3WCX2KWDve3+8dALiXWuhkvlymgKg0yfLkhdFJeXAX/Fez+dhzSu8mq57VhRv/
 sU08ANohFqdD7ayr7WBQurkI=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 4054a0e438c41009;
 Tue, 03 Nov 2026 15:17:10 +0000
X-Mizu-Trace-ID: 4054a0e438c41009
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 154/227] net/vmxnet3: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:52 +0800
Message-ID: <20261103145306.487255-155-chengwen.feng@linux.dev>
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
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 14 +++++++-------
 drivers/net/vmxnet3/vmxnet3_ethdev.h |  4 ++--
 drivers/net/vmxnet3/vmxnet3_rxtx.c   |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index 4a7c76cfef..5f18e26c4c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -179,7 +179,7 @@ static const struct vmxnet3_xstats_name_off vmxnet3_rxq_stat_strings[] = {
 
 static const struct rte_memzone *
 gpa_zone_reserve(struct rte_eth_dev *dev, uint32_t size,
-		 const char *post_string, int socket_id,
+		 const char *post_string, int numa_id,
 		 uint16_t align, bool reuse)
 {
 	char z_name[RTE_MEMZONE_NAMESIZE];
@@ -191,14 +191,14 @@ gpa_zone_reserve(struct rte_eth_dev *dev, uint32_t size,
 	mz = rte_memzone_lookup(z_name);
 	if (!reuse) {
 		rte_memzone_free(mz);
-		return rte_memzone_reserve_aligned(z_name, size, socket_id,
+		return rte_memzone_reserve_aligned(z_name, size, numa_id,
 				RTE_MEMZONE_IOVA_CONTIG, align);
 	}
 
 	if (mz)
 		return mz;
 
-	return rte_memzone_reserve_aligned(z_name, size, socket_id,
+	return rte_memzone_reserve_aligned(z_name, size, numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, align);
 }
 
@@ -653,7 +653,7 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 	 * on current socket
 	 */
 	mz = gpa_zone_reserve(dev, sizeof(struct Vmxnet3_DriverShared),
-			      "shared", rte_socket_id(), 8, 1);
+			      "shared", rte_numa_id(), 8, 1);
 
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "ERROR: Creating shared zone");
@@ -672,7 +672,7 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 	 * depends on the number of tx and rx queues, which could be different
 	 * from one config to another.
 	 */
-	mz = gpa_zone_reserve(dev, size, "queuedesc", rte_socket_id(),
+	mz = gpa_zone_reserve(dev, size, "queuedesc", rte_numa_id(),
 			      VMXNET3_QUEUE_DESC_ALIGN, 0);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "ERROR: Creating queue descriptors zone");
@@ -689,7 +689,7 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 	if (dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
 		/* Allocate memory structure for UPT1_RSSConf and configure */
 		mz = gpa_zone_reserve(dev, sizeof(struct VMXNET3_RSSConf),
-				      "rss_conf", rte_socket_id(),
+				      "rss_conf", rte_numa_id(),
 				      RTE_CACHE_LINE_SIZE, 1);
 		if (mz == NULL) {
 			PMD_INIT_LOG(ERR,
@@ -820,7 +820,7 @@ vmxnet3_dev_setup_memreg(struct rte_eth_dev *dev)
 			(2 * VMXNET3_MAX_MEMREG_QUEUES) *
 			sizeof(Vmxnet3_MemoryRegion);
 
-		mz = gpa_zone_reserve(dev, size, "memRegs", rte_socket_id(), 8,
+		mz = gpa_zone_reserve(dev, size, "memRegs", rte_numa_id(), 8,
 				      1);
 		if (mz == NULL) {
 			PMD_INIT_LOG(ERR, "ERROR: Creating memRegs zone");
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.h b/drivers/net/vmxnet3/vmxnet3_ethdev.h
index 75dafa664f..a7830bba40 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.h
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.h
@@ -208,14 +208,14 @@ void vmxnet3_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 int vmxnet3_v4_rss_configure(struct rte_eth_dev *dev);
 
 int  vmxnet3_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-				uint16_t nb_rx_desc, unsigned int socket_id,
+				uint16_t nb_rx_desc, unsigned int numa_id,
 				const struct rte_eth_rxconf *rx_conf,
 				struct rte_mempool *mb_pool);
 
 int vmxnet3_dev_rx_queue_count(void *rx_queue);
 
 int  vmxnet3_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-				uint16_t nb_tx_desc, unsigned int socket_id,
+				uint16_t nb_tx_desc, unsigned int numa_id,
 				const struct rte_eth_txconf *tx_conf);
 
 int vmxnet3_dev_rxtx_init(struct rte_eth_dev *dev);
diff --git a/drivers/net/vmxnet3/vmxnet3_rxtx.c b/drivers/net/vmxnet3/vmxnet3_rxtx.c
index aaebfc8675..b9b3de90f9 100644
--- a/drivers/net/vmxnet3/vmxnet3_rxtx.c
+++ b/drivers/net/vmxnet3/vmxnet3_rxtx.c
@@ -1031,7 +1031,7 @@ int
 vmxnet3_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-			   unsigned int socket_id,
+			   unsigned int numa_id,
 			   const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct vmxnet3_hw *hw = dev->data->dev_private;
@@ -1092,7 +1092,7 @@ vmxnet3_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	size += txq->txdata_desc_size * data_ring->size;
 
 	mz = rte_eth_dma_zone_reserve(dev, "txdesc", queue_idx, size,
-				      VMXNET3_RING_BA_ALIGN, socket_id);
+				      VMXNET3_RING_BA_ALIGN, numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "ERROR: Creating queue descriptors zone");
 		return -ENOMEM;
@@ -1132,7 +1132,7 @@ int
 vmxnet3_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-			   unsigned int socket_id,
+			   unsigned int numa_id,
 			   __rte_unused const struct rte_eth_rxconf *rx_conf,
 			   struct rte_mempool *mp)
 {
@@ -1208,7 +1208,7 @@ vmxnet3_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		size += rxq->data_desc_size * data_ring->size;
 
 	mz = rte_eth_dma_zone_reserve(dev, "rxdesc", queue_idx, size,
-				      VMXNET3_RING_BA_ALIGN, socket_id);
+				      VMXNET3_RING_BA_ALIGN, numa_id);
 	if (mz == NULL) {
 		PMD_INIT_LOG(ERR, "ERROR: Creating queue descriptors zone");
 		return -ENOMEM;
-- 
2.55.0


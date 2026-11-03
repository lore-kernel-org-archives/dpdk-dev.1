Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28F606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SlDxU9Pt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E6FF427D7;
	Tue,  3 Nov 2026 16:10:25 +0100 (CET)
Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 96E9F427DD
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:10:24 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=r3xpSjrakaurWLLesqiF7HXVZ1ZDzPq8ikWEUDeCuT4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718624; v=1; x=1794323424;
 b=SlDxU9PtoOcADXY4DCPHy+1ww/h5lSe1QQoDEFGJrZdcA4DnSMBRRYgoNZUvPtaWw87A1AUM
 eOazwxyiaHjGeyk5ArNDC12f14b1+k+Jssx2K5n6bmjluHCKL0fk0sLUaIzjlhvTwQ6ISuLwxtP
 0UNbCv6pevX7fsgVOn8LJgn4=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 461042429aa2378d;
 Tue, 03 Nov 2026 15:10:15 +0000
X-Mizu-Trace-ID: 461042429aa2378d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 104/227] net/ark: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:02 +0800
Message-ID: <20261103145306.487255-105-chengwen.feng@linux.dev>
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
 drivers/net/ark/ark_ethdev.c    |  4 ++--
 drivers/net/ark/ark_ethdev_rx.c | 14 +++++++-------
 drivers/net/ark/ark_ethdev_rx.h |  2 +-
 drivers/net/ark/ark_ethdev_tx.c | 14 +++++++-------
 drivers/net/ark/ark_ethdev_tx.h |  2 +-
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index d6b1abf383..1df54b27b4 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -441,10 +441,10 @@ ark_dev_init(struct rte_eth_dev *dev)
 		eth_dev->device = &pci_dev->device;
 		/* Device requires new dev_private data */
 		eth_dev->data->dev_private =
-			rte_zmalloc_socket(name,
+			rte_zmalloc_numa(name,
 					   sizeof(struct ark_adapter),
 					   RTE_CACHE_LINE_SIZE,
-					   rte_socket_id());
+					   rte_numa_id());
 		if (eth_dev->data->dev_private == NULL) {
 			ARK_PMD_LOG(ERR, "Memory allocation for dev_private failed\n");
 			goto error;
diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index adba943fa2..4af6f5e40a 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -114,7 +114,7 @@ int
 ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-			   unsigned int socket_id,
+			   unsigned int numa_id,
 			   const struct rte_eth_rxconf *rx_conf,
 			   struct rte_mempool *mb_pool)
 {
@@ -154,10 +154,10 @@ ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate queue struct */
-	queue = rte_zmalloc_socket("Ark_rxqueue",
+	queue = rte_zmalloc_numa("Ark_rxqueue",
 				   sizeof(struct ark_rx_queue),
 				   64,
-				   socket_id);
+				   numa_id);
 	if (queue == 0) {
 		ARK_PMD_LOG(ERR, "Failed to allocate memory in %s\n", __func__);
 		return -ENOMEM;
@@ -183,16 +183,16 @@ ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	queue->ext_user_data = ark->user_data[dev->data->port_id];
 
 	queue->reserve_q =
-		rte_zmalloc_socket("Ark_rx_queue mbuf",
+		rte_zmalloc_numa("Ark_rx_queue mbuf",
 				   nb_desc * sizeof(struct rte_mbuf *),
 				   512,
-				   socket_id);
+				   numa_id);
 	/* Align buffer to PCIe's boundary size to reduce upstream read request TLPs from FPGA */
 	queue->paddress_q =
-		rte_zmalloc_socket("Ark_rx_queue paddr",
+		rte_zmalloc_numa("Ark_rx_queue paddr",
 				   nb_desc * sizeof(rte_iova_t),
 				   ARK_PCIE_BOUNDARY,
-				   socket_id);
+				   numa_id);
 
 	if (queue->reserve_q == 0 || queue->paddress_q == 0) {
 		ARK_PMD_LOG(ERR,
diff --git a/drivers/net/ark/ark_ethdev_rx.h b/drivers/net/ark/ark_ethdev_rx.h
index 184733640b..0e5d0d5158 100644
--- a/drivers/net/ark/ark_ethdev_rx.h
+++ b/drivers/net/ark/ark_ethdev_rx.h
@@ -14,7 +14,7 @@
 int ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			       uint16_t queue_idx,
 			       uint16_t nb_desc,
-			       unsigned int socket_id,
+			       unsigned int numa_id,
 			       const struct rte_eth_rxconf *rx_conf,
 			       struct rte_mempool *mp);
 int ark_dev_rx_queue_count(void *rx_queue);
diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethdev_tx.c
index 0d6a94b919..5b0375ee56 100644
--- a/drivers/net/ark/ark_ethdev_tx.c
+++ b/drivers/net/ark/ark_ethdev_tx.c
@@ -227,7 +227,7 @@ int
 ark_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t queue_idx,
 		       uint16_t nb_desc,
-		       unsigned int socket_id,
+		       unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
@@ -248,10 +248,10 @@ ark_tx_queue_setup(struct rte_eth_dev *dev,
 	nb_desc = 2 * nb_desc;
 
 	/* Allocate queue struct */
-	queue =	rte_zmalloc_socket("Ark_txqueue",
+	queue =	rte_zmalloc_numa("Ark_txqueue",
 				   sizeof(struct ark_tx_queue),
 				   64,
-				   socket_id);
+				   numa_id);
 	if (queue == 0) {
 		ARK_PMD_LOG(ERR, "Failed to allocate tx "
 			    "queue memory in %s\n",
@@ -269,15 +269,15 @@ ark_tx_queue_setup(struct rte_eth_dev *dev,
 	queue->ext_user_data = ark->user_data[dev->data->port_id];
 
 	queue->meta_q =
-		rte_zmalloc_socket("Ark_txqueue meta",
+		rte_zmalloc_numa("Ark_txqueue meta",
 				   nb_desc * sizeof(union ark_tx_meta),
 				   64,
-				   socket_id);
+				   numa_id);
 	queue->bufs =
-		rte_zmalloc_socket("Ark_txqueue bufs",
+		rte_zmalloc_numa("Ark_txqueue bufs",
 				   nb_desc * sizeof(struct rte_mbuf *),
 				   64,
-				   socket_id);
+				   numa_id);
 
 	if (queue->meta_q == 0 || queue->bufs == 0) {
 		ARK_PMD_LOG(ERR, "Failed to allocate "
diff --git a/drivers/net/ark/ark_ethdev_tx.h b/drivers/net/ark/ark_ethdev_tx.h
index 2653408de6..099257012b 100644
--- a/drivers/net/ark/ark_ethdev_tx.h
+++ b/drivers/net/ark/ark_ethdev_tx.h
@@ -16,7 +16,7 @@ uint16_t ark_xmit_pkts(void *vtxq,
 int ark_tx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-			   unsigned int socket_id,
+			   unsigned int numa_id,
 			   const struct rte_eth_txconf *tx_conf);
 void ark_tx_queue_release(void *vtx_queue);
 int ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
-- 
2.55.0

